Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77428270B33
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 08:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgISGoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 02:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgISGoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 02:44:11 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6964C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 23:44:10 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id h9so1990273ooo.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 23:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xxMRWpqFMW35rqNi5wTKblzpN8rt4YbGzNvX/rQXDjw=;
        b=cyLQWVzCnO0TWgje023IpocQnoEXgPNTY5avu1Y9D9IEF3kJ840Z7kTz6HZZr25QV6
         qxPPrDeNn2/G1HJ35aE/ej/CQPZUVtX/IF/nVIlIm8Yd2SvJ175KKY3i/B8E/FGpZisB
         59XC7HrmAamGXuwbS+66Iu/VBAcdtUfOR3+wN2ryn7FZAAwDKeoVUuhM0tp9eqtorStd
         ienbBTLt0L7CfVFnRt34v545npSa1i+mUZnR1p/6MGbcsFlX48MlvolK7AJ2Ajj1/qTL
         7q3kOgCAXZw1IlMdkHjTy584Ejky74iTFpjmrkLC7sscCcPbUDjc7rFYo/Qw9Remr0at
         KdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxMRWpqFMW35rqNi5wTKblzpN8rt4YbGzNvX/rQXDjw=;
        b=Y2dDp5WQKm8hQq8ODs4Qt/wCLGLswQMZKxeEUppNlfMpLOWlEAm6ZT2hBrqtXyYn/S
         yWgYwZ2Umaqwak4gxhtx2Eeay8o11rnJKsdSgpP5Mvst+GkkjSKwEP65pbC1KCmIpiM3
         ySV4M473G0u/SiNkNMAx0EfByU5qXjbEU3YWZoem6tqB5H8KdhSSRtpd8jyd0KoYAF1g
         d+W/Dx9RdlJ/yUUTPiAUiPdGXNN+JxkJOJ+Tg3L5FagJ5xImpzJz/sPcksJ3yI5FbiT9
         PL67xMnLi2fti1G9ucH1rMMM7fJ9Ek7AHDgrhIxkXqj7tATJaBcMYg1YEeCBOCZiQ4og
         k0cQ==
X-Gm-Message-State: AOAM531rhrtkYWnJYTNYhs81glgNAIGCoebAPoIpRyEfKRgT/4+i83br
        IVUbp772tAgFALQOwKWs7j7esR5by4InYYqoHbq9ng==
X-Google-Smtp-Source: ABdhPJyCQh1VgM8212sRATH8Mn1MCj07Ai5i164BQSQmFTDyN9e1eyIx8PrFwkxh5AnsXwlA7E/r4NeHCOqaEk783V8=
X-Received: by 2002:a4a:4fd0:: with SMTP id c199mr26710623oob.54.1600497850120;
 Fri, 18 Sep 2020 23:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200918133632.4038538-1-georgepope@google.com>
In-Reply-To: <20200918133632.4038538-1-georgepope@google.com>
From:   Marco Elver <elver@google.com>
Date:   Sat, 19 Sep 2020 08:43:59 +0200
Message-ID: <CANpmjNO82DrJSeeTS1m7WQKbfHD7FQKxf6e07EcP5qd80CdStA@mail.gmail.com>
Subject: Re: [PATCH] ubsan: introducing CONFIG_UBSAN_BOUNDS_LOCAL for Clang
To:     George-Aurelian Popescu <georgepope@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.or>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        David Brazdil <dbrazdil@google.com>,
        George Popescu <georgepope@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 at 15:36, George-Aurelian Popescu
<georgepope@google.com> wrote:
>
> From: George Popescu <georgepope@google.com>
>
[...]
> Suggested-by: Marco Elver <elver@google.com>
> Reviewed-by: David Brazdil <dbrazdil@google.com>
> Signed-off-by: George Popescu <georgepope@android.com>

There's a mismatch between From/Author and Signed-off-by email address.

> ---
>  lib/Kconfig.ubsan      | 14 ++++++++++++++
>  scripts/Makefile.ubsan | 10 +++++++++-
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 774315de555a..553bd22e83ee 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -47,6 +47,20 @@ config UBSAN_BOUNDS
>           to the {str,mem}*cpy() family of functions (that is addressed
>           by CONFIG_FORTIFY_SOURCE).
>
> +config UBSAN_BOUNDS_LOCAL
> +       bool "Perform array local bounds checking"
> +       depends on UBSAN_TRAP
> +       depends on CC_IS_CLANG
> +       depends on !UBSAN_KCOV_BROKEN
> +       help
> +         This option enables -fsanitize=local-bounds which traps when an
> +         exception/error is detected. Therefore, it should be enabled only
> +         if trapping is expected.
> +         Enabling this option detects errors due to accesses through a
> +         pointer that is derived from an object of a statically-known size,
> +         where an added offset (which may not be known statically) is
> +         out-of-bounds.
> +
>  config UBSAN_MISC
>         bool "Enable all other Undefined Behavior sanity checks"
>         default UBSAN
> diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
> index 27348029b2b8..4e3fff0745e8 100644
> --- a/scripts/Makefile.ubsan
> +++ b/scripts/Makefile.ubsan
> @@ -4,7 +4,15 @@ ifdef CONFIG_UBSAN_ALIGNMENT
>  endif
>
>  ifdef CONFIG_UBSAN_BOUNDS
> -      CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
> +      ifdef CONFIG_CC_IS_CLANG
> +            CFLAGS_UBSAN += -fsanitize=array-bounds
> +      else
> +            CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
> +      endif
> +endif
> +
> +ifdef CONFIG_UBSAN_LOCAL_BOUNDS

Unsure what happened here, but your Kconfig option is named
UBSAN_BOUNDS_LOCAL, yet this uses CONFIG_UBSAN_LOCAL_BOUNDS, so this
patch unfortunately doesn't work yet as you intended.

> +      CFLAGS_UBSAN += -fsanitize=local-bounds
>  endif

Thanks,
-- Marco
