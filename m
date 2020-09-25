Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776EC279343
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgIYVYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbgIYVXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:23:50 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379B0C0613D7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:23:50 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a16so3447034pfk.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Qb8go8HycpjH5yveF+PfyYHMqnWZLnSFt7U7sjuOnrE=;
        b=rXGM+YU5BRbaFP3RvtKtUPBu576cAytErIUb3kUMO/E1cSI+ZFLxB0tnLxPI1LI6t0
         z2M2xLrk9a1hsIaIkdFcuZoa2QppeVZYyTjWqrxoJdyL07HBV1G9CFxpMxIlQgEfeURM
         mv/Vpgo2dvH5I+ii4RdBDnR35BNsJ7LpSyJHBqQG19B7wDFRlXgwtOWiFIkp5dpjCC3z
         ImSDfNzIiZthK3CUmuUO/+X4Za4emZUkyOan3n6KgL+ckGJzS1q00jhEL3BNtfjXNpu+
         DaA7K+S7LmrcGnFRaU16qRHRwpjfP3UOFgEP8W07uwVAD90VlyqEbrJIakBGZabbvJqa
         70GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qb8go8HycpjH5yveF+PfyYHMqnWZLnSFt7U7sjuOnrE=;
        b=llD/OojWUpwe/nmVaFvjaUoTWAyic+90n6Hg316qS6pIMP9iXDtdSrAZcCHbfTgaaC
         oxonCQp5T7zOYpjESHymubCWEnzB9O3XZPyIAO+OEht/I7TVpzthbM4aVB9gpsL8UsRp
         g9vfub1jJlHRvwvbaFD+J1iODZpIBMHrLKsvFl75LB1uClNpn7vO1H6JwgVF1TdMpc6F
         /rYc8cKJiNZ/aSqE08xdXkaXSxkan3O0jLOcxnk7nDaAqUwKgsrVKw7iHfEaF1FaLcYA
         EvNZT4Zs1YklE9FLU+iI2QYQMqK1YrBkczPAkc2TH4m7glnNyuTP1bB0psYoQOrYSGZy
         sBwg==
X-Gm-Message-State: AOAM531+0h3CVGbgf9ghyTINTrDarooPquu7UYOQXoOCeaGsKgDTRlJh
        5ddoUraPXYuJmmv5pAD0KNQ/aruaSL7bYe0t3EreqTtn0mPk0kpEPgcRZpshMxzdNbsLm/AxQlL
        c9g6QA/TmvOzIrUvghouMS+P/dIC3afQFA4CYAAUrev95m88EAtIB3rXdMyWOWlVCAGFz/mrt
X-Google-Smtp-Source: ABdhPJysWah3jm8O7Wa66GBxjE9TeS1ZTdGpfHZiqr2pWyjnRuqDAwGoFqvCzWelnOy1dlxCz88T8C8/a2zk
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a17:90b:15c6:: with SMTP id
 lh6mr30176pjb.0.1601069029061; Fri, 25 Sep 2020 14:23:49 -0700 (PDT)
Date:   Fri, 25 Sep 2020 14:23:02 -0700
In-Reply-To: <20200925212302.3979661-1-bgardon@google.com>
Message-Id: <20200925212302.3979661-23-bgardon@google.com>
Mime-Version: 1.0
References: <20200925212302.3979661-1-bgardon@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH 22/22] kvm: mmu: Don't clear write flooding count for direct roots
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

Direct roots don't have a write flooding count because the guest can't
affect that paging structure. Thus there's no need to clear the write
flooding count on a fast CR3 switch for direct roots.

Tested by running kvm-unit-tests and KVM selftests on an Intel Haswell
machine. This series introduced no new failures.

This series can be viewed in Gerrit at:
	https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2538

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c     | 15 +++++++++++----
 arch/x86/kvm/mmu/tdp_mmu.c | 12 ++++++++++++
 arch/x86/kvm/mmu/tdp_mmu.h |  2 ++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0ce7720a72d4e..345c934fabf4c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4267,7 +4267,8 @@ static void nonpaging_init_context(struct kvm_vcpu *vcpu,
 	context->nx = false;
 }
 
-static inline bool is_root_usable(struct kvm_mmu_root_info *root, gpa_t pgd,
+static inline bool is_root_usable(struct kvm *kvm,
+				  struct kvm_mmu_root_info *root, gpa_t pgd,
 				  union kvm_mmu_page_role role)
 {
 	return (role.direct || pgd == root->pgd) &&
@@ -4293,13 +4294,13 @@ static bool cached_root_available(struct kvm_vcpu *vcpu, gpa_t new_pgd,
 	root.pgd = mmu->root_pgd;
 	root.hpa = mmu->root_hpa;
 
-	if (is_root_usable(&root, new_pgd, new_role))
+	if (is_root_usable(vcpu->kvm, &root, new_pgd, new_role))
 		return true;
 
 	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++) {
 		swap(root, mmu->prev_roots[i]);
 
-		if (is_root_usable(&root, new_pgd, new_role))
+		if (is_root_usable(vcpu->kvm, &root, new_pgd, new_role))
 			break;
 	}
 
@@ -4356,7 +4357,13 @@ static void __kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_t new_pgd,
 	 */
 	vcpu_clear_mmio_info(vcpu, MMIO_GVA_ANY);
 
-	__clear_sp_write_flooding_count(to_shadow_page(vcpu->arch.mmu->root_hpa));
+	/*
+	 * If this is a direct root page, it doesn't have a write flooding
+	 * count. Otherwise, clear the write flooding count.
+	 */
+	if (!new_role.direct)
+		__clear_sp_write_flooding_count(
+				to_shadow_page(vcpu->arch.mmu->root_hpa));
 }
 
 void kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_t new_pgd, bool skip_tlb_flush,
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 42dde27decd75..c07831b0c73e1 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -124,6 +124,18 @@ static struct kvm_mmu_page *find_tdp_mmu_root_with_role(
 	return NULL;
 }
 
+hpa_t kvm_tdp_mmu_root_hpa_for_role(struct kvm *kvm,
+				    union kvm_mmu_page_role role)
+{
+	struct kvm_mmu_page *root;
+
+	root = find_tdp_mmu_root_with_role(kvm, role);
+	if (root)
+		return __pa(root->spt);
+
+	return INVALID_PAGE;
+}
+
 static union kvm_mmu_page_role page_role_for_level(struct kvm_vcpu *vcpu,
 						   int level)
 {
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index cc0b7241975aa..2395ffa71bb05 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -9,6 +9,8 @@ void kvm_mmu_init_tdp_mmu(struct kvm *kvm);
 void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm);
 
 bool is_tdp_mmu_root(struct kvm *kvm, hpa_t root);
+hpa_t kvm_tdp_mmu_root_hpa_for_role(struct kvm *kvm,
+				    union kvm_mmu_page_role role);
 hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu);
 void kvm_tdp_mmu_put_root_hpa(struct kvm *kvm, hpa_t root_hpa);
 
-- 
2.28.0.709.gb0816b6eb0-goog

