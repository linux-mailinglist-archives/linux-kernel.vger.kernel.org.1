Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CA52A9704
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 14:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgKFNcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 08:32:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727214AbgKFNcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 08:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604669519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+TezUSg7dLvy+l68Hy5i/kXoVUr9enrZZU+nQNhmr4=;
        b=W+lPFUiRhop+e2wZ4Wkli0/K5sPG5Hsu9QfPlEDOt7rSz1rroJLBhG2cJ9PWcNWJryzb3Q
        shwkvSSgat6B3ngky8sQ1N/W06Xf+qtmm9EXaxIqAmqI07KyCbtJuU9adc2WnGVeebnDFu
        yXG7CqYHglC02TXfDWb4SY/kSfo0pvg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534--LTpQ5dwMP68bYm5dAfpWw-1; Fri, 06 Nov 2020 08:31:56 -0500
X-MC-Unique: -LTpQ5dwMP68bYm5dAfpWw-1
Received: by mail-qv1-f69.google.com with SMTP id dd7so640124qvb.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 05:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+TezUSg7dLvy+l68Hy5i/kXoVUr9enrZZU+nQNhmr4=;
        b=GkTRM98fwVQxlSHR3oAkk7GbMmL6CYHKds4cyiZT9/q65YsscQHPHlarFuPh+iyNoQ
         STULEcCpuHXy0e6IFuwoSecLgSCyZNJu2D1fn7H0GU4ShpFHuZ2S1t7KES4X5DHB+82a
         BevZqyGkuDX7gdEpxeuxXwH7qWDIlaaf/o5+VNP3fSdWC/qPpadDy0eVn3pQFZQVyzUt
         rgYwEFYZw3aQIHZfwsQsYNx6vyNRfPNejbRHzmR09Tfv+odO4FRfB0v31ErWRcncnnyT
         egne7RVmd1YwhgS6IseH6/kjC6NTaZ1gVvn/+mvCIwGScDL9L6sEl7NbTwCuK2FB6GMM
         dKEg==
X-Gm-Message-State: AOAM5319t+4SY/y5ssGBOuVLOOv8C41psw4dAvvmygCWyyvYRqfHAF9b
        pLpHkeVC421K5d1+U1Cao+648KJOrdXENA++FcDPwmDBuOB0bukyyRglegNZBqiBoKC/682Yoci
        3lFS27rmpSVG7/1aw/jk0uEACbX5ht6zidPqIZq3N
X-Received: by 2002:ac8:7091:: with SMTP id y17mr223017qto.137.1604669515556;
        Fri, 06 Nov 2020 05:31:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyu3cbrhu9g6f3NITckdttARw/NVAeKuSKVHYHWNP1ZBlgHMhdbCGrdhVO1eRoSn+j5wMPadxGqseSifPCLlas=
X-Received: by 2002:ac8:7091:: with SMTP id y17mr222996qto.137.1604669515256;
 Fri, 06 Nov 2020 05:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20201106021656.40743-1-jcline@redhat.com> <20201106021656.40743-3-jcline@redhat.com>
In-Reply-To: <20201106021656.40743-3-jcline@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 6 Nov 2020 14:31:44 +0100
Message-ID: <CACO55tsRGOH5rwy-40_6FY_9mGZKfkiFBoAT2jowbQYmaLGK8g@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 2/3] drm/nouveau: manage nouveau_drm lifetime
 with devres
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 3:17 AM Jeremy Cline <jcline@redhat.com> wrote:
>
> Make use of the devm_drm_dev_alloc() API to bind the lifetime of
> nouveau_drm structure to the drm_device. This is important because a
> reference to nouveau_drm is accessible from drm_device, which is
> provided to a number of DRM layer callbacks that can run after the
> deallocation of nouveau_drm currently occurs.
>
> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 44 ++++++++++++---------------
>  drivers/gpu/drm/nouveau/nouveau_drv.h | 10 ++++--
>  2 files changed, 26 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index bc6f51bf23b7..f750c25e92f9 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -30,9 +30,11 @@
>  #include <linux/vga_switcheroo.h>
>  #include <linux/mmu_notifier.h>
>
> +#include <drm/drm_drv.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_ioctl.h>
>  #include <drm/drm_vblank.h>
> +#include <drm/drm_managed.h>
>
>  #include <core/gpuobj.h>
>  #include <core/option.h>
> @@ -532,13 +534,8 @@ nouveau_parent = {
>  static int
>  nouveau_drm_device_init(struct drm_device *dev)
>  {
> -       struct nouveau_drm *drm;
>         int ret;
> -
> -       if (!(drm = kzalloc(sizeof(*drm), GFP_KERNEL)))
> -               return -ENOMEM;
> -       dev->dev_private = drm;
> -       drm->dev = dev;
> +       struct nouveau_drm *drm = nouveau_drm(dev);
>
>         nvif_parent_ctor(&nouveau_parent, &drm->parent);
>         drm->master.base.object.parent = &drm->parent;
> @@ -620,7 +617,6 @@ nouveau_drm_device_init(struct drm_device *dev)
>         nouveau_cli_fini(&drm->master);
>  fail_alloc:
>         nvif_parent_dtor(&drm->parent);
> -       kfree(drm);
>         return ret;
>  }
>
> @@ -654,7 +650,6 @@ nouveau_drm_device_fini(struct drm_device *dev)
>         nouveau_cli_fini(&drm->client);
>         nouveau_cli_fini(&drm->master);
>         nvif_parent_dtor(&drm->parent);
> -       kfree(drm);
>  }
>
>  /*
> @@ -720,6 +715,7 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
>  {
>         struct nvkm_device *device;
>         struct drm_device *drm_dev;
> +       struct nouveau_drm *nv_dev;
>         int ret;
>
>         if (vga_switcheroo_client_probe_defer(pdev))
> @@ -750,15 +746,16 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
>         if (nouveau_atomic)
>                 driver_pci.driver_features |= DRIVER_ATOMIC;
>
> -       drm_dev = drm_dev_alloc(&driver_pci, &pdev->dev);
> -       if (IS_ERR(drm_dev)) {
> -               ret = PTR_ERR(drm_dev);
> +       nv_dev = devm_drm_dev_alloc(&pdev->dev, &driver_stub, typeof(*nv_dev), drm_dev);
> +       if (IS_ERR(nv_dev)) {
> +               ret = PTR_ERR(nv_dev);
>                 goto fail_nvkm;
>         }
> +       drm_dev = nouveau_to_drm_dev(nv_dev);
>
>         ret = pci_enable_device(pdev);
>         if (ret)
> -               goto fail_drm;
> +               goto fail_nvkm;
>
>         drm_dev->pdev = pdev;
>         pci_set_drvdata(pdev, drm_dev);
> @@ -778,8 +775,6 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
>         nouveau_drm_device_fini(drm_dev);
>  fail_pci:
>         pci_disable_device(pdev);
> -fail_drm:
> -       drm_dev_put(drm_dev);

it sounded like that when using devm_drm_dev_alloc we still have an
initial refcount of 1, so at least in this regard nothing changed so I
am wondering why this change is necessary and if the reason is
unrelated it might make sense to move it into its own patch.

>  fail_nvkm:
>         nvkm_device_del(&device);
>         return ret;
> @@ -799,7 +794,6 @@ nouveau_drm_device_remove(struct drm_device *dev)
>         device = nvkm_device_find(client->device);
>
>         nouveau_drm_device_fini(dev);
> -       drm_dev_put(dev);
>         nvkm_device_del(&device);
>  }
>
> @@ -1285,7 +1279,8 @@ nouveau_platform_device_create(const struct nvkm_device_tegra_func *func,
>                                struct platform_device *pdev,
>                                struct nvkm_device **pdevice)
>  {
> -       struct drm_device *drm;
> +       struct nouveau_drm *nv_dev;
> +       struct drm_device *drm_dev;
>         int err;
>
>         err = nvkm_device_tegra_new(func, pdev, nouveau_config, nouveau_debug,
> @@ -1293,22 +1288,21 @@ nouveau_platform_device_create(const struct nvkm_device_tegra_func *func,
>         if (err)
>                 goto err_free;
>
> -       drm = drm_dev_alloc(&driver_platform, &pdev->dev);
> -       if (IS_ERR(drm)) {
> -               err = PTR_ERR(drm);
> +       nv_dev = devm_drm_dev_alloc(&pdev->dev, &driver_platform, typeof(*nv_dev), drm_dev);
> +       if (IS_ERR(nv_dev)) {
> +               err = PTR_ERR(nv_dev);
>                 goto err_free;
>         }
> +       drm_dev = nouveau_to_drm_dev(nv_dev);
>
> -       err = nouveau_drm_device_init(drm);
> +       err = nouveau_drm_device_init(drm_dev);
>         if (err)
> -               goto err_put;
> +               goto err_free;
>
> -       platform_set_drvdata(pdev, drm);
> +       platform_set_drvdata(pdev, drm_dev);
>
> -       return drm;
> +       return drm_dev;
>
> -err_put:
> -       drm_dev_put(drm);
>  err_free:
>         nvkm_device_del(pdevice);
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
> index 3e2920a10099..cf6c33e52a5c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drv.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
> @@ -137,7 +137,11 @@ struct nouveau_drm {
>         struct nvif_parent parent;
>         struct nouveau_cli master;
>         struct nouveau_cli client;
> -       struct drm_device *dev;
> +
> +       /**
> +        * @drm_dev: The parent DRM device object.
> +        */
> +       struct drm_device drm_dev;
>
>         struct list_head clients;
>
> @@ -237,7 +241,7 @@ struct nouveau_drm {
>  static inline struct nouveau_drm *
>  nouveau_drm(struct drm_device *dev)
>  {
> -       return dev->dev_private;
> +       return container_of(dev, struct nouveau_drm, drm_dev);
>  }
>
>  /**
> @@ -251,7 +255,7 @@ nouveau_drm(struct drm_device *dev)
>   */
>  static inline struct drm_device *
>  nouveau_to_drm_dev(struct nouveau_drm *nv_dev) {
> -       return nv_dev->dev;
> +       return &nv_dev->drm_dev;
>  }
>
>  /**
> --
> 2.28.0
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
>

