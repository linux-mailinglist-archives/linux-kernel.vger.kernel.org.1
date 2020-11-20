Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8966B2BA8DF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 12:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgKTLUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 06:20:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbgKTLUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605871249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKwAu+XEOCz7UxJN4BnE5R5dnSbfpVt9dFCuipC0YN0=;
        b=MCRMipB8feCbol7sIsIDRQdT9EXdqwOXq+RR9pcZa8hvifJMhPwwpQSm7x38X0ojnDC7mk
        4UBBRnE/S9x3FMTGOauefLCTxmLaudgBIhaHXarmTbq5oOYEqgErzov+ospkrw9RJVakAC
        h9KXHCYCOG+gcLNUc5sag463iSeE1+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-8LmH0Vc5NfCbve36If9TOg-1; Fri, 20 Nov 2020 06:20:47 -0500
X-MC-Unique: 8LmH0Vc5NfCbve36If9TOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7ECB8042AC;
        Fri, 20 Nov 2020 11:20:45 +0000 (UTC)
Received: from [10.36.114.78] (ovpn-114-78.ams2.redhat.com [10.36.114.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B36719D9F;
        Fri, 20 Nov 2020 11:20:44 +0000 (UTC)
Subject: Re: [RFC PATCH 2/3] mm: Introduce a new Vmemmap page-type
To:     Oscar Salvador <osalvador@suse.de>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
References: <20201022125835.26396-1-osalvador@suse.de>
 <20201022125835.26396-3-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6fca9846-f1ad-86bd-e37c-5fbddf2871ff@redhat.com>
Date:   Fri, 20 Nov 2020 12:20:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201022125835.26396-3-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.20 14:58, Oscar Salvador wrote:
> This patch introduces a new Vmemmap page-type so we can better
> picture and handle those kind of pages.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   include/linux/mm.h         | 6 ++++++
>   include/linux/mm_types.h   | 5 +++++
>   include/linux/page-flags.h | 6 ++++++
>   3 files changed, 17 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ef360fe70aaf..48845f054136 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3126,6 +3126,12 @@ static inline bool debug_guardpage_enabled(void) { return false; }
>   static inline bool page_is_guard(struct page *page) { return false; }
>   #endif /* CONFIG_DEBUG_PAGEALLOC */
>   
> +static __always_inline unsigned long vmemmap_nr_pages(struct page *page)
> +{
> +	struct page *head = (struct page *)page->vmemmap_head;
> +	return head->vmemmap_pages - (page - head);
> +}
> +
>   #if MAX_NUMNODES > 1
>   void __init setup_nr_node_ids(void);
>   #else
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index ae891c0c55fc..0bb8de4262c3 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -171,6 +171,11 @@ struct page {
>   			 * pmem backed DAX files are mapped.
>   			 */
>   		};
> +		struct {	/* Vmemmap pages */
> +			unsigned long vmemmap_head;
> +			unsigned long vmemmap_sections; /* Number of sections */
> +			unsigned long vmemmap_pages;    /* Number of pages */
> +		};
>   
>   		/** @rcu_head: You can use this to free a page by RCU. */
>   		struct rcu_head rcu_head;
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 4f6ba9379112..2bad207515fa 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -718,6 +718,7 @@ PAGEFLAG_FALSE(DoubleMap)
>   #define PG_kmemcg	0x00000200
>   #define PG_table	0x00000400
>   #define PG_guard	0x00000800
> +#define PG_vmemmap     0x00001000
>   
>   #define PageType(page, flag)						\
>   	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
> @@ -784,6 +785,11 @@ PAGE_TYPE_OPS(Table, table)
>    */
>   PAGE_TYPE_OPS(Guard, guard)
>   
> +/*
> + * Vmemmap pages (see include/linux/memory_hotplug.h).
> + */
> +PAGE_TYPE_OPS(Vmemmap, vmemmap)
> +
>   extern bool is_free_buddy_page(struct page *page);
>   
>   __PAGEFLAG(Isolated, isolated, PF_ANY);
> 

I guess this will no longer be strictly necessary to get it flying :)

-- 
Thanks,

David / dhildenb

