Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438342EFA6B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbhAHV0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbhAHV0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:26:34 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0F4C061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:25:54 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id d20so11109281otl.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3U/EHOfY39AcbryurHHctLCFf/TUx0axlocAKoUFaDI=;
        b=LCIs9PMXFfP78WpjYndzNMd8DpHcKjZQQp7JySp+4RY/5Hw0lfJeyAEsYrZr64ht7B
         J1nyPIZjHf8aGQxSiiIP6tz2PH8D/dYZSYbRSR1+PHVM+/kaUEbiYVrcRoHfxPqe77co
         3IxZYupa+zE0azrsoomWE0e/jB1q5uN2yFtTmPtzbPnMn4U5HdiJqpiMomiN1dXP7PM6
         qqtE/MN3qZai3zZydN9OlkuIhadi0LeXWyJ4bb0Oyv96hl6timf8UY8s9aWVkuSq0x7d
         0vXdEt/y3C0A1f6J9xUU61s7UUoT8lardtzwtDzk90XhdVPpcLD7WOCVkQ3HFm+hDDO3
         zdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3U/EHOfY39AcbryurHHctLCFf/TUx0axlocAKoUFaDI=;
        b=peHvl5uwLgxSZuZl6ZwjYwAD4jPO8FtejaDiEu+qG1jvp21G/j5Am//dO3IB0/oXJU
         tFmFGZD+tvYALZrqPw2Fx7HF729bu+aGyv1DTNSi3W9/zOQQaqZdRGphGcEcfhIPuKa9
         PnC9wDyk1tyMVNa0lPHFlvqGDIx6b6GoyzjUr8HgmrAH8ZpNqsJdG2hCPa3T+QJXRge1
         Z/TUiW33DpcrkmedX/5tN+gZewM00qnm0nDm7FsBP8SvfqnnmWVY2hmeAQ+Ug002x85X
         V3indqVddDXhh2u45E3p9w2OcE3FPFOLjl0l5RI3IswTRlG4sEApZimTcRlCo5QjU+I+
         qNRA==
X-Gm-Message-State: AOAM532XTouISsrTl3qyEHkjYmap+OXIu56JDEiP48My4lP0tgVmtSEJ
        Jj3zt9eVgeGLYSVqm7M3N7lW8s5KnAYfFz8YIFY=
X-Google-Smtp-Source: ABdhPJzY43R3m7sa4CM/3MJzsT5LjVm/tO/tr1JBRDf2CaqbzL47ScVnjFGSeZYBaWMzq0x1DgaR3b8Fqmc9RSyXMtw=
X-Received: by 2002:a05:6830:1d66:: with SMTP id l6mr3906537oti.23.1610141153981;
 Fri, 08 Jan 2021 13:25:53 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-39-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-39-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:25:42 -0500
Message-ID: <CADnq5_OMbx2RnpYXhprGUXNQAxwKjB3eEiWgFjwDW3+hurQVsQ@mail.gmail.com>
Subject: Re: [PATCH 38/40] drm/amd/display/dc/dce/dce_panel_cntl: Remove
 unused variables 'bl_pwm_cntl' and 'pwm_period_cntl'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
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

On Fri, Jan 8, 2021 at 3:16 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_panel_cntl.c: In functi=
on =E2=80=98dce_get_16_bit_backlight_from_pwm=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_panel_cntl.c:54:11: war=
ning: variable =E2=80=98bl_pwm_cntl=E2=80=99 set but not used [-Wunused-but=
-set-variable]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_panel_cntl.c:53:11: war=
ning: variable =E2=80=98pwm_period_cntl=E2=80=99 set but not used [-Wunused=
-but-set-variable]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Anthony Koo <Anthony.Koo@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c b/driver=
s/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
> index 761fdfc1f5bd0..e923392358631 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
> @@ -50,16 +50,16 @@ static unsigned int dce_get_16_bit_backlight_from_pwm=
(struct panel_cntl *panel_c
>  {
>         uint64_t current_backlight;
>         uint32_t round_result;
> -       uint32_t pwm_period_cntl, bl_period, bl_int_count;
> -       uint32_t bl_pwm_cntl, bl_pwm, fractional_duty_cycle_en;
> +       uint32_t bl_period, bl_int_count;
> +       uint32_t bl_pwm, fractional_duty_cycle_en;
>         uint32_t bl_period_mask, bl_pwm_mask;
>         struct dce_panel_cntl *dce_panel_cntl =3D TO_DCE_PANEL_CNTL(panel=
_cntl);
>
> -       pwm_period_cntl =3D REG_READ(BL_PWM_PERIOD_CNTL);
> +       REG_READ(BL_PWM_PERIOD_CNTL);
>         REG_GET(BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD, &bl_period);
>         REG_GET(BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD_BITCNT, &bl_int_count);
>
> -       bl_pwm_cntl =3D REG_READ(BL_PWM_CNTL);
> +       REG_READ(BL_PWM_CNTL);
>         REG_GET(BL_PWM_CNTL, BL_ACTIVE_INT_FRAC_CNT, (uint32_t *)(&bl_pwm=
));
>         REG_GET(BL_PWM_CNTL, BL_PWM_FRACTIONAL_EN, &fractional_duty_cycle=
_en);
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
