Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D89B296711
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 00:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370028AbgJVWYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 18:24:11 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:47693 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369632AbgJVWYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 18:24:10 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E189322F00;
        Fri, 23 Oct 2020 00:24:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1603405448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cdCHaJkQW9rShLRXxj7ElU/lrunlyUEAtdDvcabUG2w=;
        b=XOi0x38w8s2x0F5DnnWfqaJ7NvNOk3w5LH4ZGac8IQsDEGRT3Vz9UJUTOK6O+38DAdlw1G
        SlEb6ObsC6stYC64Duv7YwDpUURY96cQ1SBqm09hjM5bil2iC2bBdjpyx77r9v67Jo3rqI
        2PwZhur5vZ8t31c8iGMjGPUguYBC2AM=
From:   Michael Walle <michael@walle.cc>
To:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yangbo Lu <yangbo.lu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2] mmc: sdhci-of-esdhc: set timeout to max before tuning
Date:   Fri, 23 Oct 2020 00:23:37 +0200
Message-Id: <20201022222337.19857-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On rare occations there is the following error:

  mmc0: Tuning timeout, falling back to fixed sampling clock

There are SD cards which takes a significant longer time to reply to the
first CMD19 command. The eSDHC takes the data timeout value into account
during the tuning period. The SDHCI core doesn't explicitly set this
timeout for the tuning procedure. Thus on the slow cards, there might be
a spurious "Buffer Read Ready" interrupt, which in turn triggers a wrong
sequence of events. In the end this will lead to an unsuccessful tuning
procedure and to the above error.

To workaround this, set the timeout to the maximum value (which is the
best we can do) and the SDHCI core will take care of the proper timeout
handling.

Fixes: ba49cbd0936e ("mmc: sdhci-of-esdhc: add tuning support")
Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>

---
Changes since v1:
 - Added fixes tag. Suggested by Ulf Hansson.

 drivers/mmc/host/sdhci-of-esdhc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 0b45eff6fed4..baf7801a1804 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1052,6 +1052,17 @@ static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	esdhc_tuning_block_enable(host, true);
 
+	/*
+	 * The eSDHC controller takes the data timeout value into account
+	 * during tuning. If the SD card is too slow sending the response, the
+	 * timer will expire and a "Buffer Read Ready" interrupt without data
+	 * is triggered. This leads to tuning errors.
+	 *
+	 * Just set the timeout to the maximum value because the core will
+	 * already take care of it in sdhci_send_tuning().
+	 */
+	sdhci_writeb(host, 0xe, SDHCI_TIMEOUT_CONTROL);
+
 	hs400_tuning = host->flags & SDHCI_HS400_TUNING;
 
 	do {
-- 
2.20.1

