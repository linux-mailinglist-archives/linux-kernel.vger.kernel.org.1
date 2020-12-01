Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90AF2CA432
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391248AbgLANpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387938AbgLANpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:45:10 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8EFC061A51
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 05:43:57 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id j13so1260517pjz.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 05:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZs3cd4haoA+TDqA6POpYN8YC7m6XfHT6GH0HjPmBjM=;
        b=f/2IpXakdLzHmPBxF37xXRsHxu3TP7ceBiybQPbSxCHdq/+YZHfI4Pf00ORWxGOiqp
         Is9Kyvb3TV2BBX7H43WL0S+TeanOTIv6tlKJtOR5EwwfO50rjF5lUlwYAhLknKSxgH4s
         4GQSPSEFK6eYi+B9KWj3sJm3GwqQA7eMt3/5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZs3cd4haoA+TDqA6POpYN8YC7m6XfHT6GH0HjPmBjM=;
        b=UaDUMxGpI0v50y42zpftJg19AwMWaEbeybIPgVaPFHrdBpJ6oplJ+FtoZMbcjc0cpJ
         iZNPzXieVyDM3NB8fwsQ274bq2RRZnS7TNRe4CTz714EslpKZ/N8NevCrvEDjf++Oc1B
         iJb8NUX2g1zIH/+b/Z+8xkYtNWkxWWuBUuYsODvXGxad+yq/pnZGFIQrC4kyaMCgWoZJ
         Wci4rDnT0pyhrqzAZlgLNjsIzip9XNOeCCN2Jqcc4aoeluscaQ+UylMKArxQL6LCbZLX
         aUCmNGQ4GIPnyrvkX0achqzxec5JuGkL4NI+ut124w65s5YD2Zzs4hN4bmMjI0VFqOqq
         YKiA==
X-Gm-Message-State: AOAM530dDbdpDtlEqgQepN+n1IE0WZ4Ime5A4XrIIEuiOLmd2uGgdN69
        zsPdXZax9N0nDUz7Jgj+9CJ/DA==
X-Google-Smtp-Source: ABdhPJzlpZrs7tYCs+bVPPekgHDRENk2SgSkvvOa2zESTJWo07869xM/hna2VCsk8cT9VcgBPLJ3cw==
X-Received: by 2002:a17:90a:a487:: with SMTP id z7mr2838802pjp.102.1606830237578;
        Tue, 01 Dec 2020 05:43:57 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id g14sm2839248pji.32.2020.12.01.05.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 05:43:56 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        robh@kernel.org, w@1wt.eu, daniel@0x0f.com
Subject: [PATCH v2 07/10] ARM: mstar: Add dts for Honestar ssd201htv2
Date:   Tue,  1 Dec 2020 22:43:27 +0900
Message-Id: <20201201134330.3037007-8-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201134330.3037007-1-daniel@0x0f.com>
References: <20201201134330.3037007-1-daniel@0x0f.com>
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

