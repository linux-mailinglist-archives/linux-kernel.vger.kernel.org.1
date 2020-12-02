Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5B32CB575
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387573AbgLBHDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:03:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:44047 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387511AbgLBHDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:03:20 -0500
IronPort-SDR: g7L4R4e6Z63snvCw+9f/hhsrYtzcp0046OLalpluV8XNop3wA7ICckOJjPKL7H5c4vxQ+fC3Ya
 kY3uFo+Xpb/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="169461815"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="169461815"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 23:02:37 -0800
IronPort-SDR: mGwBjKhELaVG0zSR+6Of1Ip3CH812qCUQ2s0ZkvHk3oLquttH1FXsacFriy0TSRhHmJMja39RA
 JMr+HRBhAx0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="481430011"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga004.jf.intel.com with ESMTP; 01 Dec 2020 23:02:35 -0800
From:   muhammad.husaini.zulkifli@intel.com
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        michal.simek@xilinx.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, mgross@linux.intel.com
Subject: [PATCH v6 1/4] mmc: sdhci-of-arasan: Add structure device pointer in probe func
Date:   Wed,  2 Dec 2020 23:02:01 +0800
Message-Id: <20201202150205.20150-2-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
References: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Add struct device *dev in probe func() so that it can widely use in
probe to make code more readable.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Reviewed-by: mark gross <mgross@linux.intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 38 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index d25a4b50c2f3..196e3d65277e 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1508,9 +1508,10 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_arasan_data *sdhci_arasan;
 	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	const struct sdhci_arasan_of_data *data;
 
-	match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
+	match = of_match_node(sdhci_arasan_of_match, dev->of_node);
 	data = match->data;
 	host = sdhci_pltfm_init(pdev, data->pdata, sizeof(*sdhci_arasan));
 
@@ -1524,42 +1525,42 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	sdhci_arasan->soc_ctl_map = data->soc_ctl_map;
 	sdhci_arasan->clk_ops = data->clk_ops;
 
-	node = of_parse_phandle(pdev->dev.of_node, "arasan,soc-ctl-syscon", 0);
+	node = of_parse_phandle(dev->of_node, "arasan,soc-ctl-syscon", 0);
 	if (node) {
 		sdhci_arasan->soc_ctl_base = syscon_node_to_regmap(node);
 		of_node_put(node);
 
 		if (IS_ERR(sdhci_arasan->soc_ctl_base)) {
-			ret = dev_err_probe(&pdev->dev,
+			ret = dev_err_probe(dev,
 					    PTR_ERR(sdhci_arasan->soc_ctl_base),
 					    "Can't get syscon\n");
 			goto err_pltfm_free;
 		}
 	}
 
-	sdhci_arasan->clk_ahb = devm_clk_get(&pdev->dev, "clk_ahb");
+	sdhci_arasan->clk_ahb = devm_clk_get(dev, "clk_ahb");
 	if (IS_ERR(sdhci_arasan->clk_ahb)) {
-		dev_err(&pdev->dev, "clk_ahb clock not found.\n");
+		dev_err(dev, "clk_ahb clock not found.\n");
 		ret = PTR_ERR(sdhci_arasan->clk_ahb);
 		goto err_pltfm_free;
 	}
 
-	clk_xin = devm_clk_get(&pdev->dev, "clk_xin");
+	clk_xin = devm_clk_get(dev, "clk_xin");
 	if (IS_ERR(clk_xin)) {
-		dev_err(&pdev->dev, "clk_xin clock not found.\n");
+		dev_err(dev, "clk_xin clock not found.\n");
 		ret = PTR_ERR(clk_xin);
 		goto err_pltfm_free;
 	}
 
 	ret = clk_prepare_enable(sdhci_arasan->clk_ahb);
 	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable AHB clock.\n");
+		dev_err(dev, "Unable to enable AHB clock.\n");
 		goto err_pltfm_free;
 	}
 
 	ret = clk_prepare_enable(clk_xin);
 	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable SD clock.\n");
+		dev_err(dev, "Unable to enable SD clock.\n");
 		goto clk_dis_ahb;
 	}
 
@@ -1573,7 +1574,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	pltfm_host->clk = clk_xin;
 
-	if (of_device_is_compatible(pdev->dev.of_node,
+	if (of_device_is_compatible(dev->of_node,
 				    "rockchip,rk3399-sdhci-5.1"))
 		sdhci_arasan_update_clockmultiplier(host, 0x0);
 
@@ -1588,7 +1589,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	sdhci_arasan_update_baseclkfreq(host);
 
-	ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, &pdev->dev);
+	ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, dev);
 	if (ret)
 		goto clk_disable_all;
 
@@ -1597,29 +1598,28 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 			arasan_zynqmp_execute_tuning;
 	}
 
-	arasan_dt_parse_clk_phases(&pdev->dev, &sdhci_arasan->clk_data);
+	arasan_dt_parse_clk_phases(dev, &sdhci_arasan->clk_data);
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret) {
 		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "parsing dt failed (%d)\n", ret);
+			dev_err(dev, "parsing dt failed (%d)\n", ret);
 		goto unreg_clk;
 	}
 
 	sdhci_arasan->phy = ERR_PTR(-ENODEV);
-	if (of_device_is_compatible(pdev->dev.of_node,
+	if (of_device_is_compatible(dev->of_node,
 				    "arasan,sdhci-5.1")) {
-		sdhci_arasan->phy = devm_phy_get(&pdev->dev,
-						 "phy_arasan");
+		sdhci_arasan->phy = devm_phy_get(dev, "phy_arasan");
 		if (IS_ERR(sdhci_arasan->phy)) {
 			ret = PTR_ERR(sdhci_arasan->phy);
-			dev_err(&pdev->dev, "No phy for arasan,sdhci-5.1.\n");
+			dev_err(dev, "No phy for arasan,sdhci-5.1.\n");
 			goto unreg_clk;
 		}
 
 		ret = phy_init(sdhci_arasan->phy);
 		if (ret < 0) {
-			dev_err(&pdev->dev, "phy_init err.\n");
+			dev_err(dev, "phy_init err.\n");
 			goto unreg_clk;
 		}
 
@@ -1644,7 +1644,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	if (!IS_ERR(sdhci_arasan->phy))
 		phy_exit(sdhci_arasan->phy);
 unreg_clk:
-	sdhci_arasan_unregister_sdclk(&pdev->dev);
+	sdhci_arasan_unregister_sdclk(dev);
 clk_disable_all:
 	clk_disable_unprepare(clk_xin);
 clk_dis_ahb:
-- 
2.17.1

