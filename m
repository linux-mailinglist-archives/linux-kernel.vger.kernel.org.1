Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430321E8A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 23:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgE2VhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 17:37:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54862 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgE2VhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=EEQl9ivYrlLKgFaLz+ODXlG1aDS0W2oR8ESGKsy0GfM=; b=n2ztSHWmtkLW/UDTliZriRdpv8
        /kXtnSPqDzZoTyL3UYE/p3slUb6xnqWTSskCrETXQE0KcAFNlqWEvJFkRWTsXUKFBntAnV0fbFF4I
        5N9lbVxEvhOn2RZ4uw7Y7U0HPHNGBElCukgPCi28A4omTZTasTANUPHu/ketUEN4dWrYSkWDd4zzk
        u8KjcsAglGWj9r1H0B9RnYT7GSLt65EuG4jBSK7yyq8/mngOXHaOHQPz/eeEeEKkpM9m2dbDhdV/n
        5goGquC1td9JpKfOUZw4WT5CZG3GVh1TU7NIFTKdBSMri/kuHAt8FBACLqhI1zi8adp+5V2Z8hRLs
        +SzrPBVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jemeP-0007J0-V5; Fri, 29 May 2020 21:34:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0776B30774A;
        Fri, 29 May 2020 23:34:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3BCCC2B9B1BC2; Fri, 29 May 2020 23:34:41 +0200 (CEST)
Message-ID: <20200529213321.303027161@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 29 May 2020 23:27:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de
Subject: [PATCH 10/14] x86/entry: Remove DBn stacks
References: <20200529212728.795169701@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both #DB itself, as all other IST users (NMI, #MC) now clear DR7 on
entry. Combined with not allowing breakpoints on entry/noinstr/NOKPROBE
text and no single step (EFLAGS.TF) inside the #DB handler should
guarantee us no nested #DB.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S             |   17 -----------------
 arch/x86/include/asm/cpu_entry_area.h |   12 +++---------
 arch/x86/kernel/asm-offsets_64.c      |    3 ---
 arch/x86/kernel/dumpstack_64.c        |    7 ++-----
 arch/x86/mm/cpu_entry_area.c          |    1 -
 5 files changed, 5 insertions(+), 35 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -396,11 +396,6 @@ SYM_CODE_END(\asmsym)
 	idtentry \vector asm_\cfunc \cfunc has_error_code=0
 .endm
 
-/*
- * MCE and DB exceptions
- */
-#define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
-
 /**
  * idtentry_mce_db - Macro to generate entry stubs for #MC and #DB
  * @vector:		Vector number
@@ -416,10 +411,6 @@ SYM_CODE_END(\asmsym)
  * If hits in kernel mode then it needs to go through the paranoid
  * entry as the exception can hit any random state. No preemption
  * check on exit to keep the paranoid path simple.
- *
- * If the trap is #DB then the interrupt stack entry in the IST is
- * moved to the second stack, so a potential recursion will have a
- * fresh IST.
  */
 .macro idtentry_mce_db vector asmsym cfunc
 SYM_CODE_START(\asmsym)
@@ -445,16 +436,8 @@ SYM_CODE_START(\asmsym)
 
 	movq	%rsp, %rdi		/* pt_regs pointer */
 
-	.if \vector == X86_TRAP_DB
-		subq	$DB_STACK_OFFSET, CPU_TSS_IST(IST_INDEX_DB)
-	.endif
-
 	call	\cfunc
 
-	.if \vector == X86_TRAP_DB
-		addq	$DB_STACK_OFFSET, CPU_TSS_IST(IST_INDEX_DB)
-	.endif
-
 	jmp	paranoid_exit
 
 	/* Switch to the regular task stack and use the noist entry point */
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -11,15 +11,11 @@
 #ifdef CONFIG_X86_64
 
 /* Macro to enforce the same ordering and stack sizes */
-#define ESTACKS_MEMBERS(guardsize, db2_holesize)\
+#define ESTACKS_MEMBERS(guardsize)		\
 	char	DF_stack_guard[guardsize];	\
 	char	DF_stack[EXCEPTION_STKSZ];	\
 	char	NMI_stack_guard[guardsize];	\
 	char	NMI_stack[EXCEPTION_STKSZ];	\
-	char	DB2_stack_guard[guardsize];	\
-	char	DB2_stack[db2_holesize];	\
-	char	DB1_stack_guard[guardsize];	\
-	char	DB1_stack[EXCEPTION_STKSZ];	\
 	char	DB_stack_guard[guardsize];	\
 	char	DB_stack[EXCEPTION_STKSZ];	\
 	char	MCE_stack_guard[guardsize];	\
@@ -28,12 +24,12 @@
 
 /* The exception stacks' physical storage. No guard pages required */
 struct exception_stacks {
-	ESTACKS_MEMBERS(0, 0)
+	ESTACKS_MEMBERS(0)
 };
 
 /* The effective cpu entry area mapping with guard pages. */
 struct cea_exception_stacks {
-	ESTACKS_MEMBERS(PAGE_SIZE, EXCEPTION_STKSZ)
+	ESTACKS_MEMBERS(PAGE_SIZE)
 };
 
 /*
@@ -42,8 +38,6 @@ struct cea_exception_stacks {
 enum exception_stack_ordering {
 	ESTACK_DF,
 	ESTACK_NMI,
-	ESTACK_DB2,
-	ESTACK_DB1,
 	ESTACK_DB,
 	ESTACK_MCE,
 	N_EXCEPTION_STACKS
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -57,9 +57,6 @@ int main(void)
 	BLANK();
 #undef ENTRY
 
-	OFFSET(TSS_ist, tss_struct, x86_tss.ist);
-	DEFINE(DB_STACK_OFFSET, offsetof(struct cea_exception_stacks, DB_stack) -
-	       offsetof(struct cea_exception_stacks, DB1_stack));
 	BLANK();
 
 #ifdef CONFIG_STACKPROTECTOR
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -22,15 +22,13 @@
 static const char * const exception_stack_names[] = {
 		[ ESTACK_DF	]	= "#DF",
 		[ ESTACK_NMI	]	= "NMI",
-		[ ESTACK_DB2	]	= "#DB2",
-		[ ESTACK_DB1	]	= "#DB1",
 		[ ESTACK_DB	]	= "#DB",
 		[ ESTACK_MCE	]	= "#MC",
 };
 
 const char *stack_type_name(enum stack_type type)
 {
-	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
+	BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);
 
 	if (type == STACK_TYPE_IRQ)
 		return "IRQ";
@@ -79,7 +77,6 @@ static const
 struct estack_pages estack_pages[CEA_ESTACK_PAGES] ____cacheline_aligned = {
 	EPAGERANGE(DF),
 	EPAGERANGE(NMI),
-	EPAGERANGE(DB1),
 	EPAGERANGE(DB),
 	EPAGERANGE(MCE),
 };
@@ -91,7 +88,7 @@ static bool in_exception_stack(unsigned
 	struct pt_regs *regs;
 	unsigned int k;
 
-	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
+	BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);
 
 	begin = (unsigned long)__this_cpu_read(cea_exception_stacks);
 	/*
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -107,7 +107,6 @@ static void __init percpu_setup_exceptio
 	 */
 	cea_map_stack(DF);
 	cea_map_stack(NMI);
-	cea_map_stack(DB1);
 	cea_map_stack(DB);
 	cea_map_stack(MCE);
 }


