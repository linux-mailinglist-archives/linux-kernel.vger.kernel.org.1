Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE472F6729
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbhANROO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbhANRON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:14:13 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E15C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:13:32 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id c18so54889oto.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=guVHfTm9U1BbJ/83nhR/rlmHAnSxZweOGvB2OkpNdfs=;
        b=OxmghgygzAMr8wxjWCJJEee0C8Jwm0T6+yMkuV1eCH1EkbAM0dIo0r4/gp8m/0k2xE
         7Qa5+YM9PxFqnTQM7DukVnemh64JZIICF9Ax6eaPt1gtD76gF3Ib1H2use7+JiHExB/L
         u0AySb517onG/CnSK9WORZSNJO0Ubj0ShnFH82rMcfTRG26T18hlR4ugqEFUsOUDAluV
         qgt/cwK7NTIDDXkXy45zHj2sh292EkuBq9J00Oqne1ywZqtA1C7dbTKNkY6NsHH9Lhlb
         8N9lPc/s3KAaHoUjmZcj/IxYIUO+Sp73gM5KhbzER49XbdREhaKccsSSvyxTfN9CDIFa
         M3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=guVHfTm9U1BbJ/83nhR/rlmHAnSxZweOGvB2OkpNdfs=;
        b=OfGRs1ooxrJMifz4XJDKadNqnoagNke15kn8zYiybu5wwH680b/DC60t+LJcDAlmRH
         SzGvIDLQdhPX9WOtK4+rrWwLjBqP8c9nADYyRbt6pWrnkup291oratK8+U/nN/iJSU6w
         alG0xPRVz5ymUH7xw0ln3UGTI1EgdrmsoH7/pFZ6j0vsP08EwiG81CJUte7F5YrQ02Em
         kFAPwTzRTzEtSIwc/eloc/govgiw+ItAuUsh77/Goc1ViTpTcZ/ZaxzB1aZX55axRJ+n
         fdoeGRpecU9O8r+ng9j+wYXnxJo21lwWvgs8MA3OG+hs+yHa0NX16uzeLb2mDRNqOyFT
         Y5OA==
X-Gm-Message-State: AOAM531ZHIxSf7Xk/usr6SORiPLKKDTj94fDBwwZqa3owfJT+iKz/2rS
        o51IsKSTXcOMspr9hrWb/q2sp4eZWPee8QKknA8=
X-Google-Smtp-Source: ABdhPJxWusI9+KRrPHC8KWLTRZM+GGkemdF61/Ia3lx6mdt4MMELdMrXbCZkgVx3jgC68JwaFA8CR0ICSLdY6wpV4/A=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr5468841ote.132.1610644412225;
 Thu, 14 Jan 2021 09:13:32 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-14-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-14-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:13:21 -0500
Message-ID: <CADnq5_MFMvmngNVUVK-u3v9Oz62d+66A2HUCCv0vrwUbOJMzig@mail.gmail.com>
Subject: Re: [PATCH 13/30] drm/amd/display/dc/dce60/Makefile: Ignore
 -Woverride-init warning
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
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

On Wed, Jan 13, 2021 at 3:08 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce=
60_resource.c:28:
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:568:43: w=
arning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:155:14: =
note: in expansion of macro =E2=80=98mmCRTC0_DCFE_MEM_LIGHT_SLEEP_CNTL=E2=
=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:2: note=
: in expansion of macro =E2=80=98SRI=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:181:3: n=
ote: in expansion of macro =E2=80=98XFM_COMMON_REG_LIST_DCE60=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:185:3: n=
ote: in expansion of macro =E2=80=98transform_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:568:43: n=
ote: (near initialization for =E2=80=98xfm_regs[0].DCFE_MEM_LIGHT_SLEEP_CNT=
L=E2=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:155:14: =
note: in expansion of macro =E2=80=98mmCRTC0_DCFE_MEM_LIGHT_SLEEP_CNTL=E2=
=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:2: note=
: in expansion of macro =E2=80=98SRI=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:181:3: n=
ote: in expansion of macro =E2=80=98XFM_COMMON_REG_LIST_DCE60=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:185:3: n=
ote: in expansion of macro =E2=80=98transform_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:645:43: w=
arning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:155:14: =
note: in expansion of macro =E2=80=98mmCRTC1_DCFE_MEM_LIGHT_SLEEP_CNTL=E2=
=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:2: note=
: in expansion of macro =E2=80=98SRI=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:181:3: n=
ote: in expansion of macro =E2=80=98XFM_COMMON_REG_LIST_DCE60=E2=80=99
>
>  NB: Snipped lots for the sake of brevity
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Mauro Rossi <issor.oruam@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce60/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce60/Makefile b/drivers/gpu/=
drm/amd/display/dc/dce60/Makefile
> index 7036c3bd0f871..dda596fa1cd76 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce60/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dce60/Makefile
> @@ -23,6 +23,8 @@
>  # Makefile for the 'controller' sub-component of DAL.
>  # It provides the control and status of HW CRTC block.
>
> +CFLAGS_AMDDALPATH)/dc/dce60/dce60_resource.o =3D $(call cc-disable-warni=
ng, override-init)
> +
>  DCE60 =3D dce60_timing_generator.o dce60_hw_sequencer.o \
>         dce60_resource.o
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
