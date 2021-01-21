Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C0E2FF21D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388865AbhAURiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388316AbhAURey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:34:54 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA462C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:34:13 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id q8so3630686lfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWpM9JlBh2PjRj9rPNDgayDsvoJuIDrT02opFblBIwI=;
        b=l0fIIbSNawXPUvEyBF5WOmhkcVs6nt2RBuHUcVL3dcQMwQnm8KqkgXgKrXfbuw0xR3
         uovKs375/BZEcQHZEYVDUlpOQRQ2Vj3e0CH3gLe7tD3cy41qwyHdk2syy3OGd6GD652p
         5OWLdhVGsodDCiXfkQoKaXERPdtvsfRlnXynqgF53+EtBzTWCrJBWjFFO7I+Mi6RDp6T
         MxkRutOA+u0k+Qb3Q2db/SNMZ2svbrr3unu/Ci8m5lrtV22YqgVQKI8L3aWGURlDPHCp
         HfoVas6Nkdbb8Nlw4SyWD5oxoSCZot+J5/YIksiih//gWE99F2NWMv7FEpyRTRMOAXYb
         EKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWpM9JlBh2PjRj9rPNDgayDsvoJuIDrT02opFblBIwI=;
        b=aVvwchjRVnReED1sYePGIWu+uqWfnIVXVBhIgM27l6PfygZYDqTtZJghlNGqMGdBT7
         9DYnge2D9HhI2hp8ydaSdWB1Dsnw0zNoOD/yE9DOYXRhN2fUfE5YHzBe9YudHaT2MkAg
         MJePamH5uq5j3dlg8CZ9PqVhatJ8IPUb/zNy9Ivj+WALxfuhZo2xLInFEOxf+1LqawMg
         5JEpcO1MAcV6YB3zAsyjwUxz2ZgyHRcPP8QyPfSu0AQZH/dN6JL+rrj2XyWaH+U7eQsF
         p2HsdgFm63fiMxqPu+7Ta7uycSMPG+byxsaT7OrOlhB3613ClcBNsf77djpfi8oGnvP1
         LAug==
X-Gm-Message-State: AOAM532OQHjYBY0AFHygGPMYmViqG80GS0cZtzOw1goGYJh90XLkt1Wf
        4Qt2iQVzFJqPZdsiK3Z7lFX6DSpBySqMPWG4XinBIQ==
X-Google-Smtp-Source: ABdhPJzO21s3NiiwN9DvV27HayxMgQ37uaAjAPszARtSGglJiuTXEbE/1x+lVLUskU+Mou92zXfFuskFjG7+iCR4O+M=
X-Received: by 2002:a05:6512:788:: with SMTP id x8mr148696lfr.250.1611250452285;
 Thu, 21 Jan 2021 09:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20210121163943.9889-1-vincenzo.frascino@arm.com> <20210121163943.9889-3-vincenzo.frascino@arm.com>
In-Reply-To: <20210121163943.9889-3-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 21 Jan 2021 18:34:00 +0100
Message-ID: <CAAeHK+z3QrZr3OWcvetyChk9GMPuBZVTBjWoqQB45ZSFBOJHwQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] kasan: Add KASAN mode kernel parameter
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

On Thu, Jan 21, 2021 at 5:39 PM Vincenzo Frascino
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
>  Documentation/dev-tools/kasan.rst |  7 +++++++
>  lib/test_kasan.c                  |  2 +-
>  mm/kasan/hw_tags.c                | 27 ++++++++++++++++++++++++++-
>  mm/kasan/kasan.h                  |  6 ++++--
>  4 files changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index e022b7506e37..7e4a6e0c9f57 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -161,6 +161,13 @@ particular KASAN features.
>
>  - ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
>
> +- ``kasan.mode=sync`` or ``=async`` controls whether KASAN is configured in
> +  synchronous or asynchronous mode of execution (default: ``sync``).
> +  ``synchronous mode``: an exception is triggered if a tag check fault occurs.

Synchronous mode: a bad access is detected immediately when a tag
check fault occurs.

(No need for `` here, "synchronous mode" is not an inline snippet.)

> +  ``asynchronous mode``: if a tag check fault occurs, the information is stored
> +  asynchronously in hardware (e.g. in the TFSR_EL1 register for arm64). The kernel
> +  checks the hardware location and reports an error if the fault is detected.

Asynchronous mode: a bad access detection is delayed. When a tag check
fault occurs, the information is stored in hardware (in the TFSR_EL1
register for arm64). The kernel periodically checks the hardware and
only reports tag faults during these checks.

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
> index e529428e7a11..224a2187839c 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -25,6 +25,11 @@ enum kasan_arg {
>         KASAN_ARG_ON,
>  };
>
> +enum kasan_arg_mode {
> +       KASAN_ARG_MODE_SYNC,
> +       KASAN_ARG_MODE_ASYNC,

For other modes I explicitly added a _DEFAULT option first. It makes
sense to do this here as well for consistency.

> +};
> +
>  enum kasan_arg_stacktrace {
>         KASAN_ARG_STACKTRACE_DEFAULT,
>         KASAN_ARG_STACKTRACE_OFF,
> @@ -38,6 +43,7 @@ enum kasan_arg_fault {
>  };
>
>  static enum kasan_arg kasan_arg __ro_after_init;
> +static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
>  static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;
>  static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
>
> @@ -68,6 +74,21 @@ static int __init early_kasan_flag(char *arg)
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
> @@ -115,7 +136,11 @@ void kasan_init_hw_tags_cpu(void)
>                 return;
>
>         hw_init_tags(KASAN_TAG_MAX);
> -       hw_enable_tagging();
> +

Let's add a comment:

/* Enable async mode only when explicitly requested through the command line. */

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
