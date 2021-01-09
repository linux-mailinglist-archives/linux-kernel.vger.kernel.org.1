Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA4B2F002C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 14:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbhAINr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 08:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbhAINr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 08:47:57 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D1CC0617A6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 05:46:23 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D570A3EF16;
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
Subject: [PATCH 6/9] clk: qcom: mmcc-msm8998: Add hardware clockgating registers to some clks
Date:   Sat,  9 Jan 2021 14:46:14 +0100
Message-Id: <20210109134617.146275-7-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109134617.146275-1-angelogioacchino.delregno@somainline.org>
References: <20210109134617.146275-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware clock gating is supported on some of the clocks declared in
there: ignoring that it does exist may lead to unstabilities on some
firmwares.
Add the HWCG registers where applicable to stop potential crashes.

This was verified on a smartphone shipped with a recent MSM8998
firmware, which will experience random crashes without this change.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/clk/qcom/mmcc-msm8998.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
index 475e00a5fdf4..f9510a248a36 100644
--- a/drivers/clk/qcom/mmcc-msm8998.c
+++ b/drivers/clk/qcom/mmcc-msm8998.c
@@ -1211,6 +1211,8 @@ static struct clk_rcg2 vfe1_clk_src = {
 
 static struct clk_branch misc_ahb_clk = {
 	.halt_reg = 0x328,
+	.hwcg_reg = 0x328,
+	.hwcg_bit = 1,
 	.clkr = {
 		.enable_reg = 0x328,
 		.enable_mask = BIT(0),
@@ -1241,6 +1243,8 @@ static struct clk_branch video_core_clk = {
 
 static struct clk_branch video_ahb_clk = {
 	.halt_reg = 0x1030,
+	.hwcg_reg = 0x1030,
+	.hwcg_bit = 1,
 	.clkr = {
 		.enable_reg = 0x1030,
 		.enable_mask = BIT(0),
@@ -1315,6 +1319,8 @@ static struct clk_branch video_subcore1_clk = {
 
 static struct clk_branch mdss_ahb_clk = {
 	.halt_reg = 0x2308,
+	.hwcg_reg = 0x2308,
+	.hwcg_bit = 1,
 	.clkr = {
 		.enable_reg = 0x2308,
 		.enable_mask = BIT(0),
@@ -2496,6 +2502,8 @@ static struct clk_branch mnoc_ahb_clk = {
 
 static struct clk_branch bimc_smmu_ahb_clk = {
 	.halt_reg = 0xe004,
+	.hwcg_reg = 0xe004,
+	.hwcg_bit = 1,
 	.clkr = {
 		.enable_reg = 0xe004,
 		.enable_mask = BIT(0),
@@ -2511,6 +2519,8 @@ static struct clk_branch bimc_smmu_ahb_clk = {
 
 static struct clk_branch bimc_smmu_axi_clk = {
 	.halt_reg = 0xe008,
+	.hwcg_reg = 0xe008,
+	.hwcg_bit = 1,
 	.clkr = {
 		.enable_reg = 0xe008,
 		.enable_mask = BIT(0),
-- 
2.29.2

