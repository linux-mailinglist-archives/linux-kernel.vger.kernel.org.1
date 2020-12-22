Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CBE2E0A16
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 13:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgLVMfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 07:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgLVMfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 07:35:14 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABEAC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 04:34:34 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id n127so2910017ooa.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 04:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tr+V9UKVzYs4ysPzLGuYM79WqlxZSfPeKFIlvL2ZGZM=;
        b=NiLpbTOYygjIY9aIZ1BYsTVq9S6t2u0VhSeIajW0kSFp/eCwdMTvTnMSAzbRCJsya1
         rvpSRlxbmpizlSxy2AoFthtbjiIPyk2oAcvGZzlT6kLCwEeyuHnZvo0nfZHzVyz7E8ZS
         bVzAzOy73q07GDUE+DJk3I6X5xNO2gsSIzB4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tr+V9UKVzYs4ysPzLGuYM79WqlxZSfPeKFIlvL2ZGZM=;
        b=Mb1tBRZ0OLrU8D9s7vX/dgXM0ql5ihRqbrMYRpwnXaMHqkf80lFF/CWNPnNJPOWue6
         DLgbk8BB5Aj8RJmJDlSTHqnGAoRti+8FWxHqButOxkSj9TkPrdOEB4Z5FN66CdxzU6c6
         dITksr1ySzkDG7PuwuVmerO25bsvbqsIxVkvM1f0X+ag8RHZVXVmUbfXLshXQFJ+c4oc
         yeud/K65h/C1gDRojgWfp2plRorKx8v8jdal6P5Sy6vx4Wanj/GW+IIu4kiLxd1EGMZ4
         HmR2TpqZ5Ttaj9uW0cSXDILIsupalx/XmWibyjtqC7uth81VsPU0qoECkL7uKhfbxj7a
         sq/g==
X-Gm-Message-State: AOAM530YOqsqyf07EBwnaiC4Z19fwubX8HJIhQCu2xiZ7Rilf/QPu/tc
        6YjQd78gyjY+D3oN5GSNwtmX3cxWB8Qd94pRwlh04A==
X-Google-Smtp-Source: ABdhPJypAj/udMv3GjHOEyanFde0rNqQ75gxPXTn/dxDCKrDw0+ZxswjGJBM38z7nuTjzJbxsMmBwAtwG4sP6tXBi/M=
X-Received: by 2002:a4a:11c2:: with SMTP id 185mr14836279ooc.85.1608640473605;
 Tue, 22 Dec 2020 04:34:33 -0800 (PST)
MIME-Version: 1.0
References: <1608638156-7879-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1608638156-7879-1-git-send-email-tiantao6@hisilicon.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 22 Dec 2020 13:34:22 +0100
Message-ID: <CAKMK7uGpvnmAH0GGfM0G_UgnqvwUWsyQuTwVvJ870fpqxgeSxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/hisilicon: Remove drm_dev_put in hibmc
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Dave Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 12:56 PM Tian Tao <tiantao6@hisilicon.com> wrote:
>
> Hibmc use the devm_drm_dev_alloc function in hibmc_pci_probe, if
> hibmc_pci_probe returns non-zero, devm_drm_dev_alloc will call
> devm_drm_dev_init, which will call devm_drm_dev_init_release to
> release drm_dev_put. There is no need for hibmc to call
> drm_dev_put separately.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

lgtm, Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Daniel
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 7159018..0d4e902 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -332,13 +332,13 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
>         ret = pcim_enable_device(pdev);
>         if (ret) {
>                 drm_err(dev, "failed to enable pci device: %d\n", ret);
> -               goto err_free;
> +               goto err_return;
>         }
>
>         ret = hibmc_load(dev);
>         if (ret) {
>                 drm_err(dev, "failed to load hibmc: %d\n", ret);
> -               goto err_free;
> +               goto err_return;
>         }
>
>         ret = drm_dev_register(dev, 0);
> @@ -354,9 +354,7 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
>
>  err_unload:
>         hibmc_unload(dev);
> -err_free:
> -       drm_dev_put(dev);
> -
> +err_return:
>         return ret;
>  }
>
> --
> 2.7.4
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
