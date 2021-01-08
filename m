Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E132EF9F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbhAHVJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbhAHVJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:09:49 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2508FC061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:09:09 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id s75so12906916oih.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hj2BDjkjwXsMxC7AwthRbXSFYL/Nuw/Pgh7craXfm4Y=;
        b=df/i+IUS/WvgV2yk+srMUN2ud5xcHg4fi3IKglxVDhn9WSR2e9KkbQjuXQrESEDP8A
         vFRXLqG+Vw5yGaSMGJWm5IwJJN24k0ehBQh9YucrX9yXPOHDBU8vmoHET16I1FXAL6Ow
         5hLxwudrB/i/Lw/N1UIF8JH4AW300TC0lK/deGiOlELw3HPZa5bGLvRqf72dkNdyLfVo
         BqefH2pZlyOIlX5r7A0JPrSjjCnzp/hQ+RXxoXix4MiE1ztsg3lxH/bxZcSALcPlv5Lh
         Hw4WpKYQA5u0uR/TsWgWhddtSAM/ddTKNj42+XOiCdYjzKl0oRDCSFbCj5+tNsWFlnGJ
         dkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hj2BDjkjwXsMxC7AwthRbXSFYL/Nuw/Pgh7craXfm4Y=;
        b=mnW7z+psrMPJ/wQbl/d48HTNJ/0kFMSoNDXX0tey9jf2ULPm7uVNg095yuApMNu152
         YdqFTe7rHUMx1Dmx71Ivfe9nCAH24W4L415l8ryv17N7A4TUCnIONUPWEvueJBFGzyNG
         yqah9z2bGv7Bp9ZwCqUFjkAkGUXfOBPA8hP2jZWdaFqz7TBjo15v1C0uvpFum2UhBsTO
         jQNKpTY1VZ2M7fc1aMZB/LtSZVRAXvb5kxGD7FRIFIkP8t++m3bTm4AVhOLiRYBwWeji
         lEl4uLpryueZ+rRSA/R0wb90ZqSlvyE/x5MpNpGe7ZfPHJa7oSEPuXgwGwkNRNS2UjUY
         dLlA==
X-Gm-Message-State: AOAM532Owy9MmaIcFO2BcTMaXPN5WRUNN5NRXZQp8N5XrmaGv2YLLHq7
        bjvAoc0utiasnTMfJwVc2ZjzG9IDuOcjGRFgc80=
X-Google-Smtp-Source: ABdhPJxERzv0PbVY1h7MH3aEGuyAxH6AnBzi7W7TneraBmWUvS9TSHsDBFrs3+muIaxjBJ83Y8Khij7L5DKzv0d+Qq4=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr3495197oib.123.1610140148635;
 Fri, 08 Jan 2021 13:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-24-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-24-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:08:57 -0500
Message-ID: <CADnq5_O6tuHm6AQEFZWofm_kaWGVG5O_sTXUsBT_=c9-qTN4ug@mail.gmail.com>
Subject: Re: [PATCH 23/40] drm/amd/display/dc/dce/dce_audio: Make function
 invoked by reference static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Charlene Liu <Charlene.Liu@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.c:871:6: warning:=
 no previous prototype for =E2=80=98dce60_aud_wall_dto_setup=E2=80=99 [-Wmi=
ssing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Mauro Rossi <issor.oruam@gmail.com>
> Cc: Charlene Liu <Charlene.Liu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_audio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu=
/drm/amd/display/dc/dce/dce_audio.c
> index 2a2a0fdb92539..7866cf2a668fa 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> @@ -868,7 +868,7 @@ void dce_aud_wall_dto_setup(
>  }
>
>  #if defined(CONFIG_DRM_AMD_DC_SI)
> -void dce60_aud_wall_dto_setup(
> +static void dce60_aud_wall_dto_setup(
>         struct audio *audio,
>         enum signal_type signal,
>         const struct audio_crtc_info *crtc_info,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
