Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7907B2F5D32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbhANJWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:22:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbhANJWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610616069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+P+ymbxz56cW25ly8svSOtyorypFtEzsoTghRSRpI0=;
        b=G38lD5Na6cWyhhzEwkKiCuY53iWNwMehrJWPrlJ+rbphb7UeG2pWkfw6ZKLnYl+V8nSwWh
        2Uuapc8GGOVSRrVpEr9ruv6IU50gY1AWtv5NS3AtqHgF3MKSHMP8AFbytUGcZbz7ApmqRc
        vxJRcC2BdjTT6PAeOxm3javZp8x8E+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-lYMpLajHM1uB9BTga1zBXQ-1; Thu, 14 Jan 2021 04:21:08 -0500
X-MC-Unique: lYMpLajHM1uB9BTga1zBXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BC0F1015C80;
        Thu, 14 Jan 2021 09:21:06 +0000 (UTC)
Received: from [10.36.115.75] (ovpn-115-75.ams2.redhat.com [10.36.115.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1067860C47;
        Thu, 14 Jan 2021 09:21:04 +0000 (UTC)
Subject: Re: [PATCH] mm: memblock: remove return value of memblock_free_all()
To:     Daeseok Youn <daeseok.youn@gmail.com>, rppt@kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20210114070817.GA2868715@AD01715016>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <726525ab-d30d-e58c-21ea-db9d6ad4ae6b@redhat.com>
Date:   Thu, 14 Jan 2021 10:21:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210114070817.GA2868715@AD01715016>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.01.21 08:08, Daeseok Youn wrote:
> No one checks the return value of memblock_free_all().
> Make the return value void.
> 
> memblock_free_all() is used on mem_init() for each
> architecture, and the total count of freed pages will be added
> to _totalram_pages variable by calling totalram_pages_add().
> 
> so do not need to return total count of freed pages.
> 
> Signed-off-by: Daeseok Youn <daeseok.youn@gmail.com>
> ---
>  include/linux/memblock.h | 2 +-
>  mm/memblock.c            | 6 +-----
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 9c5cc95c7cee..076fda398dff 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -117,7 +117,7 @@ int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
>  int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
>  
> -unsigned long memblock_free_all(void);
> +void memblock_free_all(void);
>  void reset_node_managed_pages(pg_data_t *pgdat);
>  void reset_all_zones_managed_pages(void);
>  void memblock_enforce_memory_reserved_overlap(void);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 40ca30bfa387..2a2b1fe4b659 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2074,10 +2074,8 @@ void __init reset_all_zones_managed_pages(void)
>  
>  /**
>   * memblock_free_all - release free pages to the buddy allocator
> - *
> - * Return: the number of pages actually released.
>   */
> -unsigned long __init memblock_free_all(void)
> +void __init memblock_free_all(void)
>  {
>  	unsigned long pages;
>  
> @@ -2086,8 +2084,6 @@ unsigned long __init memblock_free_all(void)
>  
>  	pages = free_low_memory_core_early();
>  	totalram_pages_add(pages);
> -
> -	return pages;
>  }
>  
>  #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

