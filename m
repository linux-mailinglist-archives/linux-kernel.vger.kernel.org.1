Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB9C299530
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784503AbgJZSXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:23:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36039 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773393AbgJZSXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:23:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id r10so5130129plx.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 11:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mTOMrjwlGlpuPftdkncxJgdOXaY5B7jezcTkXNur900=;
        b=DNcGM/EaguEqHd5t2ecucaDZ4X9DFdeKYpya4xXcpfKceuD+cL0AOv7wKugaXYYVRJ
         bxLlY9aF+iyjImZa596fAX0dedA9OZ+ecvdN4r234q2EIK4JhMRWR11flMyritFZyFd8
         lxGmx7svt3i8Sky+4nX55PTZRJbbOKa/um4FzoNm0OBJK184w8+LmEUdUeyiczPIOYf/
         b4nrtVnUOdFet/LdsFauNU1rL6mtyLQpW4u6TfcUkM+KDKVPtwgjrrkHW1bUVqBHr4aw
         oGQMqnYfya95W3q0X0A/QB1iNy1wmGJS/NgZS3PMKUlLQsNMyuz19pSsWaw1HyTKT9Fn
         V+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTOMrjwlGlpuPftdkncxJgdOXaY5B7jezcTkXNur900=;
        b=GgCEkBRp57HurXwgNnGJLOchCAEi8G0FJd7tbzaMeCvQMkqwwY7knHthPxJOZHvQGs
         B+tz9CzWjMHJ5XEA7bsqcHsmrDwEfwk/5jGeacSdzuddiZusOV8fBbtbmEaUZamlf7+M
         cxTxXIlrVx5jiXRrusE2ZhNcvWX4WuKCGowdcpeQEEVZJ39tgk5eU2aEcDmKH/y2WNH4
         z3zzFIr4N74hsJWxQ6AfKYisDgnY3gLldM+x6HED899mlddx2++GeneyrSUJkRdXOFSt
         wHvRAypFIEUAE4ZjQtmNX6I1HzS7ER82g3XjKbX5UPQ0t44drNsDzkIVzIB13uuECQom
         Kk7A==
X-Gm-Message-State: AOAM531BvJb3A+HMdyWCYHekpWy03KdAhLzeLaK//I2YZPNXlO9oKWtr
        XSzl0q/cV4KL5glCBl9/BwU7aHy8QrW+/E/yqaV0eg==
X-Google-Smtp-Source: ABdhPJzCWUN9tvvpwUwsnRWEXlRqttwztTfl+o6rk/gsuud5GK9GCXMifkKbMfQEJwXGl1KXBRwnlaQQihNkyKr8p38=
X-Received: by 2002:a17:90a:740a:: with SMTP id a10mr17895934pjg.32.1603736620190;
 Mon, 26 Oct 2020 11:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201026162336.3711040-1-arnd@kernel.org>
In-Reply-To: <20201026162336.3711040-1-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 26 Oct 2020 11:23:29 -0700
Message-ID: <CAKwvOdmdv6wABToSpJt5b66E1vD3Ec0QC3DnyZm7f2sJkcsNuw@mail.gmail.com>
Subject: Re: [PATCH] ctype.h: remove duplicate isdigit() helper
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 9:23 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc warns a few thousand times about the isdigit() shadow:
>
> include/linux/ctype.h:26:19: warning: declaration of 'isdigit' shadows a built-in function [-Wshadow]

Don't all functions defined here shadow builtins in GCC?  Why is
`isdigit` unique?  Is that because it's a `static inline` definition
vs a function like macro?  If that's the case, what's the harm in
converting it to a function like macro if that silences the warning?

>
> As there is already a compiler builtin, just use that, and make
> it clear we do that by defining a macro.  Unfortunately, clang
> does not have the isdigit() builtin, so this has to be conditional.

TODO(Nick): finish the Clang patch that implements that.
https://reviews.llvm.org/D86508

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/ctype.h | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/ctype.h b/include/linux/ctype.h
> index 363b004426db..c407acb258c2 100644
> --- a/include/linux/ctype.h
> +++ b/include/linux/ctype.h
> @@ -23,10 +23,6 @@ extern const unsigned char _ctype[];
>  #define isalnum(c)     ((__ismask(c)&(_U|_L|_D)) != 0)
>  #define isalpha(c)     ((__ismask(c)&(_U|_L)) != 0)
>  #define iscntrl(c)     ((__ismask(c)&(_C)) != 0)
> -static inline int isdigit(int c)
> -{
> -       return '0' <= c && c <= '9';
> -}
>  #define isgraph(c)     ((__ismask(c)&(_P|_U|_L|_D)) != 0)
>  #define islower(c)     ((__ismask(c)&(_L)) != 0)
>  #define isprint(c)     ((__ismask(c)&(_P|_U|_L|_D|_SP)) != 0)
> @@ -39,6 +35,18 @@ static inline int isdigit(int c)
>  #define isascii(c) (((unsigned char)(c))<=0x7f)
>  #define toascii(c) (((unsigned char)(c))&0x7f)
>
> +#if defined __has_builtin

#ifdef

only use `defined` explicitly when there's more than one condition
being checked with logical `&&` or `||`.

> +#if __has_builtin(__builtin_isdigit)

GCC only recently gained the `__has_builtin` macro (I filed the bug);
I would like to see something akin to
include/linux/compiler_attributes.h but using `__has_builtin` like
compiler_attributes.h uses `__has_attribute`.  That way we avoid
spaghetti like this throughout the kernel.

> +#define isdigit(ch) __builtin_isdigit(ch)
> +#endif
> +#endif
> +#ifndef isdigit
> +static inline int isdigit(int c)
> +{
> +       return '0' <= c && c <= '9';
> +}
> +#endif
> +
>  static inline unsigned char __tolower(unsigned char c)
>  {
>         if (isupper(c))
> --
> 2.27.0
>


-- 
Thanks,
~Nick Desaulniers
