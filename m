Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EED29275B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 14:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgJSMbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 08:31:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:60730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgJSMbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 08:31:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603110698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yxT0LHLLj1NGW+HpQy+scieHUSz/lm8V9lIyuOUC7lA=;
        b=aG8xuILsDAF6emeajF/1CEWajNDjFnwH8YL/KbUAoULzRQcPupZ29Ch4RDk3n5Nt+ciyhN
        pZq+yghqi/nCPfIiikEFNtIbSNe1f6HCeXuUGCSGKFqscByNK6pFURzWif9kZiinlT2LaW
        +yv8zkaRTrFBaSzgEl6IwvnniCb1rLU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71E9CB1DD;
        Mon, 19 Oct 2020 12:31:38 +0000 (UTC)
Date:   Mon, 19 Oct 2020 14:31:37 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au, osalvador@suse.de,
        alexander.h.duyck@linux.intel.com, yang.shi@linux.alibaba.com,
        david@redhat.com, hannes@cmpxchg.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/memory.c: Introduce non-atomic
 __{Set,Clear}PageSwapCache
Message-ID: <20201019123137.GG27114@dhcp22.suse.cz>
References: <20201019101520.12283-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019101520.12283-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 19-10-20 18:15:20, Muchun Song wrote:
> For the exclusive reference page, the non-atomic operations is enough,
> so replace them to non-atomic operations.

I do expect you do not see any difference in runtime and this is mostly
driven by the code reading, right? Being explicit about this in the code
would be preferred.

No objection to the change.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

With an improved changelog
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/page-flags.h | 2 ++
>  mm/memory.c                | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index fbbb841a9346..ec039dde5e4b 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -401,6 +401,8 @@ static __always_inline int PageSwapCache(struct page *page)
>  }
>  SETPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
>  CLEARPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
> +__SETPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
> +__CLEARPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
>  #else
>  PAGEFLAG_FALSE(SwapCache)
>  #endif
> diff --git a/mm/memory.c b/mm/memory.c
> index 2d267ef6621a..02dd62da26e0 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3128,10 +3128,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  				set_page_private(page, entry.val);
>  
>  				/* Tell memcg to use swap ownership records */
> -				SetPageSwapCache(page);
> +				__SetPageSwapCache(page);
>  				err = mem_cgroup_charge(page, vma->vm_mm,
>  							GFP_KERNEL);
> -				ClearPageSwapCache(page);
> +				__ClearPageSwapCache(page);
>  				if (err) {
>  					ret = VM_FAULT_OOM;
>  					goto out_page;
> -- 
> 2.20.1
> 

-- 
Michal Hocko
SUSE Labs
