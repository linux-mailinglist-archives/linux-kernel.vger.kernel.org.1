Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D392B487E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbgKPPGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731369AbgKPPGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:06:15 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA219C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:06:15 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 19so24028153wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s4udoHyh9j5IqUv+HxIL+80tVyb07J8vLMt6/kF0Ir4=;
        b=u/ixGDcp+NZMNnm/O+DlS0jMRpHKY4q7Pd3EsbpVtdjjSSMtr3FS77mwphnR9q29+f
         IzDll4a7WFJwUvgxNnlOemkmmCfjvnpJWDAcn4xX4szOhaUhQMXvejtD84fG1m+T0S4v
         b8HPPvL9a1PvNMQ6/0ghOPVPX0OyZ7ilaHtmEpUPa9h2ValL8VYceeFwdc9bdV3OFBEG
         WzFqlq8Ko2/WmyM7pIukgIvcBNtHZpDq/ZxL4eTnAbfhsfEtNUci1T56jtUsbvSqUlCe
         CKaIjSxxLNJ7+xzLTHKO2xL4PkFWph4oBjcItMXaWmdz3s7PXMzJlXSlZBSthnD7uued
         Z5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s4udoHyh9j5IqUv+HxIL+80tVyb07J8vLMt6/kF0Ir4=;
        b=H3LxTO6cxTdPp9/aLL082RLIEJ6lBKnb4UDDZr4zlB+banYPP3P/Jjr/j1/fR16YB5
         HhM9q/NeBhuswJdYYxobzk0AJOC9Oq14Zhtj4IWAgFM2i31kvKY3sIRuo50kMnlJNWPv
         wckJESt3laEkVZV+xRMy4eH21wD3f6Bt5YqnmwsY+V0o2HVgf7w4fbxxD9KqlGCR/Y55
         EkAowtK+9o601xmZn1wmIbBeAr0Kozz5Zn+Py83KlHY054LeSzj+TG9nwsnFDAaL6L/C
         B5ahMegNfyKWvaghXpidEAETDPgoeE+JefzQwzJVwQKjdp5RD74VNuyvac0d/vDzW6FS
         MssA==
X-Gm-Message-State: AOAM5310StyDvd4EyiPj5iyhAxsrgjVeJh+hl9S0qd8M5uaDqeuK6lY0
        +zX4OJmfBLLj8ykyp/27JA1fXw==
X-Google-Smtp-Source: ABdhPJw8tF4y6iZkiPHaYIRvmwH3SgAzlk4656vVGflsdOGVS/S4cEjS2rC+eWSoaGqa5NFbMWb9/Q==
X-Received: by 2002:a1c:9c53:: with SMTP id f80mr15486878wme.19.1605539174436;
        Mon, 16 Nov 2020 07:06:14 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id d128sm4597301wmc.7.2020.11.16.07.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:06:13 -0800 (PST)
Date:   Mon, 16 Nov 2020 16:06:07 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm v3 09/19] kasan: open-code kasan_unpoison_slab
Message-ID: <20201116150607.GA1357314@elver.google.com>
References: <cover.1605305978.git.andreyknvl@google.com>
 <4d64025c647190a8b7101d0b1da3deb922535a0d.1605305978.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d64025c647190a8b7101d0b1da3deb922535a0d.1605305978.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:19PM +0100, Andrey Konovalov wrote:
> There's the external annotation kasan_unpoison_slab() that is currently
> defined as static inline and uses kasan_unpoison_range(). Open-code this
> function in mempool.c. Otherwise with an upcoming change this function
> will result in an unnecessary function call.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Ia7c8b659f79209935cbaab3913bf7f082cc43a0e

Reviewed-by: Marco Elver <elver@google.com>

Thank you!

I also think this change made the code more readable, as
kasan_unpoison_slab() made me think it's unpoisoning the *whole* slab,
which is clearly not the case.

> ---
>  include/linux/kasan.h | 6 ------
>  mm/mempool.c          | 2 +-
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 1594177f86bb..872bf145ddde 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -106,11 +106,6 @@ struct kasan_cache {
>  	int free_meta_offset;
>  };
>  
> -size_t __ksize(const void *);
> -static inline void kasan_unpoison_slab(const void *ptr)
> -{
> -	kasan_unpoison_range(ptr, __ksize(ptr));
> -}
>  size_t kasan_metadata_size(struct kmem_cache *cache);
>  
>  bool kasan_save_enable_multi_shot(void);
> @@ -166,7 +161,6 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
>  	return false;
>  }
>  
> -static inline void kasan_unpoison_slab(const void *ptr) { }
>  static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
>  
>  #endif /* CONFIG_KASAN */
> diff --git a/mm/mempool.c b/mm/mempool.c
> index f473cdddaff0..583a9865b181 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -112,7 +112,7 @@ static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
>  static void kasan_unpoison_element(mempool_t *pool, void *element)
>  {
>  	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
> -		kasan_unpoison_slab(element);
> +		kasan_unpoison_range(element, __ksize(element));
>  	else if (pool->alloc == mempool_alloc_pages)
>  		kasan_alloc_pages(element, (unsigned long)pool->pool_data);
>  }
> -- 
> 2.29.2.299.gdc1121823c-goog
> 
