Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BB327D6CC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgI2TXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgI2TXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:23:03 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E14DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:23:02 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d6so5572986pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGb7x8YUCOsUH75obTDiJ9n5ILA2CmimR4Sm9Sn083E=;
        b=MG2uhNgIoAqQ145gKQDC07A/bYdHkyq4BjCi5MOZn26OWSC3h2IphtTJdCVQgHEmvR
         OnHSlEXHyRtMoL7b+uKgsnVEO1PanhsiRC5KprBPsAk17YZFL+/n6L8oB028d/4i8HLS
         VG7u8sxK1KQ/QTcd8OYbp4s/buxbMK5QqTbkg1pWXm5wK/BsJ5C1wOks6MN05kgSxJ99
         eMrGsHJI5vtsfyxVc0EhJgFFV3UCzVL5SdzdyzD9Yj33/udqxej7F4/I5QIPAzLtVE97
         4/cHr+CBZjEnzjCxTlkSC/SODby7FLtNN7kHB2L/CYdMG5ENNYmTh4v+Xo9CdYsehwgZ
         csYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGb7x8YUCOsUH75obTDiJ9n5ILA2CmimR4Sm9Sn083E=;
        b=JnY2JaWtoYElb7lsBGnvoxLMAE/OcrCUrdK3Nbj3F4MOp/1txCBsKYnfHwAlbhwmHK
         r6yq1eRzZReJHbVOA7Hkby/YguOQNMD5ewYip8zmQ9R6UpodXqeWovmP5TecgrtyX4sj
         Gjh4dfXSj7HE5FuYE3EgPdiE9DpylW7CyeG+uFpSPsvSN6lPpYkX7NztAnfB8LSMRLj6
         oWSuL/37EgTlGZ50ses7hyutgFHH1wk2LZezASK8SRO5AIW8sw3sXJsvemKm5sCxLz+p
         5A5tOkm2ukcNuksULbcdTianqhAToJQfRw5zEa3K88UPsSWraeUugHSLsTZ8wPHEl2Uz
         J7sA==
X-Gm-Message-State: AOAM530Z3c9iD6bO+f81Pc6t/IchURRqGRDhqMIJxYc6916mtP2Jum8X
        Tgpwm236EZ9DxkDiJCuYowxYuDnRI0ZMJS4ooX8eUQ==
X-Google-Smtp-Source: ABdhPJyChWdjv4wSBHHt8wwhxCBeeusT+pYIJhoqpLnBIOnRZefz7ePm3oAHqooOXWwoLggiL4gJmRRyqKeWMQd5cAw=
X-Received: by 2002:a17:902:ed11:b029:d1:f385:f4e7 with SMTP id
 b17-20020a170902ed11b02900d1f385f4e7mr5997772pld.56.1601407381691; Tue, 29
 Sep 2020 12:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200929192204.499006-1-ndesaulniers@google.com>
In-Reply-To: <20200929192204.499006-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 29 Sep 2020 12:22:50 -0700
Message-ID: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
Subject: Re: [PATCH] srcu: avoid escaped section names
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gah, must have had a `-a` in my `git commit --amend`...sorry, will send a v2...

On Tue, Sep 29, 2020 at 12:22 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> The stringification operator, `#`, in the preprocessor escapes strings.
> For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
> they treat section names that contain \".
>
> The portable solution is to not use a string literal with the
> preprocessor stringification operator.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=42950
> Fixes: commit fe15b50cdeee ("srcu: Allocate per-CPU data for DEFINE_SRCU() in modules")
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/arm/Kconfig         |  1 +
>  arch/arm/mm/Kconfig      | 11 +++++++++++
>  include/linux/srcutree.h |  2 +-
>  3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index fe2f17eb2b50..51200e371faf 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -358,6 +358,7 @@ config ARCH_EBSA110
>
>  config ARCH_EP93XX
>         bool "EP93xx-based"
> +       depends on !LD_IS_LLD
>         select ARCH_SPARSEMEM_ENABLE
>         select ARM_AMBA
>         imply ARM_PATCH_PHYS_VIRT
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 65e4482e3849..c06787c9bb48 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -9,6 +9,7 @@ comment "Processor Type"
>  config CPU_ARM7TDMI
>         bool
>         depends on !MMU
> +       depends on !LD_IS_LLD
>         select CPU_32v4T
>         select CPU_ABRT_LV4T
>         select CPU_CACHE_V4
> @@ -23,6 +24,7 @@ config CPU_ARM7TDMI
>  # ARM720T
>  config CPU_ARM720T
>         bool
> +       depends on !LD_IS_LLD
>         select CPU_32v4T
>         select CPU_ABRT_LV4T
>         select CPU_CACHE_V4
> @@ -43,6 +45,7 @@ config CPU_ARM720T
>  config CPU_ARM740T
>         bool
>         depends on !MMU
> +       depends on !LD_IS_LLD
>         select CPU_32v4T
>         select CPU_ABRT_LV4T
>         select CPU_CACHE_V4
> @@ -61,6 +64,7 @@ config CPU_ARM740T
>  config CPU_ARM9TDMI
>         bool
>         depends on !MMU
> +       depends on !LD_IS_LLD
>         select CPU_32v4T
>         select CPU_ABRT_NOMMU
>         select CPU_CACHE_V4
> @@ -75,6 +79,7 @@ config CPU_ARM9TDMI
>  # ARM920T
>  config CPU_ARM920T
>         bool
> +       depends on !LD_IS_LLD
>         select CPU_32v4T
>         select CPU_ABRT_EV4T
>         select CPU_CACHE_V4WT
> @@ -94,6 +99,7 @@ config CPU_ARM920T
>  # ARM922T
>  config CPU_ARM922T
>         bool
> +       depends on !LD_IS_LLD
>         select CPU_32v4T
>         select CPU_ABRT_EV4T
>         select CPU_CACHE_V4WT
> @@ -114,6 +120,7 @@ config CPU_ARM922T
>  # ARM925T
>  config CPU_ARM925T
>         bool
> +       depends on !LD_IS_LLD
>         select CPU_32v4T
>         select CPU_ABRT_EV4T
>         select CPU_CACHE_V4WT
> @@ -153,6 +160,7 @@ config CPU_ARM926T
>  # FA526
>  config CPU_FA526
>         bool
> +       depends on !LD_IS_LLD
>         select CPU_32v4
>         select CPU_ABRT_EV4
>         select CPU_CACHE_FA
> @@ -172,6 +180,7 @@ config CPU_FA526
>  config CPU_ARM940T
>         bool
>         depends on !MMU
> +       depends on !LD_IS_LLD
>         select CPU_32v4T
>         select CPU_ABRT_NOMMU
>         select CPU_CACHE_VIVT
> @@ -278,6 +287,7 @@ config CPU_ARM1026
>  # SA110
>  config CPU_SA110
>         bool
> +       depends on !LD_IS_LLD
>         select CPU_32v3 if ARCH_RPC
>         select CPU_32v4 if !ARCH_RPC
>         select CPU_ABRT_EV4
> @@ -299,6 +309,7 @@ config CPU_SA110
>  # SA1100
>  config CPU_SA1100
>         bool
> +       depends on !LD_IS_LLD
>         select CPU_32v4
>         select CPU_ABRT_EV4
>         select CPU_CACHE_V4WB
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index 9cfcc8a756ae..9de652f4e1bd 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -124,7 +124,7 @@ struct srcu_struct {
>  # define __DEFINE_SRCU(name, is_static)                                        \
>         is_static struct srcu_struct name;                              \
>         struct srcu_struct * const __srcu_struct_##name                 \
> -               __section("___srcu_struct_ptrs") = &name
> +               __section(___srcu_struct_ptrs) = &name
>  #else
>  # define __DEFINE_SRCU(name, is_static)                                        \
>         static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);      \
> --
> 2.28.0.709.gb0816b6eb0-goog
>


-- 
Thanks,
~Nick Desaulniers
