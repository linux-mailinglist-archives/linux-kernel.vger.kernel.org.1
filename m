Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB882F3833
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406549AbhALSNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392305AbhALSMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:12:45 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21613C06134D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:11:27 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id gj22so2031624pjb.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VFeIbs3EEJfmUmShc5b4NHNzxuz8HmBwtr3zdhFPFdU=;
        b=TeQ6xmCyxzPNvf9GuBnToRKMeXIiYDGUqc2kFUphQnu7K32zcBxTsE4DjcCEtVaQtF
         lxKWr9yPhKG2FGGHjgsCSIBPMJA4dyDdMVf5sTBzD7p1ahOTIpmQ7LhLCrK0PxWigKIF
         uu6Tkpi31fo2Lo/dEZk8IHrMQt6p+m5VUGPJuKifLnVGDxhCw6q2FUpEu/cYwxIMCVro
         amu9jXCRsdub9C6BjU94sgGJW4ljCn7uswFFhhAMg5o0RQ9ZzW9LI55j6YpC4DZ8E2jL
         2aCsZmfSrHQnNJWOJOOKPBuipQNTsHqsBczTJGoDARaVkzc2xG6QLTyKncQbLo8baEz/
         vuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VFeIbs3EEJfmUmShc5b4NHNzxuz8HmBwtr3zdhFPFdU=;
        b=o1IY7i96HLG7oqLsuAT11zl3yG4t5LYra6hNnK2SlHZw0a5MHX0MN89hKoXFSFEmaJ
         b2A03Cna9p/cEgI1ETwb1NFnxHkuqKl23/VmSL9WaqLf7aC1+KyEhOpHunRCZ9dUZV7R
         g2t3t3URvTEOXA8Xzr5LKWKgf+a1yASQi/aXSBAX/mM7n17naIcEv/bIMA3RtEZaSDCG
         BJfwtrz/4mbohlkfWduE8yptEEXINoCHw2wq+76rcLV2HABcWUtEG3iF9d/g/qqmDbCk
         /i0CmhChfw3g/fBul4Nc4oCUadC5IRJoT2eNbiNgiW3tGM7+76T0R22tNY07w0B0JnrF
         1urA==
X-Gm-Message-State: AOAM530rAolxxlWS0BluO5A88zJnZhR2avGSV8xc87aN6hY64gX9G3IZ
        T3pORdnUqQp2XUYPwVZoDIic2tssWyMNnKdnz5U2KUGPS+KVzFCPcYhnaKgiw39y7zlSvVMYO/p
        L6xPpALfnJaiJ8etRq3fk5VV/nfvj1g4P7IvNknWpJYjA2GexoW7fzXRTNjC3GaHZatbmhSVR
X-Google-Smtp-Source: ABdhPJyH+TC4ZouRxYz2W9PZwrMT+08RUoyoMahT/o8Q9ng3T9TJlcsgSogRAenAdozCUMNfLeSakPbwEyYb
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a17:90b:298:: with SMTP id
 az24mr381970pjb.128.1610475086556; Tue, 12 Jan 2021 10:11:26 -0800 (PST)
Date:   Tue, 12 Jan 2021 10:10:40 -0800
In-Reply-To: <20210112181041.356734-1-bgardon@google.com>
Message-Id: <20210112181041.356734-24-bgardon@google.com>
Mime-Version: 1.0
References: <20210112181041.356734-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 23/24] kvm: x86/mmu: Freeze SPTEs in disconnected pages
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

When clearing TDP MMU pages what have been disconnected from the paging
structure root, set the SPTEs to a special non-present value which will
not be overwritten by other threads. This is needed to prevent races in
which a thread is clearing a disconnected page table, but another thread
has already acquired a pointer to that memory and installs a mapping in
an already cleared entry. This can lead to memory leaks and accounting
errors.

Reviewed-by: Peter Feiner <pfeiner@google.com>

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 5c9d053000ad..45160ff84e91 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -333,13 +333,14 @@ static void handle_disconnected_tdp_mmu_page(struct kvm *kvm, u64 *pt,
 {
 	struct kvm_mmu_page *sp;
 	gfn_t gfn;
+	gfn_t base_gfn;
 	int level;
 	u64 *sptep;
 	u64 old_child_spte;
 	int i;
 
 	sp = sptep_to_sp(pt);
-	gfn = sp->gfn;
+	base_gfn = sp->gfn;
 	level = sp->role.level;
 
 	trace_kvm_mmu_prepare_zap_page(sp);
@@ -348,16 +349,38 @@ static void handle_disconnected_tdp_mmu_page(struct kvm *kvm, u64 *pt,
 
 	for (i = 0; i < PT64_ENT_PER_PAGE; i++) {
 		sptep = pt + i;
+		gfn = base_gfn + (i * KVM_PAGES_PER_HPAGE(level - 1));
 
 		if (atomic) {
-			old_child_spte = xchg(sptep, 0);
+			/*
+			 * Set the SPTE to a nonpresent value that other
+			 * threads will not overwrite. If the SPTE was already
+			 * frozen then another thread handling a page fault
+			 * could overwrite it, so set the SPTE until it is set
+			 * from nonfrozen -> frozen.
+			 */
+			for (;;) {
+				old_child_spte = xchg(sptep, FROZEN_SPTE);
+				if (old_child_spte != FROZEN_SPTE)
+					break;
+				cpu_relax();
+			}
 		} else {
 			old_child_spte = READ_ONCE(*sptep);
-			WRITE_ONCE(*sptep, 0);
+
+			/*
+			 * Setting the SPTE to FROZEN_SPTE is not strictly
+			 * necessary here as the MMU lock should stop other
+			 * threads from concurrentrly modifying this SPTE.
+			 * Using FROZEN_SPTE keeps the atomic and
+			 * non-atomic cases consistent and simplifies the
+			 * function.
+			 */
+			WRITE_ONCE(*sptep, FROZEN_SPTE);
 		}
-		handle_changed_spte(kvm, kvm_mmu_page_as_id(sp),
-			gfn + (i * KVM_PAGES_PER_HPAGE(level - 1)),
-			old_child_spte, 0, level - 1, atomic);
+		handle_changed_spte(kvm, kvm_mmu_page_as_id(sp), gfn,
+				    old_child_spte, FROZEN_SPTE, level - 1,
+				    atomic);
 	}
 
 	kvm_flush_remote_tlbs_with_address(kvm, gfn,
-- 
2.30.0.284.gd98b1dd5eaa7-goog

