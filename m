Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A553229D9EA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390021AbgJ1XGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389878AbgJ1XGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:06:15 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0EAC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:06:14 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id a23so556492qkg.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k0QqM9Gt2pl6jLDvRzSessXwooNr3cWtYYZ1FieYU24=;
        b=IC28rilzqqsrEp1766X9/HXON3cweBNlB89913+HjG9ZI1Id6nQ7uhycq425wCCdlg
         ysIXl7n9+f4UqjZF5znoYD9XGgLQYr433ZC/zeTp7BXIuT0jMfaUeuc/1IVcaxpNFjSU
         yySCTVnWzHAXGR4crpxrWQ8Q/FgbsoKip1A5N7QhQ4nOPSk6CbbmVfDh0iI968pnpWkl
         efA4Rsf5fHfcTWKUCJzLKNK4G2GFARZ5nTxMw7JwNEXrJUTJsMArGQ3krDp1KDNuHuGF
         xdt/2VWtxETmcaOSjRWLZeQboSx/s6yvFs/5IXFL1mO9gvfDvXgwxmhl9rn6LO2oCcDq
         2dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k0QqM9Gt2pl6jLDvRzSessXwooNr3cWtYYZ1FieYU24=;
        b=dxeDdGk+lBcM663MYit+YBHC3uW6Bl7qPgWyarn/AV5EyUlhAF5z0qKwqZCkOBA0tW
         SCW0h2fGYGHjdO9QcAL6LnRaSJwvMKf2jhVAauLM35VozqXVaZVbYWfMNLpMeHqUn86H
         Y4+ywX/3B/JFJGACBFnvBSvTDXS9UnhkY+hThvDqlJmzjJRE7JmY8POV1PY1ECuYSREb
         FYKPumIJ4IzDTaL+3P4Y8ORyd4GamccdA2g7eQ69pQFiKWa7yD7UqdaLGishL0c+qbb5
         c20sd9PRFquKQOjm1fWY/CUaRNEBi44gwSK2PjgYY26mOYu8YPT5Kj04MebJ2iac7SDZ
         Q04g==
X-Gm-Message-State: AOAM533foG2fWRNQkz7ZkJZvZYGzfBay+llAvXjuIXqwRPgMMEhwIwtb
        EH22/0M+sg2kiynsj60jbNq87KIg83PknCk981GVQBvV1CJdGQ==
X-Google-Smtp-Source: ABdhPJwW3VpC/kud5eUeUVpQz0YtVDpP6Sm44lKpXCyhNU7lezh+1Hk8awqCP/oXPLSEogdEFn3mYe6sB/MLIR84L6g=
X-Received: by 2002:ac8:46d5:: with SMTP id h21mr2208954qto.290.1603904520912;
 Wed, 28 Oct 2020 10:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <f48f800933dacfc554d9094d864a01688abcbffd.1603372719.git.andreyknvl@google.com>
In-Reply-To: <f48f800933dacfc554d9094d864a01688abcbffd.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 18:01:49 +0100
Message-ID: <CACT4Y+bx=3JCqR3GPrEUjbRFdOTQCCBofx0jd_g2Ldi+L7-iKg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 19/21] kasan: don't round_up too much
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
> For tag-based mode kasan_poison_memory() already rounds up the size. Do
> the same for software modes and remove round_up() from common code.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Ib397128fac6eba874008662b4964d65352db4aa4

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  mm/kasan/common.c | 8 ++------
>  mm/kasan/shadow.c | 1 +
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 5622b0ec0907..983383ebe32a 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -215,9 +215,7 @@ void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
>
>  void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
>  {
> -       kasan_poison_memory(object,
> -                       round_up(cache->object_size, KASAN_GRANULE_SIZE),
> -                       KASAN_KMALLOC_REDZONE);
> +       kasan_poison_memory(object, cache->object_size, KASAN_KMALLOC_REDZONE);
>  }
>
>  /*
> @@ -290,7 +288,6 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>  {
>         u8 tag;
>         void *tagged_object;
> -       unsigned long rounded_up_size;
>
>         tag = get_tag(object);
>         tagged_object = object;
> @@ -311,8 +308,7 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>                 return true;
>         }
>
> -       rounded_up_size = round_up(cache->object_size, KASAN_GRANULE_SIZE);
> -       kasan_poison_memory(object, rounded_up_size, KASAN_KMALLOC_FREE);
> +       kasan_poison_memory(object, cache->object_size, KASAN_KMALLOC_FREE);
>
>         if (static_branch_unlikely(&kasan_stack)) {
>                 if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 616ac64c4a21..ab1d39c566b9 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -82,6 +82,7 @@ void kasan_poison_memory(const void *address, size_t size, u8 value)
>          * addresses to this function.
>          */
>         address = reset_tag(address);
> +       size = round_up(size, KASAN_GRANULE_SIZE);
>
>         shadow_start = kasan_mem_to_shadow(address);
>         shadow_end = kasan_mem_to_shadow(address + size);
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
