function ViewFinder(controller) {
    this.controller = controller;
    this.panel = null;
    this.canvasContainer = null;
    this.screenSelect = null;
    this.shutterSelect = null;
    this.quickSelect = null;
    this.driveSelect = null;
    this.init();
}

ViewFinder.prototype.init = function () {
    var self = this;
    var hostname = this.controller.hostname;

    var keyInputEnabled = false;
    if (app.hostname == hostname) {
        this.controller.settings.setKeyInputEnabled(true);
        keyInputEnabled = true;
    } else {
        keyInputEnabled = this.controller.settings.getKeyInputEnabled();
    }

    this.panel = new Panel(keyInputEnabled ? 'panel-primary' : 'panel-info',
                           [4,5,6,7,8,9,10,11,12],
                           this.controller.settings.getColSize,
                           this.controller.settings.setColSize);

    this.panel.addFooter();
    var footerRow = $('<div></div>').addClass('row');
    this.panel.footer.append(footerRow);

    $('#panelsArea').append(this.panel.target);

    function setKeyInputEnabledCheck(checked) {
        if (checked) {
            self.keyInputEnabledCheck
                .html('<span class="glyphicon glyphicon-ok"></span>');
        } else {
            self.keyInputEnabledCheck
                .html('<span class="glyphicon glyphicon-ban-circle"></span>');
        }
    }
    this.keyInputEnabledCheck = $('<button type="button"></button>')
        .addClass('btn btn-default btn-xs pull-right')
        .click(function () {
            if (self.controller.isKeyInputEnabled()) {
                self.panel.target.removeClass('panel-primary');
                self.panel.target.addClass('panel-info');
                self.controller.settings.setKeyInputEnabled(false);
                setKeyInputEnabledCheck(false);
            } else {
                self.panel.target.removeClass('panel-info');
                self.panel.target.addClass('panel-primary');
                self.controller.settings.setKeyInputEnabled(true);
                setKeyInputEnabledCheck(true);
            }
            app.controlPanel.updateTitle();
            app.controlPanel.setVisibility();
        });
    setKeyInputEnabledCheck(keyInputEnabled);

    this.panel.heading.append(this.keyInputEnabledCheck);

    this.canvasContainer = $('<div></div>')
                            .addClass('viewfinder col-xs-12');
    this.panel.body.append($('<div></div>')
                            .addClass('row')
                            .append(this.canvasContainer));

    var liveViewValue = this.controller.settings.getLiveView();
    var osdValue = this.controller.settings.getOsd();

    this.screenSelect = $('<select></select>')
        .addClass('selectpicker show-tick')
        .attr('multiple', 'multiple')
        .attr('data-style', 'btn-default btn-xs')
        .attr('data-width', '100%')
        .append($('<optgroup></optgroup>')
                .attr('label', '实时取景')
                .attr('data-max-options', '1')
                .append($('<option title="视频:开启(HQ)"' +
                          (liveViewValue == 'hq' ? ' selected' : "") +
                          '>开启 (高清)</option>'))
                .append($('<option title="视频:开启(LQ)"' +
                          (liveViewValue == 'lq' ? ' selected' : "") +
                          '>开启 (一般)</option>'))
                .append($('<option title="视频:关闭"' +
                          (liveViewValue == 'hide' ? ' selected' : "") +
                          '>关闭</option>')))
        .append($('<optgroup></optgroup>')
                .attr('label', '图标')
                .attr('data-max-options', '1')
                .append($('<option title="图标:开启"' +
                          (osdValue == 'show' ? ' selected' : "") +
                          '>开启</option>'))
                .append($('<option title="图标:关闭"' +
                          (osdValue == 'hide' ? ' selected' : "") +
                          '>关闭</option>')))
        .append($('<optgroup></optgroup>')
                .attr('label', '屏幕')
                .attr('data-max-options', '1')
                .append($('<option title="屏幕:开启" selected>开启</option>'))
                .append($('<option title="屏幕:关闭">关闭</option>'))
                .append($('<option title="屏幕:视频">仅显示图像</option>')))
        .on('changed.bs.select',
            function (event, clickedIndex, newValue, oldValue) {
                if (newValue == false) {
                    // force selected
                    self.screenSelect[0][clickedIndex].selected = true;
                    self.screenSelect.selectpicker('refresh');
                }
                if (clickedIndex == 0) {
                    self.controller.liveView.start(false);
                } else if (clickedIndex == 1) {
                    self.controller.liveView.start(true);
                } else if (clickedIndex == 2) {
                    self.controller.liveView.stop();
                    self.controller.liveView.setHide();
                } else if (clickedIndex == 3) {
                    self.controller.osd.start();
                } else if (clickedIndex == 4) {
                    self.controller.osd.stop();
                    self.controller.osd.setHide();
                } else if (clickedIndex == 5) {
                    self.controller.controlLcd('on');
                } else if (clickedIndex == 6) {
                    self.controller.controlLcd('off');
                } else if (clickedIndex == 7) {
                    self.controller.controlLcd('video');
                }
            }
        );
    footerRow.append($('<div class="col-xs-6"></div>')
                    .append(this.screenSelect));
    this.screenSelect.selectpicker('refresh');

    this.driveSelect = $('<select></select>')
        .addClass('selectpicker show-tick')
        .attr('title', '拍摄模式')
        .attr('data-style', 'btn-default btn-xs')
        .attr('data-width', '100%')
        .append($('<option>单张</option>'))
        .append($('<option>一般连拍</option>'))
        .append($('<option>高速连拍</option>'))
        .append($('<option>定时器</option>'))
        .append($('<option>包围曝光</option>'))
        .on('changed.bs.select',
            function (event, clickedIndex, newValue, oldValue) {
                if (clickedIndex == 1) {
                    app.keyInput.onKey('DRIVE_SINGLE');
                } else if (clickedIndex == 2) {
                    app.keyInput.onKey('DRIVE_CONTI_N');
                } else if (clickedIndex == 3) {
                    app.keyInput.onKey('DRIVE_CONTI_H');
                } else if (clickedIndex == 4) {
                    app.keyInput.onKey('DRIVE_TIMER');
                } else if (clickedIndex == 5) {
                    app.keyInput.onKey('DRIVE_BRACKET');
                }
                if (newValue == true) {
                    // force deselect
                    self.driveSelect[0][clickedIndex].selected = false;
                    self.driveSelect.selectpicker('refresh');
                }
            }
        );
    footerRow.append($('<div class="col-xs-2 nx1-nx500-only"></div>')
                     .append(this.driveSelect));
    this.driveSelect.selectpicker('refresh');

    this.shutterSelect = $('<select></select>')
        .addClass('selectpicker')
        .attr('title', '快门')
        .attr('data-style', 'btn-default btn-xs')
        .attr('data-width', '100%')
        .append($('<option>静音</option>'))
        .append($('<option>正常</option>'))
        .on('changed.bs.select',
            function (event, clickedIndex, newValue, oldValue) {
                if (clickedIndex == 1) {
                    self.controller.shutterSetSilent(true);
                } else if (clickedIndex == 2) {
                    self.controller.shutterSetSilent(false);
                }
                if (newValue == true) {
                    // force deselect
                    self.shutterSelect[0][clickedIndex].selected = false;
                    self.shutterSelect.selectpicker('refresh');
                }
            }
        );
    footerRow.append($('<div class="col-xs-2 nx500-only"></div>')
                     .append(this.shutterSelect));
    this.shutterSelect.selectpicker('refresh');

    this.quickSelect = $('<select></select>')
        .addClass('selectpicker')
        .attr('title', '快速')
        .attr('data-style', 'btn-default btn-xs')
        .attr('data-width', '100%')
        .append($('<option>自动对焦模式</option>'))
        .append($('<option>ISO</option>'))
        .append($('<option>白平衡</option>'))
        .append($('<option>测光</option>'))
        .on('changed.bs.select',
            function (event, clickedIndex, newValue, oldValue) {
                if (clickedIndex == 1) {
                    app.keyInput.onKey('AF_MODE');
                } else if (clickedIndex == 2) {
                    app.keyInput.onKey('ISO');
                } else if (clickedIndex == 3) {
                    app.keyInput.onKey('WB');
                } else if (clickedIndex == 4) {
                    app.keyInput.onKey('METER');
                }
                if (newValue == true) {
                    // force deselect
                    self.quickSelect[0][clickedIndex].selected = false;
                    self.quickSelect.selectpicker('refresh');
                }
            }
        );
    footerRow.append($('<div class="col-xs-2 nx1-only"></div>')
                     .append(this.quickSelect));
    this.quickSelect.selectpicker('refresh');

    this.nameInput = $('<input type="text" placeholder="名称">')
        .addClass('form-control name-input')
        .val(this.controller.settings.getName())
        .change(function () {
            self.controller.settings.setName(this.value);
            app.controlPanel.updateTitle();
        });
    if (this.controller.isNx300()) {
        footerRow.append($('<div class="col-xs-6"></div>')
                         .append(this.nameInput));
    } else {
        footerRow.append($('<div class="col-xs-2"></div>')
                         .append(this.nameInput));
    }

    this.panel.body.on('hide.bs.collapse', function () {
        self.controller.stopScreen();
    });
    this.panel.body.on('show.bs.collapse', function () {
        self.controller.restartScreen();
    });
}

ViewFinder.prototype.addOsdCanvas = function (canvas) {
    this.canvasContainer.append(canvas);
}

ViewFinder.prototype.addLiveViewCanvas = function (canvas) {
    this.canvasContainer.append(canvas);
}

ViewFinder.prototype.destroy = function () {
    this.screenSelect.selectpicker('destroy');
    this.shutterSelect.selectpicker('destroy');
    this.quickSelect.selectpicker('destroy');
    this.driveSelect.selectpicker('destroy');
    this.panel.target.remove();
}
