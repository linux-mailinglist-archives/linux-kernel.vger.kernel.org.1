Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2A829DB67
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390025AbgJ1XyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389251AbgJ1Xxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:53:40 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A42C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:53:39 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id c72so1416021oig.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N1e+BCUO8+mC+KGj3wF6VbxXngF455cwAyIY2MXIsus=;
        b=T4akp1adQjfEMeMUkRQLY2gIoJxbAqURtyQkMnoZfCD/A2ry20rAQC0MDR1mw/5eMn
         AccPBVtonvLQBk3lGl43lz8z81JX091UHLJlF+mc/ifyPI8eTU0Z6+6jFh6Z22eHwe8r
         RH8lRbc4rbm+pRSW14ipcj+IFRNGJGI51n4ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N1e+BCUO8+mC+KGj3wF6VbxXngF455cwAyIY2MXIsus=;
        b=NH75oG4RQVjCITfb5rp4lLngC90ABlBty+vbbUdaKFs7b9Jxae5jVvl7bj87SbdS8n
         BD2jdqVIaVT7ZuDTMp9pba0R7Yc0a/ICxUAy7hvSxcbd3zhxiGOno6OWTn9MlXOf1CMG
         u0jjpfeQmsE5V3BY350P6jzrfP4HFaU90ZA9LfA//5rKO4/Yq2XTg+d9sF9y4Sa3TAfj
         8OOVgo4zam0OLSkCi8mh0uauKLDx103zcEHpvODh4XUhx3Xy3gQMhKV+IUON4vF2g24w
         VOkLqRkRva8tYHuSoSfkEjXgKlCdbJuubUh9/7tGKwznO/005onFohCZOsxoafkS0sKV
         m6aw==
X-Gm-Message-State: AOAM5307gzsWfg9zDu6Swmw54yINd2k/aqtLw/G1ZVRNxcFZd2zfDs6u
        41VOMopFQXZ/qrRnrqC4T6W9bItHCpsc7g==
X-Google-Smtp-Source: ABdhPJwnjQTcWIA/6CuB2hDSWT2aMZRnBt3BMZjtD+24pK9KNRbtUAqRrBQdIkPWLNxDdPMhYOmzkA==
X-Received: by 2002:a17:90a:14a4:: with SMTP id k33mr6299169pja.236.1603885400385;
        Wed, 28 Oct 2020 04:43:20 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7a4:2d09:2940:d772:8d5])
        by smtp.gmail.com with ESMTPSA id 10sm5350214pjt.50.2020.10.28.04.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 04:43:19 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Kever Yang <kever.yang@rock-chips.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2] clk: rockchip: Limit input rate for fractional approximation
Date:   Wed, 28 Oct 2020 17:12:59 +0530
Message-Id: <20201028114259.219698-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fractional approximation in some rockchip families can be generated
based on the fractional divider and the input clock frequency of
fractional divider should be less than a specified value.
.i.e:
            |--\
---[GPLL]---|   \                                      |--\
---[CPLL]---|mux|--[GATE]--[DIV]-----------------------|   \
---[NPLL]---|   /                |                     |mux|--[GATE]--
            |--/                 |--[GATE]--[FRACDIV]--|   /
                                                       |--/

The FRACDIV frequency is designed to be only 300M(Different SOC
implementations are different).But the GPLL or CPLL may be 1200M.
Must be added to limit to ensure that the design is not exceeded.

This patch is trying to support this fractional approximation on
PX30 platform with input limit rate of 600MHz.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- v2 version patch from previous patch
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20200831161436.134186-1-jagan@amarulasolutions.com/
- support input limit rate for frac approx.

 drivers/clk/rockchip/clk-px30.c | 69 +++++++++++++++++----------------
 drivers/clk/rockchip/clk.c      | 31 ++++++++++++---
 drivers/clk/rockchip/clk.h      | 21 ++++++++++
 include/linux/clk-provider.h    |  2 +
 4 files changed, 84 insertions(+), 39 deletions(-)

diff --git a/drivers/clk/rockchip/clk-px30.c b/drivers/clk/rockchip/clk-px30.c
index 6fb9c98b7d24..34e4c02d3cb1 100644
--- a/drivers/clk/rockchip/clk-px30.c
+++ b/drivers/clk/rockchip/clk-px30.c
@@ -13,6 +13,7 @@
 #include "clk.h"
 
 #define PX30_GRF_SOC_STATUS0		0x480
+#define PX30_FRAC_CLK_LIMIT		600000000
 
 enum px30_plls {
 	apll, dpll, cpll, npll, apll_b_h, apll_b_l,
@@ -421,19 +422,19 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 	COMPOSITE(0, "dclk_vopb_src", mux_cpll_npll_p, CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			PX30_CLKSEL_CON(5), 11, 1, MFLAGS, 0, 8, DFLAGS,
 			PX30_CLKGATE_CON(2), 2, GFLAGS),
-	COMPOSITE_FRACMUX(0, "dclk_vopb_frac", "dclk_vopb_src", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX_LIMIT(0, "dclk_vopb_frac", "dclk_vopb_src", CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(6), 0,
 			PX30_CLKGATE_CON(2), 3, GFLAGS,
-			&px30_dclk_vopb_fracmux),
+			&px30_dclk_vopb_fracmux, PX30_FRAC_CLK_LIMIT),
 	GATE(DCLK_VOPB, "dclk_vopb", "dclk_vopb_mux", CLK_SET_RATE_PARENT,
 			PX30_CLKGATE_CON(2), 4, GFLAGS),
 	COMPOSITE(0, "dclk_vopl_src", mux_npll_cpll_p, 0,
 			PX30_CLKSEL_CON(8), 11, 1, MFLAGS, 0, 8, DFLAGS,
 			PX30_CLKGATE_CON(2), 6, GFLAGS),
-	COMPOSITE_FRACMUX(0, "dclk_vopl_frac", "dclk_vopl_src", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX_LIMIT(0, "dclk_vopl_frac", "dclk_vopl_src", CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(9), 0,
 			PX30_CLKGATE_CON(2), 7, GFLAGS,
-			&px30_dclk_vopl_fracmux),
+			&px30_dclk_vopl_fracmux, PX30_FRAC_CLK_LIMIT),
 	GATE(DCLK_VOPL, "dclk_vopl", "dclk_vopl_mux", CLK_SET_RATE_PARENT,
 			PX30_CLKGATE_CON(2), 8, GFLAGS),
 
@@ -588,20 +589,20 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 	COMPOSITE(0, "clk_pdm_src", mux_gpll_xin24m_npll_p, 0,
 			PX30_CLKSEL_CON(26), 8, 2, MFLAGS, 0, 7, DFLAGS,
 			PX30_CLKGATE_CON(9), 9, GFLAGS),
-	COMPOSITE_FRACMUX(0, "clk_pdm_frac", "clk_pdm_src", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX_LIMIT(0, "clk_pdm_frac", "clk_pdm_src", CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(27), 0,
 			PX30_CLKGATE_CON(9), 10, GFLAGS,
-			&px30_pdm_fracmux),
+			&px30_pdm_fracmux, PX30_FRAC_CLK_LIMIT),
 	GATE(SCLK_PDM, "clk_pdm", "clk_pdm_mux", CLK_SET_RATE_PARENT,
 			PX30_CLKGATE_CON(9), 11, GFLAGS),
 
 	COMPOSITE(0, "clk_i2s0_tx_src", mux_gpll_npll_p, 0,
 			PX30_CLKSEL_CON(28), 8, 1, MFLAGS, 0, 7, DFLAGS,
 			PX30_CLKGATE_CON(9), 12, GFLAGS),
-	COMPOSITE_FRACMUX(0, "clk_i2s0_tx_frac", "clk_i2s0_tx_src", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX_LIMIT(0, "clk_i2s0_tx_frac", "clk_i2s0_tx_src", CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(29), 0,
 			PX30_CLKGATE_CON(9), 13, GFLAGS,
-			&px30_i2s0_tx_fracmux),
+			&px30_i2s0_tx_fracmux, PX30_FRAC_CLK_LIMIT),
 	COMPOSITE_NODIV(SCLK_I2S0_TX, "clk_i2s0_tx", mux_i2s0_tx_rx_p, CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(28), 12, 1, MFLAGS,
 			PX30_CLKGATE_CON(9), 14, GFLAGS),
@@ -614,10 +615,10 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 	COMPOSITE(0, "clk_i2s0_rx_src", mux_gpll_npll_p, 0,
 			PX30_CLKSEL_CON(58), 8, 1, MFLAGS, 0, 7, DFLAGS,
 			PX30_CLKGATE_CON(17), 0, GFLAGS),
-	COMPOSITE_FRACMUX(0, "clk_i2s0_rx_frac", "clk_i2s0_rx_src", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX_LIMIT(0, "clk_i2s0_rx_frac", "clk_i2s0_rx_src", CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(59), 0,
 			PX30_CLKGATE_CON(17), 1, GFLAGS,
-			&px30_i2s0_rx_fracmux),
+			&px30_i2s0_rx_fracmux, PX30_FRAC_CLK_LIMIT),
 	COMPOSITE_NODIV(SCLK_I2S0_RX, "clk_i2s0_rx", mux_i2s0_rx_tx_p, CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(58), 12, 1, MFLAGS,
 			PX30_CLKGATE_CON(17), 2, GFLAGS),
@@ -630,10 +631,10 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 	COMPOSITE(0, "clk_i2s1_src", mux_gpll_npll_p, 0,
 			PX30_CLKSEL_CON(30), 8, 1, MFLAGS, 0, 7, DFLAGS,
 			PX30_CLKGATE_CON(10), 0, GFLAGS),
-	COMPOSITE_FRACMUX(0, "clk_i2s1_frac", "clk_i2s1_src", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX_LIMIT(0, "clk_i2s1_frac", "clk_i2s1_src", CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(31), 0,
 			PX30_CLKGATE_CON(10), 1, GFLAGS,
-			&px30_i2s1_fracmux),
+			&px30_i2s1_fracmux, PX30_FRAC_CLK_LIMIT),
 	GATE(SCLK_I2S1, "clk_i2s1", "clk_i2s1_mux", CLK_SET_RATE_PARENT,
 			PX30_CLKGATE_CON(10), 2, GFLAGS),
 	COMPOSITE_NODIV(0, "clk_i2s1_out_pre", mux_i2s1_out_p, 0,
@@ -645,10 +646,10 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 	COMPOSITE(0, "clk_i2s2_src", mux_gpll_npll_p, 0,
 			PX30_CLKSEL_CON(32), 8, 1, MFLAGS, 0, 7, DFLAGS,
 			PX30_CLKGATE_CON(10), 4, GFLAGS),
-	COMPOSITE_FRACMUX(0, "clk_i2s2_frac", "clk_i2s2_src", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX_LIMIT(0, "clk_i2s2_frac", "clk_i2s2_src", CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(33), 0,
 			PX30_CLKGATE_CON(10), 5, GFLAGS,
-			&px30_i2s2_fracmux),
+			&px30_i2s2_fracmux, PX30_FRAC_CLK_LIMIT),
 	GATE(SCLK_I2S2, "clk_i2s2", "clk_i2s2_mux", CLK_SET_RATE_PARENT,
 			PX30_CLKGATE_CON(10), 6, GFLAGS),
 	COMPOSITE_NODIV(0, "clk_i2s2_out_pre", mux_i2s2_out_p, 0,
@@ -660,65 +661,65 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 	COMPOSITE(SCLK_UART1_SRC, "clk_uart1_src", mux_uart_src_p, CLK_SET_RATE_NO_REPARENT,
 			PX30_CLKSEL_CON(34), 14, 2, MFLAGS, 0, 5, DFLAGS,
 			PX30_CLKGATE_CON(10), 12, GFLAGS),
-	COMPOSITE_NOMUX_HALFDIV(0, "clk_uart1_np5", "clk_uart1_src", 0,
+	COMPOSITE_NOMUX_HALFDIV(0, "clk_uart1_np5", "clk_uart1_src", CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(35), 0, 5, DFLAGS,
 			PX30_CLKGATE_CON(10), 13, GFLAGS),
-	COMPOSITE_FRACMUX(0, "clk_uart1_frac", "clk_uart1_src", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX_LIMIT(0, "clk_uart1_frac", "clk_uart1_src", CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(36), 0,
 			PX30_CLKGATE_CON(10), 14, GFLAGS,
-			&px30_uart1_fracmux),
+			&px30_uart1_fracmux, PX30_FRAC_CLK_LIMIT),
 	GATE(SCLK_UART1, "clk_uart1", "clk_uart1_mux", CLK_SET_RATE_PARENT,
 			PX30_CLKGATE_CON(10), 15, GFLAGS),
 
 	COMPOSITE(SCLK_UART2_SRC, "clk_uart2_src", mux_uart_src_p, 0,
 			PX30_CLKSEL_CON(37), 14, 2, MFLAGS, 0, 5, DFLAGS,
 			PX30_CLKGATE_CON(11), 0, GFLAGS),
-	COMPOSITE_NOMUX_HALFDIV(0, "clk_uart2_np5", "clk_uart2_src", 0,
+	COMPOSITE_NOMUX_HALFDIV(0, "clk_uart2_np5", "clk_uart2_src", CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(38), 0, 5, DFLAGS,
 			PX30_CLKGATE_CON(11), 1, GFLAGS),
-	COMPOSITE_FRACMUX(0, "clk_uart2_frac", "clk_uart2_src", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX_LIMIT(0, "clk_uart2_frac", "clk_uart2_src", CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(39), 0,
 			PX30_CLKGATE_CON(11), 2, GFLAGS,
-			&px30_uart2_fracmux),
+			&px30_uart2_fracmux, PX30_FRAC_CLK_LIMIT),
 	GATE(SCLK_UART2, "clk_uart2", "clk_uart2_mux", CLK_SET_RATE_PARENT,
 			PX30_CLKGATE_CON(11), 3, GFLAGS),
 
 	COMPOSITE(0, "clk_uart3_src", mux_uart_src_p, 0,
 			PX30_CLKSEL_CON(40), 14, 2, MFLAGS, 0, 5, DFLAGS,
 			PX30_CLKGATE_CON(11), 4, GFLAGS),
-	COMPOSITE_NOMUX_HALFDIV(0, "clk_uart3_np5", "clk_uart3_src", 0,
+	COMPOSITE_NOMUX_HALFDIV(0, "clk_uart3_np5", "clk_uart3_src", CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(41), 0, 5, DFLAGS,
 			PX30_CLKGATE_CON(11), 5, GFLAGS),
-	COMPOSITE_FRACMUX(0, "clk_uart3_frac", "clk_uart3_src", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX_LIMIT(0, "clk_uart3_frac", "clk_uart3_src", CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(42), 0,
 			PX30_CLKGATE_CON(11), 6, GFLAGS,
-			&px30_uart3_fracmux),
+			&px30_uart3_fracmux, PX30_FRAC_CLK_LIMIT),
 	GATE(SCLK_UART3, "clk_uart3", "clk_uart3_mux", CLK_SET_RATE_PARENT,
 			PX30_CLKGATE_CON(11), 7, GFLAGS),
 
 	COMPOSITE(0, "clk_uart4_src", mux_uart_src_p, 0,
 			PX30_CLKSEL_CON(43), 14, 2, MFLAGS, 0, 5, DFLAGS,
 			PX30_CLKGATE_CON(11), 8, GFLAGS),
-	COMPOSITE_NOMUX_HALFDIV(0, "clk_uart4_np5", "clk_uart4_src", 0,
+	COMPOSITE_NOMUX_HALFDIV(0, "clk_uart4_np5", "clk_uart4_src", CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(44), 0, 5, DFLAGS,
 			PX30_CLKGATE_CON(11), 9, GFLAGS),
-	COMPOSITE_FRACMUX(0, "clk_uart4_frac", "clk_uart4_src", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX_LIMIT(0, "clk_uart4_frac", "clk_uart4_src", CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(45), 0,
 			PX30_CLKGATE_CON(11), 10, GFLAGS,
-			&px30_uart4_fracmux),
+			&px30_uart4_fracmux, PX30_FRAC_CLK_LIMIT),
 	GATE(SCLK_UART4, "clk_uart4", "clk_uart4_mux", CLK_SET_RATE_PARENT,
 			PX30_CLKGATE_CON(11), 11, GFLAGS),
 
 	COMPOSITE(0, "clk_uart5_src", mux_uart_src_p, 0,
 			PX30_CLKSEL_CON(46), 14, 2, MFLAGS, 0, 5, DFLAGS,
 			PX30_CLKGATE_CON(11), 12, GFLAGS),
-	COMPOSITE_NOMUX_HALFDIV(0, "clk_uart5_np5", "clk_uart5_src", 0,
+	COMPOSITE_NOMUX_HALFDIV(0, "clk_uart5_np5", "clk_uart5_src", CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(47), 0, 5, DFLAGS,
 			PX30_CLKGATE_CON(11), 13, GFLAGS),
-	COMPOSITE_FRACMUX(0, "clk_uart5_frac", "clk_uart5_src", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX_LIMIT(0, "clk_uart5_frac", "clk_uart5_src", CLK_SET_RATE_PARENT,
 			PX30_CLKSEL_CON(48), 0,
 			PX30_CLKGATE_CON(11), 14, GFLAGS,
-			&px30_uart5_fracmux),
+			&px30_uart5_fracmux, PX30_FRAC_CLK_LIMIT),
 	GATE(SCLK_UART5, "clk_uart5", "clk_uart5_mux", CLK_SET_RATE_PARENT,
 			PX30_CLKGATE_CON(11), 15, GFLAGS),
 
@@ -915,10 +916,10 @@ static struct rockchip_clk_branch px30_clk_pmu_branches[] __initdata = {
 	 * Clock-Architecture Diagram 2
 	 */
 
-	COMPOSITE_FRACMUX(0, "clk_rtc32k_frac", "xin24m", CLK_IGNORE_UNUSED,
+	COMPOSITE_FRACMUX_LIMIT(0, "clk_rtc32k_frac", "xin24m", CLK_IGNORE_UNUSED,
 			PX30_PMU_CLKSEL_CON(1), 0,
 			PX30_PMU_CLKGATE_CON(0), 13, GFLAGS,
-			&px30_rtc32k_pmu_fracmux),
+			&px30_rtc32k_pmu_fracmux, 0),
 
 	COMPOSITE_NOMUX(XIN24M_DIV, "xin24m_div", "xin24m", CLK_IGNORE_UNUSED,
 			PX30_PMU_CLKSEL_CON(0), 8, 5, DFLAGS,
@@ -934,13 +935,13 @@ static struct rockchip_clk_branch px30_clk_pmu_branches[] __initdata = {
 	COMPOSITE(0, "clk_uart0_pmu_src", mux_uart_src_p, 0,
 			PX30_PMU_CLKSEL_CON(3), 14, 2, MFLAGS, 0, 5, DFLAGS,
 			PX30_PMU_CLKGATE_CON(1), 0, GFLAGS),
-	COMPOSITE_NOMUX_HALFDIV(0, "clk_uart0_np5", "clk_uart0_pmu_src", 0,
+	COMPOSITE_NOMUX_HALFDIV(0, "clk_uart0_np5", "clk_uart0_pmu_src", CLK_SET_RATE_PARENT,
 			PX30_PMU_CLKSEL_CON(4), 0, 5, DFLAGS,
 			PX30_PMU_CLKGATE_CON(1), 1, GFLAGS),
-	COMPOSITE_FRACMUX(0, "clk_uart0_frac", "clk_uart0_pmu_src", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX_LIMIT(0, "clk_uart0_frac", "clk_uart0_pmu_src", CLK_SET_RATE_PARENT,
 			PX30_PMU_CLKSEL_CON(5), 0,
 			PX30_PMU_CLKGATE_CON(1), 2, GFLAGS,
-			&px30_uart0_pmu_fracmux),
+			&px30_uart0_pmu_fracmux, PX30_FRAC_CLK_LIMIT),
 	GATE(SCLK_UART0_PMU, "clk_uart0_pmu", "clk_uart0_pmu_mux", CLK_SET_RATE_PARENT,
 			PX30_PMU_CLKGATE_CON(1), 3, GFLAGS),
 
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index b443169dd408..9055725af6c5 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -182,12 +182,32 @@ static void rockchip_fractional_approximation(struct clk_hw *hw,
 	unsigned long p_rate, p_parent_rate;
 	struct clk_hw *p_parent;
 	unsigned long scale;
+	u32 div;
 
 	p_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
-	if ((rate * 20 > p_rate) && (p_rate % rate != 0)) {
+	if (((rate * 20 > p_rate) && (p_rate % rate != 0)) ||
+	    (fd->max_prate && fd->max_prate < p_rate)) {
 		p_parent = clk_hw_get_parent(clk_hw_get_parent(hw));
-		p_parent_rate = clk_hw_get_rate(p_parent);
-		*parent_rate = p_parent_rate;
+		if (!p_parent) {
+			*parent_rate = p_rate;
+		} else {
+			/* support fractional divider for one level parent clock */
+			p_parent_rate = clk_hw_get_rate(p_parent);
+			*parent_rate = p_parent_rate;
+			if (fd->max_prate && p_parent_rate > fd->max_prate) {
+				div = DIV_ROUND_UP(p_parent_rate,
+						   fd->max_prate);
+				*parent_rate = p_parent_rate / div;
+			}
+		}
+
+		if (*parent_rate < rate * 20) {
+			pr_warn("%s p_rate(%ld) is low than rate(%ld)*20, use integer or half-div\n",
+				clk_hw_get_name(hw), *parent_rate, rate);
+			*m = 0;
+			*n = 1;
+			return;
+		}
 	}
 
 	/*
@@ -210,7 +230,7 @@ static struct clk *rockchip_clk_register_frac_branch(
 		void __iomem *base, int muxdiv_offset, u8 div_flags,
 		int gate_offset, u8 gate_shift, u8 gate_flags,
 		unsigned long flags, struct rockchip_clk_branch *child,
-		spinlock_t *lock)
+		unsigned long max_prate, spinlock_t *lock)
 {
 	struct clk_hw *hw;
 	struct rockchip_clk_frac *frac;
@@ -251,6 +271,7 @@ static struct clk *rockchip_clk_register_frac_branch(
 	div->nmask = GENMASK(div->nwidth - 1, 0) << div->nshift;
 	div->lock = lock;
 	div->approximation = rockchip_fractional_approximation;
+	div->max_prate = max_prate;
 	div_ops = &clk_fractional_divider_ops;
 
 	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
@@ -488,7 +509,7 @@ void rockchip_clk_register_branches(struct rockchip_clk_provider *ctx,
 				list->div_flags,
 				list->gate_offset, list->gate_shift,
 				list->gate_flags, flags, list->child,
-				&ctx->lock);
+				list->max_prate, &ctx->lock);
 			break;
 		case branch_half_divider:
 			clk = rockchip_clk_register_halfdiv(list->name,
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 2271a84124b0..fb37e5919cf6 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -420,6 +420,7 @@ struct rockchip_clk_branch {
 	u8				gate_shift;
 	u8				gate_flags;
 	struct rockchip_clk_branch	*child;
+	unsigned long			max_prate;
 };
 
 #define COMPOSITE(_id, cname, pnames, f, mo, ms, mw, mf, ds, dw,\
@@ -594,6 +595,26 @@ struct rockchip_clk_branch {
 		.child		= ch,				\
 	}
 
+#define COMPOSITE_FRACMUX_LIMIT(_id, cname, pname, f, mo, df,	\
+				go, gs, gf, ch, prate) \
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_fraction_divider,	\
+		.name		= cname,			\
+		.parent_names	= (const char *[]){ pname },	\
+		.num_parents	= 1,				\
+		.flags		= f,				\
+		.muxdiv_offset	= mo,				\
+		.div_shift	= 16,				\
+		.div_width	= 16,				\
+		.div_flags	= df,				\
+		.gate_offset	= go,				\
+		.gate_shift	= gs,				\
+		.gate_flags	= gf,				\
+		.child		= ch,				\
+		.max_prate	= prate,			\
+	}
+
 #define COMPOSITE_FRACMUX_NOGATE(_id, cname, pname, f, mo, df, ch) \
 	{							\
 		.id		= _id,				\
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 03a5de5f99f4..b6b28a097526 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -924,6 +924,7 @@ void clk_hw_unregister_fixed_factor(struct clk_hw *hw);
  * @mwidth:	width of the numerator bit field
  * @nshift:	shift to the denominator bit field
  * @nwidth:	width of the denominator bit field
+ * @max_parent:	the maximum frequency of fractional divider parent clock
  * @lock:	register lock
  *
  * Clock with adjustable fractional divider affecting its output frequency.
@@ -947,6 +948,7 @@ struct clk_fractional_divider {
 	u8		nwidth;
 	u32		nmask;
 	u8		flags;
+	unsigned long	max_prate;
 	void		(*approximation)(struct clk_hw *hw,
 				unsigned long rate, unsigned long *parent_rate,
 				unsigned long *m, unsigned long *n);
-- 
2.25.1

