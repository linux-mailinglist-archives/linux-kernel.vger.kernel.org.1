Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841542A8900
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbgKEV2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:28:37 -0500
Received: from plasma4.jpberlin.de ([80.241.57.33]:49279 "EHLO
        plasma4.jpberlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732046AbgKEV2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:28:14 -0500
Received: from spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122])
        by plasma.jpberlin.de (Postfix) with ESMTP id 7B8F6AB751;
        Thu,  5 Nov 2020 22:21:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.68])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id TLcSij56-UPX; Thu,  5 Nov 2020 22:21:45 +0100 (CET)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "*.opensynergy.com", Issuer "Starfield Secure Certificate Authority - G2" (not verified))
        (Authenticated sender: opensynergy@jpberlin.de)
        by plasma.jpberlin.de (Postfix) with ESMTPSA id 49265AB788;
        Thu,  5 Nov 2020 22:21:45 +0100 (CET)
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Igor Skalkin <igor.skalkin@opensynergy.com>,
        Peter Hilber <peter.hilber@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>,
        <souvik.chakravarty@arm.com>, <alex.bennee@linaro.org>,
        <jean-philippe@linaro.org>, <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>
Subject: [RFC PATCH v2 03/10] firmware: arm_scmi: Add op to override max message #
Date:   Thu, 5 Nov 2020 22:21:09 +0100
Message-ID: <20201105212116.411422-4-peter.hilber@opensynergy.com>
In-Reply-To: <20201105212116.411422-1-peter.hilber@opensynergy.com>
References: <20201105212116.411422-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.39 / 15.00 / 15.00
X-Rspamd-Queue-Id: 7B8F6AB751
X-Rspamd-UID: 3f77b1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Skalkin <igor.skalkin@opensynergy.com>

The number of messages that the upcoming scmi-virtio transport can
support depends on the virtio device (SCMI platform) and can differ for
each channel. (The scmi-virtio transport does only have one tx and at
most 1 rx channel.)

Add an optional transport op so that scmi-virtio can report the actual
max message # for each channel type. Respect these new limits.

Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
---
 drivers/firmware/arm_scmi/common.h |  8 ++++-
 drivers/firmware/arm_scmi/driver.c | 49 ++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 38e6aabbe3dd..9a8359ecd220 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -203,6 +203,9 @@ struct scmi_chan_info {
  * @chan_available: Callback to check if channel is available or not
  * @chan_setup: Callback to allocate and setup a channel
  * @chan_free: Callback to free a channel
+ * @get_max_msg: Optional callback to provide max_msg dynamically
+ * 	@max_msg: Maximum number of messages for the channel type (tx or rx)
+ * 		that can be pending simultaneously in the system
  * @send_message: Callback to send a message
  * @mark_txdone: Callback to mark tx as done
  * @fetch_response: Callback to fetch response
@@ -215,6 +218,8 @@ struct scmi_transport_ops {
 	int (*chan_setup)(struct scmi_chan_info *cinfo, struct device *dev,
 			  bool tx);
 	int (*chan_free)(int id, void *p, void *data);
+	int (*get_max_msg)(bool tx, struct scmi_chan_info *base_cinfo,
+			   int *max_msg);
 	int (*send_message)(struct scmi_chan_info *cinfo,
 			    struct scmi_xfer *xfer);
 	void (*mark_txdone)(struct scmi_chan_info *cinfo, int ret);
@@ -232,7 +237,8 @@ struct scmi_transport_ops {
  * @ops: Pointer to the transport specific ops structure
  * @max_rx_timeout_ms: Timeout for communication with SoC (in Milliseconds)
  * @max_msg: Maximum number of messages for a channel type (tx or rx) that can
- *	be pending simultaneously in the system
+ *	be pending simultaneously in the system. May be overridden by the
+ *	get_max_msg op.
  * @max_msg_size: Maximum size of data per message that can be handled.
  */
 struct scmi_desc {
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 9e2f36127793..e2faa526dfce 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -61,11 +61,13 @@ static atomic_t transfer_last_id;
  *	Index of this bitmap table is also used for message
  *	sequence identifier.
  * @xfer_lock: Protection for message allocation
+ * @max_msg: Maximum number of messages that can be pending
  */
 struct scmi_xfers_info {
 	struct scmi_xfer *xfer_block;
 	unsigned long *xfer_alloc_table;
 	spinlock_t xfer_lock;
+	int max_msg;
 };
 
 /**
@@ -157,13 +159,11 @@ static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
 	u16 xfer_id;
 	struct scmi_xfer *xfer;
 	unsigned long flags, bit_pos;
-	struct scmi_info *info = handle_to_scmi_info(handle);
 
 	/* Keep the locked section as small as possible */
 	spin_lock_irqsave(&minfo->xfer_lock, flags);
-	bit_pos = find_first_zero_bit(minfo->xfer_alloc_table,
-				      info->desc->max_msg);
-	if (bit_pos == info->desc->max_msg) {
+	bit_pos = find_first_zero_bit(minfo->xfer_alloc_table, minfo->max_msg);
+	if (bit_pos == minfo->max_msg) {
 		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -602,32 +602,44 @@ int scmi_handle_put(const struct scmi_handle *handle)
 }
 
 static int __scmi_xfer_info_init(struct scmi_info *sinfo,
-				 struct scmi_xfers_info *info)
+				 struct scmi_xfers_info *info,
+				 bool tx,
+				 struct scmi_chan_info *base_cinfo)
 {
 	int i;
 	struct scmi_xfer *xfer;
 	struct device *dev = sinfo->dev;
 	const struct scmi_desc *desc = sinfo->desc;
 
+	info->max_msg = desc->max_msg;
+
+	if (desc->ops->get_max_msg) {
+		int ret =
+			desc->ops->get_max_msg(tx, base_cinfo, &info->max_msg);
+
+		if (ret)
+			return ret;
+	}
+
 	/* Pre-allocated messages, no more than what hdr.seq can support */
-	if (WARN_ON(desc->max_msg >= MSG_TOKEN_MAX)) {
+	if (WARN_ON(info->max_msg >= MSG_TOKEN_MAX)) {
 		dev_err(dev, "Maximum message of %d exceeds supported %ld\n",
-			desc->max_msg, MSG_TOKEN_MAX);
+			info->max_msg, MSG_TOKEN_MAX);
 		return -EINVAL;
 	}
 
-	info->xfer_block = devm_kcalloc(dev, desc->max_msg,
+	info->xfer_block = devm_kcalloc(dev, info->max_msg,
 					sizeof(*info->xfer_block), GFP_KERNEL);
 	if (!info->xfer_block)
 		return -ENOMEM;
 
-	info->xfer_alloc_table = devm_kcalloc(dev, BITS_TO_LONGS(desc->max_msg),
+	info->xfer_alloc_table = devm_kcalloc(dev, BITS_TO_LONGS(info->max_msg),
 					      sizeof(long), GFP_KERNEL);
 	if (!info->xfer_alloc_table)
 		return -ENOMEM;
 
 	/* Pre-initialize the buffer pointer to pre-allocated buffers */
-	for (i = 0, xfer = info->xfer_block; i < desc->max_msg; i++, xfer++) {
+	for (i = 0, xfer = info->xfer_block; i < info->max_msg; i++, xfer++) {
 		xfer->rx.buf = devm_kcalloc(dev, sizeof(u8), desc->max_msg_size,
 					    GFP_KERNEL);
 		if (!xfer->rx.buf)
@@ -644,10 +656,21 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
 
 static int scmi_xfer_info_init(struct scmi_info *sinfo)
 {
-	int ret = __scmi_xfer_info_init(sinfo, &sinfo->tx_minfo);
+	int ret;
+	struct scmi_chan_info *base_tx_cinfo;
+	struct scmi_chan_info *base_rx_cinfo;
+
+	base_tx_cinfo = idr_find(&sinfo->tx_idr, SCMI_PROTOCOL_BASE);
+	if (unlikely(!base_tx_cinfo))
+		return -EINVAL;
+
+	ret = __scmi_xfer_info_init(sinfo, &sinfo->tx_minfo, true,
+				    base_tx_cinfo);
 
-	if (!ret && idr_find(&sinfo->rx_idr, SCMI_PROTOCOL_BASE))
-		ret = __scmi_xfer_info_init(sinfo, &sinfo->rx_minfo);
+	base_rx_cinfo = idr_find(&sinfo->rx_idr, SCMI_PROTOCOL_BASE);
+	if (!ret && base_rx_cinfo)
+		ret = __scmi_xfer_info_init(sinfo, &sinfo->rx_minfo, false,
+					    base_rx_cinfo);
 
 	return ret;
 }
-- 
2.25.1

