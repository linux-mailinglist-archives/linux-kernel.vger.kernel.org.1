Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8132E2AF6FD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgKKQzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgKKQzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:55:01 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17A5C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:55:00 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id j7so3212763wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OrzYDM8svlnj5hHY+u0nDuLQxqJ3IUm9fI7fqLn+JR4=;
        b=nmgpixr7TQcfSpLeX7EBSjatykOIgcRi6jIwa2Cnv4kpT/6Xc+TNBbeJdA/YR2RsTM
         bxuNFKs8wK0WK7ZEQEzu/PWX5njPJDewgHT/NUJVtfmv9GCdHjMXqDU/Br1ui6FYtd9q
         iydNeZWSU7eZJKsfwZG7mGlZyDNCUeprixAX9bcYqpi3roIxq4p4GHoe8j918JAKjike
         Z2QS3aQ6SXJQrk7cWQ0rq3FLAYy42LwykLmuG0efhqvZUitFiYLzviMHpXHoMgskLhRD
         p2wgo6jSjFNM5Z/i30OlNs4WzlbGN8+A29tSuUVIKQ/9Q2D1aHw212lF/WXTkLqcPgpc
         1hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OrzYDM8svlnj5hHY+u0nDuLQxqJ3IUm9fI7fqLn+JR4=;
        b=HnaubFDfGZa3lh81Gjjxm/vuoEIMqxFY6GOCQieAxfnZ1pKqYwhRIhH+z2QWeE6PMb
         On0WmpYky5M83eN6WnEHYovkwtMxm8v8X2blHNBdHPOKVLOBGUP8P7lSwQu+FzmubDa5
         5zxjiga37zd6/CfYEb7tAP1cAMMs/BAnA83lxsMLuShRzLix3XOY9FITOgl5N38vbC7t
         XDwFYxofWBhCrfBNmQA+QDf5e4+51viM1Sx1/IRWiyIZ1XuX7lkIO1eHBLKsy3VQcFGy
         Y4hyRs6jZjj4jugJ/IPIEFWzQE5QfT99IDQLx3eLoO05WLVPK6bgO5UgWNnZdejyO3zv
         795A==
X-Gm-Message-State: AOAM530XbrIQXtQgz+CFYGA2Y59FSR90v4p8YBJHZAyly1jzFAdueCbL
        ouw44IOrmKl7WchCI14y+njrGw==
X-Google-Smtp-Source: ABdhPJyNx1VvORBnMwVAByjb8ipGJUMdGVWt8clrxDGcqRyXQ1S2kTw9LdV6nCEcngDdAVK+jUhmTg==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr20421341wrw.221.1605113699452;
        Wed, 11 Nov 2020 08:54:59 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id v19sm3148470wmj.31.2020.11.11.08.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:54:58 -0800 (PST)
Date:   Wed, 11 Nov 2020 17:54:53 +0100
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
Subject: Re: [PATCH v2 07/20] kasan: inline kasan_reset_tag for tag-based
 modes
Message-ID: <20201111165453.GI517454@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <ceba8fba477518e5dc26b77bc395c264cd1e593a.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceba8fba477518e5dc26b77bc395c264cd1e593a.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> Using kasan_reset_tag() currently results in a function call. As it's
> called quite often from the allocator code, this leads to a noticeable
> slowdown. Move it to include/linux/kasan.h and turn it into a static
> inline function. Also remove the now unneeded reset_tag() internal KASAN
> macro and use kasan_reset_tag() instead.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I4d2061acfe91d480a75df00b07c22d8494ef14b5
> ---
>  include/linux/kasan.h     | 5 ++++-
>  mm/kasan/common.c         | 6 +++---
>  mm/kasan/hw_tags.c        | 9 ++-------
>  mm/kasan/kasan.h          | 4 ----
>  mm/kasan/report.c         | 4 ++--
>  mm/kasan/report_hw_tags.c | 2 +-
>  mm/kasan/report_sw_tags.c | 4 ++--
>  mm/kasan/shadow.c         | 4 ++--
>  mm/kasan/sw_tags.c        | 9 ++-------
>  9 files changed, 18 insertions(+), 29 deletions(-)

Reviewed-by: Marco Elver <elver@google.com>

> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index b9b9db335d87..53c8e8b12fbc 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -193,7 +193,10 @@ static inline void kasan_record_aux_stack(void *ptr) {}
>  
>  #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
>  
> -void *kasan_reset_tag(const void *addr);
> +static inline void *kasan_reset_tag(const void *addr)
> +{
> +	return (void *)arch_kasan_reset_tag(addr);
> +}
>  
>  bool kasan_report(unsigned long addr, size_t size,
>  		bool is_write, unsigned long ip);
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 9008fc6b0810..a266b90636a1 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -174,14 +174,14 @@ size_t kasan_metadata_size(struct kmem_cache *cache)
>  struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
>  					      const void *object)
>  {
> -	return (void *)reset_tag(object) + cache->kasan_info.alloc_meta_offset;
> +	return kasan_reset_tag(object) + cache->kasan_info.alloc_meta_offset;
>  }
>  
>  struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
>  					    const void *object)
>  {
>  	BUILD_BUG_ON(sizeof(struct kasan_free_meta) > 32);
> -	return (void *)reset_tag(object) + cache->kasan_info.free_meta_offset;
> +	return kasan_reset_tag(object) + cache->kasan_info.free_meta_offset;
>  }
>  
>  void kasan_poison_slab(struct page *page)
> @@ -278,7 +278,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>  
>  	tag = get_tag(object);
>  	tagged_object = object;
> -	object = reset_tag(object);
> +	object = kasan_reset_tag(object);
>  
>  	if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
>  	    object)) {
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 70b88dd40cd8..49ea5f5c5643 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -30,20 +30,15 @@ void kasan_init_hw_tags(void)
>  	pr_info("KernelAddressSanitizer initialized\n");
>  }
>  
> -void *kasan_reset_tag(const void *addr)
> -{
> -	return reset_tag(addr);
> -}
> -
>  void kasan_poison_memory(const void *address, size_t size, u8 value)
>  {
> -	hw_set_mem_tag_range(reset_tag(address),
> +	hw_set_mem_tag_range(kasan_reset_tag(address),
>  			round_up(size, KASAN_GRANULE_SIZE), value);
>  }
>  
>  void kasan_unpoison_memory(const void *address, size_t size)
>  {
> -	hw_set_mem_tag_range(reset_tag(address),
> +	hw_set_mem_tag_range(kasan_reset_tag(address),
>  			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
>  }
>  
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index db8a7a508121..8a5501ef2339 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -246,15 +246,11 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  	return addr;
>  }
>  #endif
> -#ifndef arch_kasan_reset_tag
> -#define arch_kasan_reset_tag(addr)	((void *)(addr))
> -#endif
>  #ifndef arch_kasan_get_tag
>  #define arch_kasan_get_tag(addr)	0
>  #endif
>  
>  #define set_tag(addr, tag)	((void *)arch_kasan_set_tag((addr), (tag)))
> -#define reset_tag(addr)		((void *)arch_kasan_reset_tag(addr))
>  #define get_tag(addr)		arch_kasan_get_tag(addr)
>  
>  #ifdef CONFIG_KASAN_HW_TAGS
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 0cac53a57c14..25ca66c99e48 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -328,7 +328,7 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
>  	unsigned long flags;
>  	u8 tag = get_tag(object);
>  
> -	object = reset_tag(object);
> +	object = kasan_reset_tag(object);
>  
>  #if IS_ENABLED(CONFIG_KUNIT)
>  	if (current->kunit_test)
> @@ -361,7 +361,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>  	disable_trace_on_warning();
>  
>  	tagged_addr = (void *)addr;
> -	untagged_addr = reset_tag(tagged_addr);
> +	untagged_addr = kasan_reset_tag(tagged_addr);
>  
>  	info.access_addr = tagged_addr;
>  	if (addr_has_metadata(untagged_addr))
> diff --git a/mm/kasan/report_hw_tags.c b/mm/kasan/report_hw_tags.c
> index da543eb832cd..57114f0e14d1 100644
> --- a/mm/kasan/report_hw_tags.c
> +++ b/mm/kasan/report_hw_tags.c
> @@ -22,7 +22,7 @@ const char *get_bug_type(struct kasan_access_info *info)
>  
>  void *find_first_bad_addr(void *addr, size_t size)
>  {
> -	return reset_tag(addr);
> +	return kasan_reset_tag(addr);
>  }
>  
>  void metadata_fetch_row(char *buffer, void *row)
> diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
> index 317100fd95b9..7604b46239d4 100644
> --- a/mm/kasan/report_sw_tags.c
> +++ b/mm/kasan/report_sw_tags.c
> @@ -41,7 +41,7 @@ const char *get_bug_type(struct kasan_access_info *info)
>  	int i;
>  
>  	tag = get_tag(info->access_addr);
> -	addr = reset_tag(info->access_addr);
> +	addr = kasan_reset_tag(info->access_addr);
>  	page = kasan_addr_to_page(addr);
>  	if (page && PageSlab(page)) {
>  		cache = page->slab_cache;
> @@ -72,7 +72,7 @@ const char *get_bug_type(struct kasan_access_info *info)
>  void *find_first_bad_addr(void *addr, size_t size)
>  {
>  	u8 tag = get_tag(addr);
> -	void *p = reset_tag(addr);
> +	void *p = kasan_reset_tag(addr);
>  	void *end = p + size;
>  
>  	while (p < end && tag == *(u8 *)kasan_mem_to_shadow(p))
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 616ac64c4a21..8e4fa9157a0b 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -81,7 +81,7 @@ void kasan_poison_memory(const void *address, size_t size, u8 value)
>  	 * some of the callers (e.g. kasan_poison_object_data) pass tagged
>  	 * addresses to this function.
>  	 */
> -	address = reset_tag(address);
> +	address = kasan_reset_tag(address);
>  
>  	shadow_start = kasan_mem_to_shadow(address);
>  	shadow_end = kasan_mem_to_shadow(address + size);
> @@ -98,7 +98,7 @@ void kasan_unpoison_memory(const void *address, size_t size)
>  	 * some of the callers (e.g. kasan_unpoison_object_data) pass tagged
>  	 * addresses to this function.
>  	 */
> -	address = reset_tag(address);
> +	address = kasan_reset_tag(address);
>  
>  	kasan_poison_memory(address, size, tag);
>  
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index 3bffb489b144..d1af6f6c6d12 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -67,11 +67,6 @@ u8 random_tag(void)
>  	return (u8)(state % (KASAN_TAG_MAX + 1));
>  }
>  
> -void *kasan_reset_tag(const void *addr)
> -{
> -	return reset_tag(addr);
> -}
> -
>  bool check_memory_region(unsigned long addr, size_t size, bool write,
>  				unsigned long ret_ip)
>  {
> @@ -107,7 +102,7 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
>  	if (tag == KASAN_TAG_KERNEL)
>  		return true;
>  
> -	untagged_addr = reset_tag((const void *)addr);
> +	untagged_addr = kasan_reset_tag((const void *)addr);
>  	if (unlikely(untagged_addr <
>  			kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
>  		return !kasan_report(addr, size, write, ret_ip);
> @@ -126,7 +121,7 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
>  bool check_invalid_free(void *addr)
>  {
>  	u8 tag = get_tag(addr);
> -	u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(reset_tag(addr)));
> +	u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(kasan_reset_tag(addr)));
>  
>  	return (shadow_byte == KASAN_TAG_INVALID) ||
>  		(tag != KASAN_TAG_KERNEL && tag != shadow_byte);
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 
