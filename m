Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055A628158E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388257AbgJBOn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388016AbgJBOnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:43:25 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80FCC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 07:43:25 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id k2so1332857ybp.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 07:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQ8K/rKC3UZmS+HPw3fqqFhEn9BpnVrMLbEfvCkaaxQ=;
        b=l82Mo41OK7danCEzWkgt56N4HOyZSMpoctAVxphQ2DNsNn/JWTOXflC+wZEf+xF1B5
         8Hg4cYinPO00dceLEz6lc4dhpgaMZcx4uYGF+Ge5gSlnA8It8rF0jSF8a9C+ylmlR0Th
         JEon+J/ZUliHnLdGrxImVikl9b2l/qJ/lv7MyN1QFk9cD80SkybjZk2Uwk811JLa6O11
         r9p1O430NCWEzUxgbcUTkEdt2HpvWK26f109OCCIKCPSgMQHn67MT1VgLZ1hI5q7zfJd
         XI04hzcexR5PhQwXVxhy4UCWDVke6UzVCU0oIsWS1ufmplpU6ntdq76cFjpS/JsfUz96
         3TNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQ8K/rKC3UZmS+HPw3fqqFhEn9BpnVrMLbEfvCkaaxQ=;
        b=qgoizhOgy16jTV+SUXz4aFferrMwmcihmkxCaHBiIIpE/r+aZ83Pma69msVg1ILeAi
         hbgiCxMCYejNDuQlcpCeQ+XfBArMVOYNktC5vMtiw8VkYXIszE3zC4Wl78pPePHg4g1F
         y8N7QP587jw15nGq/TNCPmQbdSWZ/vvRQ3DBNXmPY1OAYDKu0QfnT+OBGrE7KsSYrfOe
         C1MO3xkdAU3paN75T8uO2kINDoaO2+BDT4Dx04Y/zEMuDaX8QR+5XVs7DNZ9tJG1pVYb
         AH4TP5UuhR49dOV0HML/FIij1S8Qef4Nsd6lGmlWUOFPOtr+erKMjfdi8/FOoKfvxxRh
         OatQ==
X-Gm-Message-State: AOAM530Mq3DUKHQCgkPGau6hktd8rAgwhSLw8WAYYuGfw0+vvcAnA/0F
        pWslzOsfJPxsvx7lrRK4NGOF/O+XNi6lKbf/x0/pVg==
X-Google-Smtp-Source: ABdhPJwXSLQM1wMdKV7Ms/xCrbWz6N/IUGmNVzWK1V3dGvW4WrCOv1tOmgf1lKrNzn/nV3yOveSmij46dqVklmKPI/0=
X-Received: by 2002:a25:9c87:: with SMTP id y7mr3357608ybo.18.1601649804901;
 Fri, 02 Oct 2020 07:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200922074330.2549523-1-georgepope@google.com>
In-Reply-To: <20200922074330.2549523-1-georgepope@google.com>
From:   George Popescu <georgepope@google.com>
Date:   Fri, 2 Oct 2020 17:43:14 +0300
Message-ID: <CA+DmFKDMZPef9+f4xPWMQ2mgdHPSUBmYZ3X=bS6s8XudetmW5g@mail.gmail.com>
Subject: Re: [PATCH v3] ubsan: introducing CONFIG_UBSAN_LOCAL_BOUNDS for Clang
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     peterz@infradead.org, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        David Brazdil <dbrazdil@google.com>,
        George Popescu <georgepope@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is this patch ready to be merged?

Best regards,
George


On Tue, Sep 22, 2020 at 10:43 AM George-Aurelian Popescu
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
> Add the UBSAN_BOUNDS_LOCAL config to Kconfig.ubsan to enable the
> 'local-bounds' option by default when UBSAN_TRAP is enabled.
>
> [1] http://lists.llvm.org/pipermail/llvm-dev/2012-May/049972.html
> [2] http://lists.llvm.org/pipermail/cfe-commits/Week-of-Mon-20131021/091536.html
>
> Suggested-by: Marco Elver <elver@google.com>
> Reviewed-by: David Brazdil <dbrazdil@google.com>
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: George Popescu <georgepope@android.com>
>
> ---
> v2: changed the name of the config, in Kconfig, to UBSAN_LOCAL_BOUNDS
> ---
> v3: added Reviewed-by tag
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
