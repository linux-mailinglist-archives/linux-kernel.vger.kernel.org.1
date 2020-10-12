Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75E228BAD5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389766AbgJLO2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388921AbgJLO2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:28:34 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E7FC0613D0;
        Mon, 12 Oct 2020 07:28:34 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t77so18920966oie.4;
        Mon, 12 Oct 2020 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=aPIzXeqlPLaNn1oY7uEmE3ROTpIfCJEvcRWgvKdoovk=;
        b=bfLueSZFVfYI5t4tiG4nXBTPplLCTqZvraJdnhWdDOpv3kDW6Scc0fv24fdX8vm5aN
         q+6bCFVhsBy1yRWWqfE+22PBu5yCbmoJ54ZMeVojAzpNdJHIEeXusZbNBJD/FJ5i+TnW
         xXhehWMXqW7CjSUsWLRaUYPrV3QPwg6DRgSYUGAA6+38AWmuexuK4+iDbGtvgBH/+Imv
         nTq9hS6U5uEr0DbGMQ/9/pfMujY6Kw3762NpwhesZDMXEcA8mtesluLoEPaEv6Ja4uwa
         oWV2f1F0HIrNZyPN24YugXhxAqgjwHbG+9J+jXGBEOK7edEItAZ8C2X1dUlyNwYW4B2c
         6siA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=aPIzXeqlPLaNn1oY7uEmE3ROTpIfCJEvcRWgvKdoovk=;
        b=HE+Kpo8XMd+mRFcTWXF0XUSICPeU00ZmhEf46cKG80c5LYUl+oXM/Pazd4yq3kNeZa
         9rDA8udG5Y0ArXpG5k3vcNYPhH+LPLavGF0SFxmsDrcfMSbnT/i1ejvF6un6HIiREzCl
         B+ZD5eHl32SrbQaNV52HeeniK3QSmKuFgBXS0IUgRfTECjUMQA+/VPXzEiln/u77eZTs
         e3bKyl8PDD+zVWpOffYD0gROD7jQfDECQJ9FPTJmp9ZLfQpgUzh4k5pKDtk8NjY/fFdl
         IL4cGbpLFU4jJ193++IIKgpLvJe3xhduSO1hp6sG/bq1qiYLmhQOzn9i/kJItusjOr98
         BXFQ==
X-Gm-Message-State: AOAM532RF7pVmspiL/n3N/vtl7gb8LxWSAckigu430bSMGHgJpnccdYX
        ffEz/CvRtn0qlTmYWID5MOVw2g6U+PY=
X-Google-Smtp-Source: ABdhPJyeHHQSLUa+wPYVpDy/riRpBd7Mg7EniWXMPF3j67afm7fUBEZtzFvCL9Lu3zkF0259mmLL8Q==
X-Received: by 2002:aca:c586:: with SMTP id v128mr11307848oif.115.1602512913598;
        Mon, 12 Oct 2020 07:28:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o2sm9556849oia.42.2020.10.12.07.28.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Oct 2020 07:28:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v5.10
Date:   Mon, 12 Oct 2020 07:28:32 -0700
Message-Id: <20201012142832.222386-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v5.10 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.10

Thanks,
Guenter
------

The following changes since commit ba4f184e126b751d1bffad5897f263108befc780:

  Linux 5.9-rc6 (2020-09-20 16:33:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.10

for you to fetch changes up to 9b20aec24b8ab2860ea41182ba554dfcc444c0c8:

  hwmon: (pmbus/max20730) adjust the vout reading given voltage divider (2020-10-06 14:54:55 -0700)

----------------------------------------------------------------
hwmon changes for v5.10-rc1

New driver and chip support:
- Moortec MR75203 PVT controller
- MPS Multi-phase mp2975 controller
- ADM1266
- Zen3 CPUs
- Intel MAX 10 BMC

Enhancements:
- Support for rated attributes in hwmon core
- MAX20730
  - Device monitoring via debugfs
  - VOUT readin adjustment vie devicetree bindings
- LM75
  - Devicetree support
  - Regulator support
- Improved accumulationm logic in amd_energy driver
- Added fan sensor to gsc-hwmon driver
- Support for simplified I2C probing

Various other minor fixes and improvements.

----------------------------------------------------------------
Akshay Gupta (1):
      hwmon: (amd_energy) Move label out of accumulation structure

Alban Bedel (3):
      hwmon: (lm75) Add regulator support
      dt-bindings: hwmon: Convert lm75 bindings to yaml
      dt-bindings: hwmon: Add the +vs supply to the lm75 bindings

Alexandru Ardelean (1):
      docs: hwmon: (ltc2945) update datasheet link

Alexandru Tachici (6):
      hwmon: (pmbus) Add support for ADM1266
      hwmon: (pmbus/adm1266) Add Block process call
      hwmon: (pmbus/adm1266) Add support for GPIOs
      hwmon: (pmbus/adm1266) add debugfs for states
      hwmon: (pmbus/adm1266) read blackbox
      dt-bindings: hwmon: Add bindings for ADM1266

Andrew Jeffery (1):
      hwmon: (pmbus) Expose PEC debugfs attribute

Anson Huang (1):
      hwmon: (pwm-fan) Use dev_err_probe() to simplify error handling

Chris Packham (3):
      hwmon: (adm9240) Use loops to avoid duplicated code
      hwmon: (adm9240) Create functions for updating measure and config
      hwmon: (adm9240) Convert to regmap

Chris Ruehl (2):
      hwmon: shtc1: add support for device tree bindings
      devicetree: hwmon: shtc1: add sensirion,shtc1.yaml

Chu Lin (2):
      dt-bindings: hwmon: max20730: adding device tree doc for max20730
      hwmon: (pmbus/max20730) adjust the vout reading given voltage divider

Dan Carpenter (1):
      hwmon: (w83627ehf) Fix a resource leak in probe

Geert Uytterhoeven (1):
      hwmon: (mlxreg-fan) Fix double "Mellanox"

Guenter Roeck (5):
      hwmon: (pmbus/max34440) Fix status register reads for MAX344{51,60,61}
      hwmon: (drivetemp) Add usage not describing impact on drive spin-down
      hwmon: (k10temp) Take out debugfs code
      hwmon: (pmbus) Stop caching register values
      hwmon: (pmbus) Move boolean error condition check to generating code

Joe Perches (1):
      hwmon: (scmi-hwmon) Avoid comma separated statements

Lars Povlsen (1):
      hwmon: (sparx5) Fix initial reading of temperature

Naveen Krishna Chatradhi (3):
      hwmon: (amd_energy) optimize accumulation interval
      hwmon: (amd_energy) Improve the accumulation logic
      hwmon: (amd_energy) Update driver documentation

Rahul Tanwar (2):
      hwmon: Add DT bindings schema for PVT controller
      hwmon: Add hardware monitoring driver for Moortec MR75203 PVT controller

Serge Semin (3):
      hwmon: (bt1-pvt) Test sensor power supply on probe
      hwmon: (bt1-pvt) Cache current update timeout
      hwmon: (bt1-pvt) Wait for the completion with timeout

Stephen Kitt (14):
      hwmon (pmbus) use simple i2c probe function
      hwmon: use simple i2c probe function
      hwmon: (adm1177) use simple i2c probe
      hwmon: (adm1029) use simple i2c probe
      hwmon: (w83793) use simple i2c probe
      hwmon: (w83791d) use simple i2c probe
      hwmon: (lm73) use simple i2c probe
      hwmon: (asc7621) use simple i2c probe
      hwmon: (emc2103) use simple i2c probe
      hwmon: (ltc2947) use simple i2c probe
      hwmon: use simple i2c probe function (take 2)
      hwmon: (tmp513) use simple i2c probe
      hwmon: (f75375s) use simple i2c probe
      hwmon: (dme1737) use simple i2c probe

Steve Foreman (1):
      hwmon: (pmbus/max34440) Fix OC fault limits

Tim Harvey (1):
      hwmon: (gsc-hwmon) add fan sensor

Ugur Usug (1):
      hwmon: (pmbus/max20730) add device monitoring via debugfs

Vadim Pasternak (2):
      hwmon: (pmbus) Add support for MPS Multi-phase mp2975 controller
      dt-bindings: Add MP2975 voltage regulator device

Wang Qing (1):
      hwmon: (tmp513) fix spelling typo in comments

Wei Huang (3):
      hwmon: (k10temp) Create common functions and macros for Zen CPU families
      hwmon: (k10temp) Define SVI telemetry and current factors for Zen2 CPUs
      hwmon: (k10temp) Add support for Zen3 CPUs

Xu Yilun (1):
      hwmon: Add hwmon driver for Intel MAX 10 BMC

Zbigniew Lukwinski (3):
      docs: hwmon: Add attributes to report rated values
      hwmon: (core) Add support for rated attributes
      hwmon: (pmbus/core) Add support for rated attributes

 .../devicetree/bindings/hwmon/adi,adm1266.yaml     |  51 ++
 Documentation/devicetree/bindings/hwmon/lm75.txt   |  39 --
 Documentation/devicetree/bindings/hwmon/lm75.yaml  |  66 ++
 .../devicetree/bindings/hwmon/maxim,max20730.yaml  |  65 ++
 .../devicetree/bindings/hwmon/moortec,mr75203.yaml |  71 ++
 .../devicetree/bindings/hwmon/sensirion,shtc1.yaml |  61 ++
 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 Documentation/hwmon/adm1266.rst                    |  37 +
 Documentation/hwmon/amd_energy.rst                 |   5 +
 Documentation/hwmon/drivetemp.rst                  |  18 +
 Documentation/hwmon/index.rst                      |   2 +
 Documentation/hwmon/intel-m10-bmc-hwmon.rst        |  78 +++
 Documentation/hwmon/ltc2945.rst                    |   2 +-
 Documentation/hwmon/mp2975.rst                     | 116 ++++
 Documentation/hwmon/pmbus-core.rst                 |   3 +-
 Documentation/hwmon/pmbus.rst                      |  22 +-
 Documentation/hwmon/sysfs-interface.rst            |  70 ++
 drivers/hwmon/Kconfig                              |  23 +-
 drivers/hwmon/Makefile                             |   2 +
 drivers/hwmon/ad7414.c                             |   5 +-
 drivers/hwmon/ad7418.c                             |   9 +-
 drivers/hwmon/adc128d818.c                         |   5 +-
 drivers/hwmon/adm1021.c                            |   9 +-
 drivers/hwmon/adm1025.c                            |   5 +-
 drivers/hwmon/adm1026.c                            |   5 +-
 drivers/hwmon/adm1029.c                            |   5 +-
 drivers/hwmon/adm1031.c                            |   9 +-
 drivers/hwmon/adm1177.c                            |   5 +-
 drivers/hwmon/adm9240.c                            | 356 +++++++---
 drivers/hwmon/ads7828.c                            |   9 +-
 drivers/hwmon/adt7410.c                            |   5 +-
 drivers/hwmon/adt7411.c                            |   5 +-
 drivers/hwmon/adt7462.c                            |   5 +-
 drivers/hwmon/adt7470.c                            |   5 +-
 drivers/hwmon/adt7475.c                            |   6 +-
 drivers/hwmon/amc6821.c                            |   5 +-
 drivers/hwmon/amd_energy.c                         | 164 ++---
 drivers/hwmon/asb100.c                             |   8 +-
 drivers/hwmon/asc7621.c                            |   4 +-
 drivers/hwmon/atxp1.c                              |   5 +-
 drivers/hwmon/bt1-pvt.c                            | 138 ++--
 drivers/hwmon/bt1-pvt.h                            |   3 +
 drivers/hwmon/dme1737.c                            |   9 +-
 drivers/hwmon/ds1621.c                             |   9 +-
 drivers/hwmon/ds620.c                              |   5 +-
 drivers/hwmon/emc1403.c                            |   8 +-
 drivers/hwmon/emc2103.c                            |   4 +-
 drivers/hwmon/emc6w201.c                           |   5 +-
 drivers/hwmon/f75375s.c                            |  10 +-
 drivers/hwmon/fschmd.c                             |  10 +-
 drivers/hwmon/ftsteutates.c                        |   4 +-
 drivers/hwmon/g760a.c                              |   5 +-
 drivers/hwmon/g762.c                               |   4 +-
 drivers/hwmon/gl518sm.c                            |   5 +-
 drivers/hwmon/gl520sm.c                            |   5 +-
 drivers/hwmon/gsc-hwmon.c                          |  32 +-
 drivers/hwmon/hih6130.c                            |   5 +-
 drivers/hwmon/hwmon.c                              |  10 +
 drivers/hwmon/ina209.c                             |   5 +-
 drivers/hwmon/ina2xx.c                             |   9 +-
 drivers/hwmon/ina3221.c                            |   5 +-
 drivers/hwmon/intel-m10-bmc-hwmon.c                | 334 +++++++++
 drivers/hwmon/jc42.c                               |   4 +-
 drivers/hwmon/k10temp.c                            | 162 ++---
 drivers/hwmon/lineage-pem.c                        |   5 +-
 drivers/hwmon/lm63.c                               |   9 +-
 drivers/hwmon/lm73.c                               |   4 +-
 drivers/hwmon/lm75.c                               |  33 +-
 drivers/hwmon/lm77.c                               |   4 +-
 drivers/hwmon/lm78.c                               |   9 +-
 drivers/hwmon/lm80.c                               |   5 +-
 drivers/hwmon/lm83.c                               |   9 +-
 drivers/hwmon/lm85.c                               |   8 +-
 drivers/hwmon/lm87.c                               |   4 +-
 drivers/hwmon/lm90.c                               |   7 +-
 drivers/hwmon/lm92.c                               |   5 +-
 drivers/hwmon/lm93.c                               |   5 +-
 drivers/hwmon/lm95234.c                            |   9 +-
 drivers/hwmon/lm95241.c                            |   5 +-
 drivers/hwmon/lm95245.c                            |   5 +-
 drivers/hwmon/ltc2945.c                            |   5 +-
 drivers/hwmon/ltc2947-i2c.c                        |   5 +-
 drivers/hwmon/ltc2990.c                            |   5 +-
 drivers/hwmon/ltc4151.c                            |   5 +-
 drivers/hwmon/ltc4215.c                            |   5 +-
 drivers/hwmon/ltc4222.c                            |   5 +-
 drivers/hwmon/ltc4245.c                            |   5 +-
 drivers/hwmon/ltc4260.c                            |   5 +-
 drivers/hwmon/ltc4261.c                            |   5 +-
 drivers/hwmon/max16065.c                           |   8 +-
 drivers/hwmon/max1619.c                            |   5 +-
 drivers/hwmon/max1668.c                            |   9 +-
 drivers/hwmon/max31730.c                           |   4 +-
 drivers/hwmon/max31790.c                           |   5 +-
 drivers/hwmon/max6621.c                            |   5 +-
 drivers/hwmon/max6639.c                            |   5 +-
 drivers/hwmon/max6642.c                            |   5 +-
 drivers/hwmon/max6650.c                            |  10 +-
 drivers/hwmon/max6697.c                            |   9 +-
 drivers/hwmon/mcp3021.c                            |   9 +-
 drivers/hwmon/mr75203.c                            | 656 ++++++++++++++++++
 drivers/hwmon/nct7802.c                            |   5 +-
 drivers/hwmon/nct7904.c                            |   5 +-
 drivers/hwmon/occ/p8_i2c.c                         |   5 +-
 drivers/hwmon/pcf8591.c                            |   5 +-
 drivers/hwmon/pmbus/Kconfig                        |  20 +
 drivers/hwmon/pmbus/Makefile                       |   2 +
 drivers/hwmon/pmbus/adm1266.c                      | 513 ++++++++++++++
 drivers/hwmon/pmbus/adm1275.c                      |  11 +-
 drivers/hwmon/pmbus/bel-pfe.c                      |  11 +-
 drivers/hwmon/pmbus/ibm-cffps.c                    |  19 +-
 drivers/hwmon/pmbus/inspur-ipsps.c                 |   7 +-
 drivers/hwmon/pmbus/ir35221.c                      |   7 +-
 drivers/hwmon/pmbus/ir38064.c                      |   7 +-
 drivers/hwmon/pmbus/irps5401.c                     |   7 +-
 drivers/hwmon/pmbus/isl68137.c                     |  11 +-
 drivers/hwmon/pmbus/lm25066.c                      |  11 +-
 drivers/hwmon/pmbus/ltc2978.c                      |  14 +-
 drivers/hwmon/pmbus/ltc3815.c                      |   7 +-
 drivers/hwmon/pmbus/max16064.c                     |   7 +-
 drivers/hwmon/pmbus/max16601.c                     |   7 +-
 drivers/hwmon/pmbus/max20730.c                     | 390 ++++++++++-
 drivers/hwmon/pmbus/max20751.c                     |   7 +-
 drivers/hwmon/pmbus/max31785.c                     |   9 +-
 drivers/hwmon/pmbus/max34440.c                     |  39 +-
 drivers/hwmon/pmbus/max8688.c                      |   7 +-
 drivers/hwmon/pmbus/mp2975.c                       | 769 +++++++++++++++++++++
 drivers/hwmon/pmbus/pmbus.c                        |  11 +-
 drivers/hwmon/pmbus/pmbus.h                        |  16 +-
 drivers/hwmon/pmbus/pmbus_core.c                   | 308 +++++----
 drivers/hwmon/pmbus/pxe1610.c                      |   7 +-
 drivers/hwmon/pmbus/tps40422.c                     |   7 +-
 drivers/hwmon/pmbus/tps53679.c                     |  11 +-
 drivers/hwmon/pmbus/ucd9000.c                      |  13 +-
 drivers/hwmon/pmbus/ucd9200.c                      |  13 +-
 drivers/hwmon/pmbus/xdpe12284.c                    |   7 +-
 drivers/hwmon/pmbus/zl6100.c                       |  11 +-
 drivers/hwmon/powr1220.c                           |   5 +-
 drivers/hwmon/pwm-fan.c                            |  10 +-
 drivers/hwmon/scmi-hwmon.c                         |   6 +-
 drivers/hwmon/sht21.c                              |   5 +-
 drivers/hwmon/sht3x.c                              |   9 +-
 drivers/hwmon/shtc1.c                              |  34 +-
 drivers/hwmon/smm665.c                             |   9 +-
 drivers/hwmon/smsc47m192.c                         |   5 +-
 drivers/hwmon/sparx5-temp.c                        |   2 +-
 drivers/hwmon/stts751.c                            |   5 +-
 drivers/hwmon/tc654.c                              |   5 +-
 drivers/hwmon/tc74.c                               |   5 +-
 drivers/hwmon/thmc50.c                             |   9 +-
 drivers/hwmon/tmp102.c                             |   5 +-
 drivers/hwmon/tmp103.c                             |   5 +-
 drivers/hwmon/tmp108.c                             |   5 +-
 drivers/hwmon/tmp401.c                             |   7 +-
 drivers/hwmon/tmp421.c                             |   7 +-
 drivers/hwmon/tmp513.c                             |  11 +-
 drivers/hwmon/w83627ehf.c                          |   6 +-
 drivers/hwmon/w83773g.c                            |   5 +-
 drivers/hwmon/w83781d.c                            |   9 +-
 drivers/hwmon/w83791d.c                            |   8 +-
 drivers/hwmon/w83792d.c                            |   7 +-
 drivers/hwmon/w83793.c                             |   8 +-
 drivers/hwmon/w83795.c                             |   9 +-
 drivers/hwmon/w83l785ts.c                          |   8 +-
 drivers/hwmon/w83l786ng.c                          |   4 +-
 include/linux/hwmon.h                              |  20 +
 include/linux/platform_data/gsc_hwmon.h            |   1 +
 167 files changed, 4576 insertions(+), 1022 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/lm75.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/lm75.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max20730.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
 create mode 100644 Documentation/hwmon/adm1266.rst
 create mode 100644 Documentation/hwmon/intel-m10-bmc-hwmon.rst
 create mode 100644 Documentation/hwmon/mp2975.rst
 create mode 100644 drivers/hwmon/intel-m10-bmc-hwmon.c
 create mode 100644 drivers/hwmon/mr75203.c
 create mode 100644 drivers/hwmon/pmbus/adm1266.c
 create mode 100644 drivers/hwmon/pmbus/mp2975.c
