Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F012C754C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbgK1WXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 17:23:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733271AbgK1WXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 17:23:00 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23F37223AB;
        Sat, 28 Nov 2020 22:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606602139;
        bh=9nU3KnBCN7aV20qN7YSHs9wP9eIqFrcKEEGIkh8OfW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z5/i8/RRqhoulkA+WmRXdh33lCY8lJpXyFI9iIas8vlm/Bb6jEuTlG+xXGS8FRZHH
         qwrZI82eOH0Q0qeeOxoraUg2viwfS7VFqMtZGZjiA88P4E5sFxxGgurXYrwW0O+2Su
         qkUgm6131cDwuL6YU5r+oQUkKfweSwti3w642qBE=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH] habanalabs: Modify the cs_cnt of a CB to be atomic
Date:   Sun, 29 Nov 2020 00:22:07 +0200
Message-Id: <20201128222207.23722-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201128222207.23722-1-ogabbay@kernel.org>
References: <20201128222207.23722-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Modify the CS counter of a CB to be atomic, so no locking is required
when it is being modified or read.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 29 +++++--------------
 drivers/misc/habanalabs/common/debugfs.c      |  2 +-
 drivers/misc/habanalabs/common/habanalabs.h   |  4 +--
 drivers/misc/habanalabs/gaudi/gaudi.c         | 10 +++----
 drivers/misc/habanalabs/goya/goya.c           |  4 +--
 5 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index dc85ed6ab525..beb482310a58 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -233,10 +233,7 @@ static int cs_parser(struct hl_fpriv *hpriv, struct hl_cs_job *job)
 			job->patched_cb = parser.patched_cb;
 			job->job_cb_size = parser.patched_cb_size;
 			job->contains_dma_pkt = parser.contains_dma_pkt;
-
-			spin_lock(&job->patched_cb->lock);
-			job->patched_cb->cs_cnt++;
-			spin_unlock(&job->patched_cb->lock);
+			atomic_inc(&job->patched_cb->cs_cnt);
 		}
 
 		/*
@@ -244,9 +241,7 @@ static int cs_parser(struct hl_fpriv *hpriv, struct hl_cs_job *job)
 		 * original CB anymore because it was already parsed and
 		 * won't be accessed again for this CS
 		 */
-		spin_lock(&job->user_cb->lock);
-		job->user_cb->cs_cnt--;
-		spin_unlock(&job->user_cb->lock);
+		atomic_dec(&job->user_cb->cs_cnt);
 		hl_cb_put(job->user_cb);
 		job->user_cb = NULL;
 	} else if (!rc) {
@@ -268,10 +263,7 @@ static void complete_job(struct hl_device *hdev, struct hl_cs_job *job)
 		 * created, so we need to check it's not NULL
 		 */
 		if (job->patched_cb) {
-			spin_lock(&job->patched_cb->lock);
-			job->patched_cb->cs_cnt--;
-			spin_unlock(&job->patched_cb->lock);
-
+			atomic_dec(&job->patched_cb->cs_cnt);
 			hl_cb_put(job->patched_cb);
 		}
 	}
@@ -284,10 +276,7 @@ static void complete_job(struct hl_device *hdev, struct hl_cs_job *job)
 	if (job->is_kernel_allocated_cb &&
 		((job->queue_type == QUEUE_TYPE_HW && hdev->mmu_enable) ||
 				job->queue_type == QUEUE_TYPE_INT)) {
-		spin_lock(&job->user_cb->lock);
-		job->user_cb->cs_cnt--;
-		spin_unlock(&job->user_cb->lock);
-
+		atomic_dec(&job->user_cb->cs_cnt);
 		hl_cb_put(job->user_cb);
 	}
 
@@ -680,9 +669,7 @@ static struct hl_cb *get_cb_from_cs_chunk(struct hl_device *hdev,
 		goto release_cb;
 	}
 
-	spin_lock(&cb->lock);
-	cb->cs_cnt++;
-	spin_unlock(&cb->lock);
+	atomic_inc(&cb->cs_cnt);
 
 	return cb;
 
@@ -936,9 +923,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 	goto put_cs;
 
 release_cb:
-	spin_lock(&cb->lock);
-	cb->cs_cnt--;
-	spin_unlock(&cb->lock);
+	atomic_dec(&cb->cs_cnt);
 	hl_cb_put(cb);
 free_cs_object:
 	cs_rollback(hdev, cs);
@@ -1133,7 +1118,7 @@ static int cs_ioctl_signal_wait_create_jobs(struct hl_device *hdev,
 	job->id = 0;
 	job->cs = cs;
 	job->user_cb = cb;
-	job->user_cb->cs_cnt++;
+	atomic_inc(&job->user_cb->cs_cnt);
 	job->user_cb_size = cb_size;
 	job->hw_queue_id = q_idx;
 
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index b47a62da0b41..cef716643979 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -116,7 +116,7 @@ static int command_buffers_show(struct seq_file *s, void *data)
 			"   %03llu        %d    0x%08x      %d          %d          %d\n",
 			cb->id, cb->ctx->asid, cb->size,
 			kref_read(&cb->refcount),
-			cb->mmap, cb->cs_cnt);
+			cb->mmap, atomic_read(&cb->cs_cnt));
 	}
 
 	spin_unlock(&dev_entry->cb_spinlock);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 8e2d164d97e8..571eda6ef5ab 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -532,7 +532,7 @@ struct hl_cb_mgr {
  * @refcount: reference counter for usage of the CB.
  * @hdev: pointer to device this CB belongs to.
  * @ctx: pointer to the CB owner's context.
- * @lock: spinlock to protect mmap/cs flows.
+ * @lock: spinlock to protect mmap flows.
  * @debugfs_list: node in debugfs list of command buffers.
  * @pool_list: node in pool list of command buffers.
  * @va_block_list: list of virtual addresses blocks of the CB if it is mapped to
@@ -561,7 +561,7 @@ struct hl_cb {
 	dma_addr_t		bus_address;
 	u32			mmap_size;
 	u32			size;
-	u32			cs_cnt;
+	atomic_t		cs_cnt;
 	u8			mmap;
 	u8			is_pool;
 	u8			is_internal;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index aac3c9c5a2e0..1f1926607c5e 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -838,7 +838,7 @@ static int _gaudi_init_tpc_mem(struct hl_device *hdev,
 
 	job->id = 0;
 	job->user_cb = cb;
-	job->user_cb->cs_cnt++;
+	atomic_inc(&job->user_cb->cs_cnt);
 	job->user_cb_size = cb_size;
 	job->hw_queue_id = GAUDI_QUEUE_ID_DMA_0_0;
 	job->patched_cb = job->user_cb;
@@ -861,7 +861,7 @@ static int _gaudi_init_tpc_mem(struct hl_device *hdev,
 	hl_userptr_delete_list(hdev, &job->userptr_list);
 	hl_debugfs_remove_job(hdev, job);
 	kfree(job);
-	cb->cs_cnt--;
+	atomic_dec(&cb->cs_cnt);
 
 release_cb:
 	hl_cb_put(cb);
@@ -1248,7 +1248,7 @@ static int gaudi_collective_wait_create_job(struct hl_device *hdev,
 	job->id = 0;
 	job->cs = cs;
 	job->user_cb = cb;
-	job->user_cb->cs_cnt++;
+	atomic_inc(&job->user_cb->cs_cnt);
 	job->user_cb_size = cb_size;
 	job->hw_queue_id = queue_id;
 
@@ -5570,7 +5570,7 @@ static int gaudi_memset_device_memory(struct hl_device *hdev, u64 addr,
 
 	job->id = 0;
 	job->user_cb = cb;
-	job->user_cb->cs_cnt++;
+	atomic_inc(&job->user_cb->cs_cnt);
 	job->user_cb_size = cb_size;
 	job->hw_queue_id = GAUDI_QUEUE_ID_DMA_0_0;
 	job->patched_cb = job->user_cb;
@@ -5581,7 +5581,7 @@ static int gaudi_memset_device_memory(struct hl_device *hdev, u64 addr,
 	rc = gaudi_send_job_on_qman0(hdev, job);
 	hl_debugfs_remove_job(hdev, job);
 	kfree(job);
-	cb->cs_cnt--;
+	atomic_dec(&cb->cs_cnt);
 
 	/* Verify DMA is OK */
 	err_cause = RREG32(mmDMA0_CORE_ERR_CAUSE);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 5e151610c1c8..3e5eb9e3d7bd 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4811,7 +4811,7 @@ static int goya_memset_device_memory(struct hl_device *hdev, u64 addr, u64 size,
 
 	job->id = 0;
 	job->user_cb = cb;
-	job->user_cb->cs_cnt++;
+	atomic_inc(&job->user_cb->cs_cnt);
 	job->user_cb_size = cb_size;
 	job->hw_queue_id = GOYA_QUEUE_ID_DMA_0;
 	job->patched_cb = job->user_cb;
@@ -4823,7 +4823,7 @@ static int goya_memset_device_memory(struct hl_device *hdev, u64 addr, u64 size,
 
 	hl_debugfs_remove_job(hdev, job);
 	kfree(job);
-	cb->cs_cnt--;
+	atomic_dec(&cb->cs_cnt);
 
 release_cb:
 	hl_cb_put(cb);
-- 
2.17.1

