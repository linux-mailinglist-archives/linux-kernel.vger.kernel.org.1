Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4104629C94E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766309AbgJ0T6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2901568AbgJ0T6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:58:21 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 662902074B;
        Tue, 27 Oct 2020 19:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603828700;
        bh=Mu4N80can/Ynx71LFmJ7oF1XMX9zbpnmOk5ld4BIlJs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XYoLeftktDYJ8/vtIS7Wf56cCj8UraYq4wcuYwqpCK8pgihNCpNWPOkYmw7UyhzFL
         SJ1zr1vPgLqJXK2kACTHk7pbtvnNLwmXRiwF0kQ/cdHdoRDu88fkVOH9oncMqWSP9j
         BgJdnDr23m8m5wNuJ/voRcVC3n7NKplqVAy9E1RA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 04BF4352285C; Tue, 27 Oct 2020 12:58:20 -0700 (PDT)
Date:   Tue, 27 Oct 2020 12:58:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: Recording allocation location for blocks of memory?
Message-ID: <20201027195819.GZ3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201027175810.GA26121@paulmck-ThinkPad-P72>
 <CACT4Y+bB4sZjLx6tL6F5XzxGk5iG7j=SPbDkX_bwRXmXB=JxXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bB4sZjLx6tL6F5XzxGk5iG7j=SPbDkX_bwRXmXB=JxXA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 07:40:19PM +0100, Dmitry Vyukov wrote:
> On Tue, Oct 27, 2020 at 6:58 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Hello!
> >
> > I have vague memories of some facility some time some where that recorded
> > who allocated a given block of memory, but am not seeing anything that
> > does this at present.  The problem is rare enough and the situation
> > sufficiently performance-sensitive that things like ftrace need not apply,
> > and the BPF guys suggest that BPF might not be the best tool for this job.
> >
> > The problem I am trying to solve is that a generic function that detects
> > reference count underflow that was passed to call_rcu(), and there are
> > a lot of places where the underlying problem might lie, and pretty much
> > no information.  One thing that could help is something that identifies
> > which use case the underflow corresponds to.
> >
> > So, is there something out there (including old patches) that, given a
> > pointer to allocated memory, gives some information about who allocated
> > it?  Or should I risk further inflaming the MM guys by creating one?  ;-)
> 
> Hi Paul,
> 
> KASAN can do this. However (1) it has non-trivial overhead on its own
> (but why would you want to debug something without KASAN anyway :))
> (2) there is no support for doing just stack collection without the
> rest of KASAN (they are integrated at the moment) (3) there is no
> public interface function that does what you want, though, it should
> be easy to add it. The code is around here:
> https://github.com/torvalds/linux/blob/master/mm/kasan/report.c#L111-L128
> 
> Since KASAN already bears all overheads of stack collection/storing I
> was thinking that lots of other debugging tools could indeed piggy
> back on that and print much more informative errors message when
> enabled with KASAN.
> 
> Since recently KASAN also memorizes up to 2 "other" stacks per
> objects. This is currently used to memorize call_rcu stacks, since
> they are frequently more useful than actual free stacks for
> rcu-managed objects.
> That mechanism could also memorize last refcount stacks, however I
> afraid that they will evict everything else, since we have only 2
> slots, and frequently there are lots of refcount operations.

I am guessing that KASAN's overhead make it a no-go in this case
(in production), but am checking.  But this might change if we can
reproduce in a more controlled setting.

Huh.  I bet that I could do something with the information accessed by
print_tracking() in the slub allocator.  This of course means that I am
betting that we could run with CONFIG_SLUB_DEBUG=y.  Thoughts?

							Thanx, Paul
