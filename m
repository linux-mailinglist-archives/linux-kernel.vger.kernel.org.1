Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D3A2F6716
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbhANRMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbhANRMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:12:44 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DCDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:12:04 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id w124so6629395oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GJvDy+TdE2Sd8aU9LhoJufW6xnX6FlKnoE7upSm4sCE=;
        b=ZC/tjSi7JmDbWzwVT2w3iAM+LPyO57IVQbUxi/+0Olm8mse6jVNx9p3rDxyKvvHDzF
         tDzn3t9HnObGV+8Nlompi9AtKHZojzAtWPqBC0vfQPt6ncE4Z/KTlLenmMrULmMSVlAM
         nY74BOVql0EhE3cyG/MXuPsLm+ZnNg4iFv/nowoKXZdkBZYu6zwetcmPTXzakdFLmaMp
         pHj+OZVd8EjsNC+F8S/oG0XYwPfkhVnDn3lMRO3Do9kcQCL1ibcTxgHqpZfSVdF2otkE
         IrWqtYUB0yBvQaWQ8ndpU92r4JNGXxNcYS/2nKkk5K7KNAl3FWstGE7q+7w/tjH6HMmV
         WZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GJvDy+TdE2Sd8aU9LhoJufW6xnX6FlKnoE7upSm4sCE=;
        b=MOsPoiIY1bONYTOnvp/Yau7LbyjcBINZgXCHA4zBAdHS/4mbKwHVVoxXF83dCLIJbh
         6z2EiJm75ziLKtDrZW5RbCJVuBB/JQKS8LQNk7dLLvjTWpKBVF+l/qt3hCndUqguQdm5
         lm+LnAK78NWojNsipOSx23v4xsjWcOjt5NbAnh6a8WVBYSJCDYHdMoUwe7pbrziLNLzs
         GSSwe7QzRwOo2FemHjFzuDzJBVZC2qNGPjtFc07rx80faTr/0zT32oFgo5je5i06Q1Vl
         xSVBsXHhrn8Y8kul4suTEaD+n/lR8ydIzNYIZFCay330syGaUeIZQdhunjMKQmk99T7i
         BXQg==
X-Gm-Message-State: AOAM532AtXGUVbwddpfzsfO4P2GUDUX7R5G/MigN+zoxvg4HjJpjkRmj
        9+q9UN21aLbaaZQ2jhgJP27U+FP+8W2KzkjzsaE=
X-Google-Smtp-Source: ABdhPJwsPS/8l4O8co+0gxKNUnnpaeySzhQqnpgFuv6mJpOamCh85vA9x3LQZSlOJdebd67niENCUz4ZfgOhdxn9mOw=
X-Received: by 2002:aca:6202:: with SMTP id w2mr3004573oib.5.1610644323637;
 Thu, 14 Jan 2021 09:12:03 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-12-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-12-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:11:52 -0500
Message-ID: <CADnq5_OescDuOnxnQP6UK6X0OZtnGwf7kZ-hxptfV3KCOwO4=g@mail.gmail.com>
Subject: Re: [PATCH 11/30] drm/amd/display/dc/dce100/Makefile: Ignore
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
>  In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dc=
e100_resource.c:54:
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_10_0_sh_mask.h:50=
84:45: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: not=
e: in expansion of macro =E2=80=98GRPH_CONTROL__GRPH_NUM_BANKS__SHIFT=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:170:2: note=
: in expansion of macro =E2=80=98SFB=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:291:2: note=
: in expansion of macro =E2=80=98MI_GFX8_TILE_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:537:3:=
 note: in expansion of macro =E2=80=98MI_DCE8_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_10_0_sh_mask.h:50=
84:45: note: (near initialization for =E2=80=98mi_shifts.GRPH_NUM_BANKS=E2=
=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: not=
e: in expansion of macro =E2=80=98GRPH_CONTROL__GRPH_NUM_BANKS__SHIFT=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:170:2: note=
: in expansion of macro =E2=80=98SFB=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:291:2: note=
: in expansion of macro =E2=80=98MI_GFX8_TILE_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:537:3:=
 note: in expansion of macro =E2=80=98MI_DCE8_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_10_0_sh_mask.h:50=
83:43: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: not=
e: in expansion of macro =E2=80=98GRPH_CONTROL__GRPH_NUM_BANKS_MASK=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:170:2: note=
: in expansion of macro =E2=80=98SFB=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:291:2: note=
: in expansion of macro =E2=80=98MI_GFX8_TILE_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:542:3:=
 note: in expansion of macro =E2=80=98MI_DCE8_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_10_0_sh_mask.h:50=
83:43: note: (near initialization for =E2=80=98mi_masks.GRPH_NUM_BANKS=E2=
=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: not=
e: in expansion of macro =E2=80=98GRPH_CONTROL__GRPH_NUM_BANKS_MASK=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:170:2: note=
: in expansion of macro =E2=80=98SFB=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:291:2: note=
: in expansion of macro =E2=80=98MI_GFX8_TILE_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:542:3:=
 note: in expansion of macro =E2=80=98MI_DCE8_MASK_SH_LIST=E2=80=99
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
>  drivers/gpu/drm/amd/display/dc/dce100/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce100/Makefile b/drivers/gpu=
/drm/amd/display/dc/dce100/Makefile
> index a822d4e2a1693..ff20c47f559e3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce100/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dce100/Makefile
> @@ -23,6 +23,8 @@
>  # Makefile for the 'controller' sub-component of DAL.
>  # It provides the control and status of HW CRTC block.
>
> +CFLAGS_$(AMDDALPATH)/dc/dce100/dce100_resource.o =3D $(call cc-disable-w=
arning, override-init)
> +
>  DCE100 =3D dce100_resource.o dce100_hw_sequencer.o
>
>  AMD_DAL_DCE100 =3D $(addprefix $(AMDDALPATH)/dc/dce100/,$(DCE100))
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
