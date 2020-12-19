Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7EE2DEED3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 13:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgLSMmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 07:42:01 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:27838 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgLSMmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 07:42:00 -0500
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 0BJCf6K6016488
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 21:41:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 0BJCf6K6016488
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1608381667;
        bh=/QShfHRRh7S0yQZEAxp8XGYY7a3VQZZJR3cuWY/zEU8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DHBZz6JJMcER/g+M3ITp04DrEkYDyROUPLtGW5tukfUmeU6pfsfk6T7tDNT2MEWBR
         mwvhxVY2qGm+UsFrU7NwICda+e3yrONgg5dmYhhJGIIdskbGH0wU8TsPwxMClqzaLl
         kxWEnhil4eHvwM4zMS6+JdeEsQIbMmpkZdKgSxPn8hh2qNCMMvTO+UFap6nbYBzxmJ
         +sxre9aeij6XQ8INxFHqRBX0yL4xAo37G9IfJKstPvi4j3mmKBWtW9Usu2Z8cb2tDl
         sxeiGoM63M7Yb3mAwFXGP2tqXOAI8ySOSKgik1A4dFzFYOWRxq/MnNENYhn7muF8Iy
         FYRUbfYsZTWfQ==
X-Nifty-SrcIP: [209.85.216.47]
Received: by mail-pj1-f47.google.com with SMTP id z12so2878153pjn.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 04:41:07 -0800 (PST)
X-Gm-Message-State: AOAM530R75nPqmBIw2/0hKTHKiAwIYKYXhjkjEcATdwysMcCFH7NtPZX
        eV7+oO9CR0ijzutRb32F4FFKXGT6rdsuDsV6xRs=
X-Google-Smtp-Source: ABdhPJzDNFAxnF7D55ukFdX3qo1xOjuB2EORwxIbd/FmWtCJDJG+0Xt/v1YRrTtwKfrX0kudCUEzbiY5YYjGbgDVAz4=
X-Received: by 2002:a17:90a:d18c:: with SMTP id fu12mr8623337pjb.153.1608381666291;
 Sat, 19 Dec 2020 04:41:06 -0800 (PST)
MIME-Version: 1.0
References: <20201201152017.3576951-1-elver@google.com> <CAKwvOdkcv=FES2CXfoY+AFcvg_rbPd2Nk8sEwXNBJqXL4wQGBg@mail.gmail.com>
 <CANpmjNOUHdANKQ6EZEzgbVg0+jqWgBEAuoLQxpzQJkstv6fxBg@mail.gmail.com>
 <CANpmjNOdJZUm1apuEHZz_KYJTEoRU6FVxMwZUrMar021hTd5Cg@mail.gmail.com>
 <CANiq72kwZtBn-YtWhZmewVNXNbjEXwqeWSpU1iLx45TNoLLOUg@mail.gmail.com>
 <CANpmjNN3akp+Npf6tqJR44kn=85WpkRh89Z4BQtBh0nGJEiGEQ@mail.gmail.com> <20201210212416.15d48d2a924f2e73e6bd172b@linux-foundation.org>
In-Reply-To: <20201210212416.15d48d2a924f2e73e6bd172b@linux-foundation.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 19 Dec 2020 21:40:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3A-YE2W=DkUMVc8Br4qkEjzQx=qhHMOtWDeriY2RtZg@mail.gmail.com>
Message-ID: <CAK7LNAT3A-YE2W=DkUMVc8Br4qkEjzQx=qhHMOtWDeriY2RtZg@mail.gmail.com>
Subject: Re: [PATCH] genksyms: Ignore module scoped _Static_assert()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marco Elver <elver@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 2:24 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 10 Dec 2020 17:25:30 +0100 Marco Elver <elver@google.com> wrote:
>
> > On Thu, 10 Dec 2020 at 14:29, Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > > On Thu, Dec 10, 2020 at 11:35 AM Marco Elver <elver@google.com> wrote:
> > > >
> > > > It looks like there's no clear MAINTAINER for this. :-/
> > > > It'd still be good to fix this for 5.11.
> > >
> > > Richard seems to be the author, not sure if he picks patches (CC'd).
> > >
> > > I guess Masahiro or akpm (Cc'd) would be two options; otherwise, I
> > > could pick it up through compiler attributes (stretching the
> > > definition...).
> >
> > Thanks for the info. I did find that there's an alternative patch to
> > fix _Static_assert() with genksyms that was sent 3 days after mine
> > (it's simpler, but might miss cases). I've responded there (
> > https://lkml.kernel.org/r/X9JI5KpWoo23wkRg@elver.google.com ).
> >
> > Now we have some choice. I'd argue for this patch, because it's not
> > doing preprocessor workarounds, but in the end I won't make that call.
> > :-)
>
> I have
> https://lkml.kernel.org/r/20201203230955.1482058-1-arnd@kernel.org
> queued for later this week.
>


Sorry for the delay, Marco.

And, thanks for the proper fix.
Now applied to linux-kbuild.



I will revert
14dc3983b5dff513a90bd5a8cc90acaf7867c3d0
later.





--
Best Regards
Masahiro Yamada
