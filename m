Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70ED63005A6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbhAVOiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbhAVOhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:37:03 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A2DC06178B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 06:36:23 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id kx7so3778804pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 06:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4ndQifpB6vRYXO2w5aSIQgzTLZUsKUzNWBDOARv8pU=;
        b=s1JMK3gv2GQtNAS32P5zWmfle4NytnQV8g2REiMBp/MheT/zck6MOykUghCYl1zqjj
         Hj8LSwp400GJuC4t3YF+Jll4CfhlMnzo+74wRmJ5tooJfUHelvDEmkG2fmrvtuvXy2dO
         kND61YjndMCz5z3C0/iKkUvZpqMfFKsgLXNlgrenmj59MGeiWAfj751isWv1vw89Xn15
         dJIvTHAwol/5CFRldQq2tJNv6gnKDL0JY3LIAjlsCxPDOlI0QsG01OzTwLXJPBhkrHoM
         tb5GWQcqLIHbtKKm7dphbQPE+33KOg08DRnm9DInFld88msCsqJD96JNyNGu39xKnhaX
         plHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4ndQifpB6vRYXO2w5aSIQgzTLZUsKUzNWBDOARv8pU=;
        b=H60HgjjK+gNEsLkBG5w6bDHS/edMBHFHi8V6awy1fYgbve44GPwpIBLQ+yBdSUDeTY
         XSxV6d7ClpKB9AL/t/M+77P4u0LMdMNFPtuySEzANJHMMzxT17stxlhK5MJh4CbKN5LA
         FXw/WaqZteppu/qgVfSqTbcFlfluxIR4sselzzHkOYWhF4T467RXCfBwg3V9JxilWQYl
         zr9i46BYDzW3gvuYCdShl15kV0jReF/P9Jw8br4h8dg0PGQAwUYpkxwBRuxtqqLh3NJF
         bROHYGz4Cpynv8mUrIoBLCnqZjKk/gJo01l8FurEME9YRZWO7m6QsNaLM48j1szhSMT4
         8IkQ==
X-Gm-Message-State: AOAM5326ky4UvUjmoF5iNzntMZVs1aWsrKVsPtf44OB5mpD2XlBQulHB
        DsqGSeyR45SZ0AIJJCfXqqaktAU3jFWEDT8GsLUxbeLnthQj/g==
X-Google-Smtp-Source: ABdhPJxvIfUBZnUqb/DU5Y4C0S1Eul97b0Eg9Qg1qgUdFtPS1m+ucavQvS+aaBp8VDbflPPB7Vurih1L618A54rbZQk=
X-Received: by 2002:a17:90b:350b:: with SMTP id ls11mr5726685pjb.166.1611326182815;
 Fri, 22 Jan 2021 06:36:22 -0800 (PST)
MIME-Version: 1.0
References: <20210122141125.36166-1-vincenzo.frascino@arm.com> <20210122141125.36166-3-vincenzo.frascino@arm.com>
In-Reply-To: <20210122141125.36166-3-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 22 Jan 2021 15:36:11 +0100
Message-ID: <CAAeHK+zGkkoW=jqxRyntXQ+n9JU-G071Q7s4gFQSaaSV-T8OTQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] kasan: Add KASAN mode kernel parameter
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 3:11 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Architectures supported by KASAN_HW_TAGS can provide a sync or async mode
> of execution. On an MTE enabled arm64 hw for example this can be identified
> with the synchronous or asynchronous tagging mode of execution.
> In synchronous mode, an exception is triggered if a tag check fault occurs.
> In asynchronous mode, if a tag check fault occurs, the TFSR_EL1 register is
> updated asynchronously. The kernel checks the corresponding bits
> periodically.
>
> KASAN requires a specific kernel command line parameter to make use of this
> hw features.
>
> Add KASAN HW execution mode kernel command line parameter.
>
> Note: This patch adds the kasan.mode kernel parameter and the
> sync/async kernel command line options to enable the described features.
>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  Documentation/dev-tools/kasan.rst |  9 +++++++++
>  lib/test_kasan.c                  |  2 +-
>  mm/kasan/hw_tags.c                | 32 ++++++++++++++++++++++++++++++-
>  mm/kasan/kasan.h                  |  6 ++++--
>  4 files changed, 45 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index e022b7506e37..e3dca4d1f2a7 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -161,6 +161,15 @@ particular KASAN features.
>
>  - ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
>
> +- ``kasan.mode=sync`` or ``=async`` controls whether KASAN is configured in
> +  synchronous or asynchronous mode of execution (default: ``sync``).
> +  Synchronous mode: a bad access is detected immediately when a tag
> +  check fault occurs.
> +  Asynchronous mode: a bad access detection is delayed. When a tag check
> +  fault occurs, the information is stored in hardware (in the TFSR_EL1
> +  register for arm64). The kernel periodically checks the hardware and
> +  only reports tag faults during these checks.
> +
>  - ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
>    traces collection (default: ``on`` for ``CONFIG_DEBUG_KERNEL=y``, otherwise
>    ``off``).
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index d16ec9e66806..7285dcf9fcc1 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -97,7 +97,7 @@ static void kasan_test_exit(struct kunit *test)
>                         READ_ONCE(fail_data.report_found));     \
>         if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {                 \
>                 if (READ_ONCE(fail_data.report_found))          \
> -                       hw_enable_tagging();                    \
> +                       hw_enable_tagging_sync();               \
>                 migrate_enable();                               \
>         }                                                       \
>  } while (0)
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index e529428e7a11..308a879a3798 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -25,6 +25,12 @@ enum kasan_arg {
>         KASAN_ARG_ON,
>  };
>
> +enum kasan_arg_mode {
> +       KASAN_ARG_MODE_DEFAULT,
> +       KASAN_ARG_MODE_SYNC,
> +       KASAN_ARG_MODE_ASYNC,
> +};
> +
>  enum kasan_arg_stacktrace {
>         KASAN_ARG_STACKTRACE_DEFAULT,
>         KASAN_ARG_STACKTRACE_OFF,
> @@ -38,6 +44,7 @@ enum kasan_arg_fault {
>  };
>
>  static enum kasan_arg kasan_arg __ro_after_init;
> +static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
>  static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;
>  static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
>
> @@ -68,6 +75,21 @@ static int __init early_kasan_flag(char *arg)
>  }
>  early_param("kasan", early_kasan_flag);
>
> +/* kasan.mode=sync/async */
> +static int __init early_kasan_mode(char *arg)
> +{
> +       /* If arg is not set the default mode is sync */
> +       if ((!arg) || !strcmp(arg, "sync"))
> +               kasan_arg_mode = KASAN_ARG_MODE_SYNC;
> +       else if (!strcmp(arg, "async"))
> +               kasan_arg_mode = KASAN_ARG_MODE_ASYNC;
> +       else
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +early_param("kasan.mode", early_kasan_mode);
> +
>  /* kasan.stacktrace=off/on */
>  static int __init early_kasan_flag_stacktrace(char *arg)
>  {
> @@ -115,7 +137,15 @@ void kasan_init_hw_tags_cpu(void)
>                 return;
>
>         hw_init_tags(KASAN_TAG_MAX);
> -       hw_enable_tagging();
> +
> +       /*
> +        * Enable async mode only when explicitly requested through
> +        * the command line.
> +        */
> +       if (kasan_arg_mode == KASAN_ARG_MODE_ASYNC)
> +               hw_enable_tagging_async();
> +       else
> +               hw_enable_tagging_sync();
>  }
>
>  /* kasan_init_hw_tags() is called once on boot CPU. */
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 07ef7fc742ad..3923d9744105 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -294,7 +294,8 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  #define arch_set_mem_tag_range(addr, size, tag) ((void *)(addr))
>  #endif
>
> -#define hw_enable_tagging()                    arch_enable_tagging()
> +#define hw_enable_tagging_sync()               arch_enable_tagging_sync()
> +#define hw_enable_tagging_async()              arch_enable_tagging_async()
>  #define hw_init_tags(max_tag)                  arch_init_tags(max_tag)
>  #define hw_set_tagging_report_once(state)      arch_set_tagging_report_once(state)
>  #define hw_get_random_tag()                    arch_get_random_tag()
> @@ -303,7 +304,8 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>
>  #else /* CONFIG_KASAN_HW_TAGS */
>
> -#define hw_enable_tagging()
> +#define hw_enable_tagging_sync()
> +#define hw_enable_tagging_async()
>  #define hw_set_tagging_report_once(state)
>
>  #endif /* CONFIG_KASAN_HW_TAGS */
> --
> 2.30.0
>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!
