Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AEF2B2204
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgKMRUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgKMRU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:20:28 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEF7C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:20:42 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 23so10720381wrc.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NEaARK+POApdAw5J8PNHmNemCEDBmRf/3tg6J4pJI0M=;
        b=R6rtmTSZnNl731YRGDLFG8hdCdRPWHKjhA5UWZjwI/PfJwUVBbSL27+peGAr4V+8iD
         iWYOBX+e9pfgg2gKPbaBOOprNQy08NDVePDaiWsgSlMREsV0Sz76OaWCE53Qxr75P7WP
         207JKI2lKpeNFEuyweyLq7RdqXj99TONcWbmZvIQhuuoFhVlrm1y8SATNKAQwABE2cuc
         DpeqZROMHnwcL9QjSsIUdTX66nmAPJMsCcX2uDbT1KccODGZJ07Pp3u8p9JVk40+fpew
         bIj4RNYMe1KKB9kWdQgDafM61W8MeurXYsLX4joBLQG9uHK+OC8162NWnbxjjQa/AXDv
         jxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NEaARK+POApdAw5J8PNHmNemCEDBmRf/3tg6J4pJI0M=;
        b=dmkMl70US5J9Xrty2Y8sdg6pDU5cK/QVFeTliKr7jTqrtzoyEJMyefs5N7TzaRtRhi
         Pm8kz6/ntMi98RMt2eC58tQuA0EPqjaxzZP67yO2FIz9YpyGbKEmNfYiJA1xRN10ITxS
         uRws9TmUgdHsTuv/Ig1lU2BzxLk5r3hBSGebJUG7KnQslt/i8w3pwe/uJuyKOJ2ZirCG
         BslzvhntP5m3D1bvA5Seqqnz/69v6BGdx0zD0hCJgWVQX/1M7N/nCpwYFjbU0DaKP27B
         mX0fEkvu16YjgPxRxTNoObX/8pPKcXIld8RykNAoCbRE0ojJXQ7l3tMUDiXlGclDMCLp
         f8qw==
X-Gm-Message-State: AOAM533nq/mklf+ImJn70zzs5oU/kgf0gOD0VtkQp5fcH+oyKwrK9WKe
        3zNhBVjcVeqGqX3v/wq74AqTvb1WzsAG6W+yaOs=
X-Google-Smtp-Source: ABdhPJy7Om5K1FFzu6cmA2r6Ya+DBvWq+aqxYz57w5FYoi0nJHblqOjzwI/+I4lO7oFHhLpR1lOPoURC+78Bii+3aVc=
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr5020076wrn.124.1605288036035;
 Fri, 13 Nov 2020 09:20:36 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org> <20201113134938.4004947-20-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-20-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Nov 2020 12:20:24 -0500
Message-ID: <CADnq5_PCYT6aCJEwkrS6949zU=trK5D-75w4FEWFkhaGGXtE1Q@mail.gmail.com>
Subject: Re: [PATCH 19/40] drm/amd/amdgpu/amdgpu_vram_mgr: Add missing
 descriptions for 'dev' and 'dir'
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

On Fri, Nov 13, 2020 at 8:50 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:648: warning: Function para=
meter or member 'dev' not described in 'amdgpu_vram_mgr_free_sgt'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:648: warning: Function para=
meter or member 'dir' not described in 'amdgpu_vram_mgr_free_sgt'
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vram_mgr.c
> index c99c2180785fe..d2de2a720a3d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -637,6 +637,8 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *a=
dev,
>   * amdgpu_vram_mgr_free_sgt - allocate and fill a sg table
>   *
>   * @adev: amdgpu device pointer
> + * @dev: device pointer
> + * @dir: data direction of resource to unmap
>   * @sgt: sg table to free
>   *
>   * Free a previously allocate sg table.
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
