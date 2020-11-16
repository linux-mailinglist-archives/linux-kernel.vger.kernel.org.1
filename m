Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEB02B48D8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbgKPPLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgKPPLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:11:36 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90811C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:11:34 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p1so19024940wrf.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ph474WBwjZPtIC8WXwer+eWtTufIJgCo5S0VZjhhIPE=;
        b=fqv5T6oyUPs3UyvG6i30zxMwtpOg6tczmHuVWpNWm+hQXxuNi/kdQEczNFJpFKC77q
         F37j43S/vqJ9S7adkg3K85WLETVanVbPSbghDnruXZOVhD/0Js3wagMTAB+hgfGQm0HP
         xzphqBY72oN1yPlFCW4T1Je4vU8BHtiTbvg5TSFbX4uOk/uYTbTM9oG4XKvpQMMV5rsj
         4XUkYvW1/4BqGp2xGZLNhqt5nIDJCOyXJhLm8K+b7k6o78gbzZPMawtbXuT/ivFD9kpm
         w666BOPjJkvsKI4azNQGTbx7XN+In0C+v4KyG6rbP7L77FuugdxOqQdz9vSIPJ6yySGC
         unCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ph474WBwjZPtIC8WXwer+eWtTufIJgCo5S0VZjhhIPE=;
        b=sjbvmF/3VGOjH62YVLCs9FYOh7uN+G2hWAqTgZQL6tWbZBAIDPblaCX31F2Fz0nm5s
         4tv8f3WFujLEA7mmUJcT+y0Ax7lXU0yh5nLO8r245hBKX0QP+GVQpCnlA8eTefpjV3hl
         9Rqq/8CiYDqgEAj3vuSkqXv4PaSSUD8In/jSpvusDE2iEUHIROcrXzM355Jsf9xCcPaa
         udrfyQqkz26sDDi7L81CHB0XaZwvJeCRfMibT1frSqFQvkgKOOUvXyK/NbboL1L4Pbar
         n0C57cE63QM9/lDtcdDooA8JmoStPS3O5Aqd9Umba9ZAMYFIwalI/uFVZebHQ+JcLox4
         g0Ow==
X-Gm-Message-State: AOAM531/cPSZWccTowb5b0CfCejuHQsqiYqWrmOGTLNckzEqkEktBNEO
        Tf3KY8Ntk+teKK40e+0vof/8qQ==
X-Google-Smtp-Source: ABdhPJxbM4Aw3fKMYZetkprvW9hOh0Nan1KDunBg0W5NB8sKz+IevgtW6psdw0QSl4UedN+YASGUpg==
X-Received: by 2002:adf:8521:: with SMTP id 30mr20230790wrh.265.1605539492993;
        Mon, 16 Nov 2020 07:11:32 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id t136sm17495991wmt.18.2020.11.16.07.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:11:32 -0800 (PST)
Date:   Mon, 16 Nov 2020 16:11:26 +0100
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
Subject: Re: [PATCH mm v3 10/19] kasan: inline (un)poison_range and
 check_invalid_free
Message-ID: <20201116151126.GB1357314@elver.google.com>
References: <cover.1605305978.git.andreyknvl@google.com>
 <cc8bea6e21d1cba10f4718fb58458f54fce0dab3.1605305978.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc8bea6e21d1cba10f4718fb58458f54fce0dab3.1605305978.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> Using (un)poison_range() or check_invalid_free() currently results in
> function calls. Move their definitions to mm/kasan/kasan.h and turn them
> into static inline functions for hardware tag-based mode to avoid
> unneeded function calls.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Ia9d8191024a12d1374675b3d27197f10193f50bb

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/hw_tags.c | 30 ------------------------------
>  mm/kasan/kasan.h   | 45 ++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 40 insertions(+), 35 deletions(-)
> 
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 3cdd87d189f6..863fed4edd3f 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -10,7 +10,6 @@
>  
>  #include <linux/kasan.h>
>  #include <linux/kernel.h>
> -#include <linux/kfence.h>
>  #include <linux/memory.h>
>  #include <linux/mm.h>
>  #include <linux/string.h>
> @@ -31,35 +30,6 @@ void __init kasan_init_hw_tags(void)
>  	pr_info("KernelAddressSanitizer initialized\n");
>  }
>  
> -void poison_range(const void *address, size_t size, u8 value)
> -{
> -	/* Skip KFENCE memory if called explicitly outside of sl*b. */
> -	if (is_kfence_address(address))
> -		return;
> -
> -	hw_set_mem_tag_range(kasan_reset_tag(address),
> -			round_up(size, KASAN_GRANULE_SIZE), value);
> -}
> -
> -void unpoison_range(const void *address, size_t size)
> -{
> -	/* Skip KFENCE memory if called explicitly outside of sl*b. */
> -	if (is_kfence_address(address))
> -		return;
> -
> -	hw_set_mem_tag_range(kasan_reset_tag(address),
> -			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
> -}
> -
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
> index 7876a2547b7d..8aa83b7ad79e 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -3,6 +3,7 @@
>  #define __MM_KASAN_KASAN_H
>  
>  #include <linux/kasan.h>
> +#include <linux/kfence.h>
>  #include <linux/stackdepot.h>
>  
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> @@ -154,9 +155,6 @@ struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
>  struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
>  						const void *object);
>  
> -void poison_range(const void *address, size_t size, u8 value);
> -void unpoison_range(const void *address, size_t size);
> -
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  
>  static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
> @@ -196,8 +194,6 @@ void print_tags(u8 addr_tag, const void *addr);
>  static inline void print_tags(u8 addr_tag, const void *addr) { }
>  #endif
>  
> -bool check_invalid_free(void *addr);
> -
>  void *find_first_bad_addr(void *addr, size_t size);
>  const char *get_bug_type(struct kasan_access_info *info);
>  void metadata_fetch_row(char *buffer, void *row);
> @@ -278,6 +274,45 @@ static inline u8 random_tag(void) { return hw_get_random_tag(); }
>  static inline u8 random_tag(void) { return 0; }
>  #endif
>  
> +#ifdef CONFIG_KASAN_HW_TAGS
> +
> +static inline void poison_range(const void *address, size_t size, u8 value)
> +{
> +	/* Skip KFENCE memory if called explicitly outside of sl*b. */
> +	if (is_kfence_address(address))
> +		return;
> +
> +	hw_set_mem_tag_range(kasan_reset_tag(address),
> +			round_up(size, KASAN_GRANULE_SIZE), value);
> +}
> +
> +static inline void unpoison_range(const void *address, size_t size)
> +{
> +	/* Skip KFENCE memory if called explicitly outside of sl*b. */
> +	if (is_kfence_address(address))
> +		return;
> +
> +	hw_set_mem_tag_range(kasan_reset_tag(address),
> +			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
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
> +void poison_range(const void *address, size_t size, u8 value);
> +void unpoison_range(const void *address, size_t size);
> +bool check_invalid_free(void *addr);
> +
> +#endif /* CONFIG_KASAN_HW_TAGS */
> +
>  /*
>   * Exported functions for interfaces called from assembly or from generated
>   * code. Declarations here to avoid warning about missing declarations.
> -- 
> 2.29.2.299.gdc1121823c-goog
> 
