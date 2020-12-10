Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6B12D697A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 22:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393985AbgLJVLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 16:11:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393912AbgLJVLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 16:11:22 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Alon Mizrahi <amizrahi@habana.ai>
Subject: [PATCH] habanalabs: add validation cs counter, fix misplaced counters
Date:   Thu, 10 Dec 2020 23:10:36 +0200
Message-Id: <20201210211036.8237-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alon Mizrahi <amizrahi@habana.ai>

Up until now validation errors were counted in the parsing field
of the cs_counters struct, so we added a new counter and increased
it when needed.

In addition, there were some locations where only one of the counters
was updated (ctx or aggregate) so add the second one to be updated
as well.

Signed-off-by: Alon Mizrahi <amizrahi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 75 ++++++++++++++-----
 drivers/misc/habanalabs/common/habanalabs.h   |  2 +
 .../misc/habanalabs/common/habanalabs_ioctl.c |  5 ++
 include/uapi/misc/habanalabs.h                |  4 +
 4 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 92c1c516b65f..b2b3d2b0f808 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -472,8 +472,11 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	cntr = &hdev->aggregated_cs_counters;
 
 	cs = kzalloc(sizeof(*cs), GFP_ATOMIC);
-	if (!cs)
+	if (!cs) {
+		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
+		atomic64_inc(&cntr->out_of_mem_drop_cnt);
 		return -ENOMEM;
+	}
 
 	cs->ctx = ctx;
 	cs->submitted = false;
@@ -486,6 +489,8 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 
 	cs_cmpl = kmalloc(sizeof(*cs_cmpl), GFP_ATOMIC);
 	if (!cs_cmpl) {
+		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
+		atomic64_inc(&cntr->out_of_mem_drop_cnt);
 		rc = -ENOMEM;
 		goto free_cs;
 	}
@@ -513,6 +518,8 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	cs->jobs_in_queue_cnt = kcalloc(hdev->asic_prop.max_queues,
 			sizeof(*cs->jobs_in_queue_cnt), GFP_ATOMIC);
 	if (!cs->jobs_in_queue_cnt) {
+		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
+		atomic64_inc(&cntr->out_of_mem_drop_cnt);
 		rc = -ENOMEM;
 		goto free_fence;
 	}
@@ -764,11 +771,14 @@ static int hl_cs_sanity_checks(struct hl_fpriv *hpriv, union hl_cs_args *args)
 
 static int hl_cs_copy_chunk_array(struct hl_device *hdev,
 					struct hl_cs_chunk **cs_chunk_array,
-					void __user *chunks, u32 num_chunks)
+					void __user *chunks, u32 num_chunks,
+					struct hl_ctx *ctx)
 {
 	u32 size_to_copy;
 
 	if (num_chunks > HL_MAX_JOBS_PER_CS) {
+		atomic64_inc(&ctx->cs_counters.validation_drop_cnt);
+		atomic64_inc(&hdev->aggregated_cs_counters.validation_drop_cnt);
 		dev_err(hdev->dev,
 			"Number of chunks can NOT be larger than %d\n",
 			HL_MAX_JOBS_PER_CS);
@@ -777,11 +787,16 @@ static int hl_cs_copy_chunk_array(struct hl_device *hdev,
 
 	*cs_chunk_array = kmalloc_array(num_chunks, sizeof(**cs_chunk_array),
 					GFP_ATOMIC);
-	if (!*cs_chunk_array)
+	if (!*cs_chunk_array) {
+		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
+		atomic64_inc(&hdev->aggregated_cs_counters.out_of_mem_drop_cnt);
 		return -ENOMEM;
+	}
 
 	size_to_copy = num_chunks * sizeof(struct hl_cs_chunk);
 	if (copy_from_user(*cs_chunk_array, chunks, size_to_copy)) {
+		atomic64_inc(&ctx->cs_counters.validation_drop_cnt);
+		atomic64_inc(&hdev->aggregated_cs_counters.validation_drop_cnt);
 		dev_err(hdev->dev, "Failed to copy cs chunk array from user\n");
 		kfree(*cs_chunk_array);
 		return -EFAULT;
@@ -797,6 +812,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_cs_chunk *cs_chunk_array;
 	struct hl_cs_counters_atomic *cntr;
+	struct hl_ctx *ctx = hpriv->ctx;
 	struct hl_cs_job *job;
 	struct hl_cs *cs;
 	struct hl_cb *cb;
@@ -805,7 +821,8 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 	cntr = &hdev->aggregated_cs_counters;
 	*cs_seq = ULLONG_MAX;
 
-	rc = hl_cs_copy_chunk_array(hdev, &cs_chunk_array, chunks, num_chunks);
+	rc = hl_cs_copy_chunk_array(hdev, &cs_chunk_array, chunks, num_chunks,
+			hpriv->ctx);
 	if (rc)
 		goto out;
 
@@ -832,8 +849,8 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 		rc = validate_queue_index(hdev, chunk, &queue_type,
 						&is_kernel_allocated_cb);
 		if (rc) {
-			atomic64_inc(&hpriv->ctx->cs_counters.parsing_drop_cnt);
-			atomic64_inc(&cntr->parsing_drop_cnt);
+			atomic64_inc(&ctx->cs_counters.validation_drop_cnt);
+			atomic64_inc(&cntr->validation_drop_cnt);
 			goto free_cs_object;
 		}
 
@@ -841,8 +858,8 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 			cb = get_cb_from_cs_chunk(hdev, &hpriv->cb_mgr, chunk);
 			if (!cb) {
 				atomic64_inc(
-				&hpriv->ctx->cs_counters.parsing_drop_cnt);
-				atomic64_inc(&cntr->parsing_drop_cnt);
+					&ctx->cs_counters.validation_drop_cnt);
+				atomic64_inc(&cntr->validation_drop_cnt);
 				rc = -EINVAL;
 				goto free_cs_object;
 			}
@@ -856,8 +873,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 		job = hl_cs_allocate_job(hdev, queue_type,
 						is_kernel_allocated_cb);
 		if (!job) {
-			atomic64_inc(
-			&hpriv->ctx->cs_counters.out_of_mem_drop_cnt);
+			atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
 			atomic64_inc(&cntr->out_of_mem_drop_cnt);
 			dev_err(hdev->dev, "Failed to allocate a new job\n");
 			rc = -ENOMEM;
@@ -891,7 +907,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 
 		rc = cs_parser(hpriv, job);
 		if (rc) {
-			atomic64_inc(&hpriv->ctx->cs_counters.parsing_drop_cnt);
+			atomic64_inc(&ctx->cs_counters.parsing_drop_cnt);
 			atomic64_inc(&cntr->parsing_drop_cnt);
 			dev_err(hdev->dev,
 				"Failed to parse JOB %d.%llu.%d, err %d, rejecting the CS\n",
@@ -901,8 +917,8 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 	}
 
 	if (int_queues_only) {
-		atomic64_inc(&hpriv->ctx->cs_counters.parsing_drop_cnt);
-		atomic64_inc(&cntr->parsing_drop_cnt);
+		atomic64_inc(&ctx->cs_counters.validation_drop_cnt);
+		atomic64_inc(&cntr->validation_drop_cnt);
 		dev_err(hdev->dev,
 			"Reject CS %d.%llu because only internal queues jobs are present\n",
 			cs->ctx->asid, cs->sequence);
@@ -1042,7 +1058,7 @@ static int hl_cs_ctx_switch(struct hl_fpriv *hpriv, union hl_cs_args *args,
 }
 
 static int cs_ioctl_extract_signal_seq(struct hl_device *hdev,
-		struct hl_cs_chunk *chunk, u64 *signal_seq)
+		struct hl_cs_chunk *chunk, u64 *signal_seq, struct hl_ctx *ctx)
 {
 	u64 *signal_seq_arr = NULL;
 	u32 size_to_copy, signal_seq_arr_len;
@@ -1052,6 +1068,8 @@ static int cs_ioctl_extract_signal_seq(struct hl_device *hdev,
 
 	/* currently only one signal seq is supported */
 	if (signal_seq_arr_len != 1) {
+		atomic64_inc(&ctx->cs_counters.validation_drop_cnt);
+		atomic64_inc(&hdev->aggregated_cs_counters.validation_drop_cnt);
 		dev_err(hdev->dev,
 			"Wait for signal CS supports only one signal CS seq\n");
 		return -EINVAL;
@@ -1060,13 +1078,18 @@ static int cs_ioctl_extract_signal_seq(struct hl_device *hdev,
 	signal_seq_arr = kmalloc_array(signal_seq_arr_len,
 					sizeof(*signal_seq_arr),
 					GFP_ATOMIC);
-	if (!signal_seq_arr)
+	if (!signal_seq_arr) {
+		atomic64_inc(&ctx->cs_counters.out_of_mem_drop_cnt);
+		atomic64_inc(&hdev->aggregated_cs_counters.out_of_mem_drop_cnt);
 		return -ENOMEM;
+	}
 
 	size_to_copy = chunk->num_signal_seq_arr * sizeof(*signal_seq_arr);
 	if (copy_from_user(signal_seq_arr,
 				u64_to_user_ptr(chunk->signal_seq_arr),
 				size_to_copy)) {
+		atomic64_inc(&ctx->cs_counters.validation_drop_cnt);
+		atomic64_inc(&hdev->aggregated_cs_counters.validation_drop_cnt);
 		dev_err(hdev->dev,
 			"Failed to copy signal seq array from user\n");
 		rc = -EFAULT;
@@ -1153,6 +1176,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_cs_compl *sig_waitcs_cmpl;
 	u32 q_idx, collective_engine_id = 0;
+	struct hl_cs_counters_atomic *cntr;
 	struct hl_fence *sig_fence = NULL;
 	struct hl_ctx *ctx = hpriv->ctx;
 	enum hl_queue_type q_type;
@@ -1160,9 +1184,11 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	u64 signal_seq;
 	int rc;
 
+	cntr = &hdev->aggregated_cs_counters;
 	*cs_seq = ULLONG_MAX;
 
-	rc = hl_cs_copy_chunk_array(hdev, &cs_chunk_array, chunks, num_chunks);
+	rc = hl_cs_copy_chunk_array(hdev, &cs_chunk_array, chunks, num_chunks,
+			ctx);
 	if (rc)
 		goto out;
 
@@ -1170,6 +1196,8 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	chunk = &cs_chunk_array[0];
 
 	if (chunk->queue_index >= hdev->asic_prop.max_queues) {
+		atomic64_inc(&ctx->cs_counters.validation_drop_cnt);
+		atomic64_inc(&cntr->validation_drop_cnt);
 		dev_err(hdev->dev, "Queue index %d is invalid\n",
 			chunk->queue_index);
 		rc = -EINVAL;
@@ -1181,6 +1209,8 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	q_type = hw_queue_prop->type;
 
 	if (!hw_queue_prop->supports_sync_stream) {
+		atomic64_inc(&ctx->cs_counters.validation_drop_cnt);
+		atomic64_inc(&cntr->validation_drop_cnt);
 		dev_err(hdev->dev,
 			"Queue index %d does not support sync stream operations\n",
 			q_idx);
@@ -1190,6 +1220,8 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 
 	if (cs_type == CS_TYPE_COLLECTIVE_WAIT) {
 		if (!(hw_queue_prop->collective_mode == HL_COLLECTIVE_MASTER)) {
+			atomic64_inc(&ctx->cs_counters.validation_drop_cnt);
+			atomic64_inc(&cntr->validation_drop_cnt);
 			dev_err(hdev->dev,
 				"Queue index %d is invalid\n", q_idx);
 			rc = -EINVAL;
@@ -1200,12 +1232,14 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	}
 
 	if (cs_type == CS_TYPE_WAIT || cs_type == CS_TYPE_COLLECTIVE_WAIT) {
-		rc = cs_ioctl_extract_signal_seq(hdev, chunk, &signal_seq);
+		rc = cs_ioctl_extract_signal_seq(hdev, chunk, &signal_seq, ctx);
 		if (rc)
 			goto free_cs_chunk_array;
 
 		sig_fence = hl_ctx_get_fence(ctx, signal_seq);
 		if (IS_ERR(sig_fence)) {
+			atomic64_inc(&ctx->cs_counters.validation_drop_cnt);
+			atomic64_inc(&cntr->validation_drop_cnt);
 			dev_err(hdev->dev,
 				"Failed to get signal CS with seq 0x%llx\n",
 				signal_seq);
@@ -1223,6 +1257,8 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 			container_of(sig_fence, struct hl_cs_compl, base_fence);
 
 		if (sig_waitcs_cmpl->type != CS_TYPE_SIGNAL) {
+			atomic64_inc(&ctx->cs_counters.validation_drop_cnt);
+			atomic64_inc(&cntr->validation_drop_cnt);
 			dev_err(hdev->dev,
 				"CS seq 0x%llx is not of a signal CS\n",
 				signal_seq);
@@ -1270,8 +1306,11 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	else if (cs_type == CS_TYPE_COLLECTIVE_WAIT)
 		rc = hdev->asic_funcs->collective_wait_create_jobs(hdev, ctx,
 				cs, q_idx, collective_engine_id);
-	else
+	else {
+		atomic64_inc(&ctx->cs_counters.validation_drop_cnt);
+		atomic64_inc(&cntr->validation_drop_cnt);
 		rc = -EINVAL;
+	}
 
 	if (rc)
 		goto free_cs_object;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 70b778a0d60e..e0d7f5fbaa5c 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1000,6 +1000,7 @@ struct hl_va_range {
  * @queue_full_drop_cnt: dropped due to queue full
  * @device_in_reset_drop_cnt: dropped due to device in reset
  * @max_cs_in_flight_drop_cnt: dropped due to maximum CS in-flight
+ * @validation_drop_cnt: dropped due to error in validation
  */
 struct hl_cs_counters_atomic {
 	atomic64_t out_of_mem_drop_cnt;
@@ -1007,6 +1008,7 @@ struct hl_cs_counters_atomic {
 	atomic64_t queue_full_drop_cnt;
 	atomic64_t device_in_reset_drop_cnt;
 	atomic64_t max_cs_in_flight_drop_cnt;
+	atomic64_t validation_drop_cnt;
 };
 
 /**
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index a0c0d20f6f8f..12efbd9d2e3a 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -335,6 +335,8 @@ static int cs_counters_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 			atomic64_read(&cntr->device_in_reset_drop_cnt);
 	cs_counters.total_max_cs_in_flight_drop_cnt =
 			atomic64_read(&cntr->max_cs_in_flight_drop_cnt);
+	cs_counters.total_validation_drop_cnt =
+			atomic64_read(&cntr->validation_drop_cnt);
 
 	if (hpriv->ctx) {
 		cs_counters.ctx_out_of_mem_drop_cnt =
@@ -352,6 +354,9 @@ static int cs_counters_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 		cs_counters.ctx_max_cs_in_flight_drop_cnt =
 				atomic64_read(
 			&hpriv->ctx->cs_counters.max_cs_in_flight_drop_cnt);
+		cs_counters.ctx_validation_drop_cnt =
+				atomic64_read(
+				&hpriv->ctx->cs_counters.validation_drop_cnt);
 	}
 
 	return copy_to_user(out, &cs_counters,
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index dc8bcec195cc..dba3827c43ca 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -426,6 +426,8 @@ struct hl_info_sync_manager {
  * @ctx_device_in_reset_drop_cnt: context dropped due to device in reset
  * @total_max_cs_in_flight_drop_cnt: total dropped due to maximum CS in-flight
  * @ctx_max_cs_in_flight_drop_cnt: context dropped due to maximum CS in-flight
+ * @total_validation_drop_cnt: total dropped due to validation error
+ * @ctx_validation_drop_cnt: context dropped due to validation error
  */
 struct hl_info_cs_counters {
 	__u64 total_out_of_mem_drop_cnt;
@@ -438,6 +440,8 @@ struct hl_info_cs_counters {
 	__u64 ctx_device_in_reset_drop_cnt;
 	__u64 total_max_cs_in_flight_drop_cnt;
 	__u64 ctx_max_cs_in_flight_drop_cnt;
+	__u64 total_validation_drop_cnt;
+	__u64 ctx_validation_drop_cnt;
 };
 
 enum gaudi_dcores {
-- 
2.17.1

