Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7092AC1D1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbgKIRI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:08:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:60778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730218AbgKIRI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:08:58 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1697C216C4;
        Mon,  9 Nov 2020 17:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604941738;
        bh=787Yuk0mqitnAVia8Br9gFQ3EtyFXYmOLRiV1Ic6mmg=;
        h=From:To:Cc:Subject:Date:From;
        b=EJxLRkh+MWCVENMF91V+xxd8Z/yFVXDOyFjQR1/lhF39TiPCVK0S+ugDyX07Xo8iZ
         I16r6W0IqTTxBSme7dD65M0WER6C3yOcybst85GpmeXH9FvAIwnLEhhlX8fMNLqx/j
         LSt8G5Zi94Hh3+fC2vB7dP4dynQ67cQDIWF/fY90=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: move asic property to correct structure
Date:   Mon,  9 Nov 2020 19:08:52 +0200
Message-Id: <20201109170853.23683-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whether an ASIC has MMU towards its DRAM is an ASIC property, so
move it to the asic fixed properties structure.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c    | 2 +-
 drivers/misc/habanalabs/common/habanalabs.h | 4 ++--
 drivers/misc/habanalabs/common/memory.c     | 6 +++---
 drivers/misc/habanalabs/common/mmu_v1.c     | 4 ++--
 drivers/misc/habanalabs/gaudi/gaudi.c       | 3 +--
 drivers/misc/habanalabs/goya/goya.c         | 2 +-
 6 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 104b9686e57b..3d9bd86312e2 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -598,7 +598,7 @@ static bool hl_is_device_va(struct hl_device *hdev, u64 addr)
 	if (!hdev->mmu_enable)
 		goto out;
 
-	if (hdev->dram_supports_virtual_memory &&
+	if (prop->dram_supports_virtual_memory &&
 		(addr >= prop->dmmu.start_addr && addr < prop->dmmu.end_addr))
 		return true;
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 822f90087e04..a1d82de60ef6 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -411,6 +411,7 @@ struct hl_mmu_properties {
  *                        false otherwise
  * @fw_security_status_valid: security status bits are valid and can be fetched
  *                            from BOOT_DEV_STS0
+ * @dram_supports_virtual_memory: is there an MMU towards the DRAM
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	*hw_queues_props;
@@ -467,6 +468,7 @@ struct asic_fixed_properties {
 	u8				completion_queues_count;
 	u8				fw_security_disabled;
 	u8				fw_security_status_valid;
+	u8				dram_supports_virtual_memory;
 };
 
 /**
@@ -1772,7 +1774,6 @@ struct hl_mmu_funcs {
  * @heartbeat: is heartbeat sanity check towards CPU-CP enabled.
  * @reset_on_lockup: true if a reset should be done in case of stuck CS, false
  *                   otherwise.
- * @dram_supports_virtual_memory: is MMU enabled towards DRAM.
  * @dram_default_page_mapping: is DRAM default page mapping enabled.
  * @memory_scrub: true to perform device memory scrub in various locations,
  *                such as context-switch, context close, page free, etc.
@@ -1886,7 +1887,6 @@ struct hl_device {
 	u8				hard_reset_pending;
 	u8				heartbeat;
 	u8				reset_on_lockup;
-	u8				dram_supports_virtual_memory;
 	u8				dram_default_page_mapping;
 	u8				memory_scrub;
 	u8				pmmu_huge_range;
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 01e93e83d3af..f27ca80d3c3c 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1351,7 +1351,7 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 		 * the user's input, the driver can't ensure the validity
 		 * of this accounting.
 		 */
-		if (!hdev->dram_supports_virtual_memory) {
+		if (!hdev->asic_prop.dram_supports_virtual_memory) {
 			atomic64_add(args->in.alloc.mem_size,
 					&ctx->dram_phys_mem);
 			atomic64_add(args->in.alloc.mem_size,
@@ -1380,7 +1380,7 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 		 * the user's input, the driver can't ensure the validity
 		 * of this accounting.
 		 */
-		if (!hdev->dram_supports_virtual_memory) {
+		if (!hdev->asic_prop.dram_supports_virtual_memory) {
 			atomic64_sub(args->in.alloc.mem_size,
 					&ctx->dram_phys_mem);
 			atomic64_sub(args->in.alloc.mem_size,
@@ -1915,7 +1915,7 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 	 * because the user notifies us on allocations. If the user is no more,
 	 * all DRAM is available
 	 */
-	if (!ctx->hdev->dram_supports_virtual_memory)
+	if (!ctx->hdev->asic_prop.dram_supports_virtual_memory)
 		atomic64_set(&ctx->hdev->dram_used_mem, 0);
 }
 
diff --git a/drivers/misc/habanalabs/common/mmu_v1.c b/drivers/misc/habanalabs/common/mmu_v1.c
index ac3784523baa..5f62cb158eef 100644
--- a/drivers/misc/habanalabs/common/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu_v1.c
@@ -262,7 +262,7 @@ static int dram_default_mapping_init(struct hl_ctx *ctx)
 		hop2_pte_addr, hop3_pte_addr, pte_val;
 	int rc, i, j, hop3_allocated = 0;
 
-	if ((!hdev->dram_supports_virtual_memory) ||
+	if ((!prop->dram_supports_virtual_memory) ||
 			(!hdev->dram_default_page_mapping) ||
 			(ctx->asid == HL_KERNEL_ASID_ID))
 		return 0;
@@ -362,7 +362,7 @@ static void dram_default_mapping_fini(struct hl_ctx *ctx)
 		hop2_pte_addr, hop3_pte_addr;
 	int i, j;
 
-	if ((!hdev->dram_supports_virtual_memory) ||
+	if ((!prop->dram_supports_virtual_memory) ||
 			(!hdev->dram_default_page_mapping) ||
 			(ctx->asid == HL_KERNEL_ASID_ID))
 		return;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 1135b2cc5860..8d6cffd28381 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -462,6 +462,7 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 	prop->mmu_hop_table_size = HOP_TABLE_SIZE;
 	prop->mmu_hop0_tables_total_size = HOP0_TABLES_TOTAL_SIZE;
 	prop->dram_page_size = PAGE_SIZE_2MB;
+	prop->dram_supports_virtual_memory = false;
 
 	prop->pmmu.hop0_shift = HOP0_SHIFT;
 	prop->pmmu.hop1_shift = HOP1_SHIFT;
@@ -3573,8 +3574,6 @@ static int gaudi_mmu_init(struct hl_device *hdev)
 	if (gaudi->hw_cap_initialized & HW_CAP_MMU)
 		return 0;
 
-	hdev->dram_supports_virtual_memory = false;
-
 	for (i = 0 ; i < prop->max_asid ; i++) {
 		hop0_addr = prop->mmu_pgt_addr +
 				(i * prop->mmu_hop_table_size);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 002fc53fb39d..bf21f05f7849 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -410,6 +410,7 @@ int goya_get_fixed_properties(struct hl_device *hdev)
 	prop->mmu_hop_table_size = HOP_TABLE_SIZE;
 	prop->mmu_hop0_tables_total_size = HOP0_TABLES_TOTAL_SIZE;
 	prop->dram_page_size = PAGE_SIZE_2MB;
+	prop->dram_supports_virtual_memory = true;
 
 	prop->dmmu.hop0_shift = HOP0_SHIFT;
 	prop->dmmu.hop1_shift = HOP1_SHIFT;
@@ -2481,7 +2482,6 @@ int goya_mmu_init(struct hl_device *hdev)
 	if (goya->hw_cap_initialized & HW_CAP_MMU)
 		return 0;
 
-	hdev->dram_supports_virtual_memory = true;
 	hdev->dram_default_page_mapping = true;
 
 	for (i = 0 ; i < prop->max_asid ; i++) {
-- 
2.17.1

