Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A452D3F78
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgLIKD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:03:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:44978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbgLIKD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:03:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46372AB63;
        Wed,  9 Dec 2020 10:02:45 +0000 (UTC)
Date:   Wed, 9 Dec 2020 11:02:43 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH v3 4/4] mm,memory_hotplug: Add mhp_memmap_on_memory
 boot option
Message-ID: <20201209100239.GB30892@linux>
References: <20201201115158.22638-1-osalvador@suse.de>
 <20201201115158.22638-5-osalvador@suse.de>
 <1cb78e59-d97c-f252-7d1b-e8e9bad38ddd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cb78e59-d97c-f252-7d1b-e8e9bad38ddd@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:42:18AM +0100, David Hildenbrand wrote:
> I have another memhp tunable in the works. I suggest doing it like
> page_shuffling and using, module parameters instead. Makes this
> a bit nicer IMHO.

Does that have any impact?

> diff --git a/mm/Makefile b/mm/Makefile
> index 069f216e109e..ba7714b5eaa1 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -58,9 +58,13 @@ obj-y                        := filemap.o mempool.o oom_kill.o fadvise.o \
>  page-alloc-y := page_alloc.o
>  page-alloc-$(CONFIG_SHUFFLE_PAGE_ALLOCATOR) += shuffle.o
>  
> +# Give "memory_hotplug" its own module-parameter namespace
> +memory-hotplug-$(CONFIG_MEMORY_HOTPLUG) := memory_hotplug.o
> +
>  obj-y += page-alloc.o
>  obj-y += init-mm.o
>  obj-y += memblock.o
> +obj-y += $(memory-hotplug-y)
>  
>  ifdef CONFIG_MMU
>         obj-$(CONFIG_ADVISE_SYSCALLS)   += madvise.o
> @@ -82,7 +86,6 @@ obj-$(CONFIG_SLAB) += slab.o
>  obj-$(CONFIG_SLUB) += slub.o
>  obj-$(CONFIG_KASAN)    += kasan/
>  obj-$(CONFIG_FAILSLAB) += failslab.o
> -obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
>  obj-$(CONFIG_MEMTEST)          += memtest.o
>  obj-$(CONFIG_MIGRATION) += migrate.o
>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
> 
> 
> The you can just use module_param/MODULE_PARM_DESC and set the parameter via
> 
> "memory_hotplug.memmap_on_memory"

I have to confess that I was not aware of this trick, but looks cleaner
overall.

Thanks

-- 
Oscar Salvador
SUSE L3
