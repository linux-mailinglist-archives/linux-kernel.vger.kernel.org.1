Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DAA29D95C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389670AbgJ1Www (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389662AbgJ1WwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:52:20 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEA8C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:52:20 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b69so558489qkg.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zxgi7xd3nW4FDFVux6haRrdrCJvaqFEyqWtMMDIWgYY=;
        b=eWofOYiPw5raslm8yWSmDEwm/I/OMPVFw+0VduVEDahYCfRy1yswtr6sR1Pg/kenLL
         R03DZVGnmBJWhhFjsnQR4QiuVY3nJaLRrES5cmZvm0bRNyrAwWezG3L7l8+UdIqyus49
         LINNaxfbFCakoHG0yD5FHsLcXhMzY+WpfQUIDFRnomSX+PG59G+pHRPJqMLCgdelEpZG
         07W3oXzXJXs3omJoG1YIH6S3fhauMMlCn0CapNJ/QVH/EEBKI0o19EwatkaTOnkXUi2V
         hU9xEKAJFKdr1uoH4xOoA0pucS5Y3epFPk8cssZGA54e5xpUPnTTXvvc1B1+Xt5ENfgO
         Gz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zxgi7xd3nW4FDFVux6haRrdrCJvaqFEyqWtMMDIWgYY=;
        b=NtvI5UAREATOVs0efZvGTApg1Pi8z7FPu+iJgkgISLxBLYKIdvKx9mHXxE+QPHHD1b
         dkjZMFHAapMsqLYpH16zK7DNtBQpVlxlNNi6VuzeoBoX87DzKywlNAzSLUiFsn8JtjgN
         9HjcGCbgQeelLJqn1pihlsTacSU0INfhpjnbmQy0K1WiVvSk2PnFPE7ODGJN4H6Wo3uU
         w8AQ4NeH+GIu/CLuH4npk9WkD5rHDy6BHuINdY3B4ZTWl9J9lA3ePkuy+zTUPc+nDQ1G
         uMFUdVgvhCxbrNTmPbrrpy8iEPLOXxb9jrx7G71d6Hk8XTAHYXLAe8vgy9PDxQc17Lg7
         6ZQQ==
X-Gm-Message-State: AOAM533MOeVv9JI0zDM+q3yBUKEgc2ULsEtzWCT/XxuUajgOCd9fhTJP
        CUqZrlALQBU7sYtIjeuLehTh932s25wSgibpOutAnCUBe7TQaA==
X-Google-Smtp-Source: ABdhPJy50POtHGn57238IQURdi1vWUPLZnjnOkGTn4fmZdTNYDz3IxwV1tq5IiPRk78U+K6fH4jLx8yuea6oPQZvVgw=
X-Received: by 2002:a37:7b44:: with SMTP id w65mr8409031qkc.350.1603904264037;
 Wed, 28 Oct 2020 09:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <f7b6b3b784e80d3ff82012295503def6164be657.1603372719.git.andreyknvl@google.com>
In-Reply-To: <f7b6b3b784e80d3ff82012295503def6164be657.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 17:57:33 +0100
Message-ID: <CACT4Y+bk9n6+v5dkcm8ngxQ=HbK9jS2N1nCm3F1vQLSxBiiTSA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 17/21] kasan: simplify kasan_poison_kfree
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

On Thu, Oct 22, 2020 at 3:20 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> kasan_poison_kfree() is currently only called for mempool allocations
> that are backed by either kmem_cache_alloc() or kmalloc(). Therefore, the
> page passed to kasan_poison_kfree() is always PageSlab() and there's no
> need to do the check.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/If31f88726745da8744c6bea96fb32584e6c2778c

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  mm/kasan/common.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index a581937c2a44..b82dbae0c5d6 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -441,16 +441,7 @@ void __kasan_poison_kfree(void *ptr, unsigned long ip)
>         struct page *page;
>
>         page = virt_to_head_page(ptr);
> -
> -       if (unlikely(!PageSlab(page))) {
> -               if (ptr != page_address(page)) {
> -                       kasan_report_invalid_free(ptr, ip);
> -                       return;
> -               }
> -               kasan_poison_memory(ptr, page_size(page), KASAN_FREE_PAGE);
> -       } else {
> -               ____kasan_slab_free(page->slab_cache, ptr, ip, false);
> -       }
> +       ____kasan_slab_free(page->slab_cache, ptr, ip, false);
>  }
>
>  void __kasan_kfree_large(void *ptr, unsigned long ip)
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
