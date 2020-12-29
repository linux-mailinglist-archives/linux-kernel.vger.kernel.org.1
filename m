Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE022E74DA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgL2Vho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:37:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgL2Vhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:37:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BA9422209;
        Tue, 29 Dec 2020 21:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609277820;
        bh=VaYM17xiAey5ugVovGzUuNOVOFkSsjJiVQISd9BkUR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UEOqigf+TQmvNhWe7eWYvR6K+yDEAIkvrV/2/nfqLsVSkR75UwgCgk2ecg6EAsTg5
         UlCHVY+7rZY7aTGaz/8pQMWiaHPwyRoZ3ht+Elflu/OhyZBVA6Bb4zHn32ftkxP6M7
         M1UVZ1Hs+Ucrj3gmKCX7eCqGIGFqOHKNmGkpOtpDl02CwtTauB2yPmVSxrHs9Vx37y
         3S0OwOqpxlejJmNHJXIs7cYN55U+FtX9go8uEM2ZCsPAqQuiv3aGf+Pbgs12tk+fIu
         teZRCiRFO8/ge0K3qZ7cZ+/WYeR8y6l5JHAuOSjimJ+xlNZ5LEpGjitIk8qYn7ODK8
         D5tIEVilOPXHA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 3/8] habanalabs: modify memory functions signatures
Date:   Tue, 29 Dec 2020 23:36:48 +0200
Message-Id: <20201229213653.29749-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201229213653.29749-1-ogabbay@kernel.org>
References: <20201229213653.29749-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

For consistency, modify all memory ioctl functions to get the ioctl
arguments structure rather than the arguments themselves.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 6efd90d25ff5..5d8228522bfc 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -314,16 +314,17 @@ static void free_phys_pg_pack(struct hl_device *hdev,
 /**
  * free_device_memory() - free device memory.
  * @ctx: pointer to the context structure.
- * @handle: handle of the memory chunk to free.
+ * @args: host parameters containing the requested size.
  *
  * This function does the following:
  * - Free the device memory related to the given handle.
  */
-static int free_device_memory(struct hl_ctx *ctx, u32 handle)
+static int free_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args)
 {
 	struct hl_device *hdev = ctx->hdev;
 	struct hl_vm *vm = &hdev->vm;
 	struct hl_vm_phys_pg_pack *phys_pg_pack;
+	u32 handle = args->free.handle;
 
 	spin_lock(&vm->idr_lock);
 	phys_pg_pack = idr_find(&vm->phys_pg_pack_handles, handle);
@@ -1111,20 +1112,22 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 /**
  * unmap_device_va() - unmap the given device virtual address.
  * @ctx: pointer to the context structure.
- * @vaddr: device virtual address to unmap.
+ * @args: host parameters with device virtual address to unmap.
  * @ctx_free: true if in context free flow, false otherwise.
  *
  * This function does the following:
  * - unmap the physical pages related to the given virtual address.
  * - return the device virtual block to the virtual block list.
  */
-static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr, bool ctx_free)
+static int unmap_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
+				bool ctx_free)
 {
 	struct hl_device *hdev = ctx->hdev;
 	struct hl_vm_phys_pg_pack *phys_pg_pack = NULL;
 	struct hl_vm_hash_node *hnode = NULL;
 	struct hl_userptr *userptr = NULL;
 	struct hl_va_range *va_range;
+	u64 vaddr = args->unmap.device_virt_addr;
 	enum vm_type_t *vm_type;
 	bool is_userptr;
 	int rc = 0;
@@ -1274,7 +1277,7 @@ static int mem_ioctl_no_mmu(struct hl_fpriv *hpriv, union hl_mem_args *args)
 		break;
 
 	case HL_MEM_OP_FREE:
-		rc = free_device_memory(ctx, args->in.free.handle);
+		rc = free_device_memory(ctx, &args->in);
 		break;
 
 	case HL_MEM_OP_MAP:
@@ -1382,7 +1385,7 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 			goto out;
 		}
 
-		rc = free_device_memory(ctx, args->in.free.handle);
+		rc = free_device_memory(ctx, &args->in);
 		break;
 
 	case HL_MEM_OP_MAP:
@@ -1393,8 +1396,7 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 		break;
 
 	case HL_MEM_OP_UNMAP:
-		rc = unmap_device_va(ctx, args->in.unmap.device_virt_addr,
-					false);
+		rc = unmap_device_va(ctx, &args->in, false);
 		break;
 
 	default:
@@ -1852,6 +1854,7 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 	struct hl_vm_phys_pg_pack *phys_pg_list;
 	struct hl_vm_hash_node *hnode;
 	struct hlist_node *tmp_node;
+	struct hl_mem_in args;
 	int i;
 
 	if (!hdev->mmu_enable)
@@ -1871,7 +1874,8 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 		dev_dbg(hdev->dev,
 			"hl_mem_hash_node of vaddr 0x%llx of asid %d is still alive\n",
 			hnode->vaddr, ctx->asid);
-		unmap_device_va(ctx, hnode->vaddr, true);
+		args.unmap.device_virt_addr = hnode->vaddr;
+		unmap_device_va(ctx, &args, true);
 	}
 
 	mutex_lock(&ctx->mmu_lock);
-- 
2.25.1

