Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6252F6117
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbhANMeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:34:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbhANMeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610627569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AUvS6QLhZFtiHHV/tUY8oq4VOM2EUrkQe6b8GdqyVoo=;
        b=WE0atKToM3iZkjRKXjECqpqDpoZRdRjbnfNwlLMvh9wgWmoPK/JHTwl9F+QJa0VniuE3P7
        oekMDJ/FC8lWsK/E6BASqeHWQCB0mgjY3ftqZDvI9ABkR2CCNsHEg30FZXxg83BAi2Kc9b
        pU47nBRG/O4KS6ljfNLTsBBMXN5rIqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-DVNIQXRjMUGXXVZIAgBKng-1; Thu, 14 Jan 2021 07:32:48 -0500
X-MC-Unique: DVNIQXRjMUGXXVZIAgBKng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00A901005D4C;
        Thu, 14 Jan 2021 12:32:47 +0000 (UTC)
Received: from [10.36.115.75] (ovpn-115-75.ams2.redhat.com [10.36.115.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A75685D6AD;
        Thu, 14 Jan 2021 12:32:45 +0000 (UTC)
Subject: Re: [PATCH] mm/hugetlb: Use helper huge_page_order and
 pages_per_huge_page
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210114114435.40075-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4cf8a293-7154-8cb7-3e39-3d138137e291@redhat.com>
Date:   Thu, 14 Jan 2021 13:32:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210114114435.40075-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.01.21 12:44, Miaohe Lin wrote:
> Since commit a5516438959d ("hugetlb: modular state for hugetlb page size"),
> we can use huge_page_order to access hstate->order and pages_per_huge_page
> to fetch the pages per huge page. But gather_bootmem_prealloc() forgot to
> use it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index fe2da9ad6233..c04d922757c7 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2476,7 +2476,7 @@ static void __init gather_bootmem_prealloc(void)
>  		struct hstate *h = m->hstate;
>  
>  		WARN_ON(page_count(page) != 1);
> -		prep_compound_huge_page(page, h->order);
> +		prep_compound_huge_page(page, huge_page_order(h));
>  		WARN_ON(PageReserved(page));
>  		prep_new_huge_page(h, page, page_to_nid(page));
>  		put_page(page); /* free it into the hugepage allocator */
> @@ -2488,7 +2488,7 @@ static void __init gather_bootmem_prealloc(void)
>  		 * side-effects, like CommitLimit going negative.
>  		 */
>  		if (hstate_is_gigantic(h))
> -			adjust_managed_page_count(page, 1 << h->order);
> +			adjust_managed_page_count(page, pages_per_huge_page(h));
>  		cond_resched();
>  	}
>  }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

