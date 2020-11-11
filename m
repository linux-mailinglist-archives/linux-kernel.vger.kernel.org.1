Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777832AED95
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgKKJZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:25:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbgKKJZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605086736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9nebzx0UsAYWD+0ntymddjWRLEVpWpS1bO8dXrXH6n4=;
        b=g6OobdUoLHFP9Hq+21nS+LOw+yxDT3vS3MT3MrGaoHj/ulGTlpqyqMvPLpFJ7qgaZpL+UD
        s504/Owre/GF6DE2Pd7+zAudq2fsD3FDFWvV/izSj5t+Fujq/0UD70nIJCS5j54H5WJpWs
        iTVE30yBXq0iT0NeP3O/e9nL7Bv+NMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-FDXqpnHGNXqJDzJFikjeLA-1; Wed, 11 Nov 2020 04:25:32 -0500
X-MC-Unique: FDXqpnHGNXqJDzJFikjeLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C89DF188C127;
        Wed, 11 Nov 2020 09:25:29 +0000 (UTC)
Received: from [10.36.114.151] (ovpn-114-151.ams2.redhat.com [10.36.114.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DF15413C;
        Wed, 11 Nov 2020 09:25:27 +0000 (UTC)
Subject: Re: [PATCH v1] mm/page_alloc: clear pages in alloc_contig_pages()
 with init_on_alloc=1 or __GFP_ZERO
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20201110193240.25401-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <75483ee9-f030-74ac-4b4f-732fb512280b@redhat.com>
Date:   Wed, 11 Nov 2020 10:25:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201110193240.25401-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.11.20 20:32, David Hildenbrand wrote:
> commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and
> init_on_free=1 boot options") resulted with init_on_alloc=1 in all pages
> leaving the buddy via alloc_pages() and friends to be
> initialized/cleared/zeroed on allocation.
> 
> However, the same logic is currently not applied to
> alloc_contig_pages(): allocated pages leaving the buddy aren't cleared
> with init_on_alloc=1 and init_on_free=0. Let's also properly clear
> pages on that allocation path and add support for __GFP_ZERO.
> 
> With this change, we will see double clearing of pages in some
> cases. One example are gigantic pages (either allocated via CMA, or
> allocated dynamically via alloc_contig_pages()) - which is the right
> thing to do (and to be optimized outside of the buddy in the callers) as
> discussed in:
>    https://lkml.kernel.org/r/20201019182853.7467-1-gpiccoli@canonical.com
> 
> This change implies that with init_on_alloc=1
> - All CMA allocations will be cleared
> - Gigantic pages allocated via alloc_contig_pages() will be cleared
> - virtio-mem memory to be unplugged will be cleared. While this is
>    suboptimal, it's similar to memory balloon drivers handling, where
>    all pages to be inflated will get cleared as well.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/page_alloc.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index eed4f4075b3c..0361b119b74e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8453,6 +8453,19 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>   	return 0;
>   }
>   
> +static void __alloc_contig_clear_range(unsigned long start_pfn,
> +				       unsigned long end_pfn)
> +{
> +	unsigned long pfn;
> +
> +	for (pfn = start_pfn; pfn < end_pfn; pfn += MAX_ORDER_NR_PAGES) {
> +		cond_resched();
> +		kernel_init_free_pages(pfn_to_page(pfn),
> +				       min_t(unsigned long, end_pfn - pfn,
> +					     MAX_ORDER_NR_PAGES));

In weird cases, we might cross a MAX_ORDER - 1 block here. I'll fix that.

-- 
Thanks,

David / dhildenb

