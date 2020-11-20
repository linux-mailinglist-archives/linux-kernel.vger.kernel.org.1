Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F42D2BB9C3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 00:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgKTXNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 18:13:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbgKTXNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:13:10 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A46182240B;
        Fri, 20 Nov 2020 23:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1605913989;
        bh=kGZ3tY895qvwswmX8ewkKR4DXUjrQEmGUbS1BBPrqao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XwzkJGGVKL7FuVt1qEFS7X+RiwM4EE3PuWURqNAeDOPoiHV6zVUJh9Jl9k3+FUX4z
         rXZAAZQxHYcyfX4+/8AZtT294HTEP5Zkxew1QheWaJLhx+xkCwD4T3xE/4FXWbzie3
         RAX3/B7W0MAt35ANy8G7CB1OzKeOr75KHDQblY5Q=
Date:   Fri, 20 Nov 2020 15:13:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] mm/vmscan: __isolate_lru_page_prepare clean up
Message-Id: <20201120151307.4d9e3ef092ba01a325db7ce2@linux-foundation.org>
In-Reply-To: <1605859413-53864-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1605859413-53864-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 16:03:33 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:

> The function just return 2 results, so use a 'switch' to deal with its
> result is unnecessary, and simplify it to a bool func as Vlastimil
> suggested.
> 
> Also removed 'goto' in using by reusing list_move().
> 
> ...
>
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1540,7 +1540,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>   */
>  int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode)
>  {
> -	int ret = -EBUSY;
> +	int ret = false;
>  
>  	/* Only take pages on the LRU. */
>  	if (!PageLRU(page))
> @@ -1590,7 +1590,7 @@ int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode)
>  	if ((mode & ISOLATE_UNMAPPED) && page_mapped(page))
>  		return ret;
>  
> -	return 0;
> +	return true;
>  }

The resulting __isolate_lru_page_prepare() is rather unpleasing.

- Why return an int and not a bool?

- `int ret = false' is a big hint that `ret' should have bool type!

- Why not just remove `ret' and do `return false' in all those `return
  ret' places?

- The __isolate_lru_page_prepare() kerneldoc still says "returns 0 on
  success, -ve errno on failure".  
