Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27B81DB61E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 16:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgETOU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 10:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETOU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:20:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F49AC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 07:20:28 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbPZc-0002ZW-EX; Wed, 20 May 2020 16:19:56 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E6152100C99; Wed, 20 May 2020 16:19:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V6 12/37] x86/entry: Provide idtentry_entry/exit_cond_rcu()
In-Reply-To: <CALCETrWw7Vz39ROdBV1QxOQS3gMbPgNu5RRSuhBaXG+UVcFAzw@mail.gmail.com>
References: <20200515234547.710474468@linutronix.de> <20200515235125.628629605@linutronix.de> <CALCETrWnkuwvTuJKr8Vuecgr_q+1ReBDrTv4XOqGaw7-ZpEeQQ@mail.gmail.com> <87ftbv7nsd.fsf@nanos.tec.linutronix.de> <87a7237k3x.fsf@nanos.tec.linutronix.de> <CALCETrXbQkE1zTW5Ly+ZQgDFLQQa3crPxzK6to0YR+BP5B9q+g@mail.gmail.com> <874ksb7hbg.fsf@nanos.tec.linutronix.de> <CALCETrWw7Vz39ROdBV1QxOQS3gMbPgNu5RRSuhBaXG+UVcFAzw@mail.gmail.com>
Date:   Wed, 20 May 2020 16:19:55 +0200
Message-ID: <87v9kq4rjo.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:
> On Tue, May 19, 2020 at 2:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> Unless I've missed something, the effect here is that #PF hitting in
> an RCU-watching context will skip rcu_irq_enter(), whereas all IRQs
> (because you converted them) as well as other faults and traps will
> call rcu_irq_enter().

The only reason why this is needed for #PF is that a kernel mode #PF may
sleep. And of course you cannot sleep after calling rcu_irq_enter().

All other interrupts/traps/system vectors cannot sleep ever. So it's a
straight forward enter/exit.

> Once upon a time, we did this horrible thing where, on entry from user
> mode, we would turn on interrupts while still in CONTEXT_USER, which
> means we could get an IRQ in an extended quiescent state.  This means
> that the IRQ code had to end the EQS so that IRQ handlers could use
> RCU.  But I killed this a few years ago -- x86 Linux now has a rule
> that, if IF=1, we are *not* in an EQS with the sole exception of the
> idle code.
>
> In my dream world, we would never ever get IRQs while in an EQS -- we
> would do MWAIT with IF=0 and we would exit the EQS before taking the
> interrupt.  But I guess we still need to support HLT, which means we
> have this mess.

You always can dream, but dont complain about the nightmares :)

Thanks,

        tglx
