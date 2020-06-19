Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C834F200925
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 14:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732736AbgFSM6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 08:58:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35030 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732660AbgFSM6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:58:35 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05JCwJen076832;
        Fri, 19 Jun 2020 07:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592571499;
        bh=PwbBrS5/93qfz/ERIiFrMFJ9ufsq6vvpld5u8B1rVWw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OaAhax4tGjxQR/5gRuR3ZACaUwao+J3cPA03IImLNm1YndigT5RpiG4soy/Yhh2//
         RjWaqVqnOBC/4zrN4jVl1GUaydtoduXTq1y2YbISCyhFaJ3VoQWApN/H1x7EM3HcVU
         8a6Qxv8CBIFNPKRQOm+rSteo/v+l5rn5D23sMDQk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05JCwI94081089
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Jun 2020 07:58:19 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 19
 Jun 2020 07:58:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 19 Jun 2020 07:58:18 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05JCw2Hn015675;
        Fri, 19 Jun 2020 07:58:15 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <adrian.hunter@intel.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>
CC:     <faiz_abbas@ti.com>
Subject: [PATCH 3/7] mmc: sdhci_am654: Add Support for SR2.0
Date:   Fri, 19 Jun 2020 18:27:57 +0530
Message-ID: <20200619125801.9530-4-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619125801.9530-1-faiz_abbas@ti.com>
References: <20200619125801.9530-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Support for AM65x PG2.0. Use the SoC bus framework to fixup
the driver data and skip do DLL calibration if the revision is 1.0

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 85a05344f825..365eb2819dd9 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -11,6 +11,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/sys_soc.h>
 
 #include "cqhci.h"
 #include "sdhci-pltfm.h"
@@ -324,12 +325,17 @@ static const struct sdhci_pltfm_data sdhci_am654_pdata = {
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
-static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
+static const struct sdhci_am654_driver_data sdhci_am654_sr1_drvdata = {
 	.pdata = &sdhci_am654_pdata,
 	.flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT | DLL_PRESENT |
 		 DLL_CALIB,
 };
 
+static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
+	.pdata = &sdhci_am654_pdata,
+	.flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT | DLL_PRESENT,
+};
+
 static struct sdhci_ops sdhci_j721e_8bit_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
@@ -376,6 +382,14 @@ static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
 	.flags = IOMUX_PRESENT,
 };
 
+static const struct soc_device_attribute sdhci_am654_devices[] = {
+	{ .family = "AM65X",
+	  .revision = "SR1.0",
+	  .data = &sdhci_am654_sr1_drvdata
+	},
+	{/* sentinel */}
+};
+
 static void sdhci_am654_dumpregs(struct mmc_host *mmc)
 {
 	sdhci_dumpregs(mmc_priv(mmc));
@@ -587,6 +601,7 @@ static const struct of_device_id sdhci_am654_of_match[] = {
 static int sdhci_am654_probe(struct platform_device *pdev)
 {
 	const struct sdhci_am654_driver_data *drvdata;
+	const struct soc_device_attribute *soc;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_am654_data *sdhci_am654;
 	const struct of_device_id *match;
@@ -598,6 +613,12 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 
 	match = of_match_node(sdhci_am654_of_match, pdev->dev.of_node);
 	drvdata = match->data;
+
+	/* Update drvdata based on SoC revision */
+	soc = soc_device_match(sdhci_am654_devices);
+	if (soc && soc->data)
+		drvdata = soc->data;
+
 	host = sdhci_pltfm_init(pdev, drvdata->pdata, sizeof(*sdhci_am654));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
-- 
2.17.1

