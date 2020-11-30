Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30532C9359
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgK3XxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgK3XxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:53:18 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62D4C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:52:32 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id t18so4676158otk.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/E3CsLk3n2X4/o/h00UqiQ4R0nAVrxg+YFVRXYha1do=;
        b=a2kQ6YQ+qwmy0Ls1xBAe0hNSftutzIkTHBVO4NcjyPfO1kHD/f1RwnxGyTemQ0N8Y7
         hoSSwOPugh449L9vG5d6i/gnLxIj1nYlhL2I8GFn/4FlSzrEspS9yyHtu8Th6gmZu4v/
         3zn6/flt/yE3ZQXwPivuf5kpW4yWdzVFIeNq1Y+ukm53KQkQhwDW+jnip61/1kxqyDo+
         uFnfLbiKZ+O9qHyYrPeA5e2+82D68tpOH1ooJNUN21g92LxVe7AilCkZ/IYLvMtCWo5f
         JQXsjmgSVXNX9gOu68gkp+UViUbCYNxQ4RB1AJULoGmZlH3KX3bvarEehRq+CBomQ8Q8
         sU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/E3CsLk3n2X4/o/h00UqiQ4R0nAVrxg+YFVRXYha1do=;
        b=Cxt9KFz4nviu8ApHRIBfAVsDas1sflHW5Ql3dIWnYT0OyBFd74/8gK4XPRWb7o+cCi
         6HXm1DHOkYeWp1kOl2DV8s/dSLrLhc/pWslZxPexb0hkznxyHUicujEgz0jLQ/L8gHpH
         B1ZthcfpN3fOQpGPQO24PScrrAtq5wESvuVLAIeJo4BTrp/mh5W4Wib+HJXHUV5du28v
         b0TtnkaZ+axk0vDwpdg3Rh7ark+3vsBUe479jiHtF/BErlICA6SSksWIUvbp/l9zv17o
         yWKHsmlKfD/Q4ueZsJxYr0vUsmKxuC5KVb/dRYNwg9HIyptWLua7iR9DIRB4jyN219g+
         aCdQ==
X-Gm-Message-State: AOAM531otcfpOiwI9dJyNHFIBicuc9MOWfv9iHUNYXjBW5ofdJyiHiy6
        AUeU//hYzwMCqV6FaADpUo8TE25gpq2NOts3+mg=
X-Google-Smtp-Source: ABdhPJzlB2LN4ZKpJ+zOqCDoj1z5pw3qiPOkr7hybeT2yqGjUq0PlG0wdnev+MFvbRO52K2QcZ4KPPTjV1riW26i2Cw=
X-Received: by 2002:a05:6830:22e4:: with SMTP id t4mr19276171otc.23.1606780352124;
 Mon, 30 Nov 2020 15:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-29-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-29-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:52:20 -0500
Message-ID: <CADnq5_O8E5mfdbpeqXDovWCCFfjMchVfwt60uStL34LT=zdV6g@mail.gmail.com>
Subject: Re: [PATCH 28/40] drm/amd/pm/powerplay/hwmgr/smu_helper: Demote or
 fix kernel-doc headers
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 8:43 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:112: warni=
ng: Function parameter or member 'hwmgr' not described in 'phm_wait_on_regi=
ster'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:112: warni=
ng: Function parameter or member 'index' not described in 'phm_wait_on_regi=
ster'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:112: warni=
ng: Function parameter or member 'value' not described in 'phm_wait_on_regi=
ster'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:112: warni=
ng: Function parameter or member 'mask' not described in 'phm_wait_on_regis=
ter'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:145: warni=
ng: Function parameter or member 'hwmgr' not described in 'phm_wait_on_indi=
rect_register'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:145: warni=
ng: Function parameter or member 'indirect_port' not described in 'phm_wait=
_on_indirect_register'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:145: warni=
ng: Function parameter or member 'index' not described in 'phm_wait_on_indi=
rect_register'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:145: warni=
ng: Function parameter or member 'value' not described in 'phm_wait_on_indi=
rect_register'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:145: warni=
ng: Function parameter or member 'mask' not described in 'phm_wait_on_indir=
ect_register'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu_helper.c:494: warni=
ng: Function parameter or member 'hwmgr' not described in 'phm_initializa_d=
ynamic_state_adjustment_rule_settings'
>
> Cc: Evan Quan <evan.quan@amd.com>
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
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
> index 2a0ca5194bbe9..bfe80ac0ad8c8 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
> @@ -103,7 +103,7 @@ uint32_t phm_set_field_to_u32(u32 offset, u32 origina=
l_data, u32 field, u32 size
>         return original_data;
>  }
>
> -/**
> +/*
>   * Returns once the part of the register indicated by the mask has
>   * reached the given value.
>   */
> @@ -132,7 +132,7 @@ int phm_wait_on_register(struct pp_hwmgr *hwmgr, uint=
32_t index,
>  }
>
>
> -/**
> +/*
>   * Returns once the part of the register indicated by the mask has
>   * reached the given value.The indirect space is described by giving
>   * the memory-mapped index of the indirect index register.
> @@ -486,9 +486,9 @@ int phm_get_sclk_for_voltage_evv(struct pp_hwmgr *hwm=
gr,
>  }
>
>  /**
> - * Initialize Dynamic State Adjustment Rule Settings
> + * phm_initializa_dynamic_state_adjustment_rule_settings - Initialize Dy=
namic State Adjustment Rule Settings
>   *
> - * @param    hwmgr  the address of the powerplay hardware manager.
> + * @hwmgr:  the address of the powerplay hardware manager.
>   */
>  int phm_initializa_dynamic_state_adjustment_rule_settings(struct pp_hwmg=
r *hwmgr)
>  {
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
