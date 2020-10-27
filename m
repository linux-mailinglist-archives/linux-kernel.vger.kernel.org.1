Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6314B29AB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1744894AbgJ0Lxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:53:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35935 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S367978AbgJ0Lxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:53:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id w65so780658pfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 04:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Df+q7ND3WoZWrz+YafLZQn/LvstRAbOYbHA79oujU04=;
        b=RwqKxJeTQMcGaokdjpILwcY/VKjJMWBm1HiLLCeJ21B2QfCT36dJft4+kiJ/3R2nJu
         iNkV67RFRgrhNPj0I3ZUo5lH3nyjVNXjjHy+KOlc5kkxWkvO3l2YmwU5CCn1u2NvAqDE
         kM8zePU8FrRbbjz31hgfI94EeCSc1YTEA7p12AeAdZczDxhEM7TfB6ZRXQQ+TQzQ6D9L
         B6O/TMEeYQAx1QZfROq/4pdmcoRS6nJwIaUC3YAcXgsspwIDENScMjX2U7rjRs8466Y9
         ovSTiGNRwKv3HDCZyMrpv5CSNfFN3Ma4TzeClUJEb17tji/BUZd7JF5tXR2omSq/I/Ft
         A9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Df+q7ND3WoZWrz+YafLZQn/LvstRAbOYbHA79oujU04=;
        b=mUJGJVjtVI5tNLLBfTGP5Nj4ayrxK0Enzn4o4UsroRk6UNDUX7xA+225qTWJh9oJDf
         Aqmakfq6imV0O9pena29ySmcRgYkP9ZL4NQ1rw50IMtMFMEIa6sKYwj1Be3BpYfTbqNn
         9EcWXeU+ZFx5+N9VKkbbUCkFPsuRxIWPHvfrvp9MXZmDLOSe1NAbZBqEiCAr2fRF+Quq
         48LmHXaBWK6gEDxSw6PJViQPT6emyE/LeBnt9pZEQxP/LitnaAk3+PPM9R4WIEqCmWdN
         Gb4kfLVWaSXtMo96flE3FMk6xCY1AIiHu8C0xY9B/UReTTjQOD4aODMOUdWz2lLxIeXk
         G0OA==
X-Gm-Message-State: AOAM533wEo/Yjpff6rcHYqTekP094ymUgdSTR+CpcDu1ismHE46ZVlSs
        RmNBqpdROiAyqodvl80g86e39A==
X-Google-Smtp-Source: ABdhPJzU3rMmUtDPRac7ApJktQyWyw3JjRTs5/x9DgcoD5qfX87c+WiNiS4MyMS8rZIJBfXNAd+aHg==
X-Received: by 2002:a62:7a09:0:b029:163:a7bd:e8da with SMTP id v9-20020a627a090000b0290163a7bde8damr2124436pfc.51.1603799626110;
        Tue, 27 Oct 2020 04:53:46 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id b16sm2091405pfp.195.2020.10.27.04.53.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 04:53:45 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Tushar Khandelwal <Tushar.Khandelwal@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, Sudeep.Holla@arm.com,
        robh+dt@kernel.org, morten_bp@live.dk,
        linux-arm-kernel@lists.infradead.org,
        Tushar Khandelwal <tushar.khandelwal@arm.com>,
        Usama Arif <usama.arif@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: arm_mhuv2: Add driver
Date:   Tue, 27 Oct 2020 17:23:37 +0530
Message-Id: <eab9d7165fe30a74afc62d5b540b2dc3258196a4.1603799360.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds driver for the ARM MHUv2 (Message Handling Unit) mailbox
controller.

This is based on the accepted DT bindings of the controller and supports
combination of all transport protocols, i.e. single-word, multi-word and
doorbell.

Transmitting and receiving data through the mailbox framework in
multi-word mode is done through struct arm_mhuv2_mbox_msg. Rest of the
implementation details can be seen in the bindings document or in the
driver itself.

Based on the initial work done by Morten Borup Petersen from ARM.

Co-developed-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
Signed-off-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
Tested-by: Usama Arif <usama.arif@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Bindings are already reviewed by Rob and are present here:

http://lore.kernel.org/lkml/61ca14fc441f92c1e7994e5bebae5c49811a3050.1602563406.git.viresh.kumar@linaro.org

 MAINTAINERS                               |    9 +
 drivers/mailbox/Kconfig                   |    7 +
 drivers/mailbox/Makefile                  |    2 +
 drivers/mailbox/arm_mhuv2.c               | 1268 +++++++++++++++++++++
 include/linux/mailbox/arm_mhuv2_message.h |   20 +
 5 files changed, 1306 insertions(+)
 create mode 100644 drivers/mailbox/arm_mhuv2.c
 create mode 100644 include/linux/mailbox/arm_mhuv2_message.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b75f29..87f5ba48417e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10450,6 +10450,15 @@ F:	drivers/mailbox/
 F:	include/linux/mailbox_client.h
 F:	include/linux/mailbox_controller.h
 
+MAILBOX ARM MHUv2
+M:	Viresh Kumar <viresh.kumar@linaro.org>
+M:	Tushar Khandelwal <Tushar.Khandelwal@arm.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/mailbox/arm_mhuv2.c
+F:	include/linux/mailbox/arm_mhuv2_message.h
+F:	Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
+
 MAN-PAGES: MANUAL PAGES FOR LINUX -- Sections 2, 3, 4, 5, and 7
 M:	Michael Kerrisk <mtk.manpages@gmail.com>
 L:	linux-man@vger.kernel.org
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 05b1009e2820..3c0ea96a0a8b 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -16,6 +16,13 @@ config ARM_MHU
 	  The controller has 3 mailbox channels, the last of which can be
 	  used in Secure mode only.
 
+config ARM_MHU_V2
+	tristate "ARM MHUv2 Mailbox"
+	depends on ARM_AMBA
+	help
+	  Say Y here if you want to build the ARM MHUv2 controller driver,
+	  which provides unidirectional mailboxes between processing elements.
+
 config IMX_MBOX
 	tristate "i.MX Mailbox"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 2e06e02b2e03..7194fa92c787 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -7,6 +7,8 @@ obj-$(CONFIG_MAILBOX_TEST)	+= mailbox-test.o
 
 obj-$(CONFIG_ARM_MHU)	+= arm_mhu.o arm_mhu_db.o
 
+obj-$(CONFIG_ARM_MHU_V2)	+= arm_mhuv2.o
+
 obj-$(CONFIG_IMX_MBOX)	+= imx-mailbox.o
 
 obj-$(CONFIG_ARMADA_37XX_RWTM_MBOX)	+= armada-37xx-rwtm-mailbox.o
diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
new file mode 100644
index 000000000000..1611bdb87922
--- /dev/null
+++ b/drivers/mailbox/arm_mhuv2.c
@@ -0,0 +1,1268 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM Message Handling Unit Version 2 (MHUv2) driver.
+ *
+ * Copyright (C) 2020 ARM Ltd.
+ * Copyright (C) 2020 Linaro Ltd.
+ *
+ * An MHUv2 mailbox controller can provide up to 124 channel windows (each 32
+ * bit long) and the driver allows any combination of the three transport
+ * protocol modes: single-word, multi-word and doorbell, to be used on those
+ * channel windows.
+ *
+ * The transport protocols should be specified in the device tree entry for the
+ * device. The transport protocols determine how the underlying hardware
+ * resources of the device are utilized when transmitting data. Refer to the
+ * device tree bindings of the ARM MHUv2 controller for more details.
+ *
+ * The number of registered mailbox channels is dependent on both the underlying
+ * hardware - mainly the number of channel windows implemented by the platform,
+ * as well as the selected transport protocols.
+ *
+ * The MHUv2 controller can work both as a sender and receiver, but the driver
+ * and the DT bindings support unidirectional transfers for better allocation of
+ * the channels. That is, this driver will be probed for two separate devices
+ * for each mailbox controller, a sender device and a receiver device.
+ */
+
+#include <linux/amba/bus.h>
+#include <linux/interrupt.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox/arm_mhuv2_message.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/spinlock.h>
+
+/* ====== MHUv2 Registers ====== */
+
+/* Maximum number of channel windows */
+#define MHUV2_CH_WN_MAX			124
+/* Number of combined interrupt status registers */
+#define MHUV2_CMB_INT_ST_REG_CNT	4
+#define MHUV2_STAT_BYTES		(sizeof(u32))
+#define MHUV2_STAT_BITS			(MHUV2_STAT_BYTES * __CHAR_BIT__)
+
+#define LSB_MASK(n)			((1 << (n * __CHAR_BIT__)) - 1)
+#define MHUV2_PROTOCOL_PROP		"arm,mhuv2-protocols"
+
+/* Register Message Handling Unit Configuration fields */
+struct MHU_CFG_t {
+	u32 NUM_CH : 7;
+	u32 PAD : 25;
+} __packed;
+
+/* register Interrupt Status fields */
+struct INT_ST_t {
+	u32 NR2R : 1;
+	u32 R2NR : 1;
+	u32 PAD : 30;
+} __packed;
+
+/* Register Interrupt Clear fields */
+struct INT_CLR_t {
+	u32 NR2R : 1;
+	u32 R2NR : 1;
+	u32 PAD : 30;
+} __packed;
+
+/* Register Interrupt Enable fields */
+struct INT_EN_t {
+	u32 R2NR : 1;
+	u32 NR2R : 1;
+	u32 CHCOMB : 1;
+	u32 PAD : 29;
+} __packed;
+
+/* Register Implementer Identification fields */
+struct IIDR_t {
+	u32 IMPLEMENTER : 12;
+	u32 REVISION : 4;
+	u32 VARIANT : 4;
+	u32 PRODUCT_ID : 12;
+} __packed;
+
+/* Register Architecture Identification Register fields */
+struct AIDR_t {
+	u32 ARCH_MINOR_REV : 4;
+	u32 ARCH_MAJOR_REV : 4;
+	u32 PAD : 24;
+} __packed;
+
+/* Sender Channel Window fields */
+struct mhu2_send_ch_wn_reg {
+	u32 STAT;
+	u8 PAD1[0x0C - 0x04];
+	u32 STAT_SET;
+	u32 INT_ST;
+	u32 INT_CLR;
+	u32 INT_EN;
+	u8 PAD2[0x20 - 0x1C];
+} __packed;
+
+/* Sender frame register fields */
+struct mhu2_send_frame_reg {
+	struct mhu2_send_ch_wn_reg ch_wn[MHUV2_CH_WN_MAX];
+	struct MHU_CFG_t MHU_CFG;
+	u32 RESP_CFG;
+	u32 ACCESS_REQUEST;
+	u32 ACCESS_READY;
+	struct INT_ST_t INT_ST;
+	struct INT_CLR_t INT_CLR;
+	struct INT_EN_t INT_EN;
+	u32 RESERVED0;
+	u32 CHCOMB_INT_ST[MHUV2_CMB_INT_ST_REG_CNT];
+	u8 PAD[0xFC8 - 0xFB0];
+	struct IIDR_t IIDR;
+	struct AIDR_t AIDR;
+} __packed;
+
+/* Receiver Channel Window fields */
+struct mhu2_recv_ch_wn_reg {
+	u32 STAT;
+	u32 STAT_MASKED;
+	u32 STAT_CLEAR;
+	u8 RESERVED0[0x10 - 0x0C];
+	u32 MASK;
+	u32 MASK_SET;
+	u32 MASK_CLEAR;
+	u8 PAD[0x20 - 0x1C];
+} __packed;
+
+/* Receiver frame register fields */
+struct mhu2_recv_frame_reg {
+	struct mhu2_recv_ch_wn_reg ch_wn[MHUV2_CH_WN_MAX];
+	struct MHU_CFG_t MHU_CFG;
+	u8 RESERVED0[0xF90 - 0xF84];
+	struct INT_ST_t INT_ST;
+	struct INT_CLR_t INT_CLR;
+	struct INT_EN_t INT_EN;
+	u32 PAD;
+	u32 CHCOMB_INT_ST[MHUV2_CMB_INT_ST_REG_CNT];
+	u8 RESERVED2[0xFC8 - 0xFB0];
+	struct IIDR_t IIDR;
+	struct AIDR_t AIDR;
+} __packed;
+
+
+/* ====== MHUv2 data structures ====== */
+
+enum mhuv2_transport_protocol {
+	DOORBELL = 0,
+	SINGLE_WORD = 1,
+	MULTI_WORD = 2
+};
+
+enum mhuv2_frame {
+	RECEIVER_FRAME,
+	SENDER_FRAME
+};
+
+/**
+ * struct mhuv2 - MHUv2 mailbox controller data
+ *
+ * @mbox:	Mailbox controller belonging to the MHU frame.
+ * @send/recv:	Base address of the register mapping region.
+ * @frame:	Frame type: RECEIVER_FRAME or SENDER_FRAME.
+ * @irq:	Interrupt.
+ * @windows:	Channel windows implemented by the platform.
+ * @minor:	Minor version of the controller.
+ * @length:	Length of the protocols array in bytes.
+ * @protocols:	Raw protocol information, derived from device tree.
+ * @doorbell_pending_lock: spinlock required for correct operation of Tx
+ *		interrupt for doorbells.
+ */
+struct mhuv2 {
+	struct mbox_controller mbox;
+	union {
+		struct mhu2_send_frame_reg __iomem *send;
+		struct mhu2_recv_frame_reg __iomem *recv;
+	};
+	enum mhuv2_frame frame;
+	unsigned int irq;
+	unsigned int windows;
+	unsigned int minor;
+	unsigned int length;
+	u32 *protocols;
+
+	spinlock_t doorbell_pending_lock;
+};
+
+#define mhu_from_mbox(_mbox) container_of(_mbox, struct mhuv2, mbox)
+
+/**
+ * struct mhuv2_protocol_ops - MHUv2 operations
+ *
+ * Each transport protocol must provide an implementation of the operations
+ * provided here.
+ *
+ * @rx_startup: Startup callback for receiver.
+ * @rx_shutdown: Shutdown callback for receiver.
+ * @read_data: Reads and clears newly available data.
+ * @tx_startup: Startup callback for receiver.
+ * @tx_shutdown: Shutdown callback for receiver.
+ * @last_tx_done: Report back if the last tx is completed or not.
+ * @send_data: Send data to the receiver.
+ */
+struct mhuv2_protocol_ops {
+	int (*rx_startup)(struct mhuv2 *mhu, struct mbox_chan *chan);
+	void (*rx_shutdown)(struct mhuv2 *mhu, struct mbox_chan *chan);
+	void *(*read_data)(struct mhuv2 *mhu, struct mbox_chan *chan);
+
+	void (*tx_startup)(struct mhuv2 *mhu, struct mbox_chan *chan);
+	void (*tx_shutdown)(struct mhuv2 *mhu, struct mbox_chan *chan);
+	int (*last_tx_done)(struct mhuv2 *mhu, struct mbox_chan *chan);
+	int (*send_data)(struct mhuv2 *mhu, struct mbox_chan *chan, void *data);
+};
+
+/*
+ * MHUv2 mailbox channel's private information
+ *
+ * @ops:	protocol specific ops for the channel.
+ * @ch_wn_idx:	Channel window index allocated to the channel.
+ * @windows:	Total number of windows consumed by the channel, only relevant
+ *		in MULTI_WORD protocol.
+ * @doorbell:	Doorbell bit number within the ch_wn_idx window, only relevant
+ *		in DOORBELL protocol.
+ * @pending:	Flag indicating pending doorbell interrupt, only relevant in
+ *		DOORBELL protocol.
+ */
+struct mhuv2_mbox_chan_priv {
+	const struct mhuv2_protocol_ops *ops;
+	u32 ch_wn_idx;
+	union {
+		u32 windows;
+		struct {
+			u32 doorbell;
+			u32 pending;
+		};
+	};
+};
+
+/* Macro for reading a bitfield within a physically mapped packed struct */
+#define readl_relaxed_bitfield(_regptr, _field)				\
+	({								\
+		u32 _regval;						\
+		_regval = readl_relaxed((_regptr));			\
+		(*(typeof((_regptr)))(&_regval))._field;		\
+	})
+
+/* Macro for writing a bitfield within a physically mapped packed struct */
+#define writel_relaxed_bitfield(_value, _regptr, _field)		\
+	({								\
+		u32 _regval;						\
+		_regval = readl_relaxed(_regptr);			\
+		(*(typeof(_regptr))(&_regval))._field = _value;		\
+		writel_relaxed(_regval, _regptr);			\
+	})
+
+
+/* =================== Doorbell transport protocol operations =============== */
+
+static int mhuv2_doorbell_rx_startup(struct mhuv2 *mhu, struct mbox_chan *chan)
+{
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+
+	writel_relaxed(BIT(priv->doorbell),
+		       &mhu->recv->ch_wn[priv->ch_wn_idx].MASK_CLEAR);
+	return 0;
+}
+
+static void mhuv2_doorbell_rx_shutdown(struct mhuv2 *mhu,
+				       struct mbox_chan *chan)
+{
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+
+	writel_relaxed(BIT(priv->doorbell),
+		       &mhu->recv->ch_wn[priv->ch_wn_idx].MASK_SET);
+}
+
+static void *mhuv2_doorbell_read_data(struct mhuv2 *mhu, struct mbox_chan *chan)
+{
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+
+	writel_relaxed(BIT(priv->doorbell),
+		       &mhu->recv->ch_wn[priv->ch_wn_idx].STAT_CLEAR);
+	return NULL;
+}
+
+static int mhuv2_doorbell_last_tx_done(struct mhuv2 *mhu,
+				       struct mbox_chan *chan)
+{
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+
+	return !(readl_relaxed(&mhu->send->ch_wn[priv->ch_wn_idx].STAT) &
+		 BIT(priv->doorbell));
+}
+
+static int mhuv2_doorbell_send_data(struct mhuv2 *mhu, struct mbox_chan *chan,
+				    void *data)
+{
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mhu->doorbell_pending_lock, flags);
+
+	priv->pending = 1;
+	writel_relaxed(BIT(priv->doorbell),
+		       &mhu->send->ch_wn[priv->ch_wn_idx].STAT_SET);
+
+	spin_unlock_irqrestore(&mhu->doorbell_pending_lock, flags);
+
+	return 0;
+}
+
+static const struct mhuv2_protocol_ops mhuv2_doorbell_ops = {
+	.rx_startup = mhuv2_doorbell_rx_startup,
+	.rx_shutdown = mhuv2_doorbell_rx_shutdown,
+	.read_data = mhuv2_doorbell_read_data,
+	.last_tx_done = mhuv2_doorbell_last_tx_done,
+	.send_data = mhuv2_doorbell_send_data,
+};
+#define IS_PROTOCOL_DOORBELL(_priv) (_priv->ops == &mhuv2_doorbell_ops)
+
+/* ================ Single word transport protocol operations =============== */
+
+static int mhuv2_single_word_rx_startup(struct mhuv2 *mhu,
+					struct mbox_chan *chan)
+{
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+
+	writel_relaxed(0xFFFFFFFF, &mhu->recv->ch_wn[priv->ch_wn_idx].MASK_CLEAR);
+	return 0;
+}
+
+static void mhuv2_single_word_rx_shutdown(struct mhuv2 *mhu,
+					  struct mbox_chan *chan)
+{
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+
+	writel_relaxed(0xFFFFFFFF, &mhu->recv->ch_wn[priv->ch_wn_idx].MASK_SET);
+}
+
+static void *mhuv2_single_word_read_data(struct mhuv2 *mhu,
+					 struct mbox_chan *chan)
+{
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+	u32 *data;
+
+	/* To be freed by the caller */
+	data = kzalloc(MHUV2_STAT_BYTES, GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	*data = readl_relaxed(&mhu->recv->ch_wn[priv->ch_wn_idx].STAT_MASKED);
+	writel_relaxed(0xFFFFFFFF, &mhu->recv->ch_wn[priv->ch_wn_idx].STAT_CLEAR);
+	return data;
+}
+
+static void mhuv2_single_word_tx_startup(struct mhuv2 *mhu,
+					 struct mbox_chan *chan)
+{
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+
+	if (mhu->minor) {
+		writel_relaxed(0x1, &mhu->send->ch_wn[priv->ch_wn_idx].INT_CLR);
+		writel_relaxed(0x1, &mhu->send->ch_wn[priv->ch_wn_idx].INT_EN);
+	}
+}
+
+static void mhuv2_single_word_tx_shutdown(struct mhuv2 *mhu,
+					  struct mbox_chan *chan)
+{
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+
+	if (mhu->minor)
+		writel_relaxed(0x0, &mhu->send->ch_wn[priv->ch_wn_idx].INT_EN);
+}
+
+static int mhuv2_single_word_last_tx_done(struct mhuv2 *mhu,
+					  struct mbox_chan *chan)
+{
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+
+	return !readl_relaxed(&mhu->send->ch_wn[priv->ch_wn_idx].STAT);
+}
+
+static int mhuv2_single_word_send_data(struct mhuv2 *mhu,
+				       struct mbox_chan *chan, void *data)
+{
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+	struct device *dev = mhu->mbox.dev;
+	u32 word = *(u32 *)data;
+
+	if (!word) {
+		dev_err(dev, "Data transmitted in single-word protocol must be non-zero\n");
+		return -EINVAL;
+	}
+
+	writel_relaxed(word, &mhu->send->ch_wn[priv->ch_wn_idx].STAT_SET);
+	return 0;
+}
+
+static const struct mhuv2_protocol_ops mhuv2_single_word_ops = {
+	.rx_startup = mhuv2_single_word_rx_startup,
+	.rx_shutdown = mhuv2_single_word_rx_shutdown,
+	.read_data = mhuv2_single_word_read_data,
+	.tx_startup = mhuv2_single_word_tx_startup,
+	.tx_shutdown = mhuv2_single_word_tx_shutdown,
+	.last_tx_done = mhuv2_single_word_last_tx_done,
+	.send_data = mhuv2_single_word_send_data,
+};
+
+/* ================ Multi word transport protocol operations ================ */
+
+static int mhuv2_multi_word_rx_startup(struct mhuv2 *mhu,
+				       struct mbox_chan *chan)
+{
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+	int i = priv->ch_wn_idx + priv->windows - 1;
+
+	/*
+	 * The multi-word transport protocol mandates that all but the last
+	 * status register must be masked.
+	 */
+	writel_relaxed(0xFFFFFFFF, &mhu->recv->ch_wn[i].MASK_CLEAR);
+	return 0;
+}
+
+static void mhuv2_multi_word_rx_shutdown(struct mhuv2 *mhu,
+					 struct mbox_chan *chan)
+{
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+	int i = priv->ch_wn_idx + priv->windows - 1;
+
+	writel_relaxed(0xFFFFFFFF, &mhu->recv->ch_wn[i].MASK_SET);
+}
+
+static void *mhuv2_multi_word_read_data(struct mhuv2 *mhu, struct mbox_chan *chan)
+{
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+	const int windows = priv->windows;
+	struct arm_mhuv2_mbox_msg *msg;
+	u32 *data;
+	int i, idx;
+
+	msg = kzalloc(sizeof(*msg) + windows * MHUV2_STAT_BYTES, GFP_KERNEL);
+	if (!msg)
+		return ERR_PTR(-ENOMEM);
+
+	data = msg->data = msg + 1;
+	msg->len = windows * MHUV2_STAT_BYTES;
+
+	/*
+	 * Messages are expected in order of most significant word to least
+	 * significant word. Refer mhuv2_multi_word_send_data() for more
+	 * details.
+	 *
+	 * We also need to read the STAT register instead of STAT_MASKED, as we
+	 * masked all but the last window.
+	 *
+	 * Last channel window must be cleared as the final operation. Upon
+	 * clearing the last channel window register, which is unmasked in
+	 * multi-word protocol, the interrupt is de-asserted.
+	 */
+	for (i = 0; i < windows; i++) {
+		idx = priv->ch_wn_idx + i;
+		data[windows - 1 - i] = readl_relaxed(&mhu->recv->ch_wn[idx].STAT);
+		writel_relaxed(0xFFFFFFFF, &mhu->recv->ch_wn[idx].STAT_CLEAR);
+	}
+
+	return 0;
+}
+
+static void mhuv2_multi_word_tx_startup(struct mhuv2 *mhu,
+					struct mbox_chan *chan)
+{
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+	int i = priv->ch_wn_idx + priv->windows - 1;
+
+	/* Enable interrupts only for the last window */
+	if (mhu->minor) {
+		writel_relaxed(0x1, &mhu->send->ch_wn[i].INT_CLR);
+		writel_relaxed(0x1, &mhu->send->ch_wn[i].INT_EN);
+	}
+}
+
+static void mhuv2_multi_word_tx_shutdown(struct mhuv2 *mhu,
+					 struct mbox_chan *chan)
+{
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+	int i = priv->ch_wn_idx + priv->windows - 1;
+
+	if (mhu->minor)
+		writel_relaxed(0x0, &mhu->send->ch_wn[i].INT_EN);
+}
+
+static int mhuv2_multi_word_last_tx_done(struct mhuv2 *mhu,
+					 struct mbox_chan *chan)
+{
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+	int i = priv->ch_wn_idx + priv->windows - 1;
+
+	/* Just checking the last channel window should be enough */
+	return !readl_relaxed(&mhu->send->ch_wn[i].STAT);
+}
+
+/*
+ * Message will be transmitted from most significant to least significant word.
+ * This is to allow for messages shorter than channel windows to still trigger
+ * the receiver interrupt which gets activated when the last STAT register is
+ * written. As an example, a 6-word message is to be written on a 4-channel MHU
+ * connection: Registers marked with '*' are masked, and will not generate an
+ * interrupt on the receiver side once written.
+ *
+ * u32 *data =	[0x00000001], [0x00000002], [0x00000003], [0x00000004],
+ *		[0x00000005], [0x00000006]
+ *
+ * ROUND 1:
+ * STAT reg		To write	Write sequence
+ * [ STAT 3 ]	<-	[0x00000001]	4 <- triggers interrupt on receiver
+ * [ STAT 2 ]	<-	[0x00000002]	3
+ * [ STAT 1 ]	<-	[0x00000003]	2
+ * [ STAT 0 ]	<-	[0x00000004]	1
+ *
+ * data += 4 // Increment data pointer by number of STAT regs
+ *
+ * ROUND 2:
+ * STAT reg		To write	Write sequence
+ * [ STAT 3 ]	<-	[0x00000005]	2 <- triggers interrupt on receiver
+ * [ STAT 2 ]	<-	[0x00000006]	1
+ * [ STAT 1 ]	<-	[0x00000000]
+ * [ STAT 0 ]	<-	[0x00000000]
+ */
+static int mhuv2_multi_word_send_data(struct mhuv2 *mhu, struct mbox_chan *chan,
+				      void *arg)
+{
+	const struct arm_mhuv2_mbox_msg *msg = arg;
+	int bytes_left = msg->len, bytes_to_send, bytes_in_round, i;
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+	int windows = priv->windows;
+	u32 *data = msg->data, word;
+
+	while (bytes_left) {
+		if (!data[0]) {
+			dev_err(mhu->mbox.dev, "Data aligned at first window can't be zero to guarantee interrupt generation at receiver");
+			return -EINVAL;
+		}
+
+		while(!mhuv2_multi_word_last_tx_done(mhu, chan))
+			continue;
+
+		bytes_in_round = min(bytes_left, (int)(windows * MHUV2_STAT_BYTES));
+
+		for (i = windows - 1; i >= 0; i--) {
+			/* Data less than windows can transfer ? */
+			if (unlikely(bytes_in_round <= i * MHUV2_STAT_BYTES))
+				continue;
+
+			word = data[i];
+			bytes_to_send = bytes_in_round & (MHUV2_STAT_BYTES - 1);
+			if (unlikely(bytes_to_send))
+				word &= LSB_MASK(bytes_to_send);
+			else
+				bytes_to_send = MHUV2_STAT_BYTES;
+
+			writel_relaxed(word, &mhu->send->ch_wn[priv->ch_wn_idx + windows - 1 - i].STAT_SET);
+			bytes_left -= bytes_to_send;
+			bytes_in_round -= bytes_to_send;
+		}
+
+		data += windows;
+	}
+
+	return 0;
+}
+
+static const struct mhuv2_protocol_ops mhuv2_multi_word_ops = {
+	.rx_startup = mhuv2_multi_word_rx_startup,
+	.rx_shutdown = mhuv2_multi_word_rx_shutdown,
+	.read_data = mhuv2_multi_word_read_data,
+	.tx_startup = mhuv2_multi_word_tx_startup,
+	.tx_shutdown = mhuv2_multi_word_tx_shutdown,
+	.last_tx_done = mhuv2_multi_word_last_tx_done,
+	.send_data = mhuv2_multi_word_send_data,
+};
+#define IS_PROTOCOL_MULTI_WORD(_priv) (_priv->ops == &mhuv2_multi_word_ops)
+
+
+/* Interrupt handlers */
+
+static struct mbox_chan *get_irq_chan_comb(struct mhuv2 *mhu, u32 *reg)
+{
+	struct mbox_chan *chans = mhu->mbox.chans;
+	int channel = 0, i, offset = 0, windows, protocol, ch_wn;
+	u32 stat;
+
+	for (i = 0; i < MHUV2_CMB_INT_ST_REG_CNT; i++) {
+		stat = readl_relaxed(reg + i);
+		if (!stat)
+			continue;
+
+		ch_wn = i * MHUV2_STAT_BITS + __builtin_ctz(stat);
+
+		for (i = 0; i < mhu->length; i += 2) {
+			protocol = mhu->protocols[i];
+			windows = mhu->protocols[i + 1];
+
+			if (ch_wn >= offset + windows) {
+				if (protocol == DOORBELL)
+					channel += MHUV2_STAT_BITS * windows;
+				else if (protocol == SINGLE_WORD)
+					channel += windows;
+				else
+					channel++;
+
+				offset += windows;
+				continue;
+			}
+
+			/*
+			 * Return first chan of the window in the doorbell mode,
+			 * else return the right channel.
+			 */
+			if (protocol == SINGLE_WORD)
+				channel += ch_wn - offset;
+			else if (protocol == DOORBELL)
+				channel += MHUV2_STAT_BITS * (ch_wn - offset);
+
+			return &chans[channel];
+		}
+	}
+
+	return ERR_PTR(-EIO);
+}
+
+static irqreturn_t mhuv2_sender_interrupt(int irq, void *data)
+{
+	struct mhuv2 *mhu = data;
+	struct device *dev = mhu->mbox.dev;
+	struct mhuv2_mbox_chan_priv *priv;
+	struct mbox_chan *chan;
+	unsigned long flags;
+	int i, found = 0;
+	u32 stat;
+
+	chan = get_irq_chan_comb(mhu, mhu->send->CHCOMB_INT_ST);
+	if (IS_ERR(chan)) {
+		dev_warn(dev, "Failed to find channel for the Tx interrupt\n");
+		return IRQ_NONE;
+	}
+	priv = chan->con_priv;
+
+	/* Clear the interrupt first, so we don't miss any doorbell later */
+	i = priv->ch_wn_idx;
+	if (IS_PROTOCOL_MULTI_WORD(priv))
+		i += priv->windows - 1;
+	writel_relaxed(1, &mhu->send->ch_wn[i].INT_CLR);
+
+	if (!IS_PROTOCOL_DOORBELL(priv)) {
+		if (chan->cl) {
+			mbox_chan_txdone(chan, 0);
+			return IRQ_HANDLED;
+		}
+
+		dev_warn(dev, "Tx interrupt Received on channel (%u) not currently attached to a mailbox client\n",
+			 priv->ch_wn_idx);
+		return IRQ_NONE;
+	}
+
+	/*
+	 * In Doorbell mode, make sure no new transitions happen while the
+	 * interrupt handler is trying to find the finished doorbell tx
+	 * operations, else we may think few of the transfers were complete
+	 * before they actually were.
+	 */
+	spin_lock_irqsave(&mhu->doorbell_pending_lock, flags);
+
+	/*
+	 * In case of doorbell mode, the first channel of the window is returned
+	 * by get_irq_chan_comb(). Find all the pending channels here.
+	 */
+	stat = readl_relaxed(&mhu->send->ch_wn[priv->ch_wn_idx].STAT);
+
+	for (i = 0; i < MHUV2_STAT_BITS; i++) {
+		priv = chan[i].con_priv;
+
+		/* Find cases where pending was 1, but stat's bit is cleared */
+		if (priv->pending ^ ((stat >> i) & 0x1)) {
+			BUG_ON(!priv->pending);
+
+			if (!chan->cl) {
+				dev_warn(dev, "Tx interrupt received on doorbell (%u : %u) channel not currently attached to a mailbox client\n",
+					 priv->ch_wn_idx, i);
+				continue;
+			}
+
+			mbox_chan_txdone(&chan[i], 0);
+			priv->pending = 0;
+			found++;
+		}
+	}
+
+	spin_unlock_irqrestore(&mhu->doorbell_pending_lock, flags);
+
+	if (!found) {
+		/*
+		 * We may have already processed the doorbell in the previous
+		 * iteration if the interrupt came right after we cleared it but
+		 * before we read the STAT register.
+		 */
+		dev_dbg(dev, "Couldn't find the doorbell (%u) for the Tx interrupt interrupt\n",
+			priv->ch_wn_idx);
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct mbox_chan *get_irq_chan_comb_rx(struct mhuv2 *mhu)
+{
+	struct mhuv2_mbox_chan_priv *priv;
+	struct mbox_chan *chan;
+	u32 stat;
+
+	chan = get_irq_chan_comb(mhu, mhu->recv->CHCOMB_INT_ST);
+	if (IS_ERR(chan))
+		return chan;
+
+	priv = chan->con_priv;
+	if (!IS_PROTOCOL_DOORBELL(priv))
+		return chan;
+
+	/*
+	 * In case of doorbell mode, the first channel of the window is returned
+	 * by the routine. Find the exact channel here.
+	 */
+	stat = readl_relaxed(&mhu->recv->ch_wn[priv->ch_wn_idx].STAT_MASKED);
+	BUG_ON(!stat);
+
+	return chan + __builtin_ctz(stat);
+}
+
+static struct mbox_chan *get_irq_chan_stat_rx(struct mhuv2 *mhu)
+{
+	struct mbox_chan *chans = mhu->mbox.chans;
+	struct mhuv2_mbox_chan_priv *priv;
+	u32 stat;
+	int i = 0;
+
+	while (i < mhu->mbox.num_chans) {
+		priv = chans[i].con_priv;
+		stat = readl_relaxed(&mhu->recv->ch_wn[priv->ch_wn_idx].STAT_MASKED);
+
+		if (stat) {
+			if (IS_PROTOCOL_DOORBELL(priv))
+				i += __builtin_ctz(stat);
+			return &chans[i];
+		}
+
+		i += IS_PROTOCOL_DOORBELL(priv) ? MHUV2_STAT_BITS : 1;
+	}
+
+	return ERR_PTR(-EIO);
+}
+
+static struct mbox_chan *get_irq_chan_rx(struct mhuv2 *mhu)
+{
+	if (!mhu->minor)
+		return get_irq_chan_stat_rx(mhu);
+
+	return get_irq_chan_comb_rx(mhu);
+}
+
+static irqreturn_t mhuv2_receiver_interrupt(int irq, void *arg)
+{
+	struct mhuv2 *mhu = arg;
+	struct mbox_chan *chan = get_irq_chan_rx(mhu);
+	struct device *dev = mhu->mbox.dev;
+	struct mhuv2_mbox_chan_priv *priv;
+	void *data;
+	int ret = IRQ_NONE;
+
+	if (IS_ERR(chan)) {
+		dev_warn(dev, "Failed to find channel for the rx interrupt\n");
+		return IRQ_NONE;
+	}
+	priv = chan->con_priv;
+
+	/* Read and clear the data first */
+	data = priv->ops->read_data(mhu, chan);
+
+	if (!chan->cl) {
+		dev_warn(dev, "Received data on channel (%u) not currently attached to a mailbox client\n",
+			 priv->ch_wn_idx);
+	} else if (IS_ERR(data)) {
+		dev_err(dev, "Failed to read data: %lu\n", PTR_ERR(data));
+	} else {
+		mbox_chan_received_data(chan, data);
+		ret = IRQ_HANDLED;
+	}
+
+	kfree(data);
+	return ret;
+}
+
+/* Sender and receiver ops */
+static bool mhuv2_sender_last_tx_done(struct mbox_chan *chan)
+{
+	struct mhuv2 *mhu = mhu_from_mbox(chan->mbox);
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+
+	return priv->ops->last_tx_done(mhu, chan);
+}
+
+static int mhuv2_sender_send_data(struct mbox_chan *chan, void *data)
+{
+	struct mhuv2 *mhu = mhu_from_mbox(chan->mbox);
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+
+	if (!priv->ops->last_tx_done(mhu, chan))
+		return -EBUSY;
+
+	return priv->ops->send_data(mhu, chan, data);
+}
+
+static int mhuv2_sender_startup(struct mbox_chan *chan)
+{
+	struct mhuv2 *mhu = mhu_from_mbox(chan->mbox);
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+
+	if (priv->ops->tx_startup)
+		priv->ops->tx_startup(mhu, chan);
+	return 0;
+}
+
+static void mhuv2_sender_shutdown(struct mbox_chan *chan)
+{
+	struct mhuv2 *mhu = mhu_from_mbox(chan->mbox);
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+
+	if (priv->ops->tx_shutdown)
+		priv->ops->tx_shutdown(mhu, chan);
+}
+
+static const struct mbox_chan_ops mhuv2_sender_ops = {
+	.send_data = mhuv2_sender_send_data,
+	.startup = mhuv2_sender_startup,
+	.shutdown = mhuv2_sender_shutdown,
+	.last_tx_done = mhuv2_sender_last_tx_done,
+};
+
+static int mhuv2_receiver_startup(struct mbox_chan *chan)
+{
+	struct mhuv2 *mhu = mhu_from_mbox(chan->mbox);
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+
+	return priv->ops->rx_startup(mhu, chan);
+}
+
+static void mhuv2_receiver_shutdown(struct mbox_chan *chan)
+{
+	struct mhuv2 *mhu = mhu_from_mbox(chan->mbox);
+	struct mhuv2_mbox_chan_priv *priv = chan->con_priv;
+
+	priv->ops->rx_shutdown(mhu, chan);
+}
+
+static int mhuv2_receiver_send_data(struct mbox_chan *chan, void *data)
+{
+	dev_err(chan->mbox->dev,
+		"Trying to transmit on a receiver MHU frame\n");
+	return -EIO;
+}
+
+static bool mhuv2_receiver_last_tx_done(struct mbox_chan *chan)
+{
+	dev_err(chan->mbox->dev, "Trying to Tx poll on a receiver MHU frame\n");
+	return true;
+}
+
+static const struct mbox_chan_ops mhuv2_receiver_ops = {
+	.send_data = mhuv2_receiver_send_data,
+	.startup = mhuv2_receiver_startup,
+	.shutdown = mhuv2_receiver_shutdown,
+	.last_tx_done = mhuv2_receiver_last_tx_done,
+};
+
+static struct mbox_chan *mhuv2_mbox_of_xlate(struct mbox_controller *mbox,
+					     const struct of_phandle_args *pa)
+{
+	struct mhuv2 *mhu = mhu_from_mbox(mbox);
+	struct mbox_chan *chans = mbox->chans;
+	int channel = 0, i, offset, doorbell, protocol, windows;
+
+	if (pa->args_count != 2)
+		return ERR_PTR(-EINVAL);
+
+	offset = pa->args[0];
+	doorbell = pa->args[1];
+	if (doorbell >= MHUV2_STAT_BITS)
+		goto out;
+
+	for (i = 0; i < mhu->length; i += 2) {
+		protocol = mhu->protocols[i];
+		windows = mhu->protocols[i + 1];
+
+		if (protocol == DOORBELL) {
+			if (offset < windows)
+				return &chans[channel + MHUV2_STAT_BITS * offset + doorbell];
+
+			channel += MHUV2_STAT_BITS * windows;
+			offset -= windows;
+			continue;
+		}
+
+		if (protocol == SINGLE_WORD) {
+			if (offset < windows) {
+				if (doorbell)
+					goto out;
+
+				return &chans[channel + offset];
+			}
+
+			channel += windows;
+			offset -= windows;
+		} else {
+			if (offset == 0) {
+				if (doorbell)
+					goto out;
+
+				return &chans[channel];
+			}
+
+			channel++;
+			offset--;
+		}
+	}
+
+out:
+	dev_err(mbox->dev, "Couldn't xlate to a valid channel (%d: %d)\n",
+		pa->args[0], doorbell);
+	return ERR_PTR(-ENODEV);
+}
+
+static int mhuv2_verify_protocol(struct mhuv2 *mhu)
+{
+	struct device *dev = mhu->mbox.dev;
+	int protocol, windows, channels = 0, total_windows = 0, i;
+
+	for (i = 0; i < mhu->length; i += 2) {
+		protocol = mhu->protocols[i];
+		windows = mhu->protocols[i + 1];
+
+		if (!windows) {
+			dev_err(dev, "Window size can't be zero (%d)\n", i);
+			return -EINVAL;
+		}
+		total_windows += windows;
+
+		if (protocol == DOORBELL) {
+			channels += MHUV2_STAT_BITS * windows;
+		} else if (protocol == SINGLE_WORD) {
+			channels += windows;
+		} else if (protocol == MULTI_WORD) {
+			if (windows == 1) {
+				dev_err(dev, "Window size must be greater than 1 for multi-word protocol (%d)\n",
+					i);
+				return -EINVAL;
+			}
+			channels++;
+		} else {
+			dev_err(dev, "Invalid protocol (%d) present in %s property at index %d\n",
+				protocol, MHUV2_PROTOCOL_PROP, i);
+			return -EINVAL;
+		}
+	}
+
+	if (total_windows > mhu->windows) {
+		dev_err(dev, "Channel windows can't be more than what's implemented by the hardware ( %d: %d)\n",
+			total_windows, mhu->windows);
+		return -EINVAL;
+	}
+
+	mhu->mbox.num_chans = channels;
+	return 0;
+}
+
+static int mhuv2_allocate_channels(struct mhuv2 *mhu)
+{
+	struct mbox_controller *mbox = &mhu->mbox;
+	struct mhuv2_mbox_chan_priv *priv;
+	struct device *dev = mbox->dev;
+	struct mbox_chan *chans;
+	int protocol, windows, next_window = 0, i, j, k;
+
+	chans = devm_kcalloc(dev, mbox->num_chans, sizeof(*chans), GFP_KERNEL);
+	if (!chans)
+		return -ENOMEM;
+
+	mbox->chans = chans;
+
+	for (i = 0; i < mhu->length; i += 2) {
+		protocol = mhu->protocols[i];
+		windows = mhu->protocols[i + 1];
+
+		if (protocol == MULTI_WORD) {
+			priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
+			if (!priv)
+				return -ENOMEM;
+
+			priv->ch_wn_idx = next_window;
+			priv->ops = &mhuv2_multi_word_ops;
+			priv->windows = windows;
+			chans++->con_priv = priv;
+
+			next_window += windows;
+			continue;
+		}
+
+		for (j = 0; j < windows; j++) {
+			if (protocol == DOORBELL) {
+				for (k = 0; k < MHUV2_STAT_BITS; k++) {
+					priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
+					if (!priv)
+						return -ENOMEM;
+
+					priv->ch_wn_idx = next_window + j;
+					priv->ops = &mhuv2_doorbell_ops;
+					priv->doorbell = k;
+					chans++->con_priv = priv;
+				}
+
+				/*
+				 * Permanently enable interrupt as we can't
+				 * control it per doorbell.
+				 */
+				if (mhu->frame == SENDER_FRAME && mhu->minor)
+					writel_relaxed(0x1, &mhu->send->ch_wn[priv->ch_wn_idx].INT_EN);
+			} else {
+				/* Single-word */
+				priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
+				if (!priv)
+					return -ENOMEM;
+
+				priv->ch_wn_idx = next_window + j;
+				priv->ops = &mhuv2_single_word_ops;
+				chans++->con_priv = priv;
+			}
+		}
+
+		next_window += windows;
+	}
+
+	/* Make sure we have initialized all channels */
+	BUG_ON(chans - mbox->chans != mbox->num_chans);
+
+	return 0;
+}
+
+static int mhuv2_parse_channels(struct mhuv2 *mhu)
+{
+	struct device *dev = mhu->mbox.dev;
+	const struct device_node *np = dev->of_node;
+	int ret, count;
+	u32 *protocols;
+
+	count = of_property_count_u32_elems(np, MHUV2_PROTOCOL_PROP);
+	if (count <= 0 || count % 2) {
+		dev_err(dev, "Invalid %s property (%d)\n", MHUV2_PROTOCOL_PROP,
+			count);
+		return -EINVAL;
+	}
+
+	protocols = devm_kmalloc_array(dev, count, sizeof(*protocols), GFP_KERNEL);
+	if (!protocols)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(np, MHUV2_PROTOCOL_PROP, protocols, count);
+	if (ret) {
+		dev_err(dev, "Failed to read %s property: %d\n",
+			MHUV2_PROTOCOL_PROP, ret);
+		return ret;
+	}
+
+	mhu->protocols = protocols;
+	mhu->length = count;
+
+	ret = mhuv2_verify_protocol(mhu);
+	if (ret)
+		return ret;
+
+	return mhuv2_allocate_channels(mhu);
+}
+
+static int mhuv2_tx_init(struct amba_device *adev, struct mhuv2 *mhu,
+			 void __iomem *reg)
+{
+	struct device *dev = mhu->mbox.dev;
+	int ret, i;
+
+	mhu->frame = SENDER_FRAME;
+	mhu->mbox.ops = &mhuv2_sender_ops;
+	mhu->send = reg;
+
+	mhu->windows = readl_relaxed_bitfield(&mhu->send->MHU_CFG, NUM_CH);
+	mhu->minor = readl_relaxed_bitfield(&mhu->send->AIDR, ARCH_MINOR_REV);
+
+	spin_lock_init(&mhu->doorbell_pending_lock);
+
+	/*
+	 * For minor version 1 and forward, tx interrupt is provided by
+	 * the controller.
+	 */
+	if (mhu->minor && adev->irq[0]) {
+		ret = devm_request_threaded_irq(dev, adev->irq[0], NULL,
+						mhuv2_sender_interrupt,
+						IRQF_ONESHOT, "mhuv2-tx", mhu);
+		if (ret) {
+			dev_err(dev, "Failed to request tx IRQ, fallback to polling mode: %d\n",
+				ret);
+		} else {
+			mhu->mbox.txdone_irq = true;
+			mhu->mbox.txdone_poll = false;
+			mhu->irq = adev->irq[0];
+
+			writel_relaxed_bitfield(1, &mhu->send->INT_EN, CHCOMB);
+
+			/* Disable all channel interrupts */
+			for (i = 0; i < mhu->windows; i++)
+				writel_relaxed(0x0, &mhu->send->ch_wn[i].INT_EN);
+
+			goto out;
+		}
+	}
+
+	mhu->mbox.txdone_irq = false;
+	mhu->mbox.txdone_poll = true;
+	mhu->mbox.txpoll_period = 1;
+
+out:
+	/* Wait for receiver to be ready */
+	writel_relaxed(0x1, &mhu->send->ACCESS_REQUEST);
+	while (!readl_relaxed(&mhu->send->ACCESS_READY))
+		continue;
+
+	return 0;
+}
+
+static int mhuv2_rx_init(struct amba_device *adev, struct mhuv2 *mhu,
+			 void __iomem *reg)
+{
+	struct device *dev = mhu->mbox.dev;
+	int ret, i;
+
+	mhu->frame = RECEIVER_FRAME;
+	mhu->mbox.ops = &mhuv2_receiver_ops;
+	mhu->recv = reg;
+
+	mhu->windows = readl_relaxed_bitfield(&mhu->recv->MHU_CFG, NUM_CH);
+	mhu->minor = readl_relaxed_bitfield(&mhu->recv->AIDR, ARCH_MINOR_REV);
+
+	mhu->irq = adev->irq[0];
+	if (!mhu->irq) {
+		dev_err(dev, "Missing receiver IRQ\n");
+		return -EINVAL;
+	}
+
+	ret = devm_request_threaded_irq(dev, mhu->irq, NULL,
+					mhuv2_receiver_interrupt, IRQF_ONESHOT,
+					"mhuv2-rx", mhu);
+	if (ret) {
+		dev_err(dev, "Failed to request rx IRQ\n");
+		return ret;
+	}
+
+	/* Mask all the channel windows */
+	for (i = 0; i < mhu->windows; i++)
+		writel_relaxed(0xFFFFFFFF, &mhu->recv->ch_wn[i].MASK_SET);
+
+	if (mhu->minor)
+		writel_relaxed_bitfield(1, &mhu->recv->INT_EN, CHCOMB);
+
+	return 0;
+}
+
+static int mhuv2_probe(struct amba_device *adev, const struct amba_id *id)
+{
+	struct device *dev = &adev->dev;
+	const struct device_node *np = dev->of_node;
+	struct mhuv2 *mhu;
+	void __iomem *reg;
+	int ret = -EINVAL;
+
+	reg = devm_of_iomap(dev, dev->of_node, 0, NULL);
+	if (!reg)
+		return -ENOMEM;
+
+	mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
+	if (!mhu)
+		return -ENOMEM;
+
+	mhu->mbox.dev = dev;
+	mhu->mbox.of_xlate = mhuv2_mbox_of_xlate;
+
+	if (of_device_is_compatible(np, "arm,mhuv2-tx"))
+		ret = mhuv2_tx_init(adev, mhu, reg);
+	else if (of_device_is_compatible(np, "arm,mhuv2-rx"))
+		ret = mhuv2_rx_init(adev, mhu, reg);
+	else
+		dev_err(dev, "Invalid compatible property\n");
+
+	if (ret)
+		return ret;
+
+	/* Channel windows can't be 0 */
+	BUG_ON(!mhu->windows);
+
+	ret = mhuv2_parse_channels(mhu);
+	if (ret)
+		return ret;
+
+	amba_set_drvdata(adev, mhu);
+
+	ret = devm_mbox_controller_register(dev, &mhu->mbox);
+	if (ret)
+		dev_err(dev, "failed to register ARM MHUv2 driver %d\n", ret);
+
+	return ret;
+}
+
+static int mhuv2_remove(struct amba_device *adev)
+{
+	struct mhuv2 *mhu = amba_get_drvdata(adev);
+
+	if (mhu->frame == SENDER_FRAME)
+		writel_relaxed(0x0, &mhu->send->ACCESS_REQUEST);
+
+	return 0;
+}
+
+static struct amba_id mhuv2_ids[] = {
+	{
+		/* 2.0 */
+		.id = 0xbb0d1,
+		.mask = 0xfffff,
+	},
+	{
+		/* 2.1 */
+		.id = 0xbb076,
+		.mask = 0xfffff,
+	},
+	{ 0, 0 },
+};
+MODULE_DEVICE_TABLE(amba, mhuv2_ids);
+
+static struct amba_driver mhuv2_driver = {
+	.drv = {
+		.name	= "arm-mhuv2",
+	},
+	.id_table	= mhuv2_ids,
+	.probe		= mhuv2_probe,
+	.remove		= mhuv2_remove,
+};
+module_amba_driver(mhuv2_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ARM MHUv2 Driver");
+MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
+MODULE_AUTHOR("Tushar Khandelwal <tushar.khandelwal@arm.com>");
diff --git a/include/linux/mailbox/arm_mhuv2_message.h b/include/linux/mailbox/arm_mhuv2_message.h
new file mode 100644
index 000000000000..f991f4a209af
--- /dev/null
+++ b/include/linux/mailbox/arm_mhuv2_message.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM MHUv2 Mailbox Message
+ *
+ * Copyright (C) 2020 Arm Ltd.
+ * Copyright (C) 2020 Linaro Ltd.
+ */
+
+#ifndef _LINUX_ARM_MHUV2_MESSAGE_H_
+#define _LINUX_ARM_MHUV2_MESSAGE_H_
+
+#include <linux/types.h>
+
+/* Data structure for multi-word data transport protocol */
+struct arm_mhuv2_mbox_msg {
+	void *data;
+	size_t len;
+};
+
+#endif /* _LINUX_ARM_MHUV2_MESSAGE_H_ */
-- 
2.25.0.rc1.19.g042ed3e048af

