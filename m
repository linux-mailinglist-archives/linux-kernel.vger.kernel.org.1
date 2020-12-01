Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DA72CA4D8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391534AbgLAOBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387744AbgLAOBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:01:40 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C885DC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 06:01:00 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 11so1685859oty.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 06:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KKW3EOUonoHk4bmKwuL1uydL+Yh3MzQ7U0560ouys3s=;
        b=ZP5LL+gqFwGVSjiJEWCGJpcE5N9QencikDl3FtJy626LsjuOehhztcP4aGZtTJJFm0
         KbiS+F7/oFJutQdexf7unem5E7Jw3Cfbzq91dP72FLF5Fk2lWP5jKx+hjzDDUktyna8l
         b9wsZAqq6uiMTDSf7vxuN3sxy6cLUBez117eH8kT0Q4HbhWPOCYiMHXKkq+fDv4BMN8M
         RPkpvsSVjLl7DRUu0lbIsv7O5C5jU3B+jftk4B2ky0pLG68EeUTqK3oyWPGWrirhDX9D
         dq8oXSbGaiJ9UiBgQTmTjuHXpjp1dqugBSrz/b3Io8VCFPfD+BLmy+ZoPHH7Og3YPRV6
         Lkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KKW3EOUonoHk4bmKwuL1uydL+Yh3MzQ7U0560ouys3s=;
        b=h8SSV/1u3elDc6d64z3w9CU6B8VCPG9HXnL2emA+8RxJWxUSNMRlyx2rz0Jm3WQ2Ka
         X6LouO5OPM5ZYwKA6PS/sjurny6xWeifgy4ud/DHB/MvdwVGi1JHUktMCBd2T514+/0S
         fU/ddb4OIkHkoUuCJ12re9o6UbL8kTrrTfR7wtPMdHuSCkVugfudP2rcvVlhhci8DETW
         n1j/XeE3t9jahC+P+W+X8PuHdo3MXwzRfUu3P0ZHSG6BQYcmKac55XBAd450pw2SZVhl
         f8/mZSgHOv5aAQCAuLUZdqDJPtBwZS+7K3EGQekOTN+5cVdXWQxx9dACBLV/ZsdW5uVC
         ceaA==
X-Gm-Message-State: AOAM533KQxrBxHedFjZshe+O3WWEoLw3qiubK32dS50YMqpwSH/B7EO7
        c0u2aE/9s/iqaytgO1M72rPMS+5oOyYvG6U2mT4=
X-Google-Smtp-Source: ABdhPJyM2cWPlndVwe1fEAo//Tvbj+hC/zbtvm6PxxkdYuHnDDGP1BKbyzgcygvu1QAu5sADiA+8vC46eHwb0zQbgKQ=
X-Received: by 2002:a9d:4713:: with SMTP id a19mr1911439otf.132.1606831258589;
 Tue, 01 Dec 2020 06:00:58 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-32-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-32-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 1 Dec 2020 09:00:47 -0500
Message-ID: <CADnq5_Piuz9Oua5FBeMGuMb98cwtf5+6WSqCPKi3UqkN+5Z=mw@mail.gmail.com>
Subject: Re: [PATCH 31/40] drm/amd/pm/powerplay/kv_dpm: Remove unused variable 'ret'
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/kv_dpm.c: In function =E2=80=
=98kv_dpm_powergate_uvd=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/kv_dpm.c:1678:6: warning: var=
iable =E2=80=98ret=E2=80=99 set but not used [-Wunused-but-set-variable]
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/kv_dpm.c: In function =E2=80=
=98kv_dpm_powergate_vce=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/kv_dpm.c:1706:6: warning: var=
iable =E2=80=98ret=E2=80=99 set but not used [-Wunused-but-set-variable]
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
>  drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/=
amd/pm/powerplay/kv_dpm.c
> index 4b3faaccecb94..66daabebee358 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> @@ -1675,14 +1675,13 @@ static void kv_dpm_powergate_uvd(void *handle, bo=
ol gate)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>         struct kv_power_info *pi =3D kv_get_pi(adev);
> -       int ret;
>
>         pi->uvd_power_gated =3D gate;
>
>         if (gate) {
>                 /* stop the UVD block */
> -               ret =3D amdgpu_device_ip_set_powergating_state(adev, AMD_=
IP_BLOCK_TYPE_UVD,
> -                                                            AMD_PG_STATE=
_GATE);
> +               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_UVD,
> +                                                      AMD_PG_STATE_GATE)=
;
>                 kv_update_uvd_dpm(adev, gate);
>                 if (pi->caps_uvd_pg)
>                         /* power off the UVD block */
> @@ -1694,8 +1693,8 @@ static void kv_dpm_powergate_uvd(void *handle, bool=
 gate)
>                         /* re-init the UVD block */
>                 kv_update_uvd_dpm(adev, gate);
>
> -               ret =3D amdgpu_device_ip_set_powergating_state(adev, AMD_=
IP_BLOCK_TYPE_UVD,
> -                                                            AMD_PG_STATE=
_UNGATE);
> +               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_UVD,
> +                                                      AMD_PG_STATE_UNGAT=
E);
>         }
>  }
>
> @@ -1703,14 +1702,13 @@ static void kv_dpm_powergate_vce(void *handle, bo=
ol gate)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>         struct kv_power_info *pi =3D kv_get_pi(adev);
> -       int ret;
>
>         pi->vce_power_gated =3D gate;
>
>         if (gate) {
>                 /* stop the VCE block */
> -               ret =3D amdgpu_device_ip_set_powergating_state(adev, AMD_=
IP_BLOCK_TYPE_VCE,
> -                                                            AMD_PG_STATE=
_GATE);
> +               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VCE,
> +                                                      AMD_PG_STATE_GATE)=
;
>                 kv_enable_vce_dpm(adev, false);
>                 if (pi->caps_vce_pg) /* power off the VCE block */
>                         amdgpu_kv_notify_message_to_smu(adev, PPSMC_MSG_V=
CEPowerOFF);
> @@ -1719,8 +1717,8 @@ static void kv_dpm_powergate_vce(void *handle, bool=
 gate)
>                         amdgpu_kv_notify_message_to_smu(adev, PPSMC_MSG_V=
CEPowerON);
>                 kv_enable_vce_dpm(adev, true);
>                 /* re-init the VCE block */
> -               ret =3D amdgpu_device_ip_set_powergating_state(adev, AMD_=
IP_BLOCK_TYPE_VCE,
> -                                                            AMD_PG_STATE=
_UNGATE);
> +               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VCE,
> +                                                      AMD_PG_STATE_UNGAT=
E);
>         }
>  }
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
