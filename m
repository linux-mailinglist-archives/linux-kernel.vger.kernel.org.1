Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D723A2FB6E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbhASJZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 04:25:03 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18664 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbhASI4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:56:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60069e9f0000>; Tue, 19 Jan 2021 00:55:59 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Jan
 2021 08:55:54 +0000
Received: from jckuo-lt.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 19 Jan 2021 08:55:51 +0000
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH v6 01/15] clk: tegra: Add PLLE HW power sequencer control
Date:   Tue, 19 Jan 2021 16:55:32 +0800
Message-ID: <20210119085546.725005-2-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119085546.725005-1-jckuo@nvidia.com>
References: <20210119085546.725005-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611046559; bh=aqq1ADcIPS6bW54NhwLM4/AOdKqJTgGye7vxJe3z3t4=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=HjVJzNtJhHmpGInBh4DKGoy6a4DSoYMmlpsN5j2IW1OIG6dEVO+T8shAXVhjZTBGU
         IWMOqfhSSeF1nZu2QLQPofGm/6bYNOZvaJicQ8+v0cxx7doo5RneeeAldaVscXhBXs
         sq10a8I5mG4ZnrsRh/14xwwmUjcjNn3gARunYy+RHixaKMUZMchO5FBONvpuS86oP2
         KcWV8JYbhctm0IlzcHcvxgpz8X9c4F0lsAYaDBZKvi7tjYgwDg7bcP6qUwGb267Nws
         JgsIGwFJBQnHspnM0UjwVYLO01QVqkQPUxYcrfuz1eWywxGuVf/FGDiVXrgOYWdobE
         Sh6v2r85pGxpg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PLLE has a hardware power sequencer logic which is a state machine
that can power on/off PLLE without any software intervention. The
sequencer has two inputs, one from XUSB UPHY PLL and the other from
SATA UPHY PLL. PLLE provides reference clock to XUSB and SATA UPHY
PLLs. When both of the downstream PLLs are powered-off, PLLE hardware
power sequencer will automatically power off PLLE for power saving.

XUSB and SATA UPHY PLLs also have their own hardware power sequencer
logic. XUSB UPHY PLL is shared between XUSB SuperSpeed ports and PCIE
controllers. The XUSB UPHY PLL hardware power sequencer has inputs
from XUSB and PCIE. When all of the XUSB SuperSpeed ports and PCIE
controllers are in low power state, XUSB UPHY PLL hardware power
sequencer automatically power off PLL and flags idle to PLLE hardware
power sequencer. Similar applies to SATA UPHY PLL.

PLLE hardware power sequencer has to be enabled after both downstream
sequencers are enabled.

This commit adds two helper functions:
1. tegra210_plle_hw_sequence_start() for XUSB PADCTL driver to enable
   PLLE hardware sequencer at proper time.

2. tegra210_plle_hw_sequence_is_enabled() for XUSB PADCTL driver to
   check whether PLLE hardware sequencer has been enabled or not.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
v6:
   no change
v5: no change
v4:
   update copyright strings
v3:
   rename 'val' with 'value

 drivers/clk/tegra/clk-tegra210.c | 53 +++++++++++++++++++++++++++++++-
 include/linux/clk/tegra.h        |  4 ++-
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra=
210.c
index 68cbb98af567..b9099012dc7b 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2012-2014 NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2012-2020 NVIDIA CORPORATION.  All rights reserved.
  */
=20
 #include <linux/io.h>
@@ -403,6 +403,14 @@ static unsigned long tegra210_input_freq[] =3D {
 #define PLLRE_BASE_DEFAULT_MASK		0x1c000000
 #define PLLRE_MISC0_WRITE_MASK		0x67ffffff
=20
+/* PLLE */
+#define PLLE_MISC_IDDQ_SW_CTRL		(1 << 14)
+#define PLLE_AUX_USE_LOCKDET		(1 << 3)
+#define PLLE_AUX_SS_SEQ_INCLUDE		(1 << 31)
+#define PLLE_AUX_ENABLE_SWCTL		(1 << 4)
+#define PLLE_AUX_SS_SWCTL		(1 << 6)
+#define PLLE_AUX_SEQ_ENABLE		(1 << 24)
+
 /* PLLX */
 #define PLLX_USE_DYN_RAMP		1
 #define PLLX_BASE_LOCK			(1 << 27)
@@ -489,6 +497,49 @@ static unsigned long tegra210_input_freq[] =3D {
 #define PLLU_MISC0_WRITE_MASK		0xbfffffff
 #define PLLU_MISC1_WRITE_MASK		0x00000007
=20
+bool tegra210_plle_hw_sequence_is_enabled(void)
+{
+	u32 value;
+
+	value =3D readl_relaxed(clk_base + PLLE_AUX);
+	if (value & PLLE_AUX_SEQ_ENABLE)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(tegra210_plle_hw_sequence_is_enabled);
+
+int tegra210_plle_hw_sequence_start(void)
+{
+	u32 value;
+
+	if (tegra210_plle_hw_sequence_is_enabled())
+		return 0;
+
+	/* skip if PLLE is not enabled yet */
+	value =3D readl_relaxed(clk_base + PLLE_MISC0);
+	if (!(value & PLLE_MISC_LOCK))
+		return -EIO;
+
+	value &=3D ~PLLE_MISC_IDDQ_SW_CTRL;
+	writel_relaxed(value, clk_base + PLLE_MISC0);
+
+	value =3D readl_relaxed(clk_base + PLLE_AUX);
+	value |=3D (PLLE_AUX_USE_LOCKDET | PLLE_AUX_SS_SEQ_INCLUDE);
+	value &=3D ~(PLLE_AUX_ENABLE_SWCTL | PLLE_AUX_SS_SWCTL);
+	writel_relaxed(value, clk_base + PLLE_AUX);
+
+	fence_udelay(1, clk_base);
+
+	value |=3D PLLE_AUX_SEQ_ENABLE;
+	writel_relaxed(value, clk_base + PLLE_AUX);
+
+	fence_udelay(1, clk_base);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra210_plle_hw_sequence_start);
+
 void tegra210_xusb_pll_hw_control_enable(void)
 {
 	u32 val;
diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index eb016fc9cc0b..f7ff722a03dd 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2012-2020, NVIDIA CORPORATION.  All rights reserved.
  */
=20
 #ifndef __LINUX_CLK_TEGRA_H_
@@ -123,6 +123,8 @@ static inline void tegra_cpu_clock_resume(void)
 }
 #endif
=20
+extern int tegra210_plle_hw_sequence_start(void);
+extern bool tegra210_plle_hw_sequence_is_enabled(void);
 extern void tegra210_xusb_pll_hw_control_enable(void);
 extern void tegra210_xusb_pll_hw_sequence_start(void);
 extern void tegra210_sata_pll_hw_control_enable(void);
--=20
2.25.1

