Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C132A5FB7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgKDIgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:36:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728535AbgKDIgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:36:41 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 947E620732;
        Wed,  4 Nov 2020 08:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604479000;
        bh=aM6GYUUUSCwRmYqFxuqWvV2y7ZDpTmXHznooYQn8r/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cd9/AXOY2dwAuZprbykQfUA7fTapAf0yPQZWFvES6Uu8YV2OyTyVQj4gIK4F8KS74
         5cs7Ohcx1QYVZNtsJn30SlJceq1jn2BvF3RUQBHlE2MW5oCCc4oT9HyDvGIP5DzeCA
         wt2hGAgKKpc75N9yByyeFweCQdXZn5RsuN2ayyrs=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs/gaudi: monitor device memory usage
Date:   Wed,  4 Nov 2020 10:36:26 +0200
Message-Id: <20201104083630.28402-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104083630.28402-1-ogabbay@kernel.org>
References: <20201104083630.28402-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In GAUDI we don't have an MMU towards the HBM device memory. Therefore,
the user access that memory directly through physical address (via the
different engines) without the need to go through the driver to
allocate/free memory on the HBM.

For system monitoring purposes, the driver will keep track of the HBM
usage. This can be done as long as the user accurately reports the
allocations and releases of HBM memory, through the existing MEMORY
IOCTL uapi.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 56 ++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 75dd18771868..f885812d9939 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1236,18 +1236,35 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 
 	switch (args->in.op) {
 	case HL_MEM_OP_ALLOC:
-		if (!hdev->dram_supports_virtual_memory) {
-			dev_err(hdev->dev, "DRAM alloc is not supported\n");
-			rc = -EINVAL;
-			goto out;
-		}
-
 		if (args->in.alloc.mem_size == 0) {
 			dev_err(hdev->dev,
 				"alloc size must be larger than 0\n");
 			rc = -EINVAL;
 			goto out;
 		}
+
+		/* If DRAM does not support virtual memory the driver won't
+		 * handle the allocation/freeing of that memory. However, for
+		 * system administration/monitoring purposes, the driver will
+		 * keep track of the amount of DRAM memory that is allocated
+		 * and freed by the user. Because this code totally relies on
+		 * the user's input, the driver can't ensure the validity
+		 * of this accounting.
+		 */
+		if (!hdev->dram_supports_virtual_memory) {
+			atomic64_add(args->in.alloc.mem_size,
+					&ctx->dram_phys_mem);
+			atomic64_add(args->in.alloc.mem_size,
+					&hdev->dram_used_mem);
+
+			dev_dbg(hdev->dev, "DRAM alloc is not supported\n");
+			rc = 0;
+
+			memset(args, 0, sizeof(*args));
+			args->out.handle = 0;
+			goto out;
+		}
+
 		rc = alloc_device_memory(ctx, &args->in, &handle);
 
 		memset(args, 0, sizeof(*args));
@@ -1255,6 +1272,26 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 		break;
 
 	case HL_MEM_OP_FREE:
+		/* If DRAM does not support virtual memory the driver won't
+		 * handle the allocation/freeing of that memory. However, for
+		 * system administration/monitoring purposes, the driver will
+		 * keep track of the amount of DRAM memory that is allocated
+		 * and freed by the user. Because this code totally relies on
+		 * the user's input, the driver can't ensure the validity
+		 * of this accounting.
+		 */
+		if (!hdev->dram_supports_virtual_memory) {
+			atomic64_sub(args->in.alloc.mem_size,
+					&ctx->dram_phys_mem);
+			atomic64_sub(args->in.alloc.mem_size,
+					&hdev->dram_used_mem);
+
+			dev_dbg(hdev->dev, "DRAM alloc is not supported\n");
+			rc = 0;
+
+			goto out;
+		}
+
 		rc = free_device_memory(ctx, args->in.free.handle);
 		break;
 
@@ -1773,6 +1810,13 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 
 	mutex_destroy(&ctx->mem_hash_lock);
 	hl_mmu_ctx_fini(ctx);
+
+	/* In this case we need to clear the global accounting of DRAM usage
+	 * because the user notifies us on allocations. If the user is no more,
+	 * all DRAM is available
+	 */
+	if (!ctx->hdev->dram_supports_virtual_memory)
+		atomic64_set(&ctx->hdev->dram_used_mem, 0);
 }
 
 /*
-- 
2.17.1

