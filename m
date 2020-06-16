Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960701FBE22
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 20:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgFPSgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 14:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbgFPSgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:36:04 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 055CF2082F;
        Tue, 16 Jun 2020 18:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592332564;
        bh=ygQw5Actl08lZMVXKCgVgtsSty25n+2zY0/omqxOYLQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tj/iyfELOQfWQKfZYRlE+bdGM9rpxcBcCT5k+18bsKLbIcMYvt0geXm/Y2GCZ6gHl
         /pcjFwHd0tgR6+tSlfAbCRQaMGOS5Bx3jJ7ihplGFAa4kLKlCutasfZAl2vU8IGyja
         VnyuM91jARusgdgYCClFkpGRHOjtZdG+lshXmLVo=
Date:   Tue, 16 Jun 2020 11:36:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     js1304@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH for v5.8 2/3] mm/swap: fix for
 "mm: workingset: age nonresident information alongside anonymous pages"
Message-Id: <20200616113601.a8ab80635b6434efe43d2ffc@linux-foundation.org>
In-Reply-To: <1592288204-27734-3-git-send-email-iamjoonsoo.kim@lge.com>
References: <1592288204-27734-1-git-send-email-iamjoonsoo.kim@lge.com>
        <1592288204-27734-3-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 15:16:43 +0900 js1304@gmail.com wrote:

> Subject: [PATCH for v5.8 2/3] mm/swap: fix for "mm: workingset: age nonresident information alongside anonymous pages"

I'm having trouble locating such a patch.

> Non-file-lru page could also be activated in mark_page_accessed()
> and we need to count this activation for nonresident_age.
> 
> Note that it's better for this patch to be squashed into the patch
> "mm: workingset: age nonresident information alongside anonymous pages".
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  mm/swap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 667133d..c5d5114 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -443,8 +443,7 @@ void mark_page_accessed(struct page *page)
>  		else
>  			__lru_cache_activate_page(page);
>  		ClearPageReferenced(page);
> -		if (page_is_file_lru(page))
> -			workingset_activation(page);
> +		workingset_activation(page);
>  	}
>  	if (page_is_idle(page))
>  		clear_page_idle(page);

AFAICT this patch Fixes: a528910e12ec7ee ("mm: thrash detection-based file
cache sizing")?

