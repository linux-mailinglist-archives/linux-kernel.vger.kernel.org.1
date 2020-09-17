Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B419826D0D1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIQBtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:49:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40440 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726245AbgIQBtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:49:20 -0400
X-Greylist: delayed 642 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 21:49:20 EDT
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 58B289521B50BC4F38FB;
        Thu, 17 Sep 2020 09:49:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 09:49:05 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <maz@kernel.org>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v3] KVM: arm64: fix doc warnings in mmu code
Date:   Thu, 17 Sep 2020 09:47:49 +0800
Message-ID: <1600307269-50957-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following warnings caused by mismatch bewteen function parameters
and comments.
arch/arm64/kvm/mmu.c:128: warning: Function parameter or member 'mmu' not described in '__unmap_stage2_range'
arch/arm64/kvm/mmu.c:128: warning: Function parameter or member 'may_block' not described in '__unmap_stage2_range'
arch/arm64/kvm/mmu.c:128: warning: Excess function parameter 'kvm' description in '__unmap_stage2_range'
arch/arm64/kvm/mmu.c:499: warning: Function parameter or member 'writable' not described in 'kvm_phys_addr_ioremap'
arch/arm64/kvm/mmu.c:538: warning: Function parameter or member 'mmu' not described in 'stage2_wp_range'
arch/arm64/kvm/mmu.c:538: warning: Excess function parameter 'kvm' description in 'stage2_wp_range'

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 arch/arm64/kvm/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index e8a51799..aced343 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -114,9 +114,10 @@ static bool kvm_is_device_pfn(unsigned long pfn)
  */
 /**
  * unmap_stage2_range -- Clear stage2 page table entries to unmap a range
- * @kvm:   The VM pointer
+ * @mmu:   The KVM stage-2 MMU pointer
  * @start: The intermediate physical base address of the range to unmap
  * @size:  The size of the area to unmap
+ * @may_block: Whether or not we are permitted to block
  *
  * Clear a range of stage-2 mappings, lowering the various ref-counts.  Must
  * be called while holding mmu_lock (unless for freeing the stage2 pgd before
@@ -493,6 +494,7 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
  * @guest_ipa:	The IPA at which to insert the mapping
  * @pa:		The physical address of the device
  * @size:	The size of the mapping
+ * @writable:   Whether or not to create a writable mapping
  */
 int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 			  phys_addr_t pa, unsigned long size, bool writable)
@@ -530,7 +532,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 
 /**
  * stage2_wp_range() - write protect stage2 memory region range
- * @kvm:	The KVM pointer
+ * @mmu:        The KVM stage-2 MMU pointer
  * @addr:	Start address of range
  * @end:	End address of range
  */
-- 
2.8.1

