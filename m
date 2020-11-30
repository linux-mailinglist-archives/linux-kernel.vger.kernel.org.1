Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24A62C81E8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgK3KN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:13:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgK3KN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:13:26 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57F8620809
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606731165;
        bh=eCUETalD/NcLpujA9DtX7X6qzQsHoAvyBmr7tnSAe5c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=At+/KB3mfNqORmXhCgsJu1IslZMkPq2g2dq29DMj8VhduK13dqTENaOdsnBm9GIk3
         OSxjL7eT9BY7sQ3L4Cuvs0zoR0/0FmYY7hUY5wYrElc68UVayPYP4B7HEx5IAv41JY
         1TNP5X/RAChGYLX+RYCt4ls2BDTnSXMU/AnszG14=
Received: by mail-oi1-f170.google.com with SMTP id j15so13578899oih.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 02:12:45 -0800 (PST)
X-Gm-Message-State: AOAM530jtAjvKsYsYEI5c/Wp36oVFHfGGV29bZSSgEOqbJkJagArWX9s
        1my9rDIPFqL7RiXGePSJCeNHQ7DdNvLuVfOfB/U=
X-Google-Smtp-Source: ABdhPJw7agH1J9mRqPoEcuF5EwI+rz4S23vvfseQsBavAns87GFzEmg2UujLqT4Pry/psFAS2+eHym90f/Olgq8ENcs=
X-Received: by 2002:aca:b809:: with SMTP id i9mr14179188oif.174.1606731164557;
 Mon, 30 Nov 2020 02:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20201123073634.6854-1-swpenim@gmail.com> <CAMj1kXGsQ9K57SvZ74pmD+_=338sGXjc_t+hCXMh-9BPanXnhA@mail.gmail.com>
In-Reply-To: <CAMj1kXGsQ9K57SvZ74pmD+_=338sGXjc_t+hCXMh-9BPanXnhA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 30 Nov 2020 11:12:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGs-woGGnM2QkhY5NbRRKP8_N4BY9ScBtga8mcyHoK2+A@mail.gmail.com>
Message-ID: <CAMj1kXGs-woGGnM2QkhY5NbRRKP8_N4BY9ScBtga8mcyHoK2+A@mail.gmail.com>
Subject: Re: [RESEND,PATCH] ARM: fix __div64_32() error when compiling with clang
To:     Antony Yu <swpenim@gmail.com>, Nicolas Pitre <nico@fluxnic.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Nico)

On Mon, 30 Nov 2020 at 11:11, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 23 Nov 2020 at 08:39, Antony Yu <swpenim@gmail.com> wrote:
> >
> > __do_div64 clobbers the input register r0 in little endian system.
> > According to the inline assembly document, if an input operand is
> > modified, it should be tied to a output operand. This patch can
> > prevent compilers from reusing r0 register after asm statements.
> >
> > Signed-off-by: Antony Yu <swpenim@gmail.com>
> > ---
> >  arch/arm/include/asm/div64.h | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
> > index 898e9c78a7e7..809efc51e90f 100644
> > --- a/arch/arm/include/asm/div64.h
> > +++ b/arch/arm/include/asm/div64.h
> > @@ -39,9 +39,10 @@ static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
> >         asm(    __asmeq("%0", __xh)
> >                 __asmeq("%1", "r2")
> >                 __asmeq("%2", "r0")
> > -               __asmeq("%3", "r4")
> > +               __asmeq("%3", "r0")
> > +               __asmeq("%4", "r4")
> >                 "bl     __do_div64"
> > -               : "=r" (__rem), "=r" (__res)
> > +               : "=r" (__rem), "=r" (__res), "=r" (__n)
> >                 : "r" (__n), "r" (__base)
> >                 : "ip", "lr", "cc");
> >         *n = __res;
> > --
> > 2.23.0
> >
>
> Agree that using r0 as an input operand only is incorrect, and not
> only on Clang. The compiler might assume that r0 will retain its value
> across the asm() block, which is obviously not the case.
>
> However, your patch will likely break big-endian, since in that case,
> __xh == r0, and so it will appear twice.
>
> Perhaps it would be better to change the type of __rem to unsigned
> long long as well?
