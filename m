Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C412C1EED76
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 23:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgFDVnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 17:43:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgFDVnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:43:49 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AB442067B;
        Thu,  4 Jun 2020 21:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591307028;
        bh=NrT7kxPJZH9oq0NI7hXVoXdbIA1zZsJXsd3+en/OdUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r8aUrwNbHRix1KcN/0gp2RjDKP6AUB88k/5FTg4dFXc6HUQjUPB0cTVS6vvLoLDhV
         FVvDfS1pPkJwnLSAbcQq4yJKIXEP4oMXG3E5dDz7cylvZMkcj6G0wTD0LDPHf3hp6d
         Ay4t4J92gQ7iRig2XwcJxKCWT/ln2zvfWfTec4Mg=
Date:   Thu, 4 Jun 2020 14:43:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Reddy <charante@codeaurora.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
Subject: Re: [PATCH] mm, page_alloc: skip ->waternark_boost for atomic
 order-0 allocations
Message-Id: <20200604144347.7804bc81bbd6dd3027a1cb10@linux-foundation.org>
In-Reply-To: <1589882284-21010-1-git-send-email-charante@codeaurora.org>
References: <1589882284-21010-1-git-send-email-charante@codeaurora.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 15:28:04 +0530 Charan Teja Reddy <charante@codeaurora.org> wrote:

> When boosting is enabled, it is observed that rate of atomic order-0
> allocation failures are high due to the fact that free levels in the
> system are checked with ->watermark_boost offset. This is not a problem
> for sleepable allocations but for atomic allocations which looks like
> regression.
> 
> This problem is seen frequently on system setup of Android kernel
> running on Snapdragon hardware with 4GB RAM size. When no extfrag event
> occurred in the system, ->watermark_boost factor is zero, thus the
> watermark configurations in the system are:
>    _watermark = (
>           [WMARK_MIN] = 1272, --> ~5MB
>           [WMARK_LOW] = 9067, --> ~36MB
>           [WMARK_HIGH] = 9385), --> ~38MB
>    watermark_boost = 0
> 
> After launching some memory hungry applications in Android which can
> cause extfrag events in the system to an extent that ->watermark_boost
> can be set to max i.e. default boost factor makes it to 150% of high
> watermark.
>    _watermark = (
>           [WMARK_MIN] = 1272, --> ~5MB
>           [WMARK_LOW] = 9067, --> ~36MB
>           [WMARK_HIGH] = 9385), --> ~38MB
>    watermark_boost = 14077, -->~57MB
> 
> With default system configuration, for an atomic order-0 allocation to
> succeed, having free memory of ~2MB will suffice. But boosting makes
> the min_wmark to ~61MB thus for an atomic order-0 allocation to be
> successful system should have minimum of ~23MB of free memory(from
> calculations of zone_watermark_ok(), min = 3/4(min/2)). But failures are
> observed despite system is having ~20MB of free memory. In the testing,
> this is reproducible as early as first 300secs since boot and with
> furtherlowram configurations(<2GB) it is observed as early as first
> 150secs since boot.
> 
> These failures can be avoided by excluding the ->watermark_boost in
> watermark caluculations for atomic order-0 allocations.

Do we have any additional reviewer input on this one?

> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3709,6 +3709,18 @@ static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
>  		}
>  
>  		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
> +		/*
> +		 * Allow GFP_ATOMIC order-0 allocations to exclude the
> +		 * zone->watermark_boost in its watermark calculations.
> +		 * We rely on the ALLOC_ flags set for GFP_ATOMIC
> +		 * requests in gfp_to_alloc_flags() for this. Reason not to
> +		 * use the GFP_ATOMIC directly is that we want to fall back
> +		 * to slow path thus wake up kswapd.
> +		 */
> +		if (unlikely(!order && !(alloc_flags & ALLOC_WMARK_MASK) &&
> +		     (alloc_flags & (ALLOC_HARDER | ALLOC_HIGH)))) {
> +			mark = zone->_watermark[WMARK_MIN];
> +		}
>  		if (!zone_watermark_fast(zone, order, mark,
>  				       ac->highest_zoneidx, alloc_flags)) {
>  			int ret;

It would seem smart to do

--- a/mm/page_alloc.c~mm-page_alloc-skip-waternark_boost-for-atomic-order-0-allocations-fix
+++ a/mm/page_alloc.c
@@ -3745,7 +3745,6 @@ retry:
 			}
 		}
 
-		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
 		/*
 		 * Allow GFP_ATOMIC order-0 allocations to exclude the
 		 * zone->watermark_boost in their watermark calculations.
@@ -3757,6 +3756,8 @@ retry:
 		if (unlikely(!order && !(alloc_flags & ALLOC_WMARK_MASK) &&
 		     (alloc_flags & (ALLOC_HARDER | ALLOC_HIGH)))) {
 			mark = zone->_watermark[WMARK_MIN];
+		} else {
+			mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
 		}
 		if (!zone_watermark_fast(zone, order, mark,
 				       ac->highest_zoneidx, alloc_flags)) {

but that makes page_alloc.o 16 bytes larger, so I guess don't bother.
