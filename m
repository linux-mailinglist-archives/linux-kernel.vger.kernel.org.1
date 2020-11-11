Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE2B2AF208
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgKKNZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKNZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:25:15 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82202C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:25:15 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id b16so980586qtb.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lxMzMj/D4VM40jBrYMiztVpoEGAQUw5RwBN1Z96sbhM=;
        b=W2VqwyDslVmOcQeQWaDTcCrfP6LVQRfhinZFA/R9I36CXRJM8ng79ded5njEpNajDg
         oMSWsbk2jAFI0UErp9871SonwHoCGDF+iXTfroiZ3G4OZ73/0VN2ljiQAGlOg4U0IhmH
         5ml4pwZMsu+lSJvzExtLweP9pysH4HiRRAAj5MisCDNA9e8ggSeN04sVnBiOl2PU+OLh
         QfqEodaTeEXIzkFqsc9n1wqbG3NWGRnhL+DzKgcgWeOp+GiEe3OLqK4q3NGxFXoybktD
         rXYepg+8m/I7hgMlJyYhD9LlX6VyVki3rOvCG0dc5TAWkvAwX1++kHCe4u1MC9OzBgZN
         uXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lxMzMj/D4VM40jBrYMiztVpoEGAQUw5RwBN1Z96sbhM=;
        b=S2JfmZzfyXhRfSYDfraPod4xern4pXyDieC7T7qPgzA1nDhgavy07pD/oEufBh4yEe
         mvnS8MLFk09hzFlCgncm0dBvRv/aCCWFUCW5rpOe2tu0JsREyIJ3V5j5Tg2SmpCerBqy
         NMtMTuben5J06PM1xIh4Sne7I+VUwPJVtHpT11srFrweCL9HrueBGVtqeOB68vXWxneb
         pJJ0uCuzYokDCuRQyqiovWEpVRg1IuiSy9m0IUgmNb8Ef2SbxtKJv2N0x+fWAeUkn0yU
         qRHcLOYAbEskHbIYe3UgwsoNUiyrjY2H9fwrvYpLD1zhIHfjXHwd+JgSCHMzmzdVlavb
         5Xwg==
X-Gm-Message-State: AOAM533gbcTS409QRn3EgExNh8YlSG4+Q2XZPjrpMvmCVNlCJTdtQS1B
        9K7O3m/oi1DpM7EymjKmAAqchMtshE7vAmTtoTwIoQ==
X-Google-Smtp-Source: ABdhPJzZP8LufNZKkqyfvQftEsoHgigk7e7Ui/hYJEjxWJoUQLIPPesZuqSnRUCafXIq6dogg7NdlHgqwZ4WmjnR8HM=
X-Received: by 2002:ac8:454d:: with SMTP id z13mr20929301qtn.175.1605101114470;
 Wed, 11 Nov 2020 05:25:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <81fbf12c3455448b2bb4162dd9888d405ee0c00a.1605046192.git.andreyknvl@google.com>
In-Reply-To: <81fbf12c3455448b2bb4162dd9888d405ee0c00a.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 14:25:03 +0100
Message-ID: <CAG_fn=W0abFzRDhm1ArqqntZt5OLOLv_EjC1Z1j9KQnswH7cgA@mail.gmail.com>
Subject: Re: [PATCH v9 05/44] kasan: shadow declarations only for software modes
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:11 PM Andrey Konovalov <andreyknvl@google.com> w=
rote:
>
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
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: I864be75a88b91b443c55e9c2042865e15703e164
> ---
>  include/linux/kasan.h | 47 ++++++++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 59538e795df4..26f2ab92e7ca 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -11,7 +11,6 @@ struct task_struct;
>
>  #ifdef CONFIG_KASAN
>
> -#include <linux/pgtable.h>
>  #include <asm/kasan.h>
>
>  /* kasan_data struct is used in KUnit tests for KASAN expected failures =
*/
> @@ -20,6 +19,20 @@ struct kunit_kasan_expectation {
>         bool report_found;
>  };
>
> +#endif
> +
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> +
> +#include <linux/pgtable.h>
> +
> +/* Software KASAN implementations use shadow memory. */
> +
> +#ifdef CONFIG_KASAN_SW_TAGS
> +#define KASAN_SHADOW_INIT 0xFF
> +#else
> +#define KASAN_SHADOW_INIT 0
> +#endif
> +
>  extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
>  extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
>  extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
> @@ -35,6 +48,23 @@ static inline void *kasan_mem_to_shadow(const void *ad=
dr)
>                 + KASAN_SHADOW_OFFSET;
>  }
>
> +int kasan_add_zero_shadow(void *start, unsigned long size);
> +void kasan_remove_zero_shadow(void *start, unsigned long size);
> +
> +#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> +
> +static inline int kasan_add_zero_shadow(void *start, unsigned long size)
> +{
> +       return 0;
> +}
> +static inline void kasan_remove_zero_shadow(void *start,
> +                                       unsigned long size)
> +{}
> +
> +#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> +
> +#ifdef CONFIG_KASAN
> +
>  /* Enable reporting bugs after kasan_disable_current() */
>  extern void kasan_enable_current(void);
>
> @@ -75,9 +105,6 @@ struct kasan_cache {
>         int free_meta_offset;
>  };
>
> -int kasan_add_zero_shadow(void *start, unsigned long size);
> -void kasan_remove_zero_shadow(void *start, unsigned long size);
> -
>  size_t __ksize(const void *);
>  static inline void kasan_unpoison_slab(const void *ptr)
>  {
> @@ -143,14 +170,6 @@ static inline bool kasan_slab_free(struct kmem_cache=
 *s, void *object,
>         return false;
>  }
>
> -static inline int kasan_add_zero_shadow(void *start, unsigned long size)
> -{
> -       return 0;
> -}
> -static inline void kasan_remove_zero_shadow(void *start,
> -                                       unsigned long size)
> -{}
> -
>  static inline void kasan_unpoison_slab(const void *ptr) { }
>  static inline size_t kasan_metadata_size(struct kmem_cache *cache) { ret=
urn 0; }
>
> @@ -158,8 +177,6 @@ static inline size_t kasan_metadata_size(struct kmem_=
cache *cache) { return 0; }
>
>  #ifdef CONFIG_KASAN_GENERIC
>
> -#define KASAN_SHADOW_INIT 0
> -
>  void kasan_cache_shrink(struct kmem_cache *cache);
>  void kasan_cache_shutdown(struct kmem_cache *cache);
>  void kasan_record_aux_stack(void *ptr);
> @@ -174,8 +191,6 @@ static inline void kasan_record_aux_stack(void *ptr) =
{}
>
>  #ifdef CONFIG_KASAN_SW_TAGS
>
> -#define KASAN_SHADOW_INIT 0xFF
> -
>  void kasan_init_tags(void);
>
>  void *kasan_reset_tag(const void *addr);
> --
> 2.29.2.222.g5d2a92d10f8-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
