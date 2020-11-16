Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419112B3ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 01:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgKPAYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 19:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbgKPAYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 19:24:46 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD2AC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 16:24:46 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a3so22136107wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 16:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUyT7HTicJllVKXgyA1Cwx+07UYSRPUlkv+F+qeualw=;
        b=dB8ZpzvzFRUR6qFT8MaXdJo8wn/Lhz8NxKk24CPjLigntQbUGrBCr7Pu1BkgNqwl6z
         qv6zEvWEzQhMzIUSW+NuTaDXW/SWP9YY4VTbotfeuOMxMua94zbBWgQjZ3f8+8L3o15w
         a/5ZIfWgv/mi/o+tIX6glAss/M2kk1V28uLKN95vVUOIkFt4o5+kgajawIFuPF3xQwD/
         j8Uv2wqBuKOniXnKxZovYFm9lx9o7kiHetfCAcu58G8CJhNU1nY/LCl1RUAgmPzghThO
         7UUJsBWV+DbHgnKCjpgBJGRbAM3rSi1WtLRzQX5fzcpgYzx510zi3avB7G39yR6ZMZXP
         kiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUyT7HTicJllVKXgyA1Cwx+07UYSRPUlkv+F+qeualw=;
        b=pETTLWy56o9WlDerqx/IRVLDDARORqA9cAvcFCdkWUWGMwEKEk+hO2dkIW+kzgthhZ
         h5FiYo/28BzwJ8GKtUgcKZZdS4348JgPaKPnU88CtvqTKA/MDBdcpf4TVNzM2SxeEUzE
         4jFaHrDILxfnyFTnOPP0AN9YFiMBCJG/mdxc+jm68mjKjNvjbLlyEeoFWODKV6GT+wQZ
         NtEmRL2KwqchvrzKL/jYHu3aosSREL+5CG3gZeskE97mHOnN9FKBVRLijc0KNL47Qa4a
         uPkhkWsGRo96S0wI9CDHOgFUShmN3vbTA2QxAprSFGmiKk/7EwWxTtM9dezD0g1MPr9t
         mdpw==
X-Gm-Message-State: AOAM532vy628ZXjlTJ/qU8Fty8FNMPFnYOEIfU1D9/mTTwosWbbySSqP
        kebXYv8WjOajDs5TPGPRFUS1qk/dIJac0rH6DeE=
X-Google-Smtp-Source: ABdhPJykcujZq4xRwu+2v95YrVwzQup9pDYXTEx8ALY47iKInAFm0+4TaYD9Q33qlns64mpE/RjQ4bqXGdHt7FAIfHI=
X-Received: by 2002:a7b:c0cc:: with SMTP id s12mr12453523wmh.41.1605486285009;
 Sun, 15 Nov 2020 16:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org> <20201113134938.4004947-16-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-16-lee.jones@linaro.org>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 16 Nov 2020 08:24:33 +0800
Message-ID: <CAKGbVbsubdPbZJfwXKEgRHn873sCHh98kd8pK+HVvKfpQXwXrA@mail.gmail.com>
Subject: Re: [PATCH 15/40] drm/lima/lima_drv: Demote kernel-doc formatting abuse
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next.

On Fri, Nov 13, 2020 at 9:50 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/gpu/drm/lima/lima_drv.c:264: warning: cannot understand function prototype: 'const struct drm_driver lima_drm_driver = '
>
> Cc: Qiang Yu <yuq825@gmail.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: lima@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/lima/lima_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
> index d497af91d8505..7b8d7178d09aa 100644
> --- a/drivers/gpu/drm/lima/lima_drv.c
> +++ b/drivers/gpu/drm/lima/lima_drv.c
> @@ -255,7 +255,7 @@ static const struct drm_ioctl_desc lima_drm_driver_ioctls[] = {
>
>  DEFINE_DRM_GEM_FOPS(lima_drm_driver_fops);
>
> -/**
> +/*
>   * Changelog:
>   *
>   * - 1.1.0 - add heap buffer support
> --
> 2.25.1
>
