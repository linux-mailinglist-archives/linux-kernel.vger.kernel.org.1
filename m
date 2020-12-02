Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAD02CB5F7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgLBHx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLBHx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:53:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5B8C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 23:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Eb18uoulS729HQE6Dd/opwsLMg4DEMIq77IfE1DI53k=; b=ShXIYCyKqz3+HVKcHuuF0fGLIm
        nZdss7rQSfyWkEoIepvE6VL3CQ/38OtLstsuAjtG4baAwJRYakZp657fJRSKf57vrCTee1bLDUNFA
        1ySe/zzEv6YIpqlB0Kj1BRXOTWtDMZO12xKA4/W07x56URHm6Y1+tJyJ8jWfGVy7lZEla5YrxTZyE
        e2nhDz+UefmeadUbpbMs+8ToJYlbz1V2Vr1K6mtvBtMeRsamUFCBxiZHkJhrZw1Z/Tmks99aSypgH
        R98XYbClFzt1LCRQBZbYMiwAENIa0OVYXC2Ckk1F0FpuCw98ThExi6qICJFgRZTZ9NBltmsmm/fD8
        nc2HHeHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkMwo-0003cR-Uw; Wed, 02 Dec 2020 07:53:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9AD7A3059DD;
        Wed,  2 Dec 2020 08:53:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C0402C830179; Wed,  2 Dec 2020 08:53:07 +0100 (CET)
Date:   Wed, 2 Dec 2020 08:53:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201202075307.GZ3040@hirez.programming.kicks-ass.net>
References: <160665707945.2808.5384034634184489471.tglx@nanos>
 <160665708065.2808.15317906761841446715.tglx@nanos>
 <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
 <20201130075651.GJ2414@hirez.programming.kicks-ass.net>
 <CAHk-=whPM9Ng6OsNGy==6F6WqEqLFo3kVwS1Hs063woxah5Z5g@mail.gmail.com>
 <20201201073906.GP2414@hirez.programming.kicks-ass.net>
 <20201201075633.GK3092@hirez.programming.kicks-ass.net>
 <CAHk-=wgTsvLivVr05CbfUEUv+maq+qyvsfXTA0W278f_JbJciw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgTsvLivVr05CbfUEUv+maq+qyvsfXTA0W278f_JbJciw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 11:45:25AM -0800, Linus Torvalds wrote:
> On Mon, Nov 30, 2020 at 11:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > So even if an architecture needs to enable interrupts on idle, we need
> > it disabled again when coming out. So we might as well have the arch
> > idle routine then be: STI; HLT; CLI; because then architectures than can
> > idle with interrupts disabled can avoid mucking about with the interrupt
> > state entirely.
> 
> But that's not what the code is doing.
> 
> Go look at it.
> 
> It does sti;hlt;cli;pushf;cli;sti.
> 
> All for no good reason - because the code is structured so that even
> if all the tracking and lockdep is disabled, the pointless "let's
> protect the tracking from interrupts" is still there.
> 
> See what I am complaining about?

Absolutely.

  default_idle()
    arch_cpu_idle()
      sti; hlt;
    cli;
    rcu_idle_exit()
      pushf;
      cli;
      rcu_eqs_exit(false);
      popf;
    sti;

is what it currently looks like, and that's completely insane, no
argument.

What I would like to end up with is:

  default_idle()
    arch_cpu_idle()
      sti; hlt; cli
    rcu_idle_exit()
      rcu_eqs_exit(false);
    sti;

Which would allow architectures that can idle with IRQs disabled to do
so. But that needs a little more work:

 - make arch_cpu_idle() IRQ invariant (we enter and exit with IRQs off)
 - make cpuidle drivers do similar
 - audit all rcu_idle_exit() callers and remove save/restore

