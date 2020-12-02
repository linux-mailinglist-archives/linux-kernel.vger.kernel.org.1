Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13082CBCA9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388817AbgLBMOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388796AbgLBMOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:14:42 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42939C061A54
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 04:13:39 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id t7so641825pfh.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 04:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aN+C5XQENQZ7PtixMGe2RSKK4cDKAHrNU44ZbK6c5Dk=;
        b=ewhJM7VVfBbiLXxcqR7Tye3PJM4h8qQjh6o9MQsaOtT9f05QDssdDlYXitidwdeL/E
         lU6DWVx4rAGo71BaKxCKI7b5W03O/vZXHJymRswJj4C916cLhJw9p3rbq3TsuEvut2nz
         4N4MFoSl8oOivG2IhbEgrpTY0D33I8/1dUQ3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aN+C5XQENQZ7PtixMGe2RSKK4cDKAHrNU44ZbK6c5Dk=;
        b=o8dA84EY1qk4NeWWLbl/KaQoo35Y/AaVeRpGZG+j3SaHtJqzIZxaCQ/ySUrknskXx7
         kbws8sxwtoRcrHAEJ0pfxfZ60ooK6VyVhNXnZo+eoUylXI02QcVaXkN8OB4Rq/47Of4y
         No/1Zpm+L6IPL4EcLLnighVX2COq/I//WcqZQHgvKIYa8CGcZrQ2LLwS0JNCV9nSUV4W
         V5NjjFVZ3XG7SU3q6+lQG+cMqi8l5byvyCnC9q3n3CCJs2M+d3w92hGFiqZ+t4tSCSBb
         q6PJqCQNmHEZzTx+1PY5LkBfmkoSkWQAlBK8acH5NQaME/agDI/gI+Tml0qjGBiYn/KV
         pF3Q==
X-Gm-Message-State: AOAM532glHm49RI4d7RzmmcaxvCrbZhF8cr9lhLVE0vtA561aeNWLY/b
        HKW8byWay8qt1ewKKBg60eT/UUAl7gFINdEo
X-Google-Smtp-Source: ABdhPJwLkTswKg8iQSMiDQUwVTnUkSFCv5sXMPRyt/MFmbeETyDC9KDGXoY5GXjYK8ny6CIiQBSKRQ==
X-Received: by 2002:a63:b554:: with SMTP id u20mr825574pgo.249.1606911218794;
        Wed, 02 Dec 2020 04:13:38 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:fd53:e9ba:b313:1b1d])
        by smtp.gmail.com with ESMTPSA id b37sm1951315pgl.31.2020.12.02.04.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:13:37 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Matteo Lisi <matteo.lisi@engicam.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 08/10] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini C.TOUCH 2.0
Date:   Wed,  2 Dec 2020 17:42:39 +0530
Message-Id: <20201202121241.109952-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202121241.109952-1-jagan@amarulasolutions.com>
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.

C.TOUCH 2.0 is a general purpose carrier board with capacitive
touch interface support.

i.Core MX8M Mini needs to mount on top of this Carrier board for
creating complete i.Core MX8M Mini C.TOUCH 2.0 board.

Add support for it.

Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../imx8mm-engicam-icore-mx8mm-ctouch2.dts    | 21 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 4369d783dade..8191db4c64fa 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-engicam-icore-mx8mm-ctouch2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-engicam-icore-mx8mm-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts
new file mode 100644
index 000000000000..aa3c03ad3109
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts
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
+#include "imx8mm-engicam-ctouch2.dtsi"
+#include "imx8mm-engicam-icore-mx8mm.dtsi"
+
+/ {
+	model = "Engicam i.Core MX8M Mini C.TOUCH 2.0";
+	compatible = "engicam,icore-mx8mm-ctouch2", "engicam,icore-mx8mm",
+		     "fsl,imx8mm";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+};
-- 
2.25.1

