Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CE52EF955
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbhAHUg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbhAHUgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:36:25 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997E4C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:35:45 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 15so12780289oix.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VpvD6PG1QgANsGGyog3b6p6+OIrJWW4ly0pJuf5vMsk=;
        b=PIbDQGG2BRxwiOyEK90Lk0BubPYR57V/VUqFj8RxmDdqJke6LsBIOOq03Oi/Gr/gHH
         TeoN89C3FxdsxzFrGXozyU9917pghuw30xgk6UBavCJe0sGzqmKU7Sy4hBRNMrVpAQQu
         Yfj/vMK4a/LVFQ+MAO94MS8m5p4fn2BMp5erW9WKxUNhFVvOuDRuWXhBKMT356rNUB8e
         LFmJB7im2jdh2x/vH7iYjsXCairkQLULvBWcliHRQso8NM+usxLOk1qUsQoWl15Npewd
         JkCEHQfD24zlmsptpyOgGu9l3jz2zGYP1+xt9NsvxxUr6Bqh0oFDzO6OwNSdIG+YH9v/
         Jm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VpvD6PG1QgANsGGyog3b6p6+OIrJWW4ly0pJuf5vMsk=;
        b=VKXM1Z9LaficycX1PXMTr9NuuFwBK/mL6yi9ReBPUxDmz6XO2QCStQ5m3zVY2Xmj+q
         a/POM5qG6BrBIxlt4WDBGKzkSuSk6zIEc7LKlRrB47zI5YB6xlmNOmasvbWB6Ivt55rV
         34RcMTCJixPm33kQlSPTXPdXy8Tz2f8pB3T9cSvfhIJCkVMAnYoVNk/aISE/fwIOHQmv
         6SMShZg/1abeKQU3N3oSsqeoYOfTmP8icWwgitF5iYh9nv6K6PuFnUwsPHH1YF5dWcOI
         r34EvWeGXOADjcMjSiKoDGHmY1pUuUb878aKGaXGwHAPpN20AjOUioFW9J09Bz3FJrUf
         FiDA==
X-Gm-Message-State: AOAM531lBw//rOqjE8oSvtS/rLZvzCJHV++auIiJT/xl19pw/LEnVYy5
        c5J4tObIZJnN0/sOKbLHlUnGPT3ERmVRbbjlqDM=
X-Google-Smtp-Source: ABdhPJwXn14xtfuj2gdLw5RyaClhmPybR2Gly+0Dzu2yc1H4BC6Jhn5Z19o/OFqCXKR0/5fKCx4+2eHJr5RXg9o93tQ=
X-Received: by 2002:a54:4083:: with SMTP id i3mr3410414oii.120.1610138145109;
 Fri, 08 Jan 2021 12:35:45 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-11-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-11-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 15:35:34 -0500
Message-ID: <CADnq5_NHXUy4s962i2bNTJFjOahGLakuS29vxziKApPkMOo1Uw@mail.gmail.com>
Subject: Re: [PATCH 10/40] drm/amd/pm/powerplay/hwmgr/smu7_hwmgr: Fix
 formatting and spelling issues
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

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:242: warni=
ng: Function parameter or member 'hwmgr' not described in 'smu7_enable_smc_=
voltage_controller'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:4508: warn=
ing: Function parameter or member 'us_max_fan_rpm' not described in 'smu7_s=
et_max_fan_rpm_output'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:4508: warn=
ing: Excess function parameter 'usMaxFanRpm' description in 'smu7_set_max_f=
an_rpm_output'
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
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 82676c086ce46..c57dc9ae81f2f 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -235,7 +235,7 @@ static int smu7_get_current_pcie_lane_number(struct p=
p_hwmgr *hwmgr)
>  /**
>   * smu7_enable_smc_voltage_controller - Enable voltage control
>   *
> - * @hwmgr  the address of the powerplay hardware manager.
> + * @hwmgr:  the address of the powerplay hardware manager.
>   * Return:   always PP_Result_OK
>   */
>  static int smu7_enable_smc_voltage_controller(struct pp_hwmgr *hwmgr)
> @@ -4501,7 +4501,7 @@ static int smu7_display_configuration_changed_task(=
struct pp_hwmgr *hwmgr)
>   * smu7_set_max_fan_rpm_output - Set maximum target operating fan output=
 RPM
>   *
>   * @hwmgr:  the address of the powerplay hardware manager.
> - * @usMaxFanRpm:  max operating fan RPM value.
> + * @us_max_fan_rpm:  max operating fan RPM value.
>   * Return:   The response that came from the SMC.
>   */
>  static int smu7_set_max_fan_rpm_output(struct pp_hwmgr *hwmgr, uint16_t =
us_max_fan_rpm)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
