Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C128828184A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgJBQtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBQtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:49:39 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D77EC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 09:49:38 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z23so2859607ejr.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 09:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jt0mTKD7biJvR9C/s8GFzCkzqMneNgtMalWKvcqcZ30=;
        b=EdjwouQlpw+idcJObMj1jPU1XGKGGQ0BEVqaE7YHdOSPuhnSOUbNgFMamRCgjLp/0q
         H44qtdpsxizB7fJjt3tx7nr24WboyDOF5FTSPnmlMU4kH8JDOKH2gw+i8sEJ+zPKb0gM
         JgN+3UndIwmk96JBb3avGZ2zk+iGphGgWbERjPJWWjpSkl45bq5Jb3ZJiuqv2Czx3Wz6
         WWcfOHD/W0plTO7SW3ZxLg8T8lkwzC3FXlG6h7MhCcZfpjzNUUGBgnR6I/2TjdDVHEBO
         Zqp6rV7udmQnZ0BuoYxqW2q8sZdb0EEE3MvLXx4qLjLtNfcl8fiOGW17JgrKroxGeWb7
         jnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jt0mTKD7biJvR9C/s8GFzCkzqMneNgtMalWKvcqcZ30=;
        b=T0nB2UO0wGFCcQNtIW6mwRUMf1MorPl3xZjjPFwlAvDvHnbzwCNXbAC1IPepnrgBeX
         wRSdnCsDeZZLM4mq2gEBwY66ZMdvXjrBulbXSMoR5s0qoEHtKnD5JqYaKQGu4indXK84
         xnhnJ+8SEFURpPfENu8rBqVJdFDwEtxvognISyC0MpZMpwTqgXASmJaa8NaVGLig/3Gu
         X46KwNxAnZYx3X0ZCgAoP11+7Nkh3KHLcHyku6JDQx56WGRNLjcaofuG1wvB8U9Kxp5j
         ZUNcZoVhsd9pS13nwr7YfU8SIxOrqqNKRZMyw4LcjGPgc+fn8xWo9SfHp2Zkxb+zLBNS
         yyKA==
X-Gm-Message-State: AOAM530hovnnCYTsq02tR10aGDEXA9cJ36LIRSjlZrYo7r4rX9aIBl6H
        7FvJ9OIE6bDWOLfLa/XSr7zqgw==
X-Google-Smtp-Source: ABdhPJzYKdYeTdWqSU8vWwnYGHuNNzK8lAmxh4xAjC4EFgh1Og8vu0MicZjCYnSgGajWJjpOHDvogA==
X-Received: by 2002:a17:906:1dd0:: with SMTP id v16mr3135410ejh.309.1601657376897;
        Fri, 02 Oct 2020 09:49:36 -0700 (PDT)
Received: from starbuck.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id r27sm1586429edx.33.2020.10.02.09.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 09:49:36 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Brad Harper <bjharper@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] mmc: meson-gx: remove IRQF_ONESHOT
Date:   Fri,  2 Oct 2020 18:49:15 +0200
Message-Id: <20201002164915.938217-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQF_ONESHOT was added to this driver to make sure the irq was not enabled
again until the thread part of the irq had finished doing its job.

Doing so upsets RT because, under RT, the hardirq part of the irq handler
is not migrated to a thread if the irq is claimed with IRQF_ONESHOT.
In this case, it has been reported to eventually trigger a deadlock with
the led subsystem.

Preventing RT from doing this migration was certainly not the intent, the
description of IRQF_ONESHOT does not really reflect this constraint:

 > IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler finished.
 >              Used by threaded interrupts which need to keep the
 >              irq line disabled until the threaded handler has been run.

This is exactly what this driver was trying to acheive so I'm still a bit
confused whether this is a driver or an RT issue.

Anyway, this can be solved driver side by manually disabling the IRQs
instead of the relying on the IRQF_ONESHOT. IRQF_ONESHOT may then be removed
while still making sure the irq won't trigger until the threaded part of
the handler is done.

Fixes: eb4d81127746 ("mmc: meson-gx: correct irq flag")
Reported-by: Brad Harper <bjharper@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 47 ++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 08a3b1c05acb..effc356db904 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -101,8 +101,7 @@
 #define   IRQ_RESP_STATUS BIT(14)
 #define   IRQ_SDIO BIT(15)
 #define   IRQ_EN_MASK \
-	(IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN | IRQ_RESP_STATUS |\
-	 IRQ_SDIO)
+	(IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN)
 
 #define SD_EMMC_CMD_CFG 0x50
 #define SD_EMMC_CMD_ARG 0x54
@@ -170,6 +169,7 @@ struct meson_host {
 	dma_addr_t descs_dma_addr;
 
 	int irq;
+	u32 irq_en;
 
 	bool vqmmc_enabled;
 };
@@ -842,22 +842,24 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	struct meson_host *host = dev_id;
 	struct mmc_command *cmd;
 	struct mmc_data *data;
-	u32 irq_en, status, raw_status;
+	u32  status, raw_status;
 	irqreturn_t ret = IRQ_NONE;
 
-	irq_en = readl(host->regs + SD_EMMC_IRQ_EN);
+	/* Disable irqs */
+	writel(0, host->regs + SD_EMMC_IRQ_EN);
+
 	raw_status = readl(host->regs + SD_EMMC_STATUS);
-	status = raw_status & irq_en;
+	status = raw_status & host->irq_en;
 
 	if (!status) {
 		dev_dbg(host->dev,
 			"Unexpected IRQ! irq_en 0x%08x - status 0x%08x\n",
-			 irq_en, raw_status);
-		return IRQ_NONE;
+			 host->irq_en, raw_status);
+		goto none;
 	}
 
 	if (WARN_ON(!host) || WARN_ON(!host->cmd))
-		return IRQ_NONE;
+		goto none;
 
 	/* ack all raised interrupts */
 	writel(status, host->regs + SD_EMMC_STATUS);
@@ -908,6 +910,11 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (ret == IRQ_HANDLED)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
 
+none:
+	/* Enable the irq again if the thread will not run */
+	if (ret != IRQ_WAKE_THREAD)
+		writel(host->irq_en, host->regs + SD_EMMC_IRQ_EN);
+
 	return ret;
 }
 
@@ -934,15 +941,17 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 	struct mmc_command *next_cmd, *cmd = host->cmd;
 	struct mmc_data *data;
 	unsigned int xfer_bytes;
+	int ret = IRQ_HANDLED;
 
-	if (WARN_ON(!cmd))
-		return IRQ_NONE;
+	if (WARN_ON(!cmd)) {
+		ret = IRQ_NONE;
+		goto out;
+	}
 
 	if (cmd->error) {
 		meson_mmc_wait_desc_stop(host);
 		meson_mmc_request_done(host->mmc, cmd->mrq);
-
-		return IRQ_HANDLED;
+		goto out;
 	}
 
 	data = cmd->data;
@@ -959,7 +968,10 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 	else
 		meson_mmc_request_done(host->mmc, cmd->mrq);
 
-	return IRQ_HANDLED;
+out:
+	/* Re-enable the irqs */
+	writel(host->irq_en, host->regs + SD_EMMC_IRQ_EN);
+	return ret;
 }
 
 /*
@@ -1133,13 +1145,12 @@ static int meson_mmc_probe(struct platform_device *pdev)
 
 	/* clear, ack and enable interrupts */
 	writel(0, host->regs + SD_EMMC_IRQ_EN);
-	writel(IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN,
-	       host->regs + SD_EMMC_STATUS);
-	writel(IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN,
-	       host->regs + SD_EMMC_IRQ_EN);
+	host->irq_en = IRQ_EN_MASK;
+	writel(host->irq_en, host->regs + SD_EMMC_STATUS);
+	writel(host->irq_en, host->regs + SD_EMMC_IRQ_EN);
 
 	ret = request_threaded_irq(host->irq, meson_mmc_irq,
-				   meson_mmc_irq_thread, IRQF_ONESHOT,
+				   meson_mmc_irq_thread, 0,
 				   dev_name(&pdev->dev), host);
 	if (ret)
 		goto err_init_clk;
-- 
2.25.4

