Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCE22E7443
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgL2VYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:24:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgL2VYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:24:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E96FB2074B;
        Tue, 29 Dec 2020 21:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1609277032;
        bh=RxQOQuf1Y+ttZzPNxwEdSK4WRKnL6B6y/lEz6gysaUA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lzoh8IKgzoFFAs+0T/a7Yr+aA2fYNzSEUOgK43NfytqD5LjxvCjmnJdtPC9M7B3V1
         keLX6X2QKaQ6SgCtbr728CYh5HB/BtyVjXiIShy2J07n5Sa566lJsLTcT6n5aPKcTo
         QbwcHoE8HfioRMEIkyjJhd9FD0iVgDdT/rC9FhfA=
Date:   Tue, 29 Dec 2020 13:23:51 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hailong liu <carver4lio@163.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        liu.hailong6@zte.com.cn
Subject: Re: [PATCH] mm/page_alloc:add a missing mm_page_alloc_zone_locked
 tracepoint
Message-Id: <20201229132351.025362ec38b0a763340a82de@linux-foundation.org>
In-Reply-To: <20201228132901.41523-1-carver4lio@163.com>
References: <20201228132901.41523-1-carver4lio@163.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Dec 2020 21:29:01 +0800 Hailong liu <carver4lio@163.com> wrote:

> The trace point *trace_mm_page_alloc_zone_locked()* in __rmqueue() does not
> currently cover all branches. Add the missing tracepoint and check the page
> before do that.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2871,7 +2871,7 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
>  	    zone_page_state(zone, NR_FREE_PAGES) / 2) {
>  		page = __rmqueue_cma_fallback(zone, order);
>  		if (page)
> -			return page;
> +			goto out;
>  	}
>  #endif
>  retry:
> @@ -2884,8 +2884,9 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
>  								alloc_flags))
>  			goto retry;
>  	}
> -
> -	trace_mm_page_alloc_zone_locked(page, order, migratetype);
> +out:
> +	if (page)
> +		trace_mm_page_alloc_zone_locked(page, order, migratetype);
>  	return page;
>  }

Looks right to me, but it generates a warning.  Using IS_ENABLED()
works around it.



From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm-page_alloc-add-a-missing-mm_page_alloc_zone_locked-tracepoint-fix

use IS_ENABLED() to suppress warning

mm/page_alloc.c: In function ‘__rmqueue’:
mm/page_alloc.c:2889:1: warning: label ‘out’ defined but not used [-Wunused-label]
 out:
 ^~~

Cc: Hailong liu <liu.hailong6@zte.com.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/page_alloc.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

--- a/mm/page_alloc.c~mm-page_alloc-add-a-missing-mm_page_alloc_zone_locked-tracepoint-fix
+++ a/mm/page_alloc.c
@@ -2862,20 +2862,20 @@ __rmqueue(struct zone *zone, unsigned in
 {
 	struct page *page;
 
-#ifdef CONFIG_CMA
-	/*
-	 * Balance movable allocations between regular and CMA areas by
-	 * allocating from CMA when over half of the zone's free memory
-	 * is in the CMA area.
-	 */
-	if (alloc_flags & ALLOC_CMA &&
-	    zone_page_state(zone, NR_FREE_CMA_PAGES) >
-	    zone_page_state(zone, NR_FREE_PAGES) / 2) {
-		page = __rmqueue_cma_fallback(zone, order);
-		if (page)
-			goto out;
+	if (IS_ENABLED(CONFIG_CMA)) {
+		/*
+		 * Balance movable allocations between regular and CMA areas by
+		 * allocating from CMA when over half of the zone's free memory
+		 * is in the CMA area.
+		 */
+		if (alloc_flags & ALLOC_CMA &&
+		    zone_page_state(zone, NR_FREE_CMA_PAGES) >
+		    zone_page_state(zone, NR_FREE_PAGES) / 2) {
+			page = __rmqueue_cma_fallback(zone, order);
+			if (page)
+				goto out;
+		}
 	}
-#endif
 retry:
 	page = __rmqueue_smallest(zone, order, migratetype);
 	if (unlikely(!page)) {
_

