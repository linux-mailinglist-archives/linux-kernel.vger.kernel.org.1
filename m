Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1C5286CA1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 04:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgJHCM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 22:12:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:31771 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbgJHCM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 22:12:56 -0400
IronPort-SDR: iCbmh9GzXCOO+PLif5q0kHKPNyJVb7nNh5WmMKychErznAkwsANKRtHXeetcbHk1eAUImp7Gsd
 e/pVLmHD9LOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="152154717"
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="152154717"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 19:12:56 -0700
IronPort-SDR: CVEkUxXk4t4xZt6HtFCn0L+/Kx1c5zZdCcX8gmyGU2guYajpappKm4KW1x/R8qF/q5MgOumg4S
 E7FGUVuCZ8Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="355211218"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 19:12:53 -0700
From:   muhammad.husaini.zulkifli@intel.com
To:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        andriy.shevchenko@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, arnd@arndb.de
Subject: [PATCH v4 3/4] mmc: sdhci-of-arasan: Add structure device pointer in probe
Date:   Thu,  8 Oct 2020 10:09:35 +0800
Message-Id: <20201008020936.19894-4-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Add struct device *dev in probe func() so that it can widely use in
probe to make code more readable.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index f186fbd016b1..46aea6516133 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1521,6 +1521,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_arasan_data *sdhci_arasan;
 	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	const struct sdhci_arasan_of_data *data;
 
 	match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
-- 
2.17.1

