Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710A22914A4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 23:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439538AbgJQVLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 17:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439524AbgJQVLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 17:11:02 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E1CC0613D8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 14:11:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k18so8965476wmj.5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 14:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jsG9e64+hm1kWvWLBkpftUqDmTbdR66JgHzNao/M1zI=;
        b=qoifY64wAdwn7khzBxkdl+UpeJtD27IP5uEKD2PAYtXh58H75W99PMaHcPyH2BLK4A
         LVs0YlKNOcuZ+yPv7F1LWYuvu28r82+e4M6mOGw3hWKddo5/RmL/tF6lL8SCBFymm3Kw
         h6ajPnMVk+4nKRLDJp6P0arsQOkEWpIcSsz0L2fqcwEzV6Jente1Iv7j2RbjOclHwnRO
         jTZSrRyxRfX5jtJMAL+9GBShuLKyuK7070edWe/Xz9drUCf6mRt0R056wctLKvfWfAye
         GORoVbWwjZqSkmEG+OdldigW4+eaPztoREq1HcR8XjushYw2kShScKkVq5FoOwNBSW+1
         hTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jsG9e64+hm1kWvWLBkpftUqDmTbdR66JgHzNao/M1zI=;
        b=D+a9uTiCOrHJbDkNF7h4w0kphu6DKF8h80WSADF9a31Ax3EruhPqprOHB3i3VDa+kL
         ki3h/GTBVgomlCMtMcyjuw1jN4yaXKgwYsenhEIG/1LAfzdYC6ZQANll31iUMmqDv6Zi
         htc2+hh3WvXS7OpkxN2x2Bd7AwUh92ST9/EbHkRPV2NQ+Gsh/jprO1Gg0tbGZ4of/Kge
         c556Kqqb3ZJYBB+am6p4eTbkM1+4zy4PptUwRWPrjPo/A2oicuBY/D2kL/H4gN+HWvZg
         UtoPN/38RNg6+8rP4xtziRnGXA8kh4wRxpcATJhdaNnsqR2X+/nLtdrX2TknPsd8iyBr
         qttQ==
X-Gm-Message-State: AOAM531DirB6p5SE39xroOuyCE0vz7oNiERMQtnq8ma98PoyQCwGyRv0
        KEkaKvtvXNTDVZH7xjEHdunCe/TlymvOu54gWGBUexaXweX5/J92yR1T2WWS39HmdIXrFypOIst
        VCwUS0He7WtKXsuOnnTQli8+Sh2t/hfeuGdA17S5GxCdEbF2oCEGAbTbaSvdtIAWxyuYJuQ4xN9
        vx7JAm0hw=
X-Google-Smtp-Source: ABdhPJylpYBgv4j2sRxIphZ2Ns5kUqrpGHeW+8wdhAb270TjW7wxRzQLEf+FrYPEqj/5XIg5exh3xg==
X-Received: by 2002:a1c:ab55:: with SMTP id u82mr10508319wme.152.1602969059221;
        Sat, 17 Oct 2020 14:10:59 -0700 (PDT)
Received: from localhost.localdomain ([2a00:ee2:4b0d:3001:fbc5:498b:ed6d:cfac])
        by smtp.gmail.com with ESMTPSA id w11sm10337137wrs.26.2020.10.17.14.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 14:10:58 -0700 (PDT)
From:   Luka Kovacic <luka.kovacic@sartura.hr>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-leds@vger.kernel.org
Cc:     lee.jones@linaro.org, pavel@ucw.cz, dmurphy@ti.com,
        robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        marek.behun@nic.cz, luka.perkov@sartura.hr,
        robert.marko@sartura.hr, Luka Kovacic <luka.kovacic@sartura.hr>
Subject: [PATCH v5 5/6] Documentation/ABI: Add iei-wt61p803-puzzle driver sysfs interface documentation
Date:   Sat, 17 Oct 2020 23:10:34 +0200
Message-Id: <20201017211035.257110-6-luka.kovacic@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017211035.257110-1-luka.kovacic@sartura.hr>
References: <20201017211035.257110-1-luka.kovacic@sartura.hr>
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
 .../testing/sysfs-driver-iei-wt61p803-puzzle  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-iei-wt61p803-puzzle

diff --git a/Documentation/ABI/testing/sysfs-driver-iei-wt61p803-puzzle b/Documentation/ABI/testing/sysfs-driver-iei-wt61p803-puzzle
new file mode 100644
index 000000000000..6e71d85f3296
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-iei-wt61p803-puzzle
@@ -0,0 +1,55 @@
+What:		/sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/mac_address_*
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	(RW) Internal factory assigned MAC address values
+
+What:		/sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/serial_number
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	(RW) Internal factory assigned serial number
+
+What:		/sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/version
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	(RO) Internal MCU firmware version
+
+What:		/sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/protocol_version
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	(RO) Internal MCU communication protocol version
+
+What:		/sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/power_loss_recovery
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	(RW) Host platform power loss recovery settings
+		Value mapping: 0 - Always-On, 1 - Always-Off, 2 - Always-AC, 3 - Always-WA
+
+What:		/sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/bootloader_mode
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	(RO) Internal MCU bootloader mode status
+
+What:		/sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/power_status
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	(RO) Power status indicates the host platform power on method.
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
+Description:	(RO) Internal MCU firmware build date
+		Format: yyyy/mm/dd hh:mm
+
+What:		/sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/ac_recovery_status
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	(RO) Host platform AC recovery status value
-- 
2.26.2

