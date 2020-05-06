Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325211C6C37
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 10:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgEFIsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 04:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgEFIsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:48:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA20EC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 01:48:49 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jWFj5-0007pW-Ij; Wed, 06 May 2020 10:48:23 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id F063D1001F5; Wed,  6 May 2020 10:48:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
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
Subject: Re: [patch V4 part 2 15/18] x86/kvm/svm: Handle hardirqs proper on guest enter/exit
In-Reply-To: <baf61125-72f4-5fd1-9ba1-6d55a2efdddd@redhat.com>
References: <20200505134112.272268764@linutronix.de> <20200505134341.579034898@linutronix.de> <baf61125-72f4-5fd1-9ba1-6d55a2efdddd@redhat.com>
Date:   Wed, 06 May 2020 10:48:22 +0200
Message-ID: <87imh9o3e1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 05/05/20 15:41, Thomas Gleixner wrote:
>>  	/*
>> -	 * Tell context tracking that this CPU is back.
>> +	 * VMEXIT disables interrupts (host state, see the CLI in the ASM
>> +	 * above),
>
> Apart from the small inaccuracy in that CLI has moved to vmenter.S, the

yes, that's a leftover from an earlier version.

> comments and commit message don't really help my understanding of why
> this is needed.
>
> It's true that interrupts cause a vmexit, and therefore from the
> processor point of view it's as if they are enabled.  However, the
> interrupt remains latched until local_irq_enable() in vcpu_enter_guest,
> so from the point of view of the kernel interrupts are still disabled. I
> don't understand why it's necessary to inform tracing and lockdep about
> a processor-internal state that doesn't percolate up to the kernel.
>
> For VMX indeed some care is necessary, because we the interrupt is eaten
> rather than latched.  Therefore, we call the interrupt handler from
> handle_external_interrupt_irqoff while EFLAGS.IF is still clear.
> However, if informing trace and lockdep turns out to be unnecessary
> after all for SVM, it should be okay (and clearer) to place the code in
> handle_external_interrupt_irqoff (also in arch/x86/kvm/vmx/vmx.c) .
>
> Instead, if I'm wrong, the four steps above are the same in code and
> comment, and same for the three steps in the comment below.  Can you
> replace them with the "why" of this change?

Sorry, yes the changelog and the comments are not really helpful.

From an instrumentation point of view, entering guest mode or returning
to user mode is more or less the same.

On return to user mode the kernel disables interrupts and the
sysret/iret reenables them. When entering the kernel from user mode via
syscall/exception the entry disables interrupts again. So for
instrumentation, especially interrupt disabled tracing we must track
that change otherwise a latency analysis would claim that interrupts
were disabled for the full time a task spent in user mode.

For guest mode this is practically the same. Before we enter the guest
the host state has to flip back to 'interrupts enabled' and on vmexit
reestablish the interrupt disabled state. The reason of the vmexit
(interrupt, trapped access, halt) is irrelevant from a host state
perspective so the tracking really needs to be right at the edge like we
do for the user mode transitions.

I'll sit down and write up more coherent comments and changelog.

Thanks,

        tglx
