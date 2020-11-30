Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986532C91F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388929AbgK3XEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgK3XEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:04:01 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAF3C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:03:15 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id o25so16115105oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pbLBATuyJ3oCMMqucu/E4nnHTUnE5GYSa2HahZ+nUMY=;
        b=N1sX3O1jLFNPsM+czYCS21z3e62Kchen6incjTpRzoK62lv9/g/JPxExhzCsNf5LPf
         iVYQJDPSBiK1NE9VOMvjCjlqkC6IsUgZfRI6EK5SmGqHNSCnFc9zyHXuMQsu7Z+JPgmQ
         hnl/GNMRWS4/EhS5URciA1m18YHqWVXI2RHbreKQEYUhbBP2NNsC0zguYEQxGXd4D8zy
         JZGZxXSBYqKdieUKASmeVksBrU0U5/c3+EfMGFUwV3MhqjIucjeTvuAo+XUmLJgKvZrC
         2F73/Ukl89DcV0JJiirW5qvlTyST1wotbPgXDRS8gPslhaYHdSGd1Sa4EdA/wtySQdMK
         jrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pbLBATuyJ3oCMMqucu/E4nnHTUnE5GYSa2HahZ+nUMY=;
        b=RFOSnxx8WWZdNM6icziftJUX3GMbOC3E+Xd5WAew1mQqJz5zYt8WgSBDsu2A8uCdqS
         QKFSHSXdTQ7AfSuzPfXMCyo6tnHwpQoVALIp+Y43qCx7+RY46HO3MoQPimWI1cbFLACR
         M2gIApaso7d5uK15DMuRzDtFbwprX6EomTWY/ct7iOkf5BxWtjIVAycr0OYiZW/KWMLy
         8n3uR2+rKDNM/XYp2bVXDslQXkAVz8xj2uZ6scoL1XU2q3+THMGGOVuIXRqyXdo3e/cD
         99eA8+lenMJcw2c/3M7v6ng4G51NUQt59RtLlq/eozBXs2lZGxLtdaFPeTFgju/iprwP
         1KMw==
X-Gm-Message-State: AOAM533Re1RGs2AG8iM+xaZ4aj2OiEbKkd5gxnvuwiyYbJ+KZbn29EaO
        tqNhTL5iqXdMH++wFwQQuvZysTTnzzDgN/e23ek=
X-Google-Smtp-Source: ABdhPJyryqlUQ3q+jCwYtIZCuMTd9ebkXmhYBFh7xQINE5nHfAmLqnQlscgBCJBx8EV/1R0m5PLqL3eEmwr+BmNpifk=
X-Received: by 2002:a54:4608:: with SMTP id p8mr60646oip.5.1606777394955; Mon,
 30 Nov 2020 15:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-40-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-40-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:03:03 -0500
Message-ID: <CADnq5_Pf-LD7gpzrp+TqpnhFYETjouSWKCp7ZnbnAN80NVKA1A@mail.gmail.com>
Subject: Re: [PATCH 39/40] drm/amd/pm/powerplay/smumgr/fiji_smumgr: Remove
 unused variable 'result'
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

On Tue, Nov 24, 2020 at 2:45 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/fiji_smumgr.c: In func=
tion =E2=80=98fiji_populate_smc_boot_level=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/fiji_smumgr.c:1603:6: =
warning: variable =E2=80=98result=E2=80=99 set but not used [-Wunused-but-s=
et-variable]
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
>  .../gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c   | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> index fef9d3906fccd..fea008cc1f254 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> @@ -1600,20 +1600,19 @@ static int fiji_populate_smc_uvd_level(struct pp_=
hwmgr *hwmgr,
>  static int fiji_populate_smc_boot_level(struct pp_hwmgr *hwmgr,
>                 struct SMU73_Discrete_DpmTable *table)
>  {
> -       int result =3D 0;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
>
>         table->GraphicsBootLevel =3D 0;
>         table->MemoryBootLevel =3D 0;
>
>         /* find boot level from dpm table */
> -       result =3D phm_find_boot_level(&(data->dpm_table.sclk_table),
> -                       data->vbios_boot_state.sclk_bootup_value,
> -                       (uint32_t *)&(table->GraphicsBootLevel));
> +       phm_find_boot_level(&(data->dpm_table.sclk_table),
> +                           data->vbios_boot_state.sclk_bootup_value,
> +                           (uint32_t *)&(table->GraphicsBootLevel));
>
> -       result =3D phm_find_boot_level(&(data->dpm_table.mclk_table),
> -                       data->vbios_boot_state.mclk_bootup_value,
> -                       (uint32_t *)&(table->MemoryBootLevel));
> +       phm_find_boot_level(&(data->dpm_table.mclk_table),
> +                           data->vbios_boot_state.mclk_bootup_value,
> +                           (uint32_t *)&(table->MemoryBootLevel));
>
>         table->BootVddc  =3D data->vbios_boot_state.vddc_bootup_value *
>                         VOLTAGE_SCALE;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
