Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4024F2AF798
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgKKRur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbgKKRuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:50:46 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7B3C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:50:46 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p19so4562375wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pMy5H5o1v+WngKr1b+qy1lo8XFp3TrTTXnTQCqUhuZg=;
        b=fAVKGBzKjAe4FzmDhdDDIdaDB5BezRl0ARbzRYYJnSFvDZui2+PV9PzMunIgpyBtFV
         1e1pdPHRVceAMBXgozczlGqUNQhPkCQqlFHjTAd3nPNZ6ycbPnymnqNOKlEW+SdgZEbZ
         Ca7t42UZkCex/Ik+BLFF0tKwXxS0hdm+OvHaTu3VQurOOSra1XAOInP9k8Lxu517uOJi
         yiyjOxWAeLsKn1mXFIW6KhPvCXcw3qC2VhYFr+mwvUtdnjXV4r3i2oMaWcAiAu3C8HYL
         SBxTEcfnRjP5ln+tXuaFcbzMSN9dBNP0fcH1BaeZfGHH3CyfJyJc8T0FvBTxlpvCxJiC
         c9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pMy5H5o1v+WngKr1b+qy1lo8XFp3TrTTXnTQCqUhuZg=;
        b=QzqplC7c9umWO1Iva1Lhe6SqWGiZsXzVMRD2WFofuK/PZRkR7yEjW9PHsppZCgr+qU
         Ub21hmmqIsCV8PS3PyFnMGurTEpuTYp2rD9FX7kRlU9pY1z1RKIch8XWGPOcPju+3WBq
         z9CSgC72njhs+MYINfObFEDwczmwqv0Kfoa0g86lyNSjOrw7nfbxWyGoWwlWgMOXuNjG
         rKHzcewTeg7IGzJ24sZaem1Omm//Q4cvWQF0U7sq4NEpKFB0D3mlO3tdwYpOLWmRtkdY
         3ePfhBX7vMmE43WrTtCeE8XRYvNJZJTvrenk+wdblsmDCKO8Yz/VyqwiP0EZce995K/6
         W5Fg==
X-Gm-Message-State: AOAM531WGObPOlI1Mgt4QNV1MZsK/yZamMUwJjHy9I1mw3k0shZKa8n9
        eI7jGReIDy1U90mOKIssqs3umw==
X-Google-Smtp-Source: ABdhPJwZ1ZTomPkEm6NnFS5XcoFOE7jbre2KnwrSxfqY1ikuV8ZC4b2EjuVGNlFN60bBV2WWFhhU0g==
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr5390876wmc.176.1605117044596;
        Wed, 11 Nov 2020 09:50:44 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id v8sm3346969wmg.28.2020.11.11.09.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 09:50:43 -0800 (PST)
Date:   Wed, 11 Nov 2020 18:50:38 +0100
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
Subject: Re: [PATCH v2 09/20] kasan: inline kasan_poison_memory and
 check_invalid_free
Message-ID: <20201111175038.GL517454@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <e14ac53d7c43b4381ad94665c63a154dffc04b6b.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e14ac53d7c43b4381ad94665c63a154dffc04b6b.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20PM +0100, 'Andrey Konovalov' via kasan-dev wrote:
> Using kasan_poison_memory() or check_invalid_free() currently results in
> function calls. Move their definitions to mm/kasan/kasan.h and turn them
> into static inline functions for hardware tag-based mode to avoid
> unneeded function calls.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://linux-review.googlesource.com/id/Ia9d8191024a12d1374675b3d27197f10193f50bb
> ---
>  mm/kasan/hw_tags.c | 15 ---------------
>  mm/kasan/kasan.h   | 28 ++++++++++++++++++++++++----
>  2 files changed, 24 insertions(+), 19 deletions(-)

Reviewed-by: Marco Elver <elver@google.com>

> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 1476ac07666e..0303e49904b4 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -30,27 +30,12 @@ void kasan_init_hw_tags(void)
>  	pr_info("KernelAddressSanitizer initialized\n");
>  }
>  
> -void kasan_poison_memory(const void *address, size_t size, u8 value)
> -{
> -	hw_set_mem_tag_range(kasan_reset_tag(address),
> -			round_up(size, KASAN_GRANULE_SIZE), value);
> -}
> -
>  void kasan_unpoison_memory(const void *address, size_t size)
>  {
>  	hw_set_mem_tag_range(kasan_reset_tag(address),
>  			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
>  }
>  
> -bool check_invalid_free(void *addr)
> -{
> -	u8 ptr_tag = get_tag(addr);
> -	u8 mem_tag = hw_get_mem_tag(addr);
> -
> -	return (mem_tag == KASAN_TAG_INVALID) ||
> -		(ptr_tag != KASAN_TAG_KERNEL && ptr_tag != mem_tag);
> -}
> -
>  void kasan_set_free_info(struct kmem_cache *cache,
>  				void *object, u8 tag)
>  {
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 7498839a15d3..ab7314418604 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -153,8 +153,6 @@ struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
>  struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
>  						const void *object);
>  
> -void kasan_poison_memory(const void *address, size_t size, u8 value);
> -
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  
>  static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
> @@ -194,8 +192,6 @@ void print_tags(u8 addr_tag, const void *addr);
>  static inline void print_tags(u8 addr_tag, const void *addr) { }
>  #endif
>  
> -bool check_invalid_free(void *addr);
> -
>  void *find_first_bad_addr(void *addr, size_t size);
>  const char *get_bug_type(struct kasan_access_info *info);
>  void metadata_fetch_row(char *buffer, void *row);
> @@ -279,6 +275,30 @@ static inline u8 random_tag(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_KASAN_HW_TAGS
> +
> +static inline void kasan_poison_memory(const void *address, size_t size, u8 value)
> +{
> +	hw_set_mem_tag_range(kasan_reset_tag(address),
> +			round_up(size, KASAN_GRANULE_SIZE), value);
> +}
> +
> +static inline bool check_invalid_free(void *addr)
> +{
> +	u8 ptr_tag = get_tag(addr);
> +	u8 mem_tag = hw_get_mem_tag(addr);
> +
> +	return (mem_tag == KASAN_TAG_INVALID) ||
> +		(ptr_tag != KASAN_TAG_KERNEL && ptr_tag != mem_tag);
> +}
> +
> +#else /* CONFIG_KASAN_HW_TAGS */
> +
> +void kasan_poison_memory(const void *address, size_t size, u8 value);
> +bool check_invalid_free(void *addr);
> +
> +#endif /* CONFIG_KASAN_HW_TAGS */
> +
>  /*
>   * Exported functions for interfaces called from assembly or from generated
>   * code. Declarations here to avoid warning about missing declarations.
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 
> -- 
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/e14ac53d7c43b4381ad94665c63a154dffc04b6b.1605046662.git.andreyknvl%40google.com.
