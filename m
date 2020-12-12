Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0012D843A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 05:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438081AbgLLEHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 23:07:21 -0500
Received: from relay5.mymailcheap.com ([159.100.248.207]:33933 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgLLEG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 23:06:26 -0500
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 484E0260EC;
        Sat, 12 Dec 2020 04:05:30 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id 2AC883F207;
        Sat, 12 Dec 2020 05:03:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 500FF2A36D;
        Fri, 11 Dec 2020 23:03:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1607745830;
        bh=5eDQy4yF4Sdl2nAb+gO4jhBQE5ZQZlb+o4Ar6mAQYHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KgA2Q6Frk1Xbv4mnykczaO7s1xmE6aCUrnTO085q5StSze8k4Mp6E0vJHDTH/8ezO
         yVcF3suiosJ/rhj/vwdj8rGDOz2PZCOe7Ew9Bxs3FRqKDYsp8awKrQhLAE0yZbId9K
         FhOycrIbnsUMKsrxc7+SevU/lgRSPSPXllt/vxww=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9tMZVbYDafCC; Fri, 11 Dec 2020 23:03:48 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Fri, 11 Dec 2020 23:03:48 -0500 (EST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 1729C42F57;
        Sat, 12 Dec 2020 04:03:47 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="G+37P/cA";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.161.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 4F5DA42F57;
        Sat, 12 Dec 2020 04:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1607745821; bh=5eDQy4yF4Sdl2nAb+gO4jhBQE5ZQZlb+o4Ar6mAQYHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+37P/cAJ9qc4ishnhJZFAYjiE+Neuui6+qWICxAXA32YJ7A2ir9yN5pt8x9so7+g
         qDQ1Pgj9wa+XH7Wh4CWQrtibiwd+T9KISmna5f01LKbRiFoogE286Sv5qX24FFLwhQ
         t0mNtaE1pS0S2eBbISqZaN+8ywulspkWNSfpIzsw=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: [RFC PATCH 03/12] clk: sunxi-ng: add CCU driver for V831/V833
Date:   Sat, 12 Dec 2020 12:03:09 +0800
Message-Id: <20201212040318.3640236-2-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201212040157.3639864-1-icenowy@aosc.io>
References: <20201212040157.3639864-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: mail20.mymailcheap.com
X-Spamd-Result: default: False [6.40 / 20.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.161.2:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         DMARC_NA(0.00)[aosc.io];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Queue-Id: 1729C42F57
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V831/V833 are new chips from Allwinner targeting camera market. The
difference between them is similar to V3s/V3, the former one is a
reduced-pin package with co-packaged DDR2 and the latter one is a BGA
package w/o DRAM packaged in.

Add a CCU driver for them. As the user manual didn't have marks for
different chips (V831 and V833 shares the same user manual file), only
implementing a full-functional CCU driver with V833 compatible.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
There's a PLL that is called PLL_UNI in the user manual. However a duck
test shows that it is quite similar to PLL_PERI1 on other SoCs: it
functions as parent to some peripherals, occupies the same register
offset with PLL_PERI1 and have the same clock rate configuration with
PLL_PERI1. Here I called it as pll-uni to follow the official document,
but I doubt whether we should call it pll-periph1 to be consistent with
other SoCs.

 drivers/clk/sunxi-ng/Kconfig          |   5 +
 drivers/clk/sunxi-ng/Makefile         |   1 +
 drivers/clk/sunxi-ng/ccu-sun8i-v833.c | 930 ++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-v833.h |  46 ++
 4 files changed, 982 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-v833.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-v833.h

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index ce5f5847d5d3..eb038d0f48d7 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -77,6 +77,11 @@ config SUN8I_V3S_CCU
 	default MACH_SUN8I
 	depends on MACH_SUN8I || COMPILE_TEST
 
+config SUN8I_V833_CCU
+	bool "Support for the Allwinner V833 CCU"
+	default MACH_SUN8I
+	depends on MACH_SUN8I || COMPILE_TEST
+
 config SUN8I_DE2_CCU
 	bool "Support for the Allwinner SoCs DE2 CCU"
 	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 3eb5cff40eac..dd33aba983bb 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_SUN8I_A33_CCU)	+= ccu-sun8i-a33.o
 obj-$(CONFIG_SUN8I_A83T_CCU)	+= ccu-sun8i-a83t.o
 obj-$(CONFIG_SUN8I_H3_CCU)	+= ccu-sun8i-h3.o
 obj-$(CONFIG_SUN8I_V3S_CCU)	+= ccu-sun8i-v3s.o
+obj-$(CONFIG_SUN8I_V833_CCU)	+= ccu-sun8i-v833.o
 obj-$(CONFIG_SUN8I_DE2_CCU)	+= ccu-sun8i-de2.o
 obj-$(CONFIG_SUN8I_R_CCU)	+= ccu-sun8i-r.o
 obj-$(CONFIG_SUN8I_R40_CCU)	+= ccu-sun8i-r40.o
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v833.c b/drivers/clk/sunxi-ng/ccu-sun8i-v833.c
new file mode 100644
index 000000000000..c60178035117
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v833.c
@@ -0,0 +1,930 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Icenowy Zheng <icenowy@aosc.io>
+ * Based on the H616 CCU driver, which is:
+ *   Copyright (c) 2020 Arm Ltd.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+#include "ccu_common.h"
+#include "ccu_reset.h"
+
+#include "ccu_div.h"
+#include "ccu_gate.h"
+#include "ccu_mp.h"
+#include "ccu_mult.h"
+#include "ccu_nk.h"
+#include "ccu_nkm.h"
+#include "ccu_nkmp.h"
+#include "ccu_nm.h"
+
+#include "ccu-sun8i-v833.h"
+
+/*
+ * The CPU PLL is actually NP clock, with P being /1, /2 or /4. However
+ * P should only be used for output frequencies lower than 288 MHz.
+ *
+ * For now we can just model it as a multiplier clock, and force P to /1.
+ *
+ * The M factor is present in the register's description, but not in the
+ * frequency formula, and it's documented as "M is only used for backdoor
+ * testing", so it's not modelled and then force to 0.
+ */
+#define SUN8I_V833_PLL_CPUX_REG	0x000
+static struct ccu_mult pll_cpux_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(28),
+	.mult		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
+	.common		= {
+		.reg		= 0x000,
+		.hw.init	= CLK_HW_INIT("pll-cpux", "osc24M",
+					      &ccu_mult_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+/* Some PLLs are input * N / div1 / P. Model them as NKMP with no K */
+#define SUN8I_V833_PLL_DDR0_REG	0x010
+static struct ccu_nkmp pll_ddr0_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
+	.common		= {
+		.reg		= 0x010,
+		.hw.init	= CLK_HW_INIT("pll-ddr0", "osc24M",
+					      &ccu_nkmp_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+#define SUN8I_V833_PLL_PERIPH0_REG	0x020
+static struct ccu_nkmp pll_periph0_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
+	.fixed_post_div	= 2,
+	.common		= {
+		.reg		= 0x020,
+		.features	= CCU_FEATURE_FIXED_POSTDIV,
+		.hw.init	= CLK_HW_INIT("pll-periph0", "osc24M",
+					      &ccu_nkmp_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+#define SUN8I_V833_PLL_UNI_REG		0x028
+static struct ccu_nkmp pll_uni_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
+	.fixed_post_div	= 2,
+	.common		= {
+		.reg		= 0x028,
+		.features	= CCU_FEATURE_FIXED_POSTDIV,
+		.hw.init	= CLK_HW_INIT("pll-uni", "osc24M",
+					      &ccu_nkmp_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+/*
+ * For Video PLLs, the output divider is described as "used for testing"
+ * in the user manual. So it's not modelled and forced to 0.
+ */
+#define SUN8I_V833_PLL_VIDEO0_REG	0x040
+static struct ccu_nm pll_video0_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.fixed_post_div	= 4,
+	.min_rate	= 288000000,
+	.max_rate	= 2400000000UL,
+	.common		= {
+		.reg		= 0x040,
+		.features	= CCU_FEATURE_FIXED_POSTDIV,
+		.hw.init	= CLK_HW_INIT("pll-video0", "osc24M",
+					      &ccu_nm_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+/*
+ * The Audio PLL is supposed to have 3 outputs: 2 fixed factors from
+ * the base (2x and 4x), and one variable divider (the one true pll audio).
+ *
+ * We don't have any need for the variable divider for now, so we just
+ * hardcode it to match with the clock names.
+ */
+#define SUN8I_V833_PLL_AUDIO_REG		0x078
+
+static struct ccu_sdm_setting pll_audio_sdm_table[] = {
+	{ .rate = 541900800, .pattern = 0xc001288d, .m = 1, .n = 22 },
+	{ .rate = 589824000, .pattern = 0xc00126e9, .m = 1, .n = 24 },
+};
+
+static struct ccu_nm pll_audio_base_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.sdm		= _SUNXI_CCU_SDM(pll_audio_sdm_table,
+					 BIT(24), 0x178, BIT(31)),
+	.common		= {
+		.features	= CCU_FEATURE_SIGMA_DELTA_MOD,
+		.reg		= 0x078,
+		.hw.init	= CLK_HW_INIT("pll-audio-base", "osc24M",
+					      &ccu_nm_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+#define SUN8I_V833_PLL_CSI_REG		0x0e0
+static struct ccu_nkmp pll_csi_clk = {
+	.enable		= BIT(31),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
+	.common		= {
+		.reg		= 0x0e0,
+		.hw.init	= CLK_HW_INIT("pll-csi", "osc24M",
+					      &ccu_nkmp_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
+
+static const char * const cpux_parents[] = { "osc24M", "osc32k",
+					"iosc", "pll-cpux", "pll-periph0" };
+static SUNXI_CCU_MUX(cpux_clk, "cpux", cpux_parents,
+		     0x500, 24, 3, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+static SUNXI_CCU_M(axi_clk, "axi", "cpux", 0x500, 0, 2, 0);
+static struct clk_div_table cpux_apb_div_table[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 1, .div = 2 },
+	{ .val = 2, .div = 4 },
+	{ .val = 3, .div = 4 },
+	{ /* Sentinel */ },
+};
+static SUNXI_CCU_DIV_TABLE(cpux_apb_clk, "cpux-apb", "cpux",
+			   0x500, 8, 2, cpux_apb_div_table, 0);
+
+static const char * const psi_ahb1_ahb2_parents[] = { "osc24M", "osc32k",
+						      "iosc", "pll-periph0" };
+static SUNXI_CCU_MP_WITH_MUX(psi_ahb1_ahb2_clk, "psi-ahb1-ahb2",
+			     psi_ahb1_ahb2_parents,
+			     0x510,
+			     0, 2,	/* M */
+			     8, 2,	/* P */
+			     24, 2,	/* mux */
+			     0);
+
+static const char * const ahb3_apb1_apb2_parents[] = { "osc24M", "osc32k",
+						       "psi-ahb1-ahb2",
+						       "pll-periph0" };
+static SUNXI_CCU_MP_WITH_MUX(ahb3_clk, "ahb3", ahb3_apb1_apb2_parents, 0x51c,
+			     0, 2,	/* M */
+			     8, 2,	/* P */
+			     24, 2,	/* mux */
+			     0);
+
+static SUNXI_CCU_MP_WITH_MUX(apb1_clk, "apb1", ahb3_apb1_apb2_parents, 0x520,
+			     0, 2,	/* M */
+			     8, 2,	/* P */
+			     24, 2,	/* mux */
+			     0);
+
+static SUNXI_CCU_MP_WITH_MUX(apb2_clk, "apb2", ahb3_apb1_apb2_parents, 0x524,
+			     0, 2,	/* M */
+			     8, 2,	/* P */
+			     24, 2,	/* mux */
+			     0);
+
+static const char * const de_parents[] = { "pll-uni", "pll-uni-2x", "pll-periph0-2x" };
+static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents, 0x600,
+				       0, 4,	/* M */
+				       24, 1,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+
+static SUNXI_CCU_GATE(bus_de_clk, "bus-de", "psi-ahb1-ahb2",
+		      0x60c, BIT(0), 0);
+
+static SUNXI_CCU_M_WITH_MUX_GATE(g2d_clk, "g2d", de_parents, 0x630,
+				       0, 4,	/* M */
+				       24, 1,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+
+static SUNXI_CCU_GATE(bus_g2d_clk, "bus-g2d", "psi-ahb1-ahb2",
+		      0x63c, BIT(0), 0);
+
+static const char * const ce_parents[] = { "osc24M", "pll-periph0-2x" };
+static SUNXI_CCU_MP_WITH_MUX_GATE(ce_clk, "ce", ce_parents, 0x680,
+					0, 4,	/* M */
+					8, 2,	/* N */
+					24, 1,	/* mux */
+					BIT(31),/* gate */
+					0);
+
+static SUNXI_CCU_GATE(bus_ce_clk, "bus-ce", "psi-ahb1-ahb2",
+		      0x68c, BIT(0), 0);
+
+static const char * const ve_eise_parents[] = { "pll-uni", "pll-uni-2x",
+						"pll-periph0", "pll-video0-4x" };
+static SUNXI_CCU_M_WITH_MUX_GATE(ve_clk, "ve", ve_eise_parents, 0x690,
+				       0, 3,	/* M */
+				       24, 2,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+
+static SUNXI_CCU_GATE(bus_ve_clk, "bus-ve", "psi-ahb1-ahb2",
+		      0x69c, BIT(0), 0);
+
+static SUNXI_CCU_M_WITH_MUX_GATE(eise_clk, "eise", ve_eise_parents, 0x6d0,
+				       0, 3,	/* M */
+				       24, 2,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+
+static SUNXI_CCU_GATE(bus_eise_clk, "bus-eise", "psi-ahb1-ahb2",
+		      0x6dc, BIT(0), 0);
+
+static const char * const npu_parents[] = { "pll-periph0", "pll-periph0-2x",
+					    "pll-uni", "pll-uni-2x",
+					    "pll-video-4x", "pll-cpu",
+					    "pll-csi" };
+static SUNXI_CCU_M_WITH_MUX_GATE(npu_clk, "npu", npu_parents, 0x6e0,
+				       0, 3,	/* M */
+				       24, 2,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+
+/*
+ * The bus that NPU is located is not specified on the user manual. Parent
+ * clock here is a guess based on the clock register is among other AHB1
+ * clocks.
+ */
+static SUNXI_CCU_GATE(bus_npu_clk, "bus-npu", "psi-ahb1-ahb2",
+		      0x6ec, BIT(0), 0);
+
+static SUNXI_CCU_GATE(bus_dma_clk, "bus-dma", "psi-ahb1-ahb2",
+		      0x70c, BIT(0), 0);
+
+static SUNXI_CCU_GATE(bus_hstimer_clk, "bus-hstimer", "psi-ahb1-ahb2",
+		      0x73c, BIT(0), 0);
+
+static SUNXI_CCU_GATE(avs_clk, "avs", "osc24M", 0x740, BIT(31), 0);
+
+static SUNXI_CCU_GATE(bus_dbg_clk, "bus-dbg", "psi-ahb1-ahb2",
+		      0x78c, BIT(0), 0);
+
+static SUNXI_CCU_GATE(bus_psi_clk, "bus-psi", "psi-ahb1-ahb2",
+		      0x79c, BIT(0), 0);
+
+static SUNXI_CCU_GATE(bus_pwm_clk, "bus-pwm", "apb1", 0x7ac, BIT(0), 0);
+
+/*
+ * BSP kernel declares an IOMMU bus gate at 0x7bc, however the user manual
+ * does not mention it. By trying to poke registers, even if 0x7bc is 0,
+ * the IOMMU registers are accessible.
+ */
+
+static const char * const dram_parents[] = { "pll-ddr0", "pll-periph0-2x" };
+static struct ccu_div dram_clk = {
+	.div		= _SUNXI_CCU_DIV(0, 2),
+	.mux		= _SUNXI_CCU_MUX(24, 2),
+	.common	= {
+		.reg		= 0x800,
+		.hw.init	= CLK_HW_INIT_PARENTS("dram",
+						      dram_parents,
+						      &ccu_div_ops,
+						      CLK_IS_CRITICAL),
+	},
+};
+
+static SUNXI_CCU_GATE(mbus_dma_clk, "mbus-dma", "psi-ahb1-ahb2",
+		      0x804, BIT(0), 0);
+static SUNXI_CCU_GATE(mbus_ve_clk, "mbus-ve", "psi-ahb1-ahb2",
+		      0x804, BIT(1), 0);
+static SUNXI_CCU_GATE(mbus_ce_clk, "mbus-ce", "psi-ahb1-ahb2",
+		      0x804, BIT(2), 0);
+static SUNXI_CCU_GATE(mbus_ts_clk, "mbus-csi", "psi-ahb1-ahb2",
+		      0x804, BIT(8), 0);
+static SUNXI_CCU_GATE(mbus_nand_clk, "mbus-isp", "psi-ahb1-ahb2",
+		      0x804, BIT(9), 0);
+static SUNXI_CCU_GATE(mbus_g2d_clk, "mbus-g2d", "psi-ahb1-ahb2",
+		      0x804, BIT(10), 0);
+static SUNXI_CCU_GATE(mbus_eise_clk, "mbus-eise", "psi-ahb1-ahb2",
+		      0x804, BIT(23), 0);
+static SUNXI_CCU_GATE(mbus_vdpo_clk, "mbus-vdpo", "psi-ahb1-ahb2",
+		      0x804, BIT(27), 0);
+
+static SUNXI_CCU_GATE(bus_dram_clk, "bus-dram", "psi-ahb1-ahb2",
+		      0x80c, BIT(0), CLK_IS_CRITICAL);
+
+static const char * const mmc_parents[] = { "osc24M", "pll-periph0-2x",
+					    "pll-uni-2x" };
+static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc0_clk, "mmc0", mmc_parents, 0x830,
+					  0, 4,		/* M */
+					  8, 2,		/* N */
+					  24, 2,	/* mux */
+					  BIT(31),	/* gate */
+					  2,		/* post-div */
+					  0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1", mmc_parents, 0x834,
+					  0, 4,		/* M */
+					  8, 2,		/* N */
+					  24, 2,	/* mux */
+					  BIT(31),	/* gate */
+					  2,		/* post-div */
+					  0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2", mmc_parents, 0x838,
+					  0, 4,		/* M */
+					  8, 2,		/* N */
+					  24, 2,	/* mux */
+					  BIT(31),	/* gate */
+					  2,		/* post-div */
+					  0);
+
+static SUNXI_CCU_GATE(bus_mmc0_clk, "bus-mmc0", "ahb3", 0x84c, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_mmc1_clk, "bus-mmc1", "ahb3", 0x84c, BIT(1), 0);
+static SUNXI_CCU_GATE(bus_mmc2_clk, "bus-mmc2", "ahb3", 0x84c, BIT(2), 0);
+
+static SUNXI_CCU_GATE(bus_uart0_clk, "bus-uart0", "apb2", 0x90c, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_uart1_clk, "bus-uart1", "apb2", 0x90c, BIT(1), 0);
+static SUNXI_CCU_GATE(bus_uart2_clk, "bus-uart2", "apb2", 0x90c, BIT(2), 0);
+static SUNXI_CCU_GATE(bus_uart3_clk, "bus-uart3", "apb2", 0x90c, BIT(3), 0);
+
+static SUNXI_CCU_GATE(bus_i2c0_clk, "bus-i2c0", "apb2", 0x91c, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_i2c1_clk, "bus-i2c1", "apb2", 0x91c, BIT(1), 0);
+static SUNXI_CCU_GATE(bus_i2c2_clk, "bus-i2c2", "apb2", 0x91c, BIT(2), 0);
+static SUNXI_CCU_GATE(bus_i2c3_clk, "bus-i2c3", "apb2", 0x91c, BIT(3), 0);
+
+static const char * const spi_parents[] = { "osc24M", "pll-periph0",
+					    "pll-uni", "pll-periph0-2x",
+					    "pll-uni-2x" };
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(spi0_clk, "spi0", spi_parents, 0x940,
+					0, 4,	/* M */
+					8, 2,	/* N */
+					24, 3,	/* mux */
+					BIT(31),/* gate */
+					0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(spi1_clk, "spi1", spi_parents, 0x944,
+					0, 4,	/* M */
+					8, 2,	/* N */
+					24, 3,	/* mux */
+					BIT(31),/* gate */
+					0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(spi2_clk, "spi2", spi_parents, 0x948,
+					0, 4,	/* M */
+					8, 2,	/* N */
+					24, 3,	/* mux */
+					BIT(31),/* gate */
+					0);
+
+static SUNXI_CCU_GATE(bus_spi0_clk, "bus-spi0", "ahb3", 0x96c, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_spi1_clk, "bus-spi1", "ahb3", 0x96c, BIT(1), 0);
+static SUNXI_CCU_GATE(bus_spi2_clk, "bus-spi2", "ahb3", 0x96c, BIT(2), 0);
+
+static SUNXI_CCU_GATE(emac_25m_clk, "emac-25m", "ahb3", 0x970,
+		      BIT(31) | BIT(30), 0);
+
+static SUNXI_CCU_GATE(bus_emac0_clk, "bus-emac0", "ahb3", 0x97c, BIT(0), 0);
+
+static SUNXI_CCU_GATE(bus_gpadc_clk, "bus-gpadc", "apb1", 0x9ec, BIT(0), 0);
+
+static SUNXI_CCU_GATE(bus_ths_clk, "bus-ths", "apb1", 0x9fc, BIT(0), 0);
+
+static const char * const audio_parents[] = { "pll-audio", "pll-audio-2x",
+					      "pll-audio-4x" };
+static struct ccu_div i2s0_clk = {
+	.enable		= BIT(31),
+	.div		= _SUNXI_CCU_DIV_FLAGS(8, 2, CLK_DIVIDER_POWER_OF_TWO),
+	.mux		= _SUNXI_CCU_MUX(24, 2),
+	.common		= {
+		.reg		= 0xa10,
+		.hw.init	= CLK_HW_INIT_PARENTS("i2s0",
+						      audio_parents,
+						      &ccu_div_ops,
+						      CLK_SET_RATE_PARENT),
+	},
+};
+
+static struct ccu_div i2s1_clk = {
+	.enable		= BIT(31),
+	.div		= _SUNXI_CCU_DIV_FLAGS(8, 2, CLK_DIVIDER_POWER_OF_TWO),
+	.mux		= _SUNXI_CCU_MUX(24, 2),
+	.common		= {
+		.reg		= 0xa14,
+		.hw.init	= CLK_HW_INIT_PARENTS("i2s1",
+						      audio_parents,
+						      &ccu_div_ops,
+						      CLK_SET_RATE_PARENT),
+	},
+};
+
+static SUNXI_CCU_GATE(bus_i2s0_clk, "bus-i2s0", "apb1", 0xa2c, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_i2s1_clk, "bus-i2s1", "apb1", 0xa2c, BIT(1), 0);
+
+static SUNXI_CCU_M_WITH_MUX_GATE(audio_codec_1x_clk, "audio-codec-1x",
+				 audio_parents, 0xa50,
+				 0, 4,	/* M */
+				 24, 2,	/* mux */
+				 BIT(31),	/* gate */
+				 CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M_WITH_MUX_GATE(audio_codec_4x_clk, "audio-codec-4x",
+				 audio_parents, 0xa54,
+				 0, 4,	/* M */
+				 24, 2,	/* mux */
+				 BIT(31),	/* gate */
+				 CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_GATE(bus_audio_codec_clk, "bus-audio-codec", "apb1", 0xa5c,
+		BIT(0), 0);
+
+/*
+ * There are OHCI 12M clock source selection bits for the USB 2.0 port.
+ * We will force them to 0 (12M divided from 48M).
+ */
+#define SUN8I_V833_USB0_CLK_REG		0xa70
+
+static SUNXI_CCU_GATE(usb_ohci0_clk, "usb-ohci0", "osc12M", 0xa70, BIT(31), 0);
+static SUNXI_CCU_GATE(usb_phy0_clk, "usb-phy0", "osc24M", 0xa70, BIT(29), 0);
+
+static SUNXI_CCU_GATE(bus_ohci0_clk, "bus-ohci0", "ahb3", 0xa8c, BIT(0), 0);
+static SUNXI_CCU_GATE(bus_ehci0_clk, "bus-ehci0", "ahb3", 0xa8c, BIT(4), 0);
+static SUNXI_CCU_GATE(bus_otg_clk, "bus-otg", "ahb3", 0xa8c, BIT(8), 0);
+
+static const char * const mipi_dsi_dphy0_hs_parents[] = { "pll-video0",
+						      "pll-video0-4x" };
+static SUNXI_CCU_MP_WITH_MUX_GATE(mipi_dsi_dphy0_hs_clk, "mipi-dsi-dphy0-hs",
+				  mipi_dsi_dphy0_hs_parents,
+				  0xb20,
+				  0, 4,		/* M */
+				  8, 2,		/* N */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static const char * const mipi_dsi_host0_parents[] = { "pll-periph0",
+						       "pll-periph0-4x",
+						       "osc24M" };
+static SUNXI_CCU_M_WITH_MUX_GATE(mipi_dsi_host0_clk, "mipi-dsi-host0",
+				 mipi_dsi_host0_parents,
+				 0xb24,
+				 0, 4,		/* M */
+				 24, 2,		/* mux */
+				 BIT(31),	/* gate */
+				 0);
+
+static SUNXI_CCU_GATE(bus_mipi_dsi_clk, "bus-mipi-dsi", "ahb3", 0xb4c, BIT(0), 0);
+
+static SUNXI_CCU_GATE(bus_tcon_top_clk, "bus-tcon-top", "ahb3",
+		      0xb5c, BIT(0), 0);
+
+static const char * const tcon_lcd0_parents[] = { "pll-video0",
+						  "pll-video0-4x" };
+static SUNXI_CCU_MUX_WITH_GATE(tcon_lcd0_clk, "tcon-lcd0",
+			       tcon_lcd0_parents, 0xb60,
+			       24, 3,	/* mux */
+			       BIT(31),	/* gate */
+			       CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_GATE(bus_tcon_lcd0_clk, "bus-tcon-lcd0", "ahb3",
+		      0xb7c, BIT(0), 0);
+
+static const char * const csi_top_parents[] = { "pll-uni", "pll-uni-2x",
+						"pll-periph0", "pll-periph0-2x",
+						"pll-video0-4x", "pll-csi" };
+static SUNXI_CCU_M_WITH_MUX_GATE(csi_top_clk, "csi-top",
+				 csi_top_parents, 0xc04,
+				 0, 5,		/* M */
+				 24, 3,		/* mux */
+				 BIT(31),	/* gate */
+				 0);
+
+static const char * const csi_mclk_parents[] = { "osc24M", "pll-uni",
+						 "pll-uni-2x", "pll-periph0",
+						 "pll-periph0-2x", "pll-video0",
+						 "pll-csi" };
+
+static SUNXI_CCU_M_WITH_MUX_GATE(csi_mclk0_clk, "csi-mclk0",
+				 csi_mclk_parents, 0xc08,
+				 0, 5,		/* M */
+				 24, 3,		/* mux */
+				 BIT(31),	/* gate */
+				 0);
+
+static SUNXI_CCU_M_WITH_MUX_GATE(csi_mclk1_clk, "csi-mclk1",
+				 csi_mclk_parents, 0xc0c,
+				 0, 5,		/* M */
+				 24, 3,		/* mux */
+				 BIT(31),	/* gate */
+				 0);
+
+static const char * const isp_parents[] = { "pll-uni", "pll-uni-2x",
+					    "pll-periph0", "pll-video0-4x",
+					    "pll-csi" };
+static SUNXI_CCU_M_WITH_MUX_GATE(isp_clk, "isp",
+				 isp_parents, 0xc20,
+				 0, 5,		/* M */
+				 24, 3,		/* mux */
+				 BIT(31),	/* gate */
+				 0);
+
+static SUNXI_CCU_GATE(bus_csi_clk, "bus-csi", "ahb3", 0xc2c, BIT(0), 0);
+
+static const char * const dspo_parents[] = { "pll-video0", "pll-video0-4x",
+					     "pll-periph0", "pll-periph0-2x",
+					     "pll-uni", "pll-uni-2x",
+					     "pll-csi" };
+static SUNXI_CCU_MP_WITH_MUX(dspo_clk, "dspo",
+			     dspo_parents,
+			     0xc60,
+			     0, 2,	/* M */
+			     8, 2,	/* P */
+			     24, 2,	/* mux */
+			     0);
+
+static SUNXI_CCU_GATE(bus_dspo_clk, "bus-dspo", "ahb3", 0xc6c, BIT(0), 0);
+
+/* Fixed factor clocks */
+static CLK_FIXED_FACTOR_FW_NAME(osc12M_clk, "osc12M", "hosc", 2, 1, 0);
+
+static const struct clk_hw *clk_parent_pll_audio[] = {
+	&pll_audio_base_clk.common.hw
+};
+
+/*
+ * The divider of pll-audio is fixed to 24 for now, so 24576000 and 22579200
+ * rates can be set exactly in conjunction with sigma-delta modulation.
+ */
+static CLK_FIXED_FACTOR_HWS(pll_audio_clk, "pll-audio",
+			    clk_parent_pll_audio,
+			    24, 1, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR_HWS(pll_audio_2x_clk, "pll-audio-2x",
+			    clk_parent_pll_audio,
+			    4, 1, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR_HWS(pll_audio_4x_clk, "pll-audio-4x",
+			    clk_parent_pll_audio,
+			    2, 1, CLK_SET_RATE_PARENT);
+
+static const struct clk_hw *pll_periph0_parents[] = {
+	&pll_periph0_clk.common.hw
+};
+
+static CLK_FIXED_FACTOR_HWS(pll_periph0_2x_clk, "pll-periph0-2x",
+			    pll_periph0_parents,
+			    1, 2, 0);
+
+static const struct clk_hw *pll_uni_parents[] = {
+	&pll_uni_clk.common.hw
+};
+
+static CLK_FIXED_FACTOR_HWS(pll_uni_2x_clk, "pll-uni-2x",
+			    pll_uni_parents,
+			    1, 2, 0);
+
+static CLK_FIXED_FACTOR_HW(pll_video0_4x_clk, "pll-video0-4x",
+			   &pll_video0_clk.common.hw,
+			   1, 4, CLK_SET_RATE_PARENT);
+
+static struct ccu_common *sun8i_v833_ccu_clks[] = {
+	&pll_cpux_clk.common,
+	&pll_ddr0_clk.common,
+	&pll_periph0_clk.common,
+	&pll_uni_clk.common,
+	&pll_video0_clk.common,
+	&pll_audio_base_clk.common,
+	&pll_csi_clk.common,
+	&cpux_clk.common,
+	&axi_clk.common,
+	&cpux_apb_clk.common,
+	&psi_ahb1_ahb2_clk.common,
+	&ahb3_clk.common,
+	&apb1_clk.common,
+	&apb2_clk.common,
+	&de_clk.common,
+	&bus_de_clk.common,
+	&g2d_clk.common,
+	&bus_g2d_clk.common,
+	&ce_clk.common,
+	&bus_ce_clk.common,
+	&ve_clk.common,
+	&bus_ve_clk.common,
+	&eise_clk.common,
+	&bus_eise_clk.common,
+	&npu_clk.common,
+	&bus_npu_clk.common,
+	&bus_dma_clk.common,
+	&bus_hstimer_clk.common,
+	&avs_clk.common,
+	&bus_dbg_clk.common,
+	&bus_psi_clk.common,
+	&bus_pwm_clk.common,
+	&dram_clk.common,
+	&mbus_dma_clk.common,
+	&mbus_ve_clk.common,
+	&mbus_ce_clk.common,
+	&mbus_ts_clk.common,
+	&mbus_nand_clk.common,
+	&mbus_g2d_clk.common,
+	&mbus_eise_clk.common,
+	&mbus_vdpo_clk.common,
+	&bus_dram_clk.common,
+	&mmc0_clk.common,
+	&mmc1_clk.common,
+	&mmc2_clk.common,
+	&bus_mmc0_clk.common,
+	&bus_mmc1_clk.common,
+	&bus_mmc2_clk.common,
+	&bus_uart0_clk.common,
+	&bus_uart1_clk.common,
+	&bus_uart2_clk.common,
+	&bus_uart3_clk.common,
+	&bus_i2c0_clk.common,
+	&bus_i2c1_clk.common,
+	&bus_i2c2_clk.common,
+	&bus_i2c3_clk.common,
+	&spi0_clk.common,
+	&spi1_clk.common,
+	&spi2_clk.common,
+	&bus_spi0_clk.common,
+	&bus_spi1_clk.common,
+	&bus_spi2_clk.common,
+	&emac_25m_clk.common,
+	&bus_emac0_clk.common,
+	&bus_gpadc_clk.common,
+	&bus_ths_clk.common,
+	&i2s0_clk.common,
+	&i2s1_clk.common,
+	&bus_i2s0_clk.common,
+	&bus_i2s1_clk.common,
+	&audio_codec_1x_clk.common,
+	&audio_codec_4x_clk.common,
+	&bus_audio_codec_clk.common,
+	&usb_ohci0_clk.common,
+	&usb_phy0_clk.common,
+	&bus_ohci0_clk.common,
+	&bus_ehci0_clk.common,
+	&bus_otg_clk.common,
+	&mipi_dsi_dphy0_hs_clk.common,
+	&mipi_dsi_host0_clk.common,
+	&bus_mipi_dsi_clk.common,
+	&bus_tcon_top_clk.common,
+	&tcon_lcd0_clk.common,
+	&bus_tcon_lcd0_clk.common,
+	&csi_top_clk.common,
+	&csi_mclk0_clk.common,
+	&csi_mclk1_clk.common,
+	&isp_clk.common,
+	&bus_csi_clk.common,
+	&dspo_clk.common,
+	&bus_dspo_clk.common,
+};
+
+static struct clk_hw_onecell_data sun8i_v833_hw_clks = {
+	.hws	= {
+		[CLK_OSC12M]		= &osc12M_clk.hw,
+		[CLK_PLL_CPUX]		= &pll_cpux_clk.common.hw,
+		[CLK_PLL_DDR0]		= &pll_ddr0_clk.common.hw,
+		[CLK_PLL_PERIPH0]	= &pll_periph0_clk.common.hw,
+		[CLK_PLL_PERIPH0_2X]	= &pll_periph0_2x_clk.hw,
+		[CLK_PLL_UNI]		= &pll_uni_clk.common.hw,
+		[CLK_PLL_UNI_2X]	= &pll_uni_2x_clk.hw,
+		[CLK_PLL_VIDEO0]	= &pll_video0_clk.common.hw,
+		[CLK_PLL_VIDEO0_4X]	= &pll_video0_4x_clk.hw,
+		[CLK_PLL_AUDIO_BASE]	= &pll_audio_base_clk.common.hw,
+		[CLK_PLL_AUDIO]		= &pll_audio_clk.hw,
+		[CLK_PLL_AUDIO_2X]	= &pll_audio_2x_clk.hw,
+		[CLK_PLL_AUDIO_4X]	= &pll_audio_4x_clk.hw,
+		[CLK_PLL_CSI]		= &pll_csi_clk.common.hw,
+		[CLK_CPUX]		= &cpux_clk.common.hw,
+		[CLK_AXI]		= &axi_clk.common.hw,
+		[CLK_CPUX_APB]		= &cpux_apb_clk.common.hw,
+		[CLK_PSI_AHB1_AHB2]	= &psi_ahb1_ahb2_clk.common.hw,
+		[CLK_AHB3]		= &ahb3_clk.common.hw,
+		[CLK_APB1]		= &apb1_clk.common.hw,
+		[CLK_APB2]		= &apb2_clk.common.hw,
+		[CLK_DE]		= &de_clk.common.hw,
+		[CLK_BUS_DE]		= &bus_de_clk.common.hw,
+		[CLK_G2D]		= &g2d_clk.common.hw,
+		[CLK_BUS_G2D]		= &bus_g2d_clk.common.hw,
+		[CLK_CE]		= &ce_clk.common.hw,
+		[CLK_BUS_CE]		= &bus_ce_clk.common.hw,
+		[CLK_VE]		= &ve_clk.common.hw,
+		[CLK_BUS_VE]		= &bus_ve_clk.common.hw,
+		[CLK_EISE]		= &eise_clk.common.hw,
+		[CLK_BUS_EISE]		= &bus_eise_clk.common.hw,
+		[CLK_NPU]		= &npu_clk.common.hw,
+		[CLK_BUS_NPU]		= &bus_npu_clk.common.hw,
+		[CLK_BUS_DMA]		= &bus_dma_clk.common.hw,
+		[CLK_BUS_HSTIMER]	= &bus_hstimer_clk.common.hw,
+		[CLK_AVS]		= &avs_clk.common.hw,
+		[CLK_BUS_DBG]		= &bus_dbg_clk.common.hw,
+		[CLK_BUS_PSI]		= &bus_psi_clk.common.hw,
+		[CLK_BUS_PWM]		= &bus_pwm_clk.common.hw,
+		[CLK_DRAM]		= &dram_clk.common.hw,
+		[CLK_MBUS_DMA]		= &mbus_dma_clk.common.hw,
+		[CLK_MBUS_VE]		= &mbus_ve_clk.common.hw,
+		[CLK_MBUS_CE]		= &mbus_ce_clk.common.hw,
+		[CLK_MBUS_TS]		= &mbus_ts_clk.common.hw,
+		[CLK_MBUS_NAND]		= &mbus_nand_clk.common.hw,
+		[CLK_MBUS_G2D]		= &mbus_g2d_clk.common.hw,
+		[CLK_MBUS_EISE]		= &mbus_eise_clk.common.hw,
+		[CLK_MBUS_VDPO]		= &mbus_vdpo_clk.common.hw,
+		[CLK_BUS_DRAM]		= &bus_dram_clk.common.hw,
+		[CLK_MMC0]		= &mmc0_clk.common.hw,
+		[CLK_MMC1]		= &mmc1_clk.common.hw,
+		[CLK_MMC2]		= &mmc2_clk.common.hw,
+		[CLK_BUS_MMC0]		= &bus_mmc0_clk.common.hw,
+		[CLK_BUS_MMC1]		= &bus_mmc1_clk.common.hw,
+		[CLK_BUS_MMC2]		= &bus_mmc2_clk.common.hw,
+		[CLK_BUS_UART0]		= &bus_uart0_clk.common.hw,
+		[CLK_BUS_UART1]		= &bus_uart1_clk.common.hw,
+		[CLK_BUS_UART2]		= &bus_uart2_clk.common.hw,
+		[CLK_BUS_UART3]		= &bus_uart3_clk.common.hw,
+		[CLK_BUS_I2C0]		= &bus_i2c0_clk.common.hw,
+		[CLK_BUS_I2C1]		= &bus_i2c1_clk.common.hw,
+		[CLK_BUS_I2C2]		= &bus_i2c2_clk.common.hw,
+		[CLK_BUS_I2C3]		= &bus_i2c3_clk.common.hw,
+		[CLK_SPI0]		= &spi0_clk.common.hw,
+		[CLK_SPI1]		= &spi1_clk.common.hw,
+		[CLK_SPI2]		= &spi2_clk.common.hw,
+		[CLK_BUS_SPI0]		= &bus_spi0_clk.common.hw,
+		[CLK_BUS_SPI1]		= &bus_spi1_clk.common.hw,
+		[CLK_BUS_SPI2]		= &bus_spi2_clk.common.hw,
+		[CLK_EMAC_25M]		= &emac_25m_clk.common.hw,
+		[CLK_BUS_EMAC0]		= &bus_emac0_clk.common.hw,
+		[CLK_BUS_GPADC]		= &bus_gpadc_clk.common.hw,
+		[CLK_BUS_THS]		= &bus_ths_clk.common.hw,
+		[CLK_I2S0]		= &i2s0_clk.common.hw,
+		[CLK_I2S1]		= &i2s1_clk.common.hw,
+		[CLK_BUS_I2S0]		= &bus_i2s0_clk.common.hw,
+		[CLK_BUS_I2S1]		= &bus_i2s1_clk.common.hw,
+		[CLK_AUDIO_CODEC_1X]	= &audio_codec_1x_clk.common.hw,
+		[CLK_AUDIO_CODEC_4X]	= &audio_codec_4x_clk.common.hw,
+		[CLK_BUS_AUDIO_CODEC]	= &bus_audio_codec_clk.common.hw,
+		[CLK_USB_OHCI0]		= &usb_ohci0_clk.common.hw,
+		[CLK_USB_PHY0]		= &usb_phy0_clk.common.hw,
+		[CLK_BUS_OHCI0]		= &bus_ohci0_clk.common.hw,
+		[CLK_BUS_EHCI0]		= &bus_ehci0_clk.common.hw,
+		[CLK_BUS_OTG]		= &bus_otg_clk.common.hw,
+		[CLK_MIPI_DSI_DPHY0_HS]	= &mipi_dsi_dphy0_hs_clk.common.hw,
+		[CLK_MIPI_DSI_HOST0]	= &mipi_dsi_host0_clk.common.hw,
+		[CLK_BUS_MIPI_DSI]	= &bus_mipi_dsi_clk.common.hw,
+		[CLK_BUS_TCON_TOP]	= &bus_tcon_top_clk.common.hw,
+		[CLK_TCON_LCD0]		= &tcon_lcd0_clk.common.hw,
+		[CLK_BUS_TCON_LCD0]	= &bus_tcon_lcd0_clk.common.hw,
+		[CLK_CSI_TOP]		= &csi_top_clk.common.hw,
+		[CLK_CSI_MCLK0]		= &csi_mclk0_clk.common.hw,
+		[CLK_CSI_MCLK1]		= &csi_mclk1_clk.common.hw,
+		[CLK_ISP]		= &isp_clk.common.hw,
+		[CLK_BUS_CSI]		= &bus_csi_clk.common.hw,
+		[CLK_DSPO]		= &dspo_clk.common.hw,
+		[CLK_BUS_DSPO]		= &bus_dspo_clk.common.hw,
+	},
+	.num = CLK_NUMBER,
+};
+
+static struct ccu_reset_map sun8i_v833_ccu_resets[] = {
+	[RST_MBUS]		= { 0x540, BIT(30) },
+
+	[RST_BUS_DE]		= { 0x60c, BIT(16) },
+	[RST_BUS_G2D]		= { 0x63c, BIT(16) },
+	[RST_BUS_CE]		= { 0x68c, BIT(16) },
+	[RST_BUS_VE]		= { 0x69c, BIT(16) },
+	[RST_BUS_EISE]		= { 0x6dc, BIT(16) },
+	[RST_BUS_NPU]		= { 0x6ec, BIT(16) },
+	[RST_BUS_DMA]		= { 0x70c, BIT(16) },
+	[RST_BUS_HSTIMER]	= { 0x73c, BIT(16) },
+	[RST_BUS_DBG]		= { 0x78c, BIT(16) },
+	[RST_BUS_PSI]		= { 0x79c, BIT(16) },
+	[RST_BUS_PWM]		= { 0x7ac, BIT(16) },
+	[RST_BUS_DRAM]		= { 0x70c, BIT(16) },
+	[RST_BUS_MMC0]		= { 0x84c, BIT(16) },
+	[RST_BUS_MMC1]		= { 0x84c, BIT(17) },
+	[RST_BUS_MMC2]		= { 0x84c, BIT(18) },
+	[RST_BUS_UART0]		= { 0x90c, BIT(16) },
+	[RST_BUS_UART1]		= { 0x90c, BIT(17) },
+	[RST_BUS_UART2]		= { 0x90c, BIT(18) },
+	[RST_BUS_UART3]		= { 0x90c, BIT(19) },
+	[RST_BUS_I2C0]		= { 0x91c, BIT(16) },
+	[RST_BUS_I2C1]		= { 0x91c, BIT(17) },
+	[RST_BUS_I2C2]		= { 0x91c, BIT(18) },
+	[RST_BUS_I2C3]		= { 0x91c, BIT(19) },
+	[RST_BUS_SPI0]		= { 0x96c, BIT(16) },
+	[RST_BUS_SPI1]		= { 0x96c, BIT(17) },
+	[RST_BUS_SPI2]		= { 0x96c, BIT(18) },
+	[RST_BUS_EMAC0]		= { 0x97c, BIT(16) },
+	[RST_BUS_GPADC]		= { 0x9ec, BIT(16) },
+	[RST_BUS_THS]		= { 0x9fc, BIT(16) },
+	[RST_BUS_I2S0]		= { 0xa2c, BIT(16) },
+	[RST_BUS_I2S1]		= { 0xa2c, BIT(17) },
+	[RST_BUS_AUDIO_CODEC]	= { 0xa5c, BIT(16) },
+
+	[RST_USB_PHY0]		= { 0xa70, BIT(30) },
+
+	[RST_BUS_OHCI0]		= { 0xa8c, BIT(16) },
+	[RST_BUS_EHCI0]		= { 0xa8c, BIT(20) },
+	[RST_BUS_OTG]		= { 0xa8c, BIT(24) },
+	[RST_BUS_MIPI_DSI]	= { 0xb4c, BIT(16) },
+	[RST_BUS_TCON_TOP]	= { 0xb5c, BIT(16) },
+	[RST_BUS_TCON_LCD0]	= { 0xb7c, BIT(16) },
+	[RST_BUS_CSI]		= { 0xc2c, BIT(16) },
+	[RST_BUS_DSPO]		= { 0xc6c, BIT(16) },
+};
+
+static const struct sunxi_ccu_desc sun8i_v833_ccu_desc = {
+	.ccu_clks	= sun8i_v833_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun8i_v833_ccu_clks),
+
+	.hw_clks	= &sun8i_v833_hw_clks,
+
+	.resets		= sun8i_v833_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sun8i_v833_ccu_resets),
+};
+
+static const u32 pll_regs[] = {
+	SUN8I_V833_PLL_CPUX_REG,
+	SUN8I_V833_PLL_DDR0_REG,
+	SUN8I_V833_PLL_PERIPH0_REG,
+	SUN8I_V833_PLL_UNI_REG,
+	SUN8I_V833_PLL_VIDEO0_REG,
+	SUN8I_V833_PLL_AUDIO_REG,
+	SUN8I_V833_PLL_CSI_REG,
+};
+
+static const u32 pll_video_regs[] = {
+	SUN8I_V833_PLL_VIDEO0_REG,
+};
+
+static void __init sun8i_v833_ccu_setup(struct device_node *node)
+{
+	void __iomem *reg;
+	u32 val;
+	int i;
+
+	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (IS_ERR(reg)) {
+		pr_err("%pOF: Could not map clock registers\n", node);
+		return;
+	}
+
+	/* Enable the lock bits and the output enable bits on all PLLs */
+	for (i = 0; i < ARRAY_SIZE(pll_regs); i++) {
+		val = readl(reg + pll_regs[i]);
+		val |= BIT(29) | BIT(27);
+		writel(val, reg + pll_regs[i]);
+	}
+
+	/*
+	 * Force the output divider of pll-video0 to 0.
+	 *
+	 * See the comment before its definition for the reason.
+	 */
+	val = readl(reg + SUN8I_V833_PLL_VIDEO0_REG);
+	val &= ~BIT(0);
+	writel(val, reg + SUN8I_V833_PLL_VIDEO0_REG);
+
+	/*
+	 * Force OHCI 12M clock sources to 00 (12MHz divided from 48MHz)
+	 *
+	 * This clock mux is still mysterious, and the code just enforces
+	 * it to have a valid clock parent.
+	 */
+	val = readl(reg + SUN8I_V833_USB0_CLK_REG);
+	val &= ~GENMASK(25, 24);
+	writel(val, reg + SUN8I_V833_USB0_CLK_REG);
+
+	/*
+	 * Force the post-divider of pll-audio to 12 and the output divider
+	 * of it to 2, so 24576000 and 22579200 rates can be set exactly.
+	 */
+	val = readl(reg + SUN8I_V833_PLL_AUDIO_REG);
+	val &= ~(GENMASK(21, 16) | BIT(0));
+	writel(val | (11 << 16) | BIT(0), reg + SUN8I_V833_PLL_AUDIO_REG);
+
+	i = sunxi_ccu_probe(node, reg, &sun8i_v833_ccu_desc);
+	if (i)
+		pr_err("%pOF: probing clocks fails: %d\n", node, i);
+}
+
+CLK_OF_DECLARE(sun8i_v833_ccu, "allwinner,sun8i-v833-ccu",
+	       sun8i_v833_ccu_setup);
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v833.h b/drivers/clk/sunxi-ng/ccu-sun8i-v833.h
new file mode 100644
index 000000000000..75188c446ac6
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v833.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+#ifndef _CCU_SUN8I_V833_H_
+#define _CCU_SUN8I_V833_H_
+
+#include <dt-bindings/clock/sun8i-v833-ccu.h>
+#include <dt-bindings/reset/sun8i-v833-ccu.h>
+
+#define CLK_OSC12M		0
+#define CLK_PLL_CPUX		1
+#define CLK_PLL_DDR0		2
+#define CLK_PLL_PERIPH0		3
+#define CLK_PLL_PERIPH0_2X	4
+#define CLK_PLL_UNI		5
+#define CLK_PLL_UNI_2X		6
+#define CLK_PLL_VIDEO0		7
+#define CLK_PLL_VIDEO0_4X	8
+#define CLK_PLL_AUDIO_BASE	9
+#define CLK_PLL_AUDIO		10
+#define CLK_PLL_AUDIO_2X	11
+#define CLK_PLL_AUDIO_4X	12
+#define CLK_PLL_CSI		13
+
+/* CPUX clock exported for DVFS */
+
+#define CLK_AXI			15
+#define CLK_CPUX_APB		16
+#define CLK_PSI_AHB1_AHB2	17
+#define CLK_AHB3		18
+
+/* APB1 clock exported for PIO */
+
+#define CLK_APB2		20
+
+/* All module clocks and bus gates are exported except DRAM */
+
+#define CLK_DRAM		39
+
+#define CLK_BUS_DRAM		48
+
+#define CLK_NUMBER		(CLK_BUS_DSPO + 1)
+
+#endif /* _CCU_SUN8I_V833_H_ */
-- 
2.28.0
