Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30ABC304EEC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392041AbhA0B0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:26:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728624AbhAZS1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:27:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95C32207A9;
        Tue, 26 Jan 2021 18:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611685617;
        bh=mS4fwRCoDBpjB2pQf4JgN+vKx0b/jP8+diUiuhUDlNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jqTSVnzkNI1pw4SkMEPZVenKL5EBNeXDXThSaq/NYS00TyHO6RMN9l7n2hF0qgXsB
         MmXqklVicSbsEwdjASSGGsnFIcqGoc3+4wA3oU1eMIm1RbXQnqQrFbkfcNGrzavQBO
         Pg7o3dJEkSvfTwxmmGDd06ceJR8iTDcSRfM0HWj6OIgcnLbC/8Sfh9ObjF6rwaLNg7
         oMpnRoRgBmyzEpy6dFXw2Bqtr9OBQpV0XP9dj8BgfOKZwkyXxPCzjzo35gsu0bVPdg
         tdyfLMe3v4qEsQeNzxZfVKe2k0gb6beRA+0RdyW2iee0MqQI8h3DHNvuDy0nNRtSqc
         8moYTUwV3ciqw==
Date:   Tue, 26 Jan 2021 20:26:48 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-csky@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v1] csky: use free_initmem_default() in free_initmem()
Message-ID: <20210126182648.GR6332@kernel.org>
References: <20210126181420.19223-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126181420.19223-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 07:14:20PM +0100, David Hildenbrand wrote:
> The existing code is essentially
> free_initmem_default()->free_reserved_area() without poisoning.
> 
> Note that existing code missed to update the managed page count of the
> zone.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Not compile tested as documentation on how to get
> 	https://gitlab.com/c-sky/buildroot
> running, especially with a custom kernel, is a bit sparse.

You can pick a cross-compiler from here:

https://mirrors.edge.kernel.org/pub/tools/crosstool/
 
> ---
>  arch/csky/mm/init.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
> index 81e4e5e78f38..894050a8ce09 100644
> --- a/arch/csky/mm/init.c
> +++ b/arch/csky/mm/init.c
> @@ -110,24 +110,9 @@ void __init mem_init(void)
>  	mem_init_print_info(NULL);
>  }
>  
> -extern char __init_begin[], __init_end[];
> -
>  void free_initmem(void)
>  {
> -	unsigned long addr;
> -
> -	addr = (unsigned long) &__init_begin;
> -
> -	while (addr < (unsigned long) &__init_end) {
> -		ClearPageReserved(virt_to_page(addr));
> -		init_page_count(virt_to_page(addr));
> -		free_page(addr);
> -		totalram_pages_inc();
> -		addr += PAGE_SIZE;
> -	}
> -
> -	pr_info("Freeing unused kernel memory: %dk freed\n",
> -	((unsigned int)&__init_end - (unsigned int)&__init_begin) >> 10);
> +	free_initmem_default(-1);
>  }
>  
>  void pgd_init(unsigned long *p)
> -- 
> 2.29.2
> 

-- 
Sincerely yours,
Mike.
