Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F452A8CC4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgKFC2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgKFC2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:28:13 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4454FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:28:13 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t6so1715633plq.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NR1ivICtLGjc5GKL9a9KtfZ8+g5dAh32QHphuRSDQgM=;
        b=K1yPxFsehainWOtaPaj764QSWB3O6UiG/ZoqgIRVdsFNz7d5IDJzOzpI0EEBiSlTjc
         Pw8qfxQt8749DpfIx3JjnBdQ+P605c8DJnrZFv0vmQwiFz8vvcI5vK+PjY3ms0yThQP2
         SQEKLsfMRq4bCYO45MbQwaNQG8vIVvX/rOhKwbaCmAPRm80FGYyntA/yYhHANqCaUB/U
         z8f/FPOESKL/hsp+uzJZA3xGlQJAzxOsA0nhefczqnSxALESZtQ0lyMSBFqYZay3aifn
         ZUFhA7lsvQtX7UCSCvhVXhJo8V/L64nyYKPmkjXMbCfOPC4+gpFZ97vTELH8ofyCgM2f
         wVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NR1ivICtLGjc5GKL9a9KtfZ8+g5dAh32QHphuRSDQgM=;
        b=ZiknFaXdLFmWk6RCb1Jqh8Lu5w3hanFzHT2lGgzgf+aWujT6Qc7Cwl/1vQq9HR4ALS
         WMPZAi+vpzBsOAVN4xF8sOWIMZveQa1QRxu/uRi2F/7ssNdAAcUyJN0SDfVnrHFB1mGm
         wIdMWY8A37Fey+pUNyGNxEKAzTCaIIOcSumSCwMhFMk0X8nZhUF5lOzxwJMdPTZN1X5k
         P/Ea2EDM4YXqNRNKDZDljIlXbeDpsFQickcfkhl9eo7z8uz5khhKxSk21/emLqIaQNQk
         Vc8OMu0uC5NG1crkWflfMBJDPWyAdNKdvxocneiYW3QxvBdB/NTC7gt5/hrrZ01MckpA
         MDTg==
X-Gm-Message-State: AOAM531EibUxxKeohPNu9FEmdFq41X2ka4zGq0gQdDYMbjLKiZCRPi9F
        jDcGFxqwuMiPPkxuK3HdqjjstA==
X-Google-Smtp-Source: ABdhPJyZS7JsSki/u81WjWiTHlEraRrGd9/iQt2BVJxbVDkz28M2Mc57RLDz/vsKg0kWi1gSZupo6w==
X-Received: by 2002:a17:902:9a44:b029:d3:f10c:944a with SMTP id x4-20020a1709029a44b02900d3f10c944amr5043685plv.11.1604629692710;
        Thu, 05 Nov 2020 18:28:12 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:12 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 05/27] mmc: core: UHS-II support, skip TMODE setup in some cases
Date:   Fri,  6 Nov 2020 11:27:04 +0900
Message-Id: <20201106022726.19831-6-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UHS-II's data command packet has TMODE fields in which parameters for
data transaction, like Duplex Mode(DM) and Length Mode(LM), are specified.
In some cases, we don't need to initialize them and so set uhs2_tmode0_flag
to 1 in order to skip them in generating a packet.
(The code will be added in the next commit.)

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/core/block.c  | 7 ++++++-
 drivers/mmc/core/sd_ops.c | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 8d3df0be0355..f09794811042 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -56,6 +56,7 @@
 #include "mmc_ops.h"
 #include "quirks.h"
 #include "sd_ops.h"
+#include "uhs2.h"
 
 MODULE_ALIAS("mmc:block");
 #ifdef MODULE_PARAM_PREFIX
@@ -1523,6 +1524,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	struct request *req = mmc_queue_req_to_req(mqrq);
 	struct mmc_blk_data *md = mq->blkdata;
 	bool do_rel_wr, do_data_tag;
+	bool do_multi;
+
+	do_multi = (card->host->flags & MMC_UHS2_INITIALIZED) ? true : false;
 
 	mmc_blk_data_prep(mq, mqrq, disable_multi, &do_rel_wr, &do_data_tag);
 
@@ -1533,7 +1537,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 		brq->cmd.arg <<= 9;
 	brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 
-	if (brq->data.blocks > 1 || do_rel_wr) {
+	if (brq->data.blocks > 1 || do_rel_wr || do_multi) {
 		/* SPI multiblock writes terminate using a special
 		 * token, not a STOP_TRANSMISSION request.
 		 */
@@ -1546,6 +1550,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 		brq->mrq.stop = NULL;
 		readcmd = MMC_READ_SINGLE_BLOCK;
 		writecmd = MMC_WRITE_BLOCK;
+		brq->cmd.uhs2_tmode0_flag = 1;
 	}
 	brq->cmd.opcode = rq_data_dir(req) == READ ? readcmd : writecmd;
 
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 22bf528294b9..f58bb50872f6 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -235,6 +235,7 @@ int mmc_app_send_scr(struct mmc_card *card)
 	cmd.opcode = SD_APP_SEND_SCR;
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.uhs2_tmode0_flag = 1;
 
 	data.blksz = 8;
 	data.blocks = 1;
@@ -282,6 +283,7 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	cmd.arg &= ~(0xF << (group * 4));
 	cmd.arg |= value << (group * 4);
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.uhs2_tmode0_flag = 1;
 
 	data.blksz = 64;
 	data.blocks = 1;
@@ -323,6 +325,7 @@ int mmc_app_sd_status(struct mmc_card *card, void *ssr)
 	cmd.opcode = SD_APP_SD_STATUS;
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.uhs2_tmode0_flag = 1;
 
 	data.blksz = 64;
 	data.blocks = 1;
-- 
2.28.0

