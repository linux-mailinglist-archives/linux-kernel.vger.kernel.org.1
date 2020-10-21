Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC29294FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 17:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502496AbgJUP0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 11:26:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:50890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502433AbgJUP0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:26:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A3E79ADDF;
        Wed, 21 Oct 2020 15:26:40 +0000 (UTC)
Date:   Wed, 21 Oct 2020 16:26:37 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
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
        Gilles.Muller@inria.fr
Subject: Re: [PATCH] sched/fair: check for idle core
Message-ID: <20201021152637.GH32041@suse.de>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <20201021112038.GC32041@suse.de>
 <20201021122532.GA30733@vingu-book>
 <20201021124700.GE32041@suse.de>
 <alpine.DEB.2.22.394.2010211452100.8475@hadrien>
 <20201021131827.GF32041@suse.de>
 <alpine.DEB.2.22.394.2010211547190.57356@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2010211547190.57356@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 03:48:59PM +0200, Julia Lawall wrote:
> > I worry it's overkill because prev is always used if it is idle even
> > if it is on a node remote to the waker. It cuts off the option of a
> > wakee moving to a CPU local to the waker which is not equivalent to the
> > original behaviour.
> 
> Could it be possible to check p->recent_used_cpu?  If that is prev (or on
> the same socket?), then prev could be a good choice.  If that is on the
> same socket as the waker, then maybe the waker would be better.
> 

It is an interesting idea but the treatment of p->recent_used_cpu is a
bit strange though. At one point, I looked at reconciling all the select
CPU paths into one single pass (prototype worked back in 5.6-era but was
not a universal win). As part of that, I remembered that the setting
of recent_used_cpu is a problem because it can be set to the wakers
recent_used_cpu by this chunk

                if (want_affine)
                        current->recent_used_cpu = cpu;

Fixing that on its own causes other problems. From an unposted series
that "fixed it" as the last part of 14 patch series;

    After select_idle_sibling, the *wakers* recent_used_cpu is set to the
    CPU used for the wakee. This was necessary at the time as without it,
    the miss rate was unacceptably high.  It still works, but it is less
    efficient than it can be.

    This patch leaves the waker state alone and uses either the previous CPU on
    a hit or the target CPU on a miss when the recently used CPU is examined
    for idleness. The rest of the series is important as without it, this
    patch improves the number of hits but the miss rate gets ridiculously high.
    After the rest of the series, the hit and miss rates are both higher but
    the miss rate is acceptable.

As the hunk means that recent_used_cpu could have been set based
on a previous wakeup, it makes it unreliable for making cross-node
decisions.  p->recent_used_cpu's primary purpose at the moment is to
avoid select_idle_sibling searches.

-- 
Mel Gorman
SUSE Labs
