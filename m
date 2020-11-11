Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73822AE499
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 01:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbgKKAFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 19:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731984AbgKKAFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 19:05:16 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDEBC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:05:16 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p22so212898wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4aRvj5frq2x2Ig3VTHGXWjNecxTnIxom7+px4DcCz0c=;
        b=FO2M7uTurZnh4C3vREryU20s0FpeQM2WbJtlUXhCEVef4AooWpyc8Azm/Ynt1SU023
         HcLuFI3eaj5Svi/jKo1njI77J+5aWkA9uKZsDM7Xkd/ATHbG921QkZrptNLhjN8UhL2J
         3LQtp4U1eDD3+ibbK+DVX3Zp7YQ/+dHRO1kXPUWSvcr/qlsMHcB0c952jpTsxqZhB/K0
         AOEWFGK9sakRTGNv4FzUBu5xIB7uC3zyY82UmKZmcfRvLSsjg7rliVWLPoQ0YJ3CwOLQ
         0bmsxlvfYPIP4r9FNLVkxrttl91vaeBUelEIrNcHBqKelZ8o9hjs5KIt2XYG7OJQeWqJ
         s12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4aRvj5frq2x2Ig3VTHGXWjNecxTnIxom7+px4DcCz0c=;
        b=STmfD5q1BNziodGC/2ZAF3ajkAuf1unOUPlOEpnHbgZE0j9e7bJ/s6cxpn9n8SpTrI
         ONu5wKqQBUtdY3IMHYNhUOA7kOiGrSEI7DNk/7XfBztjuaiEwjfl97SHX3JV9ktVJYzo
         z3LGXRlS7hhtI74V08TKHtcpu8hzjldlEAtS2P5fyMmz6xEyAlgGD2RRgID2GOauVwR+
         VkbzkuABMkgjcAkwzsdLEx8L3qtMWeAPRwQ/ZGxElGCeGzi0NZwbf6/qJK0OGJ529UGq
         oEshDBtd2ZSE/D1Bfc17w3cZfHxh/0VMYRBpuBitl6yB75NtMiBozE9EariL3rOusjYh
         jLYA==
X-Gm-Message-State: AOAM530k6fXRRHjjlY3UcmyXQn8Ctn20zWT99ak8DmcRj34Mb/gXgVQ5
        Cc7KUOoJRSBow7JtEhBSv75HI/GRYwHc7YgElCw=
X-Google-Smtp-Source: ABdhPJyM77nEspqaxvn9OWN0UGEKlPqHVnIO+WXkoMEHq47+GSyGrP9fYmwOW3uqOWzKMJY3a9TwutaLObHNCt5r9YI=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr629819wmb.39.1605053114850;
 Tue, 10 Nov 2020 16:05:14 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org> <20201110193112.988999-26-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-26-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 19:05:03 -0500
Message-ID: <CADnq5_M4rN9gOZaC_FEVBd_XtpMxKNzG7X3dzCd49gRUirFH-Q@mail.gmail.com>
Subject: Re: [PATCH 25/30] drm/radeon/sumo_dpm: Move 'sumo_get_pi()'s
 prototype into shared header
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

On Tue, Nov 10, 2020 at 2:32 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/sumo_dpm.c:81:25: warning: no previous prototype =
for =E2=80=98sumo_get_pi=E2=80=99 [-Wmissing-prototypes]
>  81 | struct sumo_power_info *sumo_get_pi(struct radeon_device *rdev)
>  | ^~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/sumo_dpm.h | 1 +
>  drivers/gpu/drm/radeon/sumo_smc.c | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/sumo_dpm.h b/drivers/gpu/drm/radeon/s=
umo_dpm.h
> index f1651135a47ab..db29d37ae2703 100644
> --- a/drivers/gpu/drm/radeon/sumo_dpm.h
> +++ b/drivers/gpu/drm/radeon/sumo_dpm.h
> @@ -207,6 +207,7 @@ u32 sumo_get_sleep_divider_from_id(u32 id);
>  u32 sumo_get_sleep_divider_id_from_clock(struct radeon_device *rdev,
>                                          u32 sclk,
>                                          u32 min_sclk_in_sr);
> +struct sumo_power_info *sumo_get_pi(struct radeon_device *rdev);
>
>  /* sumo_smc.c */
>  void sumo_initialize_m3_arb(struct radeon_device *rdev);
> diff --git a/drivers/gpu/drm/radeon/sumo_smc.c b/drivers/gpu/drm/radeon/s=
umo_smc.c
> index d781407057366..78d8716067318 100644
> --- a/drivers/gpu/drm/radeon/sumo_smc.c
> +++ b/drivers/gpu/drm/radeon/sumo_smc.c
> @@ -30,8 +30,6 @@
>  #define SUMO_SMU_SERVICE_ROUTINE_ALTVDDNB_NOTIFY  27
>  #define SUMO_SMU_SERVICE_ROUTINE_GFX_SRV_ID_20  20
>
> -struct sumo_power_info *sumo_get_pi(struct radeon_device *rdev);
> -
>  static void sumo_send_msg_to_smu(struct radeon_device *rdev, u32 id)
>  {
>         u32 gfx_int_req;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
