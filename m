Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105B7302753
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbhAYPww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 10:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730579AbhAYPwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:52:05 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C69C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:51:25 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id i30so13156911ota.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AnH8Zx3d2Pw4vQ7JjSbzPf+jFEKtnCEURYKMXZ7izF4=;
        b=ZcxU7anJ2ZSWMdXAhgnTS6vQEEaxIWbMi+Sl+qOBbZIW5+oXuoVr2qGbaXlCtdyBZV
         Aa7S5SWpJxIKk/p5bp5oozc2iQ7Nk1DfJjxzTFy2mO2M0rmvHXUwH3bvrhyzJngc+jRQ
         N7iOVvDIrbxs3ktZ23PBBxzgcg4o5Sek/QAVmLZY3BH6YyWNH/YfXEXA0XRpCM4VH2y0
         X6fCWC5YmfgsR9kSlOo3kHtWmUW1/36BHlts/+u8vXOhqnhVmg7cCpbtPFIuk8Q6GIpS
         QxOSH6I02N5gup190GQSXndTJdlB1RKSikDgABqI9KkBxNjQb32svdstebhNzsZRlM5y
         OoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AnH8Zx3d2Pw4vQ7JjSbzPf+jFEKtnCEURYKMXZ7izF4=;
        b=WBI1GDxwr1N/cvCvHAfMR4MpmJ3Al992/jKtgTcldrkOGEjkxQLo/tKAnxD28xm8Ke
         j8wqiC54+FxJpL2WlbEHQhTOSE52Uz/zlHuf4cBe0PDGdm3KntOpbpFyu6zCnUg+S1Oq
         OP2UFGUzp1URCpot568giKqlbX59mESIAqOJGsnOMN6ZKoaHpLMM6VEck0sPW1aaCac9
         3g995S8+vTpucjOs6VJpCTVW5gllswMvwAkavWf/yp4+7Z3XDX1v9XHMh4xIK/aMBjB7
         WxesEoFmHxo9D0TdfK7bWnhC4lrlmjUFE4HwQvW6KgotYFlOUfKPMXp/dz/Mb2FOkNFC
         iPlQ==
X-Gm-Message-State: AOAM532tM7MkNoy19sFaCMgf8rf36c7hHUj3AdNBpf+2uVYYfi+2yUQ9
        PyYqKH7hL/BLlGdzn2Qj5bnGuKmxSvofBIqkSaQ=
X-Google-Smtp-Source: ABdhPJxkHywTepuBn+fqbpyLJEosnBpNCyVcv27jF2qPKIMyyV4cAkh1nb0ayowYwrnFaAztgS4G1/tHe/M5JWEe6AA=
X-Received: by 2002:a9d:784a:: with SMTP id c10mr931304otm.132.1611589884729;
 Mon, 25 Jan 2021 07:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20210125122402.4036126-1-arnd@kernel.org>
In-Reply-To: <20210125122402.4036126-1-arnd@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 25 Jan 2021 10:51:13 -0500
Message-ID: <CADnq5_MLYdu+cY88yzmv+D6A0twg64C0vLBEhPazCgGseEWg=Q@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: fix clang build warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Joshua Aberback <joshua.aberback@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, Roman Li <Roman.Li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Will Deacon <will@kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 7:24 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang warns about the -mhard-float command line arguments
> on architectures that do not support this:
>
> clang: error: argument unused during compilation: '-mhard-float' [-Werror,-Wunused-command-line-argument]
>
> Move this into the gcc-specific arguments.
>
> Fixes: e77165bf7b02 ("drm/amd/display: Add DCN3 blocks to Makefile")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/Makefile  | 6 ++++--
>  drivers/gpu/drm/amd/display/dc/dcn301/Makefile | 3 ++-
>  drivers/gpu/drm/amd/display/dc/dcn302/Makefile | 3 ++-
>  3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> index c20331eb62e0..dfd77b3cc84d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> @@ -32,8 +32,8 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
>
>
>  ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -msse
>  endif
>
>  ifdef CONFIG_PPC64
> @@ -45,6 +45,8 @@ ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -mhard-float
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o += -mhard-float
>  endif
>
>  ifdef CONFIG_X86
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
> index 3ca7d911d25c..09264716d1dc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
> @@ -14,7 +14,7 @@ DCN301 = dcn301_init.o dcn301_resource.o dcn301_dccg.o \
>                 dcn301_dio_link_encoder.o dcn301_hwseq.o dcn301_panel_cntl.o dcn301_hubbub.o
>
>  ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn301/dcn301_resource.o := -mhard-float -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn301/dcn301_resource.o := -msse
>  endif
>
>  ifdef CONFIG_PPC64
> @@ -25,6 +25,7 @@ ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> +CFLAGS_$(AMDDALPATH)/dc/dcn301/dcn301_resource.o += -mhard-float
>  endif
>
>  ifdef CONFIG_X86
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> index 8d4924b7dc22..101620a8867a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> @@ -13,7 +13,7 @@
>  DCN3_02 = dcn302_init.o dcn302_hwseq.o dcn302_resource.o
>
>  ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -msse
>  endif
>
>  ifdef CONFIG_PPC64
> @@ -24,6 +24,7 @@ ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> +CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o += -mhard-float
>  endif
>
>  ifdef CONFIG_X86
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
