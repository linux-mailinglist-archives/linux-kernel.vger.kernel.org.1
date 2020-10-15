Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C46428FB79
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 01:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgJOXMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 19:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgJOXMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 19:12:12 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FC7C061755;
        Thu, 15 Oct 2020 16:12:11 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8C9E622EDB;
        Fri, 16 Oct 2020 01:12:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1602803524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+gqs6DU6+D0AVT4vRcQvwcZjxKuWqFgpaDX9KJb6mfw=;
        b=SOoZ7hzjvF9KZRTiAH8wK36a6nngxpVaLG/6S+geTpKYk2q7HA4USfrXpVLPs4vqhFbl2t
        GtvtkDqt5QoUPeg2LvDfWbIxs0vr42Anga6ko1pfi3Pclo812YkNISL8TmrZ8+4WYzkHoo
        epV+RHWCwSIaII1H6qFZUnyL6eAySjU=
From:   Michael Walle <michael@walle.cc>
To:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yangbo Lu <yangbo.lu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] mmc: sdhci-of-esdhc: set timeout to max before tuning
Date:   Fri, 16 Oct 2020 01:11:49 +0200
Message-Id: <20201015231149.9333-1-michael@walle.cc>
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

Signed-off-by: Michael Walle <michael@walle.cc>
---
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

