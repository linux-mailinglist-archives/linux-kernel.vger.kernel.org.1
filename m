Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B8A2951A4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 19:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503654AbgJURjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 13:39:07 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:52530 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405345AbgJURjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 13:39:06 -0400
X-IronPort-AV: E=Sophos;i="5.77,401,1596492000"; 
   d="scan'208";a="473731042"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 19:39:03 +0200
Date:   Wed, 21 Oct 2020 19:39:02 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Mel Gorman <mgorman@suse.de>
cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>
Subject: Re: [PATCH] sched/fair: check for idle core
In-Reply-To: <20201021170050.GI32041@suse.de>
Message-ID: <alpine.DEB.2.22.394.2010211937150.8475@hadrien>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr> <20201021112038.GC32041@suse.de> <20201021122532.GA30733@vingu-book> <20201021124700.GE32041@suse.de> <alpine.DEB.2.22.394.2010211452100.8475@hadrien> <20201021131827.GF32041@suse.de>
 <alpine.DEB.2.22.394.2010211522340.57356@hadrien> <20201021150800.GG32041@suse.de> <CAKfTPtDs1t6mt7fPgoGg+fT-JKmaqWybNVBN3kZhag6M4+8RUg@mail.gmail.com> <20201021170050.GI32041@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Oct 2020, Mel Gorman wrote:

> On Wed, Oct 21, 2020 at 05:19:53PM +0200, Vincent Guittot wrote:
> > On Wed, 21 Oct 2020 at 17:08, Mel Gorman <mgorman@suse.de> wrote:
> > >
> > > On Wed, Oct 21, 2020 at 03:24:48PM +0200, Julia Lawall wrote:
> > > > > I worry it's overkill because prev is always used if it is idle even
> > > > > if it is on a node remote to the waker. It cuts off the option of a
> > > > > wakee moving to a CPU local to the waker which is not equivalent to the
> > > > > original behaviour.
> > > >
> > > > But it is equal to the original behavior in the idle prev case if you go
> > > > back to the runnable load average days...
> > > >
> > >
> > > It is similar but it misses the sync treatment and sd->imbalance_pct part of
> > > wake_affine_weight which has unpredictable consequences. The data
> > > available is only on the fully utilised case.
> >
> > In fact It's the same because runnable_load_avg was null when cpu is idle, so
> > if prev_cpu was idle, we were selecting prev_idle
> >
>
> Sync wakeups may only consider this_cpu and the load of the waker but
> in that case, it was probably selected already by the sync check in
> wake_affine_idle which will pass except when the domain is overloaded.
> Fair enough, I'll withdraw any concerns. It could have done with a
> comment :/

Sure, I'll resend the patch and extend the log message with this issue.

Otherwise, I was wondering are there any particular kinds of applications
where gathering the threads back with the waker is a good idea?  I've been
looking more at applications with N threads on N cores, where it would be
best for the threads to remain where they are.

thanks,
julia
