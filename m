Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0282F3D51
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393306AbhALVgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437134AbhALVRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:17:30 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5133DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:16:50 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id j1so2121780pld.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LiS/Ah7gWBCj+VqG26e57TUr+FTn3EftEs4Z008F6g=;
        b=Tte5vz34Ez295H9ux5RiqtzRXjKmLGKaImkiavOzuENuH8a2CsP3SmS92MtBal8eUp
         sYDUR+bThu/Q5yWFGkJvZ2OKhjN5KcIGfqgtA6GQl9braYM0IWn3jsvE/mLYMC1o03ge
         h6rq9fDZshnS8HfvQ6HP7G9TV6SXofpF0/1RWFQMsyIxwDl+ajLsVOIXj3/Z57NghYDd
         Dn6ca1dOeV51P6owuT+ORL/XRhoQJL1KJiQdjtLklX+tlJCBA3hXi8a9a/rP06MEVe6C
         TMTkhQ2IvCJYfLX6Y/4ZDCPSsECnId8AVHQ2pibJAbnDZOtBGQ+MNrgRKDQaVY65qwsT
         u1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LiS/Ah7gWBCj+VqG26e57TUr+FTn3EftEs4Z008F6g=;
        b=QqZNhyy7pIGE55IMSRVHgfkSenP4iHH1nl65j80i2O2ddGYQ9Z5ETr7hqq9xCN7uTu
         Po0AA7x10v78M+m2KPhP1zXfb/c6OBfrZBHetarrxT+uI8GETaCMXlxPb0OWQ0Qu7hL6
         ICDDFQocH3gAKbA2Ldt+GSC12HmvtphHdHxI5Vb/0OvR05yK83KTzQdJcfJutadA4WHC
         9Kztc0xIxQXhzwXHiR/397dwT40nd91tfzjJtY42MEzWqBd2Ek9uCSnaVBLe6uGIiNHY
         IrXiU/A0Gdi6upu6Q+vrxY+teTP9rbvk3tC+S2XBdGk4aCwm6Qh0VDtNEZRny5ImMwa3
         OVww==
X-Gm-Message-State: AOAM532GfHsNNR47/Ho0iaKABoO9WVwdj76KkNaeVmtn3NE/9yyYYVKZ
        0kUVaSeBbziEtGxREgMJArUlCbuGN2/lX5ckIBlVCQ==
X-Google-Smtp-Source: ABdhPJwg8P4BII9dX3v26wdnHYhmLKAAAuqTIhWoAo7A3cJC9jHhaKbbI8B4c56F3QMnTil996ruTXdtanNOKjipg9w=
X-Received: by 2002:a17:90b:1087:: with SMTP id gj7mr1070271pjb.41.1610486209574;
 Tue, 12 Jan 2021 13:16:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <a83aa371e2ef96e79cbdefceebaa960a34957a79.1609871239.git.andreyknvl@google.com>
 <X/2zBibnd/zCBFa/@elver.google.com>
In-Reply-To: <X/2zBibnd/zCBFa/@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 12 Jan 2021 22:16:38 +0100
Message-ID: <CAAeHK+y0nmeDEWG8ZMX9KmE3-MhWCtrssDJi5oHG2PFNtrDK_g@mail.gmail.com>
Subject: Re: [PATCH 10/11] kasan: fix bug detection via ksize for HW_TAGS mode
To:     Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 3:32 PM Marco Elver <elver@google.com> wrote:
>
> > +/*
> > + * Unlike kasan_check_read/write(), kasan_check_byte() is performed even for
> > + * the hardware tag-based mode that doesn't rely on compiler instrumentation.
> > + */
>
> We have too many check-functions, and the name needs to be more precise.
> Intuitively, I would have thought this should have access-type, i.e.
> read or write, effectively mirroring a normal access.
>
> Would kasan_check_byte_read() be better (and just not have a 'write'
> variant because we do not need it)? This would restore ksize() closest
> to what it was before (assuming reporting behaviour is fixed, too).

> >  void kasan_poison(const void *address, size_t size, u8 value);
> >  void kasan_unpoison(const void *address, size_t size);
> > -bool kasan_check_invalid_free(void *addr);
> > +bool kasan_check(const void *addr);
>
> Definitely prefer shorted names, but we're in the unfortunate situation
> of having numerous kasan_check-functions, so we probably need to be more
> precise.
>
> kasan_check() makes me think this also does reporting, but it does not
> (it seems to only check the metadata for validity).
>
> The internal function could therefore be kasan_check_allocated() (it's
> now the inverse of kasan_check_invalid_free()).

Re: kasan_check_byte():

I think the _read suffix is only making the name longer. ksize() isn't
checking that the memory is readable (or writable), it's checking that
it's addressable. At least that's the intention of the annotation, so
it makes sense to name it correspondingly despite the implementation.

Having all kasan_check_*() functions both checking and reporting makes
sense, so let's keep the kasan_check_ prefix.

What isn't obvious from the name is that this function is present for
every kasan mode. Maybe kasan_check_byte_always()? Although it also
seems too long.

But I'm OK with keeping kasan_check_byte().

Re kasan_check():

Here we can use Andrew's suggestion about the name being related to
what the function returns. And also drop the kasan_check_ prefix as
this function only does the checking.

Let's use kasan_byte_accessible() instead of kasan_check().

> > +bool __kasan_check_byte(const void *address, unsigned long ip)
> > +{
> > +     if (!kasan_check(address)) {
> > +             kasan_report_invalid_free((void *)address, ip);
>
> This is strange: why does it report an invalid free? Should this be a
> use-after-free? I think this could just call kasan_report(....) for 1
> byte, and we'd get the right report.

Will fix in v2.

Thanks!
