Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8E928E645
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388200AbgJNS1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388067AbgJNS1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:27:06 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B85C0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:27:06 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k6so50359pls.22
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4bjkl7LU/ijpP4j3wkVH8RGMkGEhF98fqB9pEclfJrk=;
        b=MogfLG0Ygib8pC0aC4AVyfrCXTiWPZ+I8kFw8RCzn3NdcLonBPkaOwCYFHij0wrUAI
         FC7DasDbwNlLO+rUZlGNaSlybrvy7GnhjbIu+ybG2F207pU+7yDQ3pZwjyA7mz7Se71Y
         IbGhUgcX8ZusRoGk1n+nJVPB5ijxIuMYWUe8jNExK5+bFn/SX2CZz8r0nexXNXueUQ/E
         9x+skWzS9XR/eIuI+oPRvPlaI8ytWfXAyfH7Ve1uqyOucO9S6Nw9Blw5xvSWhcB1PUKI
         sb9+2pWbAnF5Bl7Co9B2gAVjAn4JQKg1Y1w9zfsCP97MMQdo8gsk6cNChxbaeq/oLx/Q
         lfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4bjkl7LU/ijpP4j3wkVH8RGMkGEhF98fqB9pEclfJrk=;
        b=kZUsB6bULpotEW9qlAeChF7PBhsAiVEUxCEVSAuP0gTmJRHb6hrcoeGVuwR26MBNUb
         fgRRTmv/XvXrjfkjLuHd/w37IHPxumergMvq9ADcj2CfrjlzZSALERccqxVXuAYlYHG2
         PWJa9f+JtmOFR9MqF9PkVvO1Udp6M0HqHMRjeEv9MKRnOEZzQqx/r+r3O/450YxJXDQj
         rnkoSLYut1kkdaY5VsnnjJDVSmtKJYm4/CkwvntzDr/KywrxODliF3mzeu04B25X47Gp
         cSBNjrxI62V/N5ZodMNZR1g9Ql0bd1JbEd2CoreUD/FSWiNRCN1czrty7a1JtUb54gNj
         2luw==
X-Gm-Message-State: AOAM531B8N9JU/hUZAnqkaK8WqBYx0Vvr6r4jA65MR15ZMgQ5pLfB2uQ
        0p4Q8Lmm2DSPncG2E1ikp3ndkXixHVUSBJGv1q4P6z8YX9wcnxUkWLyPNWHT5jl/wlzGlsH1KbK
        84ovmWAYBAEg5vgbp0USNOmNJFwmYBEBh2zYPiVyI7zBLbYZjUlc0wbGYyexpJ+snWGD+AyJK
X-Google-Smtp-Source: ABdhPJy35YA8qiNQX7ZBjgjicHgSqdVWg6euqKaGUEbJi3LTSM58YPkjX30wFc214EhwPbtHDhSobtXpgdka
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a62:884d:0:b029:152:1a5f:1123 with SMTP id
 l74-20020a62884d0000b02901521a5f1123mr580761pfd.28.1602700025984; Wed, 14 Oct
 2020 11:27:05 -0700 (PDT)
Date:   Wed, 14 Oct 2020 11:26:41 -0700
In-Reply-To: <20201014182700.2888246-1-bgardon@google.com>
Message-Id: <20201014182700.2888246-2-bgardon@google.com>
Mime-Version: 1.0
References: <20201014182700.2888246-1-bgardon@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v2 01/20] kvm: x86/mmu: Separate making SPTEs from set_spte
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the functions for generating leaf page table entries from the
function that inserts them into the paging structure. This refactoring
will facilitate changes to the MMU sychronization model to use atomic
compare / exchanges (which are not guaranteed to succeed) instead of a
monolithic MMU lock.

No functional change expected.

Tested by running kvm-unit-tests and KVM selftests on an Intel Haswell
machine. This commit introduced no new failures.

This series can be viewed in Gerrit at:
	https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2538

Signed-off-by: Ben Gardon <bgardon@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 49 ++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 32e0e5c0524e5..6c9db349600c8 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2987,20 +2987,15 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
 #define SET_SPTE_NEED_REMOTE_TLB_FLUSH	BIT(1)
 #define SET_SPTE_SPURIOUS		BIT(2)
 
-static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
-		    unsigned int pte_access, int level,
-		    gfn_t gfn, kvm_pfn_t pfn, bool speculative,
-		    bool can_unsync, bool host_writable)
+static int make_spte(struct kvm_vcpu *vcpu, unsigned int pte_access, int level,
+		     gfn_t gfn, kvm_pfn_t pfn, u64 old_spte, bool speculative,
+		     bool can_unsync, bool host_writable, bool ad_disabled,
+		     u64 *new_spte)
 {
 	u64 spte = 0;
 	int ret = 0;
-	struct kvm_mmu_page *sp;
 
-	if (set_mmio_spte(vcpu, sptep, gfn, pfn, pte_access))
-		return 0;
-
-	sp = sptep_to_sp(sptep);
-	if (sp_ad_disabled(sp))
+	if (ad_disabled)
 		spte |= SPTE_AD_DISABLED_MASK;
 	else if (kvm_vcpu_ad_need_write_protect(vcpu))
 		spte |= SPTE_AD_WRPROT_ONLY_MASK;
@@ -3053,8 +3048,8 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 		 * is responsibility of mmu_get_page / kvm_sync_page.
 		 * Same reasoning can be applied to dirty page accounting.
 		 */
-		if (!can_unsync && is_writable_pte(*sptep))
-			goto set_pte;
+		if (!can_unsync && is_writable_pte(old_spte))
+			goto out;
 
 		if (mmu_need_write_protect(vcpu, gfn, can_unsync)) {
 			pgprintk("%s: found shadow page for %llx, marking ro\n",
@@ -3065,15 +3060,37 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 		}
 	}
 
-	if (pte_access & ACC_WRITE_MASK) {
-		kvm_vcpu_mark_page_dirty(vcpu, gfn);
+	if (pte_access & ACC_WRITE_MASK)
 		spte |= spte_shadow_dirty_mask(spte);
-	}
 
 	if (speculative)
 		spte = mark_spte_for_access_track(spte);
 
-set_pte:
+out:
+	*new_spte = spte;
+	return ret;
+}
+
+static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
+		    unsigned int pte_access, int level,
+		    gfn_t gfn, kvm_pfn_t pfn, bool speculative,
+		    bool can_unsync, bool host_writable)
+{
+	u64 spte;
+	struct kvm_mmu_page *sp;
+	int ret;
+
+	if (set_mmio_spte(vcpu, sptep, gfn, pfn, pte_access))
+		return 0;
+
+	sp = sptep_to_sp(sptep);
+
+	ret = make_spte(vcpu, pte_access, level, gfn, pfn, *sptep, speculative,
+			can_unsync, host_writable, sp_ad_disabled(sp), &spte);
+
+	if (spte & PT_WRITABLE_MASK)
+		kvm_vcpu_mark_page_dirty(vcpu, gfn);
+
 	if (*sptep == spte)
 		ret |= SET_SPTE_SPURIOUS;
 	else if (mmu_spte_update(sptep, spte))
-- 
2.28.0.1011.ga647a8990f-goog

