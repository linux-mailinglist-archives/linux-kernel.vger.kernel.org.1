Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBF62B5DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgKQK6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbgKQK6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:58:13 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A262C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:58:13 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id v143so19933753qkb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Jz410s78Ji+rZ5O7FNsycPBxAAt6VG4My0PmY/OfBI=;
        b=fDqno3OWElAqTjsKqJ+zxGI0TP7VkHHQ18I4rj8hb2q7NpNzhrmgAVKg5hA3xmMksY
         0+tji4xpEzSjkR7Xhrlg1HbLigM5Np5RNo637NRj1hbJKqq1ThPdVoYEldfSc3zXuznD
         SXc0GSnSZdQdqkyrq//gkeQgOL/vIlTy0uJxLMcsD1GuC8K4bZLzkGRTQ/HsTUW91tLg
         7K6wqgxvlkRDKaEYaCNpuUfExMTGQru5dB1MwKFCcrGvB7TWirhhAOBaZileEc2ttqRJ
         om+xd06jtPXK0LgOTn23XvDoKVnELczfPnnfIjXV9l9l1RK0Z7qZvngh8SeEmWqVFHgS
         4sRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Jz410s78Ji+rZ5O7FNsycPBxAAt6VG4My0PmY/OfBI=;
        b=DyEriZr632KoLFK76pnAHRL063nN82G41vPqbzJOJ/VO5/v9+E+2y0E13/vam7Ik/V
         auNFYb/rWmmSmfpFlysgG0L2vjk2QqGHXylJa4zUVtj3EfQmjKeyNFKmnFATF6giVIFa
         EloXAOBFfG6qMn3wdWfIHZDW3erycX0HsbxICi2aKm6mYnaXiogf49zq37/JvgCEdJc7
         yIJbfuPmQrbvBxAq5giwyGJ9zeJDiNFS7lJaxUpESYX0EcjVZLDRyoB7PoxTReLUVGKZ
         leeU31Dq8Fw+8vLBK2m3UF1rCC6oKL1ZYSDJEnxs1CC2KoOYhmEyzwu3tptUokC2WmAB
         y67Q==
X-Gm-Message-State: AOAM531N95U7Lf+iW+UxN4i+zcN+DD56FNNTso8q6ogqyYemOgO1Gkl6
        IoQM2dRBHlDpX5u6fU5MBH90ImkQq/ns6DXBT/K7uA==
X-Google-Smtp-Source: ABdhPJzOEnvk+cKL0XzmEKvnbDHMeXONdJ4hWIDnE4U7IwhAltThKlUJijIu5XRXmqmkW9pgOtkZfB1YWN7FrE+L9Js=
X-Received: by 2002:a37:7b44:: with SMTP id w65mr19464097qkc.350.1605610692298;
 Tue, 17 Nov 2020 02:58:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com> <d42cdd23c59501ccc4ab91cf4e04dd134be57277.1605305978.git.andreyknvl@google.com>
In-Reply-To: <d42cdd23c59501ccc4ab91cf4e04dd134be57277.1605305978.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 17 Nov 2020 11:58:01 +0100
Message-ID: <CACT4Y+aYcegV8ZqxYGa0PuK-J97Lh5jXoVyciHW0fuEJPzZBvA@mail.gmail.com>
Subject: Re: [PATCH mm v3 08/19] kasan: inline random_tag for HW_TAGS
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:20 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Using random_tag() currently results in a function call. Move its
> definition to mm/kasan/kasan.h and turn it into a static inline function
> for hardware tag-based mode to avoid uneeded function calls.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> Link: https://linux-review.googlesource.com/id/Iac5b2faf9a912900e16cca6834d621f5d4abf427
> ---
>  mm/kasan/hw_tags.c |  5 -----
>  mm/kasan/kasan.h   | 31 ++++++++++++++-----------------
>  2 files changed, 14 insertions(+), 22 deletions(-)
>
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index a34476764f1d..3cdd87d189f6 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -51,11 +51,6 @@ void unpoison_range(const void *address, size_t size)
>                         round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
>  }
>
> -u8 random_tag(void)
> -{
> -       return hw_get_random_tag();
> -}
> -
>  bool check_invalid_free(void *addr)
>  {
>         u8 ptr_tag = get_tag(addr);
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 5e8cd2080369..7876a2547b7d 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -190,6 +190,12 @@ static inline bool addr_has_metadata(const void *addr)
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
> @@ -225,23 +231,6 @@ static inline void quarantine_reduce(void) { }
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
> -       return 0;
> -}
> -
> -#endif
> -
>  #ifndef arch_kasan_set_tag
>  static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  {
> @@ -281,6 +270,14 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>
>  #endif /* CONFIG_KASAN_HW_TAGS */
>
> +#ifdef CONFIG_KASAN_SW_TAGS
> +u8 random_tag(void);
> +#elif defined(CONFIG_KASAN_HW_TAGS)
> +static inline u8 random_tag(void) { return hw_get_random_tag(); }
> +#else
> +static inline u8 random_tag(void) { return 0; }
> +#endif
> +
>  /*
>   * Exported functions for interfaces called from assembly or from generated
>   * code. Declarations here to avoid warning about missing declarations.
> --
> 2.29.2.299.gdc1121823c-goog
>
