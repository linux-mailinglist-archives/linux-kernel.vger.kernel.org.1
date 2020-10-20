Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEF9287C41
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgJHTPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:15:18 -0400
Received: from foss.arm.com ([217.140.110.172]:45368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgJHTPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:15:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95FFB1063;
        Thu,  8 Oct 2020 12:15:06 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0F6FD3F70D;
        Thu,  8 Oct 2020 12:15:04 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 4/4] mailbox: arm_mhu: Add ARM MHU doorbell driver
Date:   Thu,  8 Oct 2020 20:14:52 +0100
Message-Id: <20201008191452.38672-5-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008191452.38672-1-sudeep.holla@arm.com>
References: <20201008191452.38672-1-sudeep.holla@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MHU drives the signal using a 32-bit register, with all 32 bits
logically ORed together. The MHU provides a set of registers to enable
software to set, clear, and check the status of each of the bits of this
register independently. The use of 32 bits for each interrupt line
enables software to provide more information about the source of the
interrupt. For example, each bit of the register can be associated with
a type of event that can contribute to raising the interrupt.

This patch adds a separate the MHU controller driver for doorbel mode
of operation using the extended DT binding to add support the same.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/Makefile     |   2 +-
 drivers/mailbox/arm_mhu_db.c | 354 +++++++++++++++++++++++++++++++++++
 2 files changed, 355 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mailbox/arm_mhu_db.c

diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 60d224b723a1..2e06e02b2e03 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_MAILBOX)		+= mailbox.o
 
 obj-$(CONFIG_MAILBOX_TEST)	+= mailbox-test.o
 
-obj-$(CONFIG_ARM_MHU)	+= arm_mhu.o
+obj-$(CONFIG_ARM_MHU)	+= arm_mhu.o arm_mhu_db.o
 
 obj-$(CONFIG_IMX_MBOX)	+= imx-mailbox.o
 
diff --git a/drivers/mailbox/arm_mhu_db.c b/drivers/mailbox/arm_mhu_db.c
new file mode 100644
index 000000000000..275efe4cca0c
--- /dev/null
+++ b/drivers/mailbox/arm_mhu_db.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2013-2015 Fujitsu Semiconductor Ltd.
+ * Copyright (C) 2015 Linaro Ltd.
+ * Based on ARM MHU driver by Jassi Brar <jaswinder.singh@linaro.org>
+ * Copyright (C) 2020 ARM Ltd.
+ */
+
+#include <linux/amba/bus.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#define INTR_STAT_OFS	0x0
+#define INTR_SET_OFS	0x8
+#define INTR_CLR_OFS	0x10
+
+#define MHU_LP_OFFSET	0x0
+#define MHU_HP_OFFSET	0x20
+#define MHU_SEC_OFFSET	0x200
+#define TX_REG_OFFSET	0x100
+
+#define MHU_CHANS	3	/* Secure, Non-Secure High and Low Priority */
+#define MHU_CHAN_MAX	20	/* Max channels to save on unused RAM */
+#define MHU_NUM_DOORBELLS	32
+
+struct mhu_db_link {
+	unsigned int irq;
+	void __iomem *tx_reg;
+	void __iomem *rx_reg;
+};
+
+struct arm_mhu {
+	void __iomem *base;
+	struct mhu_db_link mlink[MHU_CHANS];
+	struct mbox_controller mbox;
+	struct device *dev;
+};
+
+/**
+ * ARM MHU Mailbox allocated channel information
+ *
+ * @mhu: Pointer to parent mailbox device
+ * @pchan: Physical channel within which this doorbell resides in
+ * @doorbell: doorbell number pertaining to this channel
+ */
+struct mhu_db_channel {
+	struct arm_mhu *mhu;
+	unsigned int pchan;
+	unsigned int doorbell;
+};
+
+static inline struct mbox_chan *
+mhu_db_mbox_to_channel(struct mbox_controller *mbox, unsigned int pchan,
+		       unsigned int doorbell)
+{
+	int i;
+	struct mhu_db_channel *chan_info;
+
+	for (i = 0; i < mbox->num_chans; i++) {
+		chan_info = mbox->chans[i].con_priv;
+		if (chan_info && chan_info->pchan == pchan &&
+		    chan_info->doorbell == doorbell)
+			return &mbox->chans[i];
+	}
+
+	return NULL;
+}
+
+static void mhu_db_mbox_clear_irq(struct mbox_chan *chan)
+{
+	struct mhu_db_channel *chan_info = chan->con_priv;
+	void __iomem *base = chan_info->mhu->mlink[chan_info->pchan].rx_reg;
+
+	writel_relaxed(BIT(chan_info->doorbell), base + INTR_CLR_OFS);
+}
+
+static unsigned int mhu_db_mbox_irq_to_pchan_num(struct arm_mhu *mhu, int irq)
+{
+	unsigned int pchan;
+
+	for (pchan = 0; pchan < MHU_CHANS; pchan++)
+		if (mhu->mlink[pchan].irq == irq)
+			break;
+	return pchan;
+}
+
+static struct mbox_chan *
+mhu_db_mbox_irq_to_channel(struct arm_mhu *mhu, unsigned int pchan)
+{
+	unsigned long bits;
+	unsigned int doorbell;
+	struct mbox_chan *chan = NULL;
+	struct mbox_controller *mbox = &mhu->mbox;
+	void __iomem *base = mhu->mlink[pchan].rx_reg;
+
+	bits = readl_relaxed(base + INTR_STAT_OFS);
+	if (!bits)
+		/* No IRQs fired in specified physical channel */
+		return NULL;
+
+	/* An IRQ has fired, find the associated channel */
+	for (doorbell = 0; bits; doorbell++) {
+		if (!test_and_clear_bit(doorbell, &bits))
+			continue;
+
+		chan = mhu_db_mbox_to_channel(mbox, pchan, doorbell);
+		if (chan)
+			break;
+		dev_err(mbox->dev,
+			"Channel not registered: pchan: %d doorbell: %d\n",
+			pchan, doorbell);
+	}
+
+	return chan;
+}
+
+static irqreturn_t mhu_db_mbox_rx_handler(int irq, void *data)
+{
+	struct mbox_chan *chan;
+	struct arm_mhu *mhu = data;
+	unsigned int pchan = mhu_db_mbox_irq_to_pchan_num(mhu, irq);
+
+	while (NULL != (chan = mhu_db_mbox_irq_to_channel(mhu, pchan))) {
+		mbox_chan_received_data(chan, NULL);
+		mhu_db_mbox_clear_irq(chan);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static bool mhu_db_last_tx_done(struct mbox_chan *chan)
+{
+	struct mhu_db_channel *chan_info = chan->con_priv;
+	void __iomem *base = chan_info->mhu->mlink[chan_info->pchan].tx_reg;
+
+	if (readl_relaxed(base + INTR_STAT_OFS) & BIT(chan_info->doorbell))
+		return false;
+
+	return true;
+}
+
+static int mhu_db_send_data(struct mbox_chan *chan, void *data)
+{
+	struct mhu_db_channel *chan_info = chan->con_priv;
+	void __iomem *base = chan_info->mhu->mlink[chan_info->pchan].tx_reg;
+
+	/* Send event to co-processor */
+	writel_relaxed(BIT(chan_info->doorbell), base + INTR_SET_OFS);
+
+	return 0;
+}
+
+static int mhu_db_startup(struct mbox_chan *chan)
+{
+	mhu_db_mbox_clear_irq(chan);
+	return 0;
+}
+
+static void mhu_db_shutdown(struct mbox_chan *chan)
+{
+	struct mhu_db_channel *chan_info = chan->con_priv;
+	struct mbox_controller *mbox = &chan_info->mhu->mbox;
+	int i;
+
+	for (i = 0; i < mbox->num_chans; i++)
+		if (chan == &mbox->chans[i])
+			break;
+
+	if (mbox->num_chans == i) {
+		dev_warn(mbox->dev, "Request to free non-existent channel\n");
+		return;
+	}
+
+	/* Reset channel */
+	mhu_db_mbox_clear_irq(chan);
+	kfree(chan->con_priv);
+	chan->con_priv = NULL;
+}
+
+static struct mbox_chan *mhu_db_mbox_xlate(struct mbox_controller *mbox,
+					   const struct of_phandle_args *spec)
+{
+	struct arm_mhu *mhu = dev_get_drvdata(mbox->dev);
+	struct mhu_db_channel *chan_info;
+	struct mbox_chan *chan;
+	unsigned int pchan = spec->args[0];
+	unsigned int doorbell = spec->args[1];
+	int i;
+
+	/* Bounds checking */
+	if (pchan >= MHU_CHANS || doorbell >= MHU_NUM_DOORBELLS) {
+		dev_err(mbox->dev,
+			"Invalid channel requested pchan: %d doorbell: %d\n",
+			pchan, doorbell);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* Is requested channel free? */
+	chan = mhu_db_mbox_to_channel(mbox, pchan, doorbell);
+	if (chan) {
+		dev_err(mbox->dev, "Channel in use: pchan: %d doorbell: %d\n",
+			pchan, doorbell);
+		return ERR_PTR(-EBUSY);
+	}
+
+	/* Find the first free slot */
+	for (i = 0; i < mbox->num_chans; i++)
+		if (!mbox->chans[i].con_priv)
+			break;
+
+	if (mbox->num_chans == i) {
+		dev_err(mbox->dev, "No free channels left\n");
+		return ERR_PTR(-EBUSY);
+	}
+
+	chan = &mbox->chans[i];
+
+	chan_info = devm_kzalloc(mbox->dev, sizeof(*chan_info), GFP_KERNEL);
+	if (!chan_info)
+		return ERR_PTR(-ENOMEM);
+
+	chan_info->mhu = mhu;
+	chan_info->pchan = pchan;
+	chan_info->doorbell = doorbell;
+
+	chan->con_priv = chan_info;
+
+	dev_dbg(mbox->dev, "mbox: created channel phys: %d doorbell: %d\n",
+		pchan, doorbell);
+
+	return chan;
+}
+
+static const struct mbox_chan_ops mhu_db_ops = {
+	.send_data = mhu_db_send_data,
+	.startup = mhu_db_startup,
+	.shutdown = mhu_db_shutdown,
+	.last_tx_done = mhu_db_last_tx_done,
+};
+
+static int mhu_db_probe(struct amba_device *adev, const struct amba_id *id)
+{
+	u32 cell_count;
+	int i, err, max_chans;
+	struct arm_mhu *mhu;
+	struct mbox_chan *chans;
+	struct device *dev = &adev->dev;
+	struct device_node *np = dev->of_node;
+	int mhu_reg[MHU_CHANS] = {
+		MHU_LP_OFFSET, MHU_HP_OFFSET, MHU_SEC_OFFSET,
+	};
+
+	if (!of_device_is_compatible(np, "arm,mhu-doorbell"))
+		return -ENODEV;
+
+	err = of_property_read_u32(np, "#mbox-cells", &cell_count);
+	if (err) {
+		dev_err(dev, "failed to read #mbox-cells in '%pOF'\n", np);
+		return err;
+	}
+
+	if (cell_count == 2) {
+		max_chans = MHU_CHAN_MAX;
+	} else {
+		dev_err(dev, "incorrect value of #mbox-cells in '%pOF'\n", np);
+		return -EINVAL;
+	}
+
+	mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
+	if (!mhu)
+		return -ENOMEM;
+
+	mhu->base = devm_ioremap_resource(dev, &adev->res);
+	if (IS_ERR(mhu->base)) {
+		dev_err(dev, "ioremap failed\n");
+		return PTR_ERR(mhu->base);
+	}
+
+	chans = devm_kcalloc(dev, max_chans, sizeof(*chans), GFP_KERNEL);
+	if (!chans)
+		return -ENOMEM;
+
+	mhu->dev = dev;
+	mhu->mbox.dev = dev;
+	mhu->mbox.chans = chans;
+	mhu->mbox.num_chans = max_chans;
+	mhu->mbox.txdone_irq = false;
+	mhu->mbox.txdone_poll = true;
+	mhu->mbox.txpoll_period = 1;
+
+	mhu->mbox.of_xlate = mhu_db_mbox_xlate;
+	amba_set_drvdata(adev, mhu);
+
+	mhu->mbox.ops = &mhu_db_ops;
+
+	err = devm_mbox_controller_register(dev, &mhu->mbox);
+	if (err) {
+		dev_err(dev, "Failed to register mailboxes %d\n", err);
+		return err;
+	}
+
+	for (i = 0; i < MHU_CHANS; i++) {
+		int irq = mhu->mlink[i].irq = adev->irq[i];
+
+		if (irq <= 0) {
+			dev_dbg(dev, "No IRQ found for Channel %d\n", i);
+			continue;
+		}
+
+		mhu->mlink[i].rx_reg = mhu->base + mhu_reg[i];
+		mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + TX_REG_OFFSET;
+
+		err = devm_request_threaded_irq(dev, irq, NULL,
+						mhu_db_mbox_rx_handler,
+						IRQF_ONESHOT, "mhu_db_link", mhu);
+		if (err) {
+			dev_err(dev, "Can't claim IRQ %d\n", irq);
+			mbox_controller_unregister(&mhu->mbox);
+			return err;
+		}
+	}
+
+	dev_info(dev, "ARM MHU Doorbell mailbox registered\n");
+	return 0;
+}
+
+static struct amba_id mhu_ids[] = {
+	{
+		.id	= 0x1bb098,
+		.mask	= 0xffffff,
+	},
+	{ 0, 0 },
+};
+MODULE_DEVICE_TABLE(amba, mhu_ids);
+
+static struct amba_driver arm_mhu_db_driver = {
+	.drv = {
+		.name	= "mhu-doorbell",
+	},
+	.id_table	= mhu_ids,
+	.probe		= mhu_db_probe,
+};
+module_amba_driver(arm_mhu_db_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ARM MHU Doorbell Driver");
+MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
-- 
2.17.1

