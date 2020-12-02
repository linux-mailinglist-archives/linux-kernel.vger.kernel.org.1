Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2822CBCB0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgLBMOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388812AbgLBMOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:14:44 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF9EC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 04:13:47 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b10so1131872pfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 04:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QuR5732EKnWnACHGjHrRMgKt9aptcaHTLmtv3MjcXKI=;
        b=rWnIUWBlvRazjwTAjM+ni8ZdZThlxyvOqAp76M4uYKtrZgCRHnQp2bVCBU3k8l7VIw
         7FNx5SZT5ja8/8YDDhOuGpKr0Z8SvnTFFEcZfbsLNMKsRwvQOaWpifLDQA94C1oU1J9t
         FNWmNYHNxqd+BnQOUMPI0sPaASPdDFjyIfrUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QuR5732EKnWnACHGjHrRMgKt9aptcaHTLmtv3MjcXKI=;
        b=ngRL0VXgG1MU78Jl+zlRpJk6Cmm5zPX5/6bSNXB8xYIWQzRinFWQ6Q3pVfrEfeI1Ek
         YjDQj3+1zJhFzh8u2DVBfjnYMxiJDR8zTYkNiEYJlBDfdaazX9WUbCiS/wotLj1EocRg
         lQx2MduNe20f/4bilU7vpEe/Jl9cq1/ztRpmJgbn18SyOUkRF0OlKT+ejI8jrqUKs6Eu
         JafZVzmoqA6YZKBT9j2dgHbPFSE+1mFLGRGRKv8JApyE47rSI1idTa1bcZd/BePMVghz
         ZxJfmZ5iGKAYotORVDG1IOWnjNDDLQoamcskdtXBmx31vx2Q7BmjehpaSFjHmjeCXwYf
         BZOQ==
X-Gm-Message-State: AOAM532oC96vvwUnIVscqbqC4thtcWL9FE+pQ9ZSMex8CqglqH2qx/bR
        1g8agfbmd+FGshrIJP7wJHLVZw==
X-Google-Smtp-Source: ABdhPJxe88JHyI78KLC3da+lMiK8RIlBWcer15a46QBVqC486lwIqzQFpHxQ80P9v90FAAW/4Cpjyw==
X-Received: by 2002:a62:e416:0:b029:197:eed6:c8b9 with SMTP id r22-20020a62e4160000b0290197eed6c8b9mr2612796pfh.57.1606911226843;
        Wed, 02 Dec 2020 04:13:46 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:fd53:e9ba:b313:1b1d])
        by smtp.gmail.com with ESMTPSA id b37sm1951315pgl.31.2020.12.02.04.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:13:46 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Matteo Lisi <matteo.lisi@engicam.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 10/10] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini C.TOUCH 2.0 10.1" OF
Date:   Wed,  2 Dec 2020 17:42:41 +0530
Message-Id: <20201202121241.109952-11-jagan@amarulasolutions.com>
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

10.1" OF is a capacitive touch 10.1" Open Frame panel solutions.

i.Core MX8M Mini needs to mount on top of C.TOUCH 2.0 carrier with
pluged 10.1" OF for creating complete i.Core MX8M Mini C.TOUCH 2.0
10.1" Open Frame solution board.

Add support for it.

Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 ...mx8mm-engicam-icore-mx8mm-ctouch2-of10.dts | 21 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2-of10.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 8191db4c64fa..9725bbc0f268 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -31,6 +31,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-engicam-icore-mx8mm-ctouch2.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-engicam-icore-mx8mm-ctouch2-of10.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-engicam-icore-mx8mm-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2-of10.dts b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2-of10.dts
new file mode 100644
index 000000000000..0124ba5ec69c
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2-of10.dts
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
+	model = "Engicam i.Core MX8M Mini C.TOUCH 2.0 10.1\" Open Frame";
+	compatible = "engicam,icore-mx8mm-ctouch2-of10", "engicam,icore-mx8mm",
+		     "fsl,imx8mm";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+};
-- 
2.25.1

