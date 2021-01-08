Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F072EFA5C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbhAHVXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbhAHVXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:23:33 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4B8C061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:22:53 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id q205so12870305oig.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jtF04qvq/VTbhIf0eAtTSUNgk9E967muFMcFI2z2Cw0=;
        b=tljPaZFs2W2BXoVm3Xs7iAmWJxMVOvITPidmLE68nl/DJTH/iUMLhy6FY1FnfpP6TY
         DYI8oE9bXAA8BP+qU8Rg9GQrl6vpaK+ZjghdVDpz8i/z/zfe5mluyX/XJ6x86Nic6Dcw
         ZFRed+I0t7J0exHQjxqSCRnEYQC9WU2kDe0RrnSorfAXaBgsfnArxtACVstfrwNtVcdI
         j1Xy0okQMj8OQATomAAwiBR0Q2ASsa0GNQD2YAFsMyKE+L67xpV5TYxWJVowk1ZRi8Dk
         qCHduc9oHDfcqFxicsjqEqoe8iXrgrV28ISGQ7Y2X0EZ6oTwALwT1Y/0lNbY/W2r5Ogg
         bPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jtF04qvq/VTbhIf0eAtTSUNgk9E967muFMcFI2z2Cw0=;
        b=A4Fc6JUhQYZOQ4OANf9bkTl5/Z+aNjeQBbfwNaXK9s4LRPzC5Q67JtLQGzYCXF3D9x
         28NCBTgpZmp8ahmNf317A5Up0pY7A4Mldecy5SYm8vUosz5Dikqdr/m2W9FiEKqajJ2p
         AtOzXdLjGon2yWeyy4fuq3xDAxXkc+MEzIIndTYA/4qgVKi7adz6l0PELbVfDbOQqsFU
         oGqNlpeFnXpL5C/NCRDmJU8ulsQmsC8vYacbkgv8T/fmeQEqBwYhE1tUPx4BlVPkkh64
         ZQwueCHLC2Cc+d8n+LncL8vp8gIS9oY/e5b/ug7MzOU2OwFRQv9mdx4WHkWGCodtkRVz
         alYQ==
X-Gm-Message-State: AOAM530jcpufpmNiW/vc0/9q3X9bJ2X8nWQxOUMehPqR69QI8Pomo/R8
        McBdjPZJrox6jq3esNM9jZxkNocWoGz9Ug10dZRhue+B
X-Google-Smtp-Source: ABdhPJxxkc06PglmJmBDo80ggNi/XLoKHTp3G235Rou/iW9z9tfX3OBsARCyjKgT7gbYkPskt7IdEks+wbLApfnH9XE=
X-Received: by 2002:a54:4083:: with SMTP id i3mr3500886oii.120.1610140973145;
 Fri, 08 Jan 2021 13:22:53 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-36-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-36-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:22:42 -0500
Message-ID: <CADnq5_MmsvvxTMTWZn0EPeFn54=JBq3q1UbbPC91VGfbXQTFGQ@mail.gmail.com>
Subject: Re: [PATCH 35/40] drm/amd/display/dc/bios/command_table: Remove
 unused variable and associated comment
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

On Fri, Jan 8, 2021 at 3:16 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.c: In functi=
on =E2=80=98adjust_display_pll_v2=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.c:1462:11: w=
arning: unused variable =E2=80=98pixel_clock_10KHz_in=E2=80=99 [-Wunused-va=
riable]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

See my comment on the other patch for this function.

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/bios/command_table.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/driver=
s/gpu/drm/amd/display/dc/bios/command_table.c
> index dd893a1176979..66fe1d1810789 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> @@ -1457,10 +1457,6 @@ static enum bp_result adjust_display_pll_v2(
>  {
>         enum bp_result result =3D BP_RESULT_FAILURE;
>
> -       /* We need to convert from KHz units into 10KHz units and then co=
nvert
> -        * output pixel clock back 10KHz-->KHz */
> -       uint32_t pixel_clock_10KHz_in =3D bp_params->pixel_clock / 10;
> -
>         bp->cmd_helper->encoder_id_to_atom(
>                 dal_graphics_object_id_get_encoder_id(bp_params->encoder_=
object_id));
>         bp->cmd_helper->encoder_mode_bp_to_atom(bp_params->signal_type, f=
alse);
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
