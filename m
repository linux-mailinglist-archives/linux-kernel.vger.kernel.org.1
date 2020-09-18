Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB512702B5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgIRQ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:56:04 -0400
Received: from plasma31.jpberlin.de ([80.241.56.82]:9163 "EHLO
        plasma31.jpberlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIRQ4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:56:03 -0400
Received: from spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123])
        by plasma.jpberlin.de (Postfix) with ESMTP id 3C6B410268D;
        Fri, 18 Sep 2020 18:55:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.76])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id 795MTA2s70oB; Fri, 18 Sep 2020 18:55:58 +0200 (CEST)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "*.opensynergy.com", Issuer "Starfield Secure Certificate Authority - G2" (not verified))
        (Authenticated sender: opensynergy@jpberlin.de)
        by plasma.jpberlin.de (Postfix) with ESMTPSA id 09297100D05;
        Fri, 18 Sep 2020 18:55:58 +0200 (CEST)
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <sudeep.holla@arm.com>, <souvik.chakravarty@arm.com>,
        <alex.bennee@linaro.org>, <jean-philippe@linaro.org>,
        <igor.skalkin@opensynergy.com>, <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>,
        Peter Hilber <peter.hilber@opensynergy.com>
Subject: [RFC PATCH 5/7] firmware: arm_scmi: Add xfer_init_buffers transport op
Date:   Fri, 18 Sep 2020 18:55:30 +0200
Message-ID: <20200918165530.257023-1-peter.hilber@opensynergy.com>
In-Reply-To: <20200918162311.254564-1-peter.hilber@opensynergy.com>
References: <20200918162311.254564-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.07 / 15.00 / 15.00
X-Rspamd-Queue-Id: 3C6B410268D
X-Rspamd-UID: 935e96
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
index e3ccec954e93..c6071ffe4346 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -206,6 +206,7 @@ struct scmi_chan_info {
  * @get_max_msg: Optional callback to provide max_msg dynamically
  * 	@max_msg: Maximum number of messages for the channel type (tx or rx)
  * 		that can be pending simultaneously in the system
+ * @xfer_init_buffers: Callback to initialize buffers for scmi_xfer
  * @send_message: Callback to send a message
  * @mark_txdone: Callback to mark tx as done
  * @fetch_response: Callback to fetch response
@@ -220,6 +221,8 @@ struct scmi_transport_ops {
 	int (*chan_free)(int id, void *p, void *data);
 	int (*get_max_msg)(bool tx, struct scmi_chan_info *base_cinfo,
 			   int *max_msg);
+	int (*xfer_init_buffers)(struct scmi_chan_info *cinfo,
+				 struct scmi_xfer *xfer, int max_msg_size);
 	int (*send_message)(struct scmi_chan_info *cinfo,
 			    struct scmi_xfer *xfer);
 	void (*mark_txdone)(struct scmi_chan_info *cinfo, int ret);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index d66f19b27c44..2e25f6f068f5 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -632,12 +632,21 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
 
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

