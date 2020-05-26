Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41591D38D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 20:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgENSGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 14:06:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50341 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726946AbgENSGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589479562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XnOSKpz/GjmchUyWGb1CqsgEUovjDMqtxbsSwYKXQEo=;
        b=emtdtCA+mJI5mcJvk0ixnZUjpfniWDj4Ro1Da0s2YNmGudgr6vfXS986T4XSG4ICBvjrnL
        5nhe5b6yaDAtMjk2IEt3oT3cvIMxcJ+J2v3E+37sbU6pg5mhmYWtOB3rvUFliV5iBAQ+NY
        7YXDWwvl/tPToxrdjdWtrIp9uvF6Qzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-gTKGoRguOyKgme7uFs6E8w-1; Thu, 14 May 2020 14:06:00 -0400
X-MC-Unique: gTKGoRguOyKgme7uFs6E8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2872180183C;
        Thu, 14 May 2020 18:05:59 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E4345D9CA;
        Thu, 14 May 2020 18:05:54 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Michael Tsirkin <mst@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org
Subject: [PATCH RFC 3/5] KVM: x86: move kvm_vcpu_gfn_to_memslot() out of try_async_pf()
Date:   Thu, 14 May 2020 20:05:38 +0200
Message-Id: <20200514180540.52407-4-vkuznets@redhat.com>
In-Reply-To: <20200514180540.52407-1-vkuznets@redhat.com>
References: <20200514180540.52407-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change intended. We will need to analyze slot information
to map PTEs for KVM_MEM_ALLONES slots aggressively.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c         | 14 ++++++++------
 arch/x86/kvm/mmu/paging_tmpl.h |  7 +++++--
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e618472c572b..3db499df2dfc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4078,11 +4078,10 @@ static int kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 				  kvm_vcpu_gfn_to_hva(vcpu, gfn), &arch);
 }
 
-static bool try_async_pf(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
-			 gpa_t cr2_or_gpa, kvm_pfn_t *pfn, bool write,
-			 bool *writable)
+static bool try_async_pf(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
+			 bool prefault, gfn_t gfn, gpa_t cr2_or_gpa,
+			 kvm_pfn_t *pfn, bool write, bool *writable)
 {
-	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 	bool async;
 
 	/* Don't expose private memslots to L2. */
@@ -4118,7 +4117,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	bool exec = error_code & PFERR_FETCH_MASK;
 	bool lpage_disallowed = exec && is_nx_huge_page_enabled();
 	bool map_writable;
-
+	struct kvm_memory_slot *slot;
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	unsigned long mmu_seq;
 	kvm_pfn_t pfn;
@@ -4140,7 +4139,10 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
 	smp_rmb();
 
-	if (try_async_pf(vcpu, prefault, gfn, gpa, &pfn, write, &map_writable))
+	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
+
+	if (try_async_pf(vcpu, slot, prefault, gfn, gpa, &pfn, write,
+			 &map_writable))
 		return RET_PF_RETRY;
 
 	if (handle_abnormal_pfn(vcpu, is_tdp ? 0 : gpa, gfn, pfn, ACC_ALL, &r))
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index efec7d27b8c5..98e368788e8b 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -781,6 +781,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 	int write_fault = error_code & PFERR_WRITE_MASK;
 	int user_fault = error_code & PFERR_USER_MASK;
 	struct guest_walker walker;
+	struct kvm_memory_slot *slot;
 	int r;
 	kvm_pfn_t pfn;
 	unsigned long mmu_seq;
@@ -835,8 +836,10 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
 	smp_rmb();
 
-	if (try_async_pf(vcpu, prefault, walker.gfn, addr, &pfn, write_fault,
-			 &map_writable))
+	slot = kvm_vcpu_gfn_to_memslot(vcpu, walker.gfn);
+
+	if (try_async_pf(vcpu, slot, prefault, walker.gfn, addr, &pfn,
+			 write_fault, &map_writable))
 		return RET_PF_RETRY;
 
 	if (handle_abnormal_pfn(vcpu, addr, walker.gfn, pfn, walker.pte_access, &r))
-- 
2.25.4

