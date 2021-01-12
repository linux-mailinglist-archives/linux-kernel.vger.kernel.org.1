Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB13F2F3813
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405499AbhALSMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404494AbhALSMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:12:09 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807F8C0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:10:53 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id l7so2038459qth.15
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KchsQSFTsj0RB0+VLV4VScOtPrFxG2k97/Op1w+ZZ0U=;
        b=l1f5hheFIXm+V4MLFEphzsvDHhHrcd4ErXJh3tlJI4+rRSb4RZFZ3+FNc7BFnqcwMO
         tHZUReGsZZ3Bzfqg0N3LMG8xueN0DeLYCCyp3vcqooSJsw1wziaMGDersvHHPO3VNpAQ
         D5/jIvqSSExtWRLkaiwkGC05Wx1EuUUx0FONeZhpsFaIIBG8jwiWEdmKu0wPJ9wr5G94
         U9QUjJWW/uHam2+woFRCFskvLCmMGgekRgEQ/rjBK7r70r15dE9Foe+dhpynIkrdZ60v
         pbBGxPRCZLqGTWdYjXjX4xm3MEGr4MCgWVKw8NM0wX1sC5oYkYvIi7AjTbNLaisABRO9
         ITyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KchsQSFTsj0RB0+VLV4VScOtPrFxG2k97/Op1w+ZZ0U=;
        b=qHvrlgyjbH01YuZkV1FUfhmzUv97XcDHqcWgsVvMt4EtEIX/dDVSEd/QN9kiC7Tng5
         1lriNwHHmLgaoJSnlzxeCeN4OvSWYQfCUwpQTEH2VhV/AeQOmeOg0bUls71zygeoggOk
         UAFVGWZclKYy/0wBxXP/oLIExny5bh+OQ91Myks59mjCoJieQD4eXrU5PVvh1gVNny/v
         Onzf5m2w8P3c2hZ/Vvc+Ar3Scw3RhgqH0WfIDQyMhj13m71T3WeHqKcjY89WVxJK9s79
         GaU0rx4B++rQDvlAllK3fHN90Uwk7nZgOG4K3VH2DrY1/cpllx1MaGB70maRQ8gEGToM
         FY2A==
X-Gm-Message-State: AOAM5324BZRqwBMzt6zQaJX3V+oEoIXiVtCfpwmwrwxD9jcVkPWiLakK
        V+NEhWP9GoGQ/BxTF/IrQ1ubqEL2wqGhRAhMgqFuSwYylIkGfY+OS2XYVYs91oKo4/YrJFuuUyj
        VBYgR4qTCB2LVZPz0SSTlNnXpNreSL308vE88TDgRZYVyVl3UFSNI1V/HEcsuAqnH6dfxRbxb
X-Google-Smtp-Source: ABdhPJyjvLb3B5vkSKmnfKmTxMmDuEIUDlyIlfudy9eydRvb3x4Cx2NTQtHUDZzlTMknTjnAUCHKWnDFyPMt
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a0c:f00e:: with SMTP id
 z14mr635871qvk.25.1610475052661; Tue, 12 Jan 2021 10:10:52 -0800 (PST)
Date:   Tue, 12 Jan 2021 10:10:21 -0800
In-Reply-To: <20210112181041.356734-1-bgardon@google.com>
Message-Id: <20210112181041.356734-5-bgardon@google.com>
Mime-Version: 1.0
References: <20210112181041.356734-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 04/24] kvm: x86/mmu: change TDP MMU yield function returns to
 match cond_resched
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

Currently the TDP MMU yield / cond_resched functions either return
nothing or return true if the TLBs were not flushed. These are confusing
semantics, especially when making control flow decisions in calling
functions.

To clean things up, change both functions to have the same
return value semantics as cond_resched: true if the thread yielded,
false if it did not. If the function yielded in the _flush_ version,
then the TLBs will have been flushed.

Reviewed-by: Peter Feiner <pfeiner@google.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 2ef8615f9dba..b2784514ca2d 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -413,8 +413,15 @@ static inline void tdp_mmu_set_spte_no_dirty_log(struct kvm *kvm,
 			 _mmu->shadow_root_level, _start, _end)
 
 /*
- * Flush the TLB if the process should drop kvm->mmu_lock.
- * Return whether the caller still needs to flush the tlb.
+ * Flush the TLB and yield if the MMU lock is contended or this thread needs to
+ * return control to the scheduler.
+ *
+ * If this function yields, it will also reset the tdp_iter's walk over the
+ * paging structure and the calling function should allow the iterator to
+ * continue its traversal from the paging structure root.
+ *
+ * Return true if this function yielded, the TLBs were flushed, and the
+ * iterator's traversal was reset. Return false if a yield was not needed.
  */
 static bool tdp_mmu_iter_flush_cond_resched(struct kvm *kvm, struct tdp_iter *iter)
 {
@@ -422,18 +429,30 @@ static bool tdp_mmu_iter_flush_cond_resched(struct kvm *kvm, struct tdp_iter *it
 		kvm_flush_remote_tlbs(kvm);
 		cond_resched_lock(&kvm->mmu_lock);
 		tdp_iter_refresh_walk(iter);
-		return false;
-	} else {
 		return true;
-	}
+	} else
+		return false;
 }
 
-static void tdp_mmu_iter_cond_resched(struct kvm *kvm, struct tdp_iter *iter)
+/*
+ * Yield if the MMU lock is contended or this thread needs to return control
+ * to the scheduler.
+ *
+ * If this function yields, it will also reset the tdp_iter's walk over the
+ * paging structure and the calling function should allow the iterator to
+ * continue its traversal from the paging structure root.
+ *
+ * Return true if this function yielded and the iterator's traversal was reset.
+ * Return false if a yield was not needed.
+ */
+static bool tdp_mmu_iter_cond_resched(struct kvm *kvm, struct tdp_iter *iter)
 {
 	if (need_resched() || spin_needbreak(&kvm->mmu_lock)) {
 		cond_resched_lock(&kvm->mmu_lock);
 		tdp_iter_refresh_walk(iter);
-	}
+		return true;
+	} else
+		return false;
 }
 
 /*
@@ -470,7 +489,8 @@ static bool zap_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 		tdp_mmu_set_spte(kvm, &iter, 0);
 
 		if (can_yield)
-			flush_needed = tdp_mmu_iter_flush_cond_resched(kvm, &iter);
+			flush_needed = !tdp_mmu_iter_flush_cond_resched(kvm,
+									&iter);
 		else
 			flush_needed = true;
 	}
@@ -1072,7 +1092,7 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
 
 		tdp_mmu_set_spte(kvm, &iter, 0);
 
-		spte_set = tdp_mmu_iter_flush_cond_resched(kvm, &iter);
+		spte_set = !tdp_mmu_iter_flush_cond_resched(kvm, &iter);
 	}
 
 	if (spte_set)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

