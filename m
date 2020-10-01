Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B7428052D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbgJAR3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJAR3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:29:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23813C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:29:09 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y15so4017049wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iPaQCzihnyHNLy47NnUWbDr7GfchzwJLlA5r6ihLSYU=;
        b=I+gsOCjjdOcdrl0S25+QXcQmEOn5eVa7r50sBTVtz/w3lhgLaELA5MI6CfjmSQdhwi
         1+3Za2o2Q+HqdOLiRJ7MjQdLjQHkvUKSzQ+SPBYoONmZRBb1yzPdMIBLOE1HEE5fnLAA
         BQ8w08laAbz2fQVHMkoQ2oHk+WRiJSiy/g4/cycNeYIpfEq710BsL7OqSnhUtvri5mey
         kAPsYkq9nmGztS9NNvbO00ngqrQ0vK3QRNtX73q53Rk6fhsRl+ILTHwElJaTko7GuqXh
         Ss/aOCe77SpYX7k06JceIbLr174mxwekNf4+lbo13Id52IiC75tWRIb7TSu28rMy651R
         eGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iPaQCzihnyHNLy47NnUWbDr7GfchzwJLlA5r6ihLSYU=;
        b=TklOlBZxpZhV6Vfw7BS86w7f9WyhkokmBtsXxJUhaPuQb1X4Hrlpq5lrOi5YD0OeAB
         ssX+xlHW3KnotX7ROELY4JxojIe+aflEgIEve3ccPTlhl2ymJv4Jlm25AiKF1/nnZOhm
         xLttmdcVnw3dvbYllLm0/FSQFwT+Hz4JATOdNRSyX9pootc+u52JoZ0OrdvVb2R54Ai6
         iMbHZPj5kJ1jVd6PO/CcNzOSfE4sQq5FMupKdvUvrnYFIQ9lzwPxbobNmkJenJkqkBWV
         SPJEp/9e1Rf5poug3c39X1t/gXBprUwjkY1NSLXPoF37oPWfRY9XTiVTVYOEc8XAZa1W
         CRdQ==
X-Gm-Message-State: AOAM5315zd/DEAprpz2q9Pp+g+AnOZFulAFp8NfAwro9LaT4+dmsRO6o
        WOrMcWVb+IZGqEtT/+MlfZiOVA==
X-Google-Smtp-Source: ABdhPJzo235AsBkhXVYPH8dEYiNl0ar42N9voU6aVuWN/1aMLTuHt2yyhF3ju/2L0zAOuQgVIdxysg==
X-Received: by 2002:a1c:4c0d:: with SMTP id z13mr1011876wmf.113.1601573347642;
        Thu, 01 Oct 2020 10:29:07 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id m3sm9926381wrs.83.2020.10.01.10.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:29:06 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:29:01 +0200
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
Subject: Re: [PATCH v3 04/39] kasan: shadow declarations only for software
 modes
Message-ID: <20201001172901.GB4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <9de4c3b360444c66fcf454e0880fc655c5d80395.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9de4c3b360444c66fcf454e0880fc655c5d80395.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
> 
> Group shadow-related KASAN function declarations and only define them
> for the two existing software modes.
> 
> No functional changes for software modes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: I864be75a88b91b443c55e9c2042865e15703e164
> ---
>  include/linux/kasan.h | 44 ++++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index bd5b4965a269..44a9aae44138 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -3,16 +3,24 @@
>  #define _LINUX_KASAN_H
>  
>  #include <linux/types.h>
> +#include <asm/kasan.h>
>  
>  struct kmem_cache;
>  struct page;
>  struct vm_struct;
>  struct task_struct;
>  
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  
>  #include <linux/pgtable.h>
> -#include <asm/kasan.h>
> +
> +/* Software KASAN implementations use shadow memory. */
> +
> +#ifdef CONFIG_KASAN_SW_TAGS
> +#define KASAN_SHADOW_INIT 0xFF
> +#else
> +#define KASAN_SHADOW_INIT 0
> +#endif
>  
>  extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
>  extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
> @@ -29,6 +37,23 @@ static inline void *kasan_mem_to_shadow(const void *addr)
>  		+ KASAN_SHADOW_OFFSET;
>  }
>  
> +int kasan_add_zero_shadow(void *start, unsigned long size);
> +void kasan_remove_zero_shadow(void *start, unsigned long size);
> +
> +#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> +
> +static inline int kasan_add_zero_shadow(void *start, unsigned long size)
> +{
> +	return 0;
> +}
> +static inline void kasan_remove_zero_shadow(void *start,
> +					unsigned long size)
> +{}
> +
> +#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> +
> +#ifdef CONFIG_KASAN
> +
>  /* Enable reporting bugs after kasan_disable_current() */
>  extern void kasan_enable_current(void);
>  
> @@ -69,9 +94,6 @@ struct kasan_cache {
>  	int free_meta_offset;
>  };
>  
> -int kasan_add_zero_shadow(void *start, unsigned long size);
> -void kasan_remove_zero_shadow(void *start, unsigned long size);
> -
>  size_t __ksize(const void *);
>  static inline void kasan_unpoison_slab(const void *ptr)
>  {
> @@ -137,14 +159,6 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
>  	return false;
>  }
>  
> -static inline int kasan_add_zero_shadow(void *start, unsigned long size)
> -{
> -	return 0;
> -}
> -static inline void kasan_remove_zero_shadow(void *start,
> -					unsigned long size)
> -{}
> -
>  static inline void kasan_unpoison_slab(const void *ptr) { }
>  static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
>  
> @@ -152,8 +166,6 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
>  
>  #ifdef CONFIG_KASAN_GENERIC
>  
> -#define KASAN_SHADOW_INIT 0
> -
>  void kasan_cache_shrink(struct kmem_cache *cache);
>  void kasan_cache_shutdown(struct kmem_cache *cache);
>  void kasan_record_aux_stack(void *ptr);
> @@ -168,8 +180,6 @@ static inline void kasan_record_aux_stack(void *ptr) {}
>  
>  #ifdef CONFIG_KASAN_SW_TAGS
>  
> -#define KASAN_SHADOW_INIT 0xFF
> -
>  void kasan_init_tags(void);
>  
>  void *kasan_reset_tag(const void *addr);
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
