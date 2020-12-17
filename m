Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7132DCE7C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 10:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgLQJdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 04:33:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:43676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbgLQJdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 04:33:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608197508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f7wMr3rCKeUgxXFk8LrwUaFxcJhxPpDbM3TMdRt3vHc=;
        b=ZxRpHnPLouJGWl0qvClnnvw5rU/SYAMpP+qybw/K+Uy0fLrHnnu5ahxvF0cCDOZeqZlvyZ
        dlR9w0GMgGxy9KFsuKFvnomGmDS65MgZNHk5x24aIFmT/GaUidfJrqQXQlfvoGrGqb0z2i
        ENfyfKAHzdoZsjSKRBdvzoLmTj5g32g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6A6B5B71C;
        Thu, 17 Dec 2020 09:31:48 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 08/15] x86: add new features for paravirt patching
Date:   Thu, 17 Dec 2020 10:31:26 +0100
Message-Id: <20201217093133.1507-9-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201217093133.1507-1-jgross@suse.com>
References: <20201217093133.1507-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For being able to switch paravirt patching from special cased custom
code sequences to ALTERNATIVE handling some X86_FEATURE_* are needed
as new features. This enables to have the standard indirect pv call
as the default code and to patch that with the non-Xen custom code
sequence via ALTERNATIVE patching later.

Make sure paravirt patching is performed before alternative patching.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- add comment (Boris Petkov)
- no negative features (Boris Petkov)
---
 arch/x86/include/asm/cpufeatures.h |  2 ++
 arch/x86/kernel/alternative.c      | 40 ++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f5ef2d5b9231..1077b675a008 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -237,6 +237,8 @@
 #define X86_FEATURE_VMCALL		( 8*32+18) /* "" Hypervisor supports the VMCALL instruction */
 #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL hypercall instruction */
 #define X86_FEATURE_SEV_ES		( 8*32+20) /* AMD Secure Encrypted Virtualization - Encrypted State */
+#define X86_FEATURE_PVUNLOCK		( 8*32+21) /* "" PV unlock function */
+#define X86_FEATURE_VCPUPREEMPT		( 8*32+22) /* "" PV vcpu_is_preempted function */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 0a904fb2678b..abb481808811 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -600,6 +600,15 @@ int alternatives_text_reserved(void *start, void *end)
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_PARAVIRT
+static void __init paravirt_set_cap(void)
+{
+	if (!pv_is_native_spin_unlock())
+		setup_force_cpu_cap(X86_FEATURE_PVUNLOCK);
+
+	if (!pv_is_native_vcpu_is_preempted())
+		setup_force_cpu_cap(X86_FEATURE_VCPUPREEMPT);
+}
+
 void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
 				     struct paravirt_patch_site *end)
 {
@@ -623,6 +632,8 @@ void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
 }
 extern struct paravirt_patch_site __start_parainstructions[],
 	__stop_parainstructions[];
+#else
+static void __init paravirt_set_cap(void) { }
 #endif	/* CONFIG_PARAVIRT */
 
 /*
@@ -730,6 +741,33 @@ void __init alternative_instructions(void)
 	 * patching.
 	 */
 
+	/*
+	 * Paravirt patching and alternative patching can be combined to
+	 * replace a function call with a short direct code sequence (e.g.
+	 * by setting a constant return value instead of doing that in an
+	 * external function).
+	 * In order to make this work the following sequence is required:
+	 * 1. set (artificial) features depending on used paravirt
+	 *    functions which can later influence alternative patching
+	 * 2. apply paravirt patching (generally replacing an indirect
+	 *    function call with a direct one)
+	 * 3. apply alternative patching (e.g. replacing a direct function
+	 *    call with a custom code sequence)
+	 * Doing paravirt patching after alternative patching would clobber
+	 * the optimization of the custom code with a function call again.
+	 */
+	paravirt_set_cap();
+
+	/*
+	 * First patch paravirt functions, such that we overwrite the indirect
+	 * call with the direct call.
+	 */
+	apply_paravirt(__parainstructions, __parainstructions_end);
+
+	/*
+	 * Then patch alternatives, such that those paravirt calls that are in
+	 * alternatives can be overwritten by their immediate fragments.
+	 */
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
 
 #ifdef CONFIG_SMP
@@ -748,8 +786,6 @@ void __init alternative_instructions(void)
 	}
 #endif
 
-	apply_paravirt(__parainstructions, __parainstructions_end);
-
 	restart_nmi();
 	alternatives_patched = 1;
 }
-- 
2.26.2

