Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC06F2B2C68
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 10:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgKNJY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 04:24:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgKNJYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 04:24:25 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3E852224F;
        Sat, 14 Nov 2020 09:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605345864;
        bh=3rgwLGVc3ifTM2lqoJQqA5YqQU0yDqOuiwpd+GglZZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qWIAnA30qspCdunjnK7zQo1aWYLmVRjwzTl2r5WakBMKiivUd4+ChDQhk2znZD/Vr
         U32ycalAhCbAm+plvURD1KFwV4E454qjsP0D1qCe5s5vVTFv5PrO0V1USWzMLBU4F0
         Qd5mYAzUPe60xLtFwEZLMw9fjlrnSkgCD5sL2LuY=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: support reserving aligned va block
Date:   Sat, 14 Nov 2020 11:24:14 +0200
Message-Id: <20201114092414.12244-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201114092414.12244-1-ogabbay@kernel.org>
References: <20201114092414.12244-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Add support for reserving va block with alignment different than
page size. This is a pre-requisite for allocations needed in future
ASICs

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 4 +++-
 drivers/misc/habanalabs/common/memory.c     | 8 +++++---
 drivers/misc/habanalabs/gaudi/gaudi.c       | 3 ++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index eeb78381177b..76ab9741895d 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -303,6 +303,8 @@ enum hl_device_hw_state {
 	HL_DEVICE_HW_STATE_DIRTY
 };
 
+#define HL_MMU_VA_ALIGNMENT_NOT_NEEDED 0
+
 /**
  * struct hl_mmu_properties - ASIC specific MMU address translation properties.
  * @start_addr: virtual start address of the memory region.
@@ -2112,7 +2114,7 @@ int hl_vm_init(struct hl_device *hdev);
 void hl_vm_fini(struct hl_device *hdev);
 
 u64 hl_reserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
-		enum hl_va_range_type type, u32 size);
+		enum hl_va_range_type type, u32 size, u32 alignment);
 int hl_unreserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
 		u64 start_addr, u64 size);
 int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u64 size,
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index f27ca80d3c3c..351c9927151f 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -626,18 +626,20 @@ static u64 get_va_block(struct hl_device *hdev, struct hl_va_range *va_range,
  * @ctx: current context
  * @type: virtual addresses range type.
  * @size: requested block size.
+ * @alignment: required alignment in bytes of the virtual block start address,
+ *             0 means no alignment.
  *
  * This function does the following:
  * - Iterate on the virtual block list to find a suitable virtual block for the
- *   given size.
+ *   given size and alignment.
  * - Reserve the requested block and update the list.
  * - Return the start address of the virtual block.
  */
 u64 hl_reserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
-		enum hl_va_range_type type, u32 size)
+		enum hl_va_range_type type, u32 size, u32 alignment)
 {
 	return get_va_block(hdev, ctx->va_range[type], size, 0,
-			ctx->va_range[type]->page_size);
+			max(alignment, ctx->va_range[type]->page_size));
 }
 
 /**
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index bf34ca29e42b..f1b8d20cf2ce 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7802,7 +7802,8 @@ static int gaudi_internal_cb_pool_init(struct hl_device *hdev,
 	}
 
 	hdev->internal_cb_va_base = hl_reserve_va_block(hdev, ctx,
-			HL_VA_RANGE_TYPE_HOST, HOST_SPACE_INTERNAL_CB_SZ);
+			HL_VA_RANGE_TYPE_HOST, HOST_SPACE_INTERNAL_CB_SZ,
+			HL_MMU_VA_ALIGNMENT_NOT_NEEDED);
 
 	if (!hdev->internal_cb_va_base)
 		goto destroy_internal_cb_pool;
-- 
2.17.1

