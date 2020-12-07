Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C8E2D1B1F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgLGUsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727288AbgLGUs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:48:29 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AF1C061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 12:47:49 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id g20so1650326oos.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 12:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O8MHc0bkaqtEgfXzX9IcijUfPytzNuGviQ8Ld2feZE0=;
        b=M4EeiBVT5qO3N+RSm+RjkQqRnTwYMaqynM9CGNdvQCKEdeZBKAA0nri72d/1pAWseG
         xBBzs9W9YLZcz/eOx5KFEarqLQeUNt6UOQSr6Krq4rX3ccqCx1OAZr9D6jU8yKGwwPIH
         AIGd90FA92blZskIIJmQ99g5DxTCsM9iDGrOLyQ2RuQMUBUuTDJXv+FtaMFlN/Fd13YB
         rMJGRfv8zNK7ZoDyazGs4B19igxQZ+7Xddz0vzajTYAo8N/SmD4f6g8tPHBgn/DB0T5H
         EW6fBulqYoGPfvcthAaQjlGP0QE9Z1X2GtMQSCQbBMZgtP3EpeI2QQurCr0FEYy7L3I5
         pt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8MHc0bkaqtEgfXzX9IcijUfPytzNuGviQ8Ld2feZE0=;
        b=bRE78aC8qQ7AOWecXy216BQZun0CJAUCcZINERajYGgH+DchaSxC/loP6A4AtmFyF1
         9bMWMrYXguxeSWmu+C0a2Vxyvf899AsYqVAves5dvP/CvPAiBfjflK/4ji3XbO2Bdkyi
         +2xdJoxtw/eLS1OeZFjZpHbTVY0IG0lhpPrZx8ov/U2z8AQbbHEuM1kPbx1+PYZYJjwE
         rJWsiacwxEagLF5bF7oHpDwO93SpXJx3DlzX379fr9h4AOenJBksPjEAeVDwSRa0N7QK
         /BV/JUD/mfiDkVI4ANanBmr5++yQRkc15XgTK8sKmehNYq4K5u8wEaioA5PTkgwb/lYR
         iwmw==
X-Gm-Message-State: AOAM530PVh8KYa5U+/RblXFPMvdHfLcSW2Z5n5A9TtkEqBdE4mAGs3aw
        uQdQwBAN4+sk1cTl2jA57cqjojxSE1x+KHNBCIk=
X-Google-Smtp-Source: ABdhPJx2TaqdmeapmZM3GH6do6PsmIwz1wLX47b8zT/hxz2SuY+/nw9k/kcoAafnECFzdOYp6II6138ifAwMMcD6rnc=
X-Received: by 2002:a4a:330b:: with SMTP id q11mr7063370ooq.90.1607374068633;
 Mon, 07 Dec 2020 12:47:48 -0800 (PST)
MIME-Version: 1.0
References: <20201204081349.1182302-1-arnd@kernel.org>
In-Reply-To: <20201204081349.1182302-1-arnd@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Dec 2020 15:47:37 -0500
Message-ID: <CADnq5_OmAVZGuz=xHRyST4hE4w1g10wNBQ6iMgfpQD16-9QSiQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: make DRM_AMD_DC x86-only again
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roman Li <Roman.Li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Daniel Kolesa <daniel@octaforge.org>,
        Timothy Pearson <tpearson@raptorengineering.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 3:13 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> As the DRM_AMD_DC_DCN3_0 code was x86-only and fails to build on
> arm64, merging it into DRM_AMD_DC means that the top-level symbol
> is now x86-only as well.
>
> Compilation fails on arm64 with clang-12 with
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3641:6: error: stack frame size of 2416 bytes in function 'dml30_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than=]
> void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
>
> I tried to see if the stack usage can be reduced, but this is code
> that is described as "This file is gcc-parsable HW gospel, coming
> straight from HW engineers." and is written in a way that is inherently
> nonportable and not meant to be understood by humans.
>
> There are probably no non-x86 users of this code, so simplify
> the dependency list accordingly.

+ Daniel, Timothy

Others contributed code to enable this on PPC64 and ARM64.
Unfortunately, we don't have these platforms to test with within AMD.
Does PPC64 have the same stack limitations as ARM64?  Harry, Leo, can
you take a look at fixing the stack usage?

Thanks,

Alex

>
> Fixes: 20f2ffe50472 ("drm/amdgpu: fold CONFIG_DRM_AMD_DC_DCN3* into CONFIG_DRM_AMD_DC_DCN (v3)")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/display/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 797b5d4b43e5..54aa50d4deba 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -6,7 +6,7 @@ config DRM_AMD_DC
>         bool "AMD DC - Enable new display engine"
>         default y
>         select SND_HDA_COMPONENT if SND_HDA_CORE
> -       select DRM_AMD_DC_DCN if (X86 || PPC64 || (ARM64 && KERNEL_MODE_NEON)) && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
> +       select DRM_AMD_DC_DCN if X86 && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
>         help
>           Choose this option if you want to use the new display engine
>           support for AMDGPU. This adds required support for Vega and
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
