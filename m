Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5422809C6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbgJAV4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgJAV4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:56:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0807EC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 14:56:36 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b124so5923526pfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYN4Jo8znVBvexmXtOTq7Vyw02r7hMLAu1E79NO6g4Y=;
        b=mGj4QqCgUizMudIE9ro10wk616UWhcqWMnlmP/5Brlok2KQYI29mdFoZlyD5FuhZwQ
         JllnqWV9L+UwChyXuSeU2kelgLRStwVfSZi0sCBk5l3/6m0ljmL+heaCBlU+XbgUJLJq
         yhzJFFdISquAOlkwShM/RroZ8Yf9MiVCLq6POYZv4BTECBw6Ww+KOoueqyBwBUH1EVAp
         Y27OKSSzIxcH5u7iyHQmi0bPsXlI3NXlry8DhLOW0zG5MgYa2C0LGzYX0o90KyVacnsk
         Krmx5iqpudereHXhLCQsAh0F+jFSpSDqkLo+CFm5F/sXnL2hi2wxTJCImEy/hi/Xl/WP
         +V0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYN4Jo8znVBvexmXtOTq7Vyw02r7hMLAu1E79NO6g4Y=;
        b=dv1ZyJ7j0HSNjiG2IJDSbGR6BMyTxKzLvmdtqOCk2l3OM4VLGTjwQeXqllkYG2hXk/
         KFs6EBhTUNM6VBlvFfWr+BdPojeY4gGX0o6UdZjFnA/na9qXHz9mX+VeVa3yH8zJc4ta
         K8lPZ2OhkJ4Fh/3xoDVGGnFaauXamYbcpWiYYSE+yJUhInzxlBmjNwFMkFlTwztp6V9g
         hS2eL0QliGRopTDhsebNIFJuqM4+wp6rHV+3jdvM/YZaDyz7ZTC3fwOmhu6jU9LJCaqg
         BrasNFogymdLuy+e35y2lo2d4frY3ul9PgW/UT5r6g0SIJAXidV6QNw1fgcQHzxRwjA+
         QAMw==
X-Gm-Message-State: AOAM531ixbG9EcVAaDYd600JjJFNRPVcQWRSMJJTcbduY/vr3QoDbBSU
        +Gja+iXyeHIW4w0owoT1RgnesjdiNJFzv960fgsfRA==
X-Google-Smtp-Source: ABdhPJxYUpKcj6UaxygvMWUbW4f2EntDeZNwix3KAhCgYDPQEpkY6t+bQ0VA6jtlFLf5ATMLr/wDCD2h89mtjTs7RaY=
X-Received: by 2002:a63:2209:: with SMTP id i9mr7781306pgi.130.1601589395167;
 Thu, 01 Oct 2020 14:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com> <494045645c31b7f9298851118cb0b7f8964ac0f4.1600987622.git.andreyknvl@google.com>
 <20201001175402.GP4162920@elver.google.com>
In-Reply-To: <20201001175402.GP4162920@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 1 Oct 2020 23:56:24 +0200
Message-ID: <CAAeHK+yFN1NbWBSrdjHDHT9-Fk+mYMpEy_jbW8gpkiANkT=z7g@mail.gmail.com>
Subject: Re: [PATCH v3 20/39] kasan: separate metadata_fetch_row for each mode
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 7:54 PM <elver@google.com> wrote:
>
> On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> > This is a preparatory commit for the upcoming addition of a new hardware
> > tag-based (MTE-based) KASAN mode.
>
> Not sure why I've only noticed this now, but all these patches seem to
> say "This is a preparatory commit" -- I don't think "commit" is
> applicable, and "This .. patch" is discouraged.

"This commit" is used all over the place if you do git log, so it
should be fine.

>
> Maybe just change it to say "This is to prepare for the upcoming ..."
> after the below paragraph?
>
> > Rework print_memory_metadata() to make it agnostic with regard to the
> > way metadata is stored. Allow providing a separate metadata_fetch_row()
> > implementation for each KASAN mode. Hardware tag-based KASAN will provide
> > its own implementation that doesn't use shadow memory.
>
> (i.e. move it here)
>
> > No functional changes for software modes.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> Other than that,
>
> Reviewed-by: Marco Elver <elver@google.com>

Thanks!

>
> > ---
> > Change-Id: I5b0ed1d079ea776e620beca6a529a861e7dced95
> > ---
> >  mm/kasan/kasan.h          |  8 ++++++
> >  mm/kasan/report.c         | 56 +++++++++++++++++++--------------------
> >  mm/kasan/report_generic.c |  5 ++++
> >  mm/kasan/report_sw_tags.c |  5 ++++
> >  4 files changed, 45 insertions(+), 29 deletions(-)
> >
> > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > index 0bf669fad345..50b59c8f8be2 100644
> > --- a/mm/kasan/kasan.h
> > +++ b/mm/kasan/kasan.h
> > @@ -57,6 +57,13 @@
> >  #define KASAN_ABI_VERSION 1
> >  #endif
> >
> > +/* Metadata layout customization. */
> > +#define META_BYTES_PER_BLOCK 1
> > +#define META_BLOCKS_PER_ROW 16
> > +#define META_BYTES_PER_ROW (META_BLOCKS_PER_ROW * META_BYTES_PER_BLOCK)
> > +#define META_MEM_BYTES_PER_ROW (META_BYTES_PER_ROW * KASAN_GRANULE_SIZE)
> > +#define META_ROWS_AROUND_ADDR 2
> > +
> >  struct kasan_access_info {
> >       const void *access_addr;
> >       const void *first_bad_addr;
> > @@ -168,6 +175,7 @@ bool check_invalid_free(void *addr);
> >
> >  void *find_first_bad_addr(void *addr, size_t size);
> >  const char *get_bug_type(struct kasan_access_info *info);
> > +void metadata_fetch_row(char *buffer, void *row);
> >
> >  #ifdef CONFIG_KASAN_STACK_ENABLE
> >  void print_address_stack_frame(const void *addr);
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > index 13b27675a696..3924127b4786 100644
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -31,12 +31,6 @@
> >  #include "kasan.h"
> >  #include "../slab.h"
> >
> > -/* Metadata layout customization. */
> > -#define META_BYTES_PER_BLOCK 1
> > -#define META_BLOCKS_PER_ROW 16
> > -#define META_BYTES_PER_ROW (META_BLOCKS_PER_ROW * META_BYTES_PER_BLOCK)
> > -#define META_ROWS_AROUND_ADDR 2
> > -
> >  static unsigned long kasan_flags;
> >
> >  #define KASAN_BIT_REPORTED   0
> > @@ -236,55 +230,59 @@ static void print_address_description(void *addr, u8 tag)
> >       print_address_stack_frame(addr);
> >  }
> >
> > -static bool row_is_guilty(const void *row, const void *guilty)
> > +static bool meta_row_is_guilty(const void *row, const void *addr)
> >  {
> > -     return (row <= guilty) && (guilty < row + META_BYTES_PER_ROW);
> > +     return (row <= addr) && (addr < row + META_MEM_BYTES_PER_ROW);
> >  }
> >
> > -static int shadow_pointer_offset(const void *row, const void *shadow)
> > +static int meta_pointer_offset(const void *row, const void *addr)
> >  {
> > -     /* The length of ">ff00ff00ff00ff00: " is
> > -      *    3 + (BITS_PER_LONG/8)*2 chars.
> > +     /*
> > +      * Memory state around the buggy address:
> > +      *  ff00ff00ff00ff00: 00 00 00 05 fe fe fe fe fe fe fe fe fe fe fe fe
> > +      *  ...
> > +      *
> > +      * The length of ">ff00ff00ff00ff00: " is
> > +      *    3 + (BITS_PER_LONG / 8) * 2 chars.
> > +      * The length of each granule metadata is 2 bytes
> > +      *    plus 1 byte for space.
> >        */
> > -     return 3 + (BITS_PER_LONG/8)*2 + (shadow - row)*2 +
> > -             (shadow - row) / META_BYTES_PER_BLOCK + 1;
> > +     return 3 + (BITS_PER_LONG / 8) * 2 +
> > +             (addr - row) / KASAN_GRANULE_SIZE * 3 + 1;
> >  }
> >
> >  static void print_memory_metadata(const void *addr)
> >  {
> >       int i;
> > -     const void *shadow = kasan_mem_to_shadow(addr);
> > -     const void *shadow_row;
> > +     void *row;
> >
> > -     shadow_row = (void *)round_down((unsigned long)shadow,
> > -                                     META_BYTES_PER_ROW)
> > -             - META_ROWS_AROUND_ADDR * META_BYTES_PER_ROW;
> > +     row = (void *)round_down((unsigned long)addr, META_MEM_BYTES_PER_ROW)
> > +                     - META_ROWS_AROUND_ADDR * META_MEM_BYTES_PER_ROW;
> >
> >       pr_err("Memory state around the buggy address:\n");
> >
> >       for (i = -META_ROWS_AROUND_ADDR; i <= META_ROWS_AROUND_ADDR; i++) {
> > -             const void *kaddr = kasan_shadow_to_mem(shadow_row);
> > -             char buffer[4 + (BITS_PER_LONG/8)*2];
> > -             char shadow_buf[META_BYTES_PER_ROW];
> > +             char buffer[4 + (BITS_PER_LONG / 8) * 2];
> > +             char metadata[META_BYTES_PER_ROW];
> >
> >               snprintf(buffer, sizeof(buffer),
> > -                     (i == 0) ? ">%px: " : " %px: ", kaddr);
> > +                             (i == 0) ? ">%px: " : " %px: ", row);
> > +
> >               /*
> >                * We should not pass a shadow pointer to generic
> >                * function, because generic functions may try to
> >                * access kasan mapping for the passed address.
> >                */
> > -             memcpy(shadow_buf, shadow_row, META_BYTES_PER_ROW);
> > +             metadata_fetch_row(&metadata[0], row);
> > +
> >               print_hex_dump(KERN_ERR, buffer,
> >                       DUMP_PREFIX_NONE, META_BYTES_PER_ROW, 1,
> > -                     shadow_buf, META_BYTES_PER_ROW, 0);
> > +                     metadata, META_BYTES_PER_ROW, 0);
> >
> > -             if (row_is_guilty(shadow_row, shadow))
> > -                     pr_err("%*c\n",
> > -                             shadow_pointer_offset(shadow_row, shadow),
> > -                             '^');
> > +             if (meta_row_is_guilty(row, addr))
> > +                     pr_err("%*c\n", meta_pointer_offset(row, addr), '^');
> >
> > -             shadow_row += META_BYTES_PER_ROW;
> > +             row += META_MEM_BYTES_PER_ROW;
> >       }
> >  }
> >
> > diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
> > index ff067071cd28..de7a85c83106 100644
> > --- a/mm/kasan/report_generic.c
> > +++ b/mm/kasan/report_generic.c
> > @@ -122,6 +122,11 @@ const char *get_bug_type(struct kasan_access_info *info)
> >       return get_wild_bug_type(info);
> >  }
> >
> > +void metadata_fetch_row(char *buffer, void *row)
> > +{
> > +     memcpy(buffer, kasan_mem_to_shadow(row), META_BYTES_PER_ROW);
> > +}
> > +
> >  #ifdef CONFIG_KASAN_STACK_ENABLE
> >  static bool __must_check tokenize_frame_descr(const char **frame_descr,
> >                                             char *token, size_t max_tok_len,
> > diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
> > index c87d5a343b4e..add2dfe6169c 100644
> > --- a/mm/kasan/report_sw_tags.c
> > +++ b/mm/kasan/report_sw_tags.c
> > @@ -80,6 +80,11 @@ void *find_first_bad_addr(void *addr, size_t size)
> >       return p;
> >  }
> >
> > +void metadata_fetch_row(char *buffer, void *row)
> > +{
> > +     memcpy(buffer, kasan_mem_to_shadow(row), META_BYTES_PER_ROW);
> > +}
> > +
> >  void print_tags(u8 addr_tag, const void *addr)
> >  {
> >       u8 *shadow = (u8 *)kasan_mem_to_shadow(addr);
> > --
> > 2.28.0.681.g6f77f65b4e-goog
> >
