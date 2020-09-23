Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558512756A4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgIWKwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:52:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48616 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWKwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:52:39 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NAqXVJ128340;
        Wed, 23 Sep 2020 05:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600858353;
        bh=dqhnY/Ze30b8QaokFZbJsK5FcPvfbVH/2altApJSNBs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IBUlAeybIGWlDOPbAJJ0haoaYY5nRBelVYhwWIASoCzI4QV9yjtLQpLdXyZfEu4vn
         q4DekWqT3ptGmN0YQQ01nwo7jJzipYVM8h00Quoq2KDM1TG3VO1Of/OuxS8vUqASmo
         kUK7Xq/V3LVhzzzovXRcd/gboyq4H7cy/+mS3oBk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08NAqXmU005861
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 05:52:33 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 05:52:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 05:52:32 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NAq7ql059762;
        Wed, 23 Sep 2020 05:52:28 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <adrian.hunter@intel.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>, <kishon@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 4/6] mmc: sdhci_am654: Add support for input tap delay
Date:   Wed, 23 Sep 2020 16:22:04 +0530
Message-ID: <20200923105206.7988-5-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923105206.7988-1-faiz_abbas@ti.com>
References: <20200923105206.7988-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DLL need only be enabled for speed modes and clock frequencies at or
above 50 MHz. For speed modes that don't enable the DLL, we need to
configure a static input delay value. This involves reading an optional
itap-del-sel-* value from the device tree and configuring it for the
appropriate speed mode.

With this addition, make sure that DLL is always switched off at the
beginning of the set_clock() call to simplify configuration. This also
removes the need for the dll_on member in struct sdhci_am654_data.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 114 ++++++++++++++++++++++++---------
 1 file changed, 84 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 9f3347bc3757..1213b711e60a 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -66,6 +66,14 @@
 #define RETRIM_MASK		BIT(RETRIM_SHIFT)
 #define SELDLYTXCLK_SHIFT	17
 #define SELDLYTXCLK_MASK	BIT(SELDLYTXCLK_SHIFT)
+#define SELDLYRXCLK_SHIFT	16
+#define SELDLYRXCLK_MASK	BIT(SELDLYRXCLK_SHIFT)
+#define ITAPDLYSEL_SHIFT	0
+#define ITAPDLYSEL_MASK		GENMASK(4, 0)
+#define ITAPDLYENA_SHIFT	8
+#define ITAPDLYENA_MASK		BIT(ITAPDLYENA_SHIFT)
+#define ITAPCHGWIN_SHIFT	9
+#define ITAPCHGWIN_MASK		BIT(ITAPCHGWIN_SHIFT)
 
 #define DRIVER_STRENGTH_50_OHM	0x0
 #define DRIVER_STRENGTH_33_OHM	0x1
@@ -73,7 +81,7 @@
 #define DRIVER_STRENGTH_100_OHM	0x3
 #define DRIVER_STRENGTH_40_OHM	0x4
 
-#define CLOCK_TOO_SLOW_HZ	400000
+#define CLOCK_TOO_SLOW_HZ	50000000
 
 /* Command Queue Host Controller Interface Base address */
 #define SDHCI_AM654_CQE_BASE_ADDR 0x200
@@ -86,33 +94,55 @@ static struct regmap_config sdhci_am654_regmap_config = {
 };
 
 struct timing_data {
-	const char *binding;
+	const char *otap_binding;
+	const char *itap_binding;
 	u32 capability;
 };
 
 static const struct timing_data td[] = {
-	[MMC_TIMING_LEGACY] = {"ti,otap-del-sel-legacy", 0},
-	[MMC_TIMING_MMC_HS] = {"ti,otap-del-sel-mmc-hs", MMC_CAP_MMC_HIGHSPEED},
-	[MMC_TIMING_SD_HS]  = {"ti,otap-del-sel-sd-hs", MMC_CAP_SD_HIGHSPEED},
-	[MMC_TIMING_UHS_SDR12] = {"ti,otap-del-sel-sdr12", MMC_CAP_UHS_SDR12},
-	[MMC_TIMING_UHS_SDR25] = {"ti,otap-del-sel-sdr25", MMC_CAP_UHS_SDR25},
-	[MMC_TIMING_UHS_SDR50] = {"ti,otap-del-sel-sdr50", MMC_CAP_UHS_SDR50},
-	[MMC_TIMING_UHS_SDR104] = {"ti,otap-del-sel-sdr104",
+	[MMC_TIMING_LEGACY]	= {"ti,otap-del-sel-legacy",
+				   "ti,itap-del-sel-legacy",
+				   0},
+	[MMC_TIMING_MMC_HS]	= {"ti,otap-del-sel-mmc-hs",
+				   "ti,itap-del-sel-mmc-hs",
+				   MMC_CAP_MMC_HIGHSPEED},
+	[MMC_TIMING_SD_HS]	= {"ti,otap-del-sel-sd-hs",
+				   "ti,itap-del-sel-sd-hs",
+				   MMC_CAP_SD_HIGHSPEED},
+	[MMC_TIMING_UHS_SDR12]	= {"ti,otap-del-sel-sdr12",
+				   "ti,itap-del-sel-sdr12",
+				   MMC_CAP_UHS_SDR12},
+	[MMC_TIMING_UHS_SDR25]	= {"ti,otap-del-sel-sdr25",
+				   "ti,itap-del-sel-sdr25",
+				   MMC_CAP_UHS_SDR25},
+	[MMC_TIMING_UHS_SDR50]	= {"ti,otap-del-sel-sdr50",
+				   NULL,
+				   MMC_CAP_UHS_SDR50},
+	[MMC_TIMING_UHS_SDR104]	= {"ti,otap-del-sel-sdr104",
+				   NULL,
 				   MMC_CAP_UHS_SDR104},
-	[MMC_TIMING_UHS_DDR50] = {"ti,otap-del-sel-ddr50", MMC_CAP_UHS_DDR50},
-	[MMC_TIMING_MMC_DDR52] = {"ti,otap-del-sel-ddr52", MMC_CAP_DDR},
-	[MMC_TIMING_MMC_HS200] = {"ti,otap-del-sel-hs200", MMC_CAP2_HS200},
-	[MMC_TIMING_MMC_HS400] = {"ti,otap-del-sel-hs400", MMC_CAP2_HS400},
+	[MMC_TIMING_UHS_DDR50]	= {"ti,otap-del-sel-ddr50",
+				   NULL,
+				   MMC_CAP_UHS_DDR50},
+	[MMC_TIMING_MMC_DDR52]	= {"ti,otap-del-sel-ddr52",
+				   "ti,itap-del-sel-ddr52",
+				   MMC_CAP_DDR},
+	[MMC_TIMING_MMC_HS200]	= {"ti,otap-del-sel-hs200",
+				   NULL,
+				   MMC_CAP2_HS200},
+	[MMC_TIMING_MMC_HS400]	= {"ti,otap-del-sel-hs400",
+				   NULL,
+				   MMC_CAP2_HS400},
 };
 
 struct sdhci_am654_data {
 	struct regmap *base;
 	bool legacy_otapdly;
 	int otap_del_sel[ARRAY_SIZE(td)];
+	int itap_del_sel[ARRAY_SIZE(td)];
 	int clkbuf_sel;
 	int trm_icp;
 	int drv_strength;
-	bool dll_on;
 	int strb_sel;
 	u32 flags;
 };
@@ -135,6 +165,10 @@ static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock)
 	u32 mask, val;
 	int ret;
 
+	/* Disable delay chain mode */
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL5,
+			   SELDLYTXCLK_MASK | SELDLYRXCLK_MASK, 0);
+
 	if (sdhci_am654->flags & FREQSEL_2_BIT) {
 		switch (clock) {
 		case 200000000:
@@ -189,8 +223,32 @@ static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock)
 		dev_err(mmc_dev(host->mmc), "DLL failed to relock\n");
 		return;
 	}
+}
+
+static void sdhci_am654_write_itapdly(struct sdhci_am654_data *sdhci_am654,
+				      u32 itapdly)
+{
+	/* Set ITAPCHGWIN before writing to ITAPDLY */
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
+			   1 << ITAPCHGWIN_SHIFT);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYSEL_MASK,
+			   itapdly << ITAPDLYSEL_SHIFT);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
+}
+
+static void sdhci_am654_setup_delay_chain(struct sdhci_am654_data *sdhci_am654,
+					  unsigned char timing)
+{
+	u32 mask, val;
 
-	sdhci_am654->dll_on = true;
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK, 0);
+
+	val = 1 << SELDLYTXCLK_SHIFT | 1 << SELDLYRXCLK_SHIFT;
+	mask = SELDLYTXCLK_MASK | SELDLYRXCLK_MASK;
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, mask, val);
+
+	sdhci_am654_write_itapdly(sdhci_am654,
+				  sdhci_am654->itap_del_sel[timing]);
 }
 
 static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
@@ -202,11 +260,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	u32 otap_del_ena;
 	u32 mask, val;
 
-	if (sdhci_am654->dll_on) {
-		regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK, 0);
-
-		sdhci_am654->dll_on = false;
-	}
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK, 0);
 
 	sdhci_set_clock(host, clock);
 
@@ -234,14 +288,10 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
 
-	if (timing > MMC_TIMING_UHS_SDR25 && clock > CLOCK_TOO_SLOW_HZ) {
-		regmap_update_bits(sdhci_am654->base, PHY_CTRL5,
-				   SELDLYTXCLK_MASK, 0);
+	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ)
 		sdhci_am654_setup_dll(host, clock);
-	} else {
-		regmap_update_bits(sdhci_am654->base, PHY_CTRL5,
-				   SELDLYTXCLK_MASK, 1 << SELDLYTXCLK_SHIFT);
-	}
+	else
+		sdhci_am654_setup_delay_chain(sdhci_am654, timing);
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
 			   sdhci_am654->clkbuf_sel);
@@ -469,7 +519,7 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
 	int i;
 	int ret;
 
-	ret = device_property_read_u32(dev, td[MMC_TIMING_LEGACY].binding,
+	ret = device_property_read_u32(dev, td[MMC_TIMING_LEGACY].otap_binding,
 				 &sdhci_am654->otap_del_sel[MMC_TIMING_LEGACY]);
 	if (ret) {
 		/*
@@ -492,11 +542,11 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
 
 	for (i = MMC_TIMING_MMC_HS; i <= MMC_TIMING_MMC_HS400; i++) {
 
-		ret = device_property_read_u32(dev, td[i].binding,
+		ret = device_property_read_u32(dev, td[i].otap_binding,
 					       &sdhci_am654->otap_del_sel[i]);
 		if (ret) {
 			dev_dbg(dev, "Couldn't find %s\n",
-				td[i].binding);
+				td[i].otap_binding);
 			/*
 			 * Remove the corresponding capability
 			 * if an otap-del-sel value is not found
@@ -506,6 +556,10 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
 			else
 				host->mmc->caps2 &= ~td[i].capability;
 		}
+
+		if (td[i].itap_binding)
+			device_property_read_u32(dev, td[i].itap_binding,
+						 &sdhci_am654->itap_del_sel[i]);
 	}
 
 	return 0;
-- 
2.17.1

