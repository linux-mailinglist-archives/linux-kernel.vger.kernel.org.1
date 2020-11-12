Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453532B0788
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgKLO0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:26:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:43936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLO0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:26:16 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF23722240;
        Thu, 12 Nov 2020 14:26:13 +0000 (UTC)
Date:   Thu, 12 Nov 2020 09:26:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, torvalds@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        alexander.levin@microsoft.com, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com
Subject: Re: [RFC] Are you good with Lockdep?
Message-ID: <20201112092612.00a19239@gandalf.local.home>
In-Reply-To: <20201112081030.GB14554@X58A-UD3R>
References: <20201111050559.GA24438@X58A-UD3R>
        <20201111105441.GA78848@gmail.com>
        <20201111093609.1bd2b637@gandalf.local.home>
        <87d00jo55p.fsf@nanos.tec.linutronix.de>
        <20201112081030.GB14554@X58A-UD3R>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 17:10:30 +0900
Byungchul Park <byungchul.park@lge.com> wrote:

> 2. Does Lockdep do what a deadlock detection tool should do? From
>    internal engine to APIs, all the internal data structure and
>    algotithm of Lockdep is only looking at lock(?) acquisition order.
>    Fundamentally Lockdep cannot work correctly with all general cases,
>    for example, read/write/trylock and any wait/event.

But lockdep does handle read/write/trylock and can handle wait/event (just
needs better wrappers to annotate this). Perhaps part of the confusion here
is that we believe that lockdep already does what you are asking for.

> 
>    This can be done by re-introducing cross-release but still partially.
>    A deadlock detector tool should thoroughly focus on *waits* and
>    *events* to be more perfect at detecting deadlock because the fact is
>    *waits* and their *events* that never reach cause deadlock.
> 
>    With the philosophy of Lockdep, we can only handle partial cases
>    fundamently. We have no choice but to do various work-around or adopt
>    tricky ways to cover more cases if we keep using Lockdep.
> 
> > That said, I'm not at all interested in a wholesale replacement of
> > lockdep which will take exactly the same amount of time to stabilize and
> > weed out the shortcomings again.  
> 
> I don't want to bother ones who don't want to be bothered from the tool.
> But I think some day we need a new tool doing exactly what it should do
> for deadlock detection for sure.
> 
> I'm willing to make it matured on my own, or with ones who need a
> stronger tool or willing to make it matured together - I wish tho.
> That's why I suggest to make both there until the new tool gets
> considered stable.
> 
> FYI, roughly Lockdep is doing:
> 
>    1. Dependency check
>    2. Lock usage correctness check (including RCU)
>    3. IRQ related usage correctness check with IRQFLAGS
> 
> 2 and 3 should be there forever which is subtle and have gotten matured.
> But 1 is not. I've been talking about 1. But again, it's not about
> replacing it right away but having both for a while. I'm gonna try my
> best to make it better.

And I believe lockdep does handle 1. Perhaps show some tangible use case
that you want to cover that you do not believe that lockdep can handle. If
lockdep cannot handle it, it will show us where lockdep is lacking. If it
can handle it, it will educate you on other ways that lockdep can be
helpful in your development ;-)

-- Steve
