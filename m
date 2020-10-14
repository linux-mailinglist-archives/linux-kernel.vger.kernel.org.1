Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390FF28E65E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbgJNS10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388661AbgJNS1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:27:25 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B94C0613E2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:27:20 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id x3so123314pgo.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=pmB0fJH6G/7pCwGkSP5eKp4yjsD8tyP5Ccs7FrGYSIE=;
        b=Lt4lARNVq3oUmC6LOEGVbaugWfqxCdFnU9VBXlGGaHp9frXxtFU2lIwKb33FWGZ5bz
         o/yqkXycm7zXcFFDJy9Y2vQYeYO7n3xPxPm9wVshN4KmRUvFlb+Sh0f+b/xsKSn/B7pU
         97YnhUU6aVvPhTI4feVAui61SHzChYhZRmrXlag6hLwLdZlFLMrY0hIimqBMGAvcbgiW
         /xIB3FL55GLcpaB0whR5R+TyOLCVSAEvrgyGMTGt+WTynEHIz6cwxLV3U6ezARXXGvKv
         whwhjKSn12BccMbIfYBPKQbeKnDg0BvjyYrQQLBjTaK3BHHfeRxbtUm6N5RbnXLpEHba
         7AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pmB0fJH6G/7pCwGkSP5eKp4yjsD8tyP5Ccs7FrGYSIE=;
        b=Z+HcQ60YlktV289DbqJnkcBrFevgSVYaTxSPwqo/mKEM559PIBAQ+pDtr095R6yUhw
         aZQshi65Mbrm6HuW5p2dhaVCxhwt9Jwf2rwzrxpO6z11jdMowUssIhc7bud+KMO8PVSB
         GkDB0/1Q2Ty6QtsrlfzuhKuC/KZU3LfZlzNGGZYf7fNtJha+Hhwu2vZljG+Ut1Bhhbtk
         jjPNHR7vRtFx3kznUa67Ruwn1cEzGSq54caBkjnGeFjMnDFM1U9J2m7jon3ooVEour2r
         MkePwNubLGWXx1NMtNgMz+RnIGkKf7a6baLK6Wdon5H98JT5vB0Ct3gFynAwt4fQN4Pb
         qI7g==
X-Gm-Message-State: AOAM531pz5504PN6Rr6jkc7zsOcIDjB+ONcIzvYtko5S2ck/ZQCugvkQ
        VjpV+AMXbj+rBOb8G369nIFY3HZgIb7Xj937PcJ7yalJmMB14dMyfFs4+anZJpyN7Qa8taV/Sym
        hjEGsU5RKg+XxAHjb1pkr8Xh4e3sHaZJ18/T0MBnMcg0UDRmSjyIf3zo0ryk16BZLTtuXR7z+
X-Google-Smtp-Source: ABdhPJyXvuUY3lw4g5yd24ffkp6Lp/jBsszBP6LsC3kfd+f5bG3lP57XTxJlcwNaLMiyGQa5kfXfjzUAqicL
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a17:90a:ab92:: with SMTP id
 n18mr423994pjq.233.1602700040119; Wed, 14 Oct 2020 11:27:20 -0700 (PDT)
Date:   Wed, 14 Oct 2020 11:26:49 -0700
In-Reply-To: <20201014182700.2888246-1-bgardon@google.com>
Message-Id: <20201014182700.2888246-10-bgardon@google.com>
Mime-Version: 1.0
References: <20201014182700.2888246-1-bgardon@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v2 09/20] kvm: x86/mmu: Remove disallowed_hugepage_adjust
 shadow_walk_iterator arg
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

In order to avoid creating executable hugepages in the TDP MMU PF
handler, remove the dependency between disallowed_hugepage_adjust and
the shadow_walk_iterator. This will open the function up to being used
by the TDP MMU PF handler in a future patch.

Tested by running kvm-unit-tests and KVM selftests on an Intel Haswell
machine. This series introduced no new failures.

This series can be viewed in Gerrit at:
	https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2538

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c         | 13 +++++++------
 arch/x86/kvm/mmu/paging_tmpl.h |  3 ++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 05024b8ae5a4d..288b97e96202e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3243,13 +3243,12 @@ static int kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, gfn_t gfn,
 	return level;
 }
 
-static void disallowed_hugepage_adjust(struct kvm_shadow_walk_iterator it,
-				       gfn_t gfn, kvm_pfn_t *pfnp, int *levelp)
+static void disallowed_hugepage_adjust(u64 spte, gfn_t gfn, int cur_level,
+				       kvm_pfn_t *pfnp, int *levelp)
 {
 	int level = *levelp;
-	u64 spte = *it.sptep;
 
-	if (it.level == level && level > PG_LEVEL_4K &&
+	if (cur_level == level && level > PG_LEVEL_4K &&
 	    is_shadow_present_pte(spte) &&
 	    !is_large_pte(spte)) {
 		/*
@@ -3259,7 +3258,8 @@ static void disallowed_hugepage_adjust(struct kvm_shadow_walk_iterator it,
 		 * patching back for them into pfn the next 9 bits of
 		 * the address.
 		 */
-		u64 page_mask = KVM_PAGES_PER_HPAGE(level) - KVM_PAGES_PER_HPAGE(level - 1);
+		u64 page_mask = KVM_PAGES_PER_HPAGE(level) -
+				KVM_PAGES_PER_HPAGE(level - 1);
 		*pfnp |= gfn & page_mask;
 		(*levelp)--;
 	}
@@ -3292,7 +3292,8 @@ static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 		 * large page, as the leaf could be executable.
 		 */
 		if (nx_huge_page_workaround_enabled)
-			disallowed_hugepage_adjust(it, gfn, &pfn, &level);
+			disallowed_hugepage_adjust(*it.sptep, gfn, it.level,
+						   &pfn, &level);
 
 		base_gfn = gfn & ~(KVM_PAGES_PER_HPAGE(it.level) - 1);
 		if (it.level == level)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 9a1a15f19beb6..50e268eb8e1a9 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -695,7 +695,8 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 		 * large page, as the leaf could be executable.
 		 */
 		if (nx_huge_page_workaround_enabled)
-			disallowed_hugepage_adjust(it, gw->gfn, &pfn, &level);
+			disallowed_hugepage_adjust(*it.sptep, gw->gfn, it.level,
+						   &pfn, &level);
 
 		base_gfn = gw->gfn & ~(KVM_PAGES_PER_HPAGE(it.level) - 1);
 		if (it.level == level)
-- 
2.28.0.1011.ga647a8990f-goog

