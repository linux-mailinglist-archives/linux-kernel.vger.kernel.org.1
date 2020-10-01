Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6098E2809CA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733133AbgJAV5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbgJAV5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:57:21 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1376DC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 14:57:21 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w21so371579pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 14:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7vBVgkba9wR9rMzobTFcbe2FRbrTf2j7jPc/dQj28oc=;
        b=Qy1x+J2UXRT1xz2r7wKgRtNB1F4SYnCGvzWgd26HhDRfcJr5xRouppP6ZWTiuCc6Cx
         So404fYI4qWpTcEmcwCsqWAOAVMHLWpwfvpKKjZLHqMaPJhaHIC6GJlM6OoiyqpeYP3Y
         8+ZIL/Mu7VA7aTeF2dXkfNfXJ8CcRbbhIuxrI8G7JWsYlq1eZLiNiBHWdRnjI2k0pIIV
         niGwQi8egbLlBCdpeCOCYiVuz2OQ9zI01dk6pVJec4cOhEZq8958HWjrT9stMBGWUx+n
         BfzvxvsTOtcEoiVWPpioLnVRFXZs5KnakOVvvvikTbh2+eT9bnor5KoZ+CsXIv8sqRtE
         uZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7vBVgkba9wR9rMzobTFcbe2FRbrTf2j7jPc/dQj28oc=;
        b=SKaJJRgEKpdwp4h1ev/CIAaZ6Xaq+D80pUml2uxk+zLhf5HZQUyU+monmHmjRIroeo
         vJXfsVukJuBpNMMrRPwqGb0nYmRz3VsTzsVh+IGTN4yV7dEVWj3u6908bVweR76tvuc3
         1+ni1H6+2lSUsTGRNL7O9cjTHFOdizXP5TWnQhJtWwatUGns1Qqlt9hKy4B+Int8QjyP
         h0dRQzckimSgv6RwWry/0m9Ti7tzoqU4b9m0V42UI5irTp4mMKXygQHI/TqMs3GAanh2
         25e+HAlqIn7V9tsgOtkgWOeTlzbWKp5OnXtd0D05kkKEo0Kn/hm04vS9Ei0+bkTUGTe7
         2Q9A==
X-Gm-Message-State: AOAM5339f6y2Cy1JzbywbXxw7M1c4bOSorPPPVhnn8JaTx9b+x2mm3qm
        21tLe+EUgFieAxypCN68en5sjCv4Kq8sweOl5DeQCA==
X-Google-Smtp-Source: ABdhPJxBh2MTvD8EqS7uOHLoI01aNYVR8yybqeNK39O4VqSoTBwTqx0glwK0sWgJz6QKEWqjvaypPBIYu3G6Qbn+v7M=
X-Received: by 2002:a17:902:d716:b029:d3:8e2a:1b5d with SMTP id
 w22-20020a170902d716b02900d38e2a1b5dmr4556745ply.85.1601589440484; Thu, 01
 Oct 2020 14:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com> <d00f21f69ba7cb4809e850cf322247d48dae75ce.1600987622.git.andreyknvl@google.com>
 <20201001175539.GQ4162920@elver.google.com>
In-Reply-To: <20201001175539.GQ4162920@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 1 Oct 2020 23:57:09 +0200
Message-ID: <CAAeHK+ygFuqZyJKpKT6dqi8Suu3bnr_wP60ZwAQeLu6vSim+rA@mail.gmail.com>
Subject: Re: [PATCH v3 21/39] kasan: don't allow SW_TAGS with ARM64_MTE
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

On Thu, Oct 1, 2020 at 7:55 PM <elver@google.com> wrote:
>
> Does that patch title need an ", arm64" in it, like the others?

Yes, will fix in v4, thanks!

>
> On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> > Software tag-based KASAN provides its own tag checking machinery that
> > can conflict with MTE. Don't allow enabling software tag-based KASAN
> > when MTE is enabled.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> > Change-Id: Icd29bd0c6b1d3d7a0ee3d50c20490f404d34fc97
> > ---
> >  arch/arm64/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index e7450fbd0aa7..e875db8e1c86 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -131,7 +131,7 @@ config ARM64
> >       select HAVE_ARCH_JUMP_LABEL
> >       select HAVE_ARCH_JUMP_LABEL_RELATIVE
> >       select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
> > -     select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
> > +     select HAVE_ARCH_KASAN_SW_TAGS if (HAVE_ARCH_KASAN && !ARM64_MTE)
> >       select HAVE_ARCH_KGDB
> >       select HAVE_ARCH_MMAP_RND_BITS
> >       select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> > --
> > 2.28.0.681.g6f77f65b4e-goog
> >
