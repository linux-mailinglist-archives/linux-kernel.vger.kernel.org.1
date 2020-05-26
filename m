Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5F01BAA93
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 18:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgD0Q70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 12:59:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45906 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbgD0Q7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588006764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=b0MkAzhcBt7zpAJlv47FOL8k4zacsMQO/dxm0rrkVZo=;
        b=PMdjD0od0XZQXUITJXTeEvk4JmTXmNMdg/r8Gfh2Vm2Gqe7+wqqpNfiZrCd+J3bY5cvDKd
        hobAPI48Ujt8RyiHiXUa7x0KDQ+IuXPchctPk5pOJyeoZx48wdZdfB/VUkdrqyl9bGrK97
        IrvJApWbMkTCH+jfPahOWKEkUUOQrGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-ZOXwAPI6MGKz5yVCU0BHFg-1; Mon, 27 Apr 2020 12:59:20 -0400
X-MC-Unique: ZOXwAPI6MGKz5yVCU0BHFg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B3A118957E6;
        Mon, 27 Apr 2020 16:59:19 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4280619C4F;
        Mon, 27 Apr 2020 16:59:18 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     sean.j.christopherson@intel.com, jmattson@google.com,
        joro@8bytes.org, everdox@gmail.com
Subject: [PATCH] KVM: x86: handle wrap around 32-bit address space
Date:   Mon, 27 Apr 2020 12:59:17 -0400
Message-Id: <20200427165917.31799-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM is not handling the case where EIP wraps around the 32-bit address
space (that is, outside long mode).  This is needed both in vmx.c
and in emulate.c.  SVM with NRIPS is okay, but it can still print
an error to dmesg due to integer overflow.

Reported-by: Nick Peterson <everdox@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/emulate.c |  2 ++
 arch/x86/kvm/svm/svm.c |  3 ---
 arch/x86/kvm/vmx/vmx.c | 15 ++++++++++++---
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index bddaba9c68dd..de5476f8683e 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5798,6 +5798,8 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
 	}
 
 	ctxt->eip = ctxt->_eip;
+	if (ctxt->mode != X86EMUL_MODE_PROT64)
+		ctxt->eip = (u32)ctxt->_eip;
 
 done:
 	if (rc == X86EMUL_PROPAGATE_FAULT) {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 8f8fc65bfa3e..d5e72b22bc87 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -319,9 +319,6 @@ static int skip_emulated_instruction(struct kvm_vcpu *vcpu)
 		if (!kvm_emulate_instruction(vcpu, EMULTYPE_SKIP))
 			return 0;
 	} else {
-		if (svm->next_rip - kvm_rip_read(vcpu) > MAX_INST_SIZE)
-			pr_err("%s: ip 0x%lx next 0x%llx\n",
-			       __func__, kvm_rip_read(vcpu), svm->next_rip);
 		kvm_rip_write(vcpu, svm->next_rip);
 	}
 	svm_set_interrupt_shadow(vcpu, 0);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3ab6ca6062ce..ed1ffc8a727b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1556,7 +1556,7 @@ static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
 
 static int skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
-	unsigned long rip;
+	unsigned long rip, orig_rip;
 
 	/*
 	 * Using VMCS.VM_EXIT_INSTRUCTION_LEN on EPT misconfig depends on
@@ -1568,8 +1568,17 @@ static int skip_emulated_instruction(struct kvm_vcpu *vcpu)
 	 */
 	if (!static_cpu_has(X86_FEATURE_HYPERVISOR) ||
 	    to_vmx(vcpu)->exit_reason != EXIT_REASON_EPT_MISCONFIG) {
-		rip = kvm_rip_read(vcpu);
-		rip += vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
+		orig_rip = kvm_rip_read(vcpu);
+		rip = orig_rip + vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
+#ifdef CONFIG_X86_64
+		/*
+		 * We need to mask out the high 32 bits of RIP if not in 64-bit
+		 * mode, but just finding out that we are in 64-bit mode is
+		 * quite expensive.  Only do it if there was a carry.
+		 */
+		if (unlikely(((rip ^ orig_rip) >> 31) == 3) && !is_64_bit_mode(vcpu))
+			rip = (u32)rip;
+#endif
 		kvm_rip_write(vcpu, rip);
 	} else {
 		if (!kvm_emulate_instruction(vcpu, EMULTYPE_SKIP))
-- 
2.18.2

