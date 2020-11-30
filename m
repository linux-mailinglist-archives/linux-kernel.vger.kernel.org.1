Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDAA2C92E0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbgK3Xkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387524AbgK3Xkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:40:31 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E23C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:39:45 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id x16so400232oic.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OQ93NfmO2oAKiaWQTf4zD3Kd42GoiSc+oExd2EhoTMc=;
        b=RuFsyM6m9bXqlp0wxWurus4P9oqRnh/5iKzqPATv4Sh/KZdp6u071LCoDrTcBodJVx
         wWhPMM21Nih97GSyCLwXdvJY8Qq+hOOo4evNipKRL+IgOJRQ1iuvzOLPgmfLVFLHe6IO
         iWngg7M/P7nM7zWVEg9TmYoce/53BU/JUvifby+mKCXH/m57b8CPStuQDPGwkLS2sToT
         huderKH9oKoM4PEykeUl1HS9hOb2b6IArwtkKdFUdLy68ItK8X0qVlL9WluVvhZ1jPIJ
         fDxP+bKPwqdCS4qWVN/V7eRY6ty3o15r3df9YVaL+IMb+uoH89dHy1EoTJwKjY4fSvqR
         AY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OQ93NfmO2oAKiaWQTf4zD3Kd42GoiSc+oExd2EhoTMc=;
        b=dWquc/PQEkxT+PZuIRfwiNtBhVmf13Ydb+mrYbZkI5L3VoB1YIUegb7LZRDzf7Gci5
         ctjuDn+JPKzN5gvpY9Z3Bh5W+dlrb5Jf4/qgyhm0pJ+zRsqAi9zvminKbV1lSptfZV3k
         4Dtv5FGmuO8dcueL+Ld9gcaQcZjl0BIyyHFuu26MYHrRC3PdskgUL5AQKikCxreaq8BR
         XZiyDY2eJbxe66cIyqLVFRIthR4NB9oKyRbQplGNadyf2T68MCAOl25zroILxzk7cpmU
         wT15VkXt8NIYODtIHOFX8aRd2vliiGDUPa2HfROwfWDx197CDXAEbLdGSKWs8Cd+Zrqi
         z0PQ==
X-Gm-Message-State: AOAM533SUVvNkClg6tfn2BkFyMLXMNFHm+CA5dB/qpH3Sb+zJjrWBjCZ
        I7cHZLdv5fUvB6eVTPLJ0BcdOSGAc3D3nGWRrrvy1Uz4
X-Google-Smtp-Source: ABdhPJy8DGagBL+DFtJoRENKzyBSaSYCuAjM6TZowhpV0yo5q73MQS1h/tLVmbG5bcpJ4bQbRPSOTpVdnRaM8+PtiOg=
X-Received: by 2002:a54:4608:: with SMTP id p8mr178307oip.5.1606779584930;
 Mon, 30 Nov 2020 15:39:44 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-17-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-17-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:39:33 -0500
Message-ID: <CADnq5_PUi_bQ_Rc0ToBQ7d1JqtLwHb7OU9Eq7+=r9oYARm7k+w@mail.gmail.com>
Subject: Re: [PATCH 16/40] drm/amd/pm/powerplay/smumgr/iceland_smumgr: Remove
 unused variable 'res'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Huang Rui <ray.huang@amd.com>,
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/iceland_smumgr.c: In f=
unction =E2=80=98iceland_thermal_setup_fan_table=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/iceland_smumgr.c:2093:=
6: warning: variable =E2=80=98res=E2=80=99 set but not used [-Wunused-but-s=
et-variable]
>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c b/d=
rivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
> index 6a0f581de999b..2da5225eafbb8 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
> @@ -2090,7 +2090,6 @@ static int iceland_thermal_setup_fan_table(struct p=
p_hwmgr *hwmgr)
>         uint32_t t_diff1, t_diff2, pwm_diff1, pwm_diff2;
>         uint16_t fdo_min, slope1, slope2;
>         uint32_t reference_clock;
> -       int res;
>         uint64_t tmp64;
>
>         if (!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM=
_PlatformCaps_MicrocodeFanControl))
> @@ -2154,7 +2153,7 @@ static int iceland_thermal_setup_fan_table(struct p=
p_hwmgr *hwmgr)
>
>         /* fan_table.FanControl_GL_Flag =3D 1; */
>
> -       res =3D smu7_copy_bytes_to_smc(hwmgr, smu7_data->fan_table_start,=
 (uint8_t *)&fan_table, (uint32_t)sizeof(fan_table), SMC_RAM_END);
> +       smu7_copy_bytes_to_smc(hwmgr, smu7_data->fan_table_start, (uint8_=
t *)&fan_table, (uint32_t)sizeof(fan_table), SMC_RAM_END);
>

Should probably just return the error.  I'll fix it up.  Thanks!

Alex

>         return 0;
>  }
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
