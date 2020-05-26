Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C099C1E1EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 11:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbgEZJqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 05:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgEZJqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 05:46:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08288C03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 02:46:02 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1jdW9I-0000j2-Ha; Tue, 26 May 2020 11:45:28 +0200
Date:   Tue, 26 May 2020 11:45:26 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 07/25] lockdep: Add preemption disabled assertion API
Message-ID: <20200526094526.GA428152@debian-buster-darwi.lab.linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-8-a.darwish@linutronix.de>
 <20200522175503.GQ325280@hirez.programming.kicks-ass.net>
 <20200523145942.vjk3z6pbj6yicqa4@linutronix.de>
 <20200523224132.GD2483@worktop.programming.kicks-ass.net>
 <20200525102241.GF325303@hirez.programming.kicks-ass.net>
 <20200526005231.GA377571@debian-buster-darwi.lab.linutronix.de>
 <20200526081350.GI317569@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526081350.GI317569@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 10:13:50AM +0200, Peter Zijlstra wrote:
> On Tue, May 26, 2020 at 02:52:31AM +0200, Ahmed S. Darwish wrote:
> > Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > +#define lockdep_assert_irqs_enabled()					\
> > > +do {									\
> > > +	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirqs_enabled));	\
> > > +} while (0)
> > >
> >
> > Given that lockdep_off() is defined at lockdep.c as:
> >
> >   void lockdep_off(void)
> >   {
> >         current->lockdep_recursion += LOCKDEP_OFF;
> >   }
> >
> > This would imply that all of the macros:
> >
> >   - lockdep_assert_irqs_enabled()
> >   - lockdep_assert_irqs_disabled()
> >   - lockdep_assert_in_irq()
> >   - lockdep_assert_preemption_disabled()
> >   - lockdep_assert_preemption_enabled()
> >
> > will do the lockdep checks *even if* lockdep_off() was called.
> >
> > This doesn't sound right. Even if all of the above macros call sites
> > didn't care about lockdep_off()/on(), it is semantically incoherent.
>
> lockdep_off() is an abomination and really should not exist.
>
> That dm-cache-target.c thing, for example, is atrocious shite that will
> explode on -rt. Whoever wrote that needs a 'medal'.
>
> People using it deserve all the pain they get.
>
> Also; IRQ state _should_ be tracked irrespective of tracking lock
> dependencies -- I see that that currently isn't entirely the case, lemme
> go fix that.
>

Exactly, currently all the lockdep IRQ checks gets nullified if
lockdep_off() is called. That was the source of my confusion.

If you'll have any extra patches on this, I can also queue them in the
next iteration of this series, before this patch.

Thanks a lot,

--
Ahmed S. Darwish
Linutronix GmbH
