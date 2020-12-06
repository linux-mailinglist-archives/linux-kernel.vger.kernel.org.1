Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE9C2D05F2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 17:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgLFQ33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 11:29:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgLFQ3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 11:29:25 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH] habanalabs: refactor MMU locks code
Date:   Sun,  6 Dec 2020 18:28:33 +0200
Message-Id: <20201206162835.4088-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201206162835.4088-1-ogabbay@kernel.org>
References: <20201206162835.4088-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

remove mmu_cache_lock as it protects a section which is already
protected by mmu_lock.

in addition, wrap mmu cache invalidate calls in hl_vm_ctx_fini with
mmu_lock.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 2 --
 drivers/misc/habanalabs/common/habanalabs.h | 2 --
 drivers/misc/habanalabs/common/memory.c     | 4 ++++
 drivers/misc/habanalabs/gaudi/gaudi.c       | 8 --------
 drivers/misc/habanalabs/goya/goya.c         | 8 --------
 5 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 5871162a8442..59212706a836 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -373,7 +373,6 @@ static int device_early_init(struct hl_device *hdev)
 
 	mutex_init(&hdev->send_cpu_message_lock);
 	mutex_init(&hdev->debug_lock);
-	mutex_init(&hdev->mmu_cache_lock);
 	INIT_LIST_HEAD(&hdev->cs_mirror_list);
 	spin_lock_init(&hdev->cs_mirror_lock);
 	INIT_LIST_HEAD(&hdev->fpriv_list);
@@ -414,7 +413,6 @@ static void device_early_fini(struct hl_device *hdev)
 {
 	int i;
 
-	mutex_destroy(&hdev->mmu_cache_lock);
 	mutex_destroy(&hdev->debug_lock);
 	mutex_destroy(&hdev->send_cpu_message_lock);
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 70b778a0d60e..270d342f7778 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1762,7 +1762,6 @@ struct hl_mmu_funcs {
  * @asic_funcs: ASIC specific functions.
  * @asic_specific: ASIC specific information to use only from ASIC files.
  * @vm: virtual memory manager for MMU.
- * @mmu_cache_lock: protects MMU cache invalidation as it can serve one context.
  * @hwmon_dev: H/W monitor device.
  * @pm_mng_profile: current power management profile.
  * @hl_chip_info: ASIC's sensors information.
@@ -1877,7 +1876,6 @@ struct hl_device {
 	const struct hl_asic_funcs	*asic_funcs;
 	void				*asic_specific;
 	struct hl_vm			vm;
-	struct mutex			mmu_cache_lock;
 	struct device			*hwmon_dev;
 	enum hl_pm_mng_profile		pm_mng_profile;
 	struct hwmon_chip_info		*hl_chip_info;
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index cbe9da4e0211..d4a94a1c3eef 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1889,10 +1889,14 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 		unmap_device_va(ctx, hnode->vaddr, true);
 	}
 
+	mutex_lock(&ctx->mmu_lock);
+
 	/* invalidate the cache once after the unmapping loop */
 	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, VM_TYPE_USERPTR);
 	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, VM_TYPE_PHYS_PACK);
 
+	mutex_unlock(&ctx->mmu_lock);
+
 	spin_lock(&vm->idr_lock);
 	idr_for_each_entry(&vm->phys_pg_pack_handles, phys_pg_list, i)
 		if (phys_pg_list->asid == ctx->asid) {
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 65895ba075fe..4776dfed9098 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7311,8 +7311,6 @@ static int gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 	else
 		timeout_usec = MMU_CONFIG_TIMEOUT_USEC;
 
-	mutex_lock(&hdev->mmu_cache_lock);
-
 	/* L0 & L1 invalidation */
 	WREG32(mmSTLB_INV_PS, 3);
 	WREG32(mmSTLB_CACHE_INV, gaudi->mmu_cache_inv_pi++);
@@ -7328,8 +7326,6 @@ static int gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 
 	WREG32(mmSTLB_INV_SET, 0);
 
-	mutex_unlock(&hdev->mmu_cache_lock);
-
 	if (rc) {
 		dev_err_ratelimited(hdev->dev,
 					"MMU cache invalidation timeout\n");
@@ -7352,8 +7348,6 @@ static int gaudi_mmu_invalidate_cache_range(struct hl_device *hdev,
 		hdev->hard_reset_pending)
 		return 0;
 
-	mutex_lock(&hdev->mmu_cache_lock);
-
 	if (hdev->pldm)
 		timeout_usec = GAUDI_PLDM_MMU_TIMEOUT_USEC;
 	else
@@ -7381,8 +7375,6 @@ static int gaudi_mmu_invalidate_cache_range(struct hl_device *hdev,
 		1000,
 		timeout_usec);
 
-	mutex_unlock(&hdev->mmu_cache_lock);
-
 	if (rc) {
 		dev_err_ratelimited(hdev->dev,
 					"MMU cache invalidation timeout\n");
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index b8b4aa636b7c..6ae34905d34f 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5072,8 +5072,6 @@ static int goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 	else
 		timeout_usec = MMU_CONFIG_TIMEOUT_USEC;
 
-	mutex_lock(&hdev->mmu_cache_lock);
-
 	/* L0 & L1 invalidation */
 	WREG32(mmSTLB_INV_ALL_START, 1);
 
@@ -5085,8 +5083,6 @@ static int goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 		1000,
 		timeout_usec);
 
-	mutex_unlock(&hdev->mmu_cache_lock);
-
 	if (rc) {
 		dev_err_ratelimited(hdev->dev,
 					"MMU cache invalidation timeout\n");
@@ -5116,8 +5112,6 @@ static int goya_mmu_invalidate_cache_range(struct hl_device *hdev,
 	else
 		timeout_usec = MMU_CONFIG_TIMEOUT_USEC;
 
-	mutex_lock(&hdev->mmu_cache_lock);
-
 	/*
 	 * TODO: currently invalidate entire L0 & L1 as in regular hard
 	 * invalidation. Need to apply invalidation of specific cache lines with
@@ -5140,8 +5134,6 @@ static int goya_mmu_invalidate_cache_range(struct hl_device *hdev,
 		1000,
 		timeout_usec);
 
-	mutex_unlock(&hdev->mmu_cache_lock);
-
 	if (rc) {
 		dev_err_ratelimited(hdev->dev,
 					"MMU cache invalidation timeout\n");
-- 
2.17.1

