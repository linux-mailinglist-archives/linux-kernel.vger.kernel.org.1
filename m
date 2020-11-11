Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C162AF465
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgKKPGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgKKPGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:06:30 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6C0C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:06:29 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id d28so1885769qka.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=58st//mhI/fJn9QMBMlM7AWMjgnTnsXCK83D1v/z6LQ=;
        b=HvYqEhf59pq4f5pCn918VmdSxoS0ERCk5B4CQHxKSV84bR5tT9WmR3Tck6UMnlXFMk
         tN4c83qMgVm6c+DC2akoYwVQzBz+dDB/nKSaRioSE9QMkPCKisCbAwRMpoAn0G/hWIwm
         laQy2lXazX+bY9fQX/bdfu7xCCkwC+YirMaz5x9ze8MlStNsYCVpT0eabCCJXtvaTwT7
         rZFi04H6XOmW6SCS8S2MmmolS2bAxy6jU7+kot7P4LlkmIeL7nCmLv2YoB0ejm8Q84Tf
         ySZCb5TTp9izjUeikvpU3ahdXUmR+2W4T0adHg6Mwr4g8ldOHVkZxt9GyTuGCjzJQAg4
         Y/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=58st//mhI/fJn9QMBMlM7AWMjgnTnsXCK83D1v/z6LQ=;
        b=STIJTJw+JvCD5OVsMxAMznXS+EBi/waBJ6PZU7zC6uY+JDtu+06Zhf98Cv+/s1RuVR
         uIMkqX9F9yLUoZOV9TBt1JZ9mCN5HE1FnIeYtu+a3HBqkdLj4HBTvA7kHQyly9pgSLdf
         upVDOqQxg8HmREwb25hxGMJJN3f6motLUoRo7IdODYKx9/xKWy0Gpp+o2LP9bxg9CQ23
         F7lfsAUPrKq8Ruogu311zo0R4DxFtZYAIWku85ylTgKUACGbt4BLbRjZeO3YR+fdUItK
         LxSbwyE6x8PEUlSsXl/hm9um10IsHYwd6wUTcWD+SUknB+mN8VAHYfr2X61GBtBhFeai
         exSw==
X-Gm-Message-State: AOAM533LS6TqhrXUNF3X6bCNvcYpKhIGs9HDLJMbmGlx69qtYUR1rCnM
        1PJidm2h8JSoyzMv4XdcG3YhfTmSOM/+B+XC5HJemQ==
X-Google-Smtp-Source: ABdhPJzFZWCdVRVlixYqm2kPKSCFkMUfnC6cT7kRx4slKaZWhrjCJZliqDp0sjDUD4M+UcUb4fOC+c6dljTQxYN1nqE=
X-Received: by 2002:a37:4552:: with SMTP id s79mr19370022qka.6.1605107188820;
 Wed, 11 Nov 2020 07:06:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <1034f823921727b3c5819f6d2cdfc64251476862.1605046192.git.andreyknvl@google.com>
In-Reply-To: <1034f823921727b3c5819f6d2cdfc64251476862.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 16:06:16 +0100
Message-ID: <CAG_fn=VZBf8QwocHwcupo-9b6BnikAMQTuKFe1pTZwimSViqCQ@mail.gmail.com>
Subject: Re: [PATCH v9 19/44] kasan: rename addr_has_shadow to addr_has_metadata
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
> Hardware tag-based KASAN won't be using shadow memory, but will reuse
> this function. Rename "shadow" to implementation-neutral "metadata".
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
> ---
> Change-Id: I03706fe34b38da7860c39aa0968e00001a7d1873
> ---
>  mm/kasan/kasan.h          | 2 +-
>  mm/kasan/report.c         | 6 +++---
>  mm/kasan/report_generic.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index d0cf61d4d70d..f9366dfd94c9 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -146,7 +146,7 @@ static inline const void *kasan_shadow_to_mem(const v=
oid *shadow_addr)
>                 << KASAN_SHADOW_SCALE_SHIFT);
>  }
>
> -static inline bool addr_has_shadow(const void *addr)
> +static inline bool addr_has_metadata(const void *addr)
>  {
>         return (addr >=3D kasan_shadow_to_mem((void *)KASAN_SHADOW_START)=
);
>  }
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index af9138ea54ad..2990ca34abaf 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -361,7 +361,7 @@ static void __kasan_report(unsigned long addr, size_t=
 size, bool is_write,
>         untagged_addr =3D reset_tag(tagged_addr);
>
>         info.access_addr =3D tagged_addr;
> -       if (addr_has_shadow(untagged_addr))
> +       if (addr_has_metadata(untagged_addr))
>                 info.first_bad_addr =3D find_first_bad_addr(tagged_addr, =
size);
>         else
>                 info.first_bad_addr =3D untagged_addr;
> @@ -372,11 +372,11 @@ static void __kasan_report(unsigned long addr, size=
_t size, bool is_write,
>         start_report(&flags);
>
>         print_error_description(&info);
> -       if (addr_has_shadow(untagged_addr))
> +       if (addr_has_metadata(untagged_addr))
>                 print_tags(get_tag(tagged_addr), info.first_bad_addr);
>         pr_err("\n");
>
> -       if (addr_has_shadow(untagged_addr)) {
> +       if (addr_has_metadata(untagged_addr)) {
>                 print_address_description(untagged_addr, get_tag(tagged_a=
ddr));
>                 pr_err("\n");
>                 print_shadow_for_address(info.first_bad_addr);
> diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
> index b543a1ed6078..16ed550850e9 100644
> --- a/mm/kasan/report_generic.c
> +++ b/mm/kasan/report_generic.c
> @@ -118,7 +118,7 @@ const char *get_bug_type(struct kasan_access_info *in=
fo)
>         if (info->access_addr + info->access_size < info->access_addr)
>                 return "out-of-bounds";
>
> -       if (addr_has_shadow(info->access_addr))
> +       if (addr_has_metadata(info->access_addr))
>                 return get_shadow_bug_type(info);
>         return get_wild_bug_type(info);
>  }
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
