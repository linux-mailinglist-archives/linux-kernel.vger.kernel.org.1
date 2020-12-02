Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8AF2CB713
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387729AbgLBI0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:26:24 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:49102 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S2387526AbgLBI0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:26:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 9BBA620001F5;
        Wed,  2 Dec 2020 16:25:22 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4vUYZdex8rWq; Wed,  2 Dec 2020 16:25:22 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 83B19200E233;
        Wed,  2 Dec 2020 16:25:22 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 7BBFBC019F3;
        Wed,  2 Dec 2020 16:25:22 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 7F42E200756; Wed,  2 Dec 2020 16:25:22 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org, Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 1/2] phy: rockchip-emmc: output tap delay dt property
Date:   Wed,  2 Dec 2020 16:25:06 +0800
Message-Id: <20201202082507.3536-2-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201202082507.3536-1-chris.ruehl@gtsys.com.hk>
References: <20201202082507.3536-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the rockchip-emmc phy to set the otapdlysec register with
a dt property. This was mentioned from Brian Norris when he sent
the path to set the default value in the driver.
This patch add a dt property 'output-tapdelay-select' u32 and allow
to set the 0x0-0xf. If not set in dts, the old default 0x4 applies.

Tested with our customized rk3399 to tune the eMMC.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/phy/rockchip/phy-rockchip-emmc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
index 75faee5c0d27..3c7f8c08353c 100644
--- a/drivers/phy/rockchip/phy-rockchip-emmc.c
+++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
@@ -65,6 +65,8 @@
 #define PHYCTRL_OTAPDLYENA		0x1
 #define PHYCTRL_OTAPDLYENA_MASK		0x1
 #define PHYCTRL_OTAPDLYENA_SHIFT	0xb
+#define PHYCTRL_OTAPDLYSEL_DEFAULT	0x4
+#define PHYCTRL_OTAPDLYSEL_MAXVALUE	0xf
 #define PHYCTRL_OTAPDLYSEL_MASK		0xf
 #define PHYCTRL_OTAPDLYSEL_SHIFT	0x7
 #define PHYCTRL_REN_STRB_DISABLE	0x0
@@ -85,6 +87,7 @@ struct rockchip_emmc_phy {
 	struct clk	*emmcclk;
 	unsigned int drive_impedance;
 	unsigned int enable_strobe_pulldown;
+	unsigned int output_tapdelay_select;
 };
 
 static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
@@ -297,7 +300,7 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
 	/* Output tap delay */
 	regmap_write(rk_phy->reg_base,
 		     rk_phy->reg_offset + GRF_EMMCPHY_CON0,
-		     HIWORD_UPDATE(4,
+		     HIWORD_UPDATE(rk_phy->output_tapdelay_select,
 				   PHYCTRL_OTAPDLYSEL_MASK,
 				   PHYCTRL_OTAPDLYSEL_SHIFT));
 
@@ -373,6 +376,7 @@ static int rockchip_emmc_phy_probe(struct platform_device *pdev)
 	rk_phy->reg_base = grf;
 	rk_phy->drive_impedance = PHYCTRL_DR_50OHM;
 	rk_phy->enable_strobe_pulldown = PHYCTRL_REN_STRB_DISABLE;
+	rk_phy->output_tapdelay_select = PHYCTRL_OTAPDLYSEL_DEFAULT;
 
 	if (!of_property_read_u32(dev->of_node, "drive-impedance-ohm", &val))
 		rk_phy->drive_impedance = convert_drive_impedance_ohm(pdev, val);
@@ -380,6 +384,13 @@ static int rockchip_emmc_phy_probe(struct platform_device *pdev)
 	if (of_property_read_bool(dev->of_node, "enable-strobe-pulldown"))
 		rk_phy->enable_strobe_pulldown = PHYCTRL_REN_STRB_ENABLE;
 
+	if (!of_property_read_u32(dev->of_node, "output-tapdelay-select", &val)) {
+		if (val <= PHYCTRL_OTAPDLYSEL_MAXVALUE)
+			rk_phy->output_tapdelay_select = val;
+		else
+			dev_err(dev, "output-tapdelay-select exceeds limit, apply default\n");
+	}
+
 	generic_phy = devm_phy_create(dev, dev->of_node, &ops);
 	if (IS_ERR(generic_phy)) {
 		dev_err(dev, "failed to create PHY\n");
-- 
2.20.1

