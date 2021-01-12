Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E9D2F381E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406303AbhALSMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406234AbhALSMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:12:37 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1789C0617BE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:11:03 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id m9so2035563pji.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Bz7aEQSXFsShWSFI4jr1fAWxKptbtLQZdb0JsWFe/T4=;
        b=WIMfFERQ4Xukh14xesiGVwRivHrOwlvIM1VnH10WBjHLN47E0UTmjMqc1pp1e3Cbi5
         rdEIvSaUQs8jJV3Xs3QowNAPTZzBqyzrsMSw5wYMGgPsbwRvbK01cLZqf6y3Y4jCxAqk
         Iy+bTmi390GFRoqSG+P5EjEQJxQZe/He6hLTvehW0UAHaxNlK5uDTQj9/cB1gTviUw3f
         EEDI6gSa2hr48+1wZ2yr/l+NMKJqZriOKXqLOvz9Ofe7vpnXwavTBEQirY130KN5lXoh
         QI7taGZix+bfXMuGebFbXSUx29qtN5AoGMjiMjUMVjCEajNO4OiVn3tk990ufVP5KWC6
         CBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Bz7aEQSXFsShWSFI4jr1fAWxKptbtLQZdb0JsWFe/T4=;
        b=DO3if9s/5rtvkb79VPcSp/tnpmxkNUys3drJnXgfVmOjWdm9IvTCG4l+N3p3IpbLIK
         FjyEx+wHcwUDdNRioas4PXHTfNkK6lRHby7rHGIMplRZrQa1f0M5VoE/MLUggor6oWZd
         fWRA4TWBoVpY6oz0rCiFPwxoasheH+uIVVbugKjwcHUSF+IRC2Y1EFlgC4ewanofmFMK
         AVuIxPfAKPeZ0r/ngGroG8VZC4whZYyjjfKrTPZwG01xC5HfpcaCiA5jG09XbNEYjIuZ
         p0Kz+YtVVdfiEKyi0xJxzRuW1V/GJQu8Kygl2GrtkrrTFxqUeuPGZsQDWEwRf07NIkFm
         cpgw==
X-Gm-Message-State: AOAM531L/RF+2cxonSkEO0o1tUlDPvdpiZGiq0CjAVQ70wLrNphRbiBK
        FWDGMhTryryYdKPbApt4DXgAannJOFI7L3imJxwBcyRcoEh2pmDQa8YRAdzoak+8HYZT5yRmdE/
        DnrFREauxBZV0d9Wd2PkqKFsYTdjxZGosZxHcqc70SnNRa3CsQBG//DpweClrEoRFrg9snIN/
X-Google-Smtp-Source: ABdhPJx3MNHD6vCESyQOIuWic2KKIVM1PZUriW2eZxFsECsrdbPU78U/TGfB9KSfHN/sdSYr9T2liY9g9h79
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a17:902:c215:b029:da:b079:b9a3 with SMTP
 id 21-20020a170902c215b02900dab079b9a3mr292723pll.67.1610475063057; Tue, 12
 Jan 2021 10:11:03 -0800 (PST)
Date:   Tue, 12 Jan 2021 10:10:27 -0800
In-Reply-To: <20210112181041.356734-1-bgardon@google.com>
Message-Id: <20210112181041.356734-11-bgardon@google.com>
Mime-Version: 1.0
References: <20210112181041.356734-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 10/24] kvm: x86/mmu: Factor out handle disconnected pt
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

Factor out the code to handle a disconnected subtree of the TDP paging
structure from the code to handle the change to an individual SPTE.
Future commits will build on this to allow asynchronous page freeing.

No functional change intended.

Reviewed-by: Peter Feiner <pfeiner@google.com>

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 75 +++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 55df596696c7..e8f35cd46b4c 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -234,6 +234,49 @@ static void handle_changed_spte_dirty_log(struct kvm *kvm, int as_id, gfn_t gfn,
 	}
 }
 
+/**
+ * handle_disconnected_tdp_mmu_page - handle a pt removed from the TDP structure
+ *
+ * @kvm: kvm instance
+ * @pt: the page removed from the paging structure
+ *
+ * Given a page table that has been removed from the TDP paging structure,
+ * iterates through the page table to clear SPTEs and free child page tables.
+ */
+static void handle_disconnected_tdp_mmu_page(struct kvm *kvm, u64 *pt)
+{
+	struct kvm_mmu_page *sp;
+	gfn_t gfn;
+	int level;
+	u64 old_child_spte;
+	int i;
+
+	sp = sptep_to_sp(pt);
+	gfn = sp->gfn;
+	level = sp->role.level;
+
+	trace_kvm_mmu_prepare_zap_page(sp);
+
+	list_del(&sp->link);
+
+	if (sp->lpage_disallowed)
+		unaccount_huge_nx_page(kvm, sp);
+
+	for (i = 0; i < PT64_ENT_PER_PAGE; i++) {
+		old_child_spte = READ_ONCE(*(pt + i));
+		WRITE_ONCE(*(pt + i), 0);
+		handle_changed_spte(kvm, kvm_mmu_page_as_id(sp),
+			gfn + (i * KVM_PAGES_PER_HPAGE(level - 1)),
+			old_child_spte, 0, level - 1);
+	}
+
+	kvm_flush_remote_tlbs_with_address(kvm, gfn,
+					   KVM_PAGES_PER_HPAGE(level));
+
+	free_page((unsigned long)pt);
+	kmem_cache_free(mmu_page_header_cache, sp);
+}
+
 /**
  * handle_changed_spte - handle bookkeeping associated with an SPTE change
  * @kvm: kvm instance
@@ -254,10 +297,6 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 	bool was_leaf = was_present && is_last_spte(old_spte, level);
 	bool is_leaf = is_present && is_last_spte(new_spte, level);
 	bool pfn_changed = spte_to_pfn(old_spte) != spte_to_pfn(new_spte);
-	u64 *pt;
-	struct kvm_mmu_page *sp;
-	u64 old_child_spte;
-	int i;
 
 	WARN_ON(level > PT64_ROOT_MAX_LEVEL);
 	WARN_ON(level < PG_LEVEL_4K);
@@ -321,31 +360,9 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 	 * Recursively handle child PTs if the change removed a subtree from
 	 * the paging structure.
 	 */
-	if (was_present && !was_leaf && (pfn_changed || !is_present)) {
-		pt = spte_to_child_pt(old_spte, level);
-		sp = sptep_to_sp(pt);
-
-		trace_kvm_mmu_prepare_zap_page(sp);
-
-		list_del(&sp->link);
-
-		if (sp->lpage_disallowed)
-			unaccount_huge_nx_page(kvm, sp);
-
-		for (i = 0; i < PT64_ENT_PER_PAGE; i++) {
-			old_child_spte = READ_ONCE(*(pt + i));
-			WRITE_ONCE(*(pt + i), 0);
-			handle_changed_spte(kvm, as_id,
-				gfn + (i * KVM_PAGES_PER_HPAGE(level - 1)),
-				old_child_spte, 0, level - 1);
-		}
-
-		kvm_flush_remote_tlbs_with_address(kvm, gfn,
-						   KVM_PAGES_PER_HPAGE(level));
-
-		free_page((unsigned long)pt);
-		kmem_cache_free(mmu_page_header_cache, sp);
-	}
+	if (was_present && !was_leaf && (pfn_changed || !is_present))
+		handle_disconnected_tdp_mmu_page(kvm,
+				spte_to_child_pt(old_spte, level));
 }
 
 static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
-- 
2.30.0.284.gd98b1dd5eaa7-goog

