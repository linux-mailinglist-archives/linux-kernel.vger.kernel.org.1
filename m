Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE2C2CEC17
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgLDKWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgLDKWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:22:00 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC833C061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 02:21:19 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id p126so5607361oif.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 02:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kk+jgYQurGhXb5v13hLoLvf1FnCh+AW+lm+ijO2Uveg=;
        b=Zz6qtvLUpn9rXicFZjYW2+6+81EmeCUgPqBwj8VS1PFNX7MCAL6ZhP2SOMn75aHodU
         WD4jVxL5APLkDa5BkGAZjI3N+ktsPdRdSs8jiSi/2DHu++ShhOuG4bO8xmROCXiBMeB8
         sflpqK/8Y9WYxGh5oNCl1Lc5pa56CGhiER7NId7nQVmNiki0rZsOKv/CDvq9L8TYa6Dp
         CV5XLYwWfk0vaBGPOUKk+yKmpl2HI7Utya0JTJbE0Y3TYV1QY3SkfqkYH2yj92Ozy+i5
         33yWVtRfbcQfq/M+Le3LuIJDuCw6hgxHrT0qbkXIKQjtpb860I2J9/4p+WRArmzsn+kI
         xC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kk+jgYQurGhXb5v13hLoLvf1FnCh+AW+lm+ijO2Uveg=;
        b=OoJoJx4SfKeFp01ih5TTNJ2QTmn8wojDmiFyqD6PwdbC9oeg6yoRDULg6aEZCcW6Pg
         MMq+o0tE2ZknuQdBLCOXNJ9Y6r1pGHp0OB+nY0ffiB0odIenOXsHmcqkpiIk/FlyRxgy
         ljI/v16FL/xdCPoyNfc/gRtr094gCkwl/+DcU9k1D3m+/5GSY5B96i0S0EMBiMt6es0A
         ziL8QoMOTvmNftisnssNiHwDkx/Kb89p12cZon3p0Ud6JmP6GvbnyKZ87NJKtPcKiT4Z
         t56Ypob0z2jARHHQKvRlM9ol6+g1NPDhrmB2LasgvCs2vly/kBSm9LZhOYXqedzWJS9j
         Wu2Q==
X-Gm-Message-State: AOAM5330zm9q9PuDoSqAJr3MeLLQp0uuGCixlW66PMDjjbm4/r5cdHsw
        LutqHgSyWDeFOc7j3Lryg10U7EKErkALQpQ/MqwEyQ==
X-Google-Smtp-Source: ABdhPJxNJMxeMYDP+CaR4DD26S3LajA0i+UsBX6TYbz/Ro/hFoTSWxiMUIXhHBZcRjOPuA+1tGJaixmch0U0ZpLPVbw=
X-Received: by 2002:aca:448b:: with SMTP id r133mr660309oia.121.1607077279178;
 Fri, 04 Dec 2020 02:21:19 -0800 (PST)
MIME-Version: 1.0
References: <20201201152017.3576951-1-elver@google.com> <CAKwvOdkcv=FES2CXfoY+AFcvg_rbPd2Nk8sEwXNBJqXL4wQGBg@mail.gmail.com>
In-Reply-To: <CAKwvOdkcv=FES2CXfoY+AFcvg_rbPd2Nk8sEwXNBJqXL4wQGBg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 4 Dec 2020 11:21:07 +0100
Message-ID: <CANpmjNOUHdANKQ6EZEzgbVg0+jqWgBEAuoLQxpzQJkstv6fxBg@mail.gmail.com>
Subject: Re: [PATCH] genksyms: Ignore module scoped _Static_assert()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Dec 2020 at 21:00, Nick Desaulniers <ndesaulniers@google.com> wrote:
> On Tue, Dec 1, 2020 at 7:21 AM Marco Elver <elver@google.com> wrote:
> > The C11 _Static_assert() keyword may be used at module scope, and we
> > need to teach genksyms about it to not abort with an error. We currently
> > have a growing number of static_assert() (but also direct usage of
> > _Static_assert()) users at module scope:
> >
> >         git grep -E '^_Static_assert\(|^static_assert\(' | grep -v '^tools' | wc -l
> >         135
> >
> > More recently, when enabling CONFIG_MODVERSIONS with CONFIG_KCSAN, we
> > observe a number of warnings:
> >
> >         WARNING: modpost: EXPORT symbol "<..all kcsan symbols..>" [vmlinux] [...]
> >
> > When running a preprocessed source through 'genksyms -w' a number of
> > syntax errors point at usage of static_assert()s. In the case of
> > kernel/kcsan/encoding.h, new static_assert()s had been introduced which
> > used expressions that appear to cause genksyms to not even be able to
> > recover from the syntax error gracefully (as it appears was the case
> > previously).
> >
> > Therefore, make genksyms ignore all _Static_assert() and the contained
> > expression. With the fix, usage of _Static_assert() no longer cause
> > "syntax error" all over the kernel, and the above modpost warnings for
> > KCSAN are gone, too.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Ah, genksyms...if only there were a library that we could use to parse
> C code...:P
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>

Which tree would this go into?

It'd be good if this problem could be fixed for 5.11.

Thanks,
-- Marco
