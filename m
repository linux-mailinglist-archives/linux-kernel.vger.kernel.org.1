Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD3C2CBCA2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388746AbgLBMOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgLBMO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:14:26 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E7EC061A4B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 04:13:18 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id hk16so877387pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 04:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mufF4hRgH4PDLGAGuI3iYOURtYD7y9AqiPoup7RwkJ8=;
        b=NmR75SXgoGoeKXN8n3vLL4WGPGcjQOXDjUZ0KyejZtTABMoXFiCIdliRBV9v7HehY5
         qe+Lmr42/pQhIWGTE5x55FMFWYO0AEh3Tz/VGLEUUK0AaHSJCMlo8iKjz9Az8yYHQoql
         6VjWi/fID1/alaq7Ty5qOWLEOrHF0aAh8wQs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mufF4hRgH4PDLGAGuI3iYOURtYD7y9AqiPoup7RwkJ8=;
        b=aGuYL1qLrHkkpjRxgn+JdshkbULBA4o0KIlb/z0Q6JdoaeKjKEtd5jySkk3I1KwfoH
         StsuvXPxMlF7xXLHS/AlIhSipNkr6PhRAnn8WyvZ6kNe8LpZaqR4Icm8eS58rVy1lf6S
         1iJODxtRrTBCvZhaoW7dGO5sZ3kkjUL4XJfxvMPZmolEQdX3fOsF1svxdCaVG1h+CdTj
         jfJiZnUx9uATU/ZL80kljza36jPsOFl08+WERiZlxjhHn0EU+txUVxU455qrA9NGJEbJ
         e8U/se9LLvcWerx+ZUt9TXPCJ7b8SWSikAvkzPwirmR4wzMyvUpLWEIAa1YmF/1NjyjI
         /a6Q==
X-Gm-Message-State: AOAM5317KF23eNMu10jorPmHgsyZSxF1JcJ6RMXQuvWUzq5ic3svdSRW
        Ov0Cjmh2SlvTg0n3AXLSXdIFYA==
X-Google-Smtp-Source: ABdhPJwcB8XUFxscy78aQv3HGd9roxpS/vsoa5gr3WXBx6vXc6k/DyrYN52BS9HBdgtR6kENYcr0RA==
X-Received: by 2002:a17:902:b717:b029:d9:e816:fd0b with SMTP id d23-20020a170902b717b02900d9e816fd0bmr2327604pls.50.1606911198101;
        Wed, 02 Dec 2020 04:13:18 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:fd53:e9ba:b313:1b1d])
        by smtp.gmail.com with ESMTPSA id b37sm1951315pgl.31.2020.12.02.04.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:13:17 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Matteo Lisi <matteo.lisi@engicam.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 03/10] arm64: dts: imx: Add Engicam EDIMM2.2 Starter Kit
Date:   Wed,  2 Dec 2020 17:42:34 +0530
Message-Id: <20201202121241.109952-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202121241.109952-1-jagan@amarulasolutions.com>
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Engicam EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive
Evaluation Board.

Genaral features:
- LCD 7" C.Touch
- microSD slot
- Ethernet 1Gb
- Wifi/BT
- 2x LVDS Full HD interfaces
- 3x USB 2.0
- 1x USB 3.0
- HDMI Out
- Mini PCIe
- MIPI CSI
- 2x CAN
- Audio Out

SOM's like i.Core MX8M Mini needs to mount on top of this Evaluation
board for creating complete i.Core MX8M Mini EDIMM2.2 Starter Kit.

Add support for it.

Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../dts/freescale/imx8mm-engicam-common.dtsi  | 24 +++++++++++++++++++
 .../freescale/imx8mm-engicam-edimm2.2.dtsi    |  7 ++++++
 2 files changed, 31 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-common.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-common.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-engicam-common.dtsi
new file mode 100644
index 000000000000..67c1a3fe26bc
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-common.dtsi
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutions(India)
+ */
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+/* SD */
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
+	cd-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+	max-frequency = <50000000>;
+	bus-width = <4>;
+	no-1-8-v;
+	pm-ignore-notify;
+	keep-power-in-suspend;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi
new file mode 100644
index 000000000000..294df07289a2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutions(India)
+ */
+
+#include "imx8mm-engicam-common.dtsi"
-- 
2.25.1

