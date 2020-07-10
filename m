Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF0721B54A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 14:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgGJMnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 08:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgGJMnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:43:03 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166E7C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 05:43:03 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f2so2200487plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 05:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8AQCz6U9rg/TZdMooPQtBnohp0JVWtGHbcPbtcQ4I1c=;
        b=VTtWM8GXFIyeMPXW2FxBWWjAOBI0+GPTtKpkPtY9cbA7QrMtAKaKEvjBFEU0vTfVM5
         2kSf9ZSabTxU/iPcHAIyAZ2ydLY0KivuhlUHJjlUrHyhQMR57N+emlA8VAiY775wguUE
         XToYhb+IiUSUGA+dXPphm7EGt5hLZ+qqD5voIsU6j48jvXQcJAaK6M5d5Gc3+YJe270H
         ipf0xjsNnuaES0hDf0d4+g+nqtXsBBATv/3i9NqRqvhY2Hkj2t7ahnGEbw3m6tRcgCzr
         omfFTY8zgviZKZ/BNsVUrgFCx0x42PM9fx6fRZGnqbLT/I28NFcOAZ+eqYLZ6RqDS0y6
         I1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8AQCz6U9rg/TZdMooPQtBnohp0JVWtGHbcPbtcQ4I1c=;
        b=Q90LDMwXbqBU5ZfVfHV3ZF06YkYiuCyfl5OFq8IcCBK/KfyH+Vx5X3WBfotllI9BvJ
         5R+hiYXxObDJW1CpBQkpRqNXbJnltTFypFhddWyILMaXom60vRXVyf50n2UyM8PCwUvp
         kB9D08KJFze4gWUDUwIizkoyxfKr3pDGjBPtEixXb/mmJcmtjTEM0/HkNCPrA8kzihh1
         vpz6RppjwRpO8nt3+BmKjAvmDgvaWPnx9OyXThl2qL2RWKwdvfwwnwxerC25zWxLEaQF
         R59zYwwC9ztodPs0IqfNfG7swd4S4GJTbO/LEuQcmkJxDSHONVWJ0JSeROkvHrIi4/QP
         4OYg==
X-Gm-Message-State: AOAM533OU6no4Y9vlCLXC8cEm2UqI8DrRNDKLoUjTbimIGmRzZfDp9Ao
        je3s/JSdDFWY6YRRpaHoSyYQ0sEKRFjaQngYaWGdPQ==
X-Google-Smtp-Source: ABdhPJw+By+sHLOwHsh32FzyQZLDI2ANFod7vUzJkAL59THvvsg0wHyjkMm3tpI1s0Fy0ySoKshisp27bfHOuQNM6dw=
X-Received: by 2002:a17:90b:30c4:: with SMTP id hi4mr5250427pjb.166.1594384982354;
 Fri, 10 Jul 2020 05:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200706143505.23299-1-vincenzo.frascino@arm.com>
In-Reply-To: <20200706143505.23299-1-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 10 Jul 2020 14:42:51 +0200
Message-ID: <CAAeHK+wvLb9BD=GdKuZp9v2620JKWgk9ShXUdx2tWSZNw1UJBQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: Remove kasan_unpoison_stack_above_sp_to()
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 4:35 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> The function kasan_unpoison_stack_above_sp_to() is defined in kasan code
> but never used. The function was introduced as part of the commit:
>
>    commit 9f7d416c36124667 ("kprobes: Unpoison stack in jprobe_return() for KASAN")
>
> ... where it was necessary because x86's jprobe_return() would leave
> stale shadow on the stack, and was an oddity in that regard.
>
> Since then, jprobes were removed entirely, and as of commit:
>
>   commit 80006dbee674f9fa ("kprobes/x86: Remove jprobe implementation")
>
> ... there have been no callers of this function.
>
> Remove the declaration and the implementation.
>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!

> ---
>  include/linux/kasan.h |  2 --
>  mm/kasan/common.c     | 15 ---------------
>  2 files changed, 17 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 82522e996c76..0ebf2fab8567 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -38,7 +38,6 @@ extern void kasan_disable_current(void);
>  void kasan_unpoison_shadow(const void *address, size_t size);
>
>  void kasan_unpoison_task_stack(struct task_struct *task);
> -void kasan_unpoison_stack_above_sp_to(const void *watermark);
>
>  void kasan_alloc_pages(struct page *page, unsigned int order);
>  void kasan_free_pages(struct page *page, unsigned int order);
> @@ -101,7 +100,6 @@ void kasan_restore_multi_shot(bool enabled);
>  static inline void kasan_unpoison_shadow(const void *address, size_t size) {}
>
>  static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
> -static inline void kasan_unpoison_stack_above_sp_to(const void *watermark) {}
>
>  static inline void kasan_enable_current(void) {}
>  static inline void kasan_disable_current(void) {}
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 757d4074fe28..6339179badb2 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -180,21 +180,6 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
>         kasan_unpoison_shadow(base, watermark - base);
>  }
>
> -/*
> - * Clear all poison for the region between the current SP and a provided
> - * watermark value, as is sometimes required prior to hand-crafted asm function
> - * returns in the middle of functions.
> - */
> -void kasan_unpoison_stack_above_sp_to(const void *watermark)
> -{
> -       const void *sp = __builtin_frame_address(0);
> -       size_t size = watermark - sp;
> -
> -       if (WARN_ON(sp > watermark))
> -               return;
> -       kasan_unpoison_shadow(sp, size);
> -}
> -
>  void kasan_alloc_pages(struct page *page, unsigned int order)
>  {
>         u8 tag;
> --
> 2.27.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200706143505.23299-1-vincenzo.frascino%40arm.com.
