Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB34280555
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732926AbgJARdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732876AbgJARdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:33:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273A5C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:33:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so6758422wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RyvBCHeBiWREspyplqvYLjTu6txMmCKxwBHGAY8/C40=;
        b=ISKMXrHzPpXTl6YH2OnZSzENPkot5q/TU0fdM+lM7cEzORvY2csaeJv0USOcQ18qxg
         4gHudrdypoKEcHzgjxCMdPx0OjtnA/mwWlWA9odpTjHKy8i9KvkBQCnMa2p3niq83pgV
         tLdphnAJdBcirwAUcmQObo+rP2ol79CVlm4AbVX3awXXvk16lEMQfEbXfs2Xtrggo3Tr
         6QA/N8S2wM/RoWIbOcjQ0q2biItuGoSHmqJ+qy9R7elOfPvBh/FMilibsC5bAWC/g7DL
         CEG1smLGq//pYv5uPxKJmfP/yrp8eFMbgPY8mes0LDIyZsMpTtK12DtZlsq6gHxFQimU
         MVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RyvBCHeBiWREspyplqvYLjTu6txMmCKxwBHGAY8/C40=;
        b=uTMs6FZlPW54Pubev21my1rInGn+QYgrPHRWkZmj4VfLZFal7far33aKNbC3k+TZm7
         Iqma+outDz9YOEpJZmmSDmBNF1WWS3l4DIQEw7kBMSmbonCYsYQ6M1rO7+NQJLQEQ73n
         cqWd8gT38Pg+WW3yH7iL+53vT3QGavFfMplDP3zWDi88E8N1RF00CMe2LdPtFxfmZ5qC
         r3SLo+Yg1ZomIuJRL/u3AVPop7azrL4DnU3KS27QkDSNNI1aZ1JsbMbaiQfj0h9bqlFP
         /h94PldNnFjDGhIgVNv3YV5vcMggE4D5eB9MnIoLsFh6F025gjaCNUUDdfZO+dP+tv7h
         p1Lw==
X-Gm-Message-State: AOAM532D++vnmzmzcYDz7LLxpSJxPMzSquK8XIMfRw5UnYkRteIT8AJm
        1V/p1Ijl7biBY8MZXnB3r0gVwA==
X-Google-Smtp-Source: ABdhPJyKBp6vSfk3WnfQaYYcClLpeCrmO8iYzQVF1oz9m7sTbW8cz5XqdtrqY4Lz27dwRrvMvQDMZQ==
X-Received: by 2002:adf:9504:: with SMTP id 4mr10606938wrs.27.1601573613686;
        Thu, 01 Oct 2020 10:33:33 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id k4sm10446478wrx.51.2020.10.01.10.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:33:32 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:33:26 +0200
From:   elver@google.com
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/39] kasan: define KASAN_GRANULE_PAGE
Message-ID: <20201001173326.GG4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <92a351d2bc4b1235a772f343db06bedf69a3cec9.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92a351d2bc4b1235a772f343db06bedf69a3cec9.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> Define KASAN_GRANULE_PAGE as (KASAN_GRANULE_SIZE << PAGE_SHIFT), which is
> the same as (KASAN_GRANULE_SIZE * PAGE_SIZE), and use it across KASAN code
> to simplify it.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: I0b627b24187d06c8b9bb2f1d04d94b3d06945e73
> ---
>  mm/kasan/init.c   | 10 ++++------
>  mm/kasan/kasan.h  |  1 +
>  mm/kasan/shadow.c | 16 +++++++---------
>  3 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index 1a71eaa8c5f9..26b2663b3a42 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -441,9 +441,8 @@ void kasan_remove_zero_shadow(void *start, unsigned long size)
>  	addr = (unsigned long)kasan_mem_to_shadow(start);
>  	end = addr + (size >> KASAN_SHADOW_SCALE_SHIFT);
>  
> -	if (WARN_ON((unsigned long)start %
> -			(KASAN_GRANULE_SIZE * PAGE_SIZE)) ||
> -	    WARN_ON(size % (KASAN_GRANULE_SIZE * PAGE_SIZE)))
> +	if (WARN_ON((unsigned long)start % KASAN_GRANULE_PAGE) ||
> +	    WARN_ON(size % KASAN_GRANULE_PAGE))
>  		return;
>  
>  	for (; addr < end; addr = next) {
> @@ -476,9 +475,8 @@ int kasan_add_zero_shadow(void *start, unsigned long size)
>  	shadow_start = kasan_mem_to_shadow(start);
>  	shadow_end = shadow_start + (size >> KASAN_SHADOW_SCALE_SHIFT);
>  
> -	if (WARN_ON((unsigned long)start %
> -			(KASAN_GRANULE_SIZE * PAGE_SIZE)) ||
> -	    WARN_ON(size % (KASAN_GRANULE_SIZE * PAGE_SIZE)))
> +	if (WARN_ON((unsigned long)start % KASAN_GRANULE_PAGE) ||
> +	    WARN_ON(size % KASAN_GRANULE_PAGE))
>  		return -EINVAL;
>  
>  	ret = kasan_populate_early_shadow(shadow_start, shadow_end);
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index c31e2c739301..1865bb92d47a 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -7,6 +7,7 @@
>  
>  #define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
>  #define KASAN_GRANULE_MASK	(KASAN_GRANULE_SIZE - 1)
> +#define KASAN_GRANULE_PAGE	(KASAN_GRANULE_SIZE << PAGE_SHIFT)
>  
>  #define KASAN_TAG_KERNEL	0xFF /* native kernel pointers tag */
>  #define KASAN_TAG_INVALID	0xFE /* inaccessible memory tag */
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index ca0cc4c31454..1fadd4930d54 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -161,7 +161,7 @@ static int __meminit kasan_mem_notifier(struct notifier_block *nb,
>  	shadow_end = shadow_start + shadow_size;
>  
>  	if (WARN_ON(mem_data->nr_pages % KASAN_GRANULE_SIZE) ||
> -		WARN_ON(start_kaddr % (KASAN_GRANULE_SIZE << PAGE_SHIFT)))
> +		WARN_ON(start_kaddr % KASAN_GRANULE_PAGE))
>  		return NOTIFY_BAD;
>  
>  	switch (action) {
> @@ -432,22 +432,20 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
>  	unsigned long region_start, region_end;
>  	unsigned long size;
>  
> -	region_start = ALIGN(start, PAGE_SIZE * KASAN_GRANULE_SIZE);
> -	region_end = ALIGN_DOWN(end, PAGE_SIZE * KASAN_GRANULE_SIZE);
> +	region_start = ALIGN(start, KASAN_GRANULE_PAGE);
> +	region_end = ALIGN_DOWN(end, KASAN_GRANULE_PAGE);
>  
> -	free_region_start = ALIGN(free_region_start,
> -				  PAGE_SIZE * KASAN_GRANULE_SIZE);
> +	free_region_start = ALIGN(free_region_start, KASAN_GRANULE_PAGE);
>  
>  	if (start != region_start &&
>  	    free_region_start < region_start)
> -		region_start -= PAGE_SIZE * KASAN_GRANULE_SIZE;
> +		region_start -= KASAN_GRANULE_PAGE;
>  
> -	free_region_end = ALIGN_DOWN(free_region_end,
> -				     PAGE_SIZE * KASAN_GRANULE_SIZE);
> +	free_region_end = ALIGN_DOWN(free_region_end, KASAN_GRANULE_PAGE);
>  
>  	if (end != region_end &&
>  	    free_region_end > region_end)
> -		region_end += PAGE_SIZE * KASAN_GRANULE_SIZE;
> +		region_end += KASAN_GRANULE_PAGE;
>  
>  	shadow_start = kasan_mem_to_shadow((void *)region_start);
>  	shadow_end = kasan_mem_to_shadow((void *)region_end);
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
