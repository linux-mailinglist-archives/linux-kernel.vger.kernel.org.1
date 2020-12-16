Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E12B2DC85F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 22:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgLPVdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 16:33:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgLPVc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 16:32:59 -0500
Date:   Wed, 16 Dec 2020 13:32:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608154339;
        bh=UXK9MDu7bw2KYUBnvCq3dU2ZOCXRgvuj8pV/QxIWxJE=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jiQxPdF3pFWyijJz5wAzR0DomRzTYmb1s9Qh8EFMHweX2Lzzv/6aZyuKAGgmcbV0y
         4082lZlOoQeb27yUc6NB7rOISPxLoLS2bhWDcDE9OjwXvmAcWfw0RM3auhwbzrKoIi
         Y2SYIYxN9Qr066aLtWwZE4oo963X0ucSvVbb5HFmm9I0tbbxWLIf8ENSMtk3ac34FA
         X6pHuByQj41db9qW9/RSG6lNDFCOqPKGf6lXrPsiUcZxMJNT0X31CB94G7uS09za4T
         9ONy9fvk3WtEBAw8dTnOV4f/V8a7mealpc0AflG65C945DI3/evIt+XSPbEq8EjbLI
         +tWNLzPwRqWOw==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
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
Message-ID: <20201216213218.GM2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201206212002.876987748@linutronix.de>
 <20201207120943.GS3021@hirez.programming.kicks-ass.net>
 <87y2i94igo.fsf@nanos.tec.linutronix.de>
 <CANpmjNNQiTbnkkj+ZHS5xxQuQfnWN_JGwSnN-_xqfa=raVrXHQ@mail.gmail.com>
 <20201207194406.GK2657@paulmck-ThinkPad-P72>
 <20201208081129.GQ2414@hirez.programming.kicks-ass.net>
 <20201208150309.GP2657@paulmck-ThinkPad-P72>
 <873606tx1c.fsf@nanos.tec.linutronix.de>
 <20201216211931.GL2657@paulmck-ThinkPad-P72>
 <87czz9savm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czz9savm.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 10:23:57PM +0100, Thomas Gleixner wrote:
> On Wed, Dec 16 2020 at 13:19, Paul E. McKenney wrote:
> > On Wed, Dec 16, 2020 at 01:27:43AM +0100, Thomas Gleixner wrote:
> >> So my intent was to document that this code does not care about anything
> >> else than what I'd consider to be plain compiler bugs.
> >> 
> >> My conclusion might be wrong as usual :)
> >
> > Given that there is no optimization potential, then the main reason to use
> > data_race() instead of *_ONCE() is to prevent KCSAN from considering the
> > accesses when looking for data races.  But that is mostly for debugging
> > accesses, in cases when these accesses are not really part of the
> > concurrent algorithm.
> >
> > So if I understand the situation correctly, I would be using *ONCE().
> 
> Could this be spelled out somewhere in Documentation/ please?

Good point!  I will put a patch together.

							Thanx, Paul
