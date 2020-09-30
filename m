Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EC027F07C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbgI3RZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 13:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3RZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:25:52 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5343AC0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:25:52 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x22so1607953pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0nfehHdUPTyFK6XAv2rP7KrvsGMS/er2RZ8KJpBo5Yc=;
        b=Ey0Oc7klaeUxyEKTAIUl26BnK80EH68bvF8nfKE4xeNamFC2OcklPOlhknQy3v1Pnq
         w0Ye1S2ZW7nXXV8UmqJZ1F4gLLia+npAjNi5ZjpoZVUOa/nt+6uaboX09rCTLh/BPAZa
         u4PknGxYHr39Wa+qoDVRY+YsAPf3YouOFmwHrnUQODBEhQoftQRXvNdNLNktx4M0UXI9
         crFy3OPf97GDsQqnp1p6bn9/iPlM0eI9EDwdS68lnu1FdG0KByISHfuPqvvdfHsHewIO
         d+DHVq3EqIUmH/7k5xu0Liv6SLMjeirYFUVOTFpYKV9JOiXCEDVziCFC+9BZZMLFuxRp
         9JfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0nfehHdUPTyFK6XAv2rP7KrvsGMS/er2RZ8KJpBo5Yc=;
        b=TtA3UQ27fktqFv8C0d/TllAxPgVZhZQJrESpuLIW45Sd+UiGTUI+d9wIU6cJB2IBj/
         e7H/edfZD5NyXj9z61NF1YdORtl0gmgUwlee3kGmy36QnannfBFVVfImO9ySsG7z6kAm
         ZYgjV3EnQgKt39FraG+aLwHLBst89bDK7MRcRX+cdYQ1bersgbEGNmDxoCEjdC3rxpfr
         8AiFc91BM4vsbBhrSEGCN0JqZL0KB5deWUdkFqvIEPaKSEJ3krgYBNg0oxn2XZK2bein
         K7tBpEsz1zy3yYqoxXevUSgGgN0XH9dElcq1IC+NAR/9xFh+i9/qMhwH6oP6zK2V+UDt
         DnNg==
X-Gm-Message-State: AOAM531RahCICC0kQ5SO/bw9YzDK3TVzvOODv+fG8d125G1f+B0g+8PT
        p1JSFAgPP2w7Mila8tdHwVKMpqBkO38VVFh7bq/OPw==
X-Google-Smtp-Source: ABdhPJyGGvMZbaWLjGNvCwq/htmj/g6cZhOsPNY2TlA1j09zWlwE6vmsaVIDEY26ogWxIvIKGTJaJKsK0fDPHQRsVJ4=
X-Received: by 2002:a62:d44e:0:b029:13c:1611:652f with SMTP id
 u14-20020a62d44e0000b029013c1611652fmr3293347pfl.15.1601486751602; Wed, 30
 Sep 2020 10:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkHzbPjw71n+RVXuM6Wt6PNO6fiy+14QTzthF7MCkewwg@mail.gmail.com>
 <CA+icZUWvEzUhCjkMYAK22pkjshKmfE4a2y_W0sPPuqRtzXOtNw@mail.gmail.com>
 <CAFP8O3LQSS4BufLEPQKOk62T0d8HoZq0kQAU8+K4d4gpY4CPag@mail.gmail.com>
 <CA+icZUU44tbsmGfTc-2OO42V42Z02dRSs7AZCJBnXL65vJDz-Q@mail.gmail.com>
 <664e5923-d65e-0a3a-1320-8b6635146676@redhat.com> <CAKwvOdkiSLidxNxWUxCrJ_rPogORt=aGDHTkbO=yJn0FPevbpw@mail.gmail.com>
In-Reply-To: <CAKwvOdkiSLidxNxWUxCrJ_rPogORt=aGDHTkbO=yJn0FPevbpw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 30 Sep 2020 10:25:40 -0700
Message-ID: <CAKwvOdmFm9-FPrqt42NsusWRbDzNx6NF1GeSJhz_9kaAGV8eOA@mail.gmail.com>
Subject: Re: linux tooling mailing list
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Clifton <nickc@redhat.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, postmaster@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know who's behind postmaster@vger.kernel.org?  Maybe I can
email them directly if perhaps they don't check this email often?
(Benefit of the doubt)

On Tue, Sep 15, 2020 at 1:49 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Hello postmaster,
> Any thoughts on linux-toolchains@vger.kernel.org?
>
> On Wed, Aug 26, 2020 at 3:14 AM Nick Clifton <nickc@redhat.com> wrote:
> >
> > Hi Guys,
> >
> > >>>> Would it be possible to setup:
> > >>>> linux-tooling@vger.kernel.org
> >
> > >>> s/linux-tooling/linux-toolchains (better plural toolchains)
> >
> > >> FWIW FreeBSD names it "freebsd-toolchain".
> > >> NetBSD names it "tech-toolchain".
> > >>
> > >> I'd slightly prefer the singular form.
> >
> > > OK with singular form.
> > >
> > > I was thinking of GNU and LLVM toolchain*s* - that's why the plural.
> >
> > Personally I prefer the plural too, but it is not a big issue.
> >
> > I am however delighted that it looks like this idea will go ahead.
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
