Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D8A2C8405
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgK3MT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:19:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9074 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgK3MT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:19:56 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cl45T31PPzLxpp;
        Mon, 30 Nov 2020 20:18:37 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.186.123) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 30 Nov 2020 20:19:02 +0800
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
Subject: [RFC PATCH 1/3] KVM: arm64: Fix possible memory leak in kvm stage2
Date:   Mon, 30 Nov 2020 20:18:45 +0800
Message-ID: <20201130121847.91808-2-wangyanan55@huawei.com>
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

When installing a new leaf pte onto an invalid ptep, we need to get_page(ptep).
When just updating a valid leaf ptep, we shouldn't get_page(ptep).
Incorrect page_count of translation tables might lead to memory leak,
when unmapping a stage 2 memory range.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 0271b4a3b9fe..696b6aa83faf 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -186,6 +186,7 @@ static bool kvm_set_valid_leaf_pte(kvm_pte_t *ptep, u64 pa, kvm_pte_t attr,
 		return old == pte;
 
 	smp_store_release(ptep, pte);
+	get_page(virt_to_page(ptep));
 	return true;
 }
 
@@ -476,6 +477,7 @@ static bool stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 	/* There's an existing valid leaf entry, so perform break-before-make */
 	kvm_set_invalid_pte(ptep);
 	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
+	put_page(virt_to_page(ptep));
 	kvm_set_valid_leaf_pte(ptep, phys, data->attr, level);
 out:
 	data->phys += granule;
@@ -512,7 +514,7 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	}
 
 	if (stage2_map_walker_try_leaf(addr, end, level, ptep, data))
-		goto out_get_page;
+		return 0;
 
 	if (WARN_ON(level == KVM_PGTABLE_MAX_LEVELS - 1))
 		return -EINVAL;
@@ -536,9 +538,8 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
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

