Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFAE2A8904
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbgKEV2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:28:45 -0500
Received: from plasma4.jpberlin.de ([80.241.57.33]:37749 "EHLO
        plasma4.jpberlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730973AbgKEV2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:28:13 -0500
Received: from spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115])
        by plasma.jpberlin.de (Postfix) with ESMTP id 8097EAB788;
        Thu,  5 Nov 2020 22:21:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.68])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id QMW7d5Yg6Hez; Thu,  5 Nov 2020 22:21:47 +0100 (CET)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "*.opensynergy.com", Issuer "Starfield Secure Certificate Authority - G2" (not verified))
        (Authenticated sender: opensynergy@jpberlin.de)
        by plasma.jpberlin.de (Postfix) with ESMTPSA id 4F6C7AB79F;
        Thu,  5 Nov 2020 22:21:47 +0100 (CET)
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
Subject: [RFC PATCH v2 05/10] firmware: arm_scmi: Add xfer_init_buffers transport op
Date:   Thu, 5 Nov 2020 22:21:11 +0100
Message-ID: <20201105212116.411422-6-peter.hilber@opensynergy.com>
In-Reply-To: <20201105212116.411422-1-peter.hilber@opensynergy.com>
References: <20201105212116.411422-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.38 / 15.00 / 15.00
X-Rspamd-Queue-Id: 8097EAB788
X-Rspamd-UID: 1aff53
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Skalkin <igor.skalkin@opensynergy.com>

The virtio transport in this patch series can be simplified by using the
scmi_xfer tx/rx buffers for data exchange with the virtio device, and
for saving the message state. But the virtio transport requires
prepending a transport-specific header. Also, for data exchange using
virtqueues, the tx and rx buffers should not overlap.

After the previous patch, this is the second and final step to enable
the virtio transport to use the scmi_xfer buffers for data exchange.

Add an optional op through which the transport can allocate the tx/rx
buffers along with room for the prepended transport-specific headers.

Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
---
 drivers/firmware/arm_scmi/common.h |  3 +++
 drivers/firmware/arm_scmi/driver.c | 21 +++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index c998ec29018e..ae5db602e45d 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -208,6 +208,7 @@ struct scmi_chan_info {
  * @get_max_msg: Optional callback to provide max_msg dynamically
  * 	@max_msg: Maximum number of messages for the channel type (tx or rx)
  * 		that can be pending simultaneously in the system
+ * @xfer_init_buffers: Callback to initialize buffers for scmi_xfer
  * @send_message: Callback to send a message
  * @mark_txdone: Callback to mark tx as done
  * @fetch_response: Callback to fetch response
@@ -222,6 +223,8 @@ struct scmi_transport_ops {
 	int (*chan_free)(int id, void *p, void *data);
 	int (*get_max_msg)(bool tx, struct scmi_chan_info *base_cinfo,
 			   int *max_msg);
+	int (*xfer_init_buffers)(struct scmi_chan_info *cinfo,
+				 struct scmi_xfer *xfer, int max_msg_size);
 	int (*send_message)(struct scmi_chan_info *cinfo,
 			    struct scmi_xfer *xfer);
 	void (*mark_txdone)(struct scmi_chan_info *cinfo, int ret);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index e2faa526dfce..d7ad5a77b9dc 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -640,12 +640,21 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
 
 	/* Pre-initialize the buffer pointer to pre-allocated buffers */
 	for (i = 0, xfer = info->xfer_block; i < info->max_msg; i++, xfer++) {
-		xfer->rx.buf = devm_kcalloc(dev, sizeof(u8), desc->max_msg_size,
-					    GFP_KERNEL);
-		if (!xfer->rx.buf)
-			return -ENOMEM;
-
-		xfer->tx.buf = xfer->rx.buf;
+		if (desc->ops->xfer_init_buffers) {
+			int ret = desc->ops->xfer_init_buffers(
+				base_cinfo, xfer, desc->max_msg_size);
+
+			if (ret)
+				return ret;
+		} else {
+			xfer->rx.buf = devm_kcalloc(dev, sizeof(u8),
+						    desc->max_msg_size,
+						    GFP_KERNEL);
+			if (!xfer->rx.buf)
+				return -ENOMEM;
+
+			xfer->tx.buf = xfer->rx.buf;
+		}
 		init_completion(&xfer->done);
 	}
 
-- 
2.25.1

