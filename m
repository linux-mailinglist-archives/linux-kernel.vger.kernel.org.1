Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315252CAD1F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404459AbgLAUNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730559AbgLAUNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:13:50 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB61FC0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 12:13:09 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id f11so3154354oij.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 12:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jypGaIji9YGM02Yw6XQ65mzgVpIH31CChrgBYlzyuis=;
        b=YpEbgJo0LU5tsaVQOtVzXaKMxv7E7zz7mgRXmbKWy6vVxE1hPy+9MGOQPkXvR9qaff
         dW2ekabbHmxOXpkqDnR4Ox/OG2XcLsCbNB9cePj5rjdtQkXNw5dBqeV3qw61lp6f/K4N
         mXMMmFhqF/DNtCDBrNeGCEVseUgxCsJ9VWOdglz91sxbPISWw8PEo9oJa8MAJlkSIoM2
         osODQmQ9hMCc6m1E21wAofWBvlvtwswBSKPC6Yc5I5e43TnkphkVLdkabZ0DybY/65mA
         19t2QS9Jn9hWkjgkor7b5QE6YIqslCJ/WeSI6B7pxnPOfoXeTOh3KRaU3trfj1bwzLi/
         2enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jypGaIji9YGM02Yw6XQ65mzgVpIH31CChrgBYlzyuis=;
        b=QBpFvz/L6xhJHV+3zmn3XApJRGt8tu0RU0mzIZMWBy//w0fIBqPp1SuWwwY+0a0OOA
         e9Qg2+oCJrt9uY1BJf0sncJqB/5fC71hl8mdsPbFRevXGtUSPs7HwnyID8z9C4nuBGOE
         Q4jdawMd5tAtF63RCkK2LKzT18ScHuBI+e51W2UHJKfZ3WevRnSEdCgr3NPz2L82T+/n
         t8Um3a4ZAQLoHLPA4FZI0zzU9WfjVpQ5bocAtVPsKv037Z8JjhrfxhcX8bIexXVbq8m+
         tAy95jvibylbwNGRyufHVoWhjKlcMDnOzjKCWag/r8nXBSuNpwD1XISbfFyIb9JFYr/r
         Hg2g==
X-Gm-Message-State: AOAM5312vahHUCK7HMQRyRRAYiHNsxWReBbDoZCZ8NibAjrJ1hO32emW
        sXxRNExAoWUMWFipABXK0+q9tf5b6S7nrd8GPo2WcDPcuu8=
X-Google-Smtp-Source: ABdhPJwNQALI8b5GKr4B/kksrNmhACFxvOrOTtYm7YR6dT5p4twIttL5J8Ujdh85iASjmajc5br1XWTNUjmAtw0bXP8=
X-Received: by 2002:aca:a988:: with SMTP id s130mr2977504oie.172.1606853589041;
 Tue, 01 Dec 2020 12:13:09 -0800 (PST)
MIME-Version: 1.0
References: <20201201152017.3576951-1-elver@google.com> <CAKwvOdkcv=FES2CXfoY+AFcvg_rbPd2Nk8sEwXNBJqXL4wQGBg@mail.gmail.com>
In-Reply-To: <CAKwvOdkcv=FES2CXfoY+AFcvg_rbPd2Nk8sEwXNBJqXL4wQGBg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 1 Dec 2020 21:12:57 +0100
Message-ID: <CANpmjNOfs8Of0Kvp3v7miw5x0Neg5i4egc43bevLV3_rGCNqtA@mail.gmail.com>
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
>
> On Tue, Dec 1, 2020 at 7:21 AM Marco Elver <elver@google.com> wrote:
> >
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

Hehe -- another usecase for using that library ;-)  If only we could
require LLVM be present even when building the rest of the kernel with
GCC.

I guess this works, for now. Until the next new keyword that is used
at module scope...

> Acked-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks!
