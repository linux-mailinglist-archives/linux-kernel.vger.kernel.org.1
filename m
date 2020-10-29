Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866B629F5EF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgJ2UOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJ2UOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:14:24 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A073C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:14:24 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c20so3284329pfr.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l77n7oC/IyxQLfCBGbQpiCRFFdLcSomb1vOdKMROYRs=;
        b=ds1NXPTLGAXIZvjdJi8ugrSM70FcHWuCIwYhaH9mhI0HA2QijV79tt6Un83nE1oEtt
         r7Y+dzoiRxdMlrHyTfcqQgImddaXj3XlqhWWqsGwcu2xttvbypodQ1yJ26YGBEA+aWJP
         mQVxPDIZ7xqLXmW0cU4LeyBmE5rqJ3Qsjglgq/rJdcwLdvHOMRLoRB9p7k0aJqp8svWb
         OngF2h0IigTb1bVv+YWfkgUqjB+yFO3CJ20NB1RewecioLbCJiogpIK/WlBmbXLKzkS/
         dtLY/IYCtE5jowS4o6YN5IOIJWOUNzK8/oVJfM8zhr8DkB6vxsF6wOITqqPRSAUzKKT3
         3hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l77n7oC/IyxQLfCBGbQpiCRFFdLcSomb1vOdKMROYRs=;
        b=g/rpx1vDBYei3NF1n/3qFVItJgWEx2fzQ7RcNjy3+YqqmfQ/G2dwOIjyDW59WDh8tv
         HsmRgmFLzjBPfxFvIZoiQKzmqZA8ZowY1gAGcLFRy6IJs7O1QaY2C5twTgfRLku+hSxD
         Cd95JiQvO3IlbYyGa7FXJDTX85UW1eT+I7Ug8ddSvlNYXbwNDSHWTwQRL6lYWQ5iTkX9
         G1wxr4Uh0AI8/50SpzOKsKqxvcUyQT+JHe2x7J04FfKkXARJpCpUgcfmsHi3mpg4K5Y8
         u4o9NQVIhlp996FCIio1bnyjZOOrqM3ByF6839nAWW0I95KW8RNOZTPAHE2rz0IX4ztC
         i/jw==
X-Gm-Message-State: AOAM532jan4pyS+C3pL/TY190i5HjJEhNnUkbXBJzaq6H2+lRXf8ELjl
        Ske5oMTx/FG2uTnhMteKIzwPcLY0XLRrPvjo0oDw6w==
X-Google-Smtp-Source: ABdhPJx9GJFDbjQtalHbXpz4QpT9HD1QKsnubeBrC4C75nQUTCYmo2axiD2dLWceppBeCeuRufluBFF+z94cSUugzCc=
X-Received: by 2002:a17:90a:cb92:: with SMTP id a18mr1508972pju.136.1604002463411;
 Thu, 29 Oct 2020 13:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <1d87f0d5a282d9e8d14d408ac6d63462129f524c.1603372719.git.andreyknvl@google.com>
 <CACT4Y+Y6jbXh28U=9oK_1ihMhePRhZ6WP9vBwr8nVm_aU3BmNQ@mail.gmail.com>
In-Reply-To: <CACT4Y+Y6jbXh28U=9oK_1ihMhePRhZ6WP9vBwr8nVm_aU3BmNQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 29 Oct 2020 21:14:12 +0100
Message-ID: <CAAeHK+wqdtPkrhbxPanu79iCJxdYczKQ6k7+8u-hnC5JONEgNQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 07/21] kasan, arm64: move initialization message
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Wed, Oct 28, 2020 at 11:56 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > Tag-based KASAN modes are fully initialized with kasan_init_tags(),
> > while the generic mode only requireds kasan_init(). Move the
> > initialization message for tag-based modes into kasan_init_tags().
> >
> > Also fix pr_fmt() usage for KASAN code: generic mode doesn't need it,
>
> Why doesn't it need it? What's the difference with tag modes?

I need to reword the patch descriptions: it's not the mode that
doesn't need it, it's the generic.c file, as it doesn't use any pr_*()
functions.

>
> > tag-based modes should use "kasan:" instead of KBUILD_MODNAME.
>
> With generic KASAN I currently see:
>
> [    0.571473][    T0] kasan: KernelAddressSanitizer initialized
>
> So KBUILD_MODNAME somehow works. Is there some difference between files?

That code is printed from arch/xxx/mm/kasan_init*.c, which has its own
pr_fmt defined.

>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/Idfd1e50625ffdf42dfc3dbf7455b11bd200a0a49
> > ---
> >  arch/arm64/mm/kasan_init.c | 3 +++
> >  mm/kasan/generic.c         | 2 --
> >  mm/kasan/hw_tags.c         | 4 ++++
> >  mm/kasan/sw_tags.c         | 4 +++-
> >  4 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> > index b6b9d55bb72e..8f17fa834b62 100644
> > --- a/arch/arm64/mm/kasan_init.c
> > +++ b/arch/arm64/mm/kasan_init.c
> > @@ -290,5 +290,8 @@ void __init kasan_init(void)
> >  {
> >         kasan_init_shadow();
> >         kasan_init_depth();
> > +#if defined(CONFIG_KASAN_GENERIC)
> > +       /* CONFIG_KASAN_SW/HW_TAGS also requires kasan_init_tags(). */
>
> A bit cleaner way may be to introduce kasan_init_early() and
> kasan_init_late(). Late() will do tag init and always print the
> message.

It appears we'll also need kasan_init_even_later() for some
MTE-related stuff. I'll try to figure out some sane naming scheme here
and include it into the next version.
