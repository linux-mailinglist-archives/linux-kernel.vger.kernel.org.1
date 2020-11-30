Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321F32C9372
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgK3X6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgK3X6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:58:32 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E93CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:57:46 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id t142so3108157oot.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vgKRQAiib2gthU/VRaj/WeBHXJVwpbyuOw/X2vXJueI=;
        b=EBsDXBf2rrZUNngQH8wrfhBKvQwjvZtdwWGIJv3CT7KK2X4l7YGGKTTaYksY+SJCad
         tU0F75gkP1RaOYHqs99lUIrVC5ZwBE+IMKxoX8G9XoxxyPbIatH3Kvh2M8ik8Ga/Nn0i
         HFGgSi+VQ5R3Pkm+XHJJupZtg+/gtCBEV2kVRZJh/zg1MLvgCTu1KMi2YaEJ53mPDQ01
         qyI7VykMAEdx5bCu602vB0KDwedCZnnhju6pB3QONTHzFC44bsI0aRURdM44drkECL0C
         iw5X71jRT8UrvWJtd6+K0ZjvF5QPlzWbTZzQ1OwZUkTOof1RlrxmHU/tB+SMsJZQtd1G
         lZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vgKRQAiib2gthU/VRaj/WeBHXJVwpbyuOw/X2vXJueI=;
        b=ng3QOVHfSJBsAmxagdwf3nTV/TPyEmxWUXxWmpojJTdLK0/Cp3IzquxomvoSLBMH7s
         DG8MwQvtC/ZUL1nAcknj9U5cgoAxSSXs5+4KKxP6Y5dIJ1N+mnrAyxnPCMmvB+1yhow1
         /M3YOH/OhEGtSB37wU2+LkWaWxBuLt6BAWJ9fhx+hjnXsiZGs5Ic+FdBN6z6KcdrTkj5
         R7fxFadfONeL4Hcbm6TFJMb8tDjWc+PumgUo7IH/qmcwltHV1xey+l8upxQthUPL335z
         6yE5E/d127AMt8/auTDboNPSfYWadQZQfk3zATGQ4WHJGrmusd9uZT7KWDAYDpDFcaUx
         zzOw==
X-Gm-Message-State: AOAM532IAXqTGzKQvLpaOhHtVLqYKRH8vxnxX75DBz4mWxZuyMuSSrd8
        MM3LTWf+DogkXd0NRcTXneEcnAHzt/mwKufSAg8=
X-Google-Smtp-Source: ABdhPJw4rZeb/PphtWu4Cl8TtHzvOdOYjiTsuSvu34iEY+jqPxAhUdABssZ2oSFIkmZjy0IuBwel0IN3v8tMXKTbJAE=
X-Received: by 2002:a4a:d5d3:: with SMTP id a19mr48449oot.61.1606780665874;
 Mon, 30 Nov 2020 15:57:45 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-33-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-33-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:57:35 -0500
Message-ID: <CADnq5_PtZRwNNV-EvMjkV9k2sYj9jdYBT3oqtS3-hm-pTsaaew@mail.gmail.com>
Subject: Re: [PATCH 32/40] drm/amd/display/amdgpu_dm/amdgpu_dm: Mark
 'link_bandwidth_kbps' as __maybe_unused
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

On Thu, Nov 26, 2020 at 8:43 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> 'link_bandwidth_kbps' is always obtained, but only used if
> CONFIG_DRM_AMD_DC_DCN is defined.

Probably better to just move this under CONFIG_DRM_AMD_DC_DCN.  I'll
send a patch.

Thanks,

Alex


>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function=
 =E2=80=98create_stream_for_sink=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5080:11: war=
ning: variable =E2=80=98link_bandwidth_kbps=E2=80=99 set but not used [-Wun=
used-but-set-variable]
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
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 08539f4315864..ac7643d73bc68 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5077,7 +5077,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *=
aconnector,
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>         struct dsc_dec_dpcd_caps dsc_caps;
>  #endif
> -       uint32_t link_bandwidth_kbps;
> +       uint32_t __maybe_unused link_bandwidth_kbps;
>
>         struct dc_sink *sink =3D NULL;
>         if (aconnector =3D=3D NULL) {
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
