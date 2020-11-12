Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC3D2B02C5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgKLKdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:33:51 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:49451 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727789AbgKLKdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:33:50 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.53 with ESMTP; 12 Nov 2020 19:33:47 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.126 with ESMTP; 12 Nov 2020 19:33:47 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Thu, 12 Nov 2020 19:32:25 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>, torvalds@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        joel@joelfernandes.org, alexander.levin@microsoft.com,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com
Subject: Re: [RFC] Are you good with Lockdep?
Message-ID: <20201112103225.GE14554@X58A-UD3R>
References: <20201111050559.GA24438@X58A-UD3R>
 <20201111105441.GA78848@gmail.com>
 <20201111093609.1bd2b637@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111093609.1bd2b637@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 09:36:09AM -0500, Steven Rostedt wrote:
> And this is especially true with lockdep, because lockdep only detects the
> deadlock, it doesn't tell you which lock was the incorrect locking.
> 
> For example. If we have a locking chain of:
> 
>  A -> B -> D
> 
>  A -> C -> D
> 
> Which on a correct system looks like this:
> 
>  lock(A)
>  lock(B)
>  unlock(B)
>  unlock(A)
> 
>  lock(B)
>  lock(D)
>  unlock(D)
>  unlock(B)
> 
>  lock(A)
>  lock(C)
>  unlock(C)
>  unlock(A)
> 
>  lock(C)
>  lock(D)
>  unlock(D)
>  unlock(C)
> 
> which creates the above chains in that order.
> 
> But, lets say we have a bug and the system boots up doing:
> 
>  lock(D)
>  lock(A)
>  unlock(A)
>  unlock(D)
> 
> which creates the incorrect chain.
> 
>  D -> A
> 
> 
> Now you do the correct locking:
> 
>  lock(A)
>  lock(B)
> 
> Creates A -> B
> 
>  lock(A)
>  lock(C)
> 
> Creates A -> C
> 
>  lock(B)
>  lock(D)
> 
> Creates B -> D and lockdep detects:
> 
>  D -> A -> B -> D
> 
> and gives us the lockdep splat!!!
> 
> But we don't disable lockdep. We let it continue...
> 
>  lock(C)
>  lock(D)
> 
> Which creates C -> D
> 
> Now it explodes with D -> A -> C -> D

It would be better to check both so that we can choose either
breaking a single D -> A chain or both breaking A -> B -> D and
A -> C -> D.

> Which it already reported. And it can be much more complex when dealing
> with interrupt contexts and longer chains. That is, perhaps a different

IRQ context is much much worse than longer chains. I understand what you
try to explain.

> chain had a missing irq disable, now you might get 5 or 6 more lockdep
> splats because of that one bug.
> 
> The point I'm making is that the lockdep splats after the first one may
> just be another version of the same bug and not a new one. Worse, if you
> only look at the later lockdep splats, it may be much more difficult to
> find the original bug than if you just had the first one. Believe me, I've

If the later lockdep splats make us more difficult to fix, then we can
look at the first one. If it's more informative, then we can check the
all splats. Anyway it's up to us.

> been down that road too many times!
> 
> And it can be very difficult to know if new lockdep splats are not the same
> bug, and this will waste a lot of developers time!

Again, we don't have to waste time. We can go with the first one.

> This is why the decision to disable lockdep after the first splat was made.
> There were times I wanted to check locking somewhere, but is was using
> linux-next which had a lockdep splat that I didn't care about. So I
> made it not disable lockdep. And then I hit this exact scenario, that the
> one incorrect chain was causing reports all over the place. To solve it, I
> had to patch the incorrect chain to do raw locking to have lockdep ignore
> it ;-) Then I was able to test the code I was interested in.

It's not a problem of whether it's single-reporting or multi-reporting
but it's the problem of the lock creating the incorrect chain and making
you felt hard to handle.

Even if you were using single-reporting Lockdep, you anyway had to
continue to ignore locks in the same way until you got to the intest.

> I think I understand it. For things like completions and other "wait for
> events" we have lockdep annotation, but it is rather awkward to implement.
> Having something that says "lockdep_wait_event()" and
> "lockdep_exec_event()" wrappers would be useful.

Yes. It's a problem of lack of APIs. It can be done by reverting revert
of cross-release without big change. ;-)

Thanks,
Byungchul
