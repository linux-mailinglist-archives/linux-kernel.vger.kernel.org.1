Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADA12EA6F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbhAEJGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:06:35 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:56024 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727710AbhAEJGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:06:32 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10590vDZ028713;
        Tue, 5 Jan 2021 10:05:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=IastD3FRBn9kt7jStjWrF9B5vL9KHobYTZOnNwmLiQo=;
 b=ssw1cZ/4ZlOrn/aDutxeJznjvwf6yKlNCNfeFtXB2EojTlNoSUT6Mq//PuJp2gk6jAU3
 UibqgpvDoItk4Oy+LY2zD7nt2C5QCjsZntU0Al4m2O3SdWkmsDItwYdZB+QUZ7UNiZyn
 6KpXEn3sLdFavPnonO9Yo6JIOVSHLGrik5TK415X/FKjabud07Z1LTd8xNHF9uxUBeh2
 pm5MfTlTWCPTAG/t7vJ0NJDV6pRyphjXVpeACsfuGl8WgB0J/2doIl8jsW+KNgJa9S71
 uOYA1E1+SCG4A+Z8Pg+AHUJ1ssF6cZvShlsJQ2d5s79Ka/s4zr2tLbKSXKUVdWfqy2ji QA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35th25kqdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 10:05:40 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D01D710002A;
        Tue,  5 Jan 2021 10:05:39 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BF80522AA5B;
        Tue,  5 Jan 2021 10:05:39 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Jan 2021 10:05:39
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
Subject: [PATCH v2 6/6] phy: stm32: rework PLL Lock detection
Date:   Tue, 5 Jan 2021 10:05:25 +0100
Message-ID: <20210105090525.23164-7-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105090525.23164-1-amelie.delaunay@foss.st.com>
References: <20210105090525.23164-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-05,2021-01-05 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USBPHYC has a register per phy to control and monitor the debug interface
of the HS PHY through a digital debug access.
With this register, it is possible to know if PLL Lock input to phy is
high. That means the PLL is ready for HS operation.
Instead of using an hard-coded delay after PLL enable and PLL disable, use
this bit to ensure good operating of the HS PHY.
Also use an atomic counter (n_pll_cons) to count the actual number of PLL
consumers and get rid of stm32_usbphyc_has_one_phy_active.
The boolean active in the usbphyc_phy structure is kept, because we need to
know in remove if a phy_exit is required to properly disable the PLL.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 88 ++++++++++++++++++------------
 1 file changed, 54 insertions(+), 34 deletions(-)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index 8b11d95b2c20..d08fbb180e43 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -17,6 +17,7 @@
 
 #define STM32_USBPHYC_PLL	0x0
 #define STM32_USBPHYC_MISC	0x8
+#define STM32_USBPHYC_MONITOR(X) (0x108 + ((X) * 0x100))
 #define STM32_USBPHYC_VERSION	0x3F4
 
 /* STM32_USBPHYC_PLL bit fields */
@@ -32,12 +33,16 @@
 /* STM32_USBPHYC_MISC bit fields */
 #define SWITHOST		BIT(0)
 
+/* STM32_USBPHYC_MONITOR bit fields */
+#define STM32_USBPHYC_MON_OUT	GENMASK(3, 0)
+#define STM32_USBPHYC_MON_SEL	GENMASK(8, 4)
+#define STM32_USBPHYC_MON_SEL_LOCKP 0x1F
+#define STM32_USBPHYC_MON_OUT_LOCKP BIT(3)
+
 /* STM32_USBPHYC_VERSION bit fields */
 #define MINREV			GENMASK(3, 0)
 #define MAJREV			GENMASK(7, 4)
 
-#define PLL_LOCK_TIME_US	100
-#define PLL_PWR_DOWN_TIME_US	5
 #define PLL_FVCO_MHZ		2880
 #define PLL_INFF_MIN_RATE_HZ	19200000
 #define PLL_INFF_MAX_RATE_HZ	38400000
@@ -64,6 +69,7 @@ struct stm32_usbphyc {
 	int nphys;
 	struct regulator *vdda1v1;
 	struct regulator *vdda1v8;
+	atomic_t n_pll_cons;
 	int switch_setup;
 };
 
@@ -171,35 +177,27 @@ static int stm32_usbphyc_pll_init(struct stm32_usbphyc *usbphyc)
 	return 0;
 }
 
-static bool stm32_usbphyc_has_one_phy_active(struct stm32_usbphyc *usbphyc)
+static int __stm32_usbphyc_pll_disable(struct stm32_usbphyc *usbphyc)
 {
-	int i;
+	void __iomem *pll_reg = usbphyc->base + STM32_USBPHYC_PLL;
+	u32 pllen;
+
+	stm32_usbphyc_clr_bits(pll_reg, PLLEN);
 
-	for (i = 0; i < usbphyc->nphys; i++)
-		if (usbphyc->phys[i]->active)
-			return true;
+	/* Wait for minimum width of powerdown pulse (ENABLE = Low) */
+	if (readl_relaxed_poll_timeout(pll_reg, pllen, !(pllen & PLLEN), 5, 50))
+		dev_err(usbphyc->dev, "PLL not reset\n");
 
-	return false;
+	return stm32_usbphyc_regulators_disable(usbphyc);
 }
 
 static int stm32_usbphyc_pll_disable(struct stm32_usbphyc *usbphyc)
 {
-	void __iomem *pll_reg = usbphyc->base + STM32_USBPHYC_PLL;
-
-	/* Check if other phy port active */
-	if (stm32_usbphyc_has_one_phy_active(usbphyc))
+	/* Check if a phy port is still active or clk48 in use */
+	if (atomic_dec_return(&usbphyc->n_pll_cons) > 0)
 		return 0;
 
-	stm32_usbphyc_clr_bits(pll_reg, PLLEN);
-	/* Wait for minimum width of powerdown pulse (ENABLE = Low) */
-	udelay(PLL_PWR_DOWN_TIME_US);
-
-	if (readl_relaxed(pll_reg) & PLLEN) {
-		dev_err(usbphyc->dev, "PLL not reset\n");
-		return -EIO;
-	}
-
-	return stm32_usbphyc_regulators_disable(usbphyc);
+	return __stm32_usbphyc_pll_disable(usbphyc);
 }
 
 static int stm32_usbphyc_pll_enable(struct stm32_usbphyc *usbphyc)
@@ -208,39 +206,43 @@ static int stm32_usbphyc_pll_enable(struct stm32_usbphyc *usbphyc)
 	bool pllen = readl_relaxed(pll_reg) & PLLEN;
 	int ret;
 
-	/* Check if one phy port has already configured the pll */
-	if (pllen && stm32_usbphyc_has_one_phy_active(usbphyc))
+	/*
+	 * Check if a phy port or clk48 prepare has configured the pll
+	 * and ensure the PLL is enabled
+	 */
+	if (atomic_inc_return(&usbphyc->n_pll_cons) > 1 && pllen)
 		return 0;
 
 	if (pllen) {
-		ret = stm32_usbphyc_pll_disable(usbphyc);
+		/*
+		 * PLL shouldn't be enabled without known consumer,
+		 * disable it and reinit n_pll_cons
+		 */
+		dev_warn(usbphyc->dev, "PLL enabled without known consumers\n");
+
+		ret = __stm32_usbphyc_pll_disable(usbphyc);
 		if (ret)
 			return ret;
 	}
 
 	ret = stm32_usbphyc_regulators_enable(usbphyc);
 	if (ret)
-		return ret;
+		goto dec_n_pll_cons;
 
 	ret = stm32_usbphyc_pll_init(usbphyc);
 	if (ret)
 		goto reg_disable;
 
 	stm32_usbphyc_set_bits(pll_reg, PLLEN);
-	/* Wait for maximum lock time */
-	udelay(PLL_LOCK_TIME_US);
-
-	if (!(readl_relaxed(pll_reg) & PLLEN)) {
-		dev_err(usbphyc->dev, "PLLEN not set\n");
-		ret = -EIO;
-		goto reg_disable;
-	}
 
 	return 0;
 
 reg_disable:
 	stm32_usbphyc_regulators_disable(usbphyc);
 
+dec_n_pll_cons:
+	atomic_dec(&usbphyc->n_pll_cons);
+
 	return ret;
 }
 
@@ -248,15 +250,33 @@ static int stm32_usbphyc_phy_init(struct phy *phy)
 {
 	struct stm32_usbphyc_phy *usbphyc_phy = phy_get_drvdata(phy);
 	struct stm32_usbphyc *usbphyc = usbphyc_phy->usbphyc;
+	u32 reg_mon = STM32_USBPHYC_MONITOR(usbphyc_phy->index);
+	u32 monsel = FIELD_PREP(STM32_USBPHYC_MON_SEL,
+				STM32_USBPHYC_MON_SEL_LOCKP);
+	u32 monout;
 	int ret;
 
 	ret = stm32_usbphyc_pll_enable(usbphyc);
 	if (ret)
 		return ret;
 
+	/* Check that PLL Lock input to PHY is High */
+	writel_relaxed(monsel, usbphyc->base + reg_mon);
+	ret = readl_relaxed_poll_timeout(usbphyc->base + reg_mon, monout,
+					 (monout & STM32_USBPHYC_MON_OUT_LOCKP),
+					 100, 1000);
+	if (ret) {
+		dev_err(usbphyc->dev, "PLL Lock input to PHY is Low (val=%x)\n",
+			(u32)(monout & STM32_USBPHYC_MON_OUT));
+		goto pll_disable;
+	}
+
 	usbphyc_phy->active = true;
 
 	return 0;
+
+pll_disable:
+	return stm32_usbphyc_pll_disable(usbphyc);
 }
 
 static int stm32_usbphyc_phy_exit(struct phy *phy)
-- 
2.17.1

