Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934332CFEAE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 21:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgLEUIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 15:08:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgLEUIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 15:08:39 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Alon Mizrahi <amizrahi@habana.ai>
Subject: [PATCH] habanalabs/gaudi: do not set EB in collective slave queues
Date:   Sat,  5 Dec 2020 22:07:51 +0200
Message-Id: <20201205200752.1468-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alon Mizrahi <amizrahi@habana.ai>

We don't need to set EB on signal packets from collective slave
queues as it degrades performance. Because the slaves are the network
queues, the engine barrier doesn't actually guarantee that the
packet has been sent.

Signed-off-by: Alon Mizrahi <amizrahi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 2 +-
 drivers/misc/habanalabs/common/hw_queue.c   | 5 ++++-
 drivers/misc/habanalabs/gaudi/gaudi.c       | 8 ++++----
 drivers/misc/habanalabs/goya/goya.c         | 2 +-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 571eda6ef5ab..70b778a0d60e 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -944,7 +944,7 @@ struct hl_asic_funcs {
 	u32 (*get_signal_cb_size)(struct hl_device *hdev);
 	u32 (*get_wait_cb_size)(struct hl_device *hdev);
 	u32 (*gen_signal_cb)(struct hl_device *hdev, void *data, u16 sob_id,
-			u32 size);
+			u32 size, bool eb);
 	u32 (*gen_wait_cb)(struct hl_device *hdev,
 			struct hl_gen_wait_properties *prop);
 	void (*reset_sob)(struct hl_device *hdev, void *data);
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 7caf868d1585..76217258780a 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -418,8 +418,11 @@ static void init_signal_cs(struct hl_device *hdev,
 		"generate signal CB, sob_id: %d, sob val: 0x%x, q_idx: %d\n",
 		cs_cmpl->hw_sob->sob_id, cs_cmpl->sob_val, q_idx);
 
+	/* we set an EB since we must make sure all oeprations are done
+	 * when sending the signal
+	 */
 	hdev->asic_funcs->gen_signal_cb(hdev, job->patched_cb,
-				cs_cmpl->hw_sob->sob_id, 0);
+				cs_cmpl->hw_sob->sob_id, 0, true);
 
 	kref_get(&hw_sob->kref);
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index e465c158eaeb..65895ba075fe 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -361,7 +361,7 @@ static int gaudi_cpucp_info_get(struct hl_device *hdev);
 static void gaudi_disable_clock_gating(struct hl_device *hdev);
 static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid);
 static u32 gaudi_gen_signal_cb(struct hl_device *hdev, void *data, u16 sob_id,
-				u32 size);
+				u32 size, bool eb);
 static u32 gaudi_gen_wait_cb(struct hl_device *hdev,
 				struct hl_gen_wait_properties *prop);
 
@@ -1064,7 +1064,7 @@ static void gaudi_collective_slave_init_job(struct hl_device *hdev,
 		prop->collective_sob_id, queue_id);
 
 	cb_size += gaudi_gen_signal_cb(hdev, job->user_cb,
-			prop->collective_sob_id, cb_size);
+			prop->collective_sob_id, cb_size, false);
 }
 
 static void gaudi_collective_wait_init_cs(struct hl_cs *cs)
@@ -7893,7 +7893,7 @@ static u32 gaudi_get_wait_cb_size(struct hl_device *hdev)
 }
 
 static u32 gaudi_gen_signal_cb(struct hl_device *hdev, void *data, u16 sob_id,
-				u32 size)
+				u32 size, bool eb)
 {
 	struct hl_cb *cb = (struct hl_cb *) data;
 	struct packet_msg_short *pkt;
@@ -7910,7 +7910,7 @@ static u32 gaudi_gen_signal_cb(struct hl_device *hdev, void *data, u16 sob_id,
 	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_OP_MASK, 0); /* write the value */
 	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_BASE_MASK, 3); /* W_S SOB base */
 	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_OPCODE_MASK, PACKET_MSG_SHORT);
-	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_EB_MASK, 1);
+	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_EB_MASK, eb);
 	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_RB_MASK, 1);
 	ctl |= FIELD_PREP(GAUDI_PKT_SHORT_CTL_MB_MASK, 1);
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index d61177bf36a5..b8b4aa636b7c 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5339,7 +5339,7 @@ static u32 goya_get_wait_cb_size(struct hl_device *hdev)
 }
 
 static u32 goya_gen_signal_cb(struct hl_device *hdev, void *data, u16 sob_id,
-		u32 size)
+				u32 size, bool eb)
 {
 	return 0;
 }
-- 
2.17.1

