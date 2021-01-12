Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE242F3812
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391533AbhALSML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404378AbhALSMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:12:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EC4C0617AA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:10:55 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n205so3235892ybf.20
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1RYyaiKrhxGY31HgCVLvmle8FD7J6aNbeg18wopI17w=;
        b=QzsHfGoZge4Tb0qpqS9E0KA0be65MK8NJEQ07kY3AMb52ePOtedWnLL4yOA8D1BJuj
         Im4H1Pu4wgPuRqL5r1RZ5OtPG13r4toAaY2sQESin9WbNEdIlpxBNv0dpD0lwpW1QHb1
         ny1OmmNFuqSTA//72zziaIc+hExL4sj0jLH6GooUlmnhkPEpQEaqYdn1ObZsp2ZQktWj
         TvNNAKTmeCPaVZWXbmcmQxklXekSKu+XPvbBaZqSwnHOL05uAafOBhKNSERZy3mYykeM
         8qlGhbkveJNM1EXCMGhiu+P00t6fpZVSEBmSedxsk5Hj2xHOyP+RUX47Rov9LuVT7w2Y
         etaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1RYyaiKrhxGY31HgCVLvmle8FD7J6aNbeg18wopI17w=;
        b=NxmeJ6uETMYfectteUAOranBW9e+83cDFNKa2LRRSxMw/0w3l+DfY3A4ZpXaig/PtZ
         dEGh/vhJAK5JBlO+jYnWtFJl+VCgaIXr0WO6OsD7ErAuw21gE9SjThhmHj4PC0ReWO/Q
         MVN5KAny+9aRlbXqeFqM5O0arkLo2ghXMHjGF0MJVmXBxQrCyegglyU6pblbNMpgET3A
         RKdFDRXurSN9WrFWbbfWP5ML0MsRbeeuCh2OG3YFyD8vmTHNGzqSUm6CGnnO+8dEPf1L
         CvxZD4+iACVG0qMAKmABS+xpUGMX73AUNDu427hCB+t8GIIOK0SgRlHYGKroBA5g2RPf
         Vw8w==
X-Gm-Message-State: AOAM533IGK1+Qfpxr1ZMIwxJE/Xq+HGIlBwFVRogZ3k7qxUIW6nMs+pb
        GtSGkAdtKK/p+Hc7p9rlEUJJ3O28tmQ0IIDPW38mL2wlS0dhq4XGpaL4XKgpe3jpYMXkUAiAZ/E
        dcnNcF89Npp26tl0pEKTAzNAnVAEm+056ZKAMsiLv83UzGp/uRQUehIiQcaXiwrsI6H5iGVqv
X-Google-Smtp-Source: ABdhPJzUAxlBTg7TdgX2m1CDdii/yjGV+Nvq+y2ojT5UWDQOyO+BguxlCYQT3zrCdjHIpSY+k/d01EsB2t4M
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a25:aa45:: with SMTP id
 s63mr878778ybi.471.1610475054223; Tue, 12 Jan 2021 10:10:54 -0800 (PST)
Date:   Tue, 12 Jan 2021 10:10:22 -0800
In-Reply-To: <20210112181041.356734-1-bgardon@google.com>
Message-Id: <20210112181041.356734-6-bgardon@google.com>
Mime-Version: 1.0
References: <20210112181041.356734-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 05/24] kvm: x86/mmu: Fix yielding in TDP MMU
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
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

There are two problems with the way the TDP MMU yields in long running
functions. 1.) Given certain conditions, the function may not yield
reliably / frequently enough. 2.) In some functions the TDP iter risks
not making forward progress if two threads livelock yielding to
one another.

Case 1 is possible if for example, a paging structure was very large
but had few, if any writable entries. wrprot_gfn_range could traverse many
entries before finding a writable entry and yielding.

Case 2 is possible if two threads were trying to execute wrprot_gfn_range.
Each could write protect an entry and then yield. This would reset the
tdp_iter's walk over the paging structure and the loop would end up
repeating the same entry over and over, preventing either thread from
making forward progress.

Fix these issues by moving the yield to the beginning of the loop,
before other checks and only yielding if the loop has made forward
progress since the last yield.

Fixes: a6a0b05da9f3 ("kvm: x86/mmu: Support dirty logging for the TDP MMU")
Reviewed-by: Peter Feiner <pfeiner@google.com>

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 83 +++++++++++++++++++++++++++++++-------
 1 file changed, 69 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index b2784514ca2d..1987da0da66e 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -470,9 +470,23 @@ static bool zap_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 			  gfn_t start, gfn_t end, bool can_yield)
 {
 	struct tdp_iter iter;
+	gfn_t last_goal_gfn = start;
 	bool flush_needed = false;
 
 	tdp_root_for_each_pte(iter, root, start, end) {
+		/* Ensure forward progress has been made before yielding. */
+		if (can_yield && iter.goal_gfn != last_goal_gfn &&
+		    tdp_mmu_iter_flush_cond_resched(kvm, &iter)) {
+			last_goal_gfn = iter.goal_gfn;
+			flush_needed = false;
+			/*
+			 * Yielding caused the paging structure walk to be
+			 * reset so skip to the next iteration to continue the
+			 * walk from the root.
+			 */
+			continue;
+		}
+
 		if (!is_shadow_present_pte(iter.old_spte))
 			continue;
 
@@ -487,12 +501,7 @@ static bool zap_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 			continue;
 
 		tdp_mmu_set_spte(kvm, &iter, 0);
-
-		if (can_yield)
-			flush_needed = !tdp_mmu_iter_flush_cond_resched(kvm,
-									&iter);
-		else
-			flush_needed = true;
+		flush_needed = true;
 	}
 	return flush_needed;
 }
@@ -850,12 +859,25 @@ static bool wrprot_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 {
 	struct tdp_iter iter;
 	u64 new_spte;
+	gfn_t last_goal_gfn = start;
 	bool spte_set = false;
 
 	BUG_ON(min_level > KVM_MAX_HUGEPAGE_LEVEL);
 
 	for_each_tdp_pte_min_level(iter, root->spt, root->role.level,
 				   min_level, start, end) {
+		/* Ensure forward progress has been made before yielding. */
+		if (iter.goal_gfn != last_goal_gfn &&
+		    tdp_mmu_iter_cond_resched(kvm, &iter)) {
+			last_goal_gfn = iter.goal_gfn;
+			/*
+			 * Yielding caused the paging structure walk to be
+			 * reset so skip to the next iteration to continue the
+			 * walk from the root.
+			 */
+			continue;
+		}
+
 		if (!is_shadow_present_pte(iter.old_spte) ||
 		    !is_last_spte(iter.old_spte, iter.level))
 			continue;
@@ -864,8 +886,6 @@ static bool wrprot_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 
 		tdp_mmu_set_spte_no_dirty_log(kvm, &iter, new_spte);
 		spte_set = true;
-
-		tdp_mmu_iter_cond_resched(kvm, &iter);
 	}
 	return spte_set;
 }
@@ -906,9 +926,22 @@ static bool clear_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 {
 	struct tdp_iter iter;
 	u64 new_spte;
+	gfn_t last_goal_gfn = start;
 	bool spte_set = false;
 
 	tdp_root_for_each_leaf_pte(iter, root, start, end) {
+		/* Ensure forward progress has been made before yielding. */
+		if (iter.goal_gfn != last_goal_gfn &&
+		    tdp_mmu_iter_cond_resched(kvm, &iter)) {
+			last_goal_gfn = iter.goal_gfn;
+			/*
+			 * Yielding caused the paging structure walk to be
+			 * reset so skip to the next iteration to continue the
+			 * walk from the root.
+			 */
+			continue;
+		}
+
 		if (spte_ad_need_write_protect(iter.old_spte)) {
 			if (is_writable_pte(iter.old_spte))
 				new_spte = iter.old_spte & ~PT_WRITABLE_MASK;
@@ -923,8 +956,6 @@ static bool clear_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 
 		tdp_mmu_set_spte_no_dirty_log(kvm, &iter, new_spte);
 		spte_set = true;
-
-		tdp_mmu_iter_cond_resched(kvm, &iter);
 	}
 	return spte_set;
 }
@@ -1029,9 +1060,22 @@ static bool set_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 {
 	struct tdp_iter iter;
 	u64 new_spte;
+	gfn_t last_goal_gfn = start;
 	bool spte_set = false;
 
 	tdp_root_for_each_pte(iter, root, start, end) {
+		/* Ensure forward progress has been made before yielding. */
+		if (iter.goal_gfn != last_goal_gfn &&
+		    tdp_mmu_iter_cond_resched(kvm, &iter)) {
+			last_goal_gfn = iter.goal_gfn;
+			/*
+			 * Yielding caused the paging structure walk to be
+			 * reset so skip to the next iteration to continue the
+			 * walk from the root.
+			 */
+			continue;
+		}
+
 		if (!is_shadow_present_pte(iter.old_spte))
 			continue;
 
@@ -1039,8 +1083,6 @@ static bool set_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 
 		tdp_mmu_set_spte(kvm, &iter, new_spte);
 		spte_set = true;
-
-		tdp_mmu_iter_cond_resched(kvm, &iter);
 	}
 
 	return spte_set;
@@ -1078,9 +1120,23 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
 {
 	struct tdp_iter iter;
 	kvm_pfn_t pfn;
+	gfn_t last_goal_gfn = start;
 	bool spte_set = false;
 
 	tdp_root_for_each_pte(iter, root, start, end) {
+		/* Ensure forward progress has been made before yielding. */
+		if (iter.goal_gfn != last_goal_gfn &&
+		    tdp_mmu_iter_flush_cond_resched(kvm, &iter)) {
+			last_goal_gfn = iter.goal_gfn;
+			spte_set = false;
+			/*
+			 * Yielding caused the paging structure walk to be
+			 * reset so skip to the next iteration to continue the
+			 * walk from the root.
+			 */
+			continue;
+		}
+
 		if (!is_shadow_present_pte(iter.old_spte) ||
 		    is_last_spte(iter.old_spte, iter.level))
 			continue;
@@ -1091,8 +1147,7 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
 			continue;
 
 		tdp_mmu_set_spte(kvm, &iter, 0);
-
-		spte_set = !tdp_mmu_iter_flush_cond_resched(kvm, &iter);
+		spte_set = true;
 	}
 
 	if (spte_set)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

