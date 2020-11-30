Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEB32C86DA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgK3Ode (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbgK3Odc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:33:32 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E11C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:32:46 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k14so16515863wrn.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=1izSrE5tIgte+y1yJePg5s3+P+hBR2gHJhVi9jRqD4Q=;
        b=NDVpU9VLchEJ8x8pxoh/NqTjZdE2GQ96DmheGPRwcS12219t7XRWd7c5RrCvm9jahr
         rzpJQlmnqq9/m26nRRoxUctoabq+9THeNHT9vIxiRjyi2vvSnSafWEBbRW4TCwcUC5ZK
         UOtdZ3APNagSW5LFgUW0fCEz+zBBKOy3G6xHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=1izSrE5tIgte+y1yJePg5s3+P+hBR2gHJhVi9jRqD4Q=;
        b=dK1ochI92Hf6O2eg9axukrNdFaLqOmcwLLHJVtSvuXurAAkBRwjP1g6qv0v4orLZL4
         QuLxCaWNPn579H2s3YHSX0kWmSQL2fTI2MAW2n7NfMA6+QSmtCB+Vg/SULiEO+BoWGZF
         aDtm9XyINiqeG14Bky+VYpfrrNBJ6iAmGQQUm+EyDqfWAYvabORXMM7gpY3VTEgmI9J7
         z6DeUMN8cRTO4mccSmKod6wGEou9lT1p1z7qAgdVSSqAihXbgCMnvn6pUMX9U0FYnHYc
         3qZU6iaEGyXRmSQ8W9vTTYVJu0o1Ie+TZYNxe4gt3WZzz1tOHRYR7rCbH+LaDJRAwmBi
         hd8Q==
X-Gm-Message-State: AOAM531fNcCSJXLDMMqTHtDuNB3CYD4JNib1T7PwspcZglwFKltipvs6
        zjox+IN5KyJN6LgYrvsjuxEE+g==
X-Google-Smtp-Source: ABdhPJzFZzm1pxUa1tzPVIl975jKOl71PdeKWbmbtr6Jv3Sb2mul/MxJ+GXaVbUEzZI9TgYlzlNxsQ==
X-Received: by 2002:a5d:4746:: with SMTP id o6mr7734934wrs.324.1606746764681;
        Mon, 30 Nov 2020 06:32:44 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v20sm23112819wmh.44.2020.11.30.06.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 06:32:43 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:32:41 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jialin Zhang <zhangjialin11@huawei.com>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alan Cox <alan@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        huawei.libin@huawei.com
Subject: Re: [PATCH] drm/gma500: Fix error return code in psb_driver_load()
Message-ID: <20201130143241.GO401619@phenom.ffwll.local>
Mail-Followup-To: Jialin Zhang <zhangjialin11@huawei.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>, Alan Cox <alan@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com
References: <20201130020216.1906141-1-zhangjialin11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130020216.1906141-1-zhangjialin11@huawei.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 10:02:16AM +0800, Jialin Zhang wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 5c49fd3aa0ab ("gma500: Add the core DRM files and headers")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>

Out of curiosity, what is hulk robot matching here? This is a really
interesting bug for automated checkers to find!

Thanks for the patch, applied to drm-misc-next.
-Daniel

> ---
>  drivers/gpu/drm/gma500/psb_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
> index 34b4aae9a15e..074f403d7ca0 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> @@ -313,6 +313,8 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
>  	if (ret)
>  		goto out_err;
>  
> +	ret = -ENOMEM;
> +
>  	dev_priv->mmu = psb_mmu_driver_init(dev, 1, 0, 0);
>  	if (!dev_priv->mmu)
>  		goto out_err;
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
