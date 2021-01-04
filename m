Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287A22E9605
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 14:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbhADNaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 08:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbhADNaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:30:05 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0CBC06179E;
        Mon,  4 Jan 2021 05:29:17 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m5so32122019wrx.9;
        Mon, 04 Jan 2021 05:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W3+FsMu1lbDQIio4q7FHNE16t5hT0RLiFsiQpXFdTmY=;
        b=sqHg7vBu1o3BP2QxT91WFHqL2g78BS1u6AhfTN1DAkUWS/9BRZESyjjDNMxwDMnVyf
         6h6WgnhWuLJysE321kCGfYiOs8lrr21ar0YGTec0NMno+kiNkA/+Pd3gXb6tBEmqtApu
         n/CuH3vijrjaJTYWLSdTyZrIVYyiQr9u8ev/MQJDalyMxaUhwom/w45rR8ZmXWKmyh/r
         Q7t4lJiexvj7GMPUg5mJjgwSD+E7nbahizVC/ypNXgl+F31hseHKX5vJsrCehEY+7pr+
         TS4fHpgEe5UOhq1/S38ee4GQsvTRIy+RouigMdbidLUKavr640bEEgsyeth/inzAUupV
         3zWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W3+FsMu1lbDQIio4q7FHNE16t5hT0RLiFsiQpXFdTmY=;
        b=p6sYXuEskAfit0JyL6BPNHK1ZvRIb7dE/OLz++25P7aFSv7XcsqrKEDa/meWS/R0Mk
         jBnkG4y8v6awQIIIZPM9sODBb+XfDllDUJ/Jk0IQgwu6Z5lB2iLj536HFAG/TFsVP5Mi
         o70xG2NH0LEMG8G7smnJlM2Xfpfhp7X/uEZMpdNiL43ZE4pXs/eA66u+IfGrrgzQBT8e
         OyQkiJe94H0FT3z9VZUn3x34eLjIX2IOX86L5u11Y30b/k7osA3j+LCuvV1cQskAeX8F
         QWZBtU6v3/zfn8rMNzBBX3JHxC9BMo6n9UdnWSj3r12rBCWl4xmfWUdDJR/XRuG/YrZ4
         a9Cg==
X-Gm-Message-State: AOAM530JOxxFOfaQ48lLfH7EKhkh9RlZ1ZiK6FiPJCILt912uvG2Vz8C
        7486bG+Xr6aN0t4zWpc+wjw=
X-Google-Smtp-Source: ABdhPJwr2OufeuaiYtWIqCrZpai6io4a/I1J3LEe+4dG378mGHo/Cv0TSdnz6GxnNT8ny39ULqVJuQ==
X-Received: by 2002:a5d:42d0:: with SMTP id t16mr80111924wrr.230.1609766956653;
        Mon, 04 Jan 2021 05:29:16 -0800 (PST)
Received: from localhost.localdomain (p200300f13724fd00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3724:fd00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c4sm99916521wrw.72.2021.01.04.05.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 05:29:16 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 5/5] clk: meson: meson8b: add the vid_pll_lvds_en gate clock
Date:   Mon,  4 Jan 2021 14:28:06 +0100
Message-Id: <20210104132806.720558-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210104132806.720558-1-martin.blumenstingl@googlemail.com>
References: <20210104132806.720558-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HHI_VID_DIVIDER_CNTL[11] must be enabled for the video clock tree to
work. This bit is described as "LVDS_CLK_EN". It is not 100% clear where
this bit has to be placed in the hierarchy. But since the "LVDS_OUT" of
the HDMI PLL uses it's own set of registers it's more likely that this
"LVDS_CLK_EN" bit actually enables the input of the "hdmi_pll_lvds_out"
clock to the "vid_pll_in_sel" tree.

Add a gate definition for this bit (which will not be exported) so that
the kernel can manage all required bits to enable and disable the video
clocks.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 23 ++++++++++++++++++++++-
 drivers/clk/meson/meson8b.h |  3 ++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 8061c11389a9..450579779de0 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1068,6 +1068,23 @@ static struct clk_regmap meson8b_l2_dram_clk_gate = {
 	},
 };
 
+/* also called LVDS_CLK_EN */
+static struct clk_regmap meson8b_vid_pll_lvds_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_DIVIDER_CNTL,
+		.bit_idx = 11,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vid_pll_lvds_en",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&meson8b_hdmi_pll_lvds_out.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 static struct clk_regmap meson8b_vid_pll_in_sel = {
 	.data = &(struct clk_regmap_mux_data){
 		.offset = HHI_VID_DIVIDER_CNTL,
@@ -1084,7 +1101,7 @@ static struct clk_regmap meson8b_vid_pll_in_sel = {
 		 * Meson8m2: vid2_pll
 		 */
 		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_hdmi_pll_lvds_out.hw
+			&meson8b_vid_pll_lvds_en.hw
 		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -2954,6 +2971,7 @@ static struct clk_hw_onecell_data meson8_hw_onecell_data = {
 		[CLKID_CTS_MCLK_I958_DIV]   = &meson8b_cts_mclk_i958_div.hw,
 		[CLKID_CTS_MCLK_I958]	    = &meson8b_cts_mclk_i958.hw,
 		[CLKID_CTS_I958]	    = &meson8b_cts_i958.hw,
+		[CLKID_VID_PLL_LVDS_EN]	    = &meson8b_vid_pll_lvds_en.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -3171,6 +3189,7 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_CTS_MCLK_I958_DIV]   = &meson8b_cts_mclk_i958_div.hw,
 		[CLKID_CTS_MCLK_I958]	    = &meson8b_cts_mclk_i958.hw,
 		[CLKID_CTS_I958]	    = &meson8b_cts_i958.hw,
+		[CLKID_VID_PLL_LVDS_EN]	    = &meson8b_vid_pll_lvds_en.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -3390,6 +3409,7 @@ static struct clk_hw_onecell_data meson8m2_hw_onecell_data = {
 		[CLKID_CTS_MCLK_I958_DIV]   = &meson8b_cts_mclk_i958_div.hw,
 		[CLKID_CTS_MCLK_I958]	    = &meson8b_cts_mclk_i958.hw,
 		[CLKID_CTS_I958]	    = &meson8b_cts_i958.hw,
+		[CLKID_VID_PLL_LVDS_EN]	    = &meson8b_vid_pll_lvds_en.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -3588,6 +3608,7 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_cts_mclk_i958_div,
 	&meson8b_cts_mclk_i958,
 	&meson8b_cts_i958,
+	&meson8b_vid_pll_lvds_en,
 };
 
 static const struct meson8b_clk_reset_line {
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index b1a5074cf148..954d97cf6c5a 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -182,8 +182,9 @@
 #define CLKID_CTS_MCLK_I958_DIV	211
 #define CLKID_VCLK_EN		214
 #define CLKID_VCLK2_EN		215
+#define CLKID_VID_PLL_LVDS_EN	216
 
-#define CLK_NR_CLKS		216
+#define CLK_NR_CLKS		217
 
 /*
  * include the CLKID and RESETID that have
-- 
2.30.0

