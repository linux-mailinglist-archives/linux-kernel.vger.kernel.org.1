Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F5B1DBE35
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 21:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgETTmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 15:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgETTmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:42:43 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 344E2207D3;
        Wed, 20 May 2020 19:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590003762;
        bh=KGbJj3iv0JepJvFoO4BQuY6MfooRvNl3Qi71fMxvlXA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sCvt0RvySlhyUjQHgHlIv0y27A5p0pdLEh03iac3fa4pk0BIaOrKO9S6G/C+o/zto
         cXMtk9pvAkyLkCD+JnwuuIF6xtg+576m2JfOBwP6p19xlQe43HQD+dvxImOL4mNEWp
         MtrgD+5bik7fXt6McnP+RkGS9Y+iTB8FFQAkScz4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 11CEF3522A2B; Wed, 20 May 2020 12:42:42 -0700 (PDT)
Date:   Wed, 20 May 2020 12:42:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V6 12/37] x86/entry: Provide
 idtentry_entry/exit_cond_rcu()
Message-ID: <20200520194242.GV2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CALCETrWnkuwvTuJKr8Vuecgr_q+1ReBDrTv4XOqGaw7-ZpEeQQ@mail.gmail.com>
 <87ftbv7nsd.fsf@nanos.tec.linutronix.de>
 <87a7237k3x.fsf@nanos.tec.linutronix.de>
 <CALCETrXbQkE1zTW5Ly+ZQgDFLQQa3crPxzK6to0YR+BP5B9q+g@mail.gmail.com>
 <874ksb7hbg.fsf@nanos.tec.linutronix.de>
 <CALCETrWw7Vz39ROdBV1QxOQS3gMbPgNu5RRSuhBaXG+UVcFAzw@mail.gmail.com>
 <20200520022353.GN2869@paulmck-ThinkPad-P72>
 <CALCETrWAVTjsKwih06GeK237w7RLSE2D2+naiunA=VFEJY1meQ@mail.gmail.com>
 <CALCETrVPM1x5v8Gq7xyF+QqxSWSWTShhc7K02nGJZuB-oVDxNw@mail.gmail.com>
 <87y2pmv281.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2pmv281.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 09:24:46PM +0200, Thomas Gleixner wrote:
> Andy Lutomirski <luto@kernel.org> writes:
> > On Wed, May 20, 2020 at 8:36 AM Andy Lutomirski <luto@kernel.org> wrote:
> >     if (user_mode(regs)) {
> >         enter_from_user_mode();
> >     } else {
> >         if (!__rcu_is_watching()) {
> >             /*
> >              * If RCU is not watching then the same careful
> >              * sequence vs. lockdep and tracing is required.
> >              *
> >              * This only happens for IRQs that hit the idle loop, and
> >              * even that only happens if we aren't using the sane
> >              * MWAIT-while-IF=0 mode.
> >              */
> >             lockdep_hardirqs_off(CALLER_ADDR0);
> >             rcu_irq_enter();
> >             instrumentation_begin();
> >             trace_hardirqs_off_prepare();
> >             instrumentation_end();
> >             return true;
> >         } else {
> >             /*
> >              * If RCU is watching then the combo function
> >              * can be used.
> >              */
> >             instrumentation_begin();
> >             trace_hardirqs_off();
> >             rcu_tickle();
> >             instrumentation_end();
> >         }
> >     }
> >     return false;
> >
> > This is exactly what you have except that the cond_rcu part is gone
> > and I added rcu_tickle().
> >
> > Paul, the major change here is that if an IRQ hits normal kernel code
> > (i.e. code where RCU is watching and we're not in an EQS), the IRQ
> > won't call rcu_irq_enter() and rcu_irq_exit().  Instead it will call
> > rcu_tickle() on entry and nothing on exit.  Does that cover all the
> > bases?
> 
> Just chatted with Paul on IRC and he thinks this should work, but he's
> not sure whether it's actually sane :)

I will have more to say after coding it up.  ;-)

							Thanx, Paul
