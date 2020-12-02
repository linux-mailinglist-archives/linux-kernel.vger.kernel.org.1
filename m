Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9F52CBCA7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbgLBMOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388759AbgLBMOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:14:36 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94691C061A4E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 04:13:26 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id r20so913371pjp.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 04:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYIua65HX6AZqIIo3oieYOADHYvPgIcX69HtWWA0OKA=;
        b=RIByB45uNFXa9ejOMf6ucwpX1iK5VGRJy5sYs8fQP6mlu+S1jFFi/KG4wAnph5H9AC
         9Iu1+Ysx+Y6EzdH8uaQJ/ZWIVYBQbbko9X8J2tJrwLCEQ+fH1Cg8JYYt5GfIXGbj9xF2
         1RRHq+z5Euf2qhtB7yNTSyCAsYJ5wEQh48uxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYIua65HX6AZqIIo3oieYOADHYvPgIcX69HtWWA0OKA=;
        b=jkea7R/SAVfdypA34l6oyamKEUft1mD6ZRxWyhHFVXutV9+DSNPaIdzVAGVfe1eElH
         FTYRBGxe5EAhssIYDYFI3ID/xSoeSZIAyl+J/TCmFjob3M4TbmyaYQbHmfDC2DPdnUSZ
         y1w9hm3Bew2EP31hQCPupfvKlnAZdY81H7gZae0/CuGI8W8UbVH2ZZdKy7tiuXtSW1q4
         7vwflN+3ZY6UIOpl6XJZqrGHDU26mz/kajXf0v1bLngwKw1S9MgEdy78r46gLTrKKg9M
         mkaINkFz7Y+bxFGzbyFplmMv+/Qesgo7ngmDdxio/3Qx4dwQ+7XNzUiqq9wC8LDBqJ33
         LnyA==
X-Gm-Message-State: AOAM531eQwKiMPN0Xtmqv16F9Qam7AxrR5AN4rXPzAcPmByjtVwSyNfW
        FA9UBG9j6eZHexPSFDjCzBTDKg==
X-Google-Smtp-Source: ABdhPJze40GYKqoCl1IgefRfCb2a4d08iQuzWKJfiBoNlv3paDMxjIcd6LtPYoD1H4RDWOT5HQWHMQ==
X-Received: by 2002:a17:90b:4a0d:: with SMTP id kk13mr2096405pjb.23.1606911206205;
        Wed, 02 Dec 2020 04:13:26 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:fd53:e9ba:b313:1b1d])
        by smtp.gmail.com with ESMTPSA id b37sm1951315pgl.31.2020.12.02.04.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:13:25 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Matteo Lisi <matteo.lisi@engicam.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 05/10] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit
Date:   Wed,  2 Dec 2020 17:42:36 +0530
Message-Id: <20201202121241.109952-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202121241.109952-1-jagan@amarulasolutions.com>
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.

EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive
Evaluation Board from Engicam.

i.Core MX8M Mini needs to mount on top of this Evaluation board for
creating complete i.Core MX8M Mini EDIMM2.2 Starter Kit.

Add support for it.

Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../imx8mm-engicam-icore-mx8mm-edimm2.2.dts   | 21 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-edimm2.2.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 6f0777ee6cd6..4369d783dade 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-engicam-icore-mx8mm-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-edimm2.2.dts b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-edimm2.2.dts
new file mode 100644
index 000000000000..a8afc0998fcd
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-edimm2.2.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 NXP
+ * Copyright (c) 2019 Engicam srl
+ * Copyright (c) 2020 Amarula Solutions(India)
+ */
+
+/dts-v1/;
+#include "imx8mm.dtsi"
+#include "imx8mm-engicam-edimm2.2.dtsi"
+#include "imx8mm-engicam-icore-mx8mm.dtsi"
+
+/ {
+	model = "Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit";
+	compatible = "engicam,icore-mx8mm-edimm2.2", "engicam,icore-mx8mm",
+		     "fsl,imx8mm";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+};
-- 
2.25.1

