Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A592A66E3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgKDO4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:56:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbgKDO4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:56:33 -0500
Received: from suppilovahvero.lan (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 673CA2236F;
        Wed,  4 Nov 2020 14:56:27 +0000 (UTC)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, linux-sgx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jethro Beekman <jethro@fortanix.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, bp@alien8.de, cedric.xing@intel.com,
        chenalexchen@google.com, conradparker@google.com,
        cyhanish@google.com, dave.hansen@intel.com, haitao.huang@intel.com,
        kai.huang@intel.com, kai.svahn@intel.com, kmoy@google.com,
        ludloff@google.com, luto@kernel.org, nhorman@redhat.com,
        npmccallum@redhat.com, puiterwijk@redhat.com, rientjes@google.com,
        tglx@linutronix.de, yaozhangx@google.com, mikko.ylinen@intel.com
Subject: [PATCH v40 18/24] x86/traps: Attempt to fixup exceptions in vDSO before signaling
Date:   Wed,  4 Nov 2020 16:54:24 +0200
Message-Id: <20201104145430.300542-19-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com>
References: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

vDSO functions can now leverage an exception fixup mechanism similar to
kernel exception fixup.  For vDSO exception fixup, the initial user is
Intel's Software Guard Extensions (SGX), which will wrap the low-level
transitions to/from the enclave, i.e. EENTER and ERESUME instructions,
in a vDSO function and leverage fixup to intercept exceptions that would
otherwise generate a signal.  This allows the vDSO wrapper to return the
fault information directly to its caller, obviating the need for SGX
applications and libraries to juggle signal handlers.

Attempt to fixup vDSO exceptions immediately prior to populating and
sending signal information.  Except for the delivery mechanism, an
exception in a vDSO function should be treated like any other exception
in userspace, e.g. any fault that is successfully handled by the kernel
should not be directly visible to userspace.

Although it's debatable whether or not all exceptions are of interest to
enclaves, defer to the vDSO fixup to decide whether to do fixup or
generate a signal.  Future users of vDSO fixup, if there ever are any,
will undoubtedly have different requirements than SGX enclaves, e.g. the
fixup vs. signal logic can be made function specific if/when necessary.

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/kernel/traps.c | 10 ++++++++++
 arch/x86/mm/fault.c     |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e19df6cde35d..7798d862983f 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -60,6 +60,7 @@
 #include <asm/umip.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/vdso.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -117,6 +118,9 @@ do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_nr = trapnr;
 		die(str, regs, error_code);
+	} else {
+		if (fixup_vdso_exception(regs, trapnr, error_code, 0))
+			return 0;
 	}
 
 	/*
@@ -550,6 +554,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_nr = X86_TRAP_GP;
 
+		if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
+			return;
+
 		show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
 		force_sig(SIGSEGV);
 		goto exit;
@@ -1048,6 +1055,9 @@ static void math_error(struct pt_regs *regs, int trapnr)
 	if (!si_code)
 		goto exit;
 
+	if (fixup_vdso_exception(regs, trapnr, 0, 0))
+		return;
+
 	force_sig_fault(SIGFPE, si_code,
 			(void __user *)uprobe_get_trap_addr(regs));
 exit:
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 0161d4acf3ad..f1f1b5a0956a 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -30,6 +30,7 @@
 #include <asm/cpu_entry_area.h>		/* exception stack		*/
 #include <asm/pgtable_areas.h>		/* VMALLOC_START, ...		*/
 #include <asm/kvm_para.h>		/* kvm_handle_async_pf		*/
+#include <asm/vdso.h>			/* fixup_vdso_exception()	*/
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -814,6 +815,9 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 
 		sanitize_error_code(address, &error_code);
 
+		if (fixup_vdso_exception(regs, X86_TRAP_PF, error_code, address))
+			return;
+
 		if (likely(show_unhandled_signals))
 			show_signal_msg(regs, error_code, address, tsk);
 
@@ -933,6 +937,9 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 
 	sanitize_error_code(address, &error_code);
 
+	if (fixup_vdso_exception(regs, X86_TRAP_PF, error_code, address))
+		return;
+
 	set_signal_archinfo(address, error_code);
 
 #ifdef CONFIG_MEMORY_FAILURE
-- 
2.27.0

