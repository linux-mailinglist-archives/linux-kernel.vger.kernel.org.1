Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231F42FFEDB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbhAVI6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:58:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726457AbhAVImR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611304850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fR4+Y/K1NZ6ZXqSP7ZK85d8CP4lP2v3t6pePNBxYMes=;
        b=DxP42Sd2ek7XjvfNkS8h+gqYioAIkmowEUdl+l2HuedlnIuU+Swhth0BP3/xSQVY1CIwGM
        kJnpsV0fNVsrmWb5CSuP7g+fy3O68PsDpHI3EnE7hqP+1aymTda/b8ZPTW4qclgOx+tRhr
        04gPWQSbZzRwyKXwLOpHllFe89MYkSo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-xINvuI8sMKCJaWJU0LJgig-1; Fri, 22 Jan 2021 03:40:47 -0500
X-MC-Unique: xINvuI8sMKCJaWJU0LJgig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBCC091139;
        Fri, 22 Jan 2021 08:40:46 +0000 (UTC)
Received: from [10.36.114.142] (ovpn-114-142.ams2.redhat.com [10.36.114.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82D9A19486;
        Fri, 22 Jan 2021 08:40:45 +0000 (UTC)
Subject: Re: [PATCH] mm: fix prototype warning from kernel test robot
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org
References: <20210122070359.24010-1-bhe@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3fd62f11-bf44-3ede-aed1-10d9d4849f00@redhat.com>
Date:   Fri, 22 Jan 2021 09:40:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210122070359.24010-1-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.01.21 08:03, Baoquan He wrote:
> Kernel test robot calling make with 'W=1' triggering warning like below
> below for memmap_init_zone() function.
> 
> mm/page_alloc.c:6259:23: warning: no previous prototype for 'memmap_init_zone' [-Wmissing-prototypes]
>  6259 | void __meminit __weak memmap_init_zone(unsigned long size, int nid,
>       |                       ^~~~~~~~~~~~~~~~
> 
> Fix it by adding the function declaration in include/linux/mm.h.
> Since memmap_init_zone() has a generic version with '__weak',
> the declaratoin in ia64 header file can be simply removed.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  arch/ia64/include/asm/pgtable.h | 5 -----
>  include/linux/mm.h              | 1 +
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
> index 2c81394a2430..9b4efe89e62d 100644
> --- a/arch/ia64/include/asm/pgtable.h
> +++ b/arch/ia64/include/asm/pgtable.h
> @@ -517,11 +517,6 @@ extern struct page *zero_page_memmap_ptr;
>  	__changed;							\
>  })
>  #endif
> -
> -#  ifdef CONFIG_VIRTUAL_MEM_MAP
> -  /* arch mem_map init routine is needed due to holes in a virtual mem_map */
> -    extern void memmap_init_zone(struct zone *zone);
> -#  endif /* CONFIG_VIRTUAL_MEM_MAP */
>  # endif /* !__ASSEMBLY__ */
>  
>  /*
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 56bb239f9150..073049bd0b29 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2401,6 +2401,7 @@ extern void set_dma_reserve(unsigned long new_dma_reserve);
>  extern void memmap_init_range(unsigned long, int, unsigned long,
>  		unsigned long, unsigned long, enum meminit_context,
>  		struct vmem_altmap *, int migratetype);
> +extern void memmap_init_zone(struct zone *zone);
>  extern void setup_per_zone_wmarks(void);
>  extern int __meminit init_per_zone_wmark_min(void);
>  extern void mem_init(void);
> 

This patch is on top of your other series, no?

In -next, we have

extern void memmap_init_zone(unsigned long, int, unsigned long, ...

In that file, so something is wrong.

-- 
Thanks,

David / dhildenb

