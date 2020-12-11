Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E04E2D712B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405449AbgLKICg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:02:36 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9510 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733064AbgLKICM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:02:12 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Csjs42rxpzhqh6;
        Fri, 11 Dec 2020 16:00:56 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 16:01:19 +0800
From:   Yanan Wang <wangyanan55@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        "Julien Thierry" <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Quentin Perret <qperret@google.com>
CC:     <wanghaibin.wang@huawei.com>, <yezengruan@huawei.com>,
        <zhukeqian1@huawei.com>, <yuzenghui@huawei.com>,
        <jiangkunkun@huawei.com>, <wangjingyi11@huawei.com>,
        <lushenming@huawei.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: [RFC PATCH] KVM: arm64: Add prejudgement for relaxing permissions only case in stage2 translation fault handler
Date:   Fri, 11 Dec 2020 16:01:15 +0800
Message-ID: <20201211080115.21460-2-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20201211080115.21460-1-wangyanan55@huawei.com>
References: <20201211080115.21460-1-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.128]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dirty-logging, or dirty-logging-stopped time, even normal running
time of a guest configed with huge mappings and numbers of vCPUs,
translation faults by different vCPUs on the same GPA could occur
successively almost at the same time. There are two reasons for it.

(1) If there are some vCPUs accessing the same GPA at the same time
and the leaf PTE is not set yet, then they will all cause translation
faults and the first vCPU holding mmu_lock will set valid leaf PTE,
and the others will later choose to update the leaf PTE or not.

(2) When changing a leaf entry or a table entry with break-before-make,
if there are some vCPUs accessing the same GPA just catch the moment
when the target PTE is set invalid in a BBM procedure coincidentally,
they will all cause translation faults and will later choose to update
the leaf PTE or not.

The worst case can be like this: some vCPUs cause translation faults
on the same GPA with different prots, they will fight each other by
changing back access permissions of the PTE with break-before-make.
And the BBM-invalid moment might trigger more unnecessary translation
faults. As a result, some useless small loops will occur, which could
lead to vCPU stuck.

To avoid unnecessary update and small loops, add prejudgement in the
translation fault handler: Skip updating the valid leaf PTE if we are
trying to recreate exactly the same mapping or to reduce access
permissions only(such as RW-->RO). And update the valid leaf PTE without
break-before-make if we are trying to add more permissions only.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 73 +++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 23a01dfcb27a..f8b3248cef1c 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -45,6 +45,8 @@
 
 #define KVM_PTE_LEAF_ATTR_HI_S2_XN	BIT(54)
 
+#define KVM_PTE_LEAF_ATTR_PERMS	(GENMASK(7, 6) | BIT(54))
+
 struct kvm_pgtable_walk_data {
 	struct kvm_pgtable		*pgt;
 	struct kvm_pgtable_walker	*walker;
@@ -170,10 +172,9 @@ static void kvm_set_table_pte(kvm_pte_t *ptep, kvm_pte_t *childp)
 	smp_store_release(ptep, pte);
 }
 
-static bool kvm_set_valid_leaf_pte(kvm_pte_t *ptep, u64 pa, kvm_pte_t attr,
-				   u32 level)
+static kvm_pte_t kvm_init_valid_leaf_pte(u64 pa, kvm_pte_t attr, u32 level)
 {
-	kvm_pte_t old = *ptep, pte = kvm_phys_to_pte(pa);
+	kvm_pte_t pte = kvm_phys_to_pte(pa);
 	u64 type = (level == KVM_PGTABLE_MAX_LEVELS - 1) ? KVM_PTE_TYPE_PAGE :
 							   KVM_PTE_TYPE_BLOCK;
 
@@ -181,12 +182,7 @@ static bool kvm_set_valid_leaf_pte(kvm_pte_t *ptep, u64 pa, kvm_pte_t attr,
 	pte |= FIELD_PREP(KVM_PTE_TYPE, type);
 	pte |= KVM_PTE_VALID;
 
-	/* Tolerate KVM recreating the exact same mapping. */
-	if (kvm_pte_valid(old))
-		return old == pte;
-
-	smp_store_release(ptep, pte);
-	return true;
+	return pte;
 }
 
 static int kvm_pgtable_visitor_cb(struct kvm_pgtable_walk_data *data, u64 addr,
@@ -341,12 +337,17 @@ static int hyp_map_set_prot_attr(enum kvm_pgtable_prot prot,
 static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 				    kvm_pte_t *ptep, struct hyp_map_data *data)
 {
+	kvm_pte_t new, old = *ptep;
 	u64 granule = kvm_granule_size(level), phys = data->phys;
 
 	if (!kvm_block_mapping_supported(addr, end, phys, level))
 		return false;
 
-	WARN_ON(!kvm_set_valid_leaf_pte(ptep, phys, data->attr, level));
+	/* Tolerate KVM recreating the exact same mapping. */
+	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
+	if (old != new && !WARN_ON(kvm_pte_valid(old)))
+		smp_store_release(ptep, new);
+
 	data->phys += granule;
 	return true;
 }
@@ -461,25 +462,56 @@ static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
 	return 0;
 }
 
+static bool stage2_set_valid_leaf_pte_pre(u64 addr, u32 level,
+					  kvm_pte_t *ptep, kvm_pte_t new,
+					  struct stage2_map_data *data)
+{
+	kvm_pte_t old = *ptep, old_attr, new_attr;
+
+	if ((old ^ new) & (~KVM_PTE_LEAF_ATTR_PERMS))
+		return false;
+
+	/*
+	 * Skip updating if we are trying to recreate exactly the same mapping
+	 * or to reduce the access permissions only. And update the valid leaf
+	 * PTE without break-before-make if we are trying to add more access
+	 * permissions only.
+	 */
+	old_attr = (old & KVM_PTE_LEAF_ATTR_PERMS) ^ KVM_PTE_LEAF_ATTR_HI_S2_XN;
+	new_attr = (new & KVM_PTE_LEAF_ATTR_PERMS) ^ KVM_PTE_LEAF_ATTR_HI_S2_XN;
+	if (new_attr <= old_attr)
+		return true;
+
+	WRITE_ONCE(*ptep, new);
+	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
+
+	return true;
+}
+
 static bool stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 				       kvm_pte_t *ptep,
 				       struct stage2_map_data *data)
 {
+	kvm_pte_t new, old = *ptep;
 	u64 granule = kvm_granule_size(level), phys = data->phys;
+	struct page *page = virt_to_page(ptep);
 
 	if (!kvm_block_mapping_supported(addr, end, phys, level))
 		return false;
 
-	if (kvm_pte_valid(*ptep))
-		put_page(virt_to_page(ptep));
+	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
+	if (kvm_pte_valid(old)) {
+		if (stage2_set_valid_leaf_pte_pre(addr, level, ptep, new, data))
+			goto out;
 
-	if (kvm_set_valid_leaf_pte(ptep, phys, data->attr, level))
-		goto out;
+		/* Update the PTE with break-before-make if it's necessary. */
+		kvm_set_invalid_pte(ptep);
+		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
+		put_page(page);
+	}
 
-	/* There's an existing valid leaf entry, so perform break-before-make */
-	kvm_set_invalid_pte(ptep);
-	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
-	kvm_set_valid_leaf_pte(ptep, phys, data->attr, level);
+	smp_store_release(ptep, new);
+	get_page(page);
 out:
 	data->phys += granule;
 	return true;
@@ -521,7 +553,7 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	}
 
 	if (stage2_map_walker_try_leaf(addr, end, level, ptep, data))
-		goto out_get_page;
+		return 0;
 
 	if (WARN_ON(level == KVM_PGTABLE_MAX_LEVELS - 1))
 		return -EINVAL;
@@ -545,9 +577,8 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	}
 
 	kvm_set_table_pte(ptep, childp);
-
-out_get_page:
 	get_page(page);
+
 	return 0;
 }
 
-- 
2.19.1

