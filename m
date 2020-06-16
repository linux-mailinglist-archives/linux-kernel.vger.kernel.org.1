Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6551FB016
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 14:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgFPMSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 08:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbgFPMRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:17:37 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2210AC08C5C3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:17:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b7so1143850pju.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MpmBavrAY+NcMSTsAQ48p6wNUiPoSL0d6miZz8y14IE=;
        b=hwME/2Hm3k/tQH8+cNITC/0sv5z1s66dwLdL9ZBejhoO8dCZP8qWsUz1a7Ty6ig6/k
         ZwMDrtDor3C/9rmei6eOmJ03z7IO5+ZmY0lJ4C91pk38otK0rMkONaIUlhBecx/xZp7H
         a8Q/lGNgicWPz2MztwMBSKUoMI9KIuvaIMr8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MpmBavrAY+NcMSTsAQ48p6wNUiPoSL0d6miZz8y14IE=;
        b=DVS7FfJ3kRQJSLNQtR2+lqPXkvP+3VvBp9tIQRbLGeY3/yC3nrNRdKLr5n0NQ5CBW+
         5K0eNVPUmNKeGyCiD7sJce7kPF64sihF3f8BTwM+4/5apnKsGwTkw85Tgu6QjvKkvQrt
         Sy+0hW46f6hCGFyJ2JU2xblEyKWn9LWtbR4u84hPdYdOQsz07ffY0J/TkJz/+bS84wO3
         9+rsrZkkSHshrEBi5M4uDpze2niEsO54mPEcAJf/mqK5bdcS97LmCH4Y4kyfA77r92Zc
         P/yAOPmGAEHjAg8KyY2r5+FV/6OWYFqzlTms8GjnzfARslQWQMTYtpTtwjRzt3FQUDmf
         yjEA==
X-Gm-Message-State: AOAM530yx1BR95XMTjNkf5zI/m7GhGsAkOBzfvVLWFlr4IvtVDF9ZMfC
        NHyIwnV6p3dSUNiVwBhMIzucIQ==
X-Google-Smtp-Source: ABdhPJx+VzlhYRDn2bciHUsOTxFZn0WI19a1389Xf6c/UNJAsKB62DbXZwkrPG+vjKCyonbf4o/IyQ==
X-Received: by 2002:a17:90a:f0d4:: with SMTP id fa20mr2743765pjb.160.1592309856671;
        Tue, 16 Jun 2020 05:17:36 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id f23sm2360703pja.8.2020.06.16.05.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:17:36 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v4 12/12] ARM: mstar: Add dts for 70mai midrive d08
Date:   Tue, 16 Jun 2020 21:15:25 +0900
Message-Id: <20200616121525.1409790-13-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200616121525.1409790-1-daniel@0x0f.com>
References: <20200612130032.3905240-2-daniel@0x0f.com>
 <20200616121525.1409790-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds initial support for the 70mai midrive d08 dash camera.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/Makefile                    |  3 ++-
 .../boot/dts/mercury5-ssc8336n-midrived08.dts | 25 +++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/mercury5-ssc8336n-midrived08.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4a5f8075a4f6..caf4a47ba799 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1344,7 +1344,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
 dtb-$(CONFIG_ARCH_MSTARV7) += \
 	infinity-msc313-breadbee_crust.dtb \
-	infinity3-msc313e-breadbee.dtb
+	infinity3-msc313e-breadbee.dtb \
+	mercury5-ssc8336n-midrived08.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
 dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-ast2500-evb.dtb \
diff --git a/arch/arm/boot/dts/mercury5-ssc8336n-midrived08.dts b/arch/arm/boot/dts/mercury5-ssc8336n-midrived08.dts
new file mode 100644
index 000000000000..f24bd8cb8e60
--- /dev/null
+++ b/arch/arm/boot/dts/mercury5-ssc8336n-midrived08.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+/dts-v1/;
+#include "mercury5-ssc8336n.dtsi"
+
+/ {
+	model = "70mai Midrive D08";
+	compatible = "70mai,midrived08", "mstar,mercury5";
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
2.27.0.rc0

