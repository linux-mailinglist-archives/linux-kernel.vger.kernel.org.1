Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6601528E64F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389496AbgJNS1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389429AbgJNS1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:27:48 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24298C0613E5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:27:41 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id q4so70064plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OcS1EoJ2FiK+HayZIKclc/lLgHYhtZFFT/BEnIUqPtw=;
        b=gqrdTZZbZaq/iyuZCewS1i3wq0fFAH+YCBe+xm4GuJhyWNRLH7mIUO6ZXSAI3wTQtH
         X9OtBcm0pQBwuily72zEf8uLqSwvwqgKsXjevutNMjEumteq7vdF9MnbTfywihzv2XcB
         R/NgpsvXSqmdKPF5bemwwijWm7R4ivQHNjhhQt8SPsuQ0ijC81bCgd3J7B6ZubdKKl76
         asFOECVh4dcXsfeOIk/SzZcvzts8AKnn84gTa5RM7CNxw6NO16B2wIBgNbb4F8FZHl47
         mZLaTP6dzehwLPTl+JNX/GJ9i81oBJKyn+JHhyr+KSuFxwpX2se0grNjyYSGOoaMOd3q
         lavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OcS1EoJ2FiK+HayZIKclc/lLgHYhtZFFT/BEnIUqPtw=;
        b=ZpRad1T5b4wdLWGQe9JmlPob/KAC7HKdSz3Gin4CBvlq+B5giwdMFbdrNsEPvdU0Tr
         9Rl9ymdVx7LOzIuD7o4/f5iX8ZlvIgYcxh08rYAQ5DV55v3MaY7hq1WDANH+eUoUVL9a
         Pd2tD4yjwm5kj+Zd5VXzRWZ66HPW7W5XOJYyFw8gRdCIc859o7oJ1TnV/PovQZCGEKq2
         z3iskOdPHlM18AVPzrCsYwsyWSUbLh3csNlHqLtVRBiV4F3qZPF48DhxBmo5+1iY2D+i
         v3sS83BuietTwxkFMHCuPPJ+yN1s+9MG1ejnPX31tISqhlaxFVbP1u4tLbEc11hENgof
         4/Zw==
X-Gm-Message-State: AOAM530WB5B0b/UfBcXwXuHCPAE4VYTuND009bYFc2vJ4W8vmd8szmmU
        Un2jRYLuV/PYEucbGfEJAWGuAiK0jU3FvB8HL5o3nRXe3nym5PJe9UOUtxTwTzBx5aHneOwPVrI
        DecJBI1hTaIy0UXtOZXsIFkH5nkW7dzvHUi1CZeRA0PNPhQ7mLvgfZyry6Wd16jKQGWSGcZLG
X-Google-Smtp-Source: ABdhPJwbIUToJOUkI5LeHYo/HRh0q1F3xz2yZtpM9T4o/hxwf2ISyxtWJvFoOEvLo+A8KLAUpaxEZpK8gdgo
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a17:90b:1496:: with SMTP id
 js22mr522321pjb.20.1602700060562; Wed, 14 Oct 2020 11:27:40 -0700 (PDT)
Date:   Wed, 14 Oct 2020 11:27:00 -0700
In-Reply-To: <20201014182700.2888246-1-bgardon@google.com>
Message-Id: <20201014182700.2888246-21-bgardon@google.com>
Mime-Version: 1.0
References: <20201014182700.2888246-1-bgardon@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v2 20/20] kvm: x86/mmu: NX largepage recovery for TDP MMU
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

When KVM maps a largepage backed region at a lower level in order to
make it executable (i.e. NX large page shattering), it reduces the TLB
performance of that region. In order to avoid making this degradation
permanent, KVM must periodically reclaim shattered NX largepages by
zapping them and allowing them to be rebuilt in the page fault handler.

With this patch, the TDP MMU does not respect KVM's rate limiting on
reclaim. It traverses the entire TDP structure every time. This will be
addressed in a future patch.

Tested by running kvm-unit-tests and KVM selftests on an Intel Haswell
machine. This series introduced no new failures.

This series can be viewed in Gerrit at:
	https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2538

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 13 +++++++++----
 arch/x86/kvm/mmu/mmu_internal.h |  3 +++
 arch/x86/kvm/mmu/tdp_mmu.c      |  6 ++++++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3935c10278736..5c8a35e4c872b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1030,7 +1030,7 @@ static void account_shadowed(struct kvm *kvm, struct kvm_mmu_page *sp)
 	kvm_mmu_gfn_disallow_lpage(slot, gfn);
 }
 
-static void account_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+void account_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	if (sp->lpage_disallowed)
 		return;
@@ -1058,7 +1058,7 @@ static void unaccount_shadowed(struct kvm *kvm, struct kvm_mmu_page *sp)
 	kvm_mmu_gfn_allow_lpage(slot, gfn);
 }
 
-static void unaccount_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+void unaccount_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	--kvm->stat.nx_lpage_splits;
 	sp->lpage_disallowed = false;
@@ -6362,8 +6362,13 @@ static void kvm_recover_nx_lpages(struct kvm *kvm)
 				      struct kvm_mmu_page,
 				      lpage_disallowed_link);
 		WARN_ON_ONCE(!sp->lpage_disallowed);
-		kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
-		WARN_ON_ONCE(sp->lpage_disallowed);
+		if (sp->tdp_mmu_page)
+			kvm_tdp_mmu_zap_gfn_range(kvm, sp->gfn,
+				sp->gfn + KVM_PAGES_PER_HPAGE(sp->role.level));
+		else {
+			kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
+			WARN_ON_ONCE(sp->lpage_disallowed);
+		}
 
 		if (need_resched() || spin_needbreak(&kvm->mmu_lock)) {
 			kvm_mmu_commit_zap_page(kvm, &invalid_list);
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index a7230532bb845..88899a2666d86 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -299,4 +299,7 @@ static inline u64 kvm_mmu_changed_pte_notifier_make_spte(u64 old_spte,
 }
 
 
+void account_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp);
+void unaccount_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp);
+
 #endif /* __KVM_X86_MMU_INTERNAL_H */
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index b1515b89606e1..2949759c6aa84 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -289,6 +289,9 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 
 		list_del(&sp->link);
 
+		if (sp->lpage_disallowed)
+			unaccount_huge_nx_page(kvm, sp);
+
 		for (i = 0; i < PT64_ENT_PER_PAGE; i++) {
 			old_child_spte = *(pt + i);
 			*(pt + i) = 0;
@@ -567,6 +570,9 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 			new_spte = make_nonleaf_spte(child_pt,
 						     !shadow_accessed_mask);
 
+			if (huge_page_disallowed && req_level >= iter.level)
+				account_huge_nx_page(vcpu->kvm, sp);
+
 			tdp_mmu_set_spte(vcpu->kvm, &iter, new_spte);
 		}
 	}
-- 
2.28.0.1011.ga647a8990f-goog

