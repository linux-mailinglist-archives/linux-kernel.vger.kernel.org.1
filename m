Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990032F5703
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbhANB5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:57:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729576AbhAMXnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 18:43:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67A2B22248;
        Wed, 13 Jan 2021 23:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1610581370;
        bh=ertrlZE0rwiNSTRbz6JlyUmrWKabmyACTp9lthgNjBo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=riRbTyls2G1jpPe9KSJLt4CMRENZtXdUGbOsfSHcRN9pOksh/W8eajnRztz7kvNg2
         C0IAt/wIFbQs/5iqnTYpPCsP6X8zyAxjeVsjsXbUYntOUgBsBWZoJhvNehnxGMnXDK
         9/2H6Oy/1LNWTnOGQ+j+CVsgC5EuOcf9bLIfNRjI=
Date:   Wed, 13 Jan 2021 15:42:49 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Reddy <charante@codeaurora.org>
Cc:     mhocko@suse.com, vbabka@suse.cz, khalid.aziz@oracle.com,
        ngupta@nitingupta.dev, vinmenon@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/compaction: return proper state in
 should_proactive_compact_node
Message-Id: <20210113154249.51d3410f3c658d6bedd2bff4@linux-foundation.org>
In-Reply-To: <1610546586-18998-1-git-send-email-charante@codeaurora.org>
References: <1610546586-18998-1-git-send-email-charante@codeaurora.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 19:33:06 +0530 Charan Teja Reddy <charante@codeaurora.org> wrote:

> should_proactive_compact_node() returns true when sum of the
> fragmentation score of all the zones in the node is greater than the
> wmark_high of compaction which then triggers the proactive compaction
> that operates on the individual zones of the node. But proactive
> compaction runs on the zone only when the fragmentation score of the
> zone is greater than wmark_low(=wmark_high - 10).
> 
> This means that the sum of the fragmentation scores of all the zones can
> exceed the wmark_high but individual zone scores can still be less than
> the wmark_low which makes the unnecessary trigger of the proactive
> compaction only to return doing nothing.
> 
> Another issue with the return of proactive compaction with out even
> trying is its deferral. It is simply deferred for 1 <<
> COMPACT_MAX_DEFER_SHIFT if the scores across the proactive compaction is
> same, thinking that compaction didn't make any progress but in reality
> it didn't even try. With the delay between successive retries for
> proactive compaction is 500msec, it can result into the deferral for
> ~30sec with out even trying the proactive compaction.
> 
> Test scenario is that: compaction_proactiveness=50 thus the wmark_low =
> 50 and wmark_high = 60. System have 2 zones(Normal and Movable) with
> sizes 5GB and 6GB respectively. After opening some apps on the android,
> the fragmentation scores of these zones are 47 and 49 respectively.
> Since the sum of these fragmentation scores are above the wmark_high
> which triggers the proactive compaction and there since the individual
> zone scores are below wmark_low, it returns without trying the
> compaction. As a result the fragmentation scores of the zones are still
> 47 and 49 which makes the existing logic to defer the compaction
> thinking that noprogress is made across the compaction.
> 
> So, run the proactive compaction on the node zones only when atleast one
> of the zones fragmentation score is greater than wmark_low. This avoids
> the unnecessary deferral and retries of the compaction.
> 
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1964,6 +1964,26 @@ static unsigned int fragmentation_score_node(pg_data_t *pgdat)
>  	return score;
>  }
>  
> +/*
> + * Returns the maximum of fragmentation scores of zones in a node. This is
> + * used in taking the decission of whether to trigger the proactive compaction
> + * on the zones of this node.
> + */
> +static unsigned int fragmentation_score_node_zones_max(pg_data_t *pgdat)
> +{
> +	int zoneid;
> +	unsigned int max = 0;
> +
> +	for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
> +		struct zone *zone;
> +
> +		zone = &pgdat->node_zones[zoneid];
> +		max = max_t(unsigned int, fragmentation_score_zone(zone), max);

Both args are unsigned int, so I think the max_t is unnecessary?

--- a/mm/compaction.c~mm-compaction-return-proper-state-in-should_proactive_compact_node-fix
+++ a/mm/compaction.c
@@ -1975,7 +1975,7 @@ static unsigned int fragmentation_score_
 		struct zone *zone;
 
 		zone = &pgdat->node_zones[zoneid];
-		max = max_t(unsigned int, fragmentation_score_zone(zone), max);
+		max = max(fragmentation_score_zone(zone), max);
 	}
 
 	return max;
_



