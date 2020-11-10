Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DA92ACFE1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbgKJGkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:40:45 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:60946 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726006AbgKJGkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:40:45 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.316818|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_system_inform|0.414304-0.00181664-0.58388;FP=11418629599924430517|1|1|17|0|-1|-1|-1;HT=ay29a033018047194;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.IuonUmF_1604990436;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IuonUmF_1604990436)
          by smtp.aliyun-inc.com(10.147.40.233);
          Tue, 10 Nov 2020 14:40:40 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     tiny.windzz@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <frank@allwinnertech.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Colin Ian King <colin.king@canonical.com>
Subject: [RESEND PATCH 13/19] phy: sun4i-usb: add support for A100 USB PHY
Date:   Tue, 10 Nov 2020 14:40:32 +0800
Message-Id: <b323d8c7ea4eb6bc325f6a6465cb2547cc6be757.1604988979.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604988979.git.frank@allwinnertech.com>
References: <cover.1604988979.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Add support for a100's usb phy, which with 2 PHYs.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index a6900495baa5..1a0e403131e7 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -107,6 +107,7 @@ enum sun4i_usb_phy_type {
 	sun8i_r40_phy,
 	sun8i_v3s_phy,
 	sun50i_a64_phy,
+	sun50i_a100_phy,
 	sun50i_h6_phy,
 };
 
@@ -289,7 +290,13 @@ static int sun4i_usb_phy_init(struct phy *_phy)
 	}
 
 	if (data->cfg->type == sun8i_a83t_phy ||
+	    data->cfg->type == sun50i_a100_phy ||
 	    data->cfg->type == sun50i_h6_phy) {
+		if (phy->pmu && data->cfg->enable_pmu_unk1) {
+			val = readl(phy->pmu + REG_PMU_UNK1);
+			writel(val & ~BIT(3), phy->pmu + REG_PMU_UNK1);
+		}
+
 		if (phy->index == 0) {
 			val = readl(data->base + data->cfg->phyctl_offset);
 			val |= PHY_CTL_VBUSVLDEXT;
@@ -339,6 +346,7 @@ static int sun4i_usb_phy_exit(struct phy *_phy)
 
 	if (phy->index == 0) {
 		if (data->cfg->type == sun8i_a83t_phy ||
+		    data->cfg->type == sun50i_a100_phy ||
 		    data->cfg->type == sun50i_h6_phy) {
 			void __iomem *phyctl = data->base +
 				data->cfg->phyctl_offset;
@@ -960,6 +968,16 @@ static const struct sun4i_usb_phy_cfg sun50i_a64_cfg = {
 	.phy0_dual_route = true,
 };
 
+static const struct sun4i_usb_phy_cfg sun50i_a100_cfg = {
+	.num_phys = 2,
+	.type = sun50i_a100_phy,
+	.disc_thresh = 3,
+	.phyctl_offset = REG_PHYCTL_A33,
+	.dedicated_clocks = true,
+	.enable_pmu_unk1 = true,
+	.phy0_dual_route = true,
+};
+
 static const struct sun4i_usb_phy_cfg sun50i_h6_cfg = {
 	.num_phys = 4,
 	.type = sun50i_h6_phy,
@@ -983,6 +1001,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	{ .compatible = "allwinner,sun8i-v3s-usb-phy", .data = &sun8i_v3s_cfg },
 	{ .compatible = "allwinner,sun50i-a64-usb-phy",
 	  .data = &sun50i_a64_cfg},
+	{ .compatible = "allwinner,sun50i-a100-usb-phy", .data = &sun50i_a100_cfg },
 	{ .compatible = "allwinner,sun50i-h6-usb-phy", .data = &sun50i_h6_cfg },
 	{ },
 };
-- 
2.28.0

