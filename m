Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D4F2E7D74
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 01:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgLaA3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 19:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgLaA3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 19:29:00 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98727C0617A9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 16:27:42 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id p21so13604919qke.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 16:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=8ANnx6AvMPuAyAMKxozebrm5eQtYsGkfZPsOWk0XO8s=;
        b=rVBqmfJjho2XG5nRs0AINrhMHs5IAP8aScZFDDQUtuyNLrGcdZqe17gSZgdPfTnDjr
         oiN5IIVQs5IdHgVJUESSU5ZKlzt8Xc/lMRtSRdxWgZGSKBSeOZ2VXhN0a+7WraqCqlb/
         AvTk0T26bEk56/QxThAzKEEPDpMqmBA3TLuLCXDkgBuO+D+IJFMKcE8odWIT4xZSG079
         5e3VKt+f/JJpqNG055WJsJPlR3ezxVnUGbOZjYb6sktpP2mcA7kdKQ8vghB2l46IRn9J
         yzXWxvldNS9HzGXsFjfKLXmHE4qTfazjL+Qn9qVqj05rPiRRn1pO344/GaPDLRHt4ChD
         9w4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=8ANnx6AvMPuAyAMKxozebrm5eQtYsGkfZPsOWk0XO8s=;
        b=n5F/FKS65XxOSCENIfrasNU7gf/73zIcowOkhfdqggbe9iRMlXoBT32a7iCwRuocGZ
         wGz1glR/XBTQjI/dPtiGjrbQpQf64t+Sma7S9ewCe8ctHap9seNU2uIk40lmtGMMKd9o
         zX+YOEXNxgKNhB1Hao6azMRp0TzuVN44ScongzS5g89mK8CM72A8ZH7sT5QvOWA0cC7+
         negllfRVxvN2EnXO0LBry6JnbZ1rcrQxbpojjlUj92M579mD4BxvrJkcJgk2xpPNGoGG
         YOlIm0bJJQ4Snzudu9d0h2bCGi9TyMeOWtq7tBTmaRnhabJBEzAG+PDhVJekorglfs8z
         Z1fg==
X-Gm-Message-State: AOAM533Hwlv3vlvb7xExT0JswDtKW2Vv3oCDVlUAcDAZWmmRteGPaK61
        gstV+kysS5GqrWC9QaIWDQlRAz4VRsI=
X-Google-Smtp-Source: ABdhPJxeWir92fZ6IxS7tj0vsL1m/7kjxVmvp449e/9f0pAau+7nBvcKgkpymvsRDq/D8vw4iajihq/uxaY=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a0c:f046:: with SMTP id b6mr59156219qvl.14.1609374461656;
 Wed, 30 Dec 2020 16:27:41 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Dec 2020 16:27:00 -0800
In-Reply-To: <20201231002702.2223707-1-seanjc@google.com>
Message-Id: <20201231002702.2223707-8-seanjc@google.com>
Mime-Version: 1.0
References: <20201231002702.2223707-1-seanjc@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH 7/9] KVM: SVM: Use asm goto to handle unexpected #UD on SVM instructions
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

Add svm_asm*() macros, a la the existing vmx_asm*() macros, to handle
faults on SVM instructions instead of using the generic __ex(), a.k.a.
__kvm_handle_fault_on_reboot().  Using asm goto generates slightly
better code as it eliminates the in-line JMP+CALL sequences that are
needed by __kvm_handle_fault_on_reboot() to avoid triggering BUG()
from fixup (which generates bad stack traces).

Using SVM specific macros also drops the last user of __ex() and the
the last asm linkage to kvm_spurious_fault(), and adds a helper for
VMSAVE, which may gain an addition call site in the future (as part
of optimizing the SVM context switching).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c     |  3 +-
 arch/x86/kvm/svm/svm.c     | 16 +----------
 arch/x86/kvm/svm/svm_ops.h | 59 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 16 deletions(-)
 create mode 100644 arch/x86/kvm/svm/svm_ops.h

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 9858d5ae9ddd..4511d7ccdb19 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -22,6 +22,7 @@
 
 #include "x86.h"
 #include "svm.h"
+#include "svm_ops.h"
 #include "cpuid.h"
 #include "trace.h"
 
@@ -2001,7 +2002,7 @@ void sev_es_vcpu_load(struct vcpu_svm *svm, int cpu)
 	 * of which one step is to perform a VMLOAD. Since hardware does not
 	 * perform a VMSAVE on VMRUN, the host savearea must be updated.
 	 */
-	asm volatile(__ex("vmsave") : : "a" (__sme_page_pa(sd->save_area)) : "memory");
+	vmsave(__sme_page_pa(sd->save_area));
 
 	/*
 	 * Certain MSRs are restored on VMEXIT, only save ones that aren't
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index cce0143a6f80..4308ab5ca27e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -41,6 +41,7 @@
 #include "trace.h"
 
 #include "svm.h"
+#include "svm_ops.h"
 
 #define __ex(x) __kvm_handle_fault_on_reboot(x)
 
@@ -246,21 +247,6 @@ u32 svm_msrpm_offset(u32 msr)
 
 #define MAX_INST_SIZE 15
 
-static inline void clgi(void)
-{
-	asm volatile (__ex("clgi"));
-}
-
-static inline void stgi(void)
-{
-	asm volatile (__ex("stgi"));
-}
-
-static inline void invlpga(unsigned long addr, u32 asid)
-{
-	asm volatile (__ex("invlpga %1, %0") : : "c"(asid), "a"(addr));
-}
-
 static int get_max_npt_level(void)
 {
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kvm/svm/svm_ops.h b/arch/x86/kvm/svm/svm_ops.h
new file mode 100644
index 000000000000..0c8377aee52c
--- /dev/null
+++ b/arch/x86/kvm/svm/svm_ops.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __KVM_X86_SVM_OPS_H
+#define __KVM_X86_SVM_OPS_H
+
+#include <linux/compiler_types.h>
+
+#include <asm/kvm_host.h>
+
+#define svm_asm(insn, clobber...)				\
+do {								\
+	asm_volatile_goto("1: " __stringify(insn) "\n\t"	\
+			  _ASM_EXTABLE(1b, %l[fault])		\
+			  ::: clobber : fault);			\
+	return;							\
+fault:								\
+	kvm_spurious_fault();					\
+} while (0)
+
+#define svm_asm1(insn, op1, clobber...)				\
+do {								\
+	asm_volatile_goto("1: "  __stringify(insn) " %0\n\t"	\
+			  _ASM_EXTABLE(1b, %l[fault])		\
+			  :: op1 : clobber : fault);		\
+	return;							\
+fault:								\
+	kvm_spurious_fault();					\
+} while (0)
+
+#define svm_asm2(insn, op1, op2, clobber...)				\
+do {									\
+	asm_volatile_goto("1: "  __stringify(insn) " %1, %0\n\t"	\
+			  _ASM_EXTABLE(1b, %l[fault])			\
+			  :: op1, op2 : clobber : fault);		\
+	return;								\
+fault:									\
+	kvm_spurious_fault();						\
+} while (0)
+
+static inline void clgi(void)
+{
+	svm_asm(clgi);
+}
+
+static inline void stgi(void)
+{
+	svm_asm(stgi);
+}
+
+static inline void invlpga(unsigned long addr, u32 asid)
+{
+	svm_asm2(invlpga, "c"(asid), "a"(addr));
+}
+
+static inline void vmsave(hpa_t pa)
+{
+	svm_asm1(vmsave, "a" (pa), "memory");
+}
+
+#endif /* __KVM_X86_SVM_OPS_H */
-- 
2.29.2.729.g45daf8777d-goog

