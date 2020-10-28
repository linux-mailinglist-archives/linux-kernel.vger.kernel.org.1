Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAC729DAC6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgJ1XbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390353AbgJ1X3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:29:16 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A062C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:29:16 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l2so673533qkf.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OCUxgFfsZm5hmmiU0cs7ogr7Bp2NfxesKIPOcc2vAD8=;
        b=hMNvDItCFow179z1oxcHvXX45C4OvX0NHNzQYXw3NOLZRdKOHb7/k8PJHkRXA1QFJl
         pk4gDtrKVkv+68G5uSD3zOid4BSZRsEsQi5HePycxB6Udp4BL/tC3yDZhkgvdxnz3UD2
         BwtSfod1QwR5YHWuaScvBUFj66f8gr4LjNSq5BH3m+fTh4bYBvrERiJBrvNWldI7X6kB
         Jt4Rj64I7XLd3+I0cjjD0cDdy+Q6Maa8sovvdg7tKV6G2GnT8J/cO/WmtP97mpVxmd5G
         97dp2HRrG3vu3e+B1uea5tM11zQcDL7TffkUpNymvHZ/0SnvvyzkUpL6pza1VunZwUee
         8qoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCUxgFfsZm5hmmiU0cs7ogr7Bp2NfxesKIPOcc2vAD8=;
        b=D+qxWwigs8A3vO8clpTI/wmWk3Tf1pM+FgiK7J7OFVNth16fUE/DPkQMgYDTogVpPB
         4C1+2L9smDaEbvAauRvb0MJU8E+wgV6oaLzLfbJtwhy6Zt6mPTui9mjqDJMb7eSQnpTO
         YbuMedlLGAdtt3Q8BbW+JK+OgUeun2LuVfYxqbRFAS3txi7i8mLdzAK3YDrjTaUTWRng
         0drAnRXj4JCf3kFPnKjgCJtjxFfOyQjo6SO3GvUFLW5N98lK/7cNW+dQPKe0Hi4TFrsK
         Fsx23R80dQCiNc8jc+5vfB+Bdvf5ka4E625xEE2H5xvkJDoyhYkonwo3CPVKtdAiClSd
         nTdw==
X-Gm-Message-State: AOAM531BWpNh0G/wV44euRUDcsk3svqiFh8Pl5E6Z9RKwGbHysdsLLLo
        LXoQ8hTHFJqD1tYHNfB4LfqF3LQoBb0blAJYWA40rMSZ5H4IwQ==
X-Google-Smtp-Source: ABdhPJwkWF7ICS/T3u9QAuLg00nKns5VS6z2SJ/Sxr55S1s/LWN6PMgsgimncWAvlLi6nA80amMcWtDJanh/ewW5rgQ=
X-Received: by 2002:a37:a00c:: with SMTP id j12mr931915qke.231.1603884553300;
 Wed, 28 Oct 2020 04:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <a3cd7d83cc1f9ca06ef6d8c84e70f122212bf8ef.1603372719.git.andreyknvl@google.com>
In-Reply-To: <a3cd7d83cc1f9ca06ef6d8c84e70f122212bf8ef.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 12:29:02 +0100
Message-ID: <CACT4Y+ZXp1+_EV5=1Zwf4LCi+RR1tiRYesTsjhFBdZ5owrSCZw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 11/21] kasan: inline kasan_poison_memory and check_invalid_free
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 3:19 PM 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Using kasan_poison_memory() or check_invalid_free() currently results in
> function calls. Move their definitions to mm/kasan/kasan.h and turn them
> into static inline functions for hardware tag-based mode to avoid uneeded
> function calls.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Ia9d8191024a12d1374675b3d27197f10193f50bb

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  mm/kasan/hw_tags.c | 15 ---------------
>  mm/kasan/kasan.h   | 28 ++++++++++++++++++++++++----
>  2 files changed, 24 insertions(+), 19 deletions(-)
>
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 4c24bfcfeff9..f03161f3da19 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -24,27 +24,12 @@ void __init kasan_init_tags(void)
>         pr_info("KernelAddressSanitizer initialized\n");
>  }
>
> -void kasan_poison_memory(const void *address, size_t size, u8 value)
> -{
> -       set_mem_tag_range(reset_tag(address),
> -                         round_up(size, KASAN_GRANULE_SIZE), value);
> -}
> -
>  void kasan_unpoison_memory(const void *address, size_t size)
>  {
>         set_mem_tag_range(reset_tag(address),
>                           round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
>  }
>
> -bool check_invalid_free(void *addr)
> -{
> -       u8 ptr_tag = get_tag(addr);
> -       u8 mem_tag = get_mem_tag(addr);
> -
> -       return (mem_tag == KASAN_TAG_INVALID) ||
> -               (ptr_tag != KASAN_TAG_KERNEL && ptr_tag != mem_tag);
> -}
> -
>  void kasan_set_free_info(struct kmem_cache *cache,
>                                 void *object, u8 tag)
>  {
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 94ba15c2f860..8d84ae6f58f1 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -153,8 +153,6 @@ struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
>  struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
>                                                 const void *object);
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
> @@ -276,6 +272,30 @@ static inline u8 random_tag(void)
>  }
>  #endif
>
> +#ifdef CONFIG_KASAN_HW_TAGS
> +
> +static inline void kasan_poison_memory(const void *address, size_t size, u8 value)
> +{
> +       set_mem_tag_range(reset_tag(address),
> +                         round_up(size, KASAN_GRANULE_SIZE), value);
> +}
> +
> +static inline bool check_invalid_free(void *addr)
> +{
> +       u8 ptr_tag = get_tag(addr);
> +       u8 mem_tag = get_mem_tag(addr);
> +
> +       return (mem_tag == KASAN_TAG_INVALID) ||
> +               (ptr_tag != KASAN_TAG_KERNEL && ptr_tag != mem_tag);
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
> 2.29.0.rc1.297.gfa9743e501-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/a3cd7d83cc1f9ca06ef6d8c84e70f122212bf8ef.1603372719.git.andreyknvl%40google.com.
