Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772E02C7811
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 06:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgK2Fqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 00:46:45 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:39782 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2Fqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 00:46:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 9B302201456F;
        Sun, 29 Nov 2020 13:45:42 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Z1g5G2GaXUdd; Sun, 29 Nov 2020 13:45:42 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 8234E20020FC;
        Sun, 29 Nov 2020 13:45:42 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 7C4A6C019E2;
        Sun, 29 Nov 2020 13:45:42 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 7D9EE200756; Sun, 29 Nov 2020 13:45:42 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org, Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 1/2] phy: rockchip: set pulldown for strobe line in dts
Date:   Sun, 29 Nov 2020 13:44:14 +0800
Message-Id: <20201129054416.3980-2-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201129054416.3980-1-chris.ruehl@gtsys.com.hk>
References: <20201129054416.3980-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support to set the internal pulldown via dt property
and allow simplify the board design for the trace from emmc-phy to
the eMMC chipset.
Default to not set the pull-down.

This patch was inspired from the 4.4 tree of the
Rockchip SDK, where it is enabled unconditional.
The patch had been tested with our rk3399 customized board.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/phy/rockchip/phy-rockchip-emmc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
index 2dc19ddd120f..48e2d75b1004 100644
--- a/drivers/phy/rockchip/phy-rockchip-emmc.c
+++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
@@ -67,6 +67,10 @@
 #define PHYCTRL_OTAPDLYENA_SHIFT	0xb
 #define PHYCTRL_OTAPDLYSEL_MASK		0xf
 #define PHYCTRL_OTAPDLYSEL_SHIFT	0x7
+#define PHYCTRL_REN_STRB_DISABLE	0x0
+#define PHYCTRL_REN_STRB_ENABLE		0x1
+#define PHYCTRL_REN_STRB_MASK		0x1
+#define PHYCTRL_REN_STRB_SHIFT		0x9
 
 #define PHYCTRL_IS_CALDONE(x) \
 	((((x) >> PHYCTRL_CALDONE_SHIFT) & \
@@ -80,6 +84,7 @@ struct rockchip_emmc_phy {
 	struct regmap	*reg_base;
 	struct clk	*emmcclk;
 	unsigned int drive_impedance;
+	unsigned int enable_strobe_pulldown;
 };
 
 static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
@@ -295,6 +300,13 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
 				   PHYCTRL_OTAPDLYSEL_MASK,
 				   PHYCTRL_OTAPDLYSEL_SHIFT));
 
+	/* Internal pull-down for strobe line */
+	regmap_write(rk_phy->reg_base,
+		     rk_phy->reg_offset + GRF_EMMCPHY_CON2,
+		     HIWORD_UPDATE(rk_phy->enable_strobe_pulldown,
+				   PHYCTRL_REN_STRB_MASK,
+				   PHYCTRL_REN_STRB_SHIFT));
+
 	/* Power up emmc phy analog blocks */
 	return rockchip_emmc_phy_power(phy, PHYCTRL_PDB_PWR_ON);
 }
@@ -359,10 +371,14 @@ static int rockchip_emmc_phy_probe(struct platform_device *pdev)
 	rk_phy->reg_offset = reg_offset;
 	rk_phy->reg_base = grf;
 	rk_phy->drive_impedance = PHYCTRL_DR_50OHM;
+	rk_phy->enable_strobe_pulldown = PHYCTRL_REN_STRB_DISABLE;
 
 	if (!of_property_read_u32(dev->of_node, "drive-impedance-ohm", &val))
 		rk_phy->drive_impedance = convert_drive_impedance_ohm(pdev, val);
 
+	if (of_property_read_bool(dev->of_node, "enable-strobe-pulldown"))
+		rk_phy->enable_strobe_pulldown = PHYCTRL_REN_STRB_ENABLE;
+
 	generic_phy = devm_phy_create(dev, dev->of_node, &ops);
 	if (IS_ERR(generic_phy)) {
 		dev_err(dev, "failed to create PHY\n");
-- 
2.20.1

