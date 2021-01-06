Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935752EC71E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 00:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbhAFX4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 18:56:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbhAFX4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 18:56:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 643012333B;
        Wed,  6 Jan 2021 23:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1609977363;
        bh=gA46bnzFjTY1FGYHxSKAixtrOZKz7AQN8HjwXSenaeM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xtZscw1NEOE7Vkmuk84KZMwZnYh4KD/4SlvkFsP4jqvjYi0Ccch7xTMxJ2m5i/xrh
         gbiNwVmoSP1I9ada/BeOZLocDDQXlAzILYFC+MnscyCDV7TsR/2fBN7L2BaBFLxtDT
         pvwHrWBozVkEO/2dYDagRk9AfJRB+UY9TW0JrSJ8=
Date:   Wed, 6 Jan 2021 15:56:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] mm: vmscan: support complete shrinker reclaim
Message-Id: <20210106155602.6ce48dfe88ca7b94986b329b@linux-foundation.org>
In-Reply-To: <2d1f1dbb7e018ad02a9e7af36a8c86397a1598a7.1609892546.git.sudaraja@codeaurora.org>
References: <2d1f1dbb7e018ad02a9e7af36a8c86397a1598a7.1609892546.git.sudaraja@codeaurora.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc's added)

On Tue,  5 Jan 2021 16:43:38 -0800 Sudarshan Rajagopalan <sudaraja@codeaurora.org> wrote:

> Ensure that shrinkers are given the option to completely drop
> their caches even when their caches are smaller than the batch size.
> This change helps improve memory headroom by ensuring that under
> significant memory pressure shrinkers can drop all of their caches.
> This change only attempts to more aggressively call the shrinkers
> during background memory reclaim, inorder to avoid hurting the
> performance of direct memory reclaim.
> 
> ...
>
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -424,6 +424,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	long batch_size = shrinker->batch ? shrinker->batch
>  					  : SHRINK_BATCH;
>  	long scanned = 0, next_deferred;
> +	long min_cache_size = batch_size;
> +
> +	if (current_is_kswapd())
> +		min_cache_size = 0;
>  
>  	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
>  		nid = 0;
> @@ -503,7 +507,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	 * scanning at high prio and therefore should try to reclaim as much as
>  	 * possible.
>  	 */
> -	while (total_scan >= batch_size ||
> +	while (total_scan > min_cache_size ||
>  	       total_scan >= freeable) {
>  		unsigned long ret;
>  		unsigned long nr_to_scan = min(batch_size, total_scan);

I don't really see the need to exclude direct reclaim from this fix.

And if we're leaving unscanned objects behind in this situation, the
current code simply isn't working as intended, and 0b1fb40a3b1 ("mm:
vmscan: shrink all slab objects if tight on memory") either failed to
achieve its objective or was later broken?

Vladimir, could you please take a look?
