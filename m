Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6EE2DBC32
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 08:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgLPHqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 02:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgLPHqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 02:46:19 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B2AC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 23:45:39 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v14so1410041wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 23:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=Vl6SMV7emqU/EE/0touwHfiWkIdzdDy0p7Dx+1Q3PRk=;
        b=MLx2h8mc4xFUMRdUmzeOxOg/IxG4p0muwc/i/nkaVPqDJ7QD4EVUS7MRsSaWlxIioa
         x0HqnB5hW4GV4JbrhYJD5w1I3l8TV6JrVx/PWuYeKHDJpxrujEZv5GkVF6iZhXFCROH5
         Eq/nVON/qLBftQtFwPJkjbTXGkJKq2zt5fvLOccTPOhFqheRBewceOngBaqovcULcXfd
         272xKRSTujFcWVXJ6AZ6Ktq4o39RUHlPiinrLwi3Qx12jLC6ib5xNGiRzR5TKQEHD8u5
         dSrb/D4qRvPZSl/7cteh2VMNz/GIOmWMdR7oLw0mLpQDsSWQstBPlBTS4arw5meoMjTo
         GUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=Vl6SMV7emqU/EE/0touwHfiWkIdzdDy0p7Dx+1Q3PRk=;
        b=BDkcX60Cgfnj/OY9D25hnycYKVOo22RRT3fy0nAw5gez4CSE8yv2f6oacARzCcfkHy
         VJ21lpjmhPa0/656+vs2amurhhV/yXkrtORuEJlEpzDXZdJ0DToNgA2J2Wdf3essFiqS
         PqBNqrIQ77xylZs0d3Gtj0oqks6NAcilH18pTgL7YqOn5m55lsOdl4Ei7ciSVI4IPzKp
         aB2I+IqYsnaRc/dBhb0q8LTn0PRwifm6haGr8/wSo+PwuHKLbRWkc2YRoJllA04WJJ3j
         3APuZOFiyiqmZTkV3uRs/l3/LI+mtlbiLLZAGZ7pO6xt6JGDPpQkEdZwNTg2DXd79rQA
         7BoQ==
X-Gm-Message-State: AOAM531ryKNvieVJtlaC+s/RRvNxNnw2BK1XKFKnhFO/8MqFLbU2KZyn
        3htNJyxYmeDhlw/cfk58Kbbjpmlk510GQyTU
X-Google-Smtp-Source: ABdhPJykdgB9y5mdYcYaDO6NKkVItwT2stFUmPLGh7GFVwX6u27NbMAcWtPGM69gAh1NyyqYIkzcbw==
X-Received: by 2002:a1c:2203:: with SMTP id i3mr1938699wmi.6.1608104736863;
        Tue, 15 Dec 2020 23:45:36 -0800 (PST)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id 64sm1530157wmd.12.2020.12.15.23.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 23:45:36 -0800 (PST)
Date:   Wed, 16 Dec 2020 07:45:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v5.11
Message-ID: <20201216074534.GC4776@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.11

for you to fetch changes up to 0cd3aa995740eabf8af1c794ac1d9ae314c928c3:

  mfd: kempld-core: Add support for additional devices (2020-12-02 12:53:27 +0000)

----------------------------------------------------------------
 - New Drivers
   - Add support for Intel's Platform Monitoring Technology (PMT)

 - New Device Support
   - Add support for PM660/PM660L to QCom SPMI PMIC
   - Add support for lots of new devices to Kontron Core

 - New Functionality
   - Provide syscon_regmap_lookup_by_phandle_optional() to SysCon API

 - Fix-ups
   - Constify; da9xxx-core; intel_*, tps65xxx, wm8xxx-core, lp8788,
               stmpe, sun4i-gpadc, 88pm800, hi655x-pmic, ioc3, etc
   - Remove superfluous code; madera, tps65910
   - Use raw APIs (rid abstractions); tps65911-comparator, tps65910
   - Whitespace/formatting fix-ups; tps65910
   - Device Tree changes/updates; bd71837-pmic, syscon
   - Use helpers/APIs (no hand rolling); altera-sysmgr
   - Mark of_match tables as __maybe_unused; twl6030-irq
   - Fix spelling; si476x-core

 - Bug Fixes
   - Reset on resume to ensure known state; madera-core
   - Correct ordering issues; madera-core, tps65910, kempld-core
   - Remove erroneous passing of of_compatible strings; at91-usart
   - Fix potential I2C adaptor leak; htc-i2cpld
   - Correct errorneous defines; rt5033-private
   - Resolve Kconfig issues; MFD_SL28CPLD, MFD_OMAP_USB_HOST
   - Fix dev_err_probe() handling; stmfx
   - Repair interrupt regression; motorola-cpcap
   - Allow ACPI matching of DT tables; bcm590xx, da9xx, ene-kb3930,
                                       fsl-imx25-tsadc, max77650,
				       mt6397-core, rt5033, stmfx,
				       max77686, sun4i-gpadc,
				       wm8994-core, axp20x-i2c

----------------------------------------------------------------
Alexander Duyck (3):
      platform/x86: Intel PMT class driver
      platform/x86: Intel PMT Telemetry capability driver
      platform/x86: Intel PMT Crashlog capability driver

Amelie Delaunay (1):
      mfd: stmfx: Fix dev_err_probe() call in stmfx_chip_init()

AngeloGioacchino Del Regno (1):
      mfd: qcom-spmi-pmic: Add support for PM660/PM660L

Charles Keepax (2):
      mfd: madera: Add reset as part of resume
      mfd: madera: Add special errata reset handling for cs47l15

Codrin Ciubotariu (1):
      mfd: at91-usart: Do not use compatible to register child devices

David E. Box (2):
      PCI: Add defines for Designated Vendor-Specific Extended Capability
      mfd: Intel Platform Monitoring Technology support

Dmitry Osipenko (1):
      mfd: tps65910: Correct power-off programming sequence

Enric Balletbo i Serra (1):
      mfd: syscon: Add syscon_regmap_lookup_by_phandle_optional() function.

Geert Uytterhoeven (1):
      mfd: MFD_SL28CPLD should depend on ARCH_LAYERSCAPE

Jing Xiangfeng (1):
      mfd: htc-i2cpld: Add the missed i2c_put_adapter() in htcpld_register_chip_i2c()

Johan Jonker (1):
      dt-binding: mfd: syscon: add Rockchip QoS register compatibles

Krzysztof Kozlowski (18):
      dt-bindings: mfd: rohm,bd71837-pmic: Add common properties
      mfd: omap-usb: Depend on COMMON_CLK to fix compile tests
      mfd: bcm590xx: Drop of_match_ptr from of_device_id table
      mfd: da9055: Drop of_match_ptr from of_device_id table
      mfd: da9062: Drop of_match_ptr from of_device_id table
      mfd: da9063: Drop of_match_ptr from of_device_id table
      mfd: da9150: Drop of_match_ptr from of_device_id table
      mfd: ene-kb3930: Drop of_match_ptr from of_device_id table
      mfd: fsl-imx25: Drop of_match_ptr from of_device_id table
      mfd: max77650: Drop of_match_ptr from of_device_id table
      mfd: mt6397: Drop of_match_ptr from of_device_id table
      mfd: rt5033: Drop of_match_ptr from of_device_id table
      mfd: stmfx: Drop of_match_ptr from of_device_id table
      mfd: max77686: Drop of_match_ptr from of_device_id table
      mfd: sun4i: Drop of_match_ptr from of_device_id table
      mfd: wm8994: Drop of_match_ptr from of_device_id table
      mfd: axp20x: Skip of_device_id table when !CONFIG_OF
      mfd: twl6030: Mark of_device_id table as maybe unused

Lee Jones (2):
      Merge branch 'ib-mfd-mediatek-5.11' into ibs-for-mfd-merged
      mfd: tps65910: Fix a bunch of alignment issues reported-by Checkpatch

Michael Brunner (2):
      mfd: kempld-core: Check for DMI definition before ACPI
      mfd: kempld-core: Add support for additional devices

Michael Klein (1):
      mfd: si476x-core.h: Fix "regulator" spelling in comment

Michael Srba (1):
      mfd: rt5033: Fix errorneous defines

Michał Mirosław (4):
      mfd: tps65911-comparator: Use regmap accessors
      mfd: tps65910: Clean up after switching to regmap
      mfd: tps65910: Remove unused pointers
      gpio: tps65910: use regmap accessors

Richard Fitzgerald (1):
      mfd: madera: Delete register field xxx_WIDTH defines

Rikard Falkeborn (8):
      mfd: da9xxx-core: Constify static struct resource
      mfd: intel: Constify static struct resource
      mfd: tps65xxx: Constify static struct resource in OMAP2+ drivers
      mfd: wm8xxx-core: Constify static struct resource
      mfd: lp8788: Constify static struct resource
      mfd: stmpe: Constify static struct resource
      mfd: sun4i-gpadc: Constify static struct resource
      mfd: Constify static struct resources

Tony Lindgren (1):
      mfd: cpcap: Fix interrupt regression with regmap clear_ack

Zou Wei (1):
      mfd: altera-sysmgr: Use resource_size function on resource object

 Documentation/ABI/testing/sysfs-class-intel_pmt    | 119 ++++
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.yaml |   6 +
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   4 +
 MAINTAINERS                                        |   6 +
 drivers/gpio/gpio-tps65910.c                       |  12 +-
 drivers/mfd/88pm800.c                              |   2 +-
 drivers/mfd/88pm860x-core.c                        |  50 +-
 drivers/mfd/Kconfig                                |  42 +-
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/altera-sysmgr.c                        |   2 +-
 drivers/mfd/at91-usart.c                           |  12 +-
 drivers/mfd/axp20x-i2c.c                           |   2 +
 drivers/mfd/bcm590xx.c                             |   2 +-
 drivers/mfd/da9055-core.c                          |   8 +-
 drivers/mfd/da9055-i2c.c                           |   2 +-
 drivers/mfd/da9062-core.c                          |  26 +-
 drivers/mfd/da9063-core.c                          |   8 +-
 drivers/mfd/da9063-i2c.c                           |   2 +-
 drivers/mfd/da9150-core.c                          |   8 +-
 drivers/mfd/ene-kb3930.c                           |   2 +-
 drivers/mfd/fsl-imx25-tsadc.c                      |   2 +-
 drivers/mfd/hi655x-pmic.c                          |   2 +-
 drivers/mfd/htc-i2cpld.c                           |   2 +
 drivers/mfd/intel_msic.c                           |  18 +-
 drivers/mfd/intel_pmt.c                            | 223 ++++++++
 drivers/mfd/intel_quark_i2c_gpio.c                 |   4 +-
 drivers/mfd/intel_soc_pmic_bxtwc.c                 |  14 +-
 drivers/mfd/intel_soc_pmic_chtdc_ti.c              |  10 +-
 drivers/mfd/intel_soc_pmic_chtwc.c                 |   4 +-
 drivers/mfd/intel_soc_pmic_crc.c                   |  10 +-
 drivers/mfd/ioc3.c                                 |  16 +-
 drivers/mfd/kempld-core.c                          | 100 +++-
 drivers/mfd/lp8788.c                               |   4 +-
 drivers/mfd/madera-core.c                          |  35 +-
 drivers/mfd/max77650.c                             |   2 +-
 drivers/mfd/max77686.c                             |   2 +-
 drivers/mfd/max8925-core.c                         |  56 +-
 drivers/mfd/motorola-cpcap.c                       |   6 +-
 drivers/mfd/mt6397-core.c                          |   2 +-
 drivers/mfd/qcom-spmi-pmic.c                       |   4 +
 drivers/mfd/rdc321x-southbridge.c                  |   4 +-
 drivers/mfd/retu-mfd.c                             |   4 +-
 drivers/mfd/rk808.c                                |   8 +-
 drivers/mfd/rt5033.c                               |   2 +-
 drivers/mfd/stmfx.c                                |  12 +-
 drivers/mfd/stmpe.c                                |  10 +-
 drivers/mfd/sun4i-gpadc.c                          |   4 +-
 drivers/mfd/syscon.c                               |  18 +
 drivers/mfd/tc3589x.c                              |   4 +-
 drivers/mfd/tc6387xb.c                             |   2 +-
 drivers/mfd/tc6393xb.c                             |   6 +-
 drivers/mfd/tps65090.c                             |   2 +-
 drivers/mfd/tps65217.c                             |   4 +-
 drivers/mfd/tps6586x.c                             |   2 +-
 drivers/mfd/tps65910.c                             |  46 +-
 drivers/mfd/tps65911-comparator.c                  |   4 +-
 drivers/mfd/tps80031.c                             |   2 +-
 drivers/mfd/twl6030-irq.c                          |   2 +-
 drivers/mfd/wm831x-core.c                          |  52 +-
 drivers/mfd/wm8994-core.c                          |   6 +-
 drivers/platform/x86/Kconfig                       |  34 ++
 drivers/platform/x86/Makefile                      |   3 +
 drivers/platform/x86/intel_pmt_class.c             | 297 ++++++++++
 drivers/platform/x86/intel_pmt_class.h             |  52 ++
 drivers/platform/x86/intel_pmt_crashlog.c          | 328 +++++++++++
 drivers/platform/x86/intel_pmt_telemetry.c         | 160 ++++++
 include/linux/mfd/madera/core.h                    |   1 +
 include/linux/mfd/madera/registers.h               | 635 ---------------------
 include/linux/mfd/rt5033-private.h                 |  28 +-
 include/linux/mfd/si476x-core.h                    |   2 +-
 include/linux/mfd/syscon.h                         |  11 +
 include/linux/mfd/tps65910.h                       |  40 --
 include/uapi/linux/pci_regs.h                      |   5 +
 73 files changed, 1648 insertions(+), 974 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-intel_pmt
 create mode 100644 drivers/mfd/intel_pmt.c
 create mode 100644 drivers/platform/x86/intel_pmt_class.c
 create mode 100644 drivers/platform/x86/intel_pmt_class.h
 create mode 100644 drivers/platform/x86/intel_pmt_crashlog.c
 create mode 100644 drivers/platform/x86/intel_pmt_telemetry.c

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
