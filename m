Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6EA2AF8B6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgKKTJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKTJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:09:07 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13959C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 11:09:07 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so3317804wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 11:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3pzzdEUXqdlUXkCITd16mcn7xREtcEGzt0MbcAZyF9Q=;
        b=K4eTAtSNaW4ABsK0MqA/oBSfqpOpmAkKezax7uQfKZcTaJ+hBqs19gsrUKLp/FXRJU
         O760l4QF+zosCex1gestm4r7y6yf0HghWKDx04bnNI5AmE6kUZndcQK/32kGLglEhy9j
         MOeKPIC3K6zOl0SHsZuAIHhrp4aICC4GMFcLmsVHwq2AckJxCTfIv7KfGbCHP/tT0qFy
         sE4RszEvcBgy+9xGmuo/ZBlTPaHin8FPDoZrrdBvdz4x6Wxq56YDXL2dCLP1pB06a4V4
         lsZTH4rRG5hyHg3IXj05ISjFMgPt8Hg79+16grf2IsCFwJ4JJJSnYUjQ9oBXPSFISNSg
         bQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3pzzdEUXqdlUXkCITd16mcn7xREtcEGzt0MbcAZyF9Q=;
        b=Fgr2WPnGG22xiDZMBWyAmTgwiJrLjlZW3+6eTbriMDh0jMy5Hry3JLNqTkmRpiTNn2
         gIDWjHA/Jz7SYOQXOUgctvqzVf3j+le3F1tYfApEAYAkKrCUB1u4/U3hisVFYuZ7c1hA
         zV+k+B+EZqCie4g3aHC14cLd0OMuZ0b/I0sJVXdLCkyHEvDcSZzzzrqzDKwtzGRHEtW2
         zMgSAaHoovK6S4k/+n11Gr1lsKgyr4xnVP/Hu1khoxDstWT+soe3AD75ZMk4ow+D//Bg
         7QMEtARzDxgl7Sg5oU9MZGARn2mVfnPocsRBsWlefodIpRpzXYZhSy5+RA5DzVpjWDx5
         BQ5g==
X-Gm-Message-State: AOAM532+xZKIAGahhoyuG5JjWgmCyRafNc8d/NjDFzuVJ23e/ZvIaJCg
        P4BsSwSb/1pi53hnylfMb10uSg==
X-Google-Smtp-Source: ABdhPJwS+C4LRdXb3iKiJxV4xKpwDFm//prTWZiywKw/Bpavh2WuyLygkDLjWVWENWJ3krNCPCfbMA==
X-Received: by 2002:a1c:46c5:: with SMTP id t188mr5871850wma.68.1605121745575;
        Wed, 11 Nov 2020 11:09:05 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id 130sm3739700wmd.18.2020.11.11.11.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:09:04 -0800 (PST)
Date:   Wed, 11 Nov 2020 20:08:59 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/20] kasan: don't round_up too much
Message-ID: <20201111190859.GQ517454@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <b11824e1cb87c75c4def2b3ac592abb409cebf82.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b11824e1cb87c75c4def2b3ac592abb409cebf82.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> For hardware tag-based mode kasan_poison_memory() already rounds up the
> size. Do the same for software modes and remove round_up() from the common
> code.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://linux-review.googlesource.com/id/Ib397128fac6eba874008662b4964d65352db4aa4
> ---
>  mm/kasan/common.c | 8 ++------
>  mm/kasan/shadow.c | 1 +
>  2 files changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Marco Elver <elver@google.com>

> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 60793f8695a8..69ab880abacc 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -218,9 +218,7 @@ void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
>  
>  void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
>  {
> -	kasan_poison_memory(object,
> -			round_up(cache->object_size, KASAN_GRANULE_SIZE),
> -			KASAN_KMALLOC_REDZONE);
> +	kasan_poison_memory(object, cache->object_size, KASAN_KMALLOC_REDZONE);
>  }
>  
>  /*
> @@ -293,7 +291,6 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>  {
>  	u8 tag;
>  	void *tagged_object;
> -	unsigned long rounded_up_size;
>  
>  	tag = get_tag(object);
>  	tagged_object = object;
> @@ -314,8 +311,7 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>  		return true;
>  	}
>  
> -	rounded_up_size = round_up(cache->object_size, KASAN_GRANULE_SIZE);
> -	kasan_poison_memory(object, rounded_up_size, KASAN_KMALLOC_FREE);
> +	kasan_poison_memory(object, cache->object_size, KASAN_KMALLOC_FREE);
>  
>  	if (!kasan_stack_collection_enabled())
>  		return false;
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 8e4fa9157a0b..3f64c9ecbcc0 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -82,6 +82,7 @@ void kasan_poison_memory(const void *address, size_t size, u8 value)
>  	 * addresses to this function.
>  	 */
>  	address = kasan_reset_tag(address);
> +	size = round_up(size, KASAN_GRANULE_SIZE);
>  
>  	shadow_start = kasan_mem_to_shadow(address);
>  	shadow_end = kasan_mem_to_shadow(address + size);
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 
