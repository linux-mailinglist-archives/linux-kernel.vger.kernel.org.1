Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0C128CAD7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391032AbgJMJQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 05:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390781AbgJMJQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 05:16:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68912C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 02:16:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602580612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5rOifehkuYFGPneVAZms+PTki+P1cDBR+GDcChJTPHI=;
        b=mKoO27VAtj0UJpkU3A4Fk7alvCs17U8TTWtHwXghAFBpbVVkuLVAUup7L5bqVU7tCppTBR
        7UcSEyptdhEuZhybY+OYbrzwTg57Lb2J4qJiHWbC+FIP4PvGALnpdmPr++y4ToGnCqBaXG
        /yQqSR0Vqh2eusM/rtL7ZtiqPO7iRJ9XHhoxhYHFSbJyM6Dvh8EB2z3UftlBGlnZ2NmT4D
        RFKCTkPJ8fK5N6mlPP15KlG6w3v8riHivAl7ddD+lVS3if0aotQyQL9E1x1ERdleROv/sT
        o3t1S/zea3ww4LaMeCfEiXaKGC16+fKob6yHekjcOZnV09naUuz3CzcWvsbckA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602580612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5rOifehkuYFGPneVAZms+PTki+P1cDBR+GDcChJTPHI=;
        b=bwVPfjdVT9Rd9YZ7fSiLYpaqkQf503eQu5E2OZVpoOdfClcuGnHM6kay47rQba5qB9i25o
        hcnBX97UiN5VeWAw==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] RCU changes for v5.10
In-Reply-To: <CAHk-=wiWowWNsrOh+Ye+b_x=7_4MQmvXq0cdmLwqr2=YYj-jgA@mail.gmail.com>
References: <20201012141451.GA3425471@gmail.com> <CAHk-=wiWowWNsrOh+Ye+b_x=7_4MQmvXq0cdmLwqr2=YYj-jgA@mail.gmail.com>
Date:   Tue, 13 Oct 2020 11:16:52 +0200
Message-ID: <87362ipjsr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On Mon, Oct 12 2020 at 13:25, Linus Torvalds wrote:
> I don't absolutely hate that code, and I'm willing to be convinced
> about how little it matter for people who don't want to have the
> counting overhead, but I refuse to pull it as some secret hidden thing
> that isn't even mentioned in the pull request.
>
> Honestly, I did not get any strong arguments for why making the
> preempt count unconditional was such an important thing.
>
> Yes, Thomas pointed me at a couple of uses that were garbage, but even
> the people involved in those seemed to agree they were legacy garbage.

Yes, we agreed on those parts and also started to act on your request to
remove these constructs where non core code is changing behaviour
depending on some context check by either seperating it or handing the
condition in from the call sites.

You said in that original discussion:

> Of course core code can (and will) look at things like
>
>	if (in_interrupt())
>	    .. schedule work asynchronously ..
>
>  because core code ends up being called from odd places, and code like
>  that is expected to have understanding of the rules it plays with.
>
>  But something like RCU is a very different beast from some "walk the
>  scatter-gather list" code.
>
>  RCU does its work in the background, and works with lots of different
>  things. And it's so core and used everywhere that it knows about these
>  things. I mean, we literally have special code explicitly to let RCU
>  know "we entered kernel context now".

As Paul was facing the problem of not knowing the exact context on
PREEMPT_NONE kernels which can aside of the raw spinlock issue cause
deadlocks vs. the page allocator, we had the impression that solving
this particular itch with a consistent preempt count was justified.

As you did not voice objections on Pauls series which incorporated my
initial work, I was encouraging Paul to go ahead with this. Of course if
I misinterpreted your silence on that patch submission, I need to fine
tune my void decoder.

That said, I fully agree that this all should have been part of the pull
request message and in hindsight I should have reminded Ingo to be very
careful about that when we were splitting up the pull request pile of
the tip tree.

I hope that clarifies the context some more and makes the whole thing
more palatable.

Thanks,

        tglx

/me goes back to stare at in_*() constructs...
