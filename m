Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7098C1AE189
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 17:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgDQPtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 11:49:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42599 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729201AbgDQPtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:49:07 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jPTEk-0002E1-4Z; Fri, 17 Apr 2020 15:49:02 +0000
From:   Colin King <colin.king@canonical.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] sdhci: arasan: fix uninitialized value being returned as error code
Date:   Fri, 17 Apr 2020 16:49:01 +0100
Message-Id: <20200417154901.112236-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the error return value in variable ret is not being initialized
and so a successful return path is returning a garbage value. Since ret
is not being used the simple fix is just return 0 on a successful return.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: f73e66a36772 ("sdhci: arasan: Add support for Versal Tap Delays")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 16e26c217a77..45603ba515b2 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -735,7 +735,6 @@ static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
 		container_of(clk_data, struct sdhci_arasan_data, clk_data);
 	struct sdhci_host *host = sdhci_arasan->host;
 	u8 tap_delay, tap_max = 0;
-	int ret;
 
 	/*
 	 * This is applicable for SDHCI_SPEC_300 and above
@@ -781,7 +780,7 @@ static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
 		sdhci_writel(host, regval, SDHCI_ARASAN_OTAPDLY_REGISTER);
 	}
 
-	return ret;
+	return 0;
 }
 
 static const struct clk_ops versal_sdcardclk_ops = {
@@ -807,7 +806,6 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
 		container_of(clk_data, struct sdhci_arasan_data, clk_data);
 	struct sdhci_host *host = sdhci_arasan->host;
 	u8 tap_delay, tap_max = 0;
-	int ret;
 
 	/*
 	 * This is applicable for SDHCI_SPEC_300 and above
@@ -857,7 +855,7 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
 		sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
 	}
 
-	return ret;
+	return 0;
 }
 
 static const struct clk_ops versal_sampleclk_ops = {
-- 
2.25.1

