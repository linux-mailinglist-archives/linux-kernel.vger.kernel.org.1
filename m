Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB2A2EA6EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbhAEJGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:06:31 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:59425 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725996AbhAEJG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:06:29 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10593IVh000856;
        Tue, 5 Jan 2021 10:05:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=of3W7dNkNmjdLh/Rc9lMOjUfSe2xc1/iJh4f4RsxdBQ=;
 b=JlEZOfxI+gWGnS8bA58q0KrwcWhlMsJ1lpmzG22jJdv4FTKDgzyMDdNKeLkQ22YnUvMO
 EIc/VyWJLU7fijifFzP100x021BgPpQ6GdTbNJvKK9KoS6t8sgu4RROxXTyNf09EHlFG
 a0lCYvLyh+4Vvk5SDDhmxks0HveKSWAYLd0in40rwq/UH6leAy5svVrkpaunCxSpbilN
 7VbAue06vVsUFZTfHpqxqpe3N41qC1ZtQk8L+nTxmRyq/0gxVVT/Hfv3yxdqshj3tNpc
 4XX/MPWkY6HeiFT4kb0MmegX3ztTpEc7jwhy/M2bxGm9OGJmnEqqbpUYh2LcB4eZDwFm GQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35tf66uy55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 10:05:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 70D9E10002A;
        Tue,  5 Jan 2021 10:05:35 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 58F9922AA5B;
        Tue,  5 Jan 2021 10:05:35 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Jan 2021 10:05:34
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 2/6] phy: stm32: manage 1v1 and 1v8 supplies at pll activation/deactivation
Date:   Tue, 5 Jan 2021 10:05:21 +0100
Message-ID: <20210105090525.23164-3-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105090525.23164-1-amelie.delaunay@foss.st.com>
References: <20210105090525.23164-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-05,2021-01-05 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PLL block requires to be powered with 1v1 and 1v8 supplies to catch
ENABLE signal.
Currently, supplies are managed through phy_ops .power_on/off, and PLL
activation/deactivation is managed through phy_ops .init/exit.
The sequence of phy_ops .power_on/.phy_init, .power_off/.exit is USB
drivers dependent.
To ensure a good behavior of the PLL, supplies have to be managed at PLL
activation/deactivation. That means the supplies need to be put in usbphyc
node and not in phy children nodes.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 102 +++++++++++++----------------
 1 file changed, 46 insertions(+), 56 deletions(-)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index a54317e96c41..c78a2c7947ce 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -58,7 +58,6 @@ struct pll_params {
 struct stm32_usbphyc_phy {
 	struct phy *phy;
 	struct stm32_usbphyc *usbphyc;
-	struct regulator_bulk_data supplies[NUM_SUPPLIES];
 	u32 index;
 	bool active;
 };
@@ -70,6 +69,7 @@ struct stm32_usbphyc {
 	struct reset_control *rst;
 	struct stm32_usbphyc_phy **phys;
 	int nphys;
+	struct regulator_bulk_data supplies[NUM_SUPPLIES];
 	int switch_setup;
 };
 
@@ -153,10 +153,30 @@ static bool stm32_usbphyc_has_one_phy_active(struct stm32_usbphyc *usbphyc)
 	return false;
 }
 
+static int stm32_usbphyc_pll_disable(struct stm32_usbphyc *usbphyc)
+{
+	void __iomem *pll_reg = usbphyc->base + STM32_USBPHYC_PLL;
+
+	/* Check if other phy port active */
+	if (stm32_usbphyc_has_one_phy_active(usbphyc))
+		return 0;
+
+	stm32_usbphyc_clr_bits(pll_reg, PLLEN);
+	/* Wait for minimum width of powerdown pulse (ENABLE = Low) */
+	udelay(PLL_PWR_DOWN_TIME_US);
+
+	if (readl_relaxed(pll_reg) & PLLEN) {
+		dev_err(usbphyc->dev, "PLL not reset\n");
+		return -EIO;
+	}
+
+	return regulator_bulk_disable(NUM_SUPPLIES, usbphyc->supplies);
+}
+
 static int stm32_usbphyc_pll_enable(struct stm32_usbphyc *usbphyc)
 {
 	void __iomem *pll_reg = usbphyc->base + STM32_USBPHYC_PLL;
-	bool pllen = (readl_relaxed(pll_reg) & PLLEN);
+	bool pllen = readl_relaxed(pll_reg) & PLLEN;
 	int ret;
 
 	/* Check if one phy port has already configured the pll */
@@ -164,46 +184,35 @@ static int stm32_usbphyc_pll_enable(struct stm32_usbphyc *usbphyc)
 		return 0;
 
 	if (pllen) {
-		stm32_usbphyc_clr_bits(pll_reg, PLLEN);
-		/* Wait for minimum width of powerdown pulse (ENABLE = Low) */
-		udelay(PLL_PWR_DOWN_TIME_US);
+		ret = stm32_usbphyc_pll_disable(usbphyc);
+		if (ret)
+			return ret;
 	}
 
-	ret = stm32_usbphyc_pll_init(usbphyc);
+	ret = regulator_bulk_enable(NUM_SUPPLIES, usbphyc->supplies);
 	if (ret)
 		return ret;
 
-	stm32_usbphyc_set_bits(pll_reg, PLLEN);
+	ret = stm32_usbphyc_pll_init(usbphyc);
+	if (ret)
+		goto reg_disable;
 
+	stm32_usbphyc_set_bits(pll_reg, PLLEN);
 	/* Wait for maximum lock time */
 	udelay(PLL_LOCK_TIME_US);
 
 	if (!(readl_relaxed(pll_reg) & PLLEN)) {
 		dev_err(usbphyc->dev, "PLLEN not set\n");
-		return -EIO;
+		ret = -EIO;
+		goto reg_disable;
 	}
 
 	return 0;
-}
-
-static int stm32_usbphyc_pll_disable(struct stm32_usbphyc *usbphyc)
-{
-	void __iomem *pll_reg = usbphyc->base + STM32_USBPHYC_PLL;
-
-	/* Check if other phy port active */
-	if (stm32_usbphyc_has_one_phy_active(usbphyc))
-		return 0;
 
-	stm32_usbphyc_clr_bits(pll_reg, PLLEN);
-	/* Wait for minimum width of powerdown pulse (ENABLE = Low) */
-	udelay(PLL_PWR_DOWN_TIME_US);
+reg_disable:
+	regulator_bulk_disable(NUM_SUPPLIES, usbphyc->supplies);
 
-	if (readl_relaxed(pll_reg) & PLLEN) {
-		dev_err(usbphyc->dev, "PLL not reset\n");
-		return -EIO;
-	}
-
-	return 0;
+	return ret;
 }
 
 static int stm32_usbphyc_phy_init(struct phy *phy)
@@ -231,25 +240,9 @@ static int stm32_usbphyc_phy_exit(struct phy *phy)
 	return stm32_usbphyc_pll_disable(usbphyc);
 }
 
-static int stm32_usbphyc_phy_power_on(struct phy *phy)
-{
-	struct stm32_usbphyc_phy *usbphyc_phy = phy_get_drvdata(phy);
-
-	return regulator_bulk_enable(NUM_SUPPLIES, usbphyc_phy->supplies);
-}
-
-static int stm32_usbphyc_phy_power_off(struct phy *phy)
-{
-	struct stm32_usbphyc_phy *usbphyc_phy = phy_get_drvdata(phy);
-
-	return regulator_bulk_disable(NUM_SUPPLIES, usbphyc_phy->supplies);
-}
-
 static const struct phy_ops stm32_usbphyc_phy_ops = {
 	.init = stm32_usbphyc_phy_init,
 	.exit = stm32_usbphyc_phy_exit,
-	.power_on = stm32_usbphyc_phy_power_on,
-	.power_off = stm32_usbphyc_phy_power_off,
 	.owner = THIS_MODULE,
 };
 
@@ -313,7 +306,7 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 	struct device_node *child, *np = dev->of_node;
 	struct phy_provider *phy_provider;
 	u32 version;
-	int ret, port = 0;
+	int ret, i, port = 0;
 
 	usbphyc = devm_kzalloc(dev, sizeof(*usbphyc), GFP_KERNEL);
 	if (!usbphyc)
@@ -355,11 +348,20 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
+	for (i = 0; i < NUM_SUPPLIES; i++)
+		usbphyc->supplies[i].supply = supplies_names[i];
+
+	ret = devm_regulator_bulk_get(dev, NUM_SUPPLIES, usbphyc->supplies);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get regulators: %d\n", ret);
+		goto clk_disable;
+	}
+
 	for_each_child_of_node(np, child) {
 		struct stm32_usbphyc_phy *usbphyc_phy;
 		struct phy *phy;
 		u32 index;
-		int i;
 
 		phy = devm_phy_create(dev, child, &stm32_usbphyc_phy_ops);
 		if (IS_ERR(phy)) {
@@ -377,18 +379,6 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 			goto put_child;
 		}
 
-		for (i = 0; i < NUM_SUPPLIES; i++)
-			usbphyc_phy->supplies[i].supply = supplies_names[i];
-
-		ret = devm_regulator_bulk_get(&phy->dev, NUM_SUPPLIES,
-					      usbphyc_phy->supplies);
-		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(&phy->dev,
-					"failed to get regulators: %d\n", ret);
-			goto put_child;
-		}
-
 		ret = of_property_read_u32(child, "reg", &index);
 		if (ret || index > usbphyc->nphys) {
 			dev_err(&phy->dev, "invalid reg property: %d\n", ret);
-- 
2.17.1

