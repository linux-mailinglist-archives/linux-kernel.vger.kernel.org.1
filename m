Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5411A2B09DA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgKLQYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbgKLQYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:24:54 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C057C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:24:54 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id t191so5791091qka.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bIYmdruPemXDJ3Xp68i09oRAPpoygt4oEDIIpGtbWd4=;
        b=MfnOv52Sl2tr/+7U7bOXFlHJxRPRo2cVdp6cQyGR+2XWM1DldIwDbCEM1pG3CbXsIL
         is2vKvZcrHfsFwGoloEtwzdd6SyJPna5sxFpUKhifDVcVWPVZU1RxZ09Vs0B70qianHh
         MM7h7TwsDn6k2UkoFXoSCw+wI88f1D33RVdmycmTmvrIAlFmpsM0P5YFOC1cyidHgBk4
         Sivhh16GAKQF+E8iornHQtqPtpT+Hpi9v4cFiAqA+D0ZlM0Ewenr2wK8IIhXjAJIdpE/
         6P5Sz7pJtctxGc4JAj+gmUNnN/Br0Ra4exOxH4xUdxx/XKVJCj9J5yOt7X/xOdpAU89T
         xrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bIYmdruPemXDJ3Xp68i09oRAPpoygt4oEDIIpGtbWd4=;
        b=K5JZaaXaU3UBUI1NwnXpDCbX11kLg9YcdQed/WwxGld03/PaKJqq+QuYpcs2pAi8I0
         sOfgNWYbUJVXmApVyJaXLAZdms27JG429fUfvRDf2sDjli7+X5ysLyF7bFm6mx/fFxdQ
         KEyKFboM/YiJdMGDfo4LIiBOcffCiksvvMuQ8h+sKUHOh9O+2LnQNV1LlHCy6XFq5PXF
         RCNo+fAjojL4/qH6kz8ZlVrBJdVPx6OG4lJ7cZzv0Oni26AmTtFACu7s6iOVi2NXjhvB
         Tywy5QVY2T2O0XD0U2y0PoE4dLb5VPLZDX3+9Vnu3bozXaBFIMgKN69rZ2LrCc56MrZS
         on3A==
X-Gm-Message-State: AOAM530WxtjGd7OTJtvMplta399uZG9sFDrPTY5vCc+F6O2hXsnOE4xB
        jTY8MJePH+yzMq63+mN/7AtRE3MLUCmisQ==
X-Google-Smtp-Source: ABdhPJz3bBHwHr7iBtOgV9aSEUhCSmoPjhng/xQ6gvFywTHE5XT7O9LRuZOOs/APZv07THoTT8w+zw==
X-Received: by 2002:ae9:c211:: with SMTP id j17mr556311qkg.458.1605198293350;
        Thu, 12 Nov 2020 08:24:53 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:7257])
        by smtp.gmail.com with ESMTPSA id c203sm893673qkg.60.2020.11.12.08.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 08:24:52 -0800 (PST)
Date:   Thu, 12 Nov 2020 11:23:03 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: memcg/slab: pre-allocate obj_cgroups for slab
 caches with SLAB_ACCOUNT
Message-ID: <20201112162303.GB873621@cmpxchg.org>
References: <20201110195753.530157-1-guro@fb.com>
 <20201110195753.530157-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110195753.530157-2-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:57:53AM -0800, Roman Gushchin wrote:
> In general it's unknown in advance if a slab page will contain
> accounted objects or not. In order to avoid memory waste, an
> obj_cgroup vector is allocated dynamically when a need to account
> of a new object arises. Such approach is memory efficient, but
> requires an expensive cmpxchg() to set up the memcg/objcgs pointer,
> because an allocation can race with a different allocation on another
> cpu.
> 
> But in some common cases it's known for sure that a slab page will
> contain accounted objects: if the page belongs to a slab cache with a
> SLAB_ACCOUNT flag set. It includes such popular objects like
> vm_area_struct, anon_vma, task_struct, etc.
> 
> In such cases we can pre-allocate the objcgs vector and simple assign
> it to the page without any atomic operations, because at this early
> stage the page is not visible to anyone else.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

That's a nice optimization!

Some comments inline:

> @@ -485,14 +485,20 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
>   * set_page_objcgs - associate a page with a object cgroups vector
>   * @page: a pointer to the page struct
>   * @objcgs: a pointer to the object cgroups vector
> + * @atomic: save the value atomically
>   *
>   * Atomically associates a page with a vector of object cgroups.
>   */
>  static inline bool set_page_objcgs(struct page *page,
> -					struct obj_cgroup **objcgs)
> +				   struct obj_cgroup **objcgs, bool atomic)

bool parameters make callsites pretty hard to understand - unless the
function interface obviously has two modes (read vs write etc.), which
isn't the case here.

> -	return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs |
> -			MEMCG_DATA_OBJCGS);
> +	unsigned long memcg_data = (unsigned long) objcgs | MEMCG_DATA_OBJCGS;
> +
> +	if (atomic)
> +		return !cmpxchg(&page->memcg_data, 0, memcg_data);
> +
> +	page->memcg_data = memcg_data;
> +	return true;
>  }
>  #else
>  static inline struct obj_cgroup **page_objcgs(struct page *page)
> @@ -506,7 +512,7 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
>  }
>  
>  static inline bool set_page_objcgs(struct page *page,
> -					struct obj_cgroup **objcgs)
> +				   struct obj_cgroup **objcgs, bool atomic)
>  {
>  	return true;
>  }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 69a2893a6455..37bffd336235 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2874,7 +2874,7 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
>  
>  #ifdef CONFIG_MEMCG_KMEM
>  int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
> -				 gfp_t gfp)
> +				 gfp_t gfp, bool atomic)
>  {
>  	unsigned int objects = objs_per_slab_page(s, page);
>  	void *vec;
> @@ -2884,7 +2884,7 @@ int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
>  	if (!vec)
>  		return -ENOMEM;
>  
> -	if (!set_page_objcgs(page, vec))
> +	if (!set_page_objcgs(page, vec, atomic))
>  		kfree(vec);
>  	else
>  		kmemleak_not_leak(vec);

The life of page->memcg_data and this optimization could use a central
comment somewhere, because it's hard to understand what's going on
from the code alone. This function here seems like a good place?

I don't see a way to eliminate the bool on the allocation function,
but maybe it could be more descriptive. Maybe bool slab_account?

set_page_objcgs() can be inlined at this point. It made some sense to
abstract away the atomics with setter and matching getter, but with a
non-atomic mode, inlining makes things clearer and allows for better
in-place documentation in the sole callsite.

How about something like this?

	vec = kcalloc(...);

	memcg_data = (unsigned long)vec | MEMCG_DATA_OBJCGS;
	/*
	 * Set up the objcg vector for the page.
	 *
	 * When only some objects in a slab are tracked (think GFP_ACCOUNT
	 * kmalloc allocations), the objcg vector is set up when the first
	 * tracked object in the slab page is allocated. Multiple concurrent
	 * slab allocations can race to this, so synchronization is required.
	 *
	 * When SLAB_ACCOUNT is set on the cache, however, all objects in the
	 * slab page will be tracked, and the vector is allocated along with
	 * the page itself, while it's still exclusive; no atomics necessary.
	 */
	if (slab_account) {
		page->memcg_data = memcg_data;
	} else {
		if (cmpxchg(&page->memcg_data, 0, memcg_data)) {
			/* Somebody else beat us, use their vec */
			kfree(vec);
			return 0;
		}
	}
	kmemleak_not_leak(vec);
	return 0;
