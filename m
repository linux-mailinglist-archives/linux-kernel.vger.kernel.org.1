Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A87286E3B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 07:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgJHFns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 01:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgJHFns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 01:43:48 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F43C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 22:43:46 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id i2so4412463ljg.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 22:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i71PJY1rLSI4eOg+PhEakUm+s6386zJP+9T/6pzaOEg=;
        b=D/9bfveKRY7NtJ/Ol+qzWXBZbPrDmL2RSVxXB8Qw4GxvPhKfFD8a5/LhM6xoJKyV92
         l2pPteRoF8F19iNbLlZM4/qkeNMHVvBjuo4cD+h1uLBh9K70mHdV98y3rYpe7FeRFt4Z
         CmlSb6hJHUsXc/qfwmBaWurD3lyzgAmZ0azE7bvUoJxobCOr4kWK9KRhThfQxTXZvD7c
         D1YjP2b7qSKCa4Qh+P6L1LRmRgYPZRD8VI6WZFi5nRTxJ7rcUJmFOm6x3qUc0ePwxS13
         RY4fbXNhbVpM8NrXRPC6j3PggJjM+dWfKnoy7B7mDZ2K+J4wR7kuC+uxdFyh3LfjhfPh
         ILYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i71PJY1rLSI4eOg+PhEakUm+s6386zJP+9T/6pzaOEg=;
        b=sOsQev0onWgUv/zkd9iXLhZWQRhvhI/2o+oV9GI9WRMC/XVwArx4e4bIhvoWDmCqaw
         daOT1qYQOj6649y2xuMA9wMn0C37PoGHuPk8FcJryJTJL5XDLpS8Lv2LXXNnkv7CiR39
         phmhQzXFbbqbkPM1uu2XmXVoZWWHdGQ+gCJA5UflSTfSfhUOGCIwbppg8+tW6FpyLBzG
         UUlxtmI5WfK0+TWSlFkoIHruvFHHBTmQdyrKw34bOgnaKIIF/giwXAGNIF4r0U92/4C9
         +O8ggEiwob+BfseWUa/PcW8aMmsL8bI8WKGO65EcLE+j9e6ZENmzbW9ZZicaWMlHH/xx
         RrFA==
X-Gm-Message-State: AOAM531aLt1HfJeZ6pZCoUM4aiODqC9YqOaGB3CnDSZ3WHHFL3GWwpHa
        WShaJqhzdzVhcOK9zNvIIJWFOg==
X-Google-Smtp-Source: ABdhPJxA9d+S0OjpGIJz2cGmcZ/RB2TADS7auylQiOH9np9UxomCUyJaZ2ljT+CNDWrHr/EFqNRfmg==
X-Received: by 2002:a2e:9b02:: with SMTP id u2mr2707129lji.303.1602135823116;
        Wed, 07 Oct 2020 22:43:43 -0700 (PDT)
Received: from localhost.localdomain (128-70-36-207.broadband.corbina.ru. [128.70.36.207])
        by smtp.googlemail.com with ESMTPSA id x14sm738816ljm.126.2020.10.07.22.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 22:43:42 -0700 (PDT)
From:   Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Shimahara <akira215corp@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Evgeny Boger <boger@wirenboard.com>,
        Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
Subject: [PATCH] docs: w1: w1_therm: Fix broken xref, mistakes, clarify text
Date:   Thu,  8 Oct 2020 08:42:59 +0300
Message-Id: <20201008054259.5461-1-ivan.zaentsev@wirenboard.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs attribute names are mixed with the same normal text terms.
Use ReST to distinguish.

Fix typos and mistakes.

Signed-off-by: Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
---
 .../ABI/testing/sysfs-driver-w1_therm         |  6 +-
 Documentation/w1/slaves/w1_therm.rst          | 83 +++++++++----------
 2 files changed, 43 insertions(+), 46 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index 9f05bcdcd762..8873bbb075cb 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -146,7 +146,7 @@ Date:		July 2020
 Contact:	Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
 Description:
 		(RW) Control optional driver settings.
-		Bit masks to read/write (logical OR):
+		Bit masks to read/write (bitwise OR):
 
                 1: Enable check for conversion success. If byte 6 of
                    scratchpad memory is 0xC after conversion, and
@@ -157,7 +157,7 @@ Description:
                    after the conversion start and wait for 1's. In parasite
                    power mode this feature is not available.
 
-		*read*:  Currently selected features, bitwise OR.
-		*write*: Select features, bitwise OR.
+		*read*:  Currently selected features.
+		*write*: Select features.
 
 Users:		An application using the w1_term device
diff --git a/Documentation/w1/slaves/w1_therm.rst b/Documentation/w1/slaves/w1_therm.rst
index 00376501a5ef..e39202e2b000 100644
--- a/Documentation/w1/slaves/w1_therm.rst
+++ b/Documentation/w1/slaves/w1_therm.rst
@@ -27,75 +27,72 @@ W1_THERM_DS1825		0x3B
 W1_THERM_DS28EA00	0x42
 ====================	====
 
-Support is provided through the sysfs w1_slave file. Each open and
-read sequence will initiate a temperature conversion then provide two
+Support is provided through the sysfs entry ``w1_slave``. Each open and
+read sequence will initiate a temperature conversion, then provide two
 lines of ASCII output. The first line contains the nine hex bytes
 read along with a calculated crc value and YES or NO if it matched.
 If the crc matched the returned values are retained. The second line
 displays the retained values along with a temperature in millidegrees
 Centigrade after t=.
 
-Alternatively, temperature can be read using temperature sysfs, it
-return only temperature in millidegrees Centigrade.
+Alternatively, temperature can be read using ``temperature`` sysfs, it
+returns only the temperature in millidegrees Centigrade.
 
-A bulk read of all devices on the bus could be done writing 'trigger'
-in the therm_bulk_read sysfs entry at w1_bus_master level. This will
-sent the convert command on all devices on the bus, and if parasite
-powered devices are detected on the bus (and strong pullup is enable
+A bulk read of all devices on the bus could be done writing ``trigger``
+to ``therm_bulk_read`` entry at w1_bus_master level. This will
+send the convert command to all devices on the bus, and if parasite
+powered devices are detected on the bus (and strong pullup is enabled
 in the module), it will drive the line high during the longer conversion
 time required by parasited powered device on the line. Reading
-therm_bulk_read will return 0 if no bulk conversion pending,
+``therm_bulk_read`` will return 0 if no bulk conversion pending,
 -1 if at least one sensor still in conversion, 1 if conversion is complete
 but at least one sensor value has not been read yet. Result temperature is
-then accessed by reading the temperature sysfs entry of each device, which
+then accessed by reading the ``temperature`` entry of each device, which
 may return empty if conversion is still in progress. Note that if a bulk
 read is sent but one sensor is not read immediately, the next access to
-temperature on this device will return the temperature measured at the
+``temperature`` on this device will return the temperature measured at the
 time of issue of the bulk read command (not the current temperature).
 
 A strong pullup will be applied during the conversion if required.
 
-``conv_time`` sysfs entry is used to get current conversion time (read), and
+``conv_time`` is used to get current conversion time (read), and
 adjust it (write). A temperature conversion time depends on the device type and
 it's current resolution. Default conversion time is set by the driver according
 to the device datasheet. A conversion time for many original device clones
 deviate from datasheet specs. There are three options: 1) manually set the
 correct conversion time by writing a value in milliseconds to ``conv_time``; 2)
 auto measure and set a conversion time by writing ``1`` to
-``conv_time``; 3) use ``features`` entry to enable poll for conversion
+``conv_time``; 3) use ``features`` to enable poll for conversion
 completion. Options 2, 3 can't be used in parasite power mode. To get back to
 the default conversion time write ``0`` to ``conv_time``.
 
-Writing a value between 9 and 12 to the sysfs w1_slave file will change the
-precision of the sensor for the next readings. This value is in (volatile)
-SRAM, so it is reset when the sensor gets power-cycled.
+Writing a resolution value (in bits) to ``w1_slave`` will change the
+precision of the sensor for the next readings. Allowed resolutions are defined by
+the sensor. Resolution is reset when the sensor gets power-cycled.
 
-To store the current precision configuration into EEPROM, the value 0
-has to be written to the sysfs w1_slave file. Since the EEPROM has a limited
-amount of writes (>50k), this command should be used wisely.
+To store the current resolution in EEPROM, write ``0`` to ``w1_slave``.
+Since the EEPROM has a limited amount of writes (>50k), this command should be
+used wisely.
 
-Alternatively, resolution can be set or read (value from 9 to 12) using the
-dedicated resolution sysfs entry on each device. This sysfs entry is not present
-for devices not supporting this feature.
+Alternatively, resolution can be read or written using the dedicated
+``resolution`` entry on each device, if supported by the sensor.
 
-Some non-genuine DS18B20 chips are
-fixed in 12-bit mode only, so the actual resolution is read back from the chip
-and verified by the driver.
+Some non-genuine DS18B20 chips are fixed in 12-bit mode only, so the actual
+resolution is read back from the chip and verified.
 
 Note: Changing the resolution reverts the conversion time to default.
 
-The write-only sysfs entry eeprom is an alternative for EEPROM operations:
-  * 'save': will save device RAM to EEPROM
-  * 'restore': will restore EEPROM data in device RAM.
+The write-only sysfs entry ``eeprom`` is an alternative for EEPROM operations.
+Write ``save`` to save device RAM to EEPROM. Write ``restore`` to restore EEPROM
+data in device RAM.
 
-ext_power syfs entry allow tho check the power status of each device.
-  * '0': device parasite powered
-  * '1': device externally powered
+``ext_power`` entry allows checking the power state of each device. Reads
+``0`` if the device is parasite powered, ``1`` if the device is externally powered.
 
-sysfs alarms allow read or write TH and TL (Temperature High an Low) alarms.
+Sysfs ``alarms`` allow read or write TH and TL (Temperature High an Low) alarms.
 Values shall be space separated and in the device range (typical -55 degC
 to 125 degC). Values are integer as they are store in a 8bit register in
-the device. Lowest value is automatically put to TL.Once set, alarms could
+the device. Lowest value is automatically put to TL. Once set, alarms could
 be search at master level.
 
 The module parameter strong_pullup can be set to 0 to disable the
@@ -119,24 +116,24 @@ The DS28EA00 provides an additional two pins for implementing a sequence
 detection algorithm.  This feature allows you to determine the physical
 location of the chip in the 1-wire bus without needing pre-existing
 knowledge of the bus ordering.  Support is provided through the sysfs
-w1_seq file.  The file will contain a single line with an integer value
+``w1_seq``. The file will contain a single line with an integer value
 representing the device index in the bus starting at 0.
 
 ``features`` sysfs entry controls optional driver settings per device.
-Insufficient power in parasite mode, line noise and insufficient conversion time
-may lead to conversion failure. Original DS18B20 and some clones allow for
+Insufficient power in parasite mode, line noise and insufficient conversion
+time may lead to conversion failure. Original DS18B20 and some clones allow for
 detection of invalid conversion. Write bit mask ``1`` to ``features`` to enable
 checking the conversion success. If byte 6 of scratchpad memory is 0xC after
 conversion and temperature reads 85.00 (powerup value) or 127.94 (insufficient
 power), the driver returns a conversion error. Bit mask ``2`` enables poll for
 conversion completion (normal power only) by generating read cycles on the bus
 after conversion starts. In parasite power mode this feature is not available.
-Feature bit masks may be combined (OR). See accompanying sysfs documentation:
-:ref:`Documentation/w1/slaves/w1_therm.rst <w1_therm>`
+Feature bit masks may be combined (OR). More details in
+Documentation/ABI/testing/sysfs-driver-w1_therm
 
 GX20MH01 device shares family number 0x28 with DS18*20. The device is generally
-compatible with DS18B20. Added are lowest 2^-5, 2^-6 temperature bits in Config
-register; R2 bit in Config register enabling 13 and 14 bit resolutions. The
-device is powered up in 14-bit resolution mode. The conversion times specified
-in the datasheet are too low and have to be increased. The device supports
-driver features ``1`` and ``2``.
+compatible with DS18B20. Added are lowest 2\ :sup:`-5`, 2\ :sup:`-6` temperature
+bits in Config register; R2 bit in Config register enabling 13 and 14 bit
+resolutions. The device is powered up in 14-bit resolution mode. The conversion
+times specified in the datasheet are too low and have to be increased. The
+device supports driver features ``1`` and ``2``.
-- 
2.25.1

