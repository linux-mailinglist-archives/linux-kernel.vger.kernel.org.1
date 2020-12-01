Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617642CAD13
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404438AbgLAULf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:11:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9087 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730533AbgLAULc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:11:32 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CltWC5FSFzLy9V;
        Wed,  2 Dec 2020 04:10:15 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.186.123) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 2 Dec 2020 04:10:42 +0800
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
Subject: [PATCH v2 3/3] KVM: arm64: Add usage of stage 2 fault lookup level in user_mem_abort()
Date:   Wed, 2 Dec 2020 04:10:34 +0800
Message-ID: <20201201201034.116760-4-wangyanan55@huawei.com>
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

If we get a FSC_PERM fault, just using (logging_active && writable) to
determine calling kvm_pgtable_stage2_map(). There will be two more cases
we should consider.

(1) After logging_active is configged back to false from true. When we
get a FSC_PERM fault with write_fault and adjustment of hugepage is needed,
we should merge tables back to a block entry. This case is ignored by still
calling kvm_pgtable_stage2_relax_perms(), which will lead to an endless
loop and guest panic due to soft lockup.

(2) We use (FSC_PERM && logging_active && writable) to determine
collapsing a block entry into a table by calling kvm_pgtable_stage2_map().
But sometimes we may only need to relax permissions when trying to write
to a page other than a block.
In this condition,using kvm_pgtable_stage2_relax_perms() will be fine.

The ISS filed bit[1:0] in ESR_EL2 regesiter indicates the stage2 lookup
level at which a D-abort or I-abort occurred. By comparing granule of
the fault lookup level with vma_pagesize, we can strictly distinguish
conditions of calling kvm_pgtable_stage2_relax_perms() or
kvm_pgtable_stage2_map(), and the above two cases will be well considered.

Suggested-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 arch/arm64/include/asm/esr.h         |  1 +
 arch/arm64/include/asm/kvm_emulate.h |  5 +++++
 arch/arm64/kvm/mmu.c                 | 11 +++++++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 22c81f1edda2..85a3e49f92f4 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -104,6 +104,7 @@
 /* Shared ISS fault status code(IFSC/DFSC) for Data/Instruction aborts */
 #define ESR_ELx_FSC		(0x3F)
 #define ESR_ELx_FSC_TYPE	(0x3C)
+#define ESR_ELx_FSC_LEVEL	(0x03)
 #define ESR_ELx_FSC_EXTABT	(0x10)
 #define ESR_ELx_FSC_SERROR	(0x11)
 #define ESR_ELx_FSC_ACCESS	(0x08)
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 5ef2669ccd6c..00bc6f1234ba 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -350,6 +350,11 @@ static __always_inline u8 kvm_vcpu_trap_get_fault_type(const struct kvm_vcpu *vc
 	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC_TYPE;
 }
 
+static __always_inline u8 kvm_vcpu_trap_get_fault_level(const struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC_LEVEL;
+}
+
 static __always_inline bool kvm_vcpu_abt_issea(const struct kvm_vcpu *vcpu)
 {
 	switch (kvm_vcpu_trap_get_fault(vcpu)) {
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 1a01da9fdc99..75814a02d189 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -754,10 +754,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	gfn_t gfn;
 	kvm_pfn_t pfn;
 	bool logging_active = memslot_is_logging(memslot);
-	unsigned long vma_pagesize;
+	unsigned long fault_level = kvm_vcpu_trap_get_fault_level(vcpu);
+	unsigned long vma_pagesize, fault_granule;
 	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
 	struct kvm_pgtable *pgt;
 
+	fault_granule = 1UL << ARM64_HW_PGTABLE_LEVEL_SHIFT(fault_level);
 	write_fault = kvm_is_write_fault(vcpu);
 	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
 	VM_BUG_ON(write_fault && exec_fault);
@@ -896,7 +898,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	else if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))
 		prot |= KVM_PGTABLE_PROT_X;
 
-	if (fault_status == FSC_PERM && !(logging_active && writable)) {
+	/*
+	 * Under the premise of getting a FSC_PERM fault, we just need to relax
+	 * permissions only if vma_pagesize equals fault_granule. Otherwise,
+	 * kvm_pgtable_stage2_map() should be called to change block size.
+	 */
+	if (fault_status == FSC_PERM && vma_pagesize == fault_granule) {
 		ret = kvm_pgtable_stage2_relax_perms(pgt, fault_ipa, prot);
 	} else {
 		ret = kvm_pgtable_stage2_map(pgt, fault_ipa, vma_pagesize,
-- 
2.19.1

