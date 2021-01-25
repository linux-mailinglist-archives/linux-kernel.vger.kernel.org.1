Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1828930339F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbhAZFAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:00:49 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:26446 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726388AbhAYJVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:21:50 -0500
X-IronPort-AV: E=Sophos;i="5.79,373,1602540000"; 
   d="scan'208";a="488894794"
Received: from clt-128-93-178-244.vpn.inria.fr ([128.93.178.244])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 10:20:27 +0100
Date:   Mon, 25 Jan 2021 10:20:27 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Mel Gorman <mgorman@suse.de>
cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/fair: check for idle core
In-Reply-To: <20210125091238.GE20777@suse.de>
Message-ID: <alpine.DEB.2.22.394.2101251017480.5053@hadrien>
References: <1603372550-14680-1-git-send-email-Julia.Lawall@inria.fr> <20201027091936.GS32041@suse.de> <alpine.DEB.2.22.394.2101242134530.2788@hadrien> <20210125091238.GE20777@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Jan 2021, Mel Gorman wrote:

> On Sun, Jan 24, 2021 at 09:38:14PM +0100, Julia Lawall wrote:
> >
> >
> > On Tue, 27 Oct 2020, Mel Gorman wrote:
> >
> > > On Thu, Oct 22, 2020 at 03:15:50PM +0200, Julia Lawall wrote:
> > > > Fixes: 11f10e5420f6 ("sched/fair: Use load instead of runnable load in wakeup path")
> > > > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> > > > Reviewed-by Vincent Guittot <vincent.guittot@linaro.org>
> > > >
> > >
> > > While not a universal win, it was mostly a win or neutral. In few cases
> > > where there was a problem, one benchmark I'm a bit suspicious of generally
> > > as occasionally it generates bad results for unknown and unpredictable
> > > reasons. In another, it was very machine specific and the differences
> > > were small in absolte time rather than relative time. Other tests on the
> > > same machine were fine so overall;
> > >
> > > Acked-by: Mel Gorman <mgorman@suse.de>
> >
> > Recently, we have been testing the phoronix multicore benchmarks.  On v5.9
> > with this patch, the preparation time of phoronix slows down, from ~23
> > seconds to ~28 seconds.  In v5.11-rc4, we see 29 seconds.  It's not yet
> > clear what causes the problem.  But perhaps the patch should be removed
> > from v5.11, until the problem is understood.
> >
> > commit d8fcb81f1acf651a0e50eacecca43d0524984f87
> >
>
> I'm not 100% convinved given that it was a mix of wins and losses. In
> the wakup path in general, universal wins almost never happen. It's not
> 100% clear from your mail what happens during the preparation patch. If
> it included time to download the benchmarks and install then it would be
> inherently variable due to network time (if download) or cache hotness
> (if installing/compiling). While preparation time can be interesting --
> for example, if preparation involves reading a lot of files from disk,
> it's not universally interesting when it's not the critical phase of a
> benchmark.

The benchmark is completely downloaded prior to the runs.  There seems to
be some perturbation to the activation of containerd.  Normally it is
even:  *   *   *   *

and with the patch it becomes more like: *     **     **

That is every other one is on time, and every other one is late.

But I don't know why this happens.

julia

>
> I think it would be better to wait until the problem is fully understood
> to see if it's a timing artifact (e.g. a race between when prev_cpu is
> observed to be idle and when it is busy).
>
> --
> Mel Gorman
> SUSE Labs
>
