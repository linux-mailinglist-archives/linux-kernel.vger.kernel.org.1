Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58D32D19F2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgLGTos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:44:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgLGTor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:44:47 -0500
Date:   Mon, 7 Dec 2020 11:44:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607370246;
        bh=YpSaQ97s0/LeG9gYyAiylgUPcNxspCmUmFADpTfEoj0=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=V1kAKtuIVZylUBLCt60SDMYtUz8DnWI+X8dDv60tOOVb69OlbtJa/55hpPTn6KPFR
         zSDxVGuA9UzyAwYl2HdwfdZx+jupbgrvfTo/or4o25FzpXMPLLfVCvmrCljo+F3HRq
         fcqy/+ytItnwZajcjVIAtp1/dR/dQWrO928KUZ3WPVxKQXv/7Gpu4InSxiEXsWOu85
         CcG3zQ24CkuPADpDROfQUtF7ehWf8KkuFPMbUHH13cDtXf5Ks/PZJ2O5ItT7UMa6l1
         LBfKtgyXULk+/8kxGb+KcqT0gE6QXmdhntsUdc8T6OteHvZb+47HQvrV1liLfAMDdt
         MeqWd7irt0pQg==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        syzbot+23a256029191772c2f02@syzkaller.appspotmail.com,
        syzbot+56078ac0b9071335a745@syzkaller.appspotmail.com,
        syzbot+867130cb240c41f15164@syzkaller.appspotmail.com
Subject: Re: [patch 3/3] tick: Annotate tick_do_timer_cpu data races
Message-ID: <20201207194406.GK2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201206211253.919834182@linutronix.de>
 <20201206212002.876987748@linutronix.de>
 <20201207120943.GS3021@hirez.programming.kicks-ass.net>
 <87y2i94igo.fsf@nanos.tec.linutronix.de>
 <CANpmjNNQiTbnkkj+ZHS5xxQuQfnWN_JGwSnN-_xqfa=raVrXHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNQiTbnkkj+ZHS5xxQuQfnWN_JGwSnN-_xqfa=raVrXHQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 07:19:51PM +0100, Marco Elver wrote:
> On Mon, 7 Dec 2020 at 18:46, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Mon, Dec 07 2020 at 13:09, Peter Zijlstra wrote:
> > > On Sun, Dec 06, 2020 at 10:12:56PM +0100, Thomas Gleixner wrote:
> > >> +            if (data_race(tick_do_timer_cpu) == TICK_DO_TIMER_BOOT) {
> > >
> > > I prefer the form:
> > >
> > >       if (data_race(tick_do_timer_cpu == TICK_DO_TIMER_BOOT)) {
> > >
> > > But there doesn't yet seem to be sufficient data_race() usage in the
> > > kernel to see which of the forms is preferred. Do we want to bike-shed
> > > this now and document the outcome somewhere?
> >
> > Yes please before we get a gazillion of patches changing half of them
> > half a year from now.
> 
> That rule should be as simple as possible. The simplest would be:
> "Only enclose the smallest required expression in data_race(); keep
> the number of required data_race() expressions to a minimum." (=> want
> least amount of code inside data_race() with the least number of
> data_race()s).
> 
> In the case here, that'd be the "if (data_race(tick_do_timer_cpu) ==
> ..." variant.
> 
> Otherwise there's the possibility that we'll end up with accesses
> inside data_race() that we hadn't planned for. For example, somebody
> refactors some code replacing constants with variables.
> 
> I currently don't know what the rule for Peter's preferred variant
> would be, without running the risk of some accidentally data_race()'d
> accesses.
> 
> Thoughts?

I am also concerned about inadvertently covering code with data_race().

Also, in this particular case, why data_race() rather than READ_ONCE()?
Do we really expect the compiler to be able to optimize this case
significantly without READ_ONCE()?

							Thanx, Paul
