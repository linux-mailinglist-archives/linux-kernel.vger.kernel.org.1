Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BCB2F6734
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbhANRPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbhANRPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:15:07 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94F0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:14:26 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 15so6635841oix.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e7vZuwAZxOzw7k3z2H8f9KSY3axfstY9BDBHnIavRnE=;
        b=RN5+M9lpNliEOTNMklKwY6LHtvuJsya9Uc/dy/mGm3KAwc05wCogoTr/pjJaIhRVP4
         b5Tb+d/wJt4eeAEJrBjMKAYvhDMY3IpVbiHznD/Hlp1Jcuz+iRlNKYOD5Keew81dosuU
         CBsUQWb+M0kT6g4YLofdBELwx4XiaTOtiCqyOWD3Rled53KE30xMcabHk3PRZz3Fcinq
         bkYANhD3b2+OH21wjwkwui2GNyg+FbgetUvQQk0quB/nbb54Sey/ILjMuZ2TT6DeCo7r
         xbjOS9dDCWbC/RlWx6aStBFweznHeoxX5KixEAtJucoiRGRExycJ2Uw0p4gguSoW2/7F
         8lYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e7vZuwAZxOzw7k3z2H8f9KSY3axfstY9BDBHnIavRnE=;
        b=eV2VKOq0Hj1dO4ZPQVI2Wg2ZhLB6zHQ3wUy7JjOx+oPIwDIsv86d//MG5LdTZu547M
         xz5Xzm5rIEPWxdOsxgoSSwRdn8QmdI/C+XCauWel+MfcH9RMI1Tqn3aOmBX47D2evB0Y
         tgSQLU4xfT8qbs6miFpizkhK45o0ObVXb7+TVCGTxXCBnM1a6CzLHYQqWeVD16rUaIbB
         xyFVRP2sCgzg6Ln7nCCNGAg2lQPE8wnkGgnC68/dSwYENFa1biQoMUZyn7UxVmGKAOAN
         qR58ojQtqQDV2l/22hOxtmoIhO2hI8KngNYpA3Ka+VUo5uTA/jG+1Yx8TnDMR+avsqvJ
         yVmg==
X-Gm-Message-State: AOAM532sQpmb+4XFVDz+pVAQCWlpNwLEueSWaWk/8wEvLTVL+6+zPrP9
        T9g7tXq2770waBYkpkzT3sWgb+AiXECKsvRq4zA=
X-Google-Smtp-Source: ABdhPJwXvyBARwrHLkPgvHf2KHUp5Ur/KNm5pr0Yn5UE+RmnA3ZK1TwSNq0Nw38P81h3AK84uh2LA9pw+8Obwtxu2xY=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr3100502oib.123.1610644466387;
 Thu, 14 Jan 2021 09:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-15-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-15-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:14:15 -0500
Message-ID: <CADnq5_OyiqqnHaZh8s00SN4tSiVh4TYTXj5DK6Vuv-FmNXKY_A@mail.gmail.com>
Subject: Re: [PATCH 14/30] drm/amd/display/dc/dce80/Makefile: Ignore
 -Woverride-init warning
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 3:08 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce=
80_resource.c:29:
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_8_0_sh_mask.h:954=
6:58: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:213:16: note: in =
expansion of macro =E2=80=98AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIF=
T=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:102:2: note: in e=
xpansion of macro =E2=80=98AUX_SF=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:305:2: n=
ote: in expansion of macro =E2=80=98DCE10_AUX_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_8_0_sh_mask.h:954=
6:58: note: (near initialization for =E2=80=98aux_shift.AUX_SW_AUTOINCREMEN=
T_DISABLE=E2=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:213:16: note: in =
expansion of macro =E2=80=98AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIF=
T=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:102:2: note: in e=
xpansion of macro =E2=80=98AUX_SF=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:305:2: n=
ote: in expansion of macro =E2=80=98DCE10_AUX_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_8_0_sh_mask.h:954=
5:56: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:213:16: note: in =
expansion of macro =E2=80=98AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK=
=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:102:2: note: in e=
xpansion of macro =E2=80=98AUX_SF=E2=80=99
>
> NB: Snipped lots for the sake of brevity
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce80/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce80/Makefile b/drivers/gpu/=
drm/amd/display/dc/dce80/Makefile
> index 666fcb2bdbba0..0a9d1a350d8bd 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce80/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dce80/Makefile
> @@ -23,6 +23,8 @@
>  # Makefile for the 'controller' sub-component of DAL.
>  # It provides the control and status of HW CRTC block.
>
> +CFLAGS_$(AMDDALPATH)/dc/dce80/dce80_resource.o =3D $(call cc-disable-war=
ning, override-init)
> +
>  DCE80 =3D dce80_timing_generator.o dce80_hw_sequencer.o \
>         dce80_resource.o
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
