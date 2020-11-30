Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7452F2C9349
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389071AbgK3Xw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389020AbgK3Xw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:52:26 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCB1C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:51:46 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id c80so16250336oib.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dqtZVKDF+iOHb6i9HnsWKEOoMGpzp8HRWPSLoRBVdcI=;
        b=MhcYx68pv85thC3M2kbt6MwMV2rnoK8Jym2ftuEvJnOcSk+CdTsi3LDJUQpvn3eUDZ
         vRXkTuOoUk/s8nIODWCZ/11lZF/zyl1qxHrA3rU9AkQBgsdSTWFkjV/pNG+NTCUyuuYm
         YCT4W+S4o91XwIptI0ezXBboSFTQWwaxlwy8RUfSegR3Hcu2v4Iu60aYejdJak8NpVcP
         85UMA8ZYw6Ercnn5M7kVMnnOr6Qm1bFlbvK2odoFZcRn3vXD/za9Gnybajb+RmDHAzOp
         wreHXc5cL8BnrENuHw8dPMRWAoE5U1qoxvhDrjjTsdxSLoDw6WTYof5f30t2IFGoax9n
         atWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dqtZVKDF+iOHb6i9HnsWKEOoMGpzp8HRWPSLoRBVdcI=;
        b=iMkQcQ94xigfZPGncUfoJvbAb0LE4E1xdxAt1ic6rHmSImlK2p1RCsbPkFJ6ayHj3b
         ASJHYB/hcLMdXxTmwioGwS/scpNCnd+JYZYUiDFM7YWI0ooIOLQiLOeuXYMWice8HK7d
         KX6rEAQsYjWtM7fTePnFsjPyfP5zzZNjBc3/ENZ8iuRdYSNBut7UaO/+u9HPSfXArLWq
         /0o4IXR92uvKoJtmaEW1bjRaSRAldRr+cKffO8NxKiRcGIsDTMtqqvUjewHZYlCI5wRx
         UXLNNhOOluKDuXRY7Yto7Y9F5BSEW4RUEJ9wRgLw20bgXqhIr5W6dea7uCOyW7C2UsId
         7tKQ==
X-Gm-Message-State: AOAM533jU8cvjis8pRiGoJ6bHYkNkM3FsMAnaYXaJ4FcuiHYJSlJpi6k
        p+Hpu7oEid5MVHu7dm5o1XncApfMh9CaEnGgGxc=
X-Google-Smtp-Source: ABdhPJxNbLaWtxU5KsFyyPyYENrktI33lsyQ8g6VQKzB5NZEqc8up8dmIs2gDA6INhVOZD+ex3RL6AdLHEUBsE77RBY=
X-Received: by 2002:a54:4608:: with SMTP id p8mr5127oip.5.1606780306154; Mon,
 30 Nov 2020 15:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-28-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-28-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:51:34 -0500
Message-ID: <CADnq5_PgX6b24aEntKQccUzD=CkQpf2pz09rwLebeYsnB3gd-Q@mail.gmail.com>
Subject: Re: [PATCH 27/40] drm/amd/pm/powerplay/hwmgr/hwmgr: Move
 'vega20_hwmgr_init()'s prototype to shared header
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_hwmgr.c:4403:5: =
warning: no previous prototype for =E2=80=98vega20_hwmgr_init=E2=80=99 [-Wm=
issing-prototypes]
>  4403 | int vega20_hwmgr_init(struct pp_hwmgr *hwmgr)
>  | ^~~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/amd/pm/inc/hwmgr.h             | 1 +
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/=
inc/hwmgr.h
> index 499f2520b1aa3..490371bd25201 100644
> --- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
> @@ -831,5 +831,6 @@ int hwmgr_handle_task(struct pp_hwmgr *hwmgr,
>  int smu7_init_function_pointers(struct pp_hwmgr *hwmgr);
>  int smu8_init_function_pointers(struct pp_hwmgr *hwmgr);
>  int vega12_hwmgr_init(struct pp_hwmgr *hwmgr);
> +int vega20_hwmgr_init(struct pp_hwmgr *hwmgr);
>
>  #endif /* _HWMGR_H_ */
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu=
/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> index 49f8a331eb02e..6a7de8b898faf 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> @@ -47,7 +47,6 @@ extern const struct pp_smumgr_func smu10_smu_funcs;
>  extern const struct pp_smumgr_func vega20_smu_funcs;
>
>  extern int vega10_hwmgr_init(struct pp_hwmgr *hwmgr);
> -extern int vega20_hwmgr_init(struct pp_hwmgr *hwmgr);
>  extern int smu10_init_function_pointers(struct pp_hwmgr *hwmgr);
>
>  static int polaris_set_asic_special_caps(struct pp_hwmgr *hwmgr);
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
