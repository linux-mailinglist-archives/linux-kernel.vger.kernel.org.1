Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C322EF948
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbhAHUeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbhAHUeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:34:06 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CE8C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:33:25 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id l200so12740174oig.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZYvjPoOvzJBIn24kQKs5FPm5ZLIlN4myojPVOGBPV34=;
        b=crftWgJUHppE4xpnQ9WV+PbL58v5axlyYfAewl1c+EKy61Dvuy53KFTi/S3PLdBJDQ
         mLYM4uYHOgw0uPiUXE7he2yA8H0rtzm/ig+41FrqtDkqXIM23uDNnIKuOl60/ZfiP7uR
         vPiZQj9L61iIFToOrYfyxFv/BPctAShyy9OlNBRqgkeQxnfLGvrszUdlXVznH3FmZ40T
         rYnmBm42yTSBLkKksxQQzu9+zyaWJYFKgdv01z3GyCVpvUuhDc/E/8aBuTdoipw5WRHc
         IY4UG2PXjRQ6vhDiVOruCy+zUgrymwvnn4V7ifzr/WglcBPfgiiL9NtmadlrteJ+vwhl
         phmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZYvjPoOvzJBIn24kQKs5FPm5ZLIlN4myojPVOGBPV34=;
        b=DlNILV39Sc9Q8bF3wvr9HvU0er+4A2LHnFlNk0htl2CeMb/EZEXg3HCZIbNZqKF/C5
         5axffkIJVHf1uOa8Owzys5ePpA0X/tyUMFviXq5fLjmW7hW+nUdpT8pfa9oUxlR0p2U+
         GyzcpX1PwGqibDQmMsnZtxwzfy17NS0YZNRKExnBsxSKlLJGMZiDwxR9TkEvUjamdq3c
         A9AeBk5kEucr2xZqFnoGfhUErMbTuWs4dBwLiQp0B/5/RDXego0UToqykpWq8QSTBg+y
         oWS9tzn9kepSe2Ag2jj1747UP4ogo3ywyMKdEq2HvND2PTYTfUUcjqjI5jgAOH58s5Lj
         Ne+g==
X-Gm-Message-State: AOAM533Nlf88ANW08JfHKU30rcAMbRvT3yvKoOG1GKccvNcyy9Pahgah
        1XtrjFcqRMlX+TAB6+LfXdRPi7bEQ81n5IIkdlk=
X-Google-Smtp-Source: ABdhPJzfCJ8M3CUxtMAGHA/Xdc7hA7kyHDnB8qKu7wRXKdztQGcJ0JssgTBETYQ5JCXKzBsrU1OmY74hy+NwqQs/UVs=
X-Received: by 2002:aca:6202:: with SMTP id w2mr3290407oib.5.1610138005384;
 Fri, 08 Jan 2021 12:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-8-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-8-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 15:33:13 -0500
Message-ID: <CADnq5_NeuyCvFFTiRL6vi0ebNcmjCTCK1aCPE-NoOmNrimbZPQ@mail.gmail.com>
Subject: Re: [PATCH 07/40] drm/amd/pm/powerplay/hwmgr/ppatomctrl: Fix
 documentation for 'mpll_param'
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:290: warni=
ng: Function parameter or member 'mpll_param' not described in 'atomctrl_ge=
t_memory_pll_dividers_si'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:290: warni=
ng: Excess function parameter 'dividers' description in 'atomctrl_get_memor=
y_pll_dividers_si'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:339: warni=
ng: Function parameter or member 'mpll_param' not described in 'atomctrl_ge=
t_memory_pll_dividers_vi'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:339: warni=
ng: Excess function parameter 'dividers' description in 'atomctrl_get_memor=
y_pll_dividers_vi'
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
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> index 83a6504e093cb..b1038d30c8dcc 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> @@ -279,7 +279,7 @@ static const ATOM_VOLTAGE_OBJECT_V3 *atomctrl_lookup_=
voltage_type_v3(
>   *
>   * @hwmgr:           input parameter: pointer to HwMgr
>   * @clock_value:     input parameter: memory clock
> - * @dividers:        output parameter: memory PLL dividers
> + * @mpll_param:      output parameter: memory clock parameters
>   * @strobe_mode:     input parameter: 1 for strobe mode,  0 for performa=
nce mode
>   */
>  int atomctrl_get_memory_pll_dividers_si(
> @@ -332,7 +332,7 @@ int atomctrl_get_memory_pll_dividers_si(
>   *
>   * @hwmgr:                 input parameter: pointer to HwMgr
>   * @clock_value:           input parameter: memory clock
> - * @dividers:              output parameter: memory PLL dividers
> + * @mpll_param:            output parameter: memory clock parameters
>   */
>  int atomctrl_get_memory_pll_dividers_vi(struct pp_hwmgr *hwmgr,
>                 uint32_t clock_value, pp_atomctrl_memory_clock_param *mpl=
l_param)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
