Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04741DBCEB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 20:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgETScv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 14:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgETScv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:32:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835ABC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:32:50 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbTVi-0008Vl-HC; Wed, 20 May 2020 20:32:10 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C4E03100C99; Wed, 20 May 2020 20:32:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
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
In-Reply-To: <CALCETrVPM1x5v8Gq7xyF+QqxSWSWTShhc7K02nGJZuB-oVDxNw@mail.gmail.com>
References: <20200515234547.710474468@linutronix.de> <20200515235125.628629605@linutronix.de> <CALCETrWnkuwvTuJKr8Vuecgr_q+1ReBDrTv4XOqGaw7-ZpEeQQ@mail.gmail.com> <87ftbv7nsd.fsf@nanos.tec.linutronix.de> <87a7237k3x.fsf@nanos.tec.linutronix.de> <CALCETrXbQkE1zTW5Ly+ZQgDFLQQa3crPxzK6to0YR+BP5B9q+g@mail.gmail.com> <874ksb7hbg.fsf@nanos.tec.linutronix.de> <CALCETrWw7Vz39ROdBV1QxOQS3gMbPgNu5RRSuhBaXG+UVcFAzw@mail.gmail.com> <20200520022353.GN2869@paulmck-ThinkPad-P72> <CALCETrWAVTjsKwih06GeK237w7RLSE2D2+naiunA=VFEJY1meQ@mail.gmail.com> <CALCETrVPM1x5v8Gq7xyF+QqxSWSWTShhc7K02nGJZuB-oVDxNw@mail.gmail.com>
Date:   Wed, 20 May 2020 20:32:09 +0200
Message-ID: <877dx6wj86.fsf@nanos.tec.linutronix.de>
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
> So maybe the code can change to:
>
>     if (user_mode(regs)) {
>         enter_from_user_mode();
>     } else {
>         if (!__rcu_is_watching()) {
>             /*
>              * If RCU is not watching then the same careful
>              * sequence vs. lockdep and tracing is required.
>              *
>              * This only happens for IRQs that hit the idle loop, and
>              * even that only happens if we aren't using the sane
>              * MWAIT-while-IF=0 mode.
>              */
>             lockdep_hardirqs_off(CALLER_ADDR0);
>             rcu_irq_enter();
>             instrumentation_begin();
>             trace_hardirqs_off_prepare();
>             instrumentation_end();
>             return true;
>         } else {
>             /*
>              * If RCU is watching then the combo function
>              * can be used.
>              */
>             instrumentation_begin();
>             trace_hardirqs_off();
>             rcu_tickle();
>             instrumentation_end();
>         }
>     }
>     return false;
>
> This is exactly what you have except that the cond_rcu part is gone
> and I added rcu_tickle().
>
> Paul, the major change here is that if an IRQ hits normal kernel code
> (i.e. code where RCU is watching and we're not in an EQS), the IRQ
> won't call rcu_irq_enter() and rcu_irq_exit().  Instead it will call
> rcu_tickle() on entry and nothing on exit.  Does that cover all the
> bases?

Fine with me, but the final vote needs to come from Paul and Joel.

Thanks,

        tglx
