Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09CD23ACB6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 21:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHCTCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 15:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgHCTCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:02:19 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4A8C061757
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 12:02:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i92so384378pje.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O6tP2dRjUFwZbhO7kTIUZzIPSMn6S/VsoDqV/IeCHas=;
        b=GwyGimjvlfZSm4rPZf87qz1lpYAb9Sb5zXQ8UcytIulZag6qIJXsvXyLdFFUopSqv0
         /Fl1mCDdlrGtNOLSad2vl3ZlOQsuBisUBiYIQzm7JpDk1z9AjEBamBieoyh1KTMHOfZw
         tTglBd2CZnJo/XvFepNNiaRJ+uKZqWJnhtQBcDQTFDZJqiFuZKGXSJHh2q0IcYen5MAj
         +OLdSIe09Sb9neR+ZY70179YUgHipcD+bi/EBZby9k184pQbkAG1gF+JC2xh72xxod+t
         LO7i8FjJzU+JuKl2NXKM+BD1j8+TKX7ofkLgn1K+/f0ff8iojdwSiaSlDqhIeoReXUdu
         ODzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O6tP2dRjUFwZbhO7kTIUZzIPSMn6S/VsoDqV/IeCHas=;
        b=RUXyP6Vvlms3rLSB9rcQYlbj744nTf4KtPJBVmMjGkefMXVzFabXNrw39ZAQYwY0vA
         T0eQfPA+3w5NDdILl4XUuNvql3x4aOnGkVOPNUYeFWog23t3u+WMzzBTg13a7X9w0vRT
         Dx6VJjhtem5HBZ7GA6eIo83kVX6ygS+xF3QzgiDsZjG++0ohuTejcSei+DiiYQ23WI9S
         BA8yt+EE+ftPnlEHtGCf5Qq88GHoub3fEbDnD9ZeO3zEShSbhmswmlExgF/o/PjIr0h/
         +J6xq83tGcKgwreLbyAd4wLwBhUM3LIjymUI3mtpyjctIsETnQg5hVzEq03hO8HIVewK
         RtBw==
X-Gm-Message-State: AOAM5327rxg0jjcpGCTqx2u8+nacDuIWrwxw7+qXzc7kSmMdTiYZo0B9
        piQ2eqsDAFPRhNmzpCfD8kD8RgPUyQM0V4UcDDRYtg==
X-Google-Smtp-Source: ABdhPJxOc/yfQNk64Iy0M39ewebcq0NAT7dVOLQV9Zog2Bi8sDwMJRwELSzWvaGVypHwF46JkoKwRl+45aGkQMpUBps=
X-Received: by 2002:a17:90b:1103:: with SMTP id gi3mr726306pjb.32.1596481338531;
 Mon, 03 Aug 2020 12:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200731230820.1742553-1-keescook@chromium.org> <20200731230820.1742553-24-keescook@chromium.org>
In-Reply-To: <20200731230820.1742553-24-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 3 Aug 2020 12:02:07 -0700
Message-ID: <CAKwvOdn11z+iFQZC54JvQHC=NFX1FsoRMw2a-2P=5sQ6FKwbnw@mail.gmail.com>
Subject: Re: [PATCH v5 23/36] arm/build: Explicitly keep .ARM.attributes sections
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 4:18 PM Kees Cook <keescook@chromium.org> wrote:
>
> In preparation for adding --orphan-handling=warn, explicitly keep the
> .ARM.attributes section by expanding the existing ELF_DETAILS macro into
> ARM_DETAILS.
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Link: https://lore.kernel.org/lkml/CAKwvOdk-racgq5pxsoGS6Vtifbtrk5fmkmnoLxrQMaOvV0nPWw@mail.gmail.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm/include/asm/vmlinux.lds.h | 4 ++++
>  arch/arm/kernel/vmlinux-xip.lds.S  | 2 +-
>  arch/arm/kernel/vmlinux.lds.S      | 2 +-
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
> index a08f4301b718..c4af5182ab48 100644
> --- a/arch/arm/include/asm/vmlinux.lds.h
> +++ b/arch/arm/include/asm/vmlinux.lds.h
> @@ -52,6 +52,10 @@
>                 ARM_MMU_DISCARD(*(__ex_table))                          \
>                 COMMON_DISCARDS
>
> +#define ARM_DETAILS                                                    \
> +               ELF_DETAILS                                             \
> +               .ARM.attributes 0 : { *(.ARM.attributes) }

I had to look up what the `0` meant:
https://sourceware.org/binutils/docs/ld/Output-Section-Attributes.html#Output-Section-Attributes
mentions it's an "address" and
https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_chapter/ld_3.html#SEC21
mentions it as "start" (an address).
Unless we need those, can we drop them? (Sorry for the resulting churn
that would cause).  I think the NO_LOAD stuff makes more sense, but
I'm curious if the kernel checks for that.

> +
>  #define ARM_STUBS_TEXT                                                 \
>                 *(.gnu.warning)                                         \
>                 *(.glue_7)                                              \
> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
> index 904c31fa20ed..57fcbf55f913 100644
> --- a/arch/arm/kernel/vmlinux-xip.lds.S
> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> @@ -150,7 +150,7 @@ SECTIONS
>         _end = .;
>
>         STABS_DEBUG
> -       ELF_DETAILS
> +       ARM_DETAILS
>  }
>
>  /*
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index bb950c896a67..1d3d3b599635 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -149,7 +149,7 @@ SECTIONS
>         _end = .;
>
>         STABS_DEBUG
> -       ELF_DETAILS
> +       ARM_DETAILS
>  }
>
>  #ifdef CONFIG_STRICT_KERNEL_RWX
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
