Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359302A65FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbgKDOKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:10:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:37796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730139AbgKDOJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:09:34 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8883223BD;
        Wed,  4 Nov 2020 14:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604498974;
        bh=oqi/1AeJXFRea73PjIiA42SQZSDLRDeYDOWMlP0y20I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cDWBXFyoj+HrH5wsE7XLeNMngestyDFPfd+yRpJWwYa/xE1mJ+vTnqcmPSPPXC7eI
         xRv0ztRrzmABNAY6228xzEQo5QgmNHpZecXWfQdTtwkhmJGbaWiQuS7bg5gJ5dB8qe
         c4b0kbBj7AAmtdfpsE6xxdy4mPwkcYBuDgzJckDs=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH] habanalabs: Skip updating CI of internal queues if not in use
Date:   Wed,  4 Nov 2020 16:09:07 +0200
Message-Id: <20201104140908.10178-11-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104140908.10178-1-ogabbay@kernel.org>
References: <20201104140908.10178-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

There are no internal queues if H/W queues are being used.
In this case we can skip the redundant traversal over the queues array,
looking for internal queues.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/hw_queue.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 239e2ba0545f..84a7458f3363 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -48,6 +48,11 @@ void hl_int_hw_queue_update_ci(struct hl_cs *cs)
 		return;
 
 	q = &hdev->kernel_queues[0];
+
+	/* There are no internal queues if H/W queues are being used */
+	if (!hdev->asic_prop.max_queues || q->queue_type == QUEUE_TYPE_HW)
+		return;
+
 	for (i = 0 ; i < hdev->asic_prop.max_queues ; i++, q++) {
 		if (q->queue_type == QUEUE_TYPE_INT)
 			atomic_add(cs->jobs_in_queue_cnt[i], &q->ci);
-- 
2.17.1

