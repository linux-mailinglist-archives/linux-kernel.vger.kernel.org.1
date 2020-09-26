Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019362799E4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 15:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgIZN4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 09:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbgIZNzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 09:55:46 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE6DC0613D5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 06:55:46 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id r7so2352505ejs.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1VEJVLIKvGXIpDq7Str9wltA+5iXr9h3WFs6hOYr6A0=;
        b=0dbuE2nX/PVL4FzxTLZeh32ngHh5v+iFZ9McW0BaPbJVbx/N3igN/ID9UIxPGSkSER
         zS3umRiZROGdtS87ULLrYf8fT1xEKw5tYgwCHjiqacMqSExyixml2qF+aphYJYcjWNFZ
         daapt+dS+54W4/gI6kWnT2aRg0AMZyyd3NR+O6806ByQSHvWAs2TjJCh1q0/UyiZ0spN
         mWI7tVnQ3vNPjoAeLHdIjPKge6Dpqk1mZmNR1R5hd6+GtsAd8WfHA986A0k27OrWcRFT
         L+T3FONQHhcSWcFwDmjnrqgavgZ8AUIb7dOITMTIfXbLUr7IW63ICyIS+nyeeHkzCnS1
         4HmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1VEJVLIKvGXIpDq7Str9wltA+5iXr9h3WFs6hOYr6A0=;
        b=lzomNCFWsdFE9Nc7mcQyo9j1w5q+FeTk01sR9BKO/V6mhBKhu6twegNyS/RVF+Otad
         6dco0DVyH8F1hfDD3G3SSzPLdM9KUgGv7Fu5HKrXLdhmb3KzqDBpKNgzKqfC9wz4I7jU
         PSzKWjpc//Xd726w+bgLRgp42LVLDuiMwnWxLJd2p0VTk0hXLW3UF0118sAuUcLLAKIA
         Xu/sBMEl8artxYus8BlEhFjrcARPmNU+5TkdIPmXOB1enivATLarxw0JfTx0HSj7/STK
         RXyd0HX5bW7pvnHF1/xqW+LaqBmrFedYNrgBwjYuli6W7zBXT7ZqL+XPLVSldlOzKz3v
         tW5A==
X-Gm-Message-State: AOAM531sCv0ok0b4n9UIo46DPHV6pfXm1hA48bXCA+SMWHwfwQoy++L/
        GDBL7bhoJFfQTX3cAOu9xGfr2Nj3/nK4QZ2zxm6pU04SjgDBW3o0AvpegdhWEJaX7eZItDDlPJ9
        LvpBPV+ic1chZy05uyEewnnINEsJDrst3Yeyy/VNBY7l3FpsB6l7nVA1o2+6wWub3U40nBkfquc
        Gmsi8IWIVt+w==
X-Google-Smtp-Source: ABdhPJwrSIKF8YUb10cE0TyKky+5ImevETCGKyxxNGjpLdD7ejWH1gyLu8OPn27l6ruya8AFUNicUg==
X-Received: by 2002:a17:906:b7d1:: with SMTP id fy17mr7786600ejb.391.1601128544578;
        Sat, 26 Sep 2020 06:55:44 -0700 (PDT)
Received: from localhost.localdomain ([2a00:ee2:4b0d:3001:fbc5:498b:ed6d:cfac])
        by smtp.gmail.com with ESMTPSA id oq8sm4165700ejb.32.2020.09.26.06.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 06:55:43 -0700 (PDT)
From:   Luka Kovacic <luka.kovacic@sartura.hr>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org
Cc:     lee.jones@linaro.org, pavel@ucw.cz, dmurphy@ti.com,
        robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        andrew@lunn.ch, jason@lakedaemon.net, gregory.clement@bootlin.com,
        luka.perkov@sartura.hr, robert.marko@sartura.hr,
        Luka Kovacic <luka.kovacic@sartura.hr>
Subject: [PATCH v2 5/7] Documentation/ABI: Add iei-wt61p803-puzzle driver sysfs interface documentation
Date:   Sat, 26 Sep 2020 15:55:12 +0200
Message-Id: <20200926135514.26189-6-luka.kovacic@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200926135514.26189-1-luka.kovacic@sartura.hr>
References: <20200926135514.26189-1-luka.kovacic@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the iei-wt61p803-puzzle driver sysfs interface documentation to allow
monitoring and control of the microcontroller from user space.

Signed-off-by: Luka Kovacic <luka.kovacic@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
Cc: Robert Marko <robert.marko@sartura.hr>
---
 .../stable/sysfs-driver-iei-wt61p803-puzzle   | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-iei-wt61p803-puzzle

diff --git a/Documentation/ABI/stable/sysfs-driver-iei-wt61p803-puzzle b/Documentation/ABI/stable/sysfs-driver-iei-wt61p803-puzzle
new file mode 100644
index 000000000000..36fca70d66ef
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-driver-iei-wt61p803-puzzle
@@ -0,0 +1,65 @@
+What:		/sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/mac_address_*
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	Read the internal iEi WT61P803 PUZZLE MCU MAC address values.
+		These are factory assigned and can be changed.
+
+What:		/sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/serial_number
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	Read the internal iEi WT61P803 PUZZLE MCU serial number.
+		This value is factory assigned and can be changed.
+
+What:		/sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/version
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	Read the internal iEi WT61P803 PUZZLE MCU version.
+		This value is read only.
+
+What:		/sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/protocol_version
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	Read the internal iEi WT61P803 PUZZLE MCU protocol version.
+		This value is read only.
+
+What:		/sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/power_loss_recovery
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	Read the iEi WT61P803 PUZZLE MCU power loss recovery value.
+		This value is read write.
+		Value mapping: 0 - Always-On, 1 - Always-Off, 2 - Always-AC, 3 - Always-WA
+
+What:		/sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/bootloader_mode
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	Read whether the MCU is in bootloader mode.
+		This value is read only.
+
+What:		/sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/power_status
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	Read the iEi WT61P803 PUZZLE MCU power status. Power status indicates
+		the power on method.
+		This value is read only.
+		Value mapping (bitwise list):
+		0x80 - Null
+		0x40 - Firmware flag
+		0x20 - Power loss detection flag (powered off)
+		0x10 - Power loss detection flag (AC mode)
+		0x08 - Button power on
+		0x04 - WOL power on
+		0x02 - RTC alarm power on
+		0x01 - AC recover power on
+
+What:		/sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/build_info
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	Read the iEi WT61P803 PUZZLE MCU firmware build date.
+		This value is read only.
+		Format: yyyy/mm/dd hh:mm
+
+What:		/sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/ac_recovery_status
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	Read the iEi WT61P803 PUZZLE MCU AC recovery status.
+		This value is read only.
-- 
2.26.2

