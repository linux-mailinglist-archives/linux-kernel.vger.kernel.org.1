Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C88E2F843D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbhAOSXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387484AbhAOSXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:23:49 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC27BC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:23:08 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q205so10448923oig.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpWBTznuZUcZAzRcrI6A4hvRemlBsfvV9VTskIiTxqs=;
        b=r4ItQkShTWFZzgNdjP8hyF+E54DMf5V43oiwMlZk8cSAA1/Yy5b6ThpPrkNw/Q0MOC
         31DpJ6w4I5eniQaODuloEV3I/wKF4nNROthpuHi/DUl6SqGtT3sFp7EDRQ+cciiH6DJa
         E+P74Uci89IOAg597D/E194PQsRxCA4dHfL2R1ta4NYV+XR5Ta/pGBGdvPG8H/q7vdNO
         ggStMgkohzJMTm4aBIKpzA4zbCYjStOH8UiUpy1LoWdmC+AOrLJtV1WJdfEBjSyZNjXo
         Ey/aFoHcSYqWs382PaCyuzb9uy6K6lvtw0HLUFjDK5fq5mz3WdrWYJzSCRJR18SK0tFV
         SAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpWBTznuZUcZAzRcrI6A4hvRemlBsfvV9VTskIiTxqs=;
        b=LUIUfzfD+31k3YW7ZNSpd/fAlnU43RzCcLcCf+kFqrY1uFEWhaRHzUavZDlmuH3qTU
         FWW4JPgNgOsh0qTh6wkFzoQx5wP/0e80i46A1tNH1+ujoJuSvbCOGY5vW0zbJa3qGTTq
         d19TnKkJSGh35B7OckfSqasjXypfCDLu9rGu+kl2yAO5sYGxdukn2xgXrCEYElo3rwzq
         ccPBrBcdF5IF2gzVnYl8C4R8H9PvPcg/zE8ewsVrXBHgTB9h6Iwu85yX5MQSmSoRmEsx
         mG5qIIYV7o1i1pCiYEe97BTZHAlv0BCcdh8HPYCAyDbBTPiIXHZZAj8auQaIoHVuENjM
         oLgA==
X-Gm-Message-State: AOAM53091bWteP8yYLBvkT9PAj85B4riVJ8Z7bCvKrmjSNPE9Jfd/IAx
        /opFthZwWWh4Cz6L8oz/6xONWMETlEHcrf873Ho=
X-Google-Smtp-Source: ABdhPJztGGkhnXM/NF2imQJbEBr/K/vQ1PEj3u+KGHvjd0QNy8GJX1MVCyD1SYKE37RrJO+k2Tt/L+DnEGv4YL0gnuk=
X-Received: by 2002:a54:4083:: with SMTP id i3mr6470473oii.120.1610734988375;
 Fri, 15 Jan 2021 10:23:08 -0800 (PST)
MIME-Version: 1.0
References: <20210115034152.1800769-1-zhangzhijie@loongson.cn>
In-Reply-To: <20210115034152.1800769-1-zhangzhijie@loongson.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 15 Jan 2021 13:22:57 -0500
Message-ID: <CADnq5_MMW7CpGiAu_oDqt6XRP+9NJt8gTMV0aMk2NxGSCRqqZQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu:this forword declear maybe not used
To:     "ZhiJie.Zhang" <zhangzhijie@loongson.cn>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian Koenig <christian.koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 3:55 AM ZhiJie.Zhang <zhangzhijie@loongson.cn> wrote:
>
> Signed-off-by: ZhiJie.Zhang <zhangzhijie@loongson.cn>

Applied with a cleaned up commit message.

Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 2ee6edb3df93..ef4acb1d4a80 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -58,10 +58,10 @@
>  /* Forward declarations */
>  struct amdgpu_device;
>  struct drm_device;
> -struct amdgpu_dm_irq_handler_data;
>  struct dc;
>  struct amdgpu_bo;
>  struct dmub_srv;
> +struct dc_plane_state;
>
>  struct common_irq_params {
>         struct amdgpu_device *adev;
> @@ -438,11 +438,6 @@ struct amdgpu_dm_connector {
>
>  extern const struct amdgpu_ip_block_version dm_ip_block;
>
> -struct amdgpu_framebuffer;
> -struct amdgpu_display_manager;
> -struct dc_validation_set;
> -struct dc_plane_state;
> -
>  struct dm_plane_state {
>         struct drm_plane_state base;
>         struct dc_plane_state *dc_state;
> --
> 2.29.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
