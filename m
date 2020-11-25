Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472652C4524
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbgKYQ0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:26:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:56050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731326AbgKYQ0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:26:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F105BABCE;
        Wed, 25 Nov 2020 16:26:48 +0000 (UTC)
Subject: Re: [PATCH v5 1/4] mm,hwpoison: drain pcplists before bailing out for
 non-buddy zero-refcount page
To:     Oscar Salvador <osalvador@suse.de>, n-horiguchi@ah.jp.nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
References: <20201013144447.6706-1-osalvador@suse.de>
 <20201013144447.6706-2-osalvador@suse.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1673f0cd-c943-c211-4707-410c5f018aab@suse.cz>
Date:   Wed, 25 Nov 2020 17:26:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201013144447.6706-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/20 4:44 PM, Oscar Salvador wrote:
> A page with 0-refcount and !PageBuddy could perfectly be a pcppage.
> Currently, we bail out with an error if we encounter such a page, meaning
> that we do not handle pcppages neither from hard-offline nor from
> soft-offline path.
> 
> Fix this by draining pcplists whenever we find this kind of page and retry
> the check again.  It might be that pcplists have been spilled into the
> buddy allocator and so we can handle it.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>   mm/memory-failure.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index c0bb186bba62..e2f12410c594 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -946,13 +946,13 @@ static int page_action(struct page_state *ps, struct page *p,
>   }
>   
>   /**
> - * get_hwpoison_page() - Get refcount for memory error handling:
> + * __get_hwpoison_page() - Get refcount for memory error handling:
>    * @page:	raw error page (hit by memory error)
>    *
>    * Return: return 0 if failed to grab the refcount, otherwise true (some
>    * non-zero value.)
>    */
> -static int get_hwpoison_page(struct page *page)
> +static int __get_hwpoison_page(struct page *page)
>   {
>   	struct page *head = compound_head(page);
>   
> @@ -982,6 +982,26 @@ static int get_hwpoison_page(struct page *page)
>   	return 0;
>   }
>   
> +static int get_hwpoison_page(struct page *p)
> +{
> +	int ret;
> +	bool drained = false;
> +
> +retry:
> +	ret = __get_hwpoison_page(p);
> +	if (!ret && !is_free_buddy_page(p) && !page_count(p) && !drained) {
> +		/*
> +		 * The page might be in a pcplist, so try to drain those
> +		 * and see if we are lucky.
> +		 */
> +		drain_all_pages(page_zone(p));
> +		drained = true;
> +		goto retry;
> +	}
> +
> +	return ret;
> +}
> +
>   /*
>    * Do all that is necessary to remove user space mappings. Unmap
>    * the pages and send SIGBUS to the processes if the data was dirty.
> 

