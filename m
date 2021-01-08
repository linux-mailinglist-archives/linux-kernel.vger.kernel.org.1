Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BD22EF9C4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbhAHVAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbhAHVAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:00:31 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBC3C061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:00:15 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id x13so12856035oic.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2sttTWDiva5/i7UCS9hC+32Kuzu7D1WRMiPwU7HE0c4=;
        b=Can0g5gmZJYiVqWNEeUWWrIMTsjFG9TGCDpbqsIEWLn8xXbWQ2eFIBC5hvgZcdRvhq
         zUuUaigs4CCn4h1yv16tWfnMM2vJGcAHbx3reXhJwYPs1ZD5wsNIQFYJ3N4jIqiEEpL3
         RBGt+icyAzHQTlHCJ+JCOIYZ+z5kn3cI1t+SvltfEqGu4c9dujD11OrFnRGMrQ910XlX
         uCqRTQ3kD06I3tfA2afxZliI53BZtra/QWooLZC4c+k0OQkciQaVhQ3UJVKU45cA9oDv
         eWspbsLzzyB0mQI2NVl83RiNBt4LQMdNgU2BhBb16K2/i2QAQqi/eV30x+LDI9gHpNH+
         IMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2sttTWDiva5/i7UCS9hC+32Kuzu7D1WRMiPwU7HE0c4=;
        b=q2CJbm2D3DG+kM0awLE/CL94A8IlakgiSbHePegqmpaQUxGHtHsNJR5shTAuJEwRQF
         JzJbWmN3H1NwsM5j5d5ufW1vlkw53pV3BQc882gZCjyZyJyhmyegaou0P+/F76Sf/Jrf
         7sU5BZvFT9bfqxDZaeb8/a5iaxThf95/hV8EaGoqcmukiVdOQmjcmTPtJ1Bs3iqfiV1u
         pjJzcuflr4i78bNpdIn28oFqPsG82Cxdxfth+idSqwOXVueERFBnq6gPT3SuTDox/wz7
         C/VgB9tS0mujvzfYMut2vdYRdyVK31jDFzBB0Vq011kvOANZbwRzOM0cPuYTxprOo9Ic
         1KMQ==
X-Gm-Message-State: AOAM5302g2uUfkAOo6zqv09oE9v9N3UOryctRMJQqnAaQnST6GF7hI4c
        gmL1N7KPI4uz4IVANhxnUr/v0axvMqBkkrdwumQ=
X-Google-Smtp-Source: ABdhPJy95TMI5PbQnWyiCX1g20344zR2xlZQs88ADigDiP7zSolhLeEKefV91mcU2GurOeen5KXySWTEQTPAAEQuk/g=
X-Received: by 2002:aca:6202:: with SMTP id w2mr3337455oib.5.1610139615329;
 Fri, 08 Jan 2021 13:00:15 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-20-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-20-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:00:04 -0500
Message-ID: <CADnq5_NVvzzUKMdFwMoEN97AxgkEY=PCHtiKZACiCQHary2KUg@mail.gmail.com>
Subject: Re: [PATCH 19/40] drm/amd/display/dc/bios/command_table: Remove
 unused variable
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        David Airlie <airlied@linux.ie>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> None of the surrounding code was removed just in case even a small
> fraction of it was functional.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.c: In functi=
on =E2=80=98adjust_display_pll_v2=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.c:1459:35: w=
arning: variable =E2=80=98params=E2=80=99 set but not used [-Wunused-but-se=
t-variable]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Qinglang Miao <miaoqinglang@huawei.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/command_table.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/driver=
s/gpu/drm/amd/display/dc/bios/command_table.c
> index 070459e3e4070..dd893a1176979 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> @@ -1456,20 +1456,14 @@ static enum bp_result adjust_display_pll_v2(
>         struct bp_adjust_pixel_clock_parameters *bp_params)
>  {

@Harry Wentland, this function looks like it's missing the call to
EXEC_BIOS_CMD_TABLE().  I just sent a patch to fix that up, although
I'm not sure if this function every gets used on any asics supported
by amdgpu, so maybe we can just drop it.

Alex


>         enum bp_result result =3D BP_RESULT_FAILURE;
> -       ADJUST_DISPLAY_PLL_PS_ALLOCATION params =3D { 0 };
>
>         /* We need to convert from KHz units into 10KHz units and then co=
nvert
>          * output pixel clock back 10KHz-->KHz */
>         uint32_t pixel_clock_10KHz_in =3D bp_params->pixel_clock / 10;
>
> -       params.usPixelClock =3D cpu_to_le16((uint16_t)(pixel_clock_10KHz_=
in));
> -       params.ucTransmitterID =3D
> -                       bp->cmd_helper->encoder_id_to_atom(
> -                                       dal_graphics_object_id_get_encode=
r_id(
> -                                                       bp_params->encode=
r_object_id));
> -       params.ucEncodeMode =3D
> -                       (uint8_t)bp->cmd_helper->encoder_mode_bp_to_atom(
> -                                       bp_params->signal_type, false);
> +       bp->cmd_helper->encoder_id_to_atom(
> +               dal_graphics_object_id_get_encoder_id(bp_params->encoder_=
object_id));
> +       bp->cmd_helper->encoder_mode_bp_to_atom(bp_params->signal_type, f=
alse);
>         return result;
>  }
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
