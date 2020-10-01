Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82252805A6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbgJARlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJARlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:41:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CECBC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:41:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 13so280785wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JNSzrX1KLD1Jr1oOxkhpqopu9WU4zuQEXx0vLg9N7lY=;
        b=MdZ/sCH3xh0w9UUKmanUc9Xe+mqlnro58R6Uo+Lv+kn2vFbKxkxif97MOYmm9t331r
         4n9gD00qL/ZoRi80xA1WmiKAGy36oUwLFQE3N9mqypR1zWs0t6r/E65uiatCFniZ3dKW
         fvFn2XQl8bQYUVctr6+9vQ5FNnuLDo5B4maYIcMYWJ39Eoxx7ljE5zn5kEYDJzU47H+Y
         +BJQ5Oig+VCJgPEYSTrKmfmigomEBFWOiZjHuK+z6oJJxaVlnXGOY8K2TCo+jt2TEIMd
         UZ7YDtYsNZSdfEkFHbE33Ye5FCu42ttNg7XSfzAQgFjoTCisu/ewbcI+oxHxcNgZ1SiU
         lm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JNSzrX1KLD1Jr1oOxkhpqopu9WU4zuQEXx0vLg9N7lY=;
        b=uFlQltdFp34MSXBwiV3y3ekrcOZ//Av8G50TNqIB0ml8i03QUR4X5qbiuaTquVzQcG
         gW/gT56Ar9LvNI5zGOSDlzCra/a9Ba7fZk/FIt4t+cNX3XSeRnqWW3XjqAhqzAbtxHJE
         ubKseq6/5aafoOSe03W4ejw+pHiNj6WRvDVPXuH7IFTgkBOFFHhAoc5RB2xnLj+x3PHy
         MB6DTUIs8wODjmbI4GHDakZEI4JlOS8sRYDwjTeV7i30iXb5hOlHtK5GYcxHlyvnFVyn
         yDs34adYDW74H/libBeqrNx0rEMm1etTUV1LiWO5kFsH5ERu2kk5jqJniT21ELmGVIqu
         QQAg==
X-Gm-Message-State: AOAM531BXhT4OxQCwaTBMEBbf/KTovnbggxWj49nrRArT1EC20Hhrh8I
        TX2YsBqL4wOLKCyGPK2F01DsyQ==
X-Google-Smtp-Source: ABdhPJzwnwzJnMgKsKalkMf3OQd8SSpXBYLSSSq9+hwnSkHAuKWm0BA+npu3vPeoPmiM2mwBja5JEw==
X-Received: by 2002:a1c:5685:: with SMTP id k127mr1161718wmb.135.1601574068516;
        Thu, 01 Oct 2020 10:41:08 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id o194sm1074973wme.24.2020.10.01.10.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:41:07 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:41:02 +0200
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
Subject: Re: [PATCH v3 12/39] kasan: hide invalid free check implementation
Message-ID: <20201001174102.GJ4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <c1cef2ae4f4c5640afc8aac4339d77d140d45304.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1cef2ae4f4c5640afc8aac4339d77d140d45304.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
> 
> For software KASAN modes the check is based on the value in the shadow
> memory. Hardware tag-based KASAN won't be using shadow, so hide the
> implementation of the check in check_invalid_free().
> 
> Also simplify the code for software tag-based mode.
> 
> No functional changes for software modes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: I5fae9531c9fc948eb4d4e0c589744032fc5a0789
> ---
>  mm/kasan/common.c  | 19 +------------------
>  mm/kasan/generic.c |  7 +++++++
>  mm/kasan/kasan.h   |  2 ++
>  mm/kasan/sw_tags.c |  9 +++++++++
>  4 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 123abfb760d4..543e6bf2168f 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -272,25 +272,9 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
>  	return (void *)object;
>  }
>  
> -static inline bool shadow_invalid(u8 tag, s8 shadow_byte)
> -{
> -	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> -		return shadow_byte < 0 ||
> -			shadow_byte >= KASAN_GRANULE_SIZE;
> -
> -	/* else CONFIG_KASAN_SW_TAGS: */
> -	if ((u8)shadow_byte == KASAN_TAG_INVALID)
> -		return true;
> -	if ((tag != KASAN_TAG_KERNEL) && (tag != (u8)shadow_byte))
> -		return true;
> -
> -	return false;
> -}
> -
>  static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>  			      unsigned long ip, bool quarantine)
>  {
> -	s8 shadow_byte;
>  	u8 tag;
>  	void *tagged_object;
>  	unsigned long rounded_up_size;
> @@ -309,8 +293,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>  	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
>  		return false;
>  
> -	shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(object));
> -	if (shadow_invalid(tag, shadow_byte)) {
> +	if (check_invalid_free(tagged_object)) {
>  		kasan_report_invalid_free(tagged_object, ip);
>  		return true;
>  	}
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index ec4417156943..e1af3b6c53b8 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -187,6 +187,13 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
>  	return check_memory_region_inline(addr, size, write, ret_ip);
>  }
>  
> +bool check_invalid_free(void *addr)
> +{
> +	s8 shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(addr));
> +
> +	return shadow_byte < 0 || shadow_byte >= KASAN_GRANULE_SIZE;
> +}
> +
>  void kasan_cache_shrink(struct kmem_cache *cache)
>  {
>  	quarantine_remove_cache(cache);
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 1865bb92d47a..3eff57e71ff5 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -164,6 +164,8 @@ void kasan_poison_memory(const void *address, size_t size, u8 value);
>  bool check_memory_region(unsigned long addr, size_t size, bool write,
>  				unsigned long ret_ip);
>  
> +bool check_invalid_free(void *addr);
> +
>  void *find_first_bad_addr(void *addr, size_t size);
>  const char *get_bug_type(struct kasan_access_info *info);
>  
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index 4bdd7dbd6647..b2638c2cd58a 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -121,6 +121,15 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
>  	return true;
>  }
>  
> +bool check_invalid_free(void *addr)
> +{
> +	u8 tag = get_tag(addr);
> +	u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(reset_tag(addr)));
> +
> +	return (shadow_byte == KASAN_TAG_INVALID) ||
> +		(tag != KASAN_TAG_KERNEL && tag != shadow_byte);
> +}
> +
>  #define DEFINE_HWASAN_LOAD_STORE(size)					\
>  	void __hwasan_load##size##_noabort(unsigned long addr)		\
>  	{								\
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
