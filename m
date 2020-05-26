Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2181BB465
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 05:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgD1DKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 23:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgD1DKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:10:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F2AC03C1A9;
        Mon, 27 Apr 2020 20:10:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f8so7788787plt.2;
        Mon, 27 Apr 2020 20:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ylsA8WaqXyTBO+CWgCMTXAPf19Z8eh+tsnbfkjgC0es=;
        b=hntOtfu9vmdgLCg3Q05LG2S6LNz7mY+b8poU5Lpi3rIb9kiVnPGQ6xvBe+yHr/ywsu
         JLSxo6efUQVPWyHhyq4cOdDwfJMAQtnPQFnSklabfVQDZ5sRDFHHt2H+zWctJRzSjFYR
         oCN7Z2SigYgH32EM3UTQmx//gAsFgd6K7jmFe0lj0pCBW4HKF1CK3W6t3Pgp6eRaNrLO
         yNzjjw3mqo4ZZLOSRhQj7hKi87YZ/8PdITck5lvY3iHImc2jHgiiA/7lEXCTTtHY4fSQ
         /9tu353zNTuerb5clqudOqSv+2sPYstUn5gFfg1gfnW9uXHcWRoYc7UnO+llaYcONLEX
         BluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ylsA8WaqXyTBO+CWgCMTXAPf19Z8eh+tsnbfkjgC0es=;
        b=UZjT6t8RNSih1oKHSevakqgl/Y/oCmTUnlqgac66iBUP6UJsif+m+soEpocq/axWFj
         sKYUydsv7bCxRpxiOVgUrrltplZ03QC/5E4FZdRVtSTimmXlH+I7Wml1xf4i5wiFlR65
         jT/khGUfielsbslHS2E86kB2PnhE8TXyhYRSaD7pGIkFuTKVDHjCXXBmjFaRqUoNbNQS
         rp5Dszstzz9jYRkqqv22DlOWURk/+KCbsO9MznNFqVhz6unR+ejGASqFuY7Zh+y7jg97
         f5Uu786L+YsHBsEd7suonplcSIL4ciV31/zDW5Ufuha88zptK1tnoS2mASO+98w2e95G
         recQ==
X-Gm-Message-State: AGi0Pua5fovAkwYcbgIqV5RfV2eX65Xl6VqZET7fQJavwVTqB+kYcu3H
        OAXETP5ED0OyAk8oxS7uTrZTCYe9B9M=
X-Google-Smtp-Source: APiQypI0n22Q6s9bT42vD7l8MJf+GgQTTJ2Gdi8vSdz6dFkq9Urzia0TCjnrpp6qQTFPAO13g3Eypg==
X-Received: by 2002:a17:902:dc84:: with SMTP id n4mr10028881pld.281.1588043421146;
        Mon, 27 Apr 2020 20:10:21 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id 30sm6298643pgp.38.2020.04.27.20.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 20:10:20 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     robh+dt@kernel.org, jassisinghbrar@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] mailbox: sprd: Add Spreadtrum mailbox driver
Date:   Tue, 28 Apr 2020 11:10:01 +0800
Message-Id: <4b224e7bb703e15469e5cd79a54f7bc00a790fc5.1588043236.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <8d29eba045ef18c5489e122b3668afc20431f15d.1588043236.git.baolin.wang7@gmail.com>
References: <8d29eba045ef18c5489e122b3668afc20431f15d.1588043236.git.baolin.wang7@gmail.com>
In-Reply-To: <8d29eba045ef18c5489e122b3668afc20431f15d.1588043236.git.baolin.wang7@gmail.com>
References: <8d29eba045ef18c5489e122b3668afc20431f15d.1588043236.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@unisoc.com>

The Spreadtrum mailbox controller supports 8 channels to communicate
with MCUs, and it contains 2 different parts: inbox and outbox, which
are used to send and receive messages by IRQ mode.

Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
Changes from v3:
 - Save the id in mbox_chan.con_priv and remove the 'sprd_mbox_chan'

Changes from v2:
 - None.

Changes from v1:
 - None
---
 drivers/mailbox/Kconfig        |   8 +
 drivers/mailbox/Makefile       |   2 +
 drivers/mailbox/sprd-mailbox.c | 341 +++++++++++++++++++++++++++++++++
 3 files changed, 351 insertions(+)
 create mode 100644 drivers/mailbox/sprd-mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 5a577a6734cf..e03f3fb5caed 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -236,4 +236,12 @@ config SUN6I_MSGBOX
 	  various Allwinner SoCs. This mailbox is used for communication
 	  between the application CPUs and the power management coprocessor.
 
+config SPRD_MBOX
+	tristate "Spreadtrum Mailbox"
+	depends on ARCH_SPRD || COMPILE_TEST
+	help
+	  Mailbox driver implementation for the Spreadtrum platform. It is used
+	  to send message between application processors and MCU. Say Y here if
+	  you want to build the Spreatrum mailbox controller driver.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 2e4364ef5c47..9caf4ede6ce0 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -50,3 +50,5 @@ obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
 obj-$(CONFIG_ZYNQMP_IPI_MBOX)	+= zynqmp-ipi-mailbox.o
 
 obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
+
+obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
new file mode 100644
index 000000000000..f2c04984858a
--- /dev/null
+++ b/drivers/mailbox/sprd-mailbox.c
@@ -0,0 +1,341 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Spreadtrum mailbox driver
+ *
+ * Copyright (c) 2020 Spreadtrum Communications Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+#define SPRD_MBOX_ID		0x0
+#define SPRD_MBOX_MSG_LOW	0x4
+#define SPRD_MBOX_MSG_HIGH	0x8
+#define SPRD_MBOX_TRIGGER	0xc
+#define SPRD_MBOX_FIFO_RST	0x10
+#define SPRD_MBOX_FIFO_STS	0x14
+#define SPRD_MBOX_IRQ_STS	0x18
+#define SPRD_MBOX_IRQ_MSK	0x1c
+#define SPRD_MBOX_LOCK		0x20
+#define SPRD_MBOX_FIFO_DEPTH	0x24
+
+/* Bit and mask definiation for inbox's SPRD_MBOX_FIFO_STS register */
+#define SPRD_INBOX_FIFO_DELIVER_MASK		GENMASK(23, 16)
+#define SPRD_INBOX_FIFO_OVERLOW_MASK		GENMASK(15, 8)
+#define SPRD_INBOX_FIFO_DELIVER_SHIFT		16
+#define SPRD_INBOX_FIFO_BUSY_MASK		GENMASK(7, 0)
+
+/* Bit and mask definiation for SPRD_MBOX_IRQ_STS register */
+#define SPRD_MBOX_IRQ_CLR			BIT(0)
+
+/* Bit and mask definiation for outbox's SPRD_MBOX_FIFO_STS register */
+#define SPRD_OUTBOX_FIFO_FULL			BIT(0)
+#define SPRD_OUTBOX_FIFO_WR_SHIFT		16
+#define SPRD_OUTBOX_FIFO_RD_SHIFT		24
+#define SPRD_OUTBOX_FIFO_POS_MASK		GENMASK(7, 0)
+
+/* Bit and mask definiation for inbox's SPRD_MBOX_IRQ_MSK register */
+#define SPRD_INBOX_FIFO_BLOCK_IRQ		BIT(0)
+#define SPRD_INBOX_FIFO_OVERFLOW_IRQ		BIT(1)
+#define SPRD_INBOX_FIFO_DELIVER_IRQ		BIT(2)
+#define SPRD_INBOX_FIFO_IRQ_MASK		GENMASK(2, 0)
+
+/* Bit and mask definiation for outbox's SPRD_MBOX_IRQ_MSK register */
+#define SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ		BIT(0)
+#define SPRD_OUTBOX_FIFO_IRQ_MASK		GENMASK(4, 0)
+
+#define SPRD_MBOX_CHAN_MAX			8
+
+struct sprd_mbox_priv {
+	struct mbox_controller	mbox;
+	struct device		*dev;
+	void __iomem		*inbox_base;
+	void __iomem		*outbox_base;
+	struct clk		*clk;
+	u32			outbox_fifo_depth;
+
+	struct mbox_chan	chan[SPRD_MBOX_CHAN_MAX];
+};
+
+static struct sprd_mbox_priv *to_sprd_mbox_priv(struct mbox_controller *mbox)
+{
+	return container_of(mbox, struct sprd_mbox_priv, mbox);
+}
+
+static u32 sprd_mbox_get_fifo_len(struct sprd_mbox_priv *priv, u32 fifo_sts)
+{
+	u32 wr_pos = (fifo_sts >> SPRD_OUTBOX_FIFO_WR_SHIFT) &
+		SPRD_OUTBOX_FIFO_POS_MASK;
+	u32 rd_pos = (fifo_sts >> SPRD_OUTBOX_FIFO_RD_SHIFT) &
+		SPRD_OUTBOX_FIFO_POS_MASK;
+	u32 fifo_len;
+
+	/*
+	 * If the read pointer is equal with write pointer, which means the fifo
+	 * is full or empty.
+	 */
+	if (wr_pos == rd_pos) {
+		if (fifo_sts & SPRD_OUTBOX_FIFO_FULL)
+			fifo_len = priv->outbox_fifo_depth;
+		else
+			fifo_len = 0;
+	} else if (wr_pos > rd_pos) {
+		fifo_len = wr_pos - rd_pos;
+	} else {
+		fifo_len = priv->outbox_fifo_depth - rd_pos + wr_pos;
+	}
+
+	return fifo_len;
+}
+
+static irqreturn_t sprd_mbox_outbox_isr(int irq, void *data)
+{
+	struct sprd_mbox_priv *priv = data;
+	struct mbox_chan *chan;
+	u32 fifo_sts, fifo_len, msg[2];
+	int i, id;
+
+	fifo_sts = readl(priv->outbox_base + SPRD_MBOX_FIFO_STS);
+
+	fifo_len = sprd_mbox_get_fifo_len(priv, fifo_sts);
+	if (!fifo_len) {
+		dev_warn_ratelimited(priv->dev, "spurious outbox interrupt\n");
+		return IRQ_NONE;
+	}
+
+	for (i = 0; i < fifo_len; i++) {
+		msg[0] = readl(priv->outbox_base + SPRD_MBOX_MSG_LOW);
+		msg[1] = readl(priv->outbox_base + SPRD_MBOX_MSG_HIGH);
+		id = readl(priv->outbox_base + SPRD_MBOX_ID);
+
+		chan = &priv->chan[id];
+		mbox_chan_received_data(chan, (void *)msg);
+
+		/* Trigger to update outbox FIFO pointer */
+		writel(0x1, priv->outbox_base + SPRD_MBOX_TRIGGER);
+	}
+
+	/* Clear irq status after reading all message. */
+	writel(SPRD_MBOX_IRQ_CLR, priv->outbox_base + SPRD_MBOX_IRQ_STS);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t sprd_mbox_inbox_isr(int irq, void *data)
+{
+	struct sprd_mbox_priv *priv = data;
+	struct mbox_chan *chan;
+	u32 fifo_sts, send_sts, id;
+
+	fifo_sts = readl(priv->inbox_base + SPRD_MBOX_FIFO_STS);
+
+	/* Get the inbox data delivery status */
+	send_sts = (fifo_sts & SPRD_INBOX_FIFO_DELIVER_MASK) >>
+		SPRD_INBOX_FIFO_DELIVER_SHIFT;
+	if (!send_sts) {
+		dev_warn_ratelimited(priv->dev, "spurious inbox interrupt\n");
+		return IRQ_NONE;
+	}
+
+	while (send_sts) {
+		id = __ffs(send_sts);
+		send_sts &= (send_sts - 1);
+
+		chan = &priv->chan[id];
+		mbox_chan_txdone(chan, 0);
+	}
+
+	/* Clear FIFO delivery and overflow status */
+	writel(fifo_sts &
+	       (SPRD_INBOX_FIFO_DELIVER_MASK | SPRD_INBOX_FIFO_OVERLOW_MASK),
+	       priv->inbox_base + SPRD_MBOX_FIFO_RST);
+
+	/* Clear irq status */
+	writel(SPRD_MBOX_IRQ_CLR, priv->inbox_base + SPRD_MBOX_IRQ_STS);
+
+	return IRQ_HANDLED;
+}
+
+static int sprd_mbox_send_data(struct mbox_chan *chan, void *msg)
+{
+	struct sprd_mbox_priv *priv = to_sprd_mbox_priv(chan->mbox);
+	unsigned long id = (unsigned long)chan->con_priv;
+	u32 *data = msg, busy;
+
+	/*
+	 * Check if current channel is busy or not, and we can not send data
+	 * if current channel is busy.
+	 */
+	busy = readl(priv->inbox_base + SPRD_MBOX_FIFO_STS) &
+		SPRD_INBOX_FIFO_BUSY_MASK;
+	if (busy & BIT(id)) {
+		dev_err(priv->dev, "Channel %ld is busy\n", id);
+		return -EBUSY;
+	}
+
+	/* Write data into inbox FIFO, and only support 8 bytes every time */
+	writel(data[0], priv->inbox_base + SPRD_MBOX_MSG_LOW);
+	writel(data[1], priv->inbox_base + SPRD_MBOX_MSG_HIGH);
+
+	/* Set target core id */
+	writel(id, priv->inbox_base + SPRD_MBOX_ID);
+
+	/* Trigger remote request */
+	writel(0x1, priv->inbox_base + SPRD_MBOX_TRIGGER);
+
+	return 0;
+}
+
+static int sprd_mbox_startup(struct mbox_chan *chan)
+{
+	struct sprd_mbox_priv *priv = to_sprd_mbox_priv(chan->mbox);
+	u32 val;
+
+	/* Select outbox FIFO mode and reset the outbox FIFO status */
+	writel(0x0, priv->outbox_base + SPRD_MBOX_FIFO_RST);
+
+	/* Enable inbox FIFO overflow and delivery interrupt */
+	val = readl(priv->inbox_base + SPRD_MBOX_IRQ_MSK);
+	val &= ~(SPRD_INBOX_FIFO_OVERFLOW_IRQ | SPRD_INBOX_FIFO_DELIVER_IRQ);
+	writel(val, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
+
+	/* Enable outbox FIFO not empty interrupt */
+	val = readl(priv->outbox_base + SPRD_MBOX_IRQ_MSK);
+	val &= ~SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ;
+	writel(val, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
+
+	return 0;
+}
+
+static void sprd_mbox_shutdown(struct mbox_chan *chan)
+{
+	struct sprd_mbox_priv *priv = to_sprd_mbox_priv(chan->mbox);
+
+	/* Disable inbox & outbox interrupt */
+	writel(SPRD_INBOX_FIFO_IRQ_MASK, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
+	writel(SPRD_OUTBOX_FIFO_IRQ_MASK, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
+}
+
+static const struct mbox_chan_ops sprd_mbox_ops = {
+	.send_data    = sprd_mbox_send_data,
+	.startup      = sprd_mbox_startup,
+	.shutdown     = sprd_mbox_shutdown,
+};
+
+static void sprd_mbox_disable(void *data)
+{
+	struct sprd_mbox_priv *priv = data;
+
+	clk_disable_unprepare(priv->clk);
+}
+
+static int sprd_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sprd_mbox_priv *priv;
+	int ret, inbox_irq, outbox_irq;
+	unsigned long id;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
+	/*
+	 * The Spreadtrum mailbox uses an inbox to send messages to the target
+	 * core, and uses an outbox to receive messages from other cores.
+	 *
+	 * Thus the mailbox controller supplies 2 different register addresses
+	 * and IRQ numbers for inbox and outbox.
+	 */
+	priv->inbox_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->inbox_base))
+		return PTR_ERR(priv->inbox_base);
+
+	priv->outbox_base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(priv->outbox_base))
+		return PTR_ERR(priv->outbox_base);
+
+	priv->clk = devm_clk_get(dev, "enable");
+	if (IS_ERR(priv->clk)) {
+		dev_err(dev, "failed to get mailbox clock\n");
+		return PTR_ERR(priv->clk);
+	}
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, sprd_mbox_disable, priv);
+	if (ret) {
+		dev_err(dev, "failed to add mailbox disable action\n");
+		return ret;
+	}
+
+	inbox_irq = platform_get_irq(pdev, 0);
+	if (inbox_irq < 0)
+		return inbox_irq;
+
+	ret = devm_request_irq(dev, inbox_irq, sprd_mbox_inbox_isr,
+			       IRQF_NO_SUSPEND, dev_name(dev), priv);
+	if (ret) {
+		dev_err(dev, "failed to request inbox IRQ: %d\n", ret);
+		return ret;
+	}
+
+	outbox_irq = platform_get_irq(pdev, 1);
+	if (outbox_irq < 0)
+		return outbox_irq;
+
+	ret = devm_request_irq(dev, outbox_irq, sprd_mbox_outbox_isr,
+			       IRQF_NO_SUSPEND, dev_name(dev), priv);
+	if (ret) {
+		dev_err(dev, "failed to request outbox IRQ: %d\n", ret);
+		return ret;
+	}
+
+	/* Get the default outbox FIFO depth */
+	priv->outbox_fifo_depth =
+		readl(priv->outbox_base + SPRD_MBOX_FIFO_DEPTH) + 1;
+	priv->mbox.dev = dev;
+	priv->mbox.chans = &priv->chan[0];
+	priv->mbox.num_chans = SPRD_MBOX_CHAN_MAX;
+	priv->mbox.ops = &sprd_mbox_ops;
+	priv->mbox.txdone_irq = true;
+
+	for (id = 0; id < SPRD_MBOX_CHAN_MAX; id++)
+		priv->chan[id].con_priv = (void *)id;
+
+	ret = devm_mbox_controller_register(dev, &priv->mbox);
+	if (ret) {
+		dev_err(dev, "failed to register mailbox: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id sprd_mbox_of_match[] = {
+	{ .compatible = "sprd,sc9860-mailbox", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sprd_mbox_of_match);
+
+static struct platform_driver sprd_mbox_driver = {
+	.driver = {
+		.name = "sprd-mailbox",
+		.of_match_table = sprd_mbox_of_match,
+	},
+	.probe	= sprd_mbox_probe,
+};
+module_platform_driver(sprd_mbox_driver);
+
+MODULE_AUTHOR("Baolin Wang <baolin.wang@unisoc.com>");
+MODULE_DESCRIPTION("Spreadtrum mailbox driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

