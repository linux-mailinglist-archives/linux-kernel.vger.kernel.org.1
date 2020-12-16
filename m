Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEA12DBF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 12:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgLPL2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 06:28:15 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:35648 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725274AbgLPL2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 06:28:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 47CDAFB02;
        Wed, 16 Dec 2020 12:27:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GtSjAd7cPwPd; Wed, 16 Dec 2020 12:27:29 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id BAB9243BC5; Wed, 16 Dec 2020 12:27:28 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/1] phy: fsl-imx8-mipi-dphy: Hook into runtime pm
Date:   Wed, 16 Dec 2020 12:27:28 +0100
Message-Id: <eae82b09fd5ed39dbcd88cc10ce60338474183aa.1608118008.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608118008.git.agx@sigxcpu.org>
References: <cover.1608118008.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to shut down the mipi power domain on the imx8. The
alternative would be to drop the dphy from the mipi power domain in the
SOCs device tree and only have the DSI host controller visible there but
since the PD is mostly about the PHY that would defeat it's purpose.

This allows to shut off the power domain hen blanking the LCD panel:

pm_genpd_summary before:

domain                          status          slaves
    /device                                             runtime status
----------------------------------------------------------------------
mipi                            on
    /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  unsupported
    /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended

after:

mipi                            off-0
    /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  suspended
    /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../phy/freescale/phy-fsl-imx8-mipi-dphy.c    | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
index a95572b397ca..34e2d801e520 100644
--- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
+++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
@@ -14,6 +14,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 /* DPHY registers */
@@ -93,6 +94,7 @@ struct mixel_dphy_cfg {
 };
 
 struct mixel_dphy_priv {
+	struct device *dev;
 	struct mixel_dphy_cfg cfg;
 	struct regmap *regmap;
 	struct clk *phy_ref_clk;
@@ -382,6 +384,7 @@ static int mixel_dphy_power_on(struct phy *phy)
 	ret = clk_prepare_enable(priv->phy_ref_clk);
 	if (ret < 0)
 		return ret;
+	pm_runtime_get_sync(priv->dev);
 
 	phy_write(phy, PWR_ON, DPHY_PD_PLL);
 	ret = regmap_read_poll_timeout(priv->regmap, DPHY_LOCK, locked,
@@ -395,6 +398,7 @@ static int mixel_dphy_power_on(struct phy *phy)
 
 	return 0;
 clock_disable:
+	pm_runtime_put(priv->dev);
 	clk_disable_unprepare(priv->phy_ref_clk);
 	return ret;
 }
@@ -406,6 +410,7 @@ static int mixel_dphy_power_off(struct phy *phy)
 	phy_write(phy, PWR_OFF, DPHY_PD_PLL);
 	phy_write(phy, PWR_OFF, DPHY_PD_DPHY);
 
+	pm_runtime_put(priv->dev);
 	clk_disable_unprepare(priv->phy_ref_clk);
 
 	return 0;
@@ -467,6 +472,7 @@ static int mixel_dphy_probe(struct platform_device *pdev)
 	dev_dbg(dev, "phy_ref clock rate: %lu\n",
 		clk_get_rate(priv->phy_ref_clk));
 
+	priv->dev = dev;
 	dev_set_drvdata(dev, priv);
 
 	phy = devm_phy_create(dev, np, &mixel_dphy_phy_ops);
@@ -477,12 +483,26 @@ static int mixel_dphy_probe(struct platform_device *pdev)
 	phy_set_drvdata(phy, priv);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR(phy_provider);
 
-	return PTR_ERR_OR_ZERO(phy_provider);
+	pm_runtime_enable(dev);
+
+	return 0;
+}
+
+static int mixel_dphy_remove(struct platform_device *pdev)
+{
+	struct mixel_dphy_priv *priv = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(priv->dev);
+
+	return 0;
 }
 
 static struct platform_driver mixel_dphy_driver = {
 	.probe	= mixel_dphy_probe,
+	.remove = mixel_dphy_remove,
 	.driver = {
 		.name = "mixel-mipi-dphy",
 		.of_match_table	= mixel_dphy_of_match,
-- 
2.29.2

