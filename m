Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8942E7D72
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 01:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgLaA3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 19:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgLaA3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 19:29:00 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E818C0617B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 16:27:47 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id cc1so14765343qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 16:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Hbk8rdCypxZQvfdZLDuzYjKUok+n+FkfRcH5jI3PlNw=;
        b=B3sdOr5BLKe7aAEN8dvatmjua4D081XjfvGkK38L+SS9oVfNNTjza8wQIpWodTKdOH
         1S+3yTlzdgVKHjebYTH7xE3oJjYQJrWi2SRo2yHPBvY2i1Tv3Vpkrdf0PMM8ETEv6wAE
         WGkvPmpqXgS+lXLhWg0iBvwnkjuj4bocbyARWO+XFLPZJ2Q2D3YSfcumDG+lLnu9bUn3
         IUXzVG9v2qFeORt5JPh3K+vD5LndvTmoUUngN9A/jDjGaBMd/SidFQCtc0/SbQS+T7En
         dQtVku/I2RUKki4Qpdx+n0oh6WfuK8Df3svMz6gCtv1iVv0S6jiwdeYAnCNUVxyuhuX6
         WgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Hbk8rdCypxZQvfdZLDuzYjKUok+n+FkfRcH5jI3PlNw=;
        b=LJAPpKnwOaV6iAdjvAYjoBq+mePYivzlfabW/WvswnDQfQyj6x0owfmVVlNB8OVTKT
         2TiUHJccaCH7xEq52O1iDmFP/Hf1TeXQgmEDCig1WZxm1gfeAAL/4HDLisW8ZGks4B3A
         zTxv6XlxXODsOebBVlqAXuIq5SbSFtvFuV61b2CMqk8//JO4NWOyQLa/Y/TCoNnunIJQ
         PgpJmqMxKMRtiZxjITzfNglnWYQ/SBsCjv6jFO4+I7YELOrMIiadh9jeQGEDBrqWvIJL
         SbDBy6O2fsQPZjOvzLltzWY2FKN9dkSEkzwIMXlj9iWL8rKHhRPnfCvVHHh6eZQjMuzl
         InsQ==
X-Gm-Message-State: AOAM532UHQvuSRsS1oiQ7WZaixHG3+VTfcXD1iRpVth1KPChNW/pYuX4
        cKUtpWI083uQXBcPSG8pd6svqs0+UGc=
X-Google-Smtp-Source: ABdhPJz9FhK/Y1QvMm6QTyaMAeBnsHgekZgrgFV3k3M6dCuFVbWpc4EluZNruvUhyOoZEME+sDGdDb6uZRc=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a0c:cc12:: with SMTP id r18mr59611912qvk.51.1609374466605;
 Wed, 30 Dec 2020 16:27:46 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Dec 2020 16:27:02 -0800
In-Reply-To: <20201231002702.2223707-1-seanjc@google.com>
Message-Id: <20201231002702.2223707-10-seanjc@google.com>
Mime-Version: 1.0
References: <20201231002702.2223707-1-seanjc@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH 9/9] KVM: x86: Move declaration of kvm_spurious_fault() to x86.h
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David P . Reed" <dpreed@deepplum.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uros Bizjak <ubizjak@gmail.com>

Move the declaration of kvm_spurious_fault() to KVM's "private" x86.h,
it should never be called by anything other than low level KVM code.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
[sean: rebased to a series without __ex()/__kvm_handle_fault_on_reboot()]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 2 --
 arch/x86/kvm/svm/svm_ops.h      | 2 +-
 arch/x86/kvm/vmx/vmx_ops.h      | 2 +-
 arch/x86/kvm/x86.h              | 2 ++
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 51ba20ffaedb..feba0ec5474b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1634,8 +1634,6 @@ enum {
 #define kvm_arch_vcpu_memslots_id(vcpu) ((vcpu)->arch.hflags & HF_SMM_MASK ? 1 : 0)
 #define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, (role).smm)
 
-void kvm_spurious_fault(void);
-
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end,
 			unsigned flags);
diff --git a/arch/x86/kvm/svm/svm_ops.h b/arch/x86/kvm/svm/svm_ops.h
index 0c8377aee52c..aa028ef5b1e9 100644
--- a/arch/x86/kvm/svm/svm_ops.h
+++ b/arch/x86/kvm/svm/svm_ops.h
@@ -4,7 +4,7 @@
 
 #include <linux/compiler_types.h>
 
-#include <asm/kvm_host.h>
+#include "x86.h"
 
 #define svm_asm(insn, clobber...)				\
 do {								\
diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 7b6fbe103c61..7e3cb53c413f 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -4,11 +4,11 @@
 
 #include <linux/nospec.h>
 
-#include <asm/kvm_host.h>
 #include <asm/vmx.h>
 
 #include "evmcs.h"
 #include "vmcs.h"
+#include "x86.h"
 
 asmlinkage void vmread_error(unsigned long field, bool fault);
 __attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index c5ee0f5ce0f1..0d830945ae38 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -8,6 +8,8 @@
 #include "kvm_cache_regs.h"
 #include "kvm_emulate.h"
 
+void kvm_spurious_fault(void);
+
 #define KVM_DEFAULT_PLE_GAP		128
 #define KVM_VMX_DEFAULT_PLE_WINDOW	4096
 #define KVM_DEFAULT_PLE_WINDOW_GROW	2
-- 
2.29.2.729.g45daf8777d-goog

