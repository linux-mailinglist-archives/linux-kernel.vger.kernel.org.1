Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE6B23C1D5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 00:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgHDWUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 18:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHDWUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 18:20:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883D6C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 15:20:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q76so4389459wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 15:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bIU597/R52NdHt9My0gKrv9XPCqvlmRzraRI2fhWzKw=;
        b=N8IhA7xXYSSwwD5ZHij95ahJQh5m7VjaobHv39G8BqYbUStXlUudUwRau+y0sqrYIN
         TrnPoZst9mLsMipwxTzW/Ee7yXQx2TjEIE5kvFOIX8I9ZKPOw1x7E0FPVEykt5MtHeW+
         CugqxmE4WdbsZjjMyIdWQv2pyl8yFMUxFzQCi8PN65pCnJQYNEK6odoaWHs3GsbQp8BH
         g7QYvMAynvurxHOsg59Rz1nmLLNZx3SuPzbzS768v53YnXP1Ujzfx6gN+KkohPqvjyPn
         dWh0DeqmRGxwKH4seuHv+HRylwC0v7KxHIE8AlA6jaDMvMtSuBBjtnXK0X370erD2HeZ
         j5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIU597/R52NdHt9My0gKrv9XPCqvlmRzraRI2fhWzKw=;
        b=r86KjWmXHm/eC7MjbYnGcJUsxg9xT+StcDx9H6o/aua/zUWZnG9qNyLE7VLmepAaPK
         bQp/8ttNBJOYkPRGzkK7hwhknm6Fri+A+lwPrmmG5C/z+wk9RneCYYxBO0LE8LxCX4E7
         Dig34bMgYSW58RkEO4nCFsaHas5WVs42iEV+L1Wf+zjx6XY5evVjwmPtR1RGyXSRFdLi
         W7QGQWyilIRGEqSbp5TfEfyA3aO5ShMuY0d3in1UYbJzH6fVvmFY+pg+cBY9srDw/hES
         3YCDlhy9b4+nfzX+WxoIAlD7x5ZcNkrvUytu4WTizpGlRIjIgua5tPlmdB1uZzgG4+yd
         WDDw==
X-Gm-Message-State: AOAM531WzAE+ZHNDyTAN9X7Bqhme2aXfCXfHWyNn0uk0ZoQocbss6N0Q
        oecrOkMwodbetKFi238UnHda/LYtTsLzrq1Y0bE=
X-Google-Smtp-Source: ABdhPJwT9QBo034XdTdgDXsb7+dWpt+h8erXIzRln2NsLfuf3lRuDViXWgaH7wvl80+hXBC9BzPnHPOGAU8dh5dECC4=
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr469144wmh.39.1596579610237;
 Tue, 04 Aug 2020 15:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200802111536.5246-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20200802111536.5246-1-tianjia.zhang@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 4 Aug 2020 18:19:58 -0400
Message-ID: <CADnq5_ObopJHTDfoLHunJGakLNgxLwwfo-g53HCDP=fis+E+iQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix wrong return value in dm_update_plane_state()
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Stylon Wang <stylon.wang@amd.com>, Roman Li <roman.li@amd.com>,
        "Lipski, Mikita" <mikita.lipski@amd.com>,
        tianjia.zhang@alibaba.com,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 4:21 AM Tianjia Zhang
<tianjia.zhang@linux.alibaba.com> wrote:
>
> On an error exit path, a negative error code should be returned
> instead of a positive return value.
>
> Fixes: 9e869063b0021 ("drm/amd/display: Move iteration out of dm_update_planes")
> Cc: Leo Li <sunpeng.li@amd.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 710edc70e37e..5810416e2ddc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8182,8 +8182,7 @@ static int dm_update_plane_state(struct dc *dc,
>                                 dm_old_plane_state->dc_state,
>                                 dm_state->context)) {
>
> -                       ret = EINVAL;
> -                       return ret;
> +                       return -EINVAL;
>                 }
>
>
> --
> 2.26.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
