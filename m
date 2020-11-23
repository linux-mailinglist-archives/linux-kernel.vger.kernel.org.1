Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7F52C10D6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389998AbgKWQiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389530AbgKWQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:38:20 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887F8C061A4F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:38:20 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id z7so3408271wrn.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5avTsDM6MbYbagqqzSLf9X5FFe4EbwFCqAUyBew2Gc=;
        b=bsiVR9MmCxdO/RJoXzPuNvTXPzqEQFYpuHUMbVD9MgKdaYyyTn/aPe67lcdCK8iI3k
         nvAWR8FhlV9qQohIRFS1h5Jv6FflHtusqkR/UemyvZrq0+H97d8J0QnJoxkvezT+GX4O
         1tYnL7PFm4q2jCob+k5rWmq/u3ZPeh8bEwSrlu9mU56NlIihZF820CE0x72MAamiTPAa
         Nplcl2RRe99ds0zofPuReZuonza8ex3LwkY0rlSN8DZLBw9gVx48cy7tR41t0jURrBy/
         stzihb0S3D9uGqKGJp65KkT+IEvz3G/hGzO6oHsyT6Pn43kA2Fp/XLfx/zyJaAQRcmFh
         0uSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5avTsDM6MbYbagqqzSLf9X5FFe4EbwFCqAUyBew2Gc=;
        b=bBVId2jzbhbM8/lfBe3rJGkitX5c/eZ5iExz/W/ZvZblrgQzmv/35snSAz9WOzx7ER
         8czJ767qWUWmuRjBR6rjkmTYBCP+6GlWKomOQKP9FAC+hk8XYUg00gRJ/08BvCKAMqe9
         Y2ag2bPUV59BWsLD0X3A4cwzplWfyxywNT8z+CZMtgK8jB+tf0XtUpxfazvVQK95lUSN
         33zEquejZS49vRF3/Rv/rVwDnEyjI3I3Qe0Ri/pml1RwHWl8a26niI50cnZUYY2Es2CI
         ru2ER4xX3pZRbUWvQ60abQXRjD3nobEP48Z6HDOT4OGg6u58YnY7h8xDCev6MbZ+kXEd
         NaXQ==
X-Gm-Message-State: AOAM533Ok2JzM0I19lhD4KClB4sKyLlGJU9GNZhf6sYU9oWLqEk0MuLT
        nO14dP5rf3BPNQXb/IL6oTrOzA==
X-Google-Smtp-Source: ABdhPJx6pAjMpdAe+9714Rlp3PkaN3t2kdqPdj4MSGVV16wLMsTmu04aZ4SPTNOhvLbSm6jE7O4Mcw==
X-Received: by 2002:a5d:6050:: with SMTP id j16mr589970wrt.158.1606149499088;
        Mon, 23 Nov 2020 08:38:19 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:9541:d2fd:3a68:67ae])
        by smtp.gmail.com with ESMTPSA id l3sm19566386wmf.0.2020.11.23.08.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:38:18 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] clk: meson: g12a: add MIPI DSI Host Pixel Clock
Date:   Mon, 23 Nov 2020 17:38:11 +0100
Message-Id: <20201123163811.353444-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123163811.353444-1-narmstrong@baylibre.com>
References: <20201123163811.353444-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the MIPI DSI Host Pixel Clock, unlike AXG, the pixel clock can be different
from the VPU ENCL output clock to feed the DSI Host controller with a different clock rate.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.c | 72 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h |  3 +-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 3cb8196c8e29..3dedf8408405 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -3658,6 +3658,66 @@ static struct clk_regmap g12a_hdmi_tx = {
 	},
 };
 
+/* MIPI DSI Host Clocks */
+
+static const struct clk_hw *g12a_mipi_dsi_pxclk_parent_hws[] = {
+	&g12a_vid_pll.hw,
+	&g12a_gp0_pll.hw,
+	&g12a_hifi_pll.hw,
+	&g12a_mpll1.hw,
+	&g12a_fclk_div2.hw,
+	&g12a_fclk_div2p5.hw,
+	&g12a_fclk_div3.hw,
+	&g12a_fclk_div7.hw,
+};
+
+static struct clk_regmap g12a_mipi_dsi_pxclk_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_MIPIDSI_PHY_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 12,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mipi_dsi_pxclk_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = g12a_mipi_dsi_pxclk_parent_hws,
+		.num_parents = ARRAY_SIZE(g12a_mipi_dsi_pxclk_parent_hws),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap g12a_mipi_dsi_pxclk_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_MIPIDSI_PHY_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mipi_dsi_pxclk_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+					&g12a_mipi_dsi_pxclk_sel.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap g12a_mipi_dsi_pxclk = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MIPIDSI_PHY_CLK_CNTL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "mipi_dsi_pxclk",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+					&g12a_mipi_dsi_pxclk_div.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 /* HDMI Clocks */
 
 static const struct clk_parent_data g12a_hdmi_parent_data[] = {
@@ -4403,6 +4463,9 @@ static struct clk_hw_onecell_data g12a_hw_onecell_data = {
 		[CLKID_SPICC1_SCLK_SEL]		= &g12a_spicc1_sclk_sel.hw,
 		[CLKID_SPICC1_SCLK_DIV]		= &g12a_spicc1_sclk_div.hw,
 		[CLKID_SPICC1_SCLK]		= &g12a_spicc1_sclk.hw,
+		[CLKID_MIPI_DSI_PXCLK_SEL]	= &g12a_mipi_dsi_pxclk_sel.hw,
+		[CLKID_MIPI_DSI_PXCLK_DIV]	= &g12a_mipi_dsi_pxclk_div.hw,
+		[CLKID_MIPI_DSI_PXCLK]		= &g12a_mipi_dsi_pxclk.hw,
 		[NR_CLKS]			= NULL,
 	},
 	.num = NR_CLKS,
@@ -4658,6 +4721,9 @@ static struct clk_hw_onecell_data g12b_hw_onecell_data = {
 		[CLKID_SPICC1_SCLK_SEL]		= &g12a_spicc1_sclk_sel.hw,
 		[CLKID_SPICC1_SCLK_DIV]		= &g12a_spicc1_sclk_div.hw,
 		[CLKID_SPICC1_SCLK]		= &g12a_spicc1_sclk.hw,
+		[CLKID_MIPI_DSI_PXCLK_SEL]	= &g12a_mipi_dsi_pxclk_sel.hw,
+		[CLKID_MIPI_DSI_PXCLK_DIV]	= &g12a_mipi_dsi_pxclk_div.hw,
+		[CLKID_MIPI_DSI_PXCLK]		= &g12a_mipi_dsi_pxclk.hw,
 		[NR_CLKS]			= NULL,
 	},
 	.num = NR_CLKS,
@@ -4904,6 +4970,9 @@ static struct clk_hw_onecell_data sm1_hw_onecell_data = {
 		[CLKID_NNA_CORE_CLK_SEL]	= &sm1_nna_core_clk_sel.hw,
 		[CLKID_NNA_CORE_CLK_DIV]	= &sm1_nna_core_clk_div.hw,
 		[CLKID_NNA_CORE_CLK]		= &sm1_nna_core_clk.hw,
+		[CLKID_MIPI_DSI_PXCLK_SEL]	= &g12a_mipi_dsi_pxclk_sel.hw,
+		[CLKID_MIPI_DSI_PXCLK_DIV]	= &g12a_mipi_dsi_pxclk_div.hw,
+		[CLKID_MIPI_DSI_PXCLK]		= &g12a_mipi_dsi_pxclk.hw,
 		[NR_CLKS]			= NULL,
 	},
 	.num = NR_CLKS,
@@ -5151,6 +5220,9 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&sm1_nna_core_clk_sel,
 	&sm1_nna_core_clk_div,
 	&sm1_nna_core_clk,
+	&g12a_mipi_dsi_pxclk_sel,
+	&g12a_mipi_dsi_pxclk_div,
+	&g12a_mipi_dsi_pxclk,
 };
 
 static const struct reg_sequence g12a_init_regs[] = {
diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
index 69b6a69549c7..a97613df38b3 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -264,8 +264,9 @@
 #define CLKID_NNA_AXI_CLK_DIV			263
 #define CLKID_NNA_CORE_CLK_SEL			265
 #define CLKID_NNA_CORE_CLK_DIV			266
+#define CLKID_MIPI_DSI_PXCLK_DIV		268
 
-#define NR_CLKS					268
+#define NR_CLKS					271
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/g12a-clkc.h>
-- 
2.25.1

