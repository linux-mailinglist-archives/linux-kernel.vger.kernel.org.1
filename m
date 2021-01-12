Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB7C2F3F96
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394900AbhALWzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394889AbhALWzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:55:36 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82067C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:54:55 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id o11so105526ote.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/vYKtRUvIW2ynJjXb8EKOHINwCaI0vhIQWTSSZNFGWc=;
        b=Ww3KXfMqu1sID+h6joR8rNOtxPU4PNA7tn8XQ8NBQKSBnKwNcJ6+X9lq3PpgN+hH5C
         eAVVZ27v93yjtmKeKXFIUb5YpFgwY2sQVx6nMZ/K/nz+d7jZgnft0bnPIKAo07hmdX7J
         qbHJVc9RSX4qi+51lMX4wjcktwZk7Yk/hAGcsbs/yRKDvMJfFPaI4/DqV2cu84/SRYFA
         shVTnQRqHvqvXPEQuPPvZNWU8mD2p+mplAQHF/36TQLzIcLVCbvzbD2rhirHROBQ9T/l
         kGt5XvlCgeXjbrLIOMyKiG9+XIqT8r+iT+JwiyfHZq12hQBLJTa/QDWoUy8F1abiwCD4
         hZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vYKtRUvIW2ynJjXb8EKOHINwCaI0vhIQWTSSZNFGWc=;
        b=Umpv6A0HVxt4vavOZanjeRmIojCvg6PYBteZDWQd+72IbSx9g9c+Ws+/pfgsj0mPQc
         xoV0Yekh2Zi0XvZvJNZrld7/y93JCki7qGyggkvJYFneP/To/8rtNNTNzR137NFZ9SAj
         f1GC/ztPTORlB8RrBd5+kdYchoKhNZQuGagYttptInaBQJqJ1t9jWG81+DunNJ6WztEf
         hIfp0uZGQTqCgLNi6GZBr99clMTW+sCQ8siSvuqKwP40VHgfFqHSH4jGPcYKq1I6VcOV
         ap1uyOn7UnV8tBI35MoqS61EouO7EPIoDYV2YcQapBjpDcQMk5DIYIpQUfHOAMGAFnuc
         N2Ig==
X-Gm-Message-State: AOAM533bKedNXWbbHVVv1MtStT73xXLNsG7gkAtM1BYcfc83vZd1vdXA
        /ujyv43zaKevnMdOW21NMxdyE/ul8E+W9WKCvXu8Rw==
X-Google-Smtp-Source: ABdhPJzwgdUScBJYneAEXMBmswPtj1jt0k0m1Q8bFyR9znqR0OjkiLU8szsYkKQ3VBpF3LCBnWH9up1VjI4lQJISCQ8=
X-Received: by 2002:a05:6830:19ca:: with SMTP id p10mr1108587otp.233.1610492094692;
 Tue, 12 Jan 2021 14:54:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <a83aa371e2ef96e79cbdefceebaa960a34957a79.1609871239.git.andreyknvl@google.com>
 <X/2zBibnd/zCBFa/@elver.google.com> <CAAeHK+y0nmeDEWG8ZMX9KmE3-MhWCtrssDJi5oHG2PFNtrDK_g@mail.gmail.com>
In-Reply-To: <CAAeHK+y0nmeDEWG8ZMX9KmE3-MhWCtrssDJi5oHG2PFNtrDK_g@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Jan 2021 23:54:43 +0100
Message-ID: <CANpmjNNfLG-iCJY9=ogiozYGmEat0U=huMpTO4RrC0LebOdmkQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] kasan: fix bug detection via ksize for HW_TAGS mode
To:     Andrey Konovalov <andreyknvl@google.com>
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

On Tue, 12 Jan 2021 at 22:16, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Tue, Jan 12, 2021 at 3:32 PM Marco Elver <elver@google.com> wrote:
> >
> > > +/*
> > > + * Unlike kasan_check_read/write(), kasan_check_byte() is performed even for
> > > + * the hardware tag-based mode that doesn't rely on compiler instrumentation.
> > > + */
> >
> > We have too many check-functions, and the name needs to be more precise.
> > Intuitively, I would have thought this should have access-type, i.e.
> > read or write, effectively mirroring a normal access.
> >
> > Would kasan_check_byte_read() be better (and just not have a 'write'
> > variant because we do not need it)? This would restore ksize() closest
> > to what it was before (assuming reporting behaviour is fixed, too).
>
> > >  void kasan_poison(const void *address, size_t size, u8 value);
> > >  void kasan_unpoison(const void *address, size_t size);
> > > -bool kasan_check_invalid_free(void *addr);
> > > +bool kasan_check(const void *addr);
> >
> > Definitely prefer shorted names, but we're in the unfortunate situation
> > of having numerous kasan_check-functions, so we probably need to be more
> > precise.
> >
> > kasan_check() makes me think this also does reporting, but it does not
> > (it seems to only check the metadata for validity).
> >
> > The internal function could therefore be kasan_check_allocated() (it's
> > now the inverse of kasan_check_invalid_free()).
>
> Re: kasan_check_byte():
>
> I think the _read suffix is only making the name longer. ksize() isn't
> checking that the memory is readable (or writable), it's checking that
> it's addressable. At least that's the intention of the annotation, so
> it makes sense to name it correspondingly despite the implementation.
>
> Having all kasan_check_*() functions both checking and reporting makes
> sense, so let's keep the kasan_check_ prefix.
>
> What isn't obvious from the name is that this function is present for
> every kasan mode. Maybe kasan_check_byte_always()? Although it also
> seems too long.
>
> But I'm OK with keeping kasan_check_byte().

This is fine.

> Re kasan_check():
>
> Here we can use Andrew's suggestion about the name being related to
> what the function returns. And also drop the kasan_check_ prefix as
> this function only does the checking.
>
> Let's use kasan_byte_accessible() instead of kasan_check().

Sounds reasonable to me.

Thanks,
-- Marco
