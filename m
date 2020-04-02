Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB98519C091
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 13:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388231AbgDBLzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 07:55:11 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:23679 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387988AbgDBLzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 07:55:01 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tM1t51G6z1vh;
        Thu,  2 Apr 2020 13:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585828498; bh=MhmlsMfvkZ/jxtgV76LjVAGMwapDNRZk0vRzuKiw1Lc=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=aVyemHYt6ay7agExHU3z9CkG0HakP+LveeeQ+IG1ZvMTlyzZqkIhv7c721tw57yao
         C79ZYKUO9tWADfUSB/PdMFT5W1Cke1hdD2R/4gKWnFXWzmmi5s60mYPHC8Cdf4Bnn2
         YztGPrmF6kJxEc2/8ZANqeINlERfScGMa0CUenLO1v/xeNT1ThZfEGsZHn+EZTummg
         F1lr7SnqP9hvhmRO1zBZ9ui3MrlkKYqTLG3lmwtG+n7jc5f1sOR3uZyUv1e4r+4k96
         cuR+Mc3kRBFq3NllsQyLk/fE2WeJ3gEKAytF5mECqiHk0WNr+0xApblKxQbO9z47jG
         3+81UyfnQrOPg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 13:54:58 +0200
Message-Id: <84482c3f74fae701f8366bea681fc799918b1ab8.1585827904.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 7/7] mmc: sdhci: respect non-zero div quirk in programmable
 clock mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN respected also in programmable
clock mode.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/sdhci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 01fd897f8f3c..df80f39c570b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1807,9 +1807,6 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 
 	div = DIV_ROUND_UP(host->max_clk, clock);
 
-	if (div == 1 && (host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN))
-		div = 2;
-
 	if (host->version >= SDHCI_SPEC_300) {
 		/* Version 3.00 divisors must be a multiple of 2. */
 		div = min(div, SDHCI_MAX_DIV_SPEC_300);
@@ -1823,6 +1820,12 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 	real_div = div * 2 + !div;
 
 clock_set:
+	if (!div && (host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)) {
+		/* for div == 1, clock rate is divided by 2 in both modes */
+		div = 1;
+		real_div = 2;
+	}
+
 	*actual_clock = (host->max_clk * clk_mul) / real_div;
 	clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
 	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
-- 
2.20.1

