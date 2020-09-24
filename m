Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99610277A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIXUPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgIXUPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:15:51 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0738DC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 13:15:51 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id h1so173980qvo.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 13:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7ipyucG0GzWO3rvisH62lF19wBD++6q8C9TtcUdd1Hw=;
        b=fwVD884qBOqwubzCGQTUOQXC4jnyNmlRqOrQIwYG0Z2lspP9ifjyFZNvMeH2yyjBVl
         so2GxIUyOGIp0voLIc2FcJve3XguvMpz+WjyryX+ZE+qc9GuKCk1rq+dk/nM1nh4YVVf
         ecIg8aC5lilOuJMQ5P9gFQ4atyAazl5N3e5NjDlVjrfcg6F051QSoQRsApjbr8KRaSX9
         LoJsA1Q4cygDpadqcyfSM/M3XLwNPf3MITqPNj/GRh67eSBOLIgoeoBSBKyiN9g5isrE
         Mn5qHRjAcHeghMhBsU9yFEU6E8JQsfwWhUS/HnAj80JXeF6hJHnKMRJ+KZPm2mze9CIr
         J5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ipyucG0GzWO3rvisH62lF19wBD++6q8C9TtcUdd1Hw=;
        b=YS0i2Pdfqip/mbWMarXyrdAyqKvmvEkjmbH/lMh8UDxOusJz8lQiMDesP26gd1wNJs
         gjnI9y0WYaL/qXUTWXSzGBEFN9xBmCjlkG1EmeT6vZ/q38EDKGJelAzvtyWEygoB+9rC
         pMJPZEl+XHs8BRuOf3g08tm+d8gZiAeFMhaSaieze+L0UFOHCoCXX1MaDerNUuqFFdFc
         /wBQCviHUo3KwHPxMujzGNpqrRY7Nvrdnc9cpGT39V12f1MNmYcXOiRZwqmH3DmzCzDg
         jrD8OWut8Ata3LLz3mYTnxbCjE7qSD4XlGwM8VrrXJBfxyl5lVWbt8LXXLsMVPnQBsyq
         KDTg==
X-Gm-Message-State: AOAM532B+fqlMsG1JxNRJhpAkGdn+10vLjAineDn+ywiOYe3qH6cB5qA
        PV7/cvoRtgY2QowspNmBe84krA==
X-Google-Smtp-Source: ABdhPJyjL0wFqsYbAkNhauKtTeOJyHzrvF6TSHh4M0M3bZ4vzSvheh0d5uJ/4v92mwJ8+FrDqleJhA==
X-Received: by 2002:ad4:55ce:: with SMTP id bt14mr1066193qvb.2.1600978550253;
        Thu, 24 Sep 2020 13:15:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4d7a])
        by smtp.gmail.com with ESMTPSA id g203sm372916qkb.51.2020.09.24.13.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 13:15:49 -0700 (PDT)
Date:   Thu, 24 Sep 2020 16:14:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v1 4/4] mm: convert page kmemcg type to a page memcg flag
Message-ID: <20200924201417.GE329853@cmpxchg.org>
References: <20200922203700.2879671-1-guro@fb.com>
 <20200922203700.2879671-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922203700.2879671-5-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 01:37:00PM -0700, Roman Gushchin wrote:
> PageKmemcg flag is currently defined as a page type (like buddy,
> offline, table and guard). Semantically it means that the page
> was accounted as a kernel memory by the page allocator and has
> to be uncharged on the release.
> 
> As a side effect of defining the flag as a page type, the accounted
> page can't be mapped to userspace (look at page_has_type() and
> comments above). In particular, this blocks the accounting of
> vmalloc-backed memory used by some bpf maps, because these maps
> do map the memory to userspace.
> 
> One option is to fix it by complicating the access to page->mapcount,
> which provides some free bits for page->page_type.
> 
> But it's way better to move this flag into page->memcg_data flags.
> Indeed, the flag makes no sense without enabled memory cgroups
> and memory cgroup pointer set in particular.
> 
> This commit replaces PageKmemcg() and __SetPageKmemcg() with
> PageMemcgKmem() and SetPageMemcgKmem(). __ClearPageKmemcg()
> can be simple deleted because clear_page_mem_cgroup() already
> does the job.
> 
> As a bonus, on !CONFIG_MEMCG build the PageMemcgKmem() check will
> be compiled out.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

That sounds good to me!

> ---
>  include/linux/memcontrol.h | 58 ++++++++++++++++++++++++++++++++++++--
>  include/linux/page-flags.h | 11 ++------
>  mm/memcontrol.c            | 14 +++------
>  mm/page_alloc.c            |  2 +-
>  4 files changed, 62 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 9a49f1e1c0c7..390db58500d5 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -346,8 +346,14 @@ extern struct mem_cgroup *root_mem_cgroup;
>  enum page_memcg_flags {
>  	/* page->memcg_data is a pointer to an objcgs vector */
>  	PG_MEMCG_OBJ_CGROUPS,
> +	/* page has been accounted as a non-slab kernel page */
> +	PG_MEMCG_KMEM,
> +	/* the next bit after the last actual flag */
> +	PG_MEMCG_LAST_FLAG,

*_NR_FLAGS would be customary.

>  };
>  
> +#define MEMCG_FLAGS_MASK ((1UL << PG_MEMCG_LAST_FLAG) - 1)

Probably best to stick to the same prefix as the enum items.

> + * PageMemcgKmem - check if the page has MemcgKmem flag set
> + * @page: a pointer to the page struct
> + *
> + * Checks if the page has MemcgKmem flag set. The caller must ensure that
> + * the page has an associated memory cgroup. It's not safe to call this function
> + * against some types of pages, e.g. slab pages.
> + */
> +static inline bool PageMemcgKmem(struct page *page)
> +{
> +	VM_BUG_ON_PAGE(test_bit(PG_MEMCG_OBJ_CGROUPS, &page->memcg_data), page);
> +	return test_bit(PG_MEMCG_KMEM, &page->memcg_data);
> +}
> +
> +/*
> + * SetPageMemcgKmem - set the page's MemcgKmem flag
> + * @page: a pointer to the page struct
> + *
> + * Set the page's MemcgKmem flag. The caller must ensure that the page has
> + * an associated memory cgroup. It's not safe to call this function
> + * against some types of pages, e.g. slab pages.
> + */
> +static inline void SetPageMemcgKmem(struct page *page)
> +{
> +	VM_BUG_ON_PAGE(!page->memcg_data, page);
> +	VM_BUG_ON_PAGE(test_bit(PG_MEMCG_OBJ_CGROUPS, &page->memcg_data), page);
> +	__set_bit(PG_MEMCG_KMEM, &page->memcg_data);

It may be good to keep the __ prefix from __SetPageMemcg as long as
this uses __set_bit, in case we later add atomic bit futzing.
