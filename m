Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559FA279CDD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 01:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgIZXXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 19:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgIZXXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 19:23:37 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACC3C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 16:23:37 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c62so6908088qke.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 16:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=46pLbyDUIVzrtCUd00uL7JQr/+F1QduwQUALA4UUE/E=;
        b=XyfERvLOvX6a8NiOwN9fv/gxV5g1EbSZCF4mUgvT3KqVgcsyA0j7sSuFM2iGv9WDAt
         1NbuHxGdXN5SPFZeySZkPRMofxadocN0roPRKXo6QxyHk9KrdYyYVCFn9jC2vc7HcB7g
         xEJHWiEs/rSuOsQSRLUAQqMxQ7TnAmO3jAoR+rFvTiYmCXH5B2DUSd+yaZTiHnjHC8tz
         vBZoy0jeIojJGKtfZZKWeDXFHRYTODXIRFhi80gOoTyrfNlE8WXGxIiiQ8z1eTNfJz6j
         czLXbw4qSZFnQUQcYAkD1vEPSeEoodG63O2P1cKhpqTYutHdJ4hXBH2A3FD2bxATW+ii
         +fUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=46pLbyDUIVzrtCUd00uL7JQr/+F1QduwQUALA4UUE/E=;
        b=rDYPtk0JDoXJxEOtATJWzsh3HlmILdiwYoQ/9NZk89NxUcPJK67Yxr2vtgfeMj50j5
         zdX9rasMM45cEW9270VIrVokKh15xIbyfDZJQf3D+ZzXwahGA1JwzPIdxb5Z70VxHrby
         D3hgafwW27eyqTs/jQRTs1i29WoyXhvcgAfYsFAgzUJuPITv/IWfW7kZVgr43zxqpQQk
         5vGZI6FUKPJeYR+fx6fryKvP2F2cvkLFUJ0lYHdN1leTYZCJRlPbkOnfkOwvV0wgSXSY
         3564rRRrLusvF3rw/WXd7+ZH+mfE4kkwodpMMi9sEuZP3AXvBoJi7Zy4uv2VLm/QXUNT
         vNnw==
X-Gm-Message-State: AOAM532N1P/Ut5FZdfE451rKHahjK2tuWBfbvz6zxfNlhOdtJRqOvp3n
        d3hfV2d6ol/H5Z5Ey3hBxUA72w==
X-Google-Smtp-Source: ABdhPJzF99Bsln79Ikqogy6kzhoM2ErOtsE28Fqt0/2a1Mzm2Os1/ix4Zsa4AbqviwzCexvEmgq5Yg==
X-Received: by 2002:a05:620a:134e:: with SMTP id c14mr6447782qkl.223.1601162616849;
        Sat, 26 Sep 2020 16:23:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o2sm4977837qkk.42.2020.09.26.16.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 16:23:35 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kMJXT-001Tdk-C5; Sat, 26 Sep 2020 20:23:35 -0300
Date:   Sat, 26 Sep 2020 20:23:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v2 3/4] mm: Do early cow for pinned pages during fork()
 for ptes
Message-ID: <20200926232335.GA348793@ziepe.ca>
References: <20200925222600.6832-1-peterx@redhat.com>
 <20200925222600.6832-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925222600.6832-4-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 06:25:59PM -0400, Peter Xu wrote:
> -static inline void
> +/*
> + * Copy one pte.  Returns 0 if succeeded, or -EAGAIN if one preallocated page
> + * is required to copy this pte.
> + */
> +static inline int
>  copy_present_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
> -		unsigned long addr, int *rss)
> +		struct vm_area_struct *new,
> +		unsigned long addr, int *rss, struct page **prealloc)
>  {
>  	unsigned long vm_flags = vma->vm_flags;
>  	pte_t pte = *src_pte;
>  	struct page *page;
>  
> +	page = vm_normal_page(vma, addr, pte);
> +	if (page) {
> +		if (is_cow_mapping(vm_flags)) {
> +			bool is_write = pte_write(pte);

Very minor, but I liked the readability to put this chunk in a
function 'copy_normal_page' with the src/dst naming

> +
> +				/*
> +				 * We have a prealloc page, all good!  Take it
> +				 * over and copy the page & arm it.
> +				 */
> +				*prealloc = NULL;
> +				copy_user_highpage(new_page, page, addr, vma);
> +				__SetPageUptodate(new_page);
> +				pte = mk_pte(new_page, new->vm_page_prot);
> +				pte = pte_sw_mkyoung(pte);

Linus's version doesn't do pte_sw_mkyoung(), but looks OK to have it

> +				pte = maybe_mkwrite(pte_mkdirty(pte), new);

maybe_mkwrite() was not in Linus's version, but is in
wp_page_copy(). It seemed like mk_pte() should set the proper write
bit already from the vm_page_prot? Perhaps this is harmless but
redundant?

> +				page_add_new_anon_rmap(new_page, new, addr, false);
> +				rss[mm_counter(new_page)]++;
> +				set_pte_at(dst_mm, addr, dst_pte, pte);

Linus's patch had a lru_cache_add_inactive_or_unevictable() here, like
wp_page_copy()

Didn't think of anything profound to say, looks good thanks!

I'll forward this for testing as well, there are some holidays next
week so I may have been optimistic to think by Monday.

Jason
