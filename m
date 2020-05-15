Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2378F1D4F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 15:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgEONna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 09:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgEONn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:43:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAAFC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 06:43:29 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZac2-00016e-TB; Fri, 15 May 2020 15:42:55 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id AE6E5100606; Fri, 15 May 2020 15:42:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 3 13/29] x86/traps: Prepare for using DEFINE_IDTENTRY
In-Reply-To: <87mu6azp7m.fsf@nanos.tec.linutronix.de>
References: <20200505134354.774943181@linutronix.de> <20200505134904.556327833@linutronix.de> <CALCETrUyA5bN2ScrdhwEYZSUpyOhO+MaEu1X3PwX6vHGGCkqCg@mail.gmail.com> <87mu6azp7m.fsf@nanos.tec.linutronix.de>
Date:   Fri, 15 May 2020 15:42:53 +0200
Message-ID: <874kshxqjm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy,

Thomas Gleixner <tglx@linutronix.de> writes:
> In historic kernels si_addr was simply set to regs->ip and the uprobe
> muck changed that in commit b02ef20a9fba08 ("uprobes/x86: Fix the wrong
> ->si_addr when xol triggers a trap")
>     
>     If the probed insn triggers a trap, ->si_addr = regs->ip is technically
>     correct, but this is not what the signal handler wants; we need to pass
>     the address of the probed insn, not the address of xol slot.
>
> Now that I filled my own blanks, I think that I can come up with a
> halfways useful comment.

That's what I came up with (delta patch)

Thanks,

        tglx

8<---------------
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -205,6 +205,16 @@ static void do_error_trap(struct pt_regs
 	}
 }
 
+/*
+ * Posix requires to provide the address of the faulting instruction for
+ * SIGILL (#UD) and SIGFPE (#DE) in the si_addr member of siginfo_t.
+ *
+ * This address is usually regs->ip, but when an uprobe moved the code out
+ * of line then regs->ip points to the XOL code which would confuse
+ * anything which analyzes the fault address vs. the unmodified binary. If
+ * a trap happened in XOL code then uprobe maps regs->ip back to the
+ * original instruction address.
+ */
 static __always_inline void __user *error_get_trap_addr(struct pt_regs *regs)
 {
 	return (void __user *)uprobe_get_trap_addr(regs);
