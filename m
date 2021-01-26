Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC1F303BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405401AbhAZLpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:45:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392200AbhAZLZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611660217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CiONnZ1ymNvkzwHvQA22Owl9Y/QjdZQ6wIbCWQAKdh8=;
        b=EZ+/GJ/4qvfv/mYT+71kfn4at5pi3pICr6NRKsY7qvjleHGv19IcUkfXHQyxDeHtPMr6zE
        5VYRvNwX/aSKatUOqmwwRNdeKcD3LLECNQZ/h5AwBmkXsmV10sCArXBk16wpbmCsYY71ZH
        ozaJEnu9I9kKiHuQiM8m0ly1ymKiI2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-ynpxj2G4NXunwoVC9Wy3RQ-1; Tue, 26 Jan 2021 06:23:35 -0500
X-MC-Unique: ynpxj2G4NXunwoVC9Wy3RQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA6E6802B42;
        Tue, 26 Jan 2021 11:23:33 +0000 (UTC)
Received: from [10.36.114.192] (ovpn-114-192.ams2.redhat.com [10.36.114.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA229100239F;
        Tue, 26 Jan 2021 11:23:32 +0000 (UTC)
Subject: Re: [PATCH] mm/page_owner: Use helper function zone_end_pfn() to get
 end_pfn
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210123070538.5861-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <25c538a0-8d10-7c2c-6562-52a91ac158a6@redhat.com>
Date:   Tue, 26 Jan 2021 12:23:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210123070538.5861-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.01.21 08:05, Miaohe Lin wrote:
> Commit 108bcc96ef70 ("mm: add & use zone_end_pfn() and zone_spans_pfn()")
> introduced the helper zone_end_pfn() to calculate the zone end pfn. But
> pagetypeinfo_showmixedcount_print forgot to use it. And the initialization
> of local variable pfn is duplicated, remove one.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_owner.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index af464bb7fbe7..d15c7c4994f5 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -263,8 +263,8 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>   	struct page *page;
>   	struct page_ext *page_ext;
>   	struct page_owner *page_owner;
> -	unsigned long pfn = zone->zone_start_pfn, block_end_pfn;
> -	unsigned long end_pfn = pfn + zone->spanned_pages;
> +	unsigned long pfn, block_end_pfn;
> +	unsigned long end_pfn = zone_end_pfn(zone);
>   	unsigned long count[MIGRATE_TYPES] = { 0, };
>   	int pageblock_mt, page_mt;
>   	int i;
> 

Looks a little weird that we initialize "end_pfn" directly and "pfn" 
not. I'd make this consistent.

Anyhow

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

