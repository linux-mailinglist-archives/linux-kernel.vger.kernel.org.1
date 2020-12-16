Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CDE2DC04E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 13:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgLPM3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 07:29:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9618 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgLPM3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 07:29:47 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CwvYK0kxmz15cyD;
        Wed, 16 Dec 2020 20:28:21 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 20:28:50 +0800
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
        Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v2 2/3] KVM: arm64: Add prejudgement for relaxing permissions only case in stage2 translation fault handler
Date:   Wed, 16 Dec 2020 20:28:43 +0800
Message-ID: <20201216122844.25092-3-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20201216122844.25092-1-wangyanan55@huawei.com>
References: <20201216122844.25092-1-wangyanan55@huawei.com>
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

(1) If there are some vCPUs accessing the same GPA at the same time and
the leaf PTE is not set yet, then they will all cause translation faults
and the first vCPU holding mmu_lock will set valid leaf PTE, and the
others will later update the old PTE with a new one if they are different.

(2) When changing a leaf entry or a table entry with break-before-make,
if there are some vCPUs accessing the same GPA just catch the moment when
the target PTE is set invalid in a BBM procedure coincidentally, they will
all cause translation faults and will later update the old PTE with a new
one if they are different.

The worst case can be like this: vCPU A causes a translation fault with RW
prot and sets the leaf PTE with RW permissions, and then the next vCPU B
with RO prot updates the PTE back to RO permissions with break-before-make.
And the BBM-invalid moment may trigger more unnecessary translation faults,
then some useless small loops might occur which could lead to vCPU stuck.

To avoid unnecessary update and small loops, add prejudgement in the
translation fault handler: Skip updating the PTE with break-before-make
if we are trying to recreate the exact same mapping or only change the
access permissions. Actually, change of permissions will be handled
through the relax_perms path next time if necessary.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 350f9f810930..8225ced49bad 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -45,6 +45,10 @@
 
 #define KVM_PTE_LEAF_ATTR_HI_S2_XN	BIT(54)
 
+#define KVM_PTE_LEAF_ATTR_S2_PERMS	(KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | \
+					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
+					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
+
 struct kvm_pgtable_walk_data {
 	struct kvm_pgtable		*pgt;
 	struct kvm_pgtable_walker	*walker;
@@ -460,7 +464,7 @@ static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
 	return 0;
 }
 
-static bool stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
+static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 				       kvm_pte_t *ptep,
 				       struct stage2_map_data *data)
 {
@@ -469,13 +473,18 @@ static bool stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 	struct page *page = virt_to_page(ptep);
 
 	if (!kvm_block_mapping_supported(addr, end, phys, level))
-		return false;
+		return 1;
 
 	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
 	if (kvm_pte_valid(old)) {
-		/* Tolerate KVM recreating the exact same mapping */
-		if (old == new)
-			goto out;
+		/*
+		 * Skip updating the PTE with break-before-make if we are trying
+		 * to recreate the exact same mapping or only change the access
+		 * permissions. Actually, change of permissions will be handled
+		 * through the relax_perms path next time if necessary.
+		 */
+		if (!((old ^ new) & (~KVM_PTE_LEAF_ATTR_S2_PERMS)))
+			return -EAGAIN;
 
 		/* There's an existing different valid leaf entry, so perform
 		 * break-before-make.
@@ -487,9 +496,8 @@ static bool stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 
 	smp_store_release(ptep, new);
 	get_page(page);
-out:
 	data->phys += granule;
-	return true;
+	return 0;
 }
 
 static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
@@ -517,6 +525,7 @@ static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
 static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 				struct stage2_map_data *data)
 {
+	int ret;
 	kvm_pte_t *childp, pte = *ptep;
 	struct page *page = virt_to_page(ptep);
 
@@ -527,8 +536,9 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 		return 0;
 	}
 
-	if (stage2_map_walker_try_leaf(addr, end, level, ptep, data))
-		return 0;
+	ret = stage2_map_walker_try_leaf(addr, end, level, ptep, data);
+	if (ret <= 0)
+		return ret;
 
 	if (WARN_ON(level == KVM_PGTABLE_MAX_LEVELS - 1))
 		return -EINVAL;
-- 
2.19.1

