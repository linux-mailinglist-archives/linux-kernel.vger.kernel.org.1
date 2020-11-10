Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D75E2AD33D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgKJKNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbgKJKNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:13:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA7BC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nz6aJuGegJProF9XLT/RGIExULTP252ycSJBYreRDHs=; b=PqaCh7I0KNstuxHUkYz6+8G3lP
        k94XHLdZq3HGLAgIE1rNi+MyzdnbZT/8VtzGPXgPLCWFpctYvgoxCXIB1/3nEnYlyaeXD8s7zhjPo
        2XQfTNu7ItJ8o7Qw2r6wNXZ7kmnxMBVzH0q0Jpsoku7/MjG/E1ecZ9FL0WDq1Eqf9eAYOJKesdXXO
        MzpVc2S9CBps1aon/zh+4Z900vgGyq96XqjtfDZeKdm5ldKXNUtRGgNLqAoQPs75op84/aEU999uY
        uSNEhUU+8qGtMKbVzemJDqcDn4bHwdAEiCqyt79+voFKt7BA5qgli73C3pUr9hR25Pl18oG1fM4U0
        jIYAf/gg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcQeC-0004sk-5P; Tue, 10 Nov 2020 10:13:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 931153006E0;
        Tue, 10 Nov 2020 11:13:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 80C00203E11E5; Tue, 10 Nov 2020 11:13:07 +0100 (CET)
Date:   Tue, 10 Nov 2020 11:13:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 1/7] static_call/x86: Add __static_call_returnl0()
Message-ID: <20201110101307.GO2651@hirez.programming.kicks-ass.net>
References: <20201110005609.40989-1-frederic@kernel.org>
 <20201110005609.40989-2-frederic@kernel.org>
 <20201110095515.GA2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110095515.GA2594@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:55:15AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 10, 2020 at 01:56:03AM +0100, Frederic Weisbecker wrote:
> 
> > [fweisbec: s/disp16/data16, integrate into text_get_insn(), elaborate
> >  comment on the resulting insn, emulate on int3 trap, provide validation,
> >  uninline __static_call_return0() for HAVE_STATIC_CALL]

> Why did you add full emulation of this? The patch I send to you used the
> text_poke_bp(.emulate) argument to have it emulate an actual call to the
> out-of-line version of that function.
> 
> That should work fine and is a lot less code.

For reference; the below is what I send you. Actually doing the
__static_call_return0() call while we poke the magic XOR instruction is
much simpler.

---
Subject: static_call/x86: Add __static_call_return0
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Oct 12 11:43:32 CEST 2020

Provide a stub function that return 0 and wire up the static call site
patching to replace the CALL with a single 5 byte instruction that
clears %RAX, the return value register.

The function can be cast to any function pointer type that has a
single %RAX return (including pointers).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/static_call.c |   11 ++++++++++-
 include/linux/static_call.h   |    6 ++++++
 kernel/static_call.c          |    5 +++++
 3 files changed, 21 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -13,12 +13,21 @@ enum insn_type {
 
 static void __ref __static_call_transform(void *insn, enum insn_type type, void *func)
 {
+	/*
+	 * disp16 disp16 xorq %rax, %rax - a single 5 byte instruction that clears %rax
+	 */
+	static const u8 ret0[5] = { 0x66, 0x66, 0x48, 0x31, 0xc0 };
 	int size = CALL_INSN_SIZE;
+	const void *emulate = NULL;
 	const void *code;
 
 	switch (type) {
 	case CALL:
 		code = text_gen_insn(CALL_INSN_OPCODE, insn, func);
+		if (func == &__static_call_return0) {
+			emulate = code;
+			code = ret0;
+		}
 		break;
 
 	case NOP:
@@ -41,7 +50,7 @@ static void __ref __static_call_transfor
 	if (unlikely(system_state == SYSTEM_BOOTING))
 		return text_poke_early(insn, code, size);
 
-	text_poke_bp(insn, code, size, NULL);
+	text_poke_bp(insn, code, size, emulate);
 }
 
 static void __static_call_validate(void *insn, bool tail)
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -136,6 +136,8 @@ extern void arch_static_call_transform(v
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
+extern long __static_call_return0(void);
+
 extern int __init static_call_init(void);
 
 struct static_call_mod {
@@ -187,6 +189,8 @@ extern int static_call_text_reserved(voi
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
 
+static inline long __static_call_return0(void) { return 0; }
+
 static inline int static_call_init(void) { return 0; }
 
 struct static_call_key {
@@ -234,6 +238,8 @@ static inline int static_call_text_reser
 
 #else /* Generic implementation */
 
+static inline long __static_call_return0(void) { return 0; }
+
 static inline int static_call_init(void) { return 0; }
 
 struct static_call_key {
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -438,6 +438,11 @@ int __init static_call_init(void)
 }
 early_initcall(static_call_init);
 
+long __static_call_return0(void)
+{
+	return 0;
+}
+
 #ifdef CONFIG_STATIC_CALL_SELFTEST
 
 static int func_a(int x)
