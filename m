Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F4C2AE431
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbgKJXj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgKJXj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:39:29 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AB0C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:39:28 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c16so132213wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Oa+daeAHvU7lx4HkTlbwWSIAvlJdskhvUZxjOQcUKOc=;
        b=hm1sEfqdhE16MOfMABfPzeqG08HhBj+NySg9eIIoL9Y+sR/Aga2X5eNZmScIkbWHIc
         EDirkv28y3IqIsEgbUuEoSxIVkRHqIMLvIIvMbCmlfHRi3mTQaN+ftbO4V++3ai9zita
         Xe8qau8NnV4dtoR4VCbZ5L0qUHgcOgm7chWkseoCW/OX/9TfWUs2zvL76CRs1fk3eyCS
         RvCOZw9uDmcJOONRchZHvM61cY0PXBxo9NwOn53itB3dWESXzvA3IKj9E0N8i+D710+Q
         l8OKcH9Q4W/EspcokrkGNgCx/j3C9vnxs54vI0ansEw85DOEd6qEnpqIaC+iWF8Uq7Lf
         tNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Oa+daeAHvU7lx4HkTlbwWSIAvlJdskhvUZxjOQcUKOc=;
        b=oX/a5Q8p1PYmo2RHoBo0Rz3L1AGZIBrPidHljGtc92v46Cbjz3CdHkzYwQsYt/YOuN
         9fuJtFOfkGIMDJsezw/nN6jleUkqTqfwVQ3i+oewMWQMxp2GiEbAs1W+ZZLAQgjk+uie
         IXG8juTnASyhZAtZEg0MdSOPc0ueULGa0GOv85VRTMXeWrWSrrJmAHSwkf5YCiobkSDe
         xid0U5g67tuFeJTTD7A9mfRWlziAj7M86r95kwKTaMQyo+GPZN//zluc0kT87tFAG+0J
         oNk2dzqksd7sFJyHerT6rdMPmxCI0kk3u9vPyxW29G/3J+zu0lauU6NyKw0Ed2tEYq6d
         nXEA==
X-Gm-Message-State: AOAM530yJ5FsGsqYF4AOibL4fR6zxQL7nTNzPk8AqAFV+BS1u5hQ2WNh
        iFkx2VELj9psS0LN9b7sKSqIJnBXZzZw8pnwT7M=
X-Google-Smtp-Source: ABdhPJwzEw/Wodrp6vyXGUSvvtFFmUb/vCnQbEIr+yuMmEMcA383NLbMqjtrMf4QsfVrr1215aWyaM1imHBur/TbzJ8=
X-Received: by 2002:a1c:80cb:: with SMTP id b194mr544247wmd.73.1605051567472;
 Tue, 10 Nov 2020 15:39:27 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org> <20201110193112.988999-13-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-13-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 18:39:16 -0500
Message-ID: <CADnq5_N=SoFU=pAB-Wye8x1LkLm4ZYcKvag7Sh9NvK2LRc5eKA@mail.gmail.com>
Subject: Re: [PATCH 12/30] drm/radeon/radeon_dp_mst: Remove unused variable
 'ret' from radeon_mst_encoder_dpms()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 2:31 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_dp_mst.c: In function =E2=80=98radeon_mst_=
encoder_dpms=E2=80=99:
>  drivers/gpu/drm/radeon/radeon_dp_mst.c:366:6: warning: variable =E2=80=
=98ret=E2=80=99 set but not used [-Wunused-but-set-variable]
>
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
>  drivers/gpu/drm/radeon/radeon_dp_mst.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_dp_mst.c b/drivers/gpu/drm/rad=
eon/radeon_dp_mst.c
> index 008308780443c..2c32186c4acd9 100644
> --- a/drivers/gpu/drm/radeon/radeon_dp_mst.c
> +++ b/drivers/gpu/drm/radeon/radeon_dp_mst.c
> @@ -363,7 +363,7 @@ radeon_mst_encoder_dpms(struct drm_encoder *encoder, =
int mode)
>         struct radeon_connector *radeon_connector;
>         struct drm_crtc *crtc;
>         struct radeon_crtc *radeon_crtc;
> -       int ret, slots;
> +       int slots;
>         s64 fixed_pbn, fixed_pbn_per_slot, avg_time_slots_per_mtp;
>         if (!ASIC_IS_DCE5(rdev)) {
>                 DRM_ERROR("got mst dpms on non-DCE5\n");
> @@ -418,10 +418,10 @@ radeon_mst_encoder_dpms(struct drm_encoder *encoder=
, int mode)
>
>                 slots =3D drm_dp_find_vcpi_slots(&radeon_connector->mst_p=
ort->mst_mgr,
>                                                mst_enc->pbn);
> -               ret =3D drm_dp_mst_allocate_vcpi(&radeon_connector->mst_p=
ort->mst_mgr,
> -                                              radeon_connector->port,
> -                                              mst_enc->pbn, slots);
> -               ret =3D drm_dp_update_payload_part1(&radeon_connector->ms=
t_port->mst_mgr);
> +               drm_dp_mst_allocate_vcpi(&radeon_connector->mst_port->mst=
_mgr,
> +                                        radeon_connector->port,
> +                                        mst_enc->pbn, slots);
> +               drm_dp_update_payload_part1(&radeon_connector->mst_port->=
mst_mgr);
>
>                 radeon_dp_mst_set_be_cntl(primary, mst_enc,
>                                           radeon_connector->mst_port->hpd=
.hpd, true);
> @@ -436,9 +436,9 @@ radeon_mst_encoder_dpms(struct drm_encoder *encoder, =
int mode)
>
>                 atombios_dig_encoder_setup2(&primary->base, ATOM_ENCODER_=
CMD_DP_VIDEO_ON, 0,
>                                             mst_enc->fe);
> -               ret =3D drm_dp_check_act_status(&radeon_connector->mst_po=
rt->mst_mgr);
> +               drm_dp_check_act_status(&radeon_connector->mst_port->mst_=
mgr);
>
> -               ret =3D drm_dp_update_payload_part2(&radeon_connector->ms=
t_port->mst_mgr);
> +               drm_dp_update_payload_part2(&radeon_connector->mst_port->=
mst_mgr);
>
>                 break;
>         case DRM_MODE_DPMS_STANDBY:
> @@ -450,7 +450,7 @@ radeon_mst_encoder_dpms(struct drm_encoder *encoder, =
int mode)
>                         return;
>
>                 drm_dp_mst_reset_vcpi_slots(&radeon_connector->mst_port->=
mst_mgr, mst_enc->port);
> -               ret =3D drm_dp_update_payload_part1(&radeon_connector->ms=
t_port->mst_mgr);
> +               drm_dp_update_payload_part1(&radeon_connector->mst_port->=
mst_mgr);
>
>                 drm_dp_check_act_status(&radeon_connector->mst_port->mst_=
mgr);
>                 /* and this can also fail */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
