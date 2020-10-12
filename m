Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D84D28B589
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388649AbgJLNJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388634AbgJLNJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:09:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CE282076C;
        Mon, 12 Oct 2020 13:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602508164;
        bh=1w5qExof3jtV1uYgS2v5GAiIHQE62KG5XfkV3TuCgTE=;
        h=From:To:Cc:Subject:Date:From;
        b=hwhAfEq21VIdGf0HiJaS8Ba36OfOXl4HEznS/1ByBDUQU3rBu7cqGvgsiM7gYiDao
         +Av/iCHQZV3q3efiyIpH0ZDVYAkOz0WLOejXAYKZ4AqOVcWf282i3ebbAdzO6niTeh
         +WECiwVC5uHU2mhvTVH913TSqjbJNpnw0pcwqcVE=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v5.10
Date:   Mon, 12 Oct 2020 14:09:08 +0100
Message-Id: <20201012130923.6CE282076C@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 549738f15da0e5a00275977623be199fbbf7df50:

  Linux 5.9-rc8 (2020-10-04 16:04:34 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.10

for you to fetch changes up to c6e70a6fd5ceff381059e600156d78c1b94b7c60:

  Merge remote-tracking branch 'regulator/for-5.10' into regulator-next (2020-10-05 16:54:56 +0100)

----------------------------------------------------------------
regulator: Updates for v5.10

This is a fairly small release for the regulator API, there's quite a
few new devices supported and some important improvements around coupled
regulators in the core but mostly just small fixes and improvements
otherwise.

 - Fixes and cleanups around the handling of coupled regulators.
 - A special driver for some Raspberry Pi panels with some unusually
   custom stuff around them.
 - Support for Qualcomm PM660/PM660L, PM8950 and PM8953, Richtek RT4801
   and RTMV20, Rohm BD9576MUF and BD9573MUF.

----------------------------------------------------------------
AngeloGioacchino Del Regno (6):
      regulator: core: Enlarge max OF property name length to 64 chars
      regulator: qcom_spmi: Add support for new regulator types
      regulator: qcom_spmi: Add PM660/PM660L regulators
      regulator: dt-bindings: Document the PM660/660L SPMI PMIC entries
      regulator: qcom_smd: Add PM660/PM660L regulator support
      regulator: dt-bindings: Document the PM660/PM660L PMICs entries

Anson Huang (1):
      regulator: Convert pfuze100 to json-schema

Axel Lin (3):
      regulator: lp8755: Get rid of lp8755_read/lp8755_write/lp8755_update_bits
      regulator: qcom_spmi: Improve readability for setting up enable/mode pin control
      regulator: rt4801: Select REGMAP_I2C to fix build error

Charles Keepax (1):
      regulator: lochnagar: Add additional VDDCORE range

ChiYuan Huang (8):
      regulator: rt4801: Add support for RT4801 Display Bias regulator driver
      regulator: rt4801: Add DT binding documentation
      regulator: rt4801: Fix the dt-binding document for dtc check.
      regulator: rt4801: Fix W=1 build warning when CONFIG_OF=n
      regulator: rtmv20: Adds support for Richtek RTMV20 load switch regulator
      regulator: rtmv20: Add DT-binding document for Richtek RTMV20
      regulator: rtmv20: Update DT binding document and property name parsing
      regulator: rtmv20: Add missing regcache cache only before marked as dirty

Colin Ian King (1):
      regulator: fix indentation issue

Fabio Estevam (1):
      regulator: dbx500: Remove unused debugfs goto label

Geert Uytterhoeven (1):
      regulator: Make constraint debug processing conditional on DEBUG

Gene Chen (2):
      regulator: mt6360: Add support for MT6360 regulator
      dt-bindings: regulator: mt6360: Add DT binding documentation

Greg Kroah-Hartman (1):
      regulator: dbx500: no need to check return value of debugfs_create functions

Hsin-Yi Wang (1):
      regulator: da9211: add cache_type

Jisheng Zhang (22):
      regulator: mp886x: implement set_ramp_delay
      regulator: mp886x: support setting switch freq
      regulator: mp886x: support mps,switch-frequency
      regulator: sy8827n: Fix W=1 build warning when CONFIG_OF=n
      regulator: Convert sy8824x to json-schema
      regulator: 88pg86x: Fix W=1 build warning when CONFIG_OF=n
      regulator: da9210: Fix W=1 build warning when CONFIG_OF=n
      regulator: fan53555: Fix W=1 build warning when CONFIG_OF=n
      regulator: fixed: Fix W=1 build warnings when CONFIG_OF=n
      regulator: ltc3589: Fix W=1 build warning when CONFIG_OF=n
      regulator: ltc3676: Fix W=1 build warning when CONFIG_OF=n
      regulator: max1586: Fix W=1 build warning when CONFIG_OF=n
      regulator: max77826: Fix W=1 build warning when CONFIG_OF=n
      regulator: pwm: Fix W=1 build warning when CONFIG_OF=n
      regulator: stm32-pwr: Fix W=1 build warning when CONFIG_OF=n
      regulator: stm32-vrefbuf: Fix W=1 build warning when CONFIG_OF=n
      regulator: sy8106a: Fix W=1 build warning when CONFIG_OF=n
      regulator: qcom-rpmh: Fix W=1 build warning when CONFIG_OF=n
      regulator: stm32-booster: Fix W=1 build warning when CONFIG_OF=n
      regulator: tps65023: Fix W=1 build warning when CONFIG_OF=n
      regulator: mp886x: use "mps,switch-frequency-hz"
      dt-bindings: regulator: Convert mp886x to json-schema

Jonathan Marek (1):
      regulator: set of_node for qcom vbus regulator

Krzysztof Kozlowski (2):
      regulator: enable compile testing for Maxim and Samsung PMIC drivers
      regulator: s5m8767: initialize driver via module_platform_driver

Marek Vasut (2):
      regulator: rpi-panel: Add regulator/backlight driver for RPi panel
      regulator: Add DT bindings for RaspberryPi 7" display ATTINY88-based regulator/backlight controller

Mark Brown (11):
      Merge existing fixes from regulator/for-5.9
      Merge series "regulator: fix deadlock vs memory reclaim" from Michał Mirosław <mirq-linux@rere.qmqm.pl>:
      Merge series "regulator: mp886x: two features and dt json convert" from Jisheng Zhang <jszhang3@mail.ustc.edu.cn> Jisheng Zhang <Jisheng.Zhang@synaptics.com>:
      Merge series "regulator: Fix W=1 build warning when CONFIG_OF=n" from Jisheng Zhang <Jisheng.Zhang@synaptics.com>:
      Merge tag 'v5.9-rc2' into regulator-5.10
      regulator: rt4801: Specify additionalProperties: false
      Merge series "regulator: unexport regulator_lock/unlock()" from Michał Mirosław <mirq-linux@rere.qmqm.pl>:
      Merge series "Support ROHM BD9576MUF and BD9573MUF PMICs" from Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>:
      Merge series "regulator: debugging aids" from Michał Mirosław <mirq-linux@rere.qmqm.pl>:
      Merge series "Support for PM660/PM660L SPMI and SMD regulators" from kholk11@gmail.com AngeloGioacchino Del Regno <kholk11@gmail.com>:
      Merge remote-tracking branch 'regulator/for-5.10' into regulator-next

Matti Vaittinen (8):
      regulator: bd718x7 initialize regulator config only once
      regulator: bd718x7 fix regulator states at SUSPEND
      regulator: bd71837: add property for omitting ON/OFF control
      regulator: bd71847: add property for omitting ON/OFF control
      dt_bindings: regulator: Add ROHM BD9576MUF and BD9573MUF PMICs
      regulator: Support ROHM BD9576MUF and BD9573MUF
      regulator: bd9576: fix regulator binfdings dt node names
      regulator: bd9576: Fix print

Michał Mirosław (8):
      regulator: Remove pointer table overallocation
      regulator: don't require mutex for regulator_notifier_call_chain()
      regulator: remove locking around regulator_notifier_call_chain()
      regulator: unexport regulator_lock/unlock()
      regulator: print state at boot
      regulator: print symbolic errors in kernel messages
      regulator: resolve supply after creating regulator
      regulator: tps65910: use regmap accessors

Piyush Goyal (1):
      regulator: mt6360: fix spelling mistake: "regulaotr" -> "regulator"

Rikard Falkeborn (14):
      regulator: tps51632: Constify tps51632_dcdc_ops
      regulator: tps6105x: Constify tps6105x_regulator_ops
      regulator: tps62360: Constify tps62360_dcdc_ops
      regulator: tps65086: Constify static regulator_ops
      regulator: tps65090: constify static regulator_ops
      regulator: tps6586x: Constify static regulator_ops
      regulator: tps65912: Constify static regulator_ops
      regulator: tps65910: Constify static regulator_ops
      regulator: dummy: Constify dummy_initdata and dummy_ops
      regulator: fixed: Constify static regulator_ops
      regulator: stw481x-vmmc: Constify static structs
      regulator: pca9450: Constify static regulator_ops
      regulator: ti-abb: Constify ti_abb_reg_ops
      regulator: qcom: labibb: Constify static structs

Stephen Boyd (1):
      regulator: Avoid grabbing regulator lock during suspend/resume

Vladimir Lypak (2):
      regulator: qcom_smd: add pm8953 regulators
      dt-bindings: regulator: document pm8950 and pm8953 smd regulators

YueHaibing (1):
      regulator: bd718x7: Make some variable static

 .../devicetree/bindings/regulator/mp886x.txt       |  27 --
 .../devicetree/bindings/regulator/mps,mp886x.yaml  |  61 +++
 .../bindings/regulator/mt6360-regulator.yaml       | 113 +++++
 .../devicetree/bindings/regulator/pfuze100.txt     | 394 ------------------
 .../devicetree/bindings/regulator/pfuze100.yaml    | 186 +++++++++
 .../bindings/regulator/qcom,smd-rpm-regulator.yaml |  12 +
 .../bindings/regulator/qcom,spmi-regulator.txt     |  31 ++
 ...pberrypi,7inch-touchscreen-panel-regulator.yaml |  44 ++
 .../regulator/richtek,rt4801-regulator.yaml        |  79 ++++
 .../regulator/richtek,rtmv20-regulator.yaml        | 159 +++++++
 .../bindings/regulator/rohm,bd71837-regulator.yaml |  11 +
 .../bindings/regulator/rohm,bd71847-regulator.yaml |  11 +
 .../bindings/regulator/rohm,bd9576-regulator.yaml  |  34 ++
 .../bindings/regulator/silergy,sy8824x.yaml        |  45 ++
 .../devicetree/bindings/regulator/sy8824x.txt      |  24 --
 drivers/regulator/88pg86x.c                        |   2 +-
 drivers/regulator/Kconfig                          |  64 ++-
 drivers/regulator/Makefile                         |   5 +
 drivers/regulator/bd718x7-regulator.c              | 422 ++++++++++++-------
 drivers/regulator/bd9576-regulator.c               | 337 +++++++++++++++
 drivers/regulator/core.c                           | 239 ++++++-----
 drivers/regulator/da9055-regulator.c               |   2 -
 drivers/regulator/da9062-regulator.c               |   2 -
 drivers/regulator/da9063-regulator.c               |   2 -
 drivers/regulator/da9210-regulator.c               |   6 +-
 drivers/regulator/da9211-regulator.c               |  18 +-
 drivers/regulator/dbx500-prcmu.c                   |  26 +-
 drivers/regulator/dummy.c                          |   4 +-
 drivers/regulator/fan53555.c                       |   2 +-
 drivers/regulator/fixed.c                          |  20 +-
 drivers/regulator/lochnagar-regulator.c            |   1 +
 drivers/regulator/lp8755.c                         |  88 +---
 drivers/regulator/ltc3589.c                        |  12 +-
 drivers/regulator/ltc3676.c                        |  12 +-
 drivers/regulator/max1586.c                        |   2 +-
 drivers/regulator/max77826-regulator.c             |   2 +-
 drivers/regulator/mp886x.c                         | 109 ++++-
 drivers/regulator/mt6360-regulator.c               | 459 +++++++++++++++++++++
 drivers/regulator/pca9450-regulator.c              |   6 +-
 drivers/regulator/pv88060-regulator.c              |  10 +-
 drivers/regulator/pv88080-regulator.c              |  10 +-
 drivers/regulator/pv88090-regulator.c              |  10 +-
 drivers/regulator/pwm-regulator.c                  |   2 +-
 drivers/regulator/qcom-labibb-regulator.c          |   8 +-
 drivers/regulator/qcom-rpmh-regulator.c            |   2 +-
 drivers/regulator/qcom_smd-regulator.c             | 167 ++++++++
 drivers/regulator/qcom_spmi-regulator.c            | 177 ++++++--
 drivers/regulator/qcom_usb_vbus-regulator.c        |   1 +
 drivers/regulator/rpi-panel-attiny-regulator.c     | 214 ++++++++++
 drivers/regulator/rt4801-regulator.c               | 223 ++++++++++
 drivers/regulator/rtmv20-regulator.c               | 397 ++++++++++++++++++
 drivers/regulator/s5m8767.c                        |  13 +-
 drivers/regulator/slg51000-regulator.c             |   4 -
 drivers/regulator/stm32-booster.c                  |   2 +-
 drivers/regulator/stm32-pwr.c                      |   2 +-
 drivers/regulator/stm32-vrefbuf.c                  |   2 +-
 drivers/regulator/stpmic1_regulator.c              |   4 -
 drivers/regulator/stw481x-vmmc.c                   |   4 +-
 drivers/regulator/sy8106a-regulator.c              |   2 +-
 drivers/regulator/sy8827n.c                        |   2 +
 drivers/regulator/ti-abb-regulator.c               |   2 +-
 drivers/regulator/tps51632-regulator.c             |   2 +-
 drivers/regulator/tps6105x-regulator.c             |   2 +-
 drivers/regulator/tps62360-regulator.c             |   2 +-
 drivers/regulator/tps65023-regulator.c             |   2 +-
 drivers/regulator/tps65086-regulator.c             |   4 +-
 drivers/regulator/tps65090-regulator.c             |   8 +-
 drivers/regulator/tps6586x-regulator.c             |   8 +-
 drivers/regulator/tps65910-regulator.c             | 135 +++---
 drivers/regulator/tps65912-regulator.c             |   4 +-
 drivers/regulator/wm831x-dcdc.c                    |   4 -
 drivers/regulator/wm831x-isink.c                   |   2 -
 drivers/regulator/wm831x-ldo.c                     |   2 -
 drivers/regulator/wm8350-regulator.c               |   2 -
 .../regulator/mediatek,mt6360-regulator.h          |  16 +
 include/linux/regulator/driver.h                   |   3 -
 include/linux/soc/qcom/smd-rpm.h                   |   4 +
 77 files changed, 3498 insertions(+), 1033 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/mp886x.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mp886x.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/pfuze100.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/pfuze100.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/raspberrypi,7inch-touchscreen-panel-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd9576-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/silergy,sy8824x.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/sy8824x.txt
 create mode 100644 drivers/regulator/bd9576-regulator.c
 create mode 100644 drivers/regulator/mt6360-regulator.c
 create mode 100644 drivers/regulator/rpi-panel-attiny-regulator.c
 create mode 100644 drivers/regulator/rt4801-regulator.c
 create mode 100644 drivers/regulator/rtmv20-regulator.c
 create mode 100644 include/dt-bindings/regulator/mediatek,mt6360-regulator.h
