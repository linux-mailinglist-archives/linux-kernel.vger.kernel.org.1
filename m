Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FA92ED460
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbhAGQac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbhAGQab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:30:31 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0820C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 08:29:50 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id h186so4201076pfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 08:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FpXEjxjV8OA24pUWXj8gzsn1GWb+lIIbFcLAwI2yW6M=;
        b=MNQpruws9fgcWh82xa59SNVkyYGer9g6kYEfTTvrC7dc3BQeHcFsslYr/ygeNcnpvk
         6UfHt1riKnkjWLnR9AXJhsOwVCPswgIi+7AQr9gh+goe40zE2+p+NtKiefZsSnCbhDTq
         CS5vzG+aJuoTkX162eOQQYDKOoyACBh+OiPk7DN970+SsbTahoP4+Sd23qyW/MpsD++E
         89xUcRPdjnD3MsLgdnNxwIGtT54vmN9UAAxUUdAdJcCs2eeaTIYFCBIwuDjz6sRKU871
         z9PRUQlIpC2yLQQKRKBigTVsRU7zpDc6d9iKbyl4C9y0VeihB5OtcC+ExgLuqVPwCnHK
         bOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpXEjxjV8OA24pUWXj8gzsn1GWb+lIIbFcLAwI2yW6M=;
        b=R1MAEx4V2sn7TAftepSdB84epKVNUi/A9qW3q7WGOwvVoM5sgSCuKca3uzQJJR56Mu
         r5gqIW8P+GJhejC66A886oIhqWHYCMIXVTnheEse60ld11LG6U4CwNeXKT7Hll3KVmMH
         SrwLqXgpS7R/Ug/mq28yaNErPKhEh6bPuuMaO6RFEGMQsDKg7hlk/R4YYV119VTiv5VU
         xedjhCshb2HT2wjHUHk/elTVR9+Pdl22bZKWGs8vNPDbNrUSnS4wfrqhnKXpqUoS4hJ0
         x/P5dJJZkfLpZLnadLm8gnjr3vtuZULe4c6MzMhS0Mc9fAkHVivnoyEi9iJqNf0FxFUZ
         tZCg==
X-Gm-Message-State: AOAM530PNBGmSlDhb7TKYPe9o55nqWcmCAX5B3DID4j8gLiG4HHCzPnZ
        qOu5n8UrDsCezm4T5sP868n6BLAffoZbQ7Rff9AtHg==
X-Google-Smtp-Source: ABdhPJyXIT2I6ZawKyhg4hXllpWgbIJy6aKDJ16wqxqjtn+GXKKMmwiYCZdBOmMbZmK2t8UUxQsfvqzNcDp73LRLE3k=
X-Received: by 2002:a62:2585:0:b029:1ab:7fb7:b965 with SMTP id
 l127-20020a6225850000b02901ab7fb7b965mr9501125pfl.2.1610036989989; Thu, 07
 Jan 2021 08:29:49 -0800 (PST)
MIME-Version: 1.0
References: <20210106115519.32222-1-vincenzo.frascino@arm.com> <20210106115519.32222-3-vincenzo.frascino@arm.com>
In-Reply-To: <20210106115519.32222-3-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 7 Jan 2021 17:29:39 +0100
Message-ID: <CAAeHK+xuGRzkLdrfGZVo-RVfkH31qUrNdBaPd4k5ffMKHWGfTQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: mte: Add asynchronous mode support
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
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

On Wed, Jan 6, 2021 at 12:56 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> MTE provides an asynchronous mode for detecting tag exceptions. In
> particular instead of triggering a fault the arm64 core updates a
> register which is checked by the kernel at the first entry after the tag
> exception has occurred.
>
> Add support for MTE asynchronous mode.
>
> The exception handling mechanism will be added with a future patch.
>
> Note: KASAN HW activates async mode via kasan.mode kernel parameter.
> The default mode is set to synchronous.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/kernel/mte.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 24a273d47df1..5d992e16b420 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -153,8 +153,35 @@ void mte_init_tags(u64 max_tag)
>
>  void mte_enable_kernel(enum kasan_arg_mode mode)
>  {
> -       /* Enable MTE Sync Mode for EL1. */
> -       sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> +       const char *m;
> +
> +       /* Preset parameter values based on the mode. */
> +       switch (mode) {
> +       case KASAN_ARG_MODE_OFF:
> +               return;
> +       case KASAN_ARG_MODE_LIGHT:
> +               /* Enable MTE Async Mode for EL1. */
> +               sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_ASYNC);
> +               m = "asynchronous";
> +               break;
> +       case KASAN_ARG_MODE_DEFAULT:
> +       case KASAN_ARG_MODE_PROD:
> +       case KASAN_ARG_MODE_FULL:
> +               /* Enable MTE Sync Mode for EL1. */
> +               sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> +               m = "synchronous";
> +               break;
> +       default:
> +               /*
> +                * kasan mode should be always set hence we should
> +                * not reach this condition.
> +                */
> +               WARN_ON_ONCE(1);
> +               return;
> +       }
> +
> +       pr_info_once("MTE: enabled in %s mode at EL1\n", m);
> +
>         isb();
>  }
>
> --
> 2.29.2
>

Hi Vincenzo,

It would be cleaner to pass a bool to mte_enable_kernel() and have it
indicate sync/async mode. This way you don't have to pull all these
KASAN constants into the arm64 code.

Thanks!
