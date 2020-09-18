Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFDF2702B1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIRQzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:55:35 -0400
Received: from plasma31.jpberlin.de ([80.241.56.82]:9883 "EHLO
        plasma31.jpberlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIRQzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:55:35 -0400
Received: from spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122])
        by plasma.jpberlin.de (Postfix) with ESMTP id 8BABF100E7E;
        Fri, 18 Sep 2020 18:55:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.76])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id CuQEcevHF-1V; Fri, 18 Sep 2020 18:55:30 +0200 (CEST)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "*.opensynergy.com", Issuer "Starfield Secure Certificate Authority - G2" (not verified))
        (Authenticated sender: opensynergy@jpberlin.de)
        by plasma.jpberlin.de (Postfix) with ESMTPSA id 287B31018B5;
        Fri, 18 Sep 2020 18:55:30 +0200 (CEST)
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <sudeep.holla@arm.com>, <souvik.chakravarty@arm.com>,
        <alex.bennee@linaro.org>, <jean-philippe@linaro.org>,
        <igor.skalkin@opensynergy.com>, <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>,
        Peter Hilber <peter.hilber@opensynergy.com>
Subject: [RFC PATCH 4/7] firmware: arm_scmi: Add per message transport data
Date:   Fri, 18 Sep 2020 18:54:41 +0200
Message-ID: <20200918165441.256940-1-peter.hilber@opensynergy.com>
In-Reply-To: <20200918162311.254564-1-peter.hilber@opensynergy.com>
References: <20200918162311.254564-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.09 / 15.00 / 15.00
X-Rspamd-Queue-Id: 8BABF100E7E
X-Rspamd-UID: 9ae508
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Skalkin <igor.skalkin@opensynergy.com>

The virtio transport in this patch series can be simplified by using the
scmi_xfer tx/rx buffers for data exchange with the virtio device, and
for saving the message state. But the virtio transport requires
prepending a transport-specific header. Also, for data exchange using
virtqueues, the tx and rx buffers should not overlap.

The first step to solve the aforementioned issues is to add a
transport-specific data pointer to scmi_xfer.

Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
---
 drivers/firmware/arm_scmi/common.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 0f1540cb2d84..e3ccec954e93 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -131,6 +131,7 @@ struct scmi_msg {
  *	buffer for the rx path as we use for the tx path.
  * @done: command message transmit completion event
  * @async_done: pointer to delayed response message received event completion
+ * @extra_data: Transport-specific private data pointer
  */
 struct scmi_xfer {
 	int transfer_id;
@@ -139,6 +140,7 @@ struct scmi_xfer {
 	struct scmi_msg rx;
 	struct completion done;
 	struct completion *async_done;
+	void *extra_data;
 };
 
 void scmi_xfer_put(const struct scmi_handle *h, struct scmi_xfer *xfer);
-- 
2.25.1

