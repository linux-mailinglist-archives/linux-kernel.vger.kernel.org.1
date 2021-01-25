Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F764304A32
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 21:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbhAZFLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:11:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:57018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbhAYJeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:34:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A276CAFF3;
        Mon, 25 Jan 2021 09:12:40 +0000 (UTC)
Date:   Mon, 25 Jan 2021 09:12:38 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/fair: check for idle core
Message-ID: <20210125091238.GE20777@suse.de>
References: <1603372550-14680-1-git-send-email-Julia.Lawall@inria.fr>
 <20201027091936.GS32041@suse.de>
 <alpine.DEB.2.22.394.2101242134530.2788@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2101242134530.2788@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 09:38:14PM +0100, Julia Lawall wrote:
> 
> 
> On Tue, 27 Oct 2020, Mel Gorman wrote:
> 
> > On Thu, Oct 22, 2020 at 03:15:50PM +0200, Julia Lawall wrote:
> > > Fixes: 11f10e5420f6 ("sched/fair: Use load instead of runnable load in wakeup path")
> > > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> > > Reviewed-by Vincent Guittot <vincent.guittot@linaro.org>
> > >
> >
> > While not a universal win, it was mostly a win or neutral. In few cases
> > where there was a problem, one benchmark I'm a bit suspicious of generally
> > as occasionally it generates bad results for unknown and unpredictable
> > reasons. In another, it was very machine specific and the differences
> > were small in absolte time rather than relative time. Other tests on the
> > same machine were fine so overall;
> >
> > Acked-by: Mel Gorman <mgorman@suse.de>
> 
> Recently, we have been testing the phoronix multicore benchmarks.  On v5.9
> with this patch, the preparation time of phoronix slows down, from ~23
> seconds to ~28 seconds.  In v5.11-rc4, we see 29 seconds.  It's not yet
> clear what causes the problem.  But perhaps the patch should be removed
> from v5.11, until the problem is understood.
> 
> commit d8fcb81f1acf651a0e50eacecca43d0524984f87
> 

I'm not 100% convinved given that it was a mix of wins and losses. In
the wakup path in general, universal wins almost never happen. It's not
100% clear from your mail what happens during the preparation patch. If
it included time to download the benchmarks and install then it would be
inherently variable due to network time (if download) or cache hotness
(if installing/compiling). While preparation time can be interesting --
for example, if preparation involves reading a lot of files from disk,
it's not universally interesting when it's not the critical phase of a
benchmark.

I think it would be better to wait until the problem is fully understood
to see if it's a timing artifact (e.g. a race between when prev_cpu is
observed to be idle and when it is busy).

-- 
Mel Gorman
SUSE Labs
