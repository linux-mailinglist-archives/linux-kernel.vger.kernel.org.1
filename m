Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878532AE370
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbgKJWkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732123AbgKJWkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:40:11 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B67DC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:40:11 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id y7so181124pfq.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NRHRA3dKhIbMgb5WL8qK9dto+UXsm4X1NyrdOoYkubs=;
        b=Kad0oMCetDBD359mRaATbdWv2pomotW5/Yn01pwT8iBS3NuvNojaW8ID+DXfDit87Q
         2zTGODEuB8OBXXBsuLpAQUahyBJ1eobfNOTflDzkK/OqdRW8Y/M8DKn84oMS9f7NFgYv
         2exY/LAIJ7eCw4oabwKobO7EbysTpvfbuOEXA58r6EARcW//3dnGDOW+53VIDruksULz
         WbL2phMowO9ZPpvayKTRLLg60wc87W9n0mOZX7XaQqw9oEAIjXoHuhLjHhiDfh0Wcari
         5hCZFn8RRY6TAfquR4Bhriu6+Jdds929nDdMdt0J3Fad859IidR2dcltBomiBG+IyIP2
         48eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NRHRA3dKhIbMgb5WL8qK9dto+UXsm4X1NyrdOoYkubs=;
        b=YIlxj8JJ6QnbK5O4UZYh3/o7UVRsNKlAJmTL6Ru5HodcdvI8qztYJUBzn/I2HrIHU9
         dDtp9GmvJl7l/30vfce6xYg6xaHbWwvCMoD0uQZpcOsYSbX8Ep124ja2nv6u2Kq0XPOl
         S7eloH4cYJv2Y89XViDkEB5SzjRFWKOGqxmcs9boKRcOYfu6psKen3NRfnaUsfanE8Uv
         OfMNoHCR8G3B/OtuoNv0PkFN9WSB871+5MNjppEUuP7UzLcf2z0JLKGqzRfNZnNHbcbI
         1sI1veHRSfimax+3c1KRKCeN3/FshdveNo+vi09e9Hd6M3q3JuTrhxft03EECy/51PDi
         hk+w==
X-Gm-Message-State: AOAM532/dU+hn9x4c1YKXwB8palKE75WHSwUkoxIC/N5FTVXIqfLIHq4
        X3i/nriue0jXU5EGn1PaiQKFG4Udr5Bk0paf3zpOqA==
X-Google-Smtp-Source: ABdhPJwI01Z/nJWUuZlFIciJdgc5tPQghLrXc8NRSLyMtayRzCR9HkW62daIzJwoS9rPzd8kSbAtB38CiiiJZUmLqx4=
X-Received: by 2002:a17:90a:4881:: with SMTP id b1mr430686pjh.32.1605048010845;
 Tue, 10 Nov 2020 14:40:10 -0800 (PST)
MIME-Version: 1.0
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com> <20201106101419.GB3811063@ubuntu-m3-large-x86>
 <87wnyyvh56.fsf@collabora.com> <CAKwvOdkodob0M0r_AK_4nG3atLGMyNENMd6qVAHSPa92Zh7UZA@mail.gmail.com>
 <871rh2i9xg.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOdkm3u83TQDBB-fC0TwKZCFXGh5sAfahKXxA+mnzgDid_w@mail.gmail.com>
 <20201110221511.GA1373528@rani.riverdale.lan> <CAKwvOd=NQ==umC+N_Sgji5HCCFTRARh4jWiB3DaBfV6jDd5cRg@mail.gmail.com>
 <CAKwvOdmsCY8Hb6t8t9jW5DKCZKbja27bGufO=tw3+-UuTTFBOQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmsCY8Hb6t8t9jW5DKCZKbja27bGufO=tw3+-UuTTFBOQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 10 Nov 2020 14:39:59 -0800
Message-ID: <CAKwvOd=6nPUvUY6XJULmkZywHJG2kfu46h7=Zm18j9O30ovdpw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: lib: xor-neon: disable clang vectorization
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 2:39 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Nov 10, 2020 at 2:36 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Tue, Nov 10, 2020 at 2:15 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Tue, Nov 10, 2020 at 01:41:17PM -0800, Nick Desaulniers wrote:
> > > > On Mon, Nov 9, 2020 at 11:51 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> > > > >
> > > > > On Fri, 06 Nov 2020, Nick Desaulniers <ndesaulniers@google.com>
> > > > > wrote:
> > > > > > +#pragma clang loop vectorize(enable)
> > > > > >         do {
> > > > > >                 p1[0] ^= p2[0] ^ p3[0] ^ p4[0] ^ p5[0]; p1[1] ^=
> > > > > >                 p2[1] ^ p3[1] ^ p4[1] ^ p5[1];
> > > > > > ``` seems to generate the vectorized code.
> > > > > >
> > > > > > Why don't we find a way to make those pragma's more toolchain
> > > > > > portable, rather than open coding them like I have above rather
> > > > > > than this series?
> > > > >
> > > > > Hi again Nick,
> > > > >
> > > > > How did you verify the above pragmas generate correct vectorized
> > > > > code?  Have you tested this specific use case?
> > > >
> > > > I read the disassembly before and after my suggested use of pragmas;
> > > > look for vld/vstr.  You can also add -Rpass-missed=loop-vectorize to
> > > > CFLAGS_xor-neon.o in arch/arm/lib/Makefile and rebuild
> > > > arch/arm/lib/xor-neon.o with CONFIG_BTRFS enabled.
> > > >
> > >
> > > https://godbolt.org/z/1oo9M6
> > >
> > > With the __restrict__ keywords added, clang seems to vectorize the loop,
> > > but still reports that vectorization wasn't beneficial -- any idea
> > > what's going on?
>
> Anyways, it's not safe to make that change in the kernel unless you
> can guarantee that callers of these routines do not alias or overlap.

s/callers/parameters passed by callers/

>
> >
> > I suspect that loop-vectorize is a higher level pass that relies on
> > slp-vectorizer for the transform.
> >
> > $ clang -O2 --target=arm-linux-gnueabi -S -o - foo.c -mfpu=neon -mllvm
> > -print-after-all
> > ...
> > *** IR Dump After SLP Vectorizer ***
> > (bunch of <4 x i32> types)
> >
> > If you add -Rpass-missed=slp-vectorizer, observe that the existing
> > warnings from -Rpass-missed=loop-vectorize disappear; I suspect
> > loop-vectorize will print a "remark" if passes it calls did not, but
> > returned some for of error code.
> >
> > -Rpass=slp-vectorizer shows that it vectorizes two sequences of the
> > loop, and warns that some third portion (that's
> > non-immediately-obvious to me) was non beneficial.
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
