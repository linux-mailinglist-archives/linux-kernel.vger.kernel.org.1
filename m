Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5512A283895
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgJEO7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgJEO7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:59:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B58C0613CE;
        Mon,  5 Oct 2020 07:59:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e18so4045593wrw.9;
        Mon, 05 Oct 2020 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZmEQOa+O2uB9Mk3TArpM7b5UE0YlJzmnANvLmX6qy3k=;
        b=uEOc5x0G7CE0lZDX1dnetu5grF18MIyY4lNDvbbgYYpRikaieHfjETwlcrEkFPIM1e
         4LxaZPqG/et6jfd0ZpqY3c6UfE7SQKQdJOzOMcGsxoXB+kQUwZnHngqKl5xALD8yq4VQ
         +E3OFrVpWIQir7naErcJGVNdlqtug2l6GFfy8DspxIj92TxoERkK6JfwdVZBrrmcN4uN
         n4VBvt4mAyv7fhHQ3GAWVJD57XzsKWJG2rALhiGaKEIaXwsvSc+VKrNSRRmZE0Im4bBe
         +SDZ41txMIv6l8uoQEDEKKBuEFpA9j+e90vLqE0M/MPSxBCkK7mt3HlxyLvb8mj9tgbm
         a0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZmEQOa+O2uB9Mk3TArpM7b5UE0YlJzmnANvLmX6qy3k=;
        b=ip3uOBXMhnRC/cDcSRInddwRgMvGM5hY7rLcDtD2a5+qbGOn5ldc75cTC/KRRUPnnZ
         UV0Rwu1GVF9DiObYYhMMJtX9iUru/eSn8FqLCzleo5y9zJx/Qj4H99l6yNgSIEHluAXy
         XLOxU2QVAMKRi8ofBcKQg57c3dbLb4KtjdMdP/k/R+L7nOU7ju22XlX6yR6TRZEjZKQ5
         sc7HfuXuspCU+GXXYwfd6EFjF4vTDLl9sLcbbhHYpV3ta+DP2n5keeeYaNAnT/7AWs7q
         658U6bROO602I6Tkgc0Q+p1s/2kVyNK99Mzf6OowUZ8gDrPIfcTkUCa5ULEDsnj222fW
         wLxg==
X-Gm-Message-State: AOAM533wcP2y1PKf24s+Jsu2yOkUjUb1Kxx8As3dvePWIMdAhedeqKuI
        zJqMo1G67j+pwZw8AJHKBH0=
X-Google-Smtp-Source: ABdhPJy3Vi3i/FAYq98RVcSSwy7dWtX3BitQevdZocY7TB98kz4jSdTwYN2h7BRf4GDQSkp1nAi2GQ==
X-Received: by 2002:adf:f585:: with SMTP id f5mr18924699wro.64.1601909947362;
        Mon, 05 Oct 2020 07:59:07 -0700 (PDT)
Received: from localhost.localdomain (abab191.neoplus.adsl.tpnet.pl. [83.6.165.191])
        by smtp.googlemail.com with ESMTPSA id n3sm13555244wmn.28.2020.10.05.07.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:59:06 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     konradybcio@gmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] clk: qcom: gcc-msm8994: Add missing clocks, resets and GDSCs
Date:   Mon,  5 Oct 2020 16:58:55 +0200
Message-Id: <20201005145855.149206-1-konradybcio@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds GDSCs, resets and most of the missing
clocks to the msm8994 GCC driver. The remaining ones
are of local_vote_clk and gate_clk type, which are not
yet supported upstream. Also reorder them to match the
original downstream driver.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 drivers/clk/qcom/gcc-msm8994.c               | 388 ++++++++++++++++++-
 include/dt-bindings/clock/qcom,gcc-msm8994.h |  36 ++
 2 files changed, 423 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-msm8994.c b/drivers/clk/qcom/gcc-msm8994.c
index b7fc8c7ba195..144d2ba7a9be 100644
--- a/drivers/clk/qcom/gcc-msm8994.c
+++ b/drivers/clk/qcom/gcc-msm8994.c
@@ -20,6 +20,7 @@
 #include "clk-rcg.h"
 #include "clk-branch.h"
 #include "reset.h"
+#include "gdsc.h"
 
 enum {
 	P_XO,
@@ -1772,6 +1773,32 @@ static struct clk_branch gcc_gp3_clk = {
 	},
 };
 
+static struct clk_branch gcc_lpass_q6_axi_clk = {
+	.halt_reg = 0x0280,
+	.clkr = {
+		.enable_reg = 0x0280,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_lpass_q6_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mss_q6_bimc_axi_clk = {
+	.halt_reg = 0x0284,
+	.clkr = {
+		.enable_reg = 0x0284,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_mss_q6_bimc_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_pcie_0_aux_clk = {
 	.halt_reg = 0x1ad4,
 	.clkr = {
@@ -1790,6 +1817,32 @@ static struct clk_branch gcc_pcie_0_aux_clk = {
 	},
 };
 
+static struct clk_branch gcc_pcie_0_cfg_ahb_clk = {
+	.halt_reg = 0x1ad0,
+	.clkr = {
+		.enable_reg = 0x1ad0,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_pcie_0_cfg_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_0_mstr_axi_clk = {
+	.halt_reg = 0x1acc,
+	.clkr = {
+		.enable_reg = 0x1acc,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_pcie_0_mstr_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_pcie_0_pipe_clk = {
 	.halt_reg = 0x1ad8,
 	.halt_check = BRANCH_HALT_DELAY,
@@ -1809,6 +1862,20 @@ static struct clk_branch gcc_pcie_0_pipe_clk = {
 	},
 };
 
+static struct clk_branch gcc_pcie_0_slv_axi_clk = {
+	.halt_reg = 0x1ac8,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1ac8,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_pcie_0_slv_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_pcie_1_aux_clk = {
 	.halt_reg = 0x1b54,
 	.clkr = {
@@ -1827,6 +1894,32 @@ static struct clk_branch gcc_pcie_1_aux_clk = {
 	},
 };
 
+static struct clk_branch gcc_pcie_1_cfg_ahb_clk = {
+	.halt_reg = 0x1b54,
+	.clkr = {
+		.enable_reg = 0x1b54,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_pcie_1_cfg_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_1_mstr_axi_clk = {
+	.halt_reg = 0x1b50,
+	.clkr = {
+		.enable_reg = 0x1b50,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_pcie_1_mstr_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_pcie_1_pipe_clk = {
 	.halt_reg = 0x1b58,
 	.halt_check = BRANCH_HALT_DELAY,
@@ -1846,6 +1939,19 @@ static struct clk_branch gcc_pcie_1_pipe_clk = {
 	},
 };
 
+static struct clk_branch gcc_pcie_1_slv_axi_clk = {
+	.halt_reg = 0x1b48,
+	.clkr = {
+		.enable_reg = 0x1b48,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_pcie_1_slv_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_pdm2_clk = {
 	.halt_reg = 0x0ccc,
 	.clkr = {
@@ -1864,6 +1970,19 @@ static struct clk_branch gcc_pdm2_clk = {
 	},
 };
 
+static struct clk_branch gcc_pdm_ahb_clk = {
+	.halt_reg = 0x0cc4,
+	.clkr = {
+		.enable_reg = 0x0cc4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_pdm_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_sdcc1_apps_clk = {
 	.halt_reg = 0x04c4,
 	.clkr = {
@@ -1899,6 +2018,23 @@ static struct clk_branch gcc_sdcc1_ahb_clk = {
 	},
 };
 
+static struct clk_branch gcc_sdcc2_ahb_clk = {
+	.halt_reg = 0x0508,
+	.clkr = {
+		.enable_reg = 0x0508,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_sdcc2_ahb_clk",
+			.parent_names = (const char *[]){
+				"periph_noc_clk_src",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_sdcc2_apps_clk = {
 	.halt_reg = 0x0504,
 	.clkr = {
@@ -1917,6 +2053,23 @@ static struct clk_branch gcc_sdcc2_apps_clk = {
 	},
 };
 
+static struct clk_branch gcc_sdcc3_ahb_clk = {
+	.halt_reg = 0x0548,
+	.clkr = {
+		.enable_reg = 0x0548,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_sdcc3_ahb_clk",
+			.parent_names = (const char *[]){
+				"periph_noc_clk_src",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_sdcc3_apps_clk = {
 	.halt_reg = 0x0544,
 	.clkr = {
@@ -1935,6 +2088,23 @@ static struct clk_branch gcc_sdcc3_apps_clk = {
 	},
 };
 
+static struct clk_branch gcc_sdcc4_ahb_clk = {
+	.halt_reg = 0x0588,
+	.clkr = {
+		.enable_reg = 0x0588,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_sdcc4_ahb_clk",
+			.parent_names = (const char *[]){
+				"periph_noc_clk_src",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_sdcc4_apps_clk = {
 	.halt_reg = 0x0584,
 	.clkr = {
@@ -1989,6 +2159,19 @@ static struct clk_branch gcc_sys_noc_usb3_axi_clk = {
 	},
 };
 
+static struct clk_branch gcc_tsif_ahb_clk = {
+	.halt_reg = 0x0d84,
+	.clkr = {
+		.enable_reg = 0x0d84,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_tsif_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_tsif_ref_clk = {
 	.halt_reg = 0x0d88,
 	.clkr = {
@@ -2007,6 +2190,19 @@ static struct clk_branch gcc_tsif_ref_clk = {
 	},
 };
 
+static struct clk_branch gcc_ufs_ahb_clk = {
+	.halt_reg = 0x1d4c,
+	.clkr = {
+		.enable_reg = 0x1d4c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_ufs_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_ufs_axi_clk = {
 	.halt_reg = 0x1d48,
 	.clkr = {
@@ -2043,6 +2239,34 @@ static struct clk_branch gcc_ufs_rx_cfg_clk = {
 	},
 };
 
+static struct clk_branch gcc_ufs_rx_symbol_0_clk = {
+	.halt_reg = 0x1d60,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1d60,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_ufs_rx_symbol_0_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_rx_symbol_1_clk = {
+	.halt_reg = 0x1d64,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1d64,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_ufs_rx_symbol_1_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_ufs_tx_cfg_clk = {
 	.halt_reg = 0x1d50,
 	.clkr = {
@@ -2061,6 +2285,47 @@ static struct clk_branch gcc_ufs_tx_cfg_clk = {
 	},
 };
 
+static struct clk_branch gcc_ufs_tx_symbol_0_clk = {
+	.halt_reg = 0x1d58,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1d58,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_ufs_tx_symbol_0_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_tx_symbol_1_clk = {
+	.halt_reg = 0x1d5c,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1d5c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_ufs_tx_symbol_1_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb2_hs_phy_sleep_clk = {
+	.halt_reg = 0x04ac,
+	.clkr = {
+		.enable_reg = 0x04ac,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_usb2_hs_phy_sleep_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_usb30_master_clk = {
 	.halt_reg = 0x03c8,
 	.clkr = {
@@ -2097,6 +2362,19 @@ static struct clk_branch gcc_usb30_mock_utmi_clk = {
 	},
 };
 
+static struct clk_branch gcc_usb30_sleep_clk = {
+	.halt_reg = 0x03cc,
+	.clkr = {
+		.enable_reg = 0x03cc,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_usb30_sleep_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_usb3_phy_aux_clk = {
 	.halt_reg = 0x1408,
 	.clkr = {
@@ -2115,6 +2393,19 @@ static struct clk_branch gcc_usb3_phy_aux_clk = {
 	},
 };
 
+static struct clk_branch gcc_usb_hs_ahb_clk = {
+	.halt_reg = 0x0488,
+	.clkr = {
+		.enable_reg = 0x0488,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_usb_hs_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_usb_hs_system_clk = {
 	.halt_reg = 0x0484,
 	.clkr = {
@@ -2133,6 +2424,59 @@ static struct clk_branch gcc_usb_hs_system_clk = {
 	},
 };
 
+static struct clk_branch gcc_usb_phy_cfg_ahb2phy_clk = {
+	.halt_reg = 0x1a84,
+	.clkr = {
+		.enable_reg = 0x1a84,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_usb_phy_cfg_ahb2phy_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct gdsc pcie_gdsc = {
+		.gdscr = 0x1e18,
+		.pd = {
+			.name = "pcie",
+		},
+		.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc pcie_0_gdsc = {
+		.gdscr = 0x1ac4,
+		.pd = {
+			.name = "pcie_0",
+		},
+		.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc pcie_1_gdsc = {
+		.gdscr = 0x1b44,
+		.pd = {
+			.name = "pcie_1",
+		},
+		.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc usb30_gdsc = {
+		.gdscr = 0x3c4,
+		.pd = {
+			.name = "usb30",
+		},
+		.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc ufs_gdsc = {
+		.gdscr = 0x1d44,
+		.pd = {
+			.name = "ufs",
+		},
+		.pwrsts = PWRSTS_OFF_ON,
+};
+
 static struct clk_regmap *gcc_msm8994_clocks[] = {
 	[GPLL0_EARLY] = &gpll0_early.clkr,
 	[GPLL0] = &gpll0.clkr,
@@ -2233,26 +2577,64 @@ static struct clk_regmap *gcc_msm8994_clocks[] = {
 	[GCC_GP1_CLK] = &gcc_gp1_clk.clkr,
 	[GCC_GP2_CLK] = &gcc_gp2_clk.clkr,
 	[GCC_GP3_CLK] = &gcc_gp3_clk.clkr,
+	[GCC_LPASS_Q6_AXI_CLK] = &gcc_lpass_q6_axi_clk.clkr,
+	[GCC_MSS_Q6_BIMC_AXI_CLK] = &gcc_mss_q6_bimc_axi_clk.clkr,
 	[GCC_PCIE_0_AUX_CLK] = &gcc_pcie_0_aux_clk.clkr,
+	[GCC_PCIE_0_CFG_AHB_CLK] = &gcc_pcie_0_cfg_ahb_clk.clkr,
+	[GCC_PCIE_0_MSTR_AXI_CLK] = &gcc_pcie_0_mstr_axi_clk.clkr,
 	[GCC_PCIE_0_PIPE_CLK] = &gcc_pcie_0_pipe_clk.clkr,
+	[GCC_PCIE_0_SLV_AXI_CLK] = &gcc_pcie_0_slv_axi_clk.clkr,
 	[GCC_PCIE_1_AUX_CLK] = &gcc_pcie_1_aux_clk.clkr,
+	[GCC_PCIE_1_CFG_AHB_CLK] = &gcc_pcie_1_cfg_ahb_clk.clkr,
+	[GCC_PCIE_1_MSTR_AXI_CLK] = &gcc_pcie_1_mstr_axi_clk.clkr,
 	[GCC_PCIE_1_PIPE_CLK] = &gcc_pcie_1_pipe_clk.clkr,
+	[GCC_PCIE_1_SLV_AXI_CLK] = &gcc_pcie_1_slv_axi_clk.clkr,
 	[GCC_PDM2_CLK] = &gcc_pdm2_clk.clkr,
+	[GCC_PDM_AHB_CLK] = &gcc_pdm_ahb_clk.clkr,
+	[GCC_SDCC1_AHB_CLK] = &gcc_sdcc1_ahb_clk.clkr,
 	[GCC_SDCC1_APPS_CLK] = &gcc_sdcc1_apps_clk.clkr,
+	[GCC_SDCC2_AHB_CLK] = &gcc_sdcc2_ahb_clk.clkr,
 	[GCC_SDCC2_APPS_CLK] = &gcc_sdcc2_apps_clk.clkr,
+	[GCC_SDCC3_AHB_CLK] = &gcc_sdcc3_ahb_clk.clkr,
 	[GCC_SDCC3_APPS_CLK] = &gcc_sdcc3_apps_clk.clkr,
+	[GCC_SDCC4_AHB_CLK] = &gcc_sdcc4_ahb_clk.clkr,
 	[GCC_SDCC4_APPS_CLK] = &gcc_sdcc4_apps_clk.clkr,
-	[GCC_SDCC1_AHB_CLK] = &gcc_sdcc1_ahb_clk.clkr,
 	[GCC_SYS_NOC_UFS_AXI_CLK] = &gcc_sys_noc_ufs_axi_clk.clkr,
 	[GCC_SYS_NOC_USB3_AXI_CLK] = &gcc_sys_noc_usb3_axi_clk.clkr,
+	[GCC_TSIF_AHB_CLK] = &gcc_tsif_ahb_clk.clkr,
 	[GCC_TSIF_REF_CLK] = &gcc_tsif_ref_clk.clkr,
+	[GCC_UFS_AHB_CLK] = &gcc_ufs_ahb_clk.clkr,
 	[GCC_UFS_AXI_CLK] = &gcc_ufs_axi_clk.clkr,
 	[GCC_UFS_RX_CFG_CLK] = &gcc_ufs_rx_cfg_clk.clkr,
+	[GCC_UFS_RX_SYMBOL_0_CLK] = &gcc_ufs_rx_symbol_0_clk.clkr,
+	[GCC_UFS_RX_SYMBOL_1_CLK] = &gcc_ufs_rx_symbol_1_clk.clkr,
 	[GCC_UFS_TX_CFG_CLK] = &gcc_ufs_tx_cfg_clk.clkr,
+	[GCC_UFS_TX_SYMBOL_0_CLK] = &gcc_ufs_tx_symbol_0_clk.clkr,
+	[GCC_UFS_TX_SYMBOL_1_CLK] = &gcc_ufs_tx_symbol_1_clk.clkr,
+	[GCC_USB2_HS_PHY_SLEEP_CLK] = &gcc_usb2_hs_phy_sleep_clk.clkr,
 	[GCC_USB30_MASTER_CLK] = &gcc_usb30_master_clk.clkr,
 	[GCC_USB30_MOCK_UTMI_CLK] = &gcc_usb30_mock_utmi_clk.clkr,
+	[GCC_USB30_SLEEP_CLK] = &gcc_usb30_sleep_clk.clkr,
 	[GCC_USB3_PHY_AUX_CLK] = &gcc_usb3_phy_aux_clk.clkr,
+	[GCC_USB_HS_AHB_CLK] = &gcc_usb_hs_ahb_clk.clkr,
 	[GCC_USB_HS_SYSTEM_CLK] = &gcc_usb_hs_system_clk.clkr,
+	[GCC_USB_PHY_CFG_AHB2PHY_CLK] = &gcc_usb_phy_cfg_ahb2phy_clk.clkr,
+};
+
+static struct gdsc *gcc_msm8994_gdscs[] = {
+	[PCIE_GDSC] = &pcie_gdsc,
+	[PCIE_0_GDSC] = &pcie_0_gdsc,
+	[PCIE_1_GDSC] = &pcie_1_gdsc,
+	[USB30_GDSC] = &usb30_gdsc,
+	[UFS_GDSC] = &ufs_gdsc,
+};
+
+static const struct qcom_reset_map gcc_msm8994_resets[] = {
+	[USB3_PHY_RESET] = { 0x1400 },
+	[USB3PHY_PHY_RESET] = { 0x1404 },
+	[PCIE_PHY_0_RESET] = { 0x1b18 },
+	[PCIE_PHY_1_RESET] = { 0x1b98 },
+	[QUSB2_PHY_RESET] = { 0x04b8 },
 };
 
 static const struct regmap_config gcc_msm8994_regmap_config = {
@@ -2267,6 +2649,10 @@ static const struct qcom_cc_desc gcc_msm8994_desc = {
 	.config = &gcc_msm8994_regmap_config,
 	.clks = gcc_msm8994_clocks,
 	.num_clks = ARRAY_SIZE(gcc_msm8994_clocks),
+	.resets = gcc_msm8994_resets,
+	.num_resets = ARRAY_SIZE(gcc_msm8994_resets),
+	.gdscs = gcc_msm8994_gdscs,
+	.num_gdscs = ARRAY_SIZE(gcc_msm8994_gdscs),
 };
 
 static const struct of_device_id gcc_msm8994_match_table[] = {
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8994.h b/include/dt-bindings/clock/qcom,gcc-msm8994.h
index 938969309e00..507b8d6effd2 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8994.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8994.h
@@ -126,5 +126,41 @@
 #define GCC_USB3_PHY_AUX_CLK			116
 #define GCC_USB_HS_SYSTEM_CLK			117
 #define GCC_SDCC1_AHB_CLK			118
+#define GCC_LPASS_Q6_AXI_CLK		119
+#define GCC_MSS_Q6_BIMC_AXI_CLK		120
+#define GCC_PCIE_0_CFG_AHB_CLK		121
+#define GCC_PCIE_0_MSTR_AXI_CLK		122
+#define GCC_PCIE_0_SLV_AXI_CLK		123
+#define GCC_PCIE_1_CFG_AHB_CLK		124
+#define GCC_PCIE_1_MSTR_AXI_CLK		125
+#define GCC_PCIE_1_SLV_AXI_CLK		126
+#define GCC_PDM_AHB_CLK				127
+#define GCC_SDCC2_AHB_CLK			128
+#define GCC_SDCC3_AHB_CLK			129
+#define GCC_SDCC4_AHB_CLK			130
+#define GCC_TSIF_AHB_CLK			131
+#define GCC_UFS_AHB_CLK				132
+#define GCC_UFS_RX_SYMBOL_0_CLK		133
+#define GCC_UFS_RX_SYMBOL_1_CLK		134
+#define GCC_UFS_TX_SYMBOL_0_CLK		135
+#define GCC_UFS_TX_SYMBOL_1_CLK		136
+#define GCC_USB2_HS_PHY_SLEEP_CLK	137
+#define GCC_USB30_SLEEP_CLK			138
+#define GCC_USB_HS_AHB_CLK			139
+#define GCC_USB_PHY_CFG_AHB2PHY_CLK	140
+
+/* GDSCs */
+#define PCIE_GDSC			0
+#define PCIE_0_GDSC			1
+#define PCIE_1_GDSC			2
+#define USB30_GDSC			3
+#define UFS_GDSC			4
+
+/* Resets */
+#define USB3_PHY_RESET			0
+#define USB3PHY_PHY_RESET		1
+#define PCIE_PHY_0_RESET		2
+#define PCIE_PHY_1_RESET		3
+#define QUSB2_PHY_RESET			4
 
 #endif
-- 
2.28.0

