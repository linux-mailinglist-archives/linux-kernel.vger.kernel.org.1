Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D532D05EE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 17:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgLFQ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 11:29:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:44380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgLFQ3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 11:29:22 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/2] habanalabs/gaudi: support CS with no completion
Date:   Sun,  6 Dec 2020 18:28:31 +0200
Message-Id: <20201206162835.4088-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201206162835.4088-1-ogabbay@kernel.org>
References: <20201206162835.4088-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

As part of the staged submission feature, we need Gaudi to support
command submissions that will never get a completion.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c |  1 +
 drivers/misc/habanalabs/common/habanalabs.h         |  2 ++
 drivers/misc/habanalabs/gaudi/gaudi.c               | 10 +++++++---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 92c1c516b65f..ac527682cd8c 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -225,6 +225,7 @@ static int cs_parser(struct hl_fpriv *hpriv, struct hl_cs_job *job)
 	parser.queue_type = job->queue_type;
 	parser.is_kernel_allocated_cb = job->is_kernel_allocated_cb;
 	job->patched_cb = NULL;
+	parser.completion = true;
 
 	rc = hdev->asic_funcs->cs_parser(hdev, &parser);
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 270d342f7778..81a16d4f8cba 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1221,6 +1221,7 @@ struct hl_cs_job {
  *                    MSG_PROT packets. Relevant only for GAUDI as GOYA doesn't
  *                    have streams so the engine can't be busy by another
  *                    stream.
+ * @completion: true if we need completion for this CS.
  */
 struct hl_cs_parser {
 	struct hl_cb		*user_cb;
@@ -1235,6 +1236,7 @@ struct hl_cs_parser {
 	u8			job_id;
 	u8			is_kernel_allocated_cb;
 	u8			contains_dma_pkt;
+	u8			completion;
 };
 
 /*
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 658d180d3d4d..076a55ebf357 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5041,7 +5041,8 @@ static int gaudi_validate_cb(struct hl_device *hdev,
 	 * 1. A packet that will act as a completion packet
 	 * 2. A packet that will generate MSI-X interrupt
 	 */
-	parser->patched_cb_size += sizeof(struct packet_msg_prot) * 2;
+	if (parser->completion)
+		parser->patched_cb_size += sizeof(struct packet_msg_prot) * 2;
 
 	return rc;
 }
@@ -5268,8 +5269,11 @@ static int gaudi_parse_cb_mmu(struct hl_device *hdev,
 	 * 1. A packet that will act as a completion packet
 	 * 2. A packet that will generate MSI interrupt
 	 */
-	parser->patched_cb_size = parser->user_cb_size +
-			sizeof(struct packet_msg_prot) * 2;
+	if (parser->completion)
+		parser->patched_cb_size = parser->user_cb_size +
+				sizeof(struct packet_msg_prot) * 2;
+	else
+		parser->patched_cb_size = parser->user_cb_size;
 
 	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, hdev->kernel_ctx,
 				parser->patched_cb_size, false, false,
-- 
2.17.1

