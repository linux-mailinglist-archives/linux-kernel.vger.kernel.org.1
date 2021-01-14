Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB42F648D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbhANP3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:29:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:7044 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbhANP3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:29:14 -0500
IronPort-SDR: BaNT3Bb6qOTjPIL5bXyO99UOwGWu71gmzpLGUUEGjMud6/bpJaOC6QPA+VG0ZZKqd6EOPpcA/0
 gW0dQ7AC51ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="177604650"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="177604650"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 07:28:34 -0800
IronPort-SDR: dILQRkIpTGFKwwYtWjr0dNTrkFx0YCtigf5SjsCMPo5ZKO2KeyZCWXdfJPICI7i5St/VQiFC6r
 C/JucOne765w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="568193576"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2021 07:28:31 -0800
From:   Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To:     ulf.hansson@linaro.org, broonie@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, Rashmi.A@intel.com,
        mahesh.r.vaidya@intel.com, muhammad.husaini.zulkifli@intel.com
Subject: [PATCH v1 2/9] mmc: sdhci-of-arasan: Convert to use np instead of pdev->dev.of_node
Date:   Thu, 14 Jan 2021 23:26:53 +0800
Message-Id: <20210114152700.21916-3-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use np pointer to simplify code and improve readability.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 07479019caf9..ecaea4b45367 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1529,7 +1529,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	sdhci_arasan->soc_ctl_map = data->soc_ctl_map;
 	sdhci_arasan->clk_ops = data->clk_ops;
 
-	node = of_parse_phandle(pdev->dev.of_node, "arasan,soc-ctl-syscon", 0);
+	node = of_parse_phandle(np, "arasan,soc-ctl-syscon", 0);
 	if (node) {
 		sdhci_arasan->soc_ctl_base = syscon_node_to_regmap(node);
 		of_node_put(node);
@@ -1578,8 +1578,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	pltfm_host->clk = clk_xin;
 
-	if (of_device_is_compatible(pdev->dev.of_node,
-				    "rockchip,rk3399-sdhci-5.1"))
+	if (of_device_is_compatible(np, "rockchip,rk3399-sdhci-5.1"))
 		sdhci_arasan_update_clockmultiplier(host, 0x0);
 
 	if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-emmc") ||
@@ -1612,8 +1611,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	}
 
 	sdhci_arasan->phy = ERR_PTR(-ENODEV);
-	if (of_device_is_compatible(pdev->dev.of_node,
-				    "arasan,sdhci-5.1")) {
+	if (of_device_is_compatible(np, "arasan,sdhci-5.1")) {
 		sdhci_arasan->phy = devm_phy_get(&pdev->dev,
 						 "phy_arasan");
 		if (IS_ERR(sdhci_arasan->phy)) {
-- 
2.17.1

