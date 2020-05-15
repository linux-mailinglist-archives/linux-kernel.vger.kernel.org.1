Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB3B1D508F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 16:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgEOOc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 10:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgEOOc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:32:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3975CC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:32:57 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZbNx-00029H-Vb; Fri, 15 May 2020 16:32:26 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 3AF7A100606; Fri, 15 May 2020 16:32:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        paulmck <paulmck@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes\, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V4 part 4 15/24] x86/db: Split out dr6/7 handling
In-Reply-To: <2107385142.21313.1589478370190.JavaMail.zimbra@efficios.com>
Date:   Fri, 15 May 2020 16:32:25 +0200
Message-ID: <87h7whe0au.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:

> ----- On May 14, 2020, at 1:28 PM, Thomas Gleixner tglx@linutronix.de wrote:
>
>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
>>> ----- On May 5, 2020, at 9:49 AM, Thomas Gleixner tglx@linutronix.de wrote:
>>>> +
>>>> +static __always_inline void debug_exit(unsigned long dr7)
>>>> +{
>>>> +	set_debugreg(dr7, 7);
>>>> +}
>>>
>
> * Question 1
>
>>> Out of curiosity, what prevents the compiler from moving instructions
>>> outside of the code regions surrounded by entry/exit ? This is an always
>>> inline, which invokes set_debugreg which is inline for CONFIG_PARAVIRT_XXL=n,
>>> which in turn uses an asm() (not volatile), without any memory
>>> clobber.

I misread 'surrounded by entry/exit'.

Reading it again I assume you mean nmi_enter/exit(). And yes, there is a
compiler barrier missing.

Thanks,

        tglx

8<----------------
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e11ad0791dc3..ae1e61345225 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -718,6 +718,13 @@ static __always_inline void debug_enter(unsigned long *dr6, unsigned long *dr7)
 	get_debugreg(*dr7, 7);
 	set_debugreg(0, 7);
 
+	/*
+	 * Ensure the compiler doesn't lower the above statements into
+	 * the critical section; disabling breakpoints late would not
+	 * be good.
+	 */
+	barrier();
+
 	/*
 	 * The Intel SDM says:
 	 *
@@ -737,6 +744,12 @@ static __always_inline void debug_enter(unsigned long *dr6, unsigned long *dr7)
 
 static __always_inline void debug_exit(unsigned long dr7)
 {
+	/*
+	 * Ensure the compiler doesn't raise this statement into
+	 * the critical section; enabling breakpoints early would
+	 * not be good.
+	 */
+	barrier();
 	set_debugreg(dr7, 7);
 }
 
