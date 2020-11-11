Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8BD2AF3B4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgKKOgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:36:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:46490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgKKOgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:36:23 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45C062067D;
        Wed, 11 Nov 2020 14:36:11 +0000 (UTC)
Date:   Wed, 11 Nov 2020 09:36:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, joel@joelfernandes.org,
        alexander.levin@microsoft.com, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com
Subject: Re: [RFC] Are you good with Lockdep?
Message-ID: <20201111093609.1bd2b637@gandalf.local.home>
In-Reply-To: <20201111105441.GA78848@gmail.com>
References: <20201111050559.GA24438@X58A-UD3R>
        <20201111105441.GA78848@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 11:54:41 +0100
Ingo Molnar <mingo@kernel.org> wrote:

> * Byungchul Park <byungchul.park@lge.com> wrote:
> 
> > PROBLEM 1) First of all, Lockdep gets disabled on the first detection.  
> 
> Lockdep disabling itself after the first warning was an intentional 
> and deliberate design decision. (See more details below.)
> 

[..]

> Making the code simpler is always welcome, but I disagree with 
> enabling multiple warnings, for the technical reasons outlined above.

I 100% agree with Ingo. I wish we could stop *all* warnings after the first
one. The number of times people sent me bug reports with warnings without
showing me previous warnings that caused me to go on wild goose chases is
too many to count. The first warning is the *only* thing I look at.
Anything after that is likely to be caused by the integrity of the system
being compromised by the first bug.

And this is especially true with lockdep, because lockdep only detects the
deadlock, it doesn't tell you which lock was the incorrect locking.

For example. If we have a locking chain of:

 A -> B -> D

 A -> C -> D

Which on a correct system looks like this:

 lock(A)
 lock(B)
 unlock(B)
 unlock(A)

 lock(B)
 lock(D)
 unlock(D)
 unlock(B)

 lock(A)
 lock(C)
 unlock(C)
 unlock(A)

 lock(C)
 lock(D)
 unlock(D)
 unlock(C)

which creates the above chains in that order.

But, lets say we have a bug and the system boots up doing:

 lock(D)
 lock(A)
 unlock(A)
 unlock(D)

which creates the incorrect chain.

 D -> A


Now you do the correct locking:

 lock(A)
 lock(B)

Creates A -> B

 lock(A)
 lock(C)

Creates A -> C

 lock(B)
 lock(D)

Creates B -> D and lockdep detects:

 D -> A -> B -> D

and gives us the lockdep splat!!!

But we don't disable lockdep. We let it continue...

 lock(C)
 lock(D)

Which creates C -> D

Now it explodes with D -> A -> C -> D

Which it already reported. And it can be much more complex when dealing
with interrupt contexts and longer chains. That is, perhaps a different
chain had a missing irq disable, now you might get 5 or 6 more lockdep
splats because of that one bug.

The point I'm making is that the lockdep splats after the first one may
just be another version of the same bug and not a new one. Worse, if you
only look at the later lockdep splats, it may be much more difficult to
find the original bug than if you just had the first one. Believe me, I've
been down that road too many times!

And it can be very difficult to know if new lockdep splats are not the same
bug, and this will waste a lot of developers time!

This is why the decision to disable lockdep after the first splat was made.
There were times I wanted to check locking somewhere, but is was using
linux-next which had a lockdep splat that I didn't care about. So I
made it not disable lockdep. And then I hit this exact scenario, that the
one incorrect chain was causing reports all over the place. To solve it, I
had to patch the incorrect chain to do raw locking to have lockdep ignore
it ;-) Then I was able to test the code I was interested in.

> 
> > PROBLEM 2) Lockdep forces us to emulate lock acquisition for non-lock.  
> 
> >    I have the patch set. Let me share it with you in a few days.  
> 
> Not sure I understand the "problem 2)" outlined here, but I'm looking 
> forward to your patchset!
> 

I think I understand it. For things like completions and other "wait for
events" we have lockdep annotation, but it is rather awkward to implement.
Having something that says "lockdep_wait_event()" and
"lockdep_exec_event()" wrappers would be useful.

-- Steve
