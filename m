Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1062C84C9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgK3NM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgK3NMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:12:24 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8632C061A52
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:11:14 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id p21so627069pjv.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZs3cd4haoA+TDqA6POpYN8YC7m6XfHT6GH0HjPmBjM=;
        b=oWiTzhnWl/fQzg1T9slRgtaCt2/g+zGGbYypUTCPsAaNuTGD1V9388NUIlN42/3WhV
         qe3Bl+aMhPqMT74y+tckf+P6MQbKeZYQ4eHTh5rwxfaPZRCkIqeIFgB1NnqjhijjGcqW
         9iF+u34DvdJcMECKwlV0xemBcxb+3fT4aSc64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZs3cd4haoA+TDqA6POpYN8YC7m6XfHT6GH0HjPmBjM=;
        b=oITTQi0UPZKcJrDpR8KpPKPdtrnoUkuRqNx/JnmiZHgLk52sj9TXHRNWErMW+MYEYC
         Xwm/5i4TQEWtY3BYlX987wMQXv9ZRlcJvwCSji9+ztumez6kwJJ3g+ri0XXjPHpgBPk8
         H02KXxC34TRFKVW9+CCyWHwgLjpvpnrP/HbB3KfCmq6orKWj7UpBI+1W8bKKUhZh49TI
         liucVFfXenfr+Oc8vblkYaaajs9ARHenWdK5YPWYBJfiyHlXVG9Xav/7zLElLG6YlJsU
         iPxKdpzk7Ztc8HHFDu5h8Bj8LYueeuwi7Dn8uMVDx6Cy+P9bF1TV/ECggWPwYWSJIdO/
         3HSg==
X-Gm-Message-State: AOAM530snycQzsrPnpdAgMluQkdPCe+uAH2A6EpHMyZBgsV28YKz4GjD
        kiWh/36BmcKveRvSivCF4hBawA==
X-Google-Smtp-Source: ABdhPJySImjWhN6xL9PrA3Yr3Eik7V1N2YySDWWv9vPlrD8E6aid9ZwdUUtNQXTeSzZx1li54Hs1uA==
X-Received: by 2002:a17:902:ee0b:b029:da:1856:72c2 with SMTP id z11-20020a170902ee0bb02900da185672c2mr18784979plb.0.1606741874508;
        Mon, 30 Nov 2020 05:11:14 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id a4sm41757578pjq.0.2020.11.30.05.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 05:11:13 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        w@1wt.eu, daniel@0x0f.com
Subject: [PATCH 7/9] ARM: mstar: Add dts for Honestar ssd201htv2
Date:   Mon, 30 Nov 2020 22:10:45 +0900
Message-Id: <20201130131047.2648960-8-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130131047.2648960-1-daniel@0x0f.com>
References: <20201130131047.2648960-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dts for the Honestar ssd201htv2 devkit.
This is for the board populated with a SSD202D.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/Makefile                    |  1 +
 .../mstar-infinity2m-ssd202d-ssd201htv2.dts   | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-ssd201htv2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ce66ffd5a1bb..ccbf44b6f32a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1372,6 +1372,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
 dtb-$(CONFIG_ARCH_MSTARV7) += \
 	mstar-infinity-msc313-breadbee_crust.dtb \
+	mstar-infinity2m-ssd202d-ssd201htv2.dtb \
 	mstar-infinity3-msc313e-breadbee.dtb \
 	mstar-mercury5-ssc8336n-midrived08.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-ssd201htv2.dts b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-ssd201htv2.dts
new file mode 100644
index 000000000000..5d81641414a2
--- /dev/null
+++ b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-ssd201htv2.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+/dts-v1/;
+#include "mstar-infinity2m-ssd202d.dtsi"
+
+/ {
+	model = "SSD201_HT_V2";
+	compatible = "honestar,ssd201htv2", "mstar,infinity2m";
+
+	aliases {
+		serial0 = &pm_uart;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&pm_uart {
+	status = "okay";
+};
-- 
2.29.2

