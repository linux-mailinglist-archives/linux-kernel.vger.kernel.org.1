Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E896C2F0019
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 14:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbhAINrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 08:47:07 -0500
Received: from relay08.th.seeweb.it ([5.144.164.169]:36491 "EHLO
        relay08.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbhAINrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 08:47:04 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 858DD3EF11;
        Sat,  9 Jan 2021 14:46:21 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH 5/9] clk: qcom: mmcc-msm8998: Set CLK_GET_RATE_NOCACHE to pixel/byte clks
Date:   Sat,  9 Jan 2021 14:46:13 +0100
Message-Id: <20210109134617.146275-6-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109134617.146275-1-angelogioacchino.delregno@somainline.org>
References: <20210109134617.146275-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pixel and byte clocks rate should not be cached, as a VCO shutdown
may clear the frequency setup and this may not be set again due to the
cached rate being present.
This will also be useful when shadow clocks will be implemented in
the DSI PLL for seamless timing/resolution switch.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/clk/qcom/mmcc-msm8998.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
index dd68983fe22e..475e00a5fdf4 100644
--- a/drivers/clk/qcom/mmcc-msm8998.c
+++ b/drivers/clk/qcom/mmcc-msm8998.c
@@ -520,7 +520,7 @@ static struct clk_rcg2 byte0_clk_src = {
 		.parent_data = mmss_xo_dsibyte,
 		.num_parents = 4,
 		.ops = &clk_byte2_ops,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
 	},
 };
 
@@ -533,7 +533,7 @@ static struct clk_rcg2 byte1_clk_src = {
 		.parent_data = mmss_xo_dsibyte,
 		.num_parents = 4,
 		.ops = &clk_byte2_ops,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
 	},
 };
 
@@ -1084,7 +1084,7 @@ static struct clk_rcg2 pclk0_clk_src = {
 		.parent_data = mmss_xo_dsi0pll_dsi1pll,
 		.num_parents = 4,
 		.ops = &clk_pixel_ops,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
 	},
 };
 
@@ -1098,7 +1098,7 @@ static struct clk_rcg2 pclk1_clk_src = {
 		.parent_data = mmss_xo_dsi0pll_dsi1pll,
 		.num_parents = 4,
 		.ops = &clk_pixel_ops,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
 	},
 };
 
-- 
2.29.2

