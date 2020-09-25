Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7113F27933F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgIYVXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbgIYVXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:23:43 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7F2C0613DA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:23:41 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id r1so258477pjp.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oWnifn6HrnRKD0oI/QDUODqRYBCf1M68/btQOk7Cqz8=;
        b=rvIMmShdKhLZvzrzWVKzDjmRMLaSmqgHKDAcOshq1z1TsJHeaPaayVTUl96VJrRjch
         ONn+brqlySmwvRi138DzYPa78U3WRp6qUhWVbslnGaLX1Tu7bgLfq/2vjNdL048W0+Ye
         6t1bnW57iHch5oSQmMbHgN/uKSfRlrBXxmsRXh3pDRQwRh+rJxoUYo/YrLFZ8vw5bmNU
         quu8MlbvrwATqKo0IzwKeJ0UjUPKZOtLe6TBRoT5NaEuJZXGUIH//9h8DI7OmXK0YM4Q
         RHvqGd8DNgcuQzu1UryR5NjI7ntkr0S5+qXFClB4yxR9VPKatzHnvWquXBaaIN54jlO6
         HSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oWnifn6HrnRKD0oI/QDUODqRYBCf1M68/btQOk7Cqz8=;
        b=aMWWKpzbDHDYnYlB67nl8qLSkm2MgJx8OkxsydXIRwD4YQKSnRvCeEuMEYNnLAh4B6
         YgGGxNMVHuCWNJ3nvjRbO9y2b1bCpUQy8gag7POf377CQ6fmzaZK9IBLRXr44ozyqvRO
         XGE2EsNlKdSCJ51HbsJnJDt0+m72WhKOVZL4QGKgZ0INxLQ5k93eq+z9CS5/UJ/WHqRm
         UqL/35XLemi6DsY12b6GlJBT66rGlMv9/FLvS8k98iFzN2eo+ELHUKg7vIBahRlrL7U2
         nc4N3rYRRHC5THCIPYzX5N/9geuU4no/Y5nLFB/32wTufpPo1mMsDFePTMjeGF2e9II+
         2wKg==
X-Gm-Message-State: AOAM531v+vfzxtnCzomSnd/r/G/JrZ32P2kyNo0zJMMT9uX/KXWjcvM+
        Q5dO++s956WrpE7weSWmo14p0O/IFsVZPVCiHnIMM1zX/o9ZRvN1E+Ipnr7Jo5THDENSntzExtV
        niIUZONTV+geyPkDQfZeLfD6Y8WEEazka4c/ylHvWO/8rLMGBNeJXqlbtrCbGtJs0Y6P245lq
X-Google-Smtp-Source: ABdhPJwFGjQjPll9oi2B2DEy6aojVRSl1c7w0vVXPBRsNk+LzosTN6FQuDjgxauAdjxuM7ukB2CZtkD5ZZWM
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a17:902:d3d1:b029:d2:635f:6616 with SMTP
 id w17-20020a170902d3d1b02900d2635f6616mr1291657plb.28.1601069020961; Fri, 25
 Sep 2020 14:23:40 -0700 (PDT)
Date:   Fri, 25 Sep 2020 14:22:58 -0700
In-Reply-To: <20200925212302.3979661-1-bgardon@google.com>
Message-Id: <20200925212302.3979661-19-bgardon@google.com>
Mime-Version: 1.0
References: <20200925212302.3979661-1-bgardon@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH 18/22] kvm: mmu: Support disabling dirty logging for the tdp MMU
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
 arch/x86/kvm/mmu/tdp_mmu.c | 62 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/mmu/tdp_mmu.h |  2 ++
 3 files changed, 67 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b9074603f9df1..12892fc4f146d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6025,6 +6025,9 @@ void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
 	spin_lock(&kvm->mmu_lock);
 	slot_handle_leaf(kvm, (struct kvm_memory_slot *)memslot,
 			 kvm_mmu_zap_collapsible_spte, true);
+
+	if (kvm->arch.tdp_mmu_enabled)
+		kvm_tdp_mmu_zap_collapsible_sptes(kvm, memslot);
 	spin_unlock(&kvm->mmu_lock);
 }
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index e5cb7f0ec23e8..a2895119655ac 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1099,3 +1099,65 @@ bool kvm_tdp_mmu_slot_set_dirty(struct kvm *kvm, struct kvm_memory_slot *slot)
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
+	int as_id = kvm_mmu_page_as_id(root);
+
+	for_each_tdp_pte_root(iter, root, start, end) {
+		if (!is_shadow_present_pte(iter.old_spte) ||
+		    is_last_spte(iter.old_spte, iter.level))
+			continue;
+
+		pfn = spte_to_pfn(iter.old_spte);
+		if (kvm_is_reserved_pfn(pfn) ||
+		    !PageTransCompoundMap(pfn_to_page(pfn)))
+			continue;
+
+		*iter.sptep = 0;
+		handle_changed_spte(kvm, as_id, iter.gfn, iter.old_spte,
+				    0, iter.level);
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
index 2c9322ba3462b..10e70699c5372 100644
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
2.28.0.709.gb0816b6eb0-goog

