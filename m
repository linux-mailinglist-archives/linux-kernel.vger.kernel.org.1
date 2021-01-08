Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44232EF75A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 19:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbhAHSa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 13:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbhAHSa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:30:27 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62CEC061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 10:29:46 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id q7so6238681pgm.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 10:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImNmyS8KVcMriGTOlK4oD0X1A4b7wVMix0T8JHsJDBw=;
        b=Y0K7rPxt7Xxsk60fVNg19jFZvTgygV+/JV0g08lleOn3I3xFx3/pVCAHl2K20exays
         bgRQx37jUuscIru6TAY1YUB2MKnooMRFygwz/6ktZwf+kkg0C/SQON+OfJ/oW7W2WStE
         JrKrTtAiBZ7Y8ECm9juQWdQftv9s19Paay+kdH2j7DBXXHhQAmtvnmCjJUZc5zzRxONO
         nPGaC3wuxqbMV0eV2bCZtiHWCCJ46Nh2RHPMv8f7Il+0yQw+vDeyKJtnEhu/3+gFdvWl
         Fej5Denqp+sQyYl++MVYFHzquIrTUG6S36GHtVpIR744TONmjxbFaHGGsKk9DLgeXNOM
         cObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImNmyS8KVcMriGTOlK4oD0X1A4b7wVMix0T8JHsJDBw=;
        b=YCWegXIiJ8Cgw6wiRN3thsPrP6E9CGMJz9STwMb1F6lWq1QVnM0nagorRgdO4Ff/le
         MjKHqWKIrkXwy8p843lcAVWdeYffF9d7gEBceggUx/WFPCWYs0uB/sVAVtAruan2fPPd
         puoYmtRftNjeFdPfFfy3tdIpd3lwx4UPsFDzM842zpA2GRacwEfpwnSxR7+UYGHcGnYu
         khP9SgzfsBBxtHhlpU3fPYMYPu+T2ZI3uQ6xfD4bmt/SlJKw0CBxU9b8HiM+YqRzTp+0
         1WaM36AVuVrdE2/Osg2lzLV08kYbSGgkaan4erKG8Q4/lP/bygiLEkw7TWNgqAhW6NSG
         0v5w==
X-Gm-Message-State: AOAM531vVefQPV8A6V/JuGnw5qh7U90rxvgfe5dD6jYfpAGheyv7ysta
        3FOufDyp7VX8aqvvJA8u/y03DOvUMTVK5x/h8hAq8Q==
X-Google-Smtp-Source: ABdhPJwRVQkqjw+eGZx3kmV8ynRpiyG2GnMECRiKr0qdFfd6rO/yKeaxlSxN3DB3SIBtCjRla8iMWhyfoyRubShuGWM=
X-Received: by 2002:a62:14c4:0:b029:19d:d3f5:c304 with SMTP id
 187-20020a6214c40000b029019dd3f5c304mr4738308pfu.55.1610130586296; Fri, 08
 Jan 2021 10:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20210103171137.153834-1-lecopzer@gmail.com> <20210103171137.153834-4-lecopzer@gmail.com>
In-Reply-To: <20210103171137.153834-4-lecopzer@gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 8 Jan 2021 19:29:35 +0100
Message-ID: <CAAeHK+wc-DU2pUma43JtomOSy0Z6smGKwQoG_R+uKzByu3oZ9w@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: Kconfig: support CONFIG_KASAN_VMALLOC
To:     Lecopzer Chen <lecopzer@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 3, 2021 at 6:13 PM Lecopzer Chen <lecopzer@gmail.com> wrote:
>
> Now I have no device to test for HW_TAG, so keep it not selected
> until someone can test this.
>
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 05e17351e4f3..29ab35aab59e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -136,6 +136,7 @@ config ARM64
>         select HAVE_ARCH_JUMP_LABEL
>         select HAVE_ARCH_JUMP_LABEL_RELATIVE
>         select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
> +       select HAVE_ARCH_KASAN_VMALLOC if (HAVE_ARCH_KASAN && !KASAN_HW_TAGS)

KASAN_VMALLOC currently "depends on" KASAN_GENERIC. I think we should
either do "HAVE_ARCH_KASAN && KASAN_GENERIC" here as well, or just do
"if HAVE_ARCH_KASAN".

>         select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
>         select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
>         select HAVE_ARCH_KGDB
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210103171137.153834-4-lecopzer%40gmail.com.
