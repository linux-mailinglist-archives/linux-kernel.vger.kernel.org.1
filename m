Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B512DA314
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440122AbgLNWNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408269AbgLNWFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:05:03 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F7DC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:04:16 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id j12so17360723ota.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TX3JAuUmoMFaSLBKp7jxuaJpxpbmhwfuBk/LfmgbykA=;
        b=BB3LPcnvWo/vNeykO5mH6GpRSh5oWkUi9mha/v9PFRWqxPhNpQLjsx1XxJ0nEuOWaq
         neuu5GMg6V/bcCw6cGjg4P5E+Da0J3adx4XOjpqVwyi/C3UmljMSV3lpxeTWIBKPbRU5
         1N86MnUKoL7Q5ZMkVGAdN4RB3pUdV9kl9hPvV2C+jJ7qpjUvsBS/WO8DK6CwdxKyDRbf
         RdnkhBrl/pr/0cVgi6ft9l0+YliN0aChuDETLTkCACAuNt4vZP7ruj8eIc4J7UwbhbNM
         g/mkCPllbPKC4t1IuOj1RGMWTlpytY4KuGnBmdAqKAiK6v/KLC5xdlBbzRwUsiPtyMsP
         Rdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TX3JAuUmoMFaSLBKp7jxuaJpxpbmhwfuBk/LfmgbykA=;
        b=iWv3wG6kQim5ni5sHQVBdbO+8sWYoBGKTfV9f6lnKgUObiZPPhUu9z++7HS6jvShyk
         tSXRzU/wTmOTIewHTt9Gp8MCZ+1CPF/Qllnw2ZaEDyUhGAlWm8znI5AIU7Me76lHPVQb
         MEAUdQQZVuY0LByXnU4XyK8ybEWSZ+XgyFFCFMFboi+ilgIOpGHUzx0RoofJos/BgkFa
         0Hg3nY7ZONrV+vjJT/xC18e8jJTWQCa8LrdcdbBQRvuKxCWwFp1Yh/e1fLbHseMEzaED
         HhETNmXNxns94w3CNc0sZw/aal/X9VpeYy/2S/8GY1cJkedyTOtGAuDxsVyMyrw3NxGW
         KlzQ==
X-Gm-Message-State: AOAM531BVK1XgtqjOtkHdNpZ0rDFFjRDa3R76OS3CGGXtlYHxBNFFL8j
        SxAF1uF66l1kex+ganx5GxRCI7Fudy4/VQfq114=
X-Google-Smtp-Source: ABdhPJwuYKfRUvrb64bJwPGIgLQRDo/8IeY47r1fgMUNYeTjGtyWa0BiH+C81q81L+7AdH5JQCNfOQvlBQF2orAjf7Q=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr21987188ote.132.1607983455510;
 Mon, 14 Dec 2020 14:04:15 -0800 (PST)
MIME-Version: 1.0
References: <1607715156-4258-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1607715156-4258-1-git-send-email-jrdr.linux@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 14 Dec 2020 17:04:04 -0500
Message-ID: <CADnq5_MOqzGe=rDRz5JV3UNTKBWx-XHodZpo5ztMnHwGapac8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fixed kernel test robot warning
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Eryk Brol <eryk.brol@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 2:34 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Kernel test robot throws below warning ->
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5349:5:
> warning: no previous prototype for 'amdgpu_dm_crtc_atomic_set_property'
> [-Wmissing-prototypes]
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5349:5:
> warning: no previous prototype for function
> 'amdgpu_dm_crtc_atomic_set_property' [-Wmissing-prototypes]
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5373:5:
> warning: no previous prototype for 'amdgpu_dm_crtc_atomic_get_property'
> [-Wmissing-prototypes]
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5373:5:
> warning: no previous prototype for function
> 'amdgpu_dm_crtc_atomic_get_property' [-Wmissing-prototypes]
>
> As these functions are only used inside amdgpu_dm.c, these can be
> made static.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 313501c..e6d069d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5328,7 +5328,7 @@ static void dm_crtc_reset_state(struct drm_crtc *crtc)
>  }
>
>  #ifdef CONFIG_DEBUG_FS
> -int amdgpu_dm_crtc_atomic_set_property(struct drm_crtc *crtc,
> +static int amdgpu_dm_crtc_atomic_set_property(struct drm_crtc *crtc,
>                                             struct drm_crtc_state *crtc_state,
>                                             struct drm_property *property,
>                                             uint64_t val)
> @@ -5352,7 +5352,7 @@ int amdgpu_dm_crtc_atomic_set_property(struct drm_crtc *crtc,
>         return 0;
>  }
>
> -int amdgpu_dm_crtc_atomic_get_property(struct drm_crtc *crtc,
> +static int amdgpu_dm_crtc_atomic_get_property(struct drm_crtc *crtc,
>                                             const struct drm_crtc_state *state,
>                                             struct drm_property *property,
>                                             uint64_t *val)
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
