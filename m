Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664932CAD11
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbgLAULc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:11:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9086 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730551AbgLAULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:11:31 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CltWC5cyPzLyHT;
        Wed,  2 Dec 2020 04:10:15 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.186.123) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 2 Dec 2020 04:10:41 +0800
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
Subject: [PATCH v2 2/3] KVM: arm64: Fix handling of merging tables into a block entry
Date:   Wed, 2 Dec 2020 04:10:33 +0800
Message-ID: <20201201201034.116760-3-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20201201201034.116760-1-wangyanan55@huawei.com>
References: <20201201201034.116760-1-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.186.123]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dirty logging case(logging_active == True), we need to collapse a
block entry into a table if necessary. After dirty logging is canceled,
when merging tables back into a block entry, we should not only free
the non-huge page-table pages but also invalidate all the TLB entries of
non-huge mappings for the block. Without enough TLBI, multiple TLB entries
for the memory in the block will be cached.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index b232bdd142a6..23a01dfcb27a 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -496,7 +496,13 @@ static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
 		return 0;
 
 	kvm_set_invalid_pte(ptep);
-	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, 0);
+
+	/*
+	 * Invalidate the whole stage-2, as we may have numerous leaf
+	 * entries below us which would otherwise need invalidating
+	 * individually.
+	 */
+	kvm_call_hyp(__kvm_tlb_flush_vmid, data->mmu);
 	data->anchor = ptep;
 	return 0;
 }
-- 
2.19.1

