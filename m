Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A64D2731BC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 20:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgIUSRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 14:17:14 -0400
Received: from verein.lst.de ([213.95.11.211]:41460 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgIUSRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 14:17:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 76B4068AFE; Mon, 21 Sep 2020 20:17:08 +0200 (CEST)
Date:   Mon, 21 Sep 2020 20:17:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Nitin Gupta <ngupta@vflare.org>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/6] zsmalloc: switch from alloc_vm_area to get_vm_area
Message-ID: <20200921181708.GA2067@lst.de>
References: <20200918163724.2511-1-hch@lst.de> <20200918163724.2511-2-hch@lst.de> <20200921174256.GA387368@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921174256.GA387368@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 10:42:56AM -0700, Minchan Kim wrote:
> IIRC, the problem was runtime pte popluating needs GFP_KERNEL but
> zs_map_object API runs under non-preemtible section.

Make sense.

> > -	area->vm = alloc_vm_area(PAGE_SIZE * 2, NULL);
> > +	area->vm = get_vm_area(PAGE_SIZE * 2, 0);
> >  	if (!area->vm)
> >  		return -ENOMEM;
> >  	return 0;
> 
> I think it shoud work.
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 05789aa4af12..6a1e4d854593 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2232,7 +2232,7 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
>  	arch_enter_lazy_mmu_mode();
>  
>  	do {
> -		if (create || !pte_none(*pte)) {
> +		if ((create || !pte_none(*pte)) && fn) {
>  			err = fn(pte++, addr, data);
>  			if (err)
>  				break;
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 3e4fe3259612..9ef7daf3d279 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1116,6 +1116,8 @@ static struct zspage *find_get_zspage(struct size_class *class)
>  #ifdef CONFIG_ZSMALLOC_PGTABLE_MAPPING
>  static inline int __zs_cpu_up(struct mapping_area *area)
>  {
> +	int ret;
> +
>  	/*
>  	 * Make sure we don't leak memory if a cpu UP notification
>  	 * and zs_init() race and both call zs_cpu_up() on the same cpu
> @@ -1125,7 +1127,13 @@ static inline int __zs_cpu_up(struct mapping_area *area)
>  	area->vm = get_vm_area(PAGE_SIZE * 2, 0);
>  	if (!area->vm)
>  		return -ENOMEM;
> -	return 0;
> +
> +	/*
> +	 * Populate ptes in advance to avoid pte allocation with GFP_KERNEL
> +	 * in non-preemtible context of zs_map_object.
> +	 */
> +	ret = apply_to_page_range(&init_mm, NULL, PAGE_SIZE * 2, NULL, NULL);
> +	return ret;

I think this needs the addr from the vm area somewhere..

We probaby want to add a trivial helper to prefault an area instead of
the open coded variant.
