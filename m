Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B8B28E40A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbgJNQJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730757AbgJNQJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:09:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D99C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:09:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n18so4548409wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=H9rybAoRMfJuvrtAl3lNXQUNZlOJBLJM9ZuOt8XzchE=;
        b=mDnLgOrZhoKGfjuH5K/gCuqV2ir35LH3EhpmxsxKtKykKkjeOJXlBiz1+4thPLgWLt
         9U+vXym6NWNQKWqwd9e4uAvI5Kp/MMXfs3O9I/7QmYzI43IrhsFs09MVi0+9S0s+/sHk
         0KWv5Wb5kf3pmkcf8m0lwURHAANGjBofJaUbBO7vKp4IMt9c4Wx+wMyepDmqQ1Wfo5r5
         2AKowtHlwi3sIuDTGT6fY+dWXI7hdD9JSRWSkcNaMWbOonHcO42hqyLTtWqEFGlZrnzG
         DrnmrE1cM1nDLh5355ApGjFLbNV3T0kGhP7VQNm7CyNFN2FNB4Eot/KsgnX7Yp/ynhb4
         0cPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=H9rybAoRMfJuvrtAl3lNXQUNZlOJBLJM9ZuOt8XzchE=;
        b=WRLavDQsPJcxE+daWY0396QfAM0OBNF/L+D7qm3lM/gXh0RmUaap+1MIvLTpeljG+U
         bO1iQwTzcrYoOLK1DWR7xnjzAC1xlEEzUVngyn50bx8uJ4qc6xLoIjzB2PEDSG8ul88I
         wJYO+7N2WHro6jhvZlbAA3+P0a0Bw3JI4FCqwff0OCDK8XwvuFUk5E6sikcr6pz65DlA
         lFzlYaFFJF66vDd+NuH7JNdgsj5Cg4OFVljCOSfIjCwNPbIVjlfqPGPsL5QKacrQ+G+T
         cGxJqZw2soH2oPvZlZ0UlT/ytkAsqdnT+Sfp6MeP92W8NAcuCKWyn4W+azHCC7wEZrYG
         osow==
X-Gm-Message-State: AOAM5306WsIoVD4u1/j6kzr98lEoD2/zFH3WEJODh1POIV5ZvnC49tIB
        IXHAYd1eUSkbVox7i4eta89dCQ==
X-Google-Smtp-Source: ABdhPJz85Lpn23/7UfasyANSqb93KtLbn6PHVGnz2puAAugCcdmSnmxTrBfa9CcHpgfLjHGC+gSBAQ==
X-Received: by 2002:a5d:5743:: with SMTP id q3mr6287939wrw.167.1602691751994;
        Wed, 14 Oct 2020 09:09:11 -0700 (PDT)
Received: from dell ([91.110.221.166])
        by smtp.gmail.com with ESMTPSA id o186sm156741wmb.12.2020.10.14.09.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 09:09:08 -0700 (PDT)
Date:   Wed, 14 Oct 2020 17:09:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v5.10
Message-ID: <20201014160907.GA4545@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening Linus,

A small trivial fix-up with IRQChip's Kconfig will be required.

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.10

for you to fetch changes up to 6d81dc3c79d46b66b29712eb1ac5ad2cbe4231d2:

  mfd: kempld-core: Fix unused variable 'kempld_acpi_table' when !ACPI (2020-10-05 09:11:40 +0100)

----------------------------------------------------------------
 - New Drivers
   - Add support for initialising shared (between children) Regmaps
   - Add support for Kontron SL28CPLD
   - Add support for ENE KB3930 Embedded Controller
   - Add support for Intel FPGA PAC MAX 10 BMC

 - New Device Support
   - Add support for Power to Ricoh RN5T618
   - Add support for UART to Intel Lakefield
   - Add support for LP87524_Q1 to Texas Instruments LP87565

 - New Functionality
   - Device Tree; ene-kb3930, sl28cpld, syscon, lp87565, lp87524-q1
   - Use new helper dev_err_probe(); madera-core, stmfx, wcd934x
   - Use new GPIOD API; dm355evm_msp
   - Add wake-up capability; sprd-sc27xx-spi
   - Add ACPI support; kempld-core

 - Fix-ups
   - Trivial (spelling/whitespace); Kconfig, ab8500
   - Fix for unused variables; khadas-mcu, kempld-core
   - Remove unused header file(s); mt6360-core
   - Use correct IRQ flags in docs; act8945a, gateworks-gsc, rohm,bd70528-pmic
   - Add COMPILE_TEST support; asic3, tmio_core
   - Add dependency on I2C; SL28CPLD

 - Bug Fixes
   - Fix memory leak(s); sm501
   - Do not free regmap_config's 'name' until exit; syscon

----------------------------------------------------------------
Andreas Kemnade (1):
      mfd: rn5t618: Add a power supply subdevice

Andy Shevchenko (1):
      mfd: intel-lpss: Add device IDs for UART ports for Lakefield

Baolin Wang (1):
      mfd: sprd: Add wakeup capability for PMIC IRQ

Dan Carpenter (1):
      mfd: sm501: Fix leaks in probe()

Jonathan Neuschäfer (1):
      dt-bindings: mfd: ab8500: Remove weird Unicode characters

Krzysztof Kozlowski (6):
      mfd: madera: Simplify with dev_err_probe()
      mfd: stmfx: Simplify with dev_err_probe()
      mfd: wcd934x: Simplify with dev_err_probe()
      dt-bindings: mfd: syscon: Merge Samsung Exynos Sysreg bindings
      dt-bindings: mfd: syscon: Document Exynos3 and Exynos5433 compatibles
      dt-bindings: mfd: Correct interrupt flags in examples

Lee Jones (3):
      mfd: khadas-mcu: Fix randconfig 'unused-const-variable' warning
      mfd: sl28cpld: Depend on I2C
      mfd: kempld-core: Fix unused variable 'kempld_acpi_table' when !ACPI

Linus Walleij (1):
      mfd: dm355evm_msp: Convert LEDs to GPIO descriptor table

Lubomir Rintel (2):
      dt-bindings: mfd: Add ENE KB3930 Embedded Controller binding
      mfd: ene-kb3930: Add driver for ENE KB3930 Embedded Controller

Luca Ceresoli (3):
      dt-bindings: mfd: lp87565: Convert to yaml
      dt-bindings: mfd: Add LP87524-Q1
      mfd: lp87565: Add LP87524-Q1 variant

Marc Zyngier (1):
      mfd: syscon: Don't free allocated name for regmap_config

Marek Behún (1):
      mfd: asic3: Build if COMPILE_TEST=y

Mauro Carvalho Chehab (1):
      mfd: Kconfig: Fix typo of 'individual'

Michael Brunner (1):
      mfd: Add ACPI support to Kontron PLD driver

Michael Walle (8):
      mfd: Add simple regmap based I2C driver
      dt-bindings: mfd: Add bindings for sl28cpld
      mfd: simple-mfd-i2c: Add sl28cpld support
      irqchip: Add sl28cpld interrupt controller support
      watchdog: add support for sl28cpld watchdog
      pwm: Add support for sl28cpld PWM controller
      gpio: Add support for the sl28cpld GPIO controller
      hwmon: Add support for the sl28cpld hardware monitoring controller

Xu Yilun (1):
      mfd: intel-m10-bmc: Add Intel MAX 10 BMC chip support for Intel FPGA PAC

YueHaibing (1):
      mfd: mt6360: Remove unused include <linux/version.h>

 .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 ++
 .../devicetree/bindings/arm/samsung/sysreg.yaml    |  45 ----
 .../bindings/gpio/kontron,sl28cpld-gpio.yaml       |  54 +++++
 .../bindings/hwmon/kontron,sl28cpld-hwmon.yaml     |  27 +++
 .../kontron,sl28cpld-intc.yaml                     |  54 +++++
 Documentation/devicetree/bindings/mfd/ab8500.txt   |   4 +-
 Documentation/devicetree/bindings/mfd/act8945a.txt |   2 +-
 .../devicetree/bindings/mfd/ene-kb3930.yaml        |  55 +++++
 .../devicetree/bindings/mfd/gateworks-gsc.yaml     |   3 +-
 .../devicetree/bindings/mfd/kontron,sl28cpld.yaml  | 153 ++++++++++++
 Documentation/devicetree/bindings/mfd/lp87565.txt  |  79 ------
 .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  |   2 +-
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   4 +
 .../devicetree/bindings/mfd/ti,lp87524-q1.yaml     | 112 +++++++++
 .../devicetree/bindings/mfd/ti,lp87561-q1.yaml     |  83 +++++++
 .../devicetree/bindings/mfd/ti,lp87565-q1.yaml     | 101 ++++++++
 .../bindings/pwm/kontron,sl28cpld-pwm.yaml         |  35 +++
 .../bindings/watchdog/kontron,sl28cpld-wdt.yaml    |  35 +++
 Documentation/hwmon/index.rst                      |   1 +
 Documentation/hwmon/sl28cpld.rst                   |  36 +++
 drivers/gpio/Kconfig                               |  12 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-sl28cpld.c                       | 161 ++++++++++++
 drivers/hwmon/Kconfig                              |  10 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/sl28cpld-hwmon.c                     | 142 +++++++++++
 drivers/irqchip/Kconfig                            |   8 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-sl28cpld.c                     |  96 ++++++++
 drivers/mfd/Kconfig                                |  52 +++-
 drivers/mfd/Makefile                               |   3 +
 drivers/mfd/dm355evm_msp.c                         |  76 ++++--
 drivers/mfd/ene-kb3930.c                           | 212 ++++++++++++++++
 drivers/mfd/intel-lpss-pci.c                       |   4 +
 drivers/mfd/intel-m10-bmc.c                        | 164 +++++++++++++
 drivers/mfd/kempld-core.c                          | 117 ++++++++-
 drivers/mfd/khadas-mcu.c                           |   2 +
 drivers/mfd/lp87565.c                              |   4 +
 drivers/mfd/madera-core.c                          |  11 +-
 drivers/mfd/mt6360-core.c                          |   1 -
 drivers/mfd/rn5t618.c                              |   1 +
 drivers/mfd/simple-mfd-i2c.c                       |  57 +++++
 drivers/mfd/sm501.c                                |   8 +-
 drivers/mfd/sprd-sc27xx-spi.c                      |  28 ++-
 drivers/mfd/stmfx.c                                |   8 +-
 drivers/mfd/syscon.c                               |   2 +-
 drivers/mfd/wcd934x.c                              |   9 +-
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sl28cpld.c                         | 270 +++++++++++++++++++++
 drivers/watchdog/Kconfig                           |  11 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/sl28cpld_wdt.c                    | 229 +++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h                  |  65 +++++
 include/linux/mfd/lp87565.h                        |   1 +
 55 files changed, 2493 insertions(+), 186 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
 delete mode 100644 Documentation/devicetree/bindings/arm/samsung/sysreg.yaml
 create mode 100644 Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb3930.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/lp87565.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
 create mode 100644 Documentation/hwmon/sl28cpld.rst
 create mode 100644 drivers/gpio/gpio-sl28cpld.c
 create mode 100644 drivers/hwmon/sl28cpld-hwmon.c
 create mode 100644 drivers/irqchip/irq-sl28cpld.c
 create mode 100644 drivers/mfd/ene-kb3930.c
 create mode 100644 drivers/mfd/intel-m10-bmc.c
 create mode 100644 drivers/mfd/simple-mfd-i2c.c
 create mode 100644 drivers/pwm/pwm-sl28cpld.c
 create mode 100644 drivers/watchdog/sl28cpld_wdt.c
 create mode 100644 include/linux/mfd/intel-m10-bmc.h

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
