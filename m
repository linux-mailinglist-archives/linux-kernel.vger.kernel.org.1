Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6852B071A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgKLN5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgKLN5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:57:01 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85741C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:57:01 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 79so5612930otc.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gg4hBcITMmHsAQ3VH+S26lqbosyuJB6Bks+9rbgVpbY=;
        b=G5xlvt9cfX/zvnBRJyzlApPN6l5CLwfEJfQAyCMK4FXqX6GGpGgXsyQDsBU4nNTMNV
         PDZFy/XABwwVwKHEriR/Q4AZ/s5iLnt7jllyyWjdxV1ZMT4mJ7MGdR8f41kysgv6TZiM
         9aaOpYMC+LW2SoJ4K+NXmSP3AClcplKs+Fnak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gg4hBcITMmHsAQ3VH+S26lqbosyuJB6Bks+9rbgVpbY=;
        b=djrFS9kMpLVnOFAPcOnkzDzixbS8sg3eV5GNE9ZTFB3V0aOPxynV9Dm0xs95w9+SRI
         dnSzFARW9H/H/EJGxB4tdqg/Bpg00qAFgWSaawTjS09oVqrGJ88t1Ia2Be+X2zjcK6+P
         E/bMkhVoLKN56MyT1FKFhUiij8ga8ffmlw0FOU8p3A8Yjb1HuR0W/uiPSDq+RN7czCeZ
         jHWMNIIVhQRm8Rf2FCU69iiidxv/PQW1Fn5+UPN04+H8lNLmnioqc8Gjz7mdVI+epLli
         Jkfrub9J/XiIXf/pG6TXI64JKTvBvicP6D9O4eLjStJEbZPWpIUHHFj6ytbKXNSjpzI1
         IfBw==
X-Gm-Message-State: AOAM531yVOJRxY1kNSvo2RPc/Ne14g/UdufQuU4Su3p08zvmH0/Ck5kv
        r0YskF/9ITOGpMA5NY4s+C53YUjf3Jsa5ylpXQLT8w==
X-Google-Smtp-Source: ABdhPJwghD7gFFm2KvH6t+e0hZ/Y2rE6zOxG1xffyClTvTqrI1Ck16hfwnf3BxeDbozzK7/pVW3UWlJx+BYMPhxhfRY=
X-Received: by 2002:a05:6830:3155:: with SMTP id c21mr17186478ots.281.1605189420933;
 Thu, 12 Nov 2020 05:57:00 -0800 (PST)
MIME-Version: 1.0
References: <20201111050559.GA24438@X58A-UD3R> <20201111105441.GA78848@gmail.com>
 <20201111093609.1bd2b637@gandalf.local.home> <20201112103225.GE14554@X58A-UD3R>
In-Reply-To: <20201112103225.GE14554@X58A-UD3R>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 12 Nov 2020 14:56:49 +0100
Message-ID: <CAKMK7uEAcLizuCEBAN99oFGaN02Wn_ief5asTbzD=Dcv-b=9VQ@mail.gmail.com>
Subject: Re: [RFC] Are you good with Lockdep?
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        "Wilson, Chris" <chris@chris-wilson.co.uk>, duyuyang@gmail.com,
        Johannes Berg <johannes.berg@intel.com>,
        Tejun Heo <tj@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Greg KH <gregkh@linuxfoundation.org>, kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 11:33 AM Byungchul Park <byungchul.park@lge.com> wrote:
>
> On Wed, Nov 11, 2020 at 09:36:09AM -0500, Steven Rostedt wrote:
> > And this is especially true with lockdep, because lockdep only detects the
> > deadlock, it doesn't tell you which lock was the incorrect locking.
> >
> > For example. If we have a locking chain of:
> >
> >  A -> B -> D
> >
> >  A -> C -> D
> >
> > Which on a correct system looks like this:
> >
> >  lock(A)
> >  lock(B)
> >  unlock(B)
> >  unlock(A)
> >
> >  lock(B)
> >  lock(D)
> >  unlock(D)
> >  unlock(B)
> >
> >  lock(A)
> >  lock(C)
> >  unlock(C)
> >  unlock(A)
> >
> >  lock(C)
> >  lock(D)
> >  unlock(D)
> >  unlock(C)
> >
> > which creates the above chains in that order.
> >
> > But, lets say we have a bug and the system boots up doing:
> >
> >  lock(D)
> >  lock(A)
> >  unlock(A)
> >  unlock(D)
> >
> > which creates the incorrect chain.
> >
> >  D -> A
> >
> >
> > Now you do the correct locking:
> >
> >  lock(A)
> >  lock(B)
> >
> > Creates A -> B
> >
> >  lock(A)
> >  lock(C)
> >
> > Creates A -> C
> >
> >  lock(B)
> >  lock(D)
> >
> > Creates B -> D and lockdep detects:
> >
> >  D -> A -> B -> D
> >
> > and gives us the lockdep splat!!!
> >
> > But we don't disable lockdep. We let it continue...
> >
> >  lock(C)
> >  lock(D)
> >
> > Which creates C -> D
> >
> > Now it explodes with D -> A -> C -> D
>
> It would be better to check both so that we can choose either
> breaking a single D -> A chain or both breaking A -> B -> D and
> A -> C -> D.
>
> > Which it already reported. And it can be much more complex when dealing
> > with interrupt contexts and longer chains. That is, perhaps a different
>
> IRQ context is much much worse than longer chains. I understand what you
> try to explain.
>
> > chain had a missing irq disable, now you might get 5 or 6 more lockdep
> > splats because of that one bug.
> >
> > The point I'm making is that the lockdep splats after the first one may
> > just be another version of the same bug and not a new one. Worse, if you
> > only look at the later lockdep splats, it may be much more difficult to
> > find the original bug than if you just had the first one. Believe me, I've
>
> If the later lockdep splats make us more difficult to fix, then we can
> look at the first one. If it's more informative, then we can check the
> all splats. Anyway it's up to us.
>
> > been down that road too many times!
> >
> > And it can be very difficult to know if new lockdep splats are not the same
> > bug, and this will waste a lot of developers time!
>
> Again, we don't have to waste time. We can go with the first one.
>
> > This is why the decision to disable lockdep after the first splat was made.
> > There were times I wanted to check locking somewhere, but is was using
> > linux-next which had a lockdep splat that I didn't care about. So I
> > made it not disable lockdep. And then I hit this exact scenario, that the
> > one incorrect chain was causing reports all over the place. To solve it, I
> > had to patch the incorrect chain to do raw locking to have lockdep ignore
> > it ;-) Then I was able to test the code I was interested in.
>
> It's not a problem of whether it's single-reporting or multi-reporting
> but it's the problem of the lock creating the incorrect chain and making
> you felt hard to handle.
>
> Even if you were using single-reporting Lockdep, you anyway had to
> continue to ignore locks in the same way until you got to the intest.
>
> > I think I understand it. For things like completions and other "wait for
> > events" we have lockdep annotation, but it is rather awkward to implement.
> > Having something that says "lockdep_wait_event()" and
> > "lockdep_exec_event()" wrappers would be useful.
>
> Yes. It's a problem of lack of APIs. It can be done by reverting revert
> of cross-release without big change. ;-)

+1 on lockdep-native support for this. For another use case I've added
annotations for dma_fence_wait, and they're not entirely correct
unfortunately. But the false positives is along the lines of "you
really shouldn't do this, even if it's in theory deadlock free". See

commit 5fbff813a4a328b730cb117027c43a4ae9d8b6c0
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue Jul 7 22:12:05 2020 +0200

   dma-fence: basic lockdep annotations

for fairly lengthy discussion of the problem and what I ended up with.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
