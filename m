Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0546B2CBED4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388887AbgLBN4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:56:09 -0500
Received: from foss.arm.com ([217.140.110.172]:40468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbgLBN4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:56:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C7DD139F;
        Wed,  2 Dec 2020 05:54:49 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF67D3F718;
        Wed,  2 Dec 2020 05:54:47 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.xyz>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH 6/8] mmc: sunxi: add support for A100 mmc controller
Date:   Wed,  2 Dec 2020 13:54:07 +0000
Message-Id: <20201202135409.13683-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20201202135409.13683-1-andre.przywara@arm.com>
References: <20201202135409.13683-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

This patch adds support for A100 MMC controller, which use word address
for internal dma.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/mmc/host/sunxi-mmc.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index fc62773602ec..1518b64112b7 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -244,6 +244,7 @@ struct sunxi_idma_des {
 
 struct sunxi_mmc_cfg {
 	u32 idma_des_size_bits;
+	u32 idma_des_shift;
 	const struct sunxi_mmc_clk_delay *clk_delays;
 
 	/* does the IP block support autocalibration? */
@@ -343,7 +344,7 @@ static int sunxi_mmc_init_host(struct sunxi_mmc_host *host)
 	/* Enable CEATA support */
 	mmc_writel(host, REG_FUNS, SDXC_CEATA_ON);
 	/* Set DMA descriptor list base address */
-	mmc_writel(host, REG_DLBA, host->sg_dma);
+	mmc_writel(host, REG_DLBA, host->sg_dma >> host->cfg->idma_des_shift);
 
 	rval = mmc_readl(host, REG_GCTRL);
 	rval |= SDXC_INTERRUPT_ENABLE_BIT;
@@ -373,8 +374,10 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
 
 		next_desc += sizeof(struct sunxi_idma_des);
 		pdes[i].buf_addr_ptr1 =
-			cpu_to_le32(sg_dma_address(&data->sg[i]));
-		pdes[i].buf_addr_ptr2 = cpu_to_le32((u32)next_desc);
+			cpu_to_le32(sg_dma_address(&data->sg[i]) >>
+				    host->cfg->idma_des_shift);
+		pdes[i].buf_addr_ptr2 = cpu_to_le32((u32)next_desc >>
+						    host->cfg->idma_des_shift);
 	}
 
 	pdes[0].config |= cpu_to_le32(SDXC_IDMAC_DES0_FD);
@@ -1178,6 +1181,23 @@ static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg = {
 	.needs_new_timings = true,
 };
 
+static const struct sunxi_mmc_cfg sun50i_a100_cfg = {
+	.idma_des_size_bits = 16,
+	.idma_des_shift = 2,
+	.clk_delays = NULL,
+	.can_calibrate = true,
+	.mask_data0 = true,
+	.needs_new_timings = true,
+};
+
+static const struct sunxi_mmc_cfg sun50i_a100_emmc_cfg = {
+	.idma_des_size_bits = 13,
+	.idma_des_shift = 2,
+	.clk_delays = NULL,
+	.can_calibrate = true,
+	.needs_new_timings = true,
+};
+
 static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-mmc", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
@@ -1186,6 +1206,8 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg },
 	{ .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
+	{ .compatible = "allwinner,sun50i-a100-mmc", .data = &sun50i_a100_cfg },
+	{ .compatible = "allwinner,sun50i-a100-emmc", .data = &sun50i_a100_emmc_cfg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
-- 
2.17.5

