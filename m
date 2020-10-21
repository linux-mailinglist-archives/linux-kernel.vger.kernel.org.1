Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E42295144
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 19:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437308AbgJURAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 13:00:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:46490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390091AbgJURAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 13:00:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58673AE7D;
        Wed, 21 Oct 2020 17:00:53 +0000 (UTC)
Date:   Wed, 21 Oct 2020 18:00:50 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
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
Message-ID: <20201021170050.GI32041@suse.de>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <20201021112038.GC32041@suse.de>
 <20201021122532.GA30733@vingu-book>
 <20201021124700.GE32041@suse.de>
 <alpine.DEB.2.22.394.2010211452100.8475@hadrien>
 <20201021131827.GF32041@suse.de>
 <alpine.DEB.2.22.394.2010211522340.57356@hadrien>
 <20201021150800.GG32041@suse.de>
 <CAKfTPtDs1t6mt7fPgoGg+fT-JKmaqWybNVBN3kZhag6M4+8RUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtDs1t6mt7fPgoGg+fT-JKmaqWybNVBN3kZhag6M4+8RUg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 05:19:53PM +0200, Vincent Guittot wrote:
> On Wed, 21 Oct 2020 at 17:08, Mel Gorman <mgorman@suse.de> wrote:
> >
> > On Wed, Oct 21, 2020 at 03:24:48PM +0200, Julia Lawall wrote:
> > > > I worry it's overkill because prev is always used if it is idle even
> > > > if it is on a node remote to the waker. It cuts off the option of a
> > > > wakee moving to a CPU local to the waker which is not equivalent to the
> > > > original behaviour.
> > >
> > > But it is equal to the original behavior in the idle prev case if you go
> > > back to the runnable load average days...
> > >
> >
> > It is similar but it misses the sync treatment and sd->imbalance_pct part of
> > wake_affine_weight which has unpredictable consequences. The data
> > available is only on the fully utilised case.
> 
> In fact It's the same because runnable_load_avg was null when cpu is idle, so
> if prev_cpu was idle, we were selecting prev_idle
> 

Sync wakeups may only consider this_cpu and the load of the waker but
in that case, it was probably selected already by the sync check in
wake_affine_idle which will pass except when the domain is overloaded.
Fair enough, I'll withdraw any concerns. It could have done with a
comment :/

-- 
Mel Gorman
SUSE Labs
