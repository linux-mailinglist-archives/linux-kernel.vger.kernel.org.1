Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B5D2A0EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgJ3Tbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbgJ3Taq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:30:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED742C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 12:30:45 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b19so3459457pld.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 12:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Ew5qTvePmElYR26zs05QLzhONyFgn22aBK2jtdC+Ac=;
        b=kbvQq2bu4lw8s6ZlFZdrp42b5iCLDnYqyjw8qJA/JQyJJ521njP+/8Ls8NTNsroKjQ
         PMqbL/6EhyzxsIpMlm9DJmY27VxQ52ZsWNzkWfyCGbfetLkX8RsA6E7nk6IBEiN5gVkY
         6fqcTzlieo0MeLs1XsFSYzJIse4kCCkfItMBiEyT+KPXl+ZrtuSS3S9FbrJv6wrOM+pL
         L5aqICtTTWjrDc/gCkcnfGGqNAV7IynuGOE1EFpc2Mxn91OPc+KwDN9WuiHKnm8rgnF/
         NUWExEa5sFsa8CxN/nddSCRVjXXzbnN8LCVBjqknbWNRTxLLronXVDJ/xOfkOYXEMmbS
         tlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Ew5qTvePmElYR26zs05QLzhONyFgn22aBK2jtdC+Ac=;
        b=mGAwUWBRZTqZcdGxLQBgHAmz8+Ng9cMBrb5pBshw0zcOzO3RlpsGGToXoOQakPLCIM
         YiwOTyWmOvuQVtwi3Lf4jWAr2mQKEEMiWTj7L5+VoGet+xWjavvV5iFSpVLrS7iVaC4s
         f8EAXRwyJCNUNgrCtEZSYOFBvJ20WTM2ezwOitEmkEMdtWVjQe0FvVj+oh8jawazdcwp
         0Mhtv9e3u4ftf9IjR8JKa/MtBOoKddUV/LIBiOBgNlu9Fo9ovXfzL1BGAgv/rGP9ob6C
         t4CLmhIPUrbETGiaNWiDOLR/gn5/xPGd0WPF/6dEyGm68GRbmAXBEtxkGcuhhtJoCEHa
         7Avg==
X-Gm-Message-State: AOAM532owHfDp42YIBzT3FTMF+lNsj2T4k0bwx8kkhfpYFTgMD1HUbt8
        7H9XjEp7eb6wuD0sVHl+fKlc+MybrWKAFhd2y5DLyg==
X-Google-Smtp-Source: ABdhPJw+AJ9vY9gCO1eZzAXCPNNcS/g4EjgQgOXwojCYqyfhGmkG0nG75HKuZqLSl01Dywu1dkdnz3mEThwKk/no5Jg=
X-Received: by 2002:a17:902:9681:b029:d5:cdbd:c38c with SMTP id
 n1-20020a1709029681b02900d5cdbdc38cmr9755114plp.85.1604086245375; Fri, 30 Oct
 2020 12:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <6a4a7626bf280871518656f4fa89cb064740baf7.1603372719.git.andreyknvl@google.com>
 <CANpmjNPxUwrwAjN_c5sfBx5uE+Qf70B=8dbFcYPF2z1hWfpATg@mail.gmail.com>
In-Reply-To: <CANpmjNPxUwrwAjN_c5sfBx5uE+Qf70B=8dbFcYPF2z1hWfpATg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 30 Oct 2020 20:30:34 +0100
Message-ID: <CAAeHK+wF_BBSDukSPRTTc0N=OuFgKXquzthCxdR3Gq=p6jA9WQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 14/21] kasan: add and integrate kasan boot parameters
To:     Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
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
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 3:45 PM Marco Elver <elver@google.com> wrote:
>
> On Thu, 22 Oct 2020 at 15:19, Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > TODO: no meaningful description here yet, please see the cover letter
> >       for this RFC series.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/If7d37003875b2ed3e0935702c8015c223d6416a4
> > ---
> >  mm/kasan/common.c  |  92 +++++++++++++-----------
> >  mm/kasan/generic.c |   5 ++
> >  mm/kasan/hw_tags.c | 169 ++++++++++++++++++++++++++++++++++++++++++++-
> >  mm/kasan/kasan.h   |   9 +++
> >  mm/kasan/report.c  |  14 +++-
> >  mm/kasan/sw_tags.c |   5 ++
> >  6 files changed, 250 insertions(+), 44 deletions(-)
> >
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 1a5e6c279a72..cc129ef62ab1 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -129,35 +129,37 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> >         unsigned int redzone_size;
> >         int redzone_adjust;
> >
> > -       /* Add alloc meta. */
> > -       cache->kasan_info.alloc_meta_offset = *size;
> > -       *size += sizeof(struct kasan_alloc_meta);
> > -
> > -       /* Add free meta. */
> > -       if (IS_ENABLED(CONFIG_KASAN_GENERIC) &&
> > -           (cache->flags & SLAB_TYPESAFE_BY_RCU || cache->ctor ||
> > -            cache->object_size < sizeof(struct kasan_free_meta))) {
> > -               cache->kasan_info.free_meta_offset = *size;
> > -               *size += sizeof(struct kasan_free_meta);
> > -       }
> > -
> > -       redzone_size = optimal_redzone(cache->object_size);
> > -       redzone_adjust = redzone_size - (*size - cache->object_size);
> > -       if (redzone_adjust > 0)
> > -               *size += redzone_adjust;
> > -
> > -       *size = min_t(unsigned int, KMALLOC_MAX_SIZE,
> > -                       max(*size, cache->object_size + redzone_size));
> > +       if (static_branch_unlikely(&kasan_stack)) {
>
> I just looked at this file in your Github repo, and noticed that this
> could just be
>
> if (!static_branch_unlikely(&kasan_stack))
>     return;
>
> since the if-block ends at the function. That might hopefully make the
> diff a bit smaller.

Will do, thanks!
