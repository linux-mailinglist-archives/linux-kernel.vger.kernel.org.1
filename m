Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77D52FA997
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390264AbhARTFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:05:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407899AbhARTEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:04:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79C84206DB;
        Mon, 18 Jan 2021 19:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610996628;
        bh=93vuH1QZVW1W+YkbBBPRUFf+AgUm2pPaYHTfeLScUPA=;
        h=From:To:Cc:Subject:Date:From;
        b=dWT61FR4HKjUWiyqlr7nrgT0yCdtWxOfY08Yq5RwTfVUrhJyVH9FQHnunmCogq2iL
         zYPS8H2GrXL4RCN3Vi07cmewvmaNkEMFdihiQBKLj3RrMIvRqyQpjnKMyhtdw9sRo7
         vmr39SfIUTeY1UeuO8CLJuluU6idQYyFsmlV//sgU3YAYKdgfSGjq3k4/Lstrqk/+n
         SOS1ATt9i6atR5KPqMSMThcP3J7FeNcnjfOGY9Knve7ZrYZYX8rPbO8lIRWdO994hh
         rrQ9s/jPQpvn9nlYSbBUAsoJVQqwSAf+puPwIHlGIy0V/I/MyQtLgqOTUGz6M/Dsig
         NNiAAgMyD//PQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 1/3] habanalabs: always try to use the hint address
Date:   Mon, 18 Jan 2021 21:03:41 +0200
Message-Id: <20210118190343.11978-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

Currently hint address is ignored in case va block page size
is not power of 2. We need to support th user hint address also in this
case, but only if the hint address is aligned to page size.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 133 ++++++------------------
 1 file changed, 33 insertions(+), 100 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index ada977eb136c..585425514cad 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -520,8 +520,8 @@ static inline int add_va_block(struct hl_device *hdev,
 }
 
 /**
- * get_va_block_pow2() - get a virtual block for the given size and alignment
- *                       where alignment is a power of 2.
+ * get_va_block() - get a virtual block for the given size and alignment.
+ *
  * @hdev: pointer to the habanalabs device structure.
  * @va_range: pointer to the virtual addresses range.
  * @size: requested block size.
@@ -530,11 +530,11 @@ static inline int add_va_block(struct hl_device *hdev,
  *
  * This function does the following:
  * - Iterate on the virtual block list to find a suitable virtual block for the
- *   given size and alignment.
+ *   given size, hint address and alignment.
  * - Reserve the requested block and update the list.
  * - Return the start address of the virtual block.
  */
-static u64 get_va_block_pow2(struct hl_device *hdev,
+static u64 get_va_block(struct hl_device *hdev,
 				struct hl_va_range *va_range,
 				u64 size, u64 hint_addr, u32 va_block_align)
 {
@@ -542,22 +542,37 @@ static u64 get_va_block_pow2(struct hl_device *hdev,
 	u64 valid_start, valid_size, prev_start, prev_end, align_mask,
 	reserved_valid_start = 0, reserved_valid_size = 0;
 	bool add_prev = false;
+	bool is_align_pow_2  = is_power_of_2(va_range->page_size);
 
-	align_mask = ~((u64)va_block_align - 1);
+	if (is_align_pow_2)
+		align_mask = ~((u64)va_block_align - 1);
+	else {
+		/*
+		 * with non-power-of-2 range we work only with page granularity
+		 * and the start address is page aligned,
+		 * so no need for alignment checking.
+		 */
+		size = DIV_ROUND_UP_ULL(size, va_range->page_size) *
+							va_range->page_size;
+	}
 
-	/* check if hint_addr is aligned */
-	if (hint_addr & (va_block_align - 1))
+	/* Check if we need to ignore hint address */
+	if ((is_align_pow_2 && (hint_addr & (va_block_align - 1))) ||
+		(!is_align_pow_2 && (hint_addr % va_range->page_size))) {
+		dev_info(hdev->dev, "Hint address 0x%llx will be ignored\n",
+					hint_addr);
 		hint_addr = 0;
+	}
 
 	mutex_lock(&va_range->lock);
 
 	print_va_list_locked(hdev, &va_range->list);
 
 	list_for_each_entry(va_block, &va_range->list, node) {
-		/* calc the first possible aligned addr */
+		/* Calc the first possible aligned addr */
 		valid_start = va_block->start;
 
-		if (valid_start & (va_block_align - 1)) {
+		if (is_align_pow_2 && (valid_start & (va_block_align - 1))) {
 			valid_start &= align_mask;
 			valid_start += va_block_align;
 			if (valid_start > va_block->end)
@@ -565,9 +580,11 @@ static u64 get_va_block_pow2(struct hl_device *hdev,
 		}
 
 		valid_size = va_block->end - valid_start;
+		if (valid_size < size)
+			continue;
 
-		if (valid_size >= size && (!new_va_block ||
-					valid_size < reserved_valid_size)) {
+		/* Pick the minimal length block which has the required size */
+		if (!new_va_block || (valid_size < reserved_valid_size)) {
 			new_va_block = va_block;
 			reserved_valid_start = valid_start;
 			reserved_valid_size = valid_size;
@@ -584,10 +601,14 @@ static u64 get_va_block_pow2(struct hl_device *hdev,
 
 	if (!new_va_block) {
 		dev_err(hdev->dev, "no available va block for size %llu\n",
-		size);
+								size);
 		goto out;
 	}
 
+	/*
+	 * Check if there is some leftover range due to reserving the new
+	 * va block, then return it to the main virtual addresses list.
+	 */
 	if (reserved_valid_start > new_va_block->start) {
 		prev_start = new_va_block->start;
 		prev_end = reserved_valid_start - 1;
@@ -617,94 +638,6 @@ static u64 get_va_block_pow2(struct hl_device *hdev,
 	return reserved_valid_start;
 }
 
-/**
- * get_va_block_non_pow2() - get a virtual block for the given size and
- *                           alignment where alignment is not a power of 2.
- * @hdev: pointer to the habanalabs device structure.
- * @va_range: pointer to the virtual addresses range.
- * @size: requested block size.
- * @hint_addr: hint for requested address by the user.
- * @va_block_align: required alignment of the virtual block start address.
- *
- * This function does the following:
- * - Iterate on the virtual block list to find a suitable virtual block for the
- *   given size and alignment.
- * - Reserve the requested block and update the list.
- * - Return the start address of the virtual block.
- */
-static u64 get_va_block_non_pow2(struct hl_device *hdev,
-				struct hl_va_range *va_range,
-				u64 size, u64 hint_addr, u32 va_block_align)
-{
-	struct hl_vm_va_block *va_block, *new_va_block = NULL;
-	u64 reserved_valid_start = 0;
-
-	/*
-	 * with non-power-of-2 range we work only with page granularity and the
-	 * start address is page aligned, so no need for alignment checking.
-	 */
-	size = DIV_ROUND_UP_ULL(size, va_range->page_size) *
-							va_range->page_size;
-
-	mutex_lock(&va_range->lock);
-
-	print_va_list_locked(hdev, &va_range->list);
-
-	list_for_each_entry(va_block, &va_range->list, node) {
-		if ((va_block->start + size) > va_block->end)
-			continue;
-
-		new_va_block = va_block;
-		reserved_valid_start = va_block->start;
-		break;
-	}
-
-	if (!new_va_block) {
-		dev_err(hdev->dev, "no available va block for size %llu\n",
-				size);
-		goto out;
-	}
-
-	if (new_va_block->size > size) {
-		new_va_block->start += size;
-		new_va_block->size = new_va_block->end - new_va_block->start;
-	} else {
-		list_del(&new_va_block->node);
-		kfree(new_va_block);
-	}
-
-	print_va_list_locked(hdev, &va_range->list);
-out:
-	mutex_unlock(&va_range->lock);
-
-	return reserved_valid_start;
-}
-
-/*
- * get_va_block() - get a virtual block for the given size and alignment.
- * @hdev: pointer to the habanalabs device structure.
- * @va_range: pointer to the virtual addresses range.
- * @size: requested block size.
- * @hint_addr: hint for requested address by the user.
- * @va_block_align: required alignment of the virtual block start address.
- *
- * This function does the following:
- * - Iterate on the virtual block list to find a suitable virtual block for the
- *   given size and alignment.
- * - Reserve the requested block and update the list.
- * - Return the start address of the virtual block.
- */
-static u64 get_va_block(struct hl_device *hdev, struct hl_va_range *va_range,
-			u64 size, u64 hint_addr, u32 va_block_align)
-{
-	if (is_power_of_2(va_range->page_size))
-		return get_va_block_pow2(hdev, va_range,
-					size, hint_addr, va_block_align);
-	else
-		return get_va_block_non_pow2(hdev, va_range,
-					size, hint_addr, va_block_align);
-}
-
 /*
  * hl_reserve_va_block() - reserve a virtual block of a given size.
  * @hdev: pointer to the habanalabs device structure.
-- 
2.25.1

