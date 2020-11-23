Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD752C113F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 18:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390054AbgKWRB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 12:01:58 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50318 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388176AbgKWRBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:01:54 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ANGwP5F011885;
        Mon, 23 Nov 2020 18:01:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=h27+U22NP7ldDbS1mhQ0Dxetk1yNVLZJWe63dRldsCo=;
 b=fUHNAiyXB65akHkEy4rgfcFH5DNxXa8rleL3utKOFHRwLmYXmMRrRCzO01qm/560l0ZN
 9qbY/9ZgJlXqGVEsDio+/DzOIprKYB3aIrMqreg1cZpHRuyLnKERDBgB4H27HaY4Wew2
 EQsyS71FJ3ImAyWtCYoNGVAkg6zTjBi/R3ufPsbv6vIn58cL87SbrWZckrzl4vXgxB/N
 CFniC/zYkLGCOMq5sO9/WubQ8LhxtM8n1OBcdp7hgVxTsoB0KXdS748KZnCYIQwWo0Wg
 dvyAgkwPXfmWUtKjawHia6ZsZVmSOF/d6H0eJ1VnClRaZqx+Nwe0kzKy/VHsOKzji4Qm xw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34y0fgkmm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 18:01:40 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 06E0D10002A;
        Mon, 23 Nov 2020 18:01:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DC4582BA2D0;
        Mon, 23 Nov 2020 18:01:39 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov 2020 18:01:39
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 3/6] phy: stm32: replace regulator_bulk* by multiple regulator_*
Date:   Mon, 23 Nov 2020 18:01:29 +0100
Message-ID: <20201123170132.17859-4-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201123170132.17859-1-amelie.delaunay@st.com>
References: <20201123170132.17859-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_14:2020-11-23,2020-11-23 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to async_schedule_domain call in regulator_bulk_enable,
scheduling while atomic bug can raise if regulator_bulk_enable is called
under atomic context.
To avoid this issue, this patch replaces all regulator_bulk* by regulator_
per regulators.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 69 ++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index c78a2c7947ce..8ef97c8806ff 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -36,13 +36,6 @@
 #define MINREV			GENMASK(3, 0)
 #define MAJREV			GENMASK(7, 4)
 
-static const char * const supplies_names[] = {
-	"vdda1v1",	/* 1V1 */
-	"vdda1v8",	/* 1V8 */
-};
-
-#define NUM_SUPPLIES		ARRAY_SIZE(supplies_names)
-
 #define PLL_LOCK_TIME_US	100
 #define PLL_PWR_DOWN_TIME_US	5
 #define PLL_FVCO_MHZ		2880
@@ -69,7 +62,8 @@ struct stm32_usbphyc {
 	struct reset_control *rst;
 	struct stm32_usbphyc_phy **phys;
 	int nphys;
-	struct regulator_bulk_data supplies[NUM_SUPPLIES];
+	struct regulator *vdda1v1;
+	struct regulator *vdda1v8;
 	int switch_setup;
 };
 
@@ -83,6 +77,41 @@ static inline void stm32_usbphyc_clr_bits(void __iomem *reg, u32 bits)
 	writel_relaxed(readl_relaxed(reg) & ~bits, reg);
 }
 
+static int stm32_usbphyc_regulators_enable(struct stm32_usbphyc *usbphyc)
+{
+	int ret;
+
+	ret = regulator_enable(usbphyc->vdda1v1);
+	if (ret)
+		return ret;
+
+	ret = regulator_enable(usbphyc->vdda1v8);
+	if (ret)
+		goto vdda1v1_disable;
+
+	return 0;
+
+vdda1v1_disable:
+	regulator_disable(usbphyc->vdda1v1);
+
+	return ret;
+}
+
+static int stm32_usbphyc_regulators_disable(struct stm32_usbphyc *usbphyc)
+{
+	int ret;
+
+	ret = regulator_disable(usbphyc->vdda1v8);
+	if (ret)
+		return ret;
+
+	ret = regulator_disable(usbphyc->vdda1v1);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static void stm32_usbphyc_get_pll_params(u32 clk_rate,
 					 struct pll_params *pll_params)
 {
@@ -170,7 +199,7 @@ static int stm32_usbphyc_pll_disable(struct stm32_usbphyc *usbphyc)
 		return -EIO;
 	}
 
-	return regulator_bulk_disable(NUM_SUPPLIES, usbphyc->supplies);
+	return stm32_usbphyc_regulators_disable(usbphyc);
 }
 
 static int stm32_usbphyc_pll_enable(struct stm32_usbphyc *usbphyc)
@@ -189,7 +218,7 @@ static int stm32_usbphyc_pll_enable(struct stm32_usbphyc *usbphyc)
 			return ret;
 	}
 
-	ret = regulator_bulk_enable(NUM_SUPPLIES, usbphyc->supplies);
+	ret = stm32_usbphyc_regulators_enable(usbphyc);
 	if (ret)
 		return ret;
 
@@ -210,7 +239,7 @@ static int stm32_usbphyc_pll_enable(struct stm32_usbphyc *usbphyc)
 	return 0;
 
 reg_disable:
-	regulator_bulk_disable(NUM_SUPPLIES, usbphyc->supplies);
+	stm32_usbphyc_regulators_disable(usbphyc);
 
 	return ret;
 }
@@ -306,7 +335,7 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 	struct device_node *child, *np = dev->of_node;
 	struct phy_provider *phy_provider;
 	u32 version;
-	int ret, i, port = 0;
+	int ret, port = 0;
 
 	usbphyc = devm_kzalloc(dev, sizeof(*usbphyc), GFP_KERNEL);
 	if (!usbphyc)
@@ -348,13 +377,19 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
-	for (i = 0; i < NUM_SUPPLIES; i++)
-		usbphyc->supplies[i].supply = supplies_names[i];
+	usbphyc->vdda1v1 = devm_regulator_get(dev, "vdda1v1");
+	if (IS_ERR(usbphyc->vdda1v1)) {
+		ret = PTR_ERR(usbphyc->vdda1v1);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get vdda1v1 supply: %d\n", ret);
+		goto clk_disable;
+	}
 
-	ret = devm_regulator_bulk_get(dev, NUM_SUPPLIES, usbphyc->supplies);
-	if (ret) {
+	usbphyc->vdda1v8 = devm_regulator_get(dev, "vdda1v8");
+	if (IS_ERR(usbphyc->vdda1v8)) {
+		ret = PTR_ERR(usbphyc->vdda1v8);
 		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get regulators: %d\n", ret);
+			dev_err(dev, "failed to get vdda1v8 supply: %d\n", ret);
 		goto clk_disable;
 	}
 
-- 
2.17.1

