Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B5A2A34AF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgKBT6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:58:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbgKBT6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:58:16 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2709322275;
        Mon,  2 Nov 2020 19:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604347096;
        bh=BIBocCu38J/SSAG+UJa0YL9z7UrRUB56t1CJJQiwnRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uy4Cw6Mw3m3VYt3cUOtuBHYzv/QN3KyjgvV0taXcRMT07Lus65XaihN5AoSYTSb7p
         /hyQmneGLnM9u33Eze/YjAdznfGn7iEcgQgMf2Ws+eqCiEKrM/XZJirn1R2G5LK+nU
         EMXxR1ae2i7ftqoU4YLEMycbHpT2ynABkrKiT/J0=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH 4/4] habanalabs: remove duplicate check
Date:   Mon,  2 Nov 2020 21:58:02 +0200
Message-Id: <20201102195802.10608-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102195802.10608-1-ogabbay@kernel.org>
References: <20201102195802.10608-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already check if queue index is smaller than max queues a few lines
above this check so no need to check this again.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index b0f33579ca7f..1f8b53d42e3a 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -948,9 +948,10 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	hw_queue_prop = &hdev->asic_prop.hw_queues_props[q_idx];
 	q_type = hw_queue_prop->type;
 
-	if ((q_idx >= hdev->asic_prop.max_queues) ||
-			(!hw_queue_prop->supports_sync_stream)) {
-		dev_err(hdev->dev, "Queue index %d is invalid\n", q_idx);
+	if (!hw_queue_prop->supports_sync_stream) {
+		dev_err(hdev->dev,
+			"Queue index %d does not support sync stream operations\n",
+			q_idx);
 		rc = -EINVAL;
 		goto free_cs_chunk_array;
 	}
-- 
2.17.1

