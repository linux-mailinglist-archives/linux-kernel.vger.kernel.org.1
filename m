Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440D72C8407
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgK3MUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:20:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8165 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgK3MUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:20:07 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cl45j6WPjz15K9J;
        Mon, 30 Nov 2020 20:18:49 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.186.123) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 30 Nov 2020 20:19:08 +0800
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
Subject: [RFC PATCH 2/3] KVM: arm64: Fix handling of merging tables into a block entry
Date:   Mon, 30 Nov 2020 20:18:46 +0800
Message-ID: <20201130121847.91808-3-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20201130121847.91808-1-wangyanan55@huawei.com>
References: <20201130121847.91808-1-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.186.123]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dirty logging case(logging_active == True), we need to collapse a block
entry into a table if necessary. After dirty logging is canceled, when merging
tables back into a block entry, we should not only free the non-huge page
tables but also unmap the non-huge mapping for the block. Without the unmap,
inconsistent TLB entries for the pages in the the block will be created.

We could also use unmap_stage2_range API to unmap the non-huge mapping,
but this could potentially free the upper level page-table page which
will be useful later.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 696b6aa83faf..fec8dc9f2baa 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -500,6 +500,9 @@ static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
 	return 0;
 }
 
+static void stage2_flush_dcache(void *addr, u64 size);
+static bool stage2_pte_cacheable(kvm_pte_t pte);
+
 static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 				struct stage2_map_data *data)
 {
@@ -507,9 +510,17 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	struct page *page = virt_to_page(ptep);
 
 	if (data->anchor) {
-		if (kvm_pte_valid(pte))
+		if (kvm_pte_valid(pte)) {
+			kvm_set_invalid_pte(ptep);
+			kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu,
+				     addr, level);
 			put_page(page);
 
+			if (stage2_pte_cacheable(pte))
+				stage2_flush_dcache(kvm_pte_follow(pte),
+						    kvm_granule_size(level));
+		}
+
 		return 0;
 	}
 
@@ -574,7 +585,7 @@ static int stage2_map_walk_table_post(u64 addr, u64 end, u32 level,
  * The behaviour of the LEAF callback then depends on whether or not the
  * anchor has been set. If not, then we're not using a block mapping higher
  * up the table and we perform the mapping at the existing leaves instead.
- * If, on the other hand, the anchor _is_ set, then we drop references to
+ * If, on the other hand, the anchor _is_ set, then we unmap the mapping of
  * all valid leaves so that the pages beneath the anchor can be freed.
  *
  * Finally, the TABLE_POST callback does nothing if the anchor has not
-- 
2.19.1

