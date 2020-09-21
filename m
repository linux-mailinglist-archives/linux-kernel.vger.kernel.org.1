Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A82A271E97
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgIUJKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgIUJKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:10:34 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A78C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:10:34 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id e23so11675571otk.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jy0s2USaK+JhHTs7TrcCHTEta2V5dGsxjsWQWazaFrg=;
        b=Pz6WH6M/BJu89iBBzg4E6J5882Nx/Znsr5EsHYfUQ6GFKTxPBeLOYbpCo7vfJeJpkC
         77J7q3aewmGbJ95g5OqICNjFyeMY6FvLZzJrM0wlVDwIms9/46dORRQ5117KreK/w4H8
         ysc0nr2ZFmgBf/A9E3fxOt0xtZHnq72FBx/fQPHanVIvItt5yIEIxKY8wtPFySsmeemd
         +TZvvP5E2s9+DEsPlo/gbGS15zROAMsjcl3BosN8R6SCMGgKzUCYhh4tGJr79lHTUOwg
         U/wK4nL04rINlIU5gtjeEPN7bXp47qaVXdwUgGLmP1TijxdS5WxvJj7r9V7xJEA90jVS
         oK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jy0s2USaK+JhHTs7TrcCHTEta2V5dGsxjsWQWazaFrg=;
        b=nR6pqvJa1MoHGEMLI0aHl9GVDK7sjVIagdPhUBj5Humjuajs8oR6xknJMADnxF/dXd
         wSlxS4Lk8QWYdA/lhB6XAF0OkkdW9FPuvtaGKV5MSSs0Nq0myKdgspF0tCgZ3QNbRaa5
         N7QADQnDcCAwh/TP3nx+fqw1bElEk4xb1JJmS0goXAP1jQGHUzsvrp/bE0t7njIwZmyI
         UtAa0ghuDUvuAhqsZ/qCCOg5cTEVIXOrf8t/euRvy1GcgSAqroYrAxcLBrNSEDYmooNL
         ppEYsGlTACWsEw5tZevC8UQJqABLP970Lj96awko4BJmEpg18nZq6k5Hk5JMw47HiHgw
         LF6g==
X-Gm-Message-State: AOAM5328XBXX+fQFRAl5gA0hlUN6KuQqncUDeBs3eMq5CMRHSQ1RMTDn
        3dOlrnQ8dUbN4fmurzKflldZOL3KWTWojLwxgEnxug==
X-Google-Smtp-Source: ABdhPJxAPoNM9cxvuhL4A0nzgYDZ1C0km3PcNvpJZJweF0+o5ZqHFmqErzFuM4OdOW9fJp2X8AcX+Tf3ctOX4erzkNo=
X-Received: by 2002:a9d:66a:: with SMTP id 97mr18596488otn.233.1600679433137;
 Mon, 21 Sep 2020 02:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200921075131.1334333-1-georgepope@google.com>
In-Reply-To: <20200921075131.1334333-1-georgepope@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 21 Sep 2020 11:10:21 +0200
Message-ID: <CANpmjNO8YNROJsOj+n=hWj=2-LqebBQdZRks1KKQ3Scd05fLjg@mail.gmail.com>
Subject: Re: [PATCH] ubsan: introducing CONFIG_UBSAN_LOCAL_BOUNDS for Clang
To:     George-Aurelian Popescu <georgepope@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        David Brazdil <dbrazdil@google.com>,
        George Popescu <georgepope@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020 at 09:51, George-Aurelian Popescu
<georgepope@google.com> wrote:
>
> From: George Popescu <georgepope@android.com>
>
> When the kernel is compiled with Clang, -fsanitize=bounds expands to
> -fsanitize=array-bounds and -fsanitize=local-bounds.
>
> Enabling -fsanitize=local-bounds with Clang has the unfortunate
> side-effect of inserting traps; this goes back to its original intent,
> which was as a hardening and not a debugging feature [1]. The same feature
> made its way into -fsanitize=bounds, but the traps remained. For that
> reason, -fsanitize=bounds was split into 'array-bounds' and
> 'local-bounds' [2].
>
> Since 'local-bounds' doesn't behave like a normal sanitizer, enable
> it with Clang only if trapping behaviour was requested by
> CONFIG_UBSAN_TRAP=y.
>
> Add the UBSAN_LOCAL_BOUNDS config to Kconfig.ubsan to enable the
> 'local-bounds' option by default when UBSAN_TRAP is enabled.
>
> [1] http://lists.llvm.org/pipermail/llvm-dev/2012-May/049972.html
> [2] http://lists.llvm.org/pipermail/cfe-commits/Week-of-Mon-20131021/091536.html
>
> Suggested-by: Marco Elver <elver@google.com>
> Reviewed-by: David Brazdil <dbrazdil@google.com>
> Signed-off-by: George Popescu <georgepope@android.com>

Reviewed-by: Marco Elver <elver@google.com>

Thank you!

> ---
> v1: changed the name of the config to UBSAN_LOCAL_BOUNDS in Kconfig

This version is v2, so this should have said "v2: <summary of what
changed>". The subject should have said "PATCH v2" (you can get this
by passing --reroll-count=2 to git).

(I also see you fixed the the Signed-off-by/From inconsistency.)

> ---
> ---
>  lib/Kconfig.ubsan      | 14 ++++++++++++++
>  scripts/Makefile.ubsan | 10 +++++++++-
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 774315de555a..58f8d03d037b 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -47,6 +47,20 @@ config UBSAN_BOUNDS
>           to the {str,mem}*cpy() family of functions (that is addressed
>           by CONFIG_FORTIFY_SOURCE).
>
> +config UBSAN_LOCAL_BOUNDS
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
> +      CFLAGS_UBSAN += -fsanitize=local-bounds
>  endif
>
>  ifdef CONFIG_UBSAN_MISC
> --
> 2.28.0.681.g6f77f65b4e-goog
>
