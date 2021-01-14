Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DFF2F648C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbhANP3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:29:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:7042 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbhANP3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:29:11 -0500
IronPort-SDR: TN7ABXlD9rHFxNCiTwF8LV4rYhsUpCGoc9GS0bFe5BeCE4P0T6YACcwk2/e1BT8nwGgI9PfByg
 cqSBkLHJncgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="177604646"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="177604646"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 07:28:30 -0800
IronPort-SDR: NoxZ3DHvz2CuXS0x4PLU/X4En+RToa7BGMCe4CfyQkjDrSYR5QyUo3kDJNk6vMScPTt5biLQeh
 GjTIxLb5O//g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="568193554"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2021 07:28:27 -0800
From:   Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To:     ulf.hansson@linaro.org, broonie@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, Rashmi.A@intel.com,
        mahesh.r.vaidya@intel.com, muhammad.husaini.zulkifli@intel.com
Subject: [PATCH v1 1/9] mmc: sdhci-of-arasan: use of_device_get_match_data()
Date:   Thu, 14 Jan 2021 23:26:52 +0800
Message-Id: <20210114152700.21916-2-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() helper to get the match-data.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 4f3774bcda94..07479019caf9 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1508,7 +1508,6 @@ static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
 static int sdhci_arasan_probe(struct platform_device *pdev)
 {
 	int ret;
-	const struct of_device_id *match;
 	struct device_node *node;
 	struct clk *clk_xin;
 	struct sdhci_host *host;
@@ -1517,8 +1516,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	const struct sdhci_arasan_of_data *data;
 
-	match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
-	data = match->data;
+	data = of_device_get_match_data(&pdev->dev);
 	host = sdhci_pltfm_init(pdev, data->pdata, sizeof(*sdhci_arasan));
 
 	if (IS_ERR(host))
-- 
2.17.1

