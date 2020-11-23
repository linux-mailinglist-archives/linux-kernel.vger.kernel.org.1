Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E792C03A2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgKWKrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:47:14 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:38473 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgKWKrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:47:14 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.51 with ESMTP; 23 Nov 2020 19:47:12 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.126 with ESMTP; 23 Nov 2020 19:47:12 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Mon, 23 Nov 2020 19:45:38 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Byungchul Park <max.byungchul.park@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        will@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        alexander.levin@microsoft.com,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>, duyuyang@gmail.com,
        johannes.berg@intel.com, Tejun Heo <tj@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, willy@infradead.org,
        david@fromorbit.com, Amir Goldstein <amir73il@gmail.com>,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team <kernel-team@lge.com>
Subject: Re: [RFC] Are you good with Lockdep?
Message-ID: <20201123104538.GA9464@X58A-UD3R>
References: <20201111050559.GA24438@X58A-UD3R>
 <20201111105441.GA78848@gmail.com>
 <20201111093609.1bd2b637@gandalf.local.home>
 <87d00jo55p.fsf@nanos.tec.linutronix.de>
 <20201112081030.GB14554@X58A-UD3R>
 <20201112092612.00a19239@gandalf.local.home>
 <CANrsvRNr=JG=-oyYZxn+AXTMX9Ly4OJB0xY5F2Lmqo+1Q_S4fA@mail.gmail.com>
 <20201116090547.GC26078@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116090547.GC26078@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 06:05:47PM +0900, Byungchul Park wrote:
> On Thu, Nov 12, 2020 at 11:58:44PM +0900, Byungchul Park wrote:
> > > > FYI, roughly Lockdep is doing:
> > > >
> > > >    1. Dependency check
> > > >    2. Lock usage correctness check (including RCU)
> > > >    3. IRQ related usage correctness check with IRQFLAGS
> > > >
> > > > 2 and 3 should be there forever which is subtle and have gotten matured.
> > > > But 1 is not. I've been talking about 1. But again, it's not about
> > > > replacing it right away but having both for a while. I'm gonna try my
> > > > best to make it better.
> > >
> > > And I believe lockdep does handle 1. Perhaps show some tangible use case
> > > that you want to cover that you do not believe that lockdep can handle. If
> > > lockdep cannot handle it, it will show us where lockdep is lacking. If it
> > > can handle it, it will educate you on other ways that lockdep can be
> > > helpful in your development ;-)
> 
> 1) OK. Lockdep might work with trylock well.
> 2) Definitely Lockdep cannot do what Cross-release was doing.
> 3) For readlock handling, let me be back later and give you examples. I
>    need check current Lockdep code first. But I have to all-stop what
>    I'm doing at the moment because of a very big personal issue, which
>    is a sad thing.

I just found that Boqun Feng has made a lot of changes into Lockdep
recently to support tracking recursive read locks, while I was checking
how the current Lockdep deals with read locks.

I need to read the code more.. I'll add my opinion on it once I see
how it works. Before that, I'd like to share my approach so that you
guys can see what means to track *wait* and *event*, how simply the tool
can work and what exactly a deadlock detection tool should do. Let me
add my patches onto this thread right away.

I understand you all don't want to replace such a stable tool but I
hope you to see *the* right way to track things for that purpose.
Again, I do never touch any other functions of Lockdep including all
great efforts that have been made but dependency tracking.

Thanks,
Byungchul
