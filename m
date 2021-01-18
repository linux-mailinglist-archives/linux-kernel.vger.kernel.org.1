Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945FC2FA99E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437006AbhARTF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:05:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407818AbhARTEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:04:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B6BE20725;
        Mon, 18 Jan 2021 19:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610996631;
        bh=mripDz6jp7uXWJI9XQv+0+HnWi8jGqPFUcWXNEbnLzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LOeZt5WtU1G8dMl94eSWF2mx6xj02BYTFEnYcLP04THhDCEQmBAX+8AgBA89DwQYJ
         FRuxUOVZon8aMcBlPJ2M+pjlDsv5s8cYXu5NvSDXIwgthgZqhFKpqrJ3dm6L1B/hVl
         A92QoO8gO/5tyFh27m3htOOSy5OG7F8FTUMurwQfTDW+DeWj0lHDQlz35GpvekMKFM
         iLTnohIuxDMKzjGCC+n4kLFJO8AgPdA26WWr1crYg4iLGrsbqs7PhGquidpWNLkh5U
         Cr14x2GCfn4lISUBpBd0/xsRtdAh3cj+Xe0DgRglCeK07bJNp7KXMhrm9jpLnx/9AE
         Pr4M+KgHEXw3Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 3/3] habanalabs: fix MMU debugfs related nodes
Date:   Mon, 18 Jan 2021 21:03:43 +0200
Message-Id: <20210118190343.11978-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118190343.11978-1-ogabbay@kernel.org>
References: <20210118190343.11978-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

In mmu debugfs node show un-scrambled physical addresses.
before read/write through data nodes, need to unscramble the
physical address before using it for pci transaction.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c    | 21 ++++--
 drivers/misc/habanalabs/common/habanalabs.h | 14 +++-
 drivers/misc/habanalabs/common/mmu/mmu.c    | 74 ++++++++++++++++++---
 drivers/misc/habanalabs/gaudi/gaudi.c       |  3 +-
 drivers/misc/habanalabs/goya/goya.c         |  3 +-
 5 files changed, 93 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 323d0381a60a..9e3c1efe56ba 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -310,8 +310,8 @@ static int mmu_show(struct seq_file *s, void *data)
 	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
 	struct hl_device *hdev = dev_entry->hdev;
 	struct hl_ctx *ctx;
-	struct hl_mmu_hop_info hops_info;
-	u64 virt_addr = dev_entry->mmu_addr;
+	struct hl_mmu_hop_info hops_info = {0};
+	u64 virt_addr = dev_entry->mmu_addr, phys_addr;
 	int i;
 
 	if (!hdev->mmu_enable)
@@ -333,10 +333,19 @@ static int mmu_show(struct seq_file *s, void *data)
 		return 0;
 	}
 
-	seq_printf(s,
-		"asid: %u, virt_addr: 0x%llx, scrambled virt_addr: 0x%llx\n",
-		dev_entry->mmu_asid, dev_entry->mmu_addr,
-		hops_info.scrambled_vaddr);
+	phys_addr = hops_info.hop_info[hops_info.used_hops - 1].hop_pte_val;
+
+	if (hops_info.scrambled_vaddr &&
+		(dev_entry->mmu_addr != hops_info.scrambled_vaddr))
+		seq_printf(s,
+			"asid: %u, virt_addr: 0x%llx, scrambled virt_addr: 0x%llx,\nphys_addr: 0x%llx, scrambled_phys_addr: 0x%llx\n",
+			dev_entry->mmu_asid, dev_entry->mmu_addr,
+			hops_info.scrambled_vaddr,
+			hops_info.unscrambled_paddr, phys_addr);
+	else
+		seq_printf(s,
+			"asid: %u, virt_addr: 0x%llx, phys_addr: 0x%llx\n",
+			dev_entry->mmu_asid, dev_entry->mmu_addr, phys_addr);
 
 	for (i = 0 ; i < hops_info.used_hops ; i++) {
 		seq_printf(s, "hop%d_addr: 0x%llx\n",
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index ce1a1e70a6d5..4129e4e6a7b5 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -851,8 +851,10 @@ enum div_select_defs {
  * @collective_wait_init_cs: Generate collective master/slave packets
  *                           and place them in the relevant cs jobs
  * @collective_wait_create_jobs: allocate collective wait cs jobs
- * @scramble_vaddr: Routine to scramble the virtual address prior of mapping it
+ * @scramble_addr: Routine to scramble the address prior of mapping it
  *                  in the MMU.
+ * @descramble_addr: Routine to de-scramble the address prior of
+ *                  showing it to users.
  * @ack_protection_bits_errors: ack and dump all security violations
  */
 struct hl_asic_funcs {
@@ -963,7 +965,8 @@ struct hl_asic_funcs {
 	int (*collective_wait_create_jobs)(struct hl_device *hdev,
 			struct hl_ctx *ctx, struct hl_cs *cs, u32 wait_queue_id,
 			u32 collective_engine_id);
-	u64 (*scramble_vaddr)(struct hl_device *hdev, u64 virt_addr);
+	u64 (*scramble_addr)(struct hl_device *hdev, u64 addr);
+	u64 (*descramble_addr)(struct hl_device *hdev, u64 addr);
 	void (*ack_protection_bits_errors)(struct hl_device *hdev);
 };
 
@@ -1726,13 +1729,17 @@ struct hl_mmu_per_hop_info {
  * @scrambled_vaddr: The value of the virtual address after scrambling. This
  *                   address replaces the original virtual-address when mapped
  *                   in the MMU tables.
+ * @unscrambled_paddr: The un-scrambled physical address.
  * @hop_info: Array holding the per-hop information used for the translation.
  * @used_hops: The number of hops used for the translation.
+ * @range_type: virtual address range type.
  */
 struct hl_mmu_hop_info {
 	u64 scrambled_vaddr;
+	u64 unscrambled_paddr;
 	struct hl_mmu_per_hop_info hop_info[MMU_ARCH_5_HOPS];
 	u32 used_hops;
+	enum hl_va_range_type range_type;
 };
 
 /**
@@ -2222,7 +2229,8 @@ void hl_mmu_v1_set_funcs(struct hl_device *hdev, struct hl_mmu_funcs *mmu);
 int hl_mmu_va_to_pa(struct hl_ctx *ctx, u64 virt_addr, u64 *phys_addr);
 int hl_mmu_get_tlb_info(struct hl_ctx *ctx, u64 virt_addr,
 			struct hl_mmu_hop_info *hops);
-u64 hl_mmu_scramble_vaddr(struct hl_device *hdev, u64 virt_addr);
+u64 hl_mmu_scramble_addr(struct hl_device *hdev, u64 addr);
+u64 hl_mmu_descramble_addr(struct hl_device *hdev, u64 addr);
 bool hl_is_dram_va(struct hl_device *hdev, u64 virt_addr);
 
 int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index 97c51686fcfe..27dc0d116db5 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -287,9 +287,9 @@ int hl_mmu_map_page(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 	 * after scrambling)
 	 */
 	if ((is_dram_addr &&
-			((hdev->asic_funcs->scramble_vaddr(hdev, phys_addr) &
+			((hdev->asic_funcs->scramble_addr(hdev, phys_addr) &
 				(mmu_prop->page_size - 1)) ||
-			(hdev->asic_funcs->scramble_vaddr(hdev, virt_addr) &
+			(hdev->asic_funcs->scramble_addr(hdev, virt_addr) &
 				(mmu_prop->page_size - 1)))) ||
 		(!is_dram_addr && ((phys_addr & (real_page_size - 1)) ||
 				(virt_addr & (real_page_size - 1)))))
@@ -476,19 +476,53 @@ void hl_mmu_swap_in(struct hl_ctx *ctx)
 		hdev->mmu_func[MMU_HR_PGT].swap_in(ctx);
 }
 
+static void hl_mmu_pa_page_with_offset(struct hl_ctx *ctx, u64 virt_addr,
+						struct hl_mmu_hop_info *hops,
+						u64 *phys_addr)
+{
+	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 offset_mask, addr_mask, hop_shift, tmp_phys_addr;
+	u32 hop0_shift_off;
+	void *p;
+
+	/* last hop holds the phys address and flags */
+	if (hops->unscrambled_paddr)
+		tmp_phys_addr = hops->unscrambled_paddr;
+	else
+		tmp_phys_addr = hops->hop_info[hops->used_hops - 1].hop_pte_val;
+
+	if (hops->range_type == HL_VA_RANGE_TYPE_HOST_HUGE)
+		p = &prop->pmmu_huge;
+	else if (hops->range_type == HL_VA_RANGE_TYPE_HOST)
+		p = &prop->pmmu;
+	else /* HL_VA_RANGE_TYPE_DRAM */
+		p = &prop->dmmu;
+
+	/*
+	 * find the correct hop shift field in hl_mmu_properties structure
+	 * in order to determine the right maks for the page offset.
+	 */
+	hop0_shift_off = offsetof(struct hl_mmu_properties, hop0_shift);
+	p = (char *)p + hop0_shift_off;
+	p = (char *)p + ((hops->used_hops - 1) * sizeof(u64));
+	hop_shift = *(u64 *)p;
+	offset_mask = (1 << hop_shift) - 1;
+	addr_mask = ~(offset_mask);
+	*phys_addr = (tmp_phys_addr & addr_mask) |
+					(virt_addr & offset_mask);
+}
+
 int hl_mmu_va_to_pa(struct hl_ctx *ctx, u64 virt_addr, u64 *phys_addr)
 {
 	struct hl_mmu_hop_info hops;
-	u64 tmp_addr;
 	int rc;
 
 	rc = hl_mmu_get_tlb_info(ctx, virt_addr, &hops);
 	if (rc)
 		return rc;
 
-	/* last hop holds the phys address and flags */
-	tmp_addr = hops.hop_info[hops.used_hops - 1].hop_pte_val;
-	*phys_addr = (tmp_addr & HOP_PHYS_ADDR_MASK) | (virt_addr & FLAGS_MASK);
+	hl_mmu_pa_page_with_offset(ctx, virt_addr, &hops,  phys_addr);
 
 	return 0;
 }
@@ -525,6 +559,11 @@ int hl_mmu_get_tlb_info(struct hl_ctx *ctx, u64 virt_addr,
 
 	mutex_unlock(&ctx->mmu_lock);
 
+	/* add page offset to physical address */
+	if (hops->unscrambled_paddr)
+		hl_mmu_pa_page_with_offset(ctx, virt_addr, hops,
+					&hops->unscrambled_paddr);
+
 	return rc;
 }
 
@@ -548,13 +587,26 @@ int hl_mmu_if_set_funcs(struct hl_device *hdev)
 }
 
 /**
- * hl_mmu_scramble_vaddr() - The generic mmu virtual address scrambling routine.
+ * hl_mmu_scramble_addr() - The generic mmu address scrambling routine.
+ * @hdev: pointer to device data.
+ * @addr: The address to scramble.
+ *
+ * Return: The scrambled address.
+ */
+u64 hl_mmu_scramble_addr(struct hl_device *hdev, u64 addr)
+{
+	return addr;
+}
+
+/**
+ * hl_mmu_descramble_addr() - The generic mmu address descrambling
+ * routine.
  * @hdev: pointer to device data.
- * @virt_addr: The virtual address to scramble.
+ * @addr: The address to descramble.
  *
- * Return: The scrambled virtual address.
+ * Return: The un-scrambled address.
  */
-u64 hl_mmu_scramble_vaddr(struct hl_device *hdev, u64 virt_addr)
+u64 hl_mmu_descramble_addr(struct hl_device *hdev, u64 addr)
 {
-	return virt_addr;
+	return addr;
 }
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 69b3867bc151..b49e10394ed4 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8548,7 +8548,8 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.get_device_time = gaudi_get_device_time,
 	.collective_wait_init_cs = gaudi_collective_wait_init_cs,
 	.collective_wait_create_jobs = gaudi_collective_wait_create_jobs,
-	.scramble_vaddr = hl_mmu_scramble_vaddr,
+	.scramble_addr = hl_mmu_scramble_addr,
+	.descramble_addr = hl_mmu_descramble_addr,
 	.ack_protection_bits_errors = gaudi_ack_protection_bits_errors
 };
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 82f69274def7..db951d622ad5 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5459,7 +5459,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.get_device_time = goya_get_device_time,
 	.collective_wait_init_cs = goya_collective_wait_init_cs,
 	.collective_wait_create_jobs = goya_collective_wait_create_jobs,
-	.scramble_vaddr = hl_mmu_scramble_vaddr,
+	.scramble_addr = hl_mmu_scramble_addr,
+	.descramble_addr = hl_mmu_descramble_addr,
 	.ack_protection_bits_errors = goya_ack_protection_bits_errors
 };
 
-- 
2.25.1

