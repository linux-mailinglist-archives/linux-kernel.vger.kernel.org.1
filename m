Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FB72F0A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 01:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbhAKAMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 19:12:38 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:52814 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbhAKAMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 19:12:38 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B4D54827F97;
        Mon, 11 Jan 2021 11:11:52 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kykoI-005ATR-MN; Mon, 11 Jan 2021 11:11:50 +1100
Date:   Mon, 11 Jan 2021 11:11:50 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm: vmscan: support complete shrinker reclaim
Message-ID: <20210111001150.GB164110@dread.disaster.area>
References: <2d1f1dbb7e018ad02a9e7af36a8c86397a1598a7.1609892546.git.sudaraja@codeaurora.org>
 <20210106155602.6ce48dfe88ca7b94986b329b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106155602.6ce48dfe88ca7b94986b329b@linux-foundation.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=LpQP-O61AAAA:8 a=VwQbUJbxAAAA:8
        a=pGLkceISAAAA:8 a=7-415B0cAAAA:8 a=QjApW-H8ccU26VCOgC8A:9
        a=CjuIK1q_8ugA:10 a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 03:56:02PM -0800, Andrew Morton wrote:
> (cc's added)
> 
> On Tue,  5 Jan 2021 16:43:38 -0800 Sudarshan Rajagopalan <sudaraja@codeaurora.org> wrote:
> 
> > Ensure that shrinkers are given the option to completely drop
> > their caches even when their caches are smaller than the batch size.
> > This change helps improve memory headroom by ensuring that under
> > significant memory pressure shrinkers can drop all of their caches.
> > This change only attempts to more aggressively call the shrinkers
> > during background memory reclaim, inorder to avoid hurting the
> > performance of direct memory reclaim.
> > 

Why isn't the residual scan count accrual (nr_deferred) not
triggering the total_scan > freeable condition that is supposed to
allow shrinkers to completely empty under ongoing memory pressure
events?

> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -424,6 +424,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >  	long batch_size = shrinker->batch ? shrinker->batch
> >  					  : SHRINK_BATCH;
> >  	long scanned = 0, next_deferred;
> > +	long min_cache_size = batch_size;
> > +
> > +	if (current_is_kswapd())
> > +		min_cache_size = 0;
> >  
> >  	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> >  		nid = 0;
> > @@ -503,7 +507,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >  	 * scanning at high prio and therefore should try to reclaim as much as
> >  	 * possible.
> >  	 */
> > -	while (total_scan >= batch_size ||
> > +	while (total_scan > min_cache_size ||
> >  	       total_scan >= freeable) {
> >  		unsigned long ret;
> >  		unsigned long nr_to_scan = min(batch_size, total_scan);
> 
> I don't really see the need to exclude direct reclaim from this fix.
> 
> And if we're leaving unscanned objects behind in this situation, the
> current code simply isn't working as intended, and 0b1fb40a3b1 ("mm:
> vmscan: shrink all slab objects if tight on memory") either failed to
> achieve its objective or was later broken?

This looks to me like just another symptom of the fact that
nr_deferred needs to be tracked per-memcg. i.e. the deferred work
because total_scan < batch_size is not being aggregated against that
specific memcg and hence the accrual of deferred work over multiple
calls is not occurring correctly. Therefore we never meet the
conditions (total_scan > freeable) where the memcg shrinker can
drain the last few freeable entries in the cache.

i.e. see this patchset which makes the deferral of work be
accounted per-memcg:

https://lore.kernel.org/lkml/20210105225817.1036378-1-shy828301@gmail.com/

and that should also allow accrual of the work skipped on each memcg
be accounted across multiple calls to the shrinkers for the same
memcg. Hence as memory pressure within the memcg goes up, the
repeated calls to direct reclaim within that memcg will result in
all of the freeable items in each cache eventually being freed...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
