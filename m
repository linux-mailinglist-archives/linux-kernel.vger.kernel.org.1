Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F66129C4F3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1823970AbgJ0SBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:01:11 -0400
Received: from mail-qv1-f73.google.com ([209.85.219.73]:53695 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1823718AbgJ0R7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:59:50 -0400
Received: by mail-qv1-f73.google.com with SMTP id z9so1314187qvo.20
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=pOTcENHU6wqJJ3cPGXaUEXXcmuzILdwS9IUGREQEYLU=;
        b=AVgaJ/v4KywVIrgTz57lMlfjx3jDjDwAYJ6aYsfyb2gTP1Endgev6TCUT6NK3dVO5c
         9vlF0AfnyBKeqndCJVCcvnGjqblnfDahVldKiOBsM6O1aSUZ/wucJ21H956cTu0o5py8
         p9LWSHkquW05lQbYO61oW0VxGH3gdW+yu0gxSNcQBDt76xRUT3oChrv2fl1JL+UHtSe3
         ng2sehmakCgFytvf2alnQjipxnQC/c8QFaPsvwYwc+FlogWLd4vuiN+EDi2jo5TlTN8o
         kcyJaVBtKeNGoutAl31mvIemzV5GGS/QHTKSSRZzYJ453UY3DjQNTn/9OxFAqTn2Avfl
         xXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pOTcENHU6wqJJ3cPGXaUEXXcmuzILdwS9IUGREQEYLU=;
        b=ifGdbPqcPkrLdFbSU5p9202Ps+Y+xFUse7vam1/vb/UVQu/DD8zPyJeKDy+2Eu1Ala
         WIsvrUGpp0MMOvXf6sBVCS+Jf56W7c6voVB2EsocypQocgXc3UxvkOIK3Wmna0mAH/Cc
         4LHFB7DsMCrl0tBymA5CLR0KxodSMeQkiqr1oB20WkNjuaRQxqY5S+7PB+356JjTNFX1
         Zq2G+JAeVSr5I5y/5qV4R2oqlMwo+EAN22HsWySQk5bPAtRmKX3ekxPwJo9N+X1mPes7
         f79b8cmTiyHEoI6dG1kXacMgQy8wtSGQrLEEKRNC6/pxeAW/va+7+swK5F++nY9dhA4g
         Jlbw==
X-Gm-Message-State: AOAM531OL5Eq8VRRT41aa/48E//A89wtYu2Fbmg0en3HWGE0UiC/5sHK
        PT1ghy0EeRj7ZymFi2uhoINXWfrXlVoNPdR4GBUNnUOIQFo77/iN12wagyE6cVslk0/QDhAWkAu
        cffTitfkYbOLRsAIQztB+u8mivOCvYVWoK+B1y0RBSCGc6H4cPlobTo/ZOJt54XhRrFBLYURE
X-Google-Smtp-Source: ABdhPJxXP3MCaof8IMN7lQHYqo/fDn4xCqd6YNisdN1pPMqUmwwr3qGS47G3JTeiSwOHNBj3loLOA/XHaVDc
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a0c:e054:: with SMTP id
 y20mr3875558qvk.30.1603821589510; Tue, 27 Oct 2020 10:59:49 -0700 (PDT)
Date:   Tue, 27 Oct 2020 10:59:44 -0700
In-Reply-To: <20201027175944.1183301-1-bgardon@google.com>
Message-Id: <20201027175944.1183301-2-bgardon@google.com>
Mime-Version: 1.0
References: <20201027175944.1183301-1-bgardon@google.com>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH 2/2] kvm: x86/mmu: Add TDP MMU SPTE changed trace point
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an extremely verbose trace point to the TDP MMU to log all SPTE
changes, regardless of callstack / motivation. This is useful when a
complete picture of the paging structure is needed or a change cannot be
explained with the other, existing trace points.

Tested: ran the demand paging selftest on an Intel Skylake machine with
	all the trace points used by the TDP MMU enabled and observed
	them firing with expected values.

This patch can be viewed in Gerrit at:
https://linux-review.googlesource.com/c/virt/kvm/kvm/+/3813

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmutrace.h | 29 +++++++++++++++++++++++++++++
 arch/x86/kvm/mmu/tdp_mmu.c  |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
index 213699b27b448..e798489b56b55 100644
--- a/arch/x86/kvm/mmu/mmutrace.h
+++ b/arch/x86/kvm/mmu/mmutrace.h
@@ -381,6 +381,35 @@ TRACE_EVENT(
 	)
 );
 
+TRACE_EVENT(
+	kvm_tdp_mmu_spte_changed,
+	TP_PROTO(int as_id, gfn_t gfn, int level, u64 old_spte, u64 new_spte),
+	TP_ARGS(as_id, gfn, level, old_spte, new_spte),
+
+	TP_STRUCT__entry(
+		__field(u64, gfn)
+		__field(u64, old_spte)
+		__field(u64, new_spte)
+		/* Level cannot be larger than 5 on x86, so it fits in a u8. */
+		__field(u8, level)
+		/* as_id can only be 0 or 1 x86, so it fits in a u8. */
+		__field(u8, as_id)
+	),
+
+	TP_fast_assign(
+		__entry->gfn = gfn;
+		__entry->old_spte = old_spte;
+		__entry->new_spte = new_spte;
+		__entry->level = level;
+		__entry->as_id = as_id;
+	),
+
+	TP_printk("as id %d gfn %llx level %d old_spte %llx new_spte %llx",
+		  __entry->as_id, __entry->gfn, __entry->level,
+		  __entry->old_spte, __entry->new_spte
+	)
+);
+
 #endif /* _TRACE_KVMMMU_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 047e2d966abef..5820c36ccfdca 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -241,6 +241,8 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 	if (old_spte == new_spte)
 		return;
 
+	trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
+
 	/*
 	 * The only times a SPTE should be changed from a non-present to
 	 * non-present state is when an MMIO entry is installed/modified/
-- 
2.29.0.rc2.309.g374f81d7ae-goog

