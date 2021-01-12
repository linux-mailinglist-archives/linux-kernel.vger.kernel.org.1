Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B13F2F3F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438247AbhALWQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405114AbhALWQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:16:35 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8147DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:15:55 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id d189so4022057oig.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TPk/MoS2a2L1cJbnsXH08Uh897owOozsQ9nh9DxD7sU=;
        b=lBhq03YJ5GEn2JImUYBBlWeFuOih1WcOj1PbqpZTRWteLaYakNQW6YN5+U7HZaQpFR
         a/h/QeHjrBrpX07KvTaZACAFwPzPVomYrsqZJczkgb1eLyPJnhcaj+T0m6zYeQhbr7nD
         aH5wJhPjK50+lykPwUFsFQiKmYDhBUFceGoFtOB4Q8i+jSivxEvtxxkc7LrthOQEuXtg
         haslozWlCBAl0OStHuQsoalfMnNCGIsLh/rnW5x1SRN1yp16zGhqYlG5S3VLaVnsss1G
         5uFeQ6j6gUHf5Jsc9dmTiUp3cff2GKVS9k+5oFqgpQ7+zv/bjTQxxI4sCz9AR66y3OXD
         xcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TPk/MoS2a2L1cJbnsXH08Uh897owOozsQ9nh9DxD7sU=;
        b=GAGQcPFojW9ohxvzmr4JYYF8sHgZVExecHYKQ1pbfKgwmRNWpjS9CsqITcwxFS8Wkf
         umYxPC6r9F+XJxkv46YErRXK4yLjc53E39nV6KwNoMMmP0SevZpCyv6FhZhUCnZqnFmp
         pe6YN5ClpLWnVI1GMpVcpqUIQoJZKAS6kuivatAfOCcCgBWteMWC9Ow1/5TLgBuwnrYA
         mLHiPYKYpmiSgou6gAX/rH5WZOJNvpTSwYWMrDVhHbJ8JR3xaUJWvWG3Yw4G9pgpEnhG
         g1fNFrmWexabCHF1p/ZHpvw6yB3LlX2112i9lhyXYd5F5hMS1HKoAYJJWx0IXTCh9jLw
         nJjQ==
X-Gm-Message-State: AOAM532Kt3akauWfhF7/995MXxJW2dI8KT/RgWNkID1Peu6gjMvjjVXW
        pTG9QGfJT67L9rO3ctnxrefSOnlv7+MhDtWPZ6A=
X-Google-Smtp-Source: ABdhPJwhEOohpitzCJr8DYappiwsBlb20rgQUSGwRS2IYFhoDDVGBSifpAHat+E2bUj0xoyP6n3neab+dqf7xFXO8lM=
X-Received: by 2002:aca:6202:: with SMTP id w2mr765685oib.5.1610489754915;
 Tue, 12 Jan 2021 14:15:54 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-18-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-18-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:15:41 -0500
Message-ID: <CADnq5_NqMy0i9S3HzNe3wMCBCcFwwxrx_tUBTJJUbdQ65oFX4Q@mail.gmail.com>
Subject: Re: [PATCH 17/40] drm/amd/display/dc/dce/dce_aux: Remove duplicate
 line causing 'field overwritten' issue
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

On Mon, Jan 11, 2021 at 2:20 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dc=
e112_resource.c:59:
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10=
014:58: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in =
expansion of macro =E2=80=98AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIF=
T=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:127:2: note: in e=
xpansion of macro =E2=80=98AUX_SF=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:177:2:=
 note: in expansion of macro =E2=80=98DCE_AUX_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10=
014:58: note: (near initialization for =E2=80=98aux_shift.AUX_SW_AUTOINCREM=
ENT_DISABLE=E2=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in =
expansion of macro =E2=80=98AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIF=
T=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:127:2: note: in e=
xpansion of macro =E2=80=98AUX_SF=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:177:2:=
 note: in expansion of macro =E2=80=98DCE_AUX_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10=
013:56: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in =
expansion of macro =E2=80=98AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK=
=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:127:2: note: in e=
xpansion of macro =E2=80=98AUX_SF=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:181:2:=
 note: in expansion of macro =E2=80=98DCE_AUX_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10=
013:56: note: (near initialization for =E2=80=98aux_mask.AUX_SW_AUTOINCREME=
NT_DISABLE=E2=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in =
expansion of macro =E2=80=98AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK=
=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:127:2: note: in e=
xpansion of macro =E2=80=98AUX_SF=E2=80=99
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
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h b/drivers/gpu/d=
rm/amd/display/dc/dce/dce_aux.h
> index 382465862f297..277484cf853e4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
> @@ -124,7 +124,6 @@ struct dce110_aux_registers {
>         AUX_SF(AUX_SW_CONTROL, AUX_SW_GO, mask_sh),\
>         AUX_SF(AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),\
>         AUX_SF(AUX_SW_DATA, AUX_SW_DATA_RW, mask_sh),\
> -       AUX_SF(AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),\
>         AUX_SF(AUX_SW_DATA, AUX_SW_INDEX, mask_sh),\
>         AUX_SF(AUX_SW_DATA, AUX_SW_DATA, mask_sh),\
>         AUX_SF(AUX_SW_STATUS, AUX_SW_REPLY_BYTE_COUNT, mask_sh),\
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
