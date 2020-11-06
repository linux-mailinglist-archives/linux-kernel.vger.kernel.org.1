Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64712A8E10
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 05:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgKFEJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 23:09:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:11272 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgKFEJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 23:09:56 -0500
IronPort-SDR: UikGDYcWiO8+XinSvtapjalX9cWmNIXL5lm+OEngz70zoPyjpdslD5zo++veb2cHxNrpj7R/a7
 0m9d1JV9p+VQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="166909027"
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="166909027"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 20:09:55 -0800
IronPort-SDR: MxCqS5DlBO6FG8aVKfKbxZ8aOdpl5wS3AJK6mFRvcBabB+dKNHWSNEthbVzPZuJzc5TF2NgHa9
 SKfLVDwlYAnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="354560667"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by fmsmga004.fm.intel.com with ESMTP; 05 Nov 2020 20:09:53 -0800
From:   muhammad.husaini.zulkifli@intel.com
To:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     adrian.hunter@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, david.e.box@linux.intel.com
Subject: [PATCH v1 1/1] mmc: sdhci-of-arasan: Specify .clk_ops for Keem Bay SOC
Date:   Fri,  6 Nov 2020 20:09:33 +0800
Message-Id: <20201106120933.7190-2-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106120933.7190-1-muhammad.husaini.zulkifli@intel.com>
References: <20201106120933.7190-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Commit 16ada730a759 ("mmc: sdhci-of-arasan: Modify clock operations handling")
introduces platform specific SDHCI clock operation.

This patch declares the clock operation for Keem Bay.
Add clk_ops for SD, EMMC and SDIO operations.

Fixes: 36c6aadaae86 ("mmc: sdhci-of-arasan: Add support for Intel Keem Bay")

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 829ccef87426..012d52e1abee 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1199,16 +1199,19 @@ static struct sdhci_arasan_of_data sdhci_arasan_versal_data = {
 static struct sdhci_arasan_of_data intel_keembay_emmc_data = {
 	.soc_ctl_map = &intel_keembay_soc_ctl_map,
 	.pdata = &sdhci_keembay_emmc_pdata,
+	.clk_ops = &arasan_clk_ops,
 };
 
 static struct sdhci_arasan_of_data intel_keembay_sd_data = {
 	.soc_ctl_map = &intel_keembay_soc_ctl_map,
 	.pdata = &sdhci_keembay_sd_pdata,
+	.clk_ops = &arasan_clk_ops,
 };
 
 static struct sdhci_arasan_of_data intel_keembay_sdio_data = {
 	.soc_ctl_map = &intel_keembay_soc_ctl_map,
 	.pdata = &sdhci_keembay_sdio_pdata,
+	.clk_ops = &arasan_clk_ops,
 };
 
 static const struct of_device_id sdhci_arasan_of_match[] = {
-- 
2.17.1

