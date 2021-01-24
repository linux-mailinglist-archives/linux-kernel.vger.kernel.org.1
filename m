Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F42301FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 01:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbhAYAAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 19:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbhAXX7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 18:59:06 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799DEC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 15:58:25 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id r4so6487982pls.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 15:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=sxDwfnXEerJ6Ap/Q1ZpbffkeUM8AptFoTvsd0C6Q/kU=;
        b=qNz69BrUzBkJ8ftoRNmFpuzCXZgxSpIzj8E3ktc0PU3k7PPfxCkWPg54CuQKJG3mLW
         yBVe/9sHtGmRt+ibX9VxGFsFZJQ0hnAPrj3FX2ohv02pmr9OsfKLXvmWnBX+GcG476Un
         1UPg4EAqZvU4+vvm6MVXfTs88aqs4wMpQN0539CIHnoigzLaOaKHhz26lWGFZ7bMRtsX
         IZKEsOhBt15yJGELFBh7t7g9MUwfz4dIXgkX3Tz2BMBPU0JUKn0V1Bk19dfsmaNvffU1
         etAFuuSlj2HbzDutByLZSnyHxJKy0b1O30vgtswm7ngQiXuaptsggRFUfBRlXh573FkA
         Wj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=sxDwfnXEerJ6Ap/Q1ZpbffkeUM8AptFoTvsd0C6Q/kU=;
        b=lji+Qegzvf+ItmgONrCuTpU1I/6Pa4DpLQ+68REEV/jBbIfwu19tv/cOTISVHN2ZB9
         tRNYw+z4F7OqExmRCimDPTGpx9C6JGXJKYZXHeo1uQwO2t/Uhk/5GHiDbVOStvVD0u1Q
         HFJVJc2rpjdpqtC2+q/qtukOXreFNgV79F7Ylg4xoEy1FjWl382FqY/bxPQ6kZ2JyZ/f
         0C4IH+izxKLuwKMNHHl9I7Pc+2Oqy6xbHRIHkSVb6sG5SEBWAamf3G9KWj8XGmoOo+Mm
         Bvd7tOIxZGs4oQVHCAptAJ8zYRt5ynTjekZwBN38+3SRT2a3oDbsLolV/ZwddjKKLvV1
         bwVw==
X-Gm-Message-State: AOAM5303L8x1jZqmNj4qVnD4OtWBDMFRYTlYGHyMoR2u/Yqgb7yLPBwm
        YX9jJZdHOYoTOJkuV1NPF5I9gw==
X-Google-Smtp-Source: ABdhPJy+E/G7UOngkUomksN0tFh5EcMppFPn0aGGQmMUEzvwWpJOcQItJIbh74Unizkx3EpltPrVkg==
X-Received: by 2002:a17:902:443:b029:dc:1aa4:28f0 with SMTP id 61-20020a1709020443b02900dc1aa428f0mr8522387ple.4.1611532704849;
        Sun, 24 Jan 2021 15:58:24 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id a188sm15617958pfb.108.2021.01.24.15.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 15:58:23 -0800 (PST)
Date:   Sun, 24 Jan 2021 15:58:23 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Muchun Song <songmuchun@bytedance.com>
cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, willy@infradead.org, osalvador@suse.de,
        mhocko@suse.com, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 02/12] mm: hugetlb: introduce a new config
 HUGETLB_PAGE_FREE_VMEMMAP
In-Reply-To: <20210117151053.24600-3-songmuchun@bytedance.com>
Message-ID: <472a58b9-12cb-3c3-d132-13dbae5174f0@google.com>
References: <20210117151053.24600-1-songmuchun@bytedance.com> <20210117151053.24600-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jan 2021, Muchun Song wrote:

> The HUGETLB_PAGE_FREE_VMEMMAP option is used to enable the freeing
> of unnecessary vmemmap associated with HugeTLB pages. The config
> option is introduced early so that supporting code can be written
> to depend on the option. The initial version of the code only
> provides support for x86-64.
> 
> Like other code which frees vmemmap, this config option depends on
> HAVE_BOOTMEM_INFO_NODE. The routine register_page_bootmem_info() is
> used to register bootmem info. Therefore, make sure
> register_page_bootmem_info is enabled if HUGETLB_PAGE_FREE_VMEMMAP
> is defined.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  arch/x86/mm/init_64.c |  2 +-
>  fs/Kconfig            | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 0a45f062826e..0435bee2e172 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1225,7 +1225,7 @@ static struct kcore_list kcore_vsyscall;
>  
>  static void __init register_page_bootmem_info(void)
>  {
> -#ifdef CONFIG_NUMA
> +#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
>  	int i;
>  
>  	for_each_online_node(i)
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 976e8b9033c4..e7c4c2a79311 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -245,6 +245,24 @@ config HUGETLBFS
>  config HUGETLB_PAGE
>  	def_bool HUGETLBFS
>  
> +config HUGETLB_PAGE_FREE_VMEMMAP
> +	def_bool HUGETLB_PAGE

I'm not sure I understand the rationale for providing this help text if 
this is def_bool depending on CONFIG_HUGETLB_PAGE.  Are you intending that 
this is actually configurable and we want to provide guidance to the admin 
on when to disable it (which it currently doesn't)?  If not, why have the 
help text?

> +	depends on X86_64
> +	depends on SPARSEMEM_VMEMMAP
> +	depends on HAVE_BOOTMEM_INFO_NODE
> +	help
> +	  The option HUGETLB_PAGE_FREE_VMEMMAP allows for the freeing of
> +	  some vmemmap pages associated with pre-allocated HugeTLB pages.
> +	  For example, on X86_64 6 vmemmap pages of size 4KB each can be
> +	  saved for each 2MB HugeTLB page.  4094 vmemmap pages of size 4KB
> +	  each can be saved for each 1GB HugeTLB page.
> +
> +	  When a HugeTLB page is allocated or freed, the vmemmap array
> +	  representing the range associated with the page will need to be
> +	  remapped.  When a page is allocated, vmemmap pages are freed
> +	  after remapping.  When a page is freed, previously discarded
> +	  vmemmap pages must be allocated before remapping.
> +
>  config MEMFD_CREATE
>  	def_bool TMPFS || HUGETLBFS
>  
