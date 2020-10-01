Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1226A28062D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733011AbgJASDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 14:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbgJASDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:03:37 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDBCC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 11:03:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id s13so3828012wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4RuJhY/87VL3JhPEf+faiXyRb2FdU2wNNWjiTAoQeOk=;
        b=g857Ar4OsKkfvKJF2TeGJcsn2rzY1dIr/DaETOmxqkjGRsvrERpsZ1x0BXqG9/hwgp
         a74u3LiD8RkIwlbIEjQLlt6wGSecAk4o7qfoR6Ds8UO2dK88PYWOB/hmazDeRJDAA+BI
         Nfj7WVFZOY76x4b5/p2zJHgR/zkQ+zowJze7ZEiMnuHRKDT/jbT3Cfjlxcyki0PSfiK0
         vgPUSw5Zzi1rTfbHxIHGM2l9o2IWC0FgNoYqOo4v+ski0leEakl9n5UmBkE2X+jDFT/S
         8L3c6PiJXfzRiBA5JXaNFdzKBNJ2XsQr6ngC/h4st9mXATqasL8kkewWSYZwszEogLpc
         52Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4RuJhY/87VL3JhPEf+faiXyRb2FdU2wNNWjiTAoQeOk=;
        b=PSCzJ3shPgXSffSWrGVZqQuXp3SIQkL36iohtOwyGpPvxZsoPZsxPn+hf0VV1tvkZy
         OtXHDgDCvb4NfeDJvSce1LP+1PRD1zKUGJF7M/C6uTvQn+lu5J3CZgo+XogKDbQqyLAq
         dBKJDhwXHPHcibQXypER3sOEiJRDfoxEwGLyJo186gAt0leS9M/RdvBI+20Xv/bbL1mL
         vNGCRmu7KTSrLSDIfiRVvN0VYbuEywpkM7btoscLOZ4ba6CYkB1E4SmKZGiqx6X2konx
         Z6PXQoxN7eu0s+AOB477L8OdsuWzjPPvmeRH9YHGi1K5ZTQsqhciGXG+ophTu7rc2JrP
         opvA==
X-Gm-Message-State: AOAM530+qA6SC/df26obaTM8wR5S27YMX7c8Ya8t4DGM8+UtPxLRsaGu
        7kkAqv3dxNYWrQ+mRcZ1FAWhnA==
X-Google-Smtp-Source: ABdhPJw7xuBgltMVA48qRrl2OpqGXsDqBxsHXhWfgM2MZ/UBkevUn68H+Zo3O/HFZuEwfmRkQZH0XQ==
X-Received: by 2002:a1c:b7d7:: with SMTP id h206mr1284905wmf.159.1601575415423;
        Thu, 01 Oct 2020 11:03:35 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id t4sm10525373wrr.26.2020.10.01.11.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 11:03:34 -0700 (PDT)
Date:   Thu, 1 Oct 2020 20:03:29 +0200
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
Subject: Re: [PATCH v3 37/39] kasan, slub: reset tags when accessing metadata
Message-ID: <20201001180329.GV4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <a9229404628ab379bc74010125333f110771d4b6.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9229404628ab379bc74010125333f110771d4b6.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> SLUB allocator accesses metadata for slab objects, that may lie
> out-of-bounds of the object itself, or be accessed when an object is freed.
> Such accesses trigger tag faults and lead to false-positive reports with
> hardware tag-based KASAN.
> 
> Software KASAN modes disable instrumentation for allocator code via
> KASAN_SANITIZE Makefile macro, and rely on kasan_enable/disable_current()
> annotations which are used to ignore KASAN reports.
> 
> With hardware tag-based KASAN neither of those options are available, as
> it doesn't use compiler instrumetation, no tag faults are ignored, and MTE
> is disabled after the first one.
> 
> Instead, reset tags when accessing metadata.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Acked-by: Marco Elver <elver@google.com>

I assume you have tested with the various SLUB debug options, as well as
things like memory initialization etc?

> ---
> Change-Id: I39f3c4d4f29299d4fbbda039bedf230db1c746fb
> ---
>  mm/page_poison.c |  2 +-
>  mm/slub.c        | 25 ++++++++++++++-----------
>  2 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/page_poison.c b/mm/page_poison.c
> index 34b9181ee5d1..d90d342a391f 100644
> --- a/mm/page_poison.c
> +++ b/mm/page_poison.c
> @@ -43,7 +43,7 @@ static void poison_page(struct page *page)
>  
>  	/* KASAN still think the page is in-use, so skip it. */
>  	kasan_disable_current();
> -	memset(addr, PAGE_POISON, PAGE_SIZE);
> +	memset(kasan_reset_tag(addr), PAGE_POISON, PAGE_SIZE);
>  	kasan_enable_current();
>  	kunmap_atomic(addr);
>  }
> diff --git a/mm/slub.c b/mm/slub.c
> index 68c02b2eecd9..f5b4bef3cd6c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -249,7 +249,7 @@ static inline void *freelist_ptr(const struct kmem_cache *s, void *ptr,
>  {
>  #ifdef CONFIG_SLAB_FREELIST_HARDENED
>  	/*
> -	 * When CONFIG_KASAN_SW_TAGS is enabled, ptr_addr might be tagged.
> +	 * When CONFIG_KASAN_SW/HW_TAGS is enabled, ptr_addr might be tagged.
>  	 * Normally, this doesn't cause any issues, as both set_freepointer()
>  	 * and get_freepointer() are called with a pointer with the same tag.
>  	 * However, there are some issues with CONFIG_SLUB_DEBUG code. For
> @@ -275,6 +275,7 @@ static inline void *freelist_dereference(const struct kmem_cache *s,
>  
>  static inline void *get_freepointer(struct kmem_cache *s, void *object)
>  {
> +	object = kasan_reset_tag(object);
>  	return freelist_dereference(s, object + s->offset);
>  }
>  
> @@ -304,6 +305,7 @@ static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
>  	BUG_ON(object == fp); /* naive detection of double free or corruption */
>  #endif
>  
> +	freeptr_addr = (unsigned long)kasan_reset_tag((void *)freeptr_addr);
>  	*(void **)freeptr_addr = freelist_ptr(s, fp, freeptr_addr);
>  }
>  
> @@ -538,8 +540,8 @@ static void print_section(char *level, char *text, u8 *addr,
>  			  unsigned int length)
>  {
>  	metadata_access_enable();
> -	print_hex_dump(level, text, DUMP_PREFIX_ADDRESS, 16, 1, addr,
> -			length, 1);
> +	print_hex_dump(level, kasan_reset_tag(text), DUMP_PREFIX_ADDRESS,
> +			16, 1, addr, length, 1);
>  	metadata_access_disable();
>  }
>  
> @@ -570,7 +572,7 @@ static struct track *get_track(struct kmem_cache *s, void *object,
>  
>  	p = object + get_info_end(s);
>  
> -	return p + alloc;
> +	return kasan_reset_tag(p + alloc);
>  }
>  
>  static void set_track(struct kmem_cache *s, void *object,
> @@ -583,7 +585,8 @@ static void set_track(struct kmem_cache *s, void *object,
>  		unsigned int nr_entries;
>  
>  		metadata_access_enable();
> -		nr_entries = stack_trace_save(p->addrs, TRACK_ADDRS_COUNT, 3);
> +		nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
> +					      TRACK_ADDRS_COUNT, 3);
>  		metadata_access_disable();
>  
>  		if (nr_entries < TRACK_ADDRS_COUNT)
> @@ -747,7 +750,7 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
>  
>  static void init_object(struct kmem_cache *s, void *object, u8 val)
>  {
> -	u8 *p = object;
> +	u8 *p = kasan_reset_tag(object);
>  
>  	if (s->flags & SLAB_RED_ZONE)
>  		memset(p - s->red_left_pad, val, s->red_left_pad);
> @@ -777,7 +780,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
>  	u8 *addr = page_address(page);
>  
>  	metadata_access_enable();
> -	fault = memchr_inv(start, value, bytes);
> +	fault = memchr_inv(kasan_reset_tag(start), value, bytes);
>  	metadata_access_disable();
>  	if (!fault)
>  		return 1;
> @@ -873,7 +876,7 @@ static int slab_pad_check(struct kmem_cache *s, struct page *page)
>  
>  	pad = end - remainder;
>  	metadata_access_enable();
> -	fault = memchr_inv(pad, POISON_INUSE, remainder);
> +	fault = memchr_inv(kasan_reset_tag(pad), POISON_INUSE, remainder);
>  	metadata_access_disable();
>  	if (!fault)
>  		return 1;
> @@ -1118,7 +1121,7 @@ void setup_page_debug(struct kmem_cache *s, struct page *page, void *addr)
>  		return;
>  
>  	metadata_access_enable();
> -	memset(addr, POISON_INUSE, page_size(page));
> +	memset(kasan_reset_tag(addr), POISON_INUSE, page_size(page));
>  	metadata_access_disable();
>  }
>  
> @@ -2884,10 +2887,10 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
>  		stat(s, ALLOC_FASTPATH);
>  	}
>  
> -	maybe_wipe_obj_freeptr(s, object);
> +	maybe_wipe_obj_freeptr(s, kasan_reset_tag(object));
>  
>  	if (unlikely(slab_want_init_on_alloc(gfpflags, s)) && object)
> -		memset(object, 0, s->object_size);
> +		memset(kasan_reset_tag(object), 0, s->object_size);
>  
>  	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object);
>  
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
