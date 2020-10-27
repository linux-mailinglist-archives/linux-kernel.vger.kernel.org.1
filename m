Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75EC29C952
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829164AbgJ0T7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1795822AbgJ0T7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:59:18 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAD262076B;
        Tue, 27 Oct 2020 19:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603828756;
        bh=cA0iuWfjAUg+glshXTaaW3nSPKlAqfZmxvdoguoYc20=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=2ZNBcb61IpUkeHc8vjL1cEPuU3P8vpbevyaHWMy472Qe2QQQ19lWUgsayZsXaMjEe
         4X4cJe8d4jZ4xDg3iXN/grcW+jVsEIs7VrF0GH9IqHatbku4spnp8ljkLoPbuOt7kB
         mZwErNP3jX1uqo1on01WoVXL9neIOvt2ZuHqGBSU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7D313352285C; Tue, 27 Oct 2020 12:59:16 -0700 (PDT)
Date:   Tue, 27 Oct 2020 12:59:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: Recording allocation location for blocks of memory?
Message-ID: <20201027195916.GA3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201027175810.GA26121@paulmck-ThinkPad-P72>
 <CACT4Y+bB4sZjLx6tL6F5XzxGk5iG7j=SPbDkX_bwRXmXB=JxXA@mail.gmail.com>
 <CANpmjNNxAvembOetv15FfZ=04mpj0Qwx+1tnn22tABaHHRRv=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNxAvembOetv15FfZ=04mpj0Qwx+1tnn22tABaHHRRv=Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 08:45:43PM +0100, Marco Elver wrote:
> Hi Paul,
> 
> Let me add another option below, as an alternative to KASAN that
> Dmitry mentioned.
> 
> On Tue, 27 Oct 2020 at 19:40, Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Tue, Oct 27, 2020 at 6:58 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > Hello!
> > >
> > > I have vague memories of some facility some time some where that recorded
> > > who allocated a given block of memory, but am not seeing anything that
> > > does this at present.  The problem is rare enough and the situation
> > > sufficiently performance-sensitive that things like ftrace need not apply,
> > > and the BPF guys suggest that BPF might not be the best tool for this job.
> 
> Since you mention "performance-sensitive" and you say that "ftrace
> need not apply", I have a suspicion that KASAN also need not apply.
> KASAN itself uses lib/stackdepot.c to store stacktraces, which
> deduplicates stack traces by hashing them; but over time its usage
> grows significantly and may also not be suitable for production even
> if you manage to use it without KASAN somehow.
> 
> If you want something for production that more or less works
> out-of-the-box, KFENCE might work. :-)
> v5 here: https://lkml.kernel.org/r/20201027141606.426816-1-elver@google.com
> 
> You can just get KFENCE to print the allocation stack (and free stack
> if the object has been freed) by calling
> kfence_handle_page_fault(obj_addr), which should generate a
> use-after-free report if the object was allocated via KFENCE. You
> could check if the object was allocated with KFENCE with
> is_kfence_address(), but kfence_handle_page_fault() will just return
> if the object wasn't allocated via KFENCE.
> 
> If you do have the benefit of whatever you're hunting being deployed
> across lots of machines in production, it might work.
> 
> If it's not deployed across lots of machines, you might get lucky if
> you set kfence.sample_interval=1 and CONFIG_KFENCE_NUM_OBJECTS=4095
> (will use 32 MiB for the KFENCE pool; but you can make it larger to be
> sure it won't be exhausted too soon).

Thank you!  I will look into this as well!

							Thanx, Paul

> > > The problem I am trying to solve is that a generic function that detects
> > > reference count underflow that was passed to call_rcu(), and there are
> > > a lot of places where the underlying problem might lie, and pretty much
> > > no information.  One thing that could help is something that identifies
> > > which use case the underflow corresponds to.
> > >
> > > So, is there something out there (including old patches) that, given a
> > > pointer to allocated memory, gives some information about who allocated
> > > it?  Or should I risk further inflaming the MM guys by creating one?  ;-)
> >
> > Hi Paul,
> >
> > KASAN can do this. However (1) it has non-trivial overhead on its own
> > (but why would you want to debug something without KASAN anyway :))
> > (2) there is no support for doing just stack collection without the
> > rest of KASAN (they are integrated at the moment) (3) there is no
> > public interface function that does what you want, though, it should
> > be easy to add it. The code is around here:
> > https://github.com/torvalds/linux/blob/master/mm/kasan/report.c#L111-L128
> >
> > Since KASAN already bears all overheads of stack collection/storing I
> > was thinking that lots of other debugging tools could indeed piggy
> > back on that and print much more informative errors message when
> > enabled with KASAN.
> >
> > Since recently KASAN also memorizes up to 2 "other" stacks per
> > objects. This is currently used to memorize call_rcu stacks, since
> > they are frequently more useful than actual free stacks for
> > rcu-managed objects.
> > That mechanism could also memorize last refcount stacks, however I
> > afraid that they will evict everything else, since we have only 2
> > slots, and frequently there are lots of refcount operations.
