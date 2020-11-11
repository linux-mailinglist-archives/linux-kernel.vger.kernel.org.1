Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1912AF718
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgKKRCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgKKRCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:02:22 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7C0C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:02:21 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id b6so3231306wrt.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X24sjVNgpxyUWyZmmGXSuDW61sfZW/dMlYXC795Q6f4=;
        b=C0lPrtGZD/j/Sfgz9VA8o53jywhNyVbrWkPXdinU7hgJCKm0EfQnx6aGcg9xzg6DGw
         wTdDu7zwV4uj3yxmK0/ksmxnQYA058iX/CpFPyp9CGjYSu+akHSdsIPdnbBGCuw0TeqJ
         bCd5MOxtNLyy/zAbzHSDWmig27i1mnqQpJNsXCt2YFtsjDnIN/szdxPuOhJv9FnkgUjo
         s0dOveQRdPcCPW7izH/aKuZSc7yPS7tz4QmEKtilZVGP9kRnfE0tfUpV7iSc8dI7gdXQ
         Tr1bJkr9N0lZOorDgxm6XyiJnEOSeXxtyjrPEVM183XhNK4R5fjUovdKJ0oFM/+1YNbS
         XHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X24sjVNgpxyUWyZmmGXSuDW61sfZW/dMlYXC795Q6f4=;
        b=TznkStGxbn2laiPSTeqW7LOx4CS/yik+EefZvqt56b44Qq8B6QgH+CFIqRFB9TKuCP
         duo/xAnO+AwzlmDaTDriRxzzCf7Gub5GGcrI3NpV968cJLfvnSdDTB3xxXx8/Sfp44aR
         TkiRh92MfBQM7vi/N7ZI3ITWI3Zkk3sPPGBFhZMZxmSjBtr09gaHAOrb9KTfwUmSdVyq
         /h5ZfcajKgkzgMOed4ojINd8YbLyHsvE7stBGAUn8RfvPRrrJdmNIVKPkPls9dmpPqbX
         Myt9uB/+YQi7z0PTHSuGtdFJXBhmsaHoavVZJlYk6DIQ3VOQM33+mDJmS9z+6xSjkTaj
         TkHg==
X-Gm-Message-State: AOAM530cnBBlToRyWWh6IIGT6O5shCc6QefZl0tZnGqeFApyuwLlUY85
        8AtELU5lGgnQKInPTuOCTQVvQQ==
X-Google-Smtp-Source: ABdhPJxGRYXeGNoPTHvyCyyaZirkOH54BZZpF1BtiSeGtu4yeREI8jYsqxEywTX4MOTQ8d12x0O59A==
X-Received: by 2002:adf:e484:: with SMTP id i4mr18558640wrm.398.1605114140431;
        Wed, 11 Nov 2020 09:02:20 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id i11sm3321276wro.85.2020.11.11.09.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 09:02:19 -0800 (PST)
Date:   Wed, 11 Nov 2020 18:02:13 +0100
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
Subject: Re: [PATCH v2 08/20] kasan: inline random_tag for HW_TAGS
Message-ID: <20201111170213.GJ517454@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <73399d4c0644266d61ad81eb391f5ee10c09e098.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73399d4c0644266d61ad81eb391f5ee10c09e098.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> Using random_tag() currently results in a function call. Move its
> definition to mm/kasan/kasan.h and turn it into a static inline function
> for hardware tag-based mode to avoid uneeded function calls.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Iac5b2faf9a912900e16cca6834d621f5d4abf427
> ---
>  mm/kasan/hw_tags.c |  5 -----
>  mm/kasan/kasan.h   | 34 +++++++++++++++++-----------------
>  2 files changed, 17 insertions(+), 22 deletions(-)

Reviewed-by: Marco Elver <elver@google.com>

But see style comments below.

> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 49ea5f5c5643..1476ac07666e 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -42,11 +42,6 @@ void kasan_unpoison_memory(const void *address, size_t size)
>  			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
>  }
>  
> -u8 random_tag(void)
> -{
> -	return hw_get_random_tag();
> -}
> -
>  bool check_invalid_free(void *addr)
>  {
>  	u8 ptr_tag = get_tag(addr);
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 8a5501ef2339..7498839a15d3 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -188,6 +188,12 @@ static inline bool addr_has_metadata(const void *addr)
>  
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>  
> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> +void print_tags(u8 addr_tag, const void *addr);
> +#else
> +static inline void print_tags(u8 addr_tag, const void *addr) { }
> +#endif
> +
>  bool check_invalid_free(void *addr);
>  
>  void *find_first_bad_addr(void *addr, size_t size);
> @@ -223,23 +229,6 @@ static inline void quarantine_reduce(void) { }
>  static inline void quarantine_remove_cache(struct kmem_cache *cache) { }
>  #endif
>  
> -#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> -
> -void print_tags(u8 addr_tag, const void *addr);
> -
> -u8 random_tag(void);
> -
> -#else
> -
> -static inline void print_tags(u8 addr_tag, const void *addr) { }
> -
> -static inline u8 random_tag(void)
> -{
> -	return 0;
> -}
> -
> -#endif
> -
>  #ifndef arch_kasan_set_tag
>  static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  {
> @@ -279,6 +268,17 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  
>  #endif /* CONFIG_KASAN_HW_TAGS */
>  
> +#ifdef CONFIG_KASAN_SW_TAGS
> +u8 random_tag(void);
> +#elif defined(CONFIG_KASAN_HW_TAGS)
> +#define random_tag() hw_get_random_tag()

Shouldn't this also be a function?

+static inline u8 random_tag(void) { return hw_get_random_tag(); }

Or is there a reason why this was made a macro?

> +#else
> +static inline u8 random_tag(void)
> +{
> +	return 0;
> +}

Could just be on 1 line:

+static inline u8 random_tag(void) { return 0; }

> +#endif
> +
>  /*
>   * Exported functions for interfaces called from assembly or from generated
>   * code. Declarations here to avoid warning about missing declarations.
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 
