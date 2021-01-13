Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6EB2F5115
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbhAMRZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:25:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:37528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbhAMRZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:25:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 023E0ACF5;
        Wed, 13 Jan 2021 17:24:59 +0000 (UTC)
Subject: Re: [PATCH 1/2] kasan, mm: fix conflicts with init_on_alloc/free
To:     Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1610553773.git.andreyknvl@google.com>
 <7fbac00e4d155cf529517a165a48351dcf3c3156.1610553774.git.andreyknvl@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <25aa25d6-080c-ccfa-9367-fc60f46ff10f@suse.cz>
Date:   Wed, 13 Jan 2021 18:24:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <7fbac00e4d155cf529517a165a48351dcf3c3156.1610553774.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/21 5:03 PM, Andrey Konovalov wrote:
> A few places where SLUB accesses object's data or metadata were missed in
> a previous patch. This leads to false positives with hardware tag-based
> KASAN when bulk allocations are used with init_on_alloc/free.
> 
> Fix the false-positives by resetting pointer tags during these accesses.
> 
> Link: https://linux-review.googlesource.com/id/I50dd32838a666e173fe06c3c5c766f2c36aae901
> Fixes: aa1ef4d7b3f67 ("kasan, mm: reset tags when accessing metadata")
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index dc5b42e700b8..75fb097d990d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2791,7 +2791,8 @@ static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
>  						   void *obj)
>  {
>  	if (unlikely(slab_want_init_on_free(s)) && obj)
> -		memset((void *)((char *)obj + s->offset), 0, sizeof(void *));
> +		memset((void *)((char *)kasan_reset_tag(obj) + s->offset),
> +			0, sizeof(void *));
>  }
>  
>  /*
> @@ -2883,7 +2884,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
>  		stat(s, ALLOC_FASTPATH);
>  	}
>  
> -	maybe_wipe_obj_freeptr(s, kasan_reset_tag(object));
> +	maybe_wipe_obj_freeptr(s, object);

And in that case the reset was unnecessary, right. (commit log only mentions
adding missing resets).

>  	if (unlikely(slab_want_init_on_alloc(gfpflags, s)) && object)
>  		memset(kasan_reset_tag(object), 0, s->object_size);
> @@ -3329,7 +3330,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  		int j;
>  
>  		for (j = 0; j < i; j++)
> -			memset(p[j], 0, s->object_size);
> +			memset(kasan_reset_tag(p[j]), 0, s->object_size);
>  	}
>  
>  	/* memcg and kmem_cache debug support */
> 

