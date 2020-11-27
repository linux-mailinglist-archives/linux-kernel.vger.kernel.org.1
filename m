Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BC82C6884
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 16:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgK0PNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 10:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbgK0PNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 10:13:14 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76FDC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 07:13:12 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so5911667wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 07:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jdic1AcrtNbfCiOP1a193foU7ToP7PxTGmucyyLllzY=;
        b=eFkd8QxSc1ZwnhEaZi3HO0lu4NUyuYVEKihdUegxYkQ76EDIVKbAU6Bz62Y0Twd/D9
         WkS/7z1edRNON6EjPBTY2oz0UK+fNJn9Pyyyy59BYkkszr1NG808l4n5I5/i4XFiGKGC
         MOjfFf3mv5H8mY0U13jMLH9zHk5TEpaTJimLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Jdic1AcrtNbfCiOP1a193foU7ToP7PxTGmucyyLllzY=;
        b=CgKjx/9gE0Z4V51bMPMPN4qIX8/Wjgq5wmJx6EIDR6ulHu2SRyHxRB0tEg1jS18vbQ
         B7EX1l/pIa/yC+eDUNtHz0K+0mLW4dvAFt5bPpj305b7gbYj6KoYhHbpxJfgpPfE5DhH
         IO4eAFGVFZMY7RvL+8oEotZmPB7t143iGm17veD0StJx0nsE4SkBKSyng+zZhM3XjZRs
         /PQ7wKvk3XYgtWH+/yQKVzdlmQW4jCUiLcXzojh/xJD8KTxiDfO7lSlsgv7AemMDQwUq
         ph5Z+wc5h6aRBS7TQ0aeg3u4KzJcun23dUqvw1NK+fogVx3VTPAfHcLTrhorCHYlCCuC
         1olw==
X-Gm-Message-State: AOAM5319aqHRWUQRSOtUZjQGQwzeVknNsbVddvLAZiwkOqqwkxwf1mhJ
        pJH9daXUTAYjwCYxtQ824xq70rvIydl6Qg==
X-Google-Smtp-Source: ABdhPJxS76ox3RylPH7RNmHVGlgnXkh2eKF8FznVgSxfvwW00r3yeMyg8znwZMIDlZzB206zrP/Pkw==
X-Received: by 2002:a5d:4c4a:: with SMTP id n10mr11257523wrt.54.1606489989868;
        Fri, 27 Nov 2020 07:13:09 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f16sm13178895wmh.7.2020.11.27.07.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 07:13:09 -0800 (PST)
Date:   Fri, 27 Nov 2020 16:13:07 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     hdegoede@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vboxvideo: Used the vram helper
Message-ID: <20201127151307.GG401619@phenom.ffwll.local>
Mail-Followup-To: Tian Tao <tiantao6@hisilicon.com>, hdegoede@redhat.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1606446882-36335-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606446882-36335-1-git-send-email-tiantao6@hisilicon.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 11:14:42AM +0800, Tian Tao wrote:
> if the driver uses drmm_vram_helper_init, there is no need to
> call drm_vram_helper_release_mm when the drm module get unloaded,
> as this will done automagically.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/gpu/drm/vboxvideo/vbox_ttm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_ttm.c b/drivers/gpu/drm/vboxvideo/vbox_ttm.c
> index f5a0667..e1909a8 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_ttm.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_ttm.c
> @@ -16,8 +16,8 @@ int vbox_mm_init(struct vbox_private *vbox)
>  	int ret;
>  	struct drm_device *dev = &vbox->ddev;
>  
> -	vmm = drm_vram_helper_alloc_mm(dev, pci_resource_start(dev->pdev, 0),
> -				       vbox->available_vram_size);
> +	vmm = drmm_vram_helper_init(dev, pci_resource_start(dev->pdev, 0),
> +				    vbox->available_vram_size);

Pretty sure this doesn't compile without warnings, since the return value
changes. With that fixed lgtm.

Btw if you're bored, a devm_ version of arch_phys_wc_add is very much on
the wishlist, and would allow us to complete remove vbox_mm_fini.

Cheers, Daniel

>  	if (IS_ERR(vmm)) {
>  		ret = PTR_ERR(vmm);
>  		DRM_ERROR("Error initializing VRAM MM; %d\n", ret);
> @@ -32,5 +32,4 @@ int vbox_mm_init(struct vbox_private *vbox)
>  void vbox_mm_fini(struct vbox_private *vbox)
>  {
>  	arch_phys_wc_del(vbox->fb_mtrr);
> -	drm_vram_helper_release_mm(&vbox->ddev);
>  }
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
