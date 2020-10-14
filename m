Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEC128E659
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389404AbgJNS2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389369AbgJNS1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:27:46 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19757C0613D9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:27:34 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id y17so343515qkf.15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=784t8a81EqGn9vK4Ge4RJ0ESjE9KKEOgOyqmynlKty8=;
        b=s0GCOtZv55Gjd1XHXBNohAfLhPXXnWUIpl5wRjQa0+qx7m9d24d8lNaf2d5GleFDYx
         FleZ1dK7ZTfsCYqTl3v8ni6T9+4V+z2sDpnoQRfG2nA/pIO4I4vguFIGpMIQZdbmggBo
         87aIbQ3ugz5pmTHQDNkNwjji7NWAj9QFs4HvpHNHsVtEzowDK/n+MXtcofriSQVxpBCz
         AOF1ImkpJ3oHPXTl5IyeBlaNcRU0Mph+k+mCNJtE1a7dwdvyHgrYkHPvK3lkbAxzgd70
         xLH0KM8bpSCr+0Q9RXVm88RwpmUaA48qFNld6VHL5c2f2OSaDu506sYRjPsZkCnaJrA+
         Oy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=784t8a81EqGn9vK4Ge4RJ0ESjE9KKEOgOyqmynlKty8=;
        b=R6o2veoQQbzaHKOWjZtAbTvX1aVshYfLjkG/QP4Gl5s84Om0Dg60Ftx9fzRUux5xrv
         V3cE8lxn73jqPuKwj7dMbXxz3fDFxBa+LyPqRBte557qH0RwK0rsqqxNvkXAZz/4nTbh
         u+zpDeQM0rJnf287t2G4dunYCogHSlqDh5BA6xlJ00zlSnRfRZzijJTPAlo6iRaEjo/1
         Qqp2d1Ah5Eb/6pBsUHVaNpL84Owh/mwh/Tci6fT4AdL2z8tT6ciLestAS3N0c6b2gYi5
         oMhWch+b/YxRmUSsUfbkjxkNVvKAN9+uGA6LgD4uLN4PiCqOiSnYTNwySOxWR8fuTDom
         KH8w==
X-Gm-Message-State: AOAM533diKZKIKclF6aScMTkmJdc7kzfcybgVdY04db1URQVHMQ05fC8
        N876MiqOO9alDnxSaDIulRrf3qRn9eM9pjxp9EvN2AFiW5EmTFt6DTVgaOJaWyDlPPboYrRh1VW
        gKxO9ZbTMRXA+NOp9tE+NX/WbV6YpumayeI5aZDW21yoTbYng0Hg+cUN9wzRpt4oNinRj1UVE
X-Google-Smtp-Source: ABdhPJz0zfyLeokjzsNy8itq7rVjzagA+2DwEboiDW0FQFTIsV+gGl/ieGnSnFL25RShz2/4Btae//px32HM
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a0c:9e0e:: with SMTP id
 p14mr547966qve.25.1602700053163; Wed, 14 Oct 2020 11:27:33 -0700 (PDT)
Date:   Wed, 14 Oct 2020 11:26:56 -0700
In-Reply-To: <20201014182700.2888246-1-bgardon@google.com>
Message-Id: <20201014182700.2888246-17-bgardon@google.com>
Mime-Version: 1.0
References: <20201014182700.2888246-1-bgardon@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v2 16/20] kvm: x86/mmu: Support disabling dirty logging for
 the tdp MMU
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

Dirty logging ultimately breaks down MMU mappings to 4k granularity.
When dirty logging is no longer needed, these granaular mappings
represent a useless performance penalty. When dirty logging is disabled,
search the paging structure for mappings that could be re-constituted
into a large page mapping. Zap those mappings so that they can be
faulted in again at a higher mapping level.

Tested by running kvm-unit-tests and KVM selftests on an Intel Haswell
machine. This series introduced no new failures.

This series can be viewed in Gerrit at:
	https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2538

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c     |  3 ++
 arch/x86/kvm/mmu/tdp_mmu.c | 59 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/mmu/tdp_mmu.h |  2 ++
 3 files changed, 64 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b2ce57761d2f1..8fcf5e955c475 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5918,6 +5918,9 @@ void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
 	spin_lock(&kvm->mmu_lock);
 	slot_handle_leaf(kvm, (struct kvm_memory_slot *)memslot,
 			 kvm_mmu_zap_collapsible_spte, true);
+
+	if (kvm->arch.tdp_mmu_enabled)
+		kvm_tdp_mmu_zap_collapsible_sptes(kvm, memslot);
 	spin_unlock(&kvm->mmu_lock);
 }
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 099c7d68aeb1d..94624cc1df84c 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1019,3 +1019,62 @@ bool kvm_tdp_mmu_slot_set_dirty(struct kvm *kvm, struct kvm_memory_slot *slot)
 	return spte_set;
 }
 
+/*
+ * Clear non-leaf entries (and free associated page tables) which could
+ * be replaced by large mappings, for GFNs within the slot.
+ */
+static void zap_collapsible_spte_range(struct kvm *kvm,
+				       struct kvm_mmu_page *root,
+				       gfn_t start, gfn_t end)
+{
+	struct tdp_iter iter;
+	kvm_pfn_t pfn;
+	bool spte_set = false;
+
+	tdp_root_for_each_pte(iter, root, start, end) {
+		if (!is_shadow_present_pte(iter.old_spte) ||
+		    is_last_spte(iter.old_spte, iter.level))
+			continue;
+
+		pfn = spte_to_pfn(iter.old_spte);
+		if (kvm_is_reserved_pfn(pfn) ||
+		    !PageTransCompoundMap(pfn_to_page(pfn)))
+			continue;
+
+		tdp_mmu_set_spte(kvm, &iter, 0);
+		spte_set = true;
+
+		spte_set = !tdp_mmu_iter_cond_resched(kvm, &iter);
+	}
+
+	if (spte_set)
+		kvm_flush_remote_tlbs(kvm);
+}
+
+/*
+ * Clear non-leaf entries (and free associated page tables) which could
+ * be replaced by large mappings, for GFNs within the slot.
+ */
+void kvm_tdp_mmu_zap_collapsible_sptes(struct kvm *kvm,
+				       const struct kvm_memory_slot *slot)
+{
+	struct kvm_mmu_page *root;
+	int root_as_id;
+
+	for_each_tdp_mmu_root(kvm, root) {
+		root_as_id = kvm_mmu_page_as_id(root);
+		if (root_as_id != slot->as_id)
+			continue;
+
+		/*
+		 * Take a reference on the root so that it cannot be freed if
+		 * this thread releases the MMU lock and yields in this loop.
+		 */
+		get_tdp_mmu_root(kvm, root);
+
+		zap_collapsible_spte_range(kvm, root, slot->base_gfn,
+					   slot->base_gfn + slot->npages);
+
+		put_tdp_mmu_root(kvm, root);
+	}
+}
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index add8bb97c56dd..dc4cdc5cc29f5 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -38,4 +38,6 @@ void kvm_tdp_mmu_clear_dirty_pt_masked(struct kvm *kvm,
 				       gfn_t gfn, unsigned long mask,
 				       bool wrprot);
 bool kvm_tdp_mmu_slot_set_dirty(struct kvm *kvm, struct kvm_memory_slot *slot);
+void kvm_tdp_mmu_zap_collapsible_sptes(struct kvm *kvm,
+				       const struct kvm_memory_slot *slot);
 #endif /* __KVM_X86_MMU_TDP_MMU_H */
-- 
2.28.0.1011.ga647a8990f-goog

