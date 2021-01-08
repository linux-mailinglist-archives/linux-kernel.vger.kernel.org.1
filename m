Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA3F2EF93C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbhAHUbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbhAHUbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:31:31 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF249C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:30:50 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id d20so10957762otl.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8rX5uQHouoI4FRLqYNMC44Y4GpGcbHM8bJ4cljG7WHw=;
        b=VxZNWixJ9jeyM+bRpStXCk4K+N3m4Y9Ybu9ZCvuqS+CqhTWY1XWogyftNuSMgnEt90
         ZWXsoD5HgCuGbbR8yxZJm4DvSQUw17tQ6O0QsVdUjg45cjKPEYUpH1FCcejSkq6ORIYn
         XAcAM/S0kVwh7zsTDEr8rAQB1UU1psvDMPg7jCpp5DSEHM2hpkMDDVQB/PW98ZIWMbr3
         x67+sermSbPEUWP8Ar+zVI9n2jXRI9ynkgBaIV+S/4Y/Z7YxTxIg48Oxwai3JoCgj9Fm
         ZUrwzATMTbL/qZ5Va1HBYi6CQAw6oGXcMbPgp9o4dnLqEELRyvGE4WLSrUCDARalPWOW
         eIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8rX5uQHouoI4FRLqYNMC44Y4GpGcbHM8bJ4cljG7WHw=;
        b=K8kxLI5FsyaiP7++lz6w5ycHZ5PJjeeEKiBUDWzNGazm8OClK1xV7ivLt3aFwibrA0
         X2OgGl7QV/YoaVpe2SW/qcbd3NTwvU8tQzSm4eIHq6e/N/TySFxoh9hGXssWEK9LEkpd
         qfkyv0cqTUPmtOOds+OQdF/FAS7m9eEhWR88uN2WqUuJbrtr4MvBrl7NX8E+iiLhnx6K
         Uji+otO2jb8uTK9XuXuU91qVJTv80Ww6f6IQi8AvBqgZ32Dcp1lQgOODo54aNxB9AxdT
         hPoc5ZrvX5khHBep4fvgCqtua6BDt16jSshA40cDLnHE97UJIjmSqLlbgkmOOFZE3TZJ
         GfKA==
X-Gm-Message-State: AOAM532qg7/ZacLl1oySVv76VQTGKMSxBmrNH/Ut+bEc+kHzghDnnBWk
        rxrYdgSNOwge8JJ4Ja7RYQBN7+lHGusdMOEyVwFlZlL9
X-Google-Smtp-Source: ABdhPJz7Zw0UXJkV9YhbqEzt+3/lMNn51AX5yaKpxgYs2S9iN5GxGCnckdi3xe1/x6OJGrPsnJjXsOH6rXR/u32R+7A=
X-Received: by 2002:a05:6830:1d66:: with SMTP id l6mr3782098oti.23.1610137850323;
 Fri, 08 Jan 2021 12:30:50 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-5-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-5-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 15:30:38 -0500
Message-ID: <CADnq5_M7R1rhP73iUWg+mcOTm_n+j8h2nh0ykLRUVda2xmNvMA@mail.gmail.com>
Subject: Re: [PATCH 04/40] drm/amd/amdgpu/amdgpu_ih: Update
 'amdgpu_ih_decode_iv_helper()'s function header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
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

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c:220: warning: Function parameter =
or member 'ih' not described in 'amdgpu_ih_decode_iv_helper'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c:220: warning: Function parameter =
or member 'entry' not described in 'amdgpu_ih_decode_iv_helper'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ih.c
> index 725a9c73d51f0..dc852af4f3b76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -209,6 +209,8 @@ int amdgpu_ih_process(struct amdgpu_device *adev, str=
uct amdgpu_ih_ring *ih)
>   * amdgpu_ih_decode_iv_helper - decode an interrupt vector
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: ih ring to process
> + * @entry: IV entry
>   *
>   * Decodes the interrupt vector at the current rptr
>   * position and also advance the position for for Vega10
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
