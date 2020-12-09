Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BBD2D3F66
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgLIJ7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:59:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20015 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729299AbgLIJ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607507869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dke/0tBf78HdlvQE9wUM0dJ9CCsXJgYBnBHm6bEO7Xo=;
        b=Dzxbc2KA8oyKRMg+cr08CPrbsaHEiLIKYtekOTm/liFvGP93LLiiIfhTOQh8KsD9R8AWO3
        AHl1WA1YnZ5gKMZceZl93oEnxM4CWe7QPspbWdBjAXaQ+KI6q4X4/5LW6XisY/aqEsmj90
        T+RZmc3M0KpxAtD0+N27SQ6c9F8VF2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-GMhEVBD9MRCd8njopXx6ag-1; Wed, 09 Dec 2020 04:57:45 -0500
X-MC-Unique: GMhEVBD9MRCd8njopXx6ag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D24066D525;
        Wed,  9 Dec 2020 09:57:40 +0000 (UTC)
Received: from [10.36.114.167] (ovpn-114-167.ams2.redhat.com [10.36.114.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68CD96064B;
        Wed,  9 Dec 2020 09:57:34 +0000 (UTC)
Subject: Re: [PATCH v7 06/15] mm/hugetlb: Disable freeing vmemmap if struct
 page size is not power of two
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-7-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ba57ea7d-709b-bf36-d48a-cc72a26012cc@redhat.com>
Date:   Wed, 9 Dec 2020 10:57:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130151838.11208-7-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.11.20 16:18, Muchun Song wrote:
> We only can free the tail vmemmap pages of HugeTLB to the buddy allocator
> when the size of struct page is a power of two.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb_vmemmap.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 51152e258f39..ad8fc61ea273 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -111,6 +111,11 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  	unsigned int nr_pages = pages_per_huge_page(h);
>  	unsigned int vmemmap_pages;
>  
> +	if (!is_power_of_2(sizeof(struct page))) {
> +		pr_info("disable freeing vmemmap pages for %s\n", h->name);

I'd just drop that pr_info(). Users are able to observe that it's
working (below), so they are able to identify that it's not working as well.

> +		return;
> +	}
> +
>  	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
>  	/*
>  	 * The head page and the first tail page are not to be freed to buddy
> 

Please squash this patch into the enabling patch and add a comment
instead, like

/* We cannot optimize if a "struct page" crosses page boundaries. */

-- 
Thanks,

David / dhildenb

