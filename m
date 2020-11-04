Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2EE2A6602
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgKDOKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:10:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730114AbgKDOJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:09:33 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A2D2223AB;
        Wed,  4 Nov 2020 14:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604498972;
        bh=Zddzj5dYtUo29tQf9SWXibxuKbG4QMbW43K4a8N4BcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G36xsSl859n7ohHp7srvImhCqVaYdV813luX602iR2GuGmBnVuvY3m21N0BAfJ6kl
         IMv1XyCjVcMjYhjlsESD5XwfrCuUFXANnwrzxUYollQXINB2tGz5ojT4Wk7qQANPzw
         EKmYcMGP4OxWuSXg3sosIkYmL8goyfrMsMU331E0=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH] habanalabs: Separate CS job completion from its deallocation
Date:   Wed,  4 Nov 2020 16:09:06 +0200
Message-Id: <20201104140908.10178-10-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104140908.10178-1-ogabbay@kernel.org>
References: <20201104140908.10178-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Current CS jobs are no longer needed after their completion.
However, jobs of future workload might be in use even after they are
completed. To allow that, the patch adds a refcount to the job object,
and decouples its completion handling from its deallocation.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 25 ++++++++++++++-----
 drivers/misc/habanalabs/common/debugfs.c      | 13 +++++-----
 drivers/misc/habanalabs/common/habanalabs.h   |  2 ++
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 6de4b161856c..662b19663839 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -155,6 +155,18 @@ static void cs_put(struct hl_cs *cs)
 	kref_put(&cs->refcount, cs_do_release);
 }
 
+static void cs_job_do_release(struct kref *ref)
+{
+	struct hl_cs_job *job = container_of(ref, struct hl_cs_job, refcount);
+
+	kfree(job);
+}
+
+static void cs_job_put(struct hl_cs_job *job)
+{
+	kref_put(&job->refcount, cs_job_do_release);
+}
+
 static bool is_cb_patched(struct hl_device *hdev, struct hl_cs_job *job)
 {
 	/*
@@ -227,7 +239,7 @@ static int cs_parser(struct hl_fpriv *hpriv, struct hl_cs_job *job)
 	return rc;
 }
 
-static void free_job(struct hl_device *hdev, struct hl_cs_job *job)
+static void complete_job(struct hl_device *hdev, struct hl_cs_job *job)
 {
 	struct hl_cs *cs = job->cs;
 
@@ -276,7 +288,7 @@ static void free_job(struct hl_device *hdev, struct hl_cs_job *job)
 			job->queue_type == QUEUE_TYPE_HW)
 		cs_put(cs);
 
-	kfree(job);
+	cs_job_put(job);
 }
 
 static void cs_do_release(struct kref *ref)
@@ -290,13 +302,13 @@ static void cs_do_release(struct kref *ref)
 	/*
 	 * Although if we reached here it means that all external jobs have
 	 * finished, because each one of them took refcnt to CS, we still
-	 * need to go over the internal jobs and free them. Otherwise, we
+	 * need to go over the internal jobs and complete them. Otherwise, we
 	 * will have leaked memory and what's worse, the CS object (and
 	 * potentially the CTX object) could be released, while the JOB
 	 * still holds a pointer to them (but no reference).
 	 */
 	list_for_each_entry_safe(job, tmp, &cs->job_list, cs_node)
-		free_job(hdev, job);
+		complete_job(hdev, job);
 
 	if (!cs->submitted) {
 		/* In case the wait for signal CS was submitted, the put occurs
@@ -507,7 +519,7 @@ static void cs_rollback(struct hl_device *hdev, struct hl_cs *cs)
 	struct hl_cs_job *job, *tmp;
 
 	list_for_each_entry_safe(job, tmp, &cs->job_list, cs_node)
-		free_job(hdev, job);
+		complete_job(hdev, job);
 }
 
 void hl_cs_rollback_all(struct hl_device *hdev)
@@ -539,7 +551,7 @@ static void job_wq_completion(struct work_struct *work)
 	struct hl_device *hdev = cs->ctx->hdev;
 
 	/* job is no longer needed */
-	free_job(hdev, job);
+	complete_job(hdev, job);
 }
 
 static int validate_queue_index(struct hl_device *hdev,
@@ -647,6 +659,7 @@ struct hl_cs_job *hl_cs_allocate_job(struct hl_device *hdev,
 	if (!job)
 		return NULL;
 
+	kref_init(&job->refcount);
 	job->queue_type = queue_type;
 	job->is_kernel_allocated_cb = is_kernel_allocated_cb;
 
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 912ddfa360b1..b44193ec3d12 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -168,18 +168,19 @@ static int command_submission_jobs_show(struct seq_file *s, void *data)
 		if (first) {
 			first = false;
 			seq_puts(s, "\n");
-			seq_puts(s, " JOB ID   CS ID    CTX ASID   H/W Queue\n");
-			seq_puts(s, "---------------------------------------\n");
+			seq_puts(s, " JOB ID   CS ID    CTX ASID   JOB RefCnt   H/W Queue\n");
+			seq_puts(s, "----------------------------------------------------\n");
 		}
 		if (job->cs)
 			seq_printf(s,
-				"    %02d       %llu         %d         %d\n",
+				"   %02d      %llu        %d          %d           %d\n",
 				job->id, job->cs->sequence, job->cs->ctx->asid,
-				job->hw_queue_id);
+				kref_read(&job->refcount), job->hw_queue_id);
 		else
 			seq_printf(s,
-				"    %02d       0         %d         %d\n",
-				job->id, HL_KERNEL_ASID_ID, job->hw_queue_id);
+				"   %02d      0        %d          %d           %d\n",
+				job->id, HL_KERNEL_ASID_ID,
+				kref_read(&job->refcount), job->hw_queue_id);
 	}
 
 	spin_unlock(&dev_entry->cs_job_spinlock);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 227f1a9552a6..2e3021adc824 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1142,6 +1142,7 @@ struct hl_cs {
  * @userptr_list: linked-list of userptr mappings that belong to this job and
  *			wait for completion.
  * @debugfs_list: node in debugfs list of command submission jobs.
+ * @refcount: reference counter for usage of the CS job.
  * @queue_type: the type of the H/W queue this job is submitted to.
  * @id: the id of this job inside a CS.
  * @hw_queue_id: the id of the H/W queue this job is submitted to.
@@ -1165,6 +1166,7 @@ struct hl_cs_job {
 	struct work_struct	finish_work;
 	struct list_head	userptr_list;
 	struct list_head	debugfs_list;
+	struct kref		refcount;
 	enum hl_queue_type	queue_type;
 	u32			id;
 	u32			hw_queue_id;
-- 
2.17.1

