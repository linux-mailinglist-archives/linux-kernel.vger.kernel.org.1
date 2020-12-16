Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221EC2DC04B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 13:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgLPM3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 07:29:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9619 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgLPM3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 07:29:41 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CwvYK11p2z15cyv;
        Wed, 16 Dec 2020 20:28:21 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 20:28:51 +0800
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
Subject: [PATCH v2 3/3] KVM: arm64: Mark the page dirty only if the fault is handled successfully
Date:   Wed, 16 Dec 2020 20:28:44 +0800
Message-ID: <20201216122844.25092-4-wangyanan55@huawei.com>
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

We now mark the page dirty and set the bitmap before calling fault handlers
in user_mem_abort(), and we might end up having spurious dirty pages if
update of permissions or mapping has failed.
So, mark the page dirty only if the fault is handled successfully.

Let the guest directly enter again but not return to userspace if we were
trying to recreate the same mapping or only change access permissions
with BBM, which is not permitted in the mapping path.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 arch/arm64/kvm/mmu.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 75814a02d189..72e516a10914 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -879,11 +879,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (vma_pagesize == PAGE_SIZE && !force_pte)
 		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
 							   &pfn, &fault_ipa);
-	if (writable) {
+	if (writable)
 		prot |= KVM_PGTABLE_PROT_W;
-		kvm_set_pfn_dirty(pfn);
-		mark_page_dirty(kvm, gfn);
-	}
 
 	if (fault_status != FSC_PERM && !device)
 		clean_dcache_guest_page(pfn, vma_pagesize);
@@ -911,6 +908,19 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 					     memcache);
 	}
 
+	/* Mark the page dirty only if the fault is handled successfully */
+	if (writable && !ret) {
+		kvm_set_pfn_dirty(pfn);
+		mark_page_dirty(kvm, gfn);
+	}
+
+	/* Let the guest directly enter again if we were trying to recreate the
+	 * same mapping or only change access permissions with BBM, which is not
+	 * permitted in the mapping path.
+	 */
+	if (ret == -EAGAIN)
+		ret = 0;
+
 out_unlock:
 	spin_unlock(&kvm->mmu_lock);
 	kvm_set_pfn_accessed(pfn);
-- 
2.19.1

