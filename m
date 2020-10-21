Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE54294D71
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441526AbgJUNYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:24:51 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:50411 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409401AbgJUNYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:24:50 -0400
X-IronPort-AV: E=Sophos;i="5.77,401,1596492000"; 
   d="scan'208";a="473688826"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 15:24:49 +0200
Date:   Wed, 21 Oct 2020 15:24:48 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Mel Gorman <mgorman@suse.de>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>
Subject: Re: [PATCH] sched/fair: check for idle core
In-Reply-To: <20201021131827.GF32041@suse.de>
Message-ID: <alpine.DEB.2.22.394.2010211522340.57356@hadrien>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr> <20201021112038.GC32041@suse.de> <20201021122532.GA30733@vingu-book> <20201021124700.GE32041@suse.de> <alpine.DEB.2.22.394.2010211452100.8475@hadrien> <20201021131827.GF32041@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-389467810-1603286689=:57356"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-389467810-1603286689=:57356
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT



On Wed, 21 Oct 2020, Mel Gorman wrote:

> On Wed, Oct 21, 2020 at 02:56:06PM +0200, Julia Lawall wrote:
> >
> >
> > On Wed, 21 Oct 2020, Mel Gorman wrote:
> >
> > > On Wed, Oct 21, 2020 at 02:25:32PM +0200, Vincent Guittot wrote:
> > > > > I see Vincent already agreed with the patch so I could be wrong.  Vincent,
> > > > > did I miss something stupid?
> > > >
> > > > This patch fixes the problem that we don't favor anymore the prev_cpu when it is idle since
> > > > commit 11f10e5420f6ce because load is not null when cpu is idle whereas runnable_load was
> > > > And this is important because this will�then decide in which LLC we will looks for a cpu
> > > >
> > >
> > > Ok, that is understandable but I'm still concerned that the fix simply
> > > trades one problem for another by leaving related tasks remote to each
> > > other and increasing cache misses and remote data accesses.
> > >
> > > wake_affine_weight is a giant pain because really we don't care about the
> > > load on the waker CPU or its available, we care about whether it has idle
> > > siblings that can be found quickly. As tempting as ripping it out is,
> > > it never happened because sometimes it makes the right decision.
> >
> > My goal was to restore the previous behavior, when runnable load was used.
> > The patch removing the use of runnable load (11f10e5420f6) presented it
> > basically as that load balancing was using it, so wakeup should use it
> > too, and any way it didn't matter because idle CPUS were checked for
> > anyway.
> >
>
> Which is fair.
>
> > Is your point of view that the proposed change is overkill?  Or is it that
> > the original behavior was not desirable?
> >
>
> I worry it's overkill because prev is always used if it is idle even
> if it is on a node remote to the waker. It cuts off the option of a
> wakee moving to a CPU local to the waker which is not equivalent to the
> original behaviour.

But it is equal to the original behavior in the idle prev case if you go
back to the runnable load average days...

The problem seems impossible to solve, because there is no way to know by
looking only at prev and this whether the thread would prefer to stay
where it was or go to the waker.

julia
--8323329-389467810-1603286689=:57356--
