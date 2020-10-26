Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89CF2996BF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1792979AbgJZTW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1792972AbgJZTW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:22:27 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FCBF20709
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 19:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603740146;
        bh=rdH81gD1U2kWovShxEgNuY3bLKkO1T+WW3kWNRVjGSM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aJh9wWLPIUesyXx4C/tJnh1fen8x6evPyIjc4sNU9/OXhrCUzi3HByo+f+zVzHoiO
         nhQcqaHq/SbaA7hajmnZy5YpxPHMgl7pRfJz69iMhLzBhA7pCQm/qHDVVGAGOBBEsw
         BBEoyGvLgxuHQtMwW1gqjMjJ5T4C0obkHzWwvTRA=
Received: by mail-qt1-f176.google.com with SMTP id i7so6878628qti.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 12:22:26 -0700 (PDT)
X-Gm-Message-State: AOAM531GluqPVzgTH0dYV0R7oLw48M9Rck7GPZsNJMig6MW/Z0LxDeMK
        iTiCTZGL5LIv4z3ul89efZap2C2mbyA1afSyei0=
X-Google-Smtp-Source: ABdhPJxIDPTufr52kNTMJQnBoyCopCXHnR8khLPhNjUFIpf1FOQGvvF5QClP5Galtq9B9t1VsDSyijq96IO2iH+YvIs=
X-Received: by 2002:ac8:4808:: with SMTP id g8mr17753337qtq.18.1603740145367;
 Mon, 26 Oct 2020 12:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201026162336.3711040-1-arnd@kernel.org> <CAKwvOdmdv6wABToSpJt5b66E1vD3Ec0QC3DnyZm7f2sJkcsNuw@mail.gmail.com>
In-Reply-To: <CAKwvOdmdv6wABToSpJt5b66E1vD3Ec0QC3DnyZm7f2sJkcsNuw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 26 Oct 2020 20:22:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a32dWaCQV8Q1g0eoQD2PFb8Jt2pDHEkTJOMAoyJpOhD3w@mail.gmail.com>
Message-ID: <CAK8P3a32dWaCQV8Q1g0eoQD2PFb8Jt2pDHEkTJOMAoyJpOhD3w@mail.gmail.com>
Subject: Re: [PATCH] ctype.h: remove duplicate isdigit() helper
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 7:23 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Mon, Oct 26, 2020 at 9:23 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > gcc warns a few thousand times about the isdigit() shadow:
> >
> > include/linux/ctype.h:26:19: warning: declaration of 'isdigit' shadows a built-in function [-Wshadow]
>
> Don't all functions defined here shadow builtins in GCC?  Why is
> `isdigit` unique?  Is that because it's a `static inline` definition
> vs a function like macro?  If that's the case, what's the harm in
> converting it to a function like macro if that silences the warning?

It was originally a macro but got changed to an inline function in
1204c77f9b6a ("include/linux/ctype.h: make isdigit() table lookupless"),
apparently in order to avoid evaluating the argument more than once.

I suppose we could make it a statement expression with a local
variable like

#define isdigit(c) ({ __auto_type __c = (c);  '0' <= __c && __c <= '9'; })

> > @@ -39,6 +35,18 @@ static inline int isdigit(int c)
> >  #define isascii(c) (((unsigned char)(c))<=0x7f)
> >  #define toascii(c) (((unsigned char)(c))&0x7f)
> >
> > +#if defined __has_builtin
>
> #ifdef
>
> only use `defined` explicitly when there's more than one condition
> being checked with logical `&&` or `||`.
>
> > +#if __has_builtin(__builtin_isdigit)
>
> GCC only recently gained the `__has_builtin` macro (I filed the bug);
> I would like to see something akin to
> include/linux/compiler_attributes.h but using `__has_builtin` like
> compiler_attributes.h uses `__has_attribute`.  That way we avoid
> spaghetti like this throughout the kernel.

Ok. I've added a 'has_builtin()' macro (without underscores)
in linux/compiler.h in version 2. I don't use it anywhere else
in my current series, so there should be no dependencies.

     Arnd
