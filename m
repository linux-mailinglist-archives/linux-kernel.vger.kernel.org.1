Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518012AF379
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgKKOZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKKOZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:25:42 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E305C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:25:41 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id x13so934238qvk.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ivzJGCKhLp1x2v+oY17etQZN4NoUxQRVrZrrn1pxmzQ=;
        b=MhI88VRyKnCSohVt/b/8moDNfsbfFZlYNQiqzxMiCoC0YdUE3yesZOW9r3lkab0qdi
         nLTsNDYTtZW7/Tx7SbsMMFaYfEwfshUShKuAY87B4CS5Pv9u+9X/LS2GlP8KwZfgCD4G
         lYq0JxA7S0Jo9A4VX9wDC3zvrK8+nuwTGlMXYf2znZPt3+b2N8VcU+DkKtBOXETf6Gge
         qFuGoVHNqeKDPhK3zoi5jB8MprtBffAZxECn7RRrQxhmyjg0o4EwwYgfsBSeCq9MmzX2
         Yt/EjBmaMtq9i8xzhStc5QGXB83wuDF64VU6zHPRoKyQNk0yYjg58xjXYkFaOIa5FJT1
         HzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ivzJGCKhLp1x2v+oY17etQZN4NoUxQRVrZrrn1pxmzQ=;
        b=gzHWA4zyO7HjePd7dLRk3E3+ZRibrvCXQ9TxsqdK7ldrVVCXuEqS3Vq2fgeVmG2JpP
         /lWtu6PX43Yr4Pr9atW1qLM4//1i0X+sBVSfV+jkgqJuEVTL07yWQmLqBSZW0tLB6bgJ
         jXv/eDoqYQfAd+OhLsAm2rVZDB2ZBCrU6qnwgtPyoArrWXkW07wkpznnplwRAvzFZEyD
         t07Kjpm8EL8qJ5YiKP7i0lJFTkU+TdVs7mFrsECe/BDBnVLvnN26LL9SXW17Gyb3dn0M
         rJ3/80aEinYMxFokcKZEr8ssoXOoXU0KpzCd60pxEgSxpp3ML2ADnJFBcG6eL3WcYTFB
         eb4w==
X-Gm-Message-State: AOAM533+b876KuVNzLFguhRlWI9QNULPPqSJdjStLQlk959rk7pZapib
        a3wzndQOCDti+QUjkitW49mwTG+ODxp0DeM44HJMOg==
X-Google-Smtp-Source: ABdhPJycer9vbmyDtpWZBUED3QtzZpM+KIzRxpVTeFzrW+cu9wtIRqmDDFvTkmO16e0dR39bfgELlSelu5U7Z3G6ggk=
X-Received: by 2002:a0c:9e53:: with SMTP id z19mr24687355qve.23.1605104740021;
 Wed, 11 Nov 2020 06:25:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <f19f5aac37051fa10b2a8eb3539c19e113b92a06.1605046192.git.andreyknvl@google.com>
In-Reply-To: <f19f5aac37051fa10b2a8eb3539c19e113b92a06.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 15:25:28 +0100
Message-ID: <CAG_fn=XTGREjohda7iNoJMFO+cmh250iANoWMBsBn8uVJSK9Lw@mail.gmail.com>
Subject: Re: [PATCH v9 14/44] kasan: decode stack frame only with KASAN_STACK_ENABLE
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
> Decoding routines aren't needed when CONFIG_KASAN_STACK_ENABLE is not
> enabled. Currently only generic KASAN mode implements stack error
> reporting.
>
> No functional changes for software modes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: I084e3214f2b40dc0bef7c5a9fafdc6f5c42b06a2
> ---
>  mm/kasan/kasan.h          |   6 ++
>  mm/kasan/report.c         | 162 --------------------------------------
>  mm/kasan/report_generic.c | 162 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 168 insertions(+), 162 deletions(-)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 3eff57e71ff5..d0cf61d4d70d 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -169,6 +169,12 @@ bool check_invalid_free(void *addr);
>  void *find_first_bad_addr(void *addr, size_t size);
>  const char *get_bug_type(struct kasan_access_info *info);
>
> +#if defined(CONFIG_KASAN_GENERIC) && CONFIG_KASAN_STACK
> +void print_address_stack_frame(const void *addr);
> +#else
> +static inline void print_address_stack_frame(const void *addr) { }
> +#endif
> +
>  bool kasan_report(unsigned long addr, size_t size,
>                 bool is_write, unsigned long ip);
>  void kasan_report_invalid_free(void *object, unsigned long ip);
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index fff0c7befbfe..b18d193f7f58 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -211,168 +211,6 @@ static inline bool init_task_stack_addr(const void =
*addr)
>                         sizeof(init_thread_union.stack));
>  }
>
> -static bool __must_check tokenize_frame_descr(const char **frame_descr,
> -                                             char *token, size_t max_tok=
_len,
> -                                             unsigned long *value)
> -{
> -       const char *sep =3D strchr(*frame_descr, ' ');
> -
> -       if (sep =3D=3D NULL)
> -               sep =3D *frame_descr + strlen(*frame_descr);
> -
> -       if (token !=3D NULL) {
> -               const size_t tok_len =3D sep - *frame_descr;
> -
> -               if (tok_len + 1 > max_tok_len) {
> -                       pr_err("KASAN internal error: frame description t=
oo long: %s\n",
> -                              *frame_descr);
> -                       return false;
> -               }
> -
> -               /* Copy token (+ 1 byte for '\0'). */
> -               strlcpy(token, *frame_descr, tok_len + 1);
> -       }
> -
> -       /* Advance frame_descr past separator. */
> -       *frame_descr =3D sep + 1;
> -
> -       if (value !=3D NULL && kstrtoul(token, 10, value)) {
> -               pr_err("KASAN internal error: not a valid number: %s\n", =
token);
> -               return false;
> -       }
> -
> -       return true;
> -}
> -
> -static void print_decoded_frame_descr(const char *frame_descr)
> -{
> -       /*
> -        * We need to parse the following string:
> -        *    "n alloc_1 alloc_2 ... alloc_n"
> -        * where alloc_i looks like
> -        *    "offset size len name"
> -        * or "offset size len name:line".
> -        */
> -
> -       char token[64];
> -       unsigned long num_objects;
> -
> -       if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> -                                 &num_objects))
> -               return;
> -
> -       pr_err("\n");
> -       pr_err("this frame has %lu %s:\n", num_objects,
> -              num_objects =3D=3D 1 ? "object" : "objects");
> -
> -       while (num_objects--) {
> -               unsigned long offset;
> -               unsigned long size;
> -
> -               /* access offset */
> -               if (!tokenize_frame_descr(&frame_descr, token, sizeof(tok=
en),
> -                                         &offset))
> -                       return;
> -               /* access size */
> -               if (!tokenize_frame_descr(&frame_descr, token, sizeof(tok=
en),
> -                                         &size))
> -                       return;
> -               /* name length (unused) */
> -               if (!tokenize_frame_descr(&frame_descr, NULL, 0, NULL))
> -                       return;
> -               /* object name */
> -               if (!tokenize_frame_descr(&frame_descr, token, sizeof(tok=
en),
> -                                         NULL))
> -                       return;
> -
> -               /* Strip line number; without filename it's not very help=
ful. */
> -               strreplace(token, ':', '\0');
> -
> -               /* Finally, print object information. */
> -               pr_err(" [%lu, %lu) '%s'", offset, offset + size, token);
> -       }
> -}
> -
> -static bool __must_check get_address_stack_frame_info(const void *addr,
> -                                                     unsigned long *offs=
et,
> -                                                     const char **frame_=
descr,
> -                                                     const void **frame_=
pc)
> -{
> -       unsigned long aligned_addr;
> -       unsigned long mem_ptr;
> -       const u8 *shadow_bottom;
> -       const u8 *shadow_ptr;
> -       const unsigned long *frame;
> -
> -       BUILD_BUG_ON(IS_ENABLED(CONFIG_STACK_GROWSUP));
> -
> -       /*
> -        * NOTE: We currently only support printing frame information for
> -        * accesses to the task's own stack.
> -        */
> -       if (!object_is_on_stack(addr))
> -               return false;
> -
> -       aligned_addr =3D round_down((unsigned long)addr, sizeof(long));
> -       mem_ptr =3D round_down(aligned_addr, KASAN_GRANULE_SIZE);
> -       shadow_ptr =3D kasan_mem_to_shadow((void *)aligned_addr);
> -       shadow_bottom =3D kasan_mem_to_shadow(end_of_stack(current));
> -
> -       while (shadow_ptr >=3D shadow_bottom && *shadow_ptr !=3D KASAN_ST=
ACK_LEFT) {
> -               shadow_ptr--;
> -               mem_ptr -=3D KASAN_GRANULE_SIZE;
> -       }
> -
> -       while (shadow_ptr >=3D shadow_bottom && *shadow_ptr =3D=3D KASAN_=
STACK_LEFT) {
> -               shadow_ptr--;
> -               mem_ptr -=3D KASAN_GRANULE_SIZE;
> -       }
> -
> -       if (shadow_ptr < shadow_bottom)
> -               return false;
> -
> -       frame =3D (const unsigned long *)(mem_ptr + KASAN_GRANULE_SIZE);
> -       if (frame[0] !=3D KASAN_CURRENT_STACK_FRAME_MAGIC) {
> -               pr_err("KASAN internal error: frame info validation faile=
d; invalid marker: %lu\n",
> -                      frame[0]);
> -               return false;
> -       }
> -
> -       *offset =3D (unsigned long)addr - (unsigned long)frame;
> -       *frame_descr =3D (const char *)frame[1];
> -       *frame_pc =3D (void *)frame[2];
> -
> -       return true;
> -}
> -
> -static void print_address_stack_frame(const void *addr)
> -{
> -       unsigned long offset;
> -       const char *frame_descr;
> -       const void *frame_pc;
> -
> -       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> -               return;
> -
> -       if (!get_address_stack_frame_info(addr, &offset, &frame_descr,
> -                                         &frame_pc))
> -               return;
> -
> -       /*
> -        * get_address_stack_frame_info only returns true if the given ad=
dr is
> -        * on the current task's stack.
> -        */
> -       pr_err("\n");
> -       pr_err("addr %px is located in stack of task %s/%d at offset %lu =
in frame:\n",
> -              addr, current->comm, task_pid_nr(current), offset);
> -       pr_err(" %pS\n", frame_pc);
> -
> -       if (!frame_descr)
> -               return;
> -
> -       print_decoded_frame_descr(frame_descr);
> -}
> -
>  static void print_address_description(void *addr, u8 tag)
>  {
>         struct page *page =3D kasan_addr_to_page(addr);
> diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
> index 7d5b9e5c7cfe..b543a1ed6078 100644
> --- a/mm/kasan/report_generic.c
> +++ b/mm/kasan/report_generic.c
> @@ -16,6 +16,7 @@
>  #include <linux/mm.h>
>  #include <linux/printk.h>
>  #include <linux/sched.h>
> +#include <linux/sched/task_stack.h>
>  #include <linux/slab.h>
>  #include <linux/stackdepot.h>
>  #include <linux/stacktrace.h>
> @@ -122,6 +123,167 @@ const char *get_bug_type(struct kasan_access_info *=
info)
>         return get_wild_bug_type(info);
>  }
>
> +#if CONFIG_KASAN_STACK
> +static bool __must_check tokenize_frame_descr(const char **frame_descr,
> +                                             char *token, size_t max_tok=
_len,
> +                                             unsigned long *value)
> +{
> +       const char *sep =3D strchr(*frame_descr, ' ');
> +
> +       if (sep =3D=3D NULL)
> +               sep =3D *frame_descr + strlen(*frame_descr);
> +
> +       if (token !=3D NULL) {
> +               const size_t tok_len =3D sep - *frame_descr;
> +
> +               if (tok_len + 1 > max_tok_len) {
> +                       pr_err("KASAN internal error: frame description t=
oo long: %s\n",
> +                              *frame_descr);
> +                       return false;
> +               }
> +
> +               /* Copy token (+ 1 byte for '\0'). */
> +               strlcpy(token, *frame_descr, tok_len + 1);
> +       }
> +
> +       /* Advance frame_descr past separator. */
> +       *frame_descr =3D sep + 1;
> +
> +       if (value !=3D NULL && kstrtoul(token, 10, value)) {
> +               pr_err("KASAN internal error: not a valid number: %s\n", =
token);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +static void print_decoded_frame_descr(const char *frame_descr)
> +{
> +       /*
> +        * We need to parse the following string:
> +        *    "n alloc_1 alloc_2 ... alloc_n"
> +        * where alloc_i looks like
> +        *    "offset size len name"
> +        * or "offset size len name:line".
> +        */
> +
> +       char token[64];
> +       unsigned long num_objects;
> +
> +       if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
> +                                 &num_objects))
> +               return;
> +
> +       pr_err("\n");
> +       pr_err("this frame has %lu %s:\n", num_objects,
> +              num_objects =3D=3D 1 ? "object" : "objects");
> +
> +       while (num_objects--) {
> +               unsigned long offset;
> +               unsigned long size;
> +
> +               /* access offset */
> +               if (!tokenize_frame_descr(&frame_descr, token, sizeof(tok=
en),
> +                                         &offset))
> +                       return;
> +               /* access size */
> +               if (!tokenize_frame_descr(&frame_descr, token, sizeof(tok=
en),
> +                                         &size))
> +                       return;
> +               /* name length (unused) */
> +               if (!tokenize_frame_descr(&frame_descr, NULL, 0, NULL))
> +                       return;
> +               /* object name */
> +               if (!tokenize_frame_descr(&frame_descr, token, sizeof(tok=
en),
> +                                         NULL))
> +                       return;
> +
> +               /* Strip line number; without filename it's not very help=
ful. */
> +               strreplace(token, ':', '\0');
> +
> +               /* Finally, print object information. */
> +               pr_err(" [%lu, %lu) '%s'", offset, offset + size, token);
> +       }
> +}
> +
> +static bool __must_check get_address_stack_frame_info(const void *addr,
> +                                                     unsigned long *offs=
et,
> +                                                     const char **frame_=
descr,
> +                                                     const void **frame_=
pc)
> +{
> +       unsigned long aligned_addr;
> +       unsigned long mem_ptr;
> +       const u8 *shadow_bottom;
> +       const u8 *shadow_ptr;
> +       const unsigned long *frame;
> +
> +       BUILD_BUG_ON(IS_ENABLED(CONFIG_STACK_GROWSUP));
> +
> +       /*
> +        * NOTE: We currently only support printing frame information for
> +        * accesses to the task's own stack.
> +        */
> +       if (!object_is_on_stack(addr))
> +               return false;
> +
> +       aligned_addr =3D round_down((unsigned long)addr, sizeof(long));
> +       mem_ptr =3D round_down(aligned_addr, KASAN_GRANULE_SIZE);
> +       shadow_ptr =3D kasan_mem_to_shadow((void *)aligned_addr);
> +       shadow_bottom =3D kasan_mem_to_shadow(end_of_stack(current));
> +
> +       while (shadow_ptr >=3D shadow_bottom && *shadow_ptr !=3D KASAN_ST=
ACK_LEFT) {
> +               shadow_ptr--;
> +               mem_ptr -=3D KASAN_GRANULE_SIZE;
> +       }
> +
> +       while (shadow_ptr >=3D shadow_bottom && *shadow_ptr =3D=3D KASAN_=
STACK_LEFT) {
> +               shadow_ptr--;
> +               mem_ptr -=3D KASAN_GRANULE_SIZE;
> +       }
> +
> +       if (shadow_ptr < shadow_bottom)
> +               return false;
> +
> +       frame =3D (const unsigned long *)(mem_ptr + KASAN_GRANULE_SIZE);
> +       if (frame[0] !=3D KASAN_CURRENT_STACK_FRAME_MAGIC) {
> +               pr_err("KASAN internal error: frame info validation faile=
d; invalid marker: %lu\n",
> +                      frame[0]);
> +               return false;
> +       }
> +
> +       *offset =3D (unsigned long)addr - (unsigned long)frame;
> +       *frame_descr =3D (const char *)frame[1];
> +       *frame_pc =3D (void *)frame[2];
> +
> +       return true;
> +}
> +
> +void print_address_stack_frame(const void *addr)
> +{
> +       unsigned long offset;
> +       const char *frame_descr;
> +       const void *frame_pc;
> +
> +       if (!get_address_stack_frame_info(addr, &offset, &frame_descr,
> +                                         &frame_pc))
> +               return;
> +
> +       /*
> +        * get_address_stack_frame_info only returns true if the given ad=
dr is
> +        * on the current task's stack.
> +        */
> +       pr_err("\n");
> +       pr_err("addr %px is located in stack of task %s/%d at offset %lu =
in frame:\n",
> +              addr, current->comm, task_pid_nr(current), offset);
> +       pr_err(" %pS\n", frame_pc);
> +
> +       if (!frame_descr)
> +               return;
> +
> +       print_decoded_frame_descr(frame_descr);
> +}
> +#endif /* CONFIG_KASAN_STACK */
> +
>  #define DEFINE_ASAN_REPORT_LOAD(size)                     \
>  void __asan_report_load##size##_noabort(unsigned long addr) \
>  {                                                         \
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
