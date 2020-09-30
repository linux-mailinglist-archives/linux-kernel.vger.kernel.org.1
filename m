Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EBE27DDDA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 03:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgI3BlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 21:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgI3BlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 21:41:15 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4C9C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 18:41:14 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id j11so467691ejk.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 18:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LSkCcfd5u6tIHuoglXDv5dm2jlHVEjxvQdA65Pq0GoA=;
        b=Ca86OShb3J5/791Ts6dB/T/Lo1vrbE/l771+QbFvBXD3CPEIWA1ERChhlaAo58wopT
         y9lyDzJXBvYNNPjpAYZZXawwUhSC3WeZBWOkL4BXw3DVFPEN8BgjZOc3x1GuBs8uI+f8
         e6vGlUcD62s/J47wMNpGk+QH5+ZiLpk/nHBlQsxJS4PTGf894qNORtYhyednvr7sDAKt
         MhNtVKxE+s7pRyO1c1w4MOIQ32HZJzStq4qCyU30PxuCR/9Z1aYhz6J2Z5zlyBU3VxLh
         NKvkcafo6n6PTTZz3/i3v9Lm1+UEQSPALQp0s3UzLx3aiuocgChB0aQNEy+x0fIEurRx
         rGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LSkCcfd5u6tIHuoglXDv5dm2jlHVEjxvQdA65Pq0GoA=;
        b=NUbOfuSA3FGv8t+YfW3dmGXQz2wpv3JNYwEGwXOi8xSZfBb57ab0uPUeIdcn8b7KkK
         Ljp15duVl25JLhzLEvJBaafLE2tG2anhJIjh10rEsSX9Os/tY84OPme9vHNHyW+FDmng
         yYrXecH9k6A3vfZ3SqpBMo00E2s2Dd4Pw+P3V1RBe21BD3agk3dqPtXk61QMLQ+K/L2G
         2VHdTOPevCVTOLBXvdUjnHCyuq+Rja0gfpXeXd5C7mN34kcSTD7wQfu9blU0U7Z4creM
         ooLB5h8GjN1eyNw14HHf8QOnJEwPWxVzi+TX8hS29inHvS6wDHa1dM1ZEzS7gjCeOpUB
         ZvCQ==
X-Gm-Message-State: AOAM5306urja0j69bXNuI/xHS4m+pDdXEq4xC5jwqxr3zx/2Bm+vat6Z
        Aj+l2uoRS3ab4Y+j9GB3Sx3Ekw3e25p4r6V2M79/0fWGYiy9eKvP9l6fqgNK6wKMk4BnoWMub03
        23921cc8FQWd3M6UOIfQadXS7t0XhxmuGL5CQw6juUnFWGQVtyxlNtM5yakAVDXGN4bJ6abs/eG
        GX4HmQ/0Blmw==
X-Google-Smtp-Source: ABdhPJw7xUlIH00UwAgym2lIgdIfzZmulqgjFLa0U1/kjWToRVO6y2LJUfl0Y2S0PdPL1T4XgTmbkg==
X-Received: by 2002:a17:907:64d:: with SMTP id wq13mr426766ejb.513.1601430072896;
        Tue, 29 Sep 2020 18:41:12 -0700 (PDT)
Received: from localhost.localdomain ([2a00:ee2:4b0d:3000:290:faff:fe54:449c])
        by smtp.gmail.com with ESMTPSA id q1sm203258ejy.37.2020.09.29.18.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 18:41:11 -0700 (PDT)
From:   Luka Kovacic <luka.kovacic@sartura.hr>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org
Cc:     lee.jones@linaro.org, pavel@ucw.cz, dmurphy@ti.com,
        robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        andrew@lunn.ch, jason@lakedaemon.net, gregory.clement@bootlin.com,
        marek.behun@nic.cz, luka.perkov@sartura.hr,
        robert.marko@sartura.hr, Luka Kovacic <luka.kovacic@sartura.hr>
Subject: [PATCH v3 0/7] Add support for the iEi Puzzle-M801 board
Date:   Wed, 30 Sep 2020 03:40:51 +0200
Message-Id: <20200930014058.44460-1-luka.kovacic@sartura.hr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the iEi Puzzle-M801 1U Rackmount Network
Appliance and for the iEi WT61P803 PUZZLE microcontroller, which enables
some board specific features like fan and LED control, system power
management and temperature sensor reading.

The platform is based on the popular Marvell Armada 8040 SoC and supports
up to 16 GB of DDR4 2400 MHz ECC RAM.
It has a PCIe x16 slot (x2 lanes only) and an M.2 type B slot.

External chassis ports:
2x 10 GbE SFP+
4x 1 GbE (Marvell 88E1512P)
2x USB 3.0
1x RJ45 serial port

All notable board components are supported in this patchset.

Changes for v2:
   - Use LAAs for local-mac-address and match reg values
   - Code styling changes
   - Error handling moved to the end of the function
   - Define all magic numbers in the main header file
   - Convert the driver to make it OF independent
   - Refactor hwmon to use devm_hwmon_device_register_with_info()
   - Reduce the number of mutex locks
   - Allocate memory once for the response buffer
   - Reduce managed memory allocations
Changes for v3:
   - Move iei-wt61p803-puzzle driver sysfs interface documentation to testing
   - Change some internal functions to static
   - Sync dt-bindings examples with the iEi Puzzle-M801 board dts
   - Remove obsolete device tree properties and correct LED functions
   - Reverse christmas tree variable declaration order, where possible
   - MAC address sysfs function rewrite
   - Fixed struct members size, where reasonable (MFD driver)
   - Add an error check for hwmon_dev
   - Use devm_led_classdev_register_ext() in the LED driver

Luka Kovacic (7):
  dt-bindings: Add iEi vendor prefix and iEi WT61P803 PUZZLE driver
    bindings
  drivers: mfd: Add a driver for iEi WT61P803 PUZZLE MCU
  drivers: hwmon: Add the iEi WT61P803 PUZZLE HWMON driver
  drivers: leds: Add the iEi WT61P803 PUZZLE LED driver
  Documentation/ABI: Add iei-wt61p803-puzzle driver sysfs interface
    documentation
  MAINTAINERS: Add an entry for the iEi WT61P803 PUZZLE driver
  arm64: dts: marvell: Add a device tree for the iEi Puzzle-M801 board

 .../testing/sysfs-driver-iei-wt61p803-puzzle  |   55 +
 .../hwmon/iei,wt61p803-puzzle-hwmon.yaml      |   41 +
 .../leds/iei,wt61p803-puzzle-leds.yaml        |   45 +
 .../bindings/mfd/iei,wt61p803-puzzle.yaml     |   82 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |   13 +
 arch/arm64/boot/dts/marvell/Makefile          |    1 +
 .../dts/marvell/armada-8040-puzzle-m801.dts   |  524 +++++++++
 drivers/hwmon/Kconfig                         |    8 +
 drivers/hwmon/Makefile                        |    1 +
 drivers/hwmon/iei-wt61p803-puzzle-hwmon.c     |  513 ++++++++
 drivers/leds/Kconfig                          |    8 +
 drivers/leds/Makefile                         |    1 +
 drivers/leds/leds-iei-wt61p803-puzzle.c       |  157 +++
 drivers/mfd/Kconfig                           |    8 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/iei-wt61p803-puzzle.c             | 1045 +++++++++++++++++
 include/linux/mfd/iei-wt61p803-puzzle.h       |   69 ++
 18 files changed, 2574 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-iei-wt61p803-puzzle
 create mode 100644 Documentation/devicetree/bindings/hwmon/iei,wt61p803-puzzle-hwmon.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/iei,wt61p803-puzzle-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/iei,wt61p803-puzzle.yaml
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
 create mode 100644 drivers/hwmon/iei-wt61p803-puzzle-hwmon.c
 create mode 100644 drivers/leds/leds-iei-wt61p803-puzzle.c
 create mode 100644 drivers/mfd/iei-wt61p803-puzzle.c
 create mode 100644 include/linux/mfd/iei-wt61p803-puzzle.h

-- 
2.26.2

