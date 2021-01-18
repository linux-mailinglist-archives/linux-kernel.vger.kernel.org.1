Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88292FADB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 00:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732854AbhARXYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 18:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730272AbhARXX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 18:23:59 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26BAC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 15:23:18 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id h4so20309006qkk.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 15:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DBvkANnsASxNzW1l4kG04pLbjkG68+3VpEAecnZNaSA=;
        b=XDm097mldCjKNGSrByLQ0T7F7N9MUkOW49lOtt+kzwDNZ2vn4ZgGt98sJsHoiJ3PpD
         2CXsO7iCz4GOUKGp9omKhzptoX41tdKD6/5rs2JGStmHiEToMK7YhljMwGSseW/5AE90
         XstktZpNsBNFrtASn1vL3HMq0VTMQuDCvjA+XdLcoFpGFFxQzwng/2E6vWxw6e9RBR8G
         zClNzhSTKcv1ZfWBnxNK+4jZZpVfVlw35nDG5JWBKP0t1DwKyitaS2E+w0Ax/k0aKbMp
         Jm8ZsVWhgvy89C3mx6/elomre4rUs6JhYdw6+ANB0C6h/HJ35BGQ6XZ+vamtnavlOSt2
         fUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DBvkANnsASxNzW1l4kG04pLbjkG68+3VpEAecnZNaSA=;
        b=XShhzznSl8MpsT0pZKocbwXtVvQ70Yao+nKccpI/WVDsZMpRswHHfSvDRdknjgbKZG
         seqUcMJqXXS2rRCvPN1X0zjEu8HvD8S8TNIEVMnsTqiishd9d3iTZRQc71Y7QpSRHBuM
         GTTrOjMMI+eC4/a6SbO9EzVdFuJRZ7y4nUnvjQsrMlCKEXMZdLedSL5HMzTBjJ0nVzMI
         dm/z5+lMO2fvqhFhlFovbdwTrQ1qsYE/xUiXX1BegfXubjp2Z9KHQW/QsYAy2pIQ18bF
         eGTMWFu9sgSBlxbzeHPFxzEIuILY7yQQtbDXlTve4zOOGaAmCQpvnZSaXL57Fz6fizOE
         +fXw==
X-Gm-Message-State: AOAM5336MJgZoeDpRAoEFy2v5jnEbVABQjpFEE34ze028OXAU6EKesPD
        /myXA4o22NmBR6UWnm/k5dRmIrfZT1ClvUGFnx9d8w==
X-Google-Smtp-Source: ABdhPJxUVtLZ5wlXdNBM3SyiUYqA8bQPWf2PF9ARLTVL4xSRF3Uvs7Olys7HhET4W8YekMTWVyI4yCY7mD9ViPLhu0A=
X-Received: by 2002:a37:68e:: with SMTP id 136mr1897310qkg.121.1611012197723;
 Mon, 18 Jan 2021 15:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20210118224659.263928-1-zzyiwei@android.com>
In-Reply-To: <20210118224659.263928-1-zzyiwei@android.com>
From:   =?UTF-8?B?WWl3ZWkgWmhhbmfigI4=?= <zzyiwei@android.com>
Date:   Mon, 18 Jan 2021 15:23:07 -0800
Message-ID: <CAKB3++adfpdBHFEyGZ3v2V6zyW+ayg86CLDRKx1ty+OytjYFNw@mail.gmail.com>
Subject: Re: [PATCH] Track total GPU memory for virtio driver
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 2:47 PM Yiwei Zhang <zzyiwei@android.com> wrote:
>
> On the success of virtio_gpu_object_create, add size of newly allocated
> bo to the tracled total_mem. In drm_gem_object_funcs.free, after the gem
> bo lost its last refcount, subtract the bo size from the tracked
> total_mem if the original underlying memory allocation is successful.
>
> Signed-off-by: Yiwei Zhang <zzyiwei@android.com>
> ---
>  drivers/gpu/drm/virtio/Kconfig          |  1 +
>  drivers/gpu/drm/virtio/virtgpu_drv.h    |  4 ++++
>  drivers/gpu/drm/virtio/virtgpu_object.c | 19 +++++++++++++++++++
>  3 files changed, 24 insertions(+)
>
> diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
> index b925b8b1da16..e103b7e883b1 100644
> --- a/drivers/gpu/drm/virtio/Kconfig
> +++ b/drivers/gpu/drm/virtio/Kconfig
> @@ -5,6 +5,7 @@ config DRM_VIRTIO_GPU
>         select DRM_KMS_HELPER
>         select DRM_GEM_SHMEM_HELPER
>         select VIRTIO_DMA_SHARED_BUFFER
> +       select TRACE_GPU_MEM
>         help
>            This is the virtual GPU driver for virtio.  It can be used with
>            QEMU based VMMs (like KVM or Xen).
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 6a232553c99b..7c60e7486bc4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -249,6 +249,10 @@ struct virtio_gpu_device {
>         spinlock_t resource_export_lock;
>         /* protects map state and host_visible_mm */
>         spinlock_t host_visible_lock;
> +
> +#ifdef CONFIG_TRACE_GPU_MEM
> +       atomic64_t total_mem;
> +#endif
>  };
>
>  struct virtio_gpu_fpriv {
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index d69a5b6da553..1e16226cebbe 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -25,12 +25,29 @@
>
>  #include <linux/dma-mapping.h>
>  #include <linux/moduleparam.h>
> +#ifdef CONFIG_TRACE_GPU_MEM
> +#include <trace/events/gpu_mem.h>
> +#endif
>
>  #include "virtgpu_drv.h"
>
>  static int virtio_gpu_virglrenderer_workaround = 1;
>  module_param_named(virglhack, virtio_gpu_virglrenderer_workaround, int, 0400);
>
> +#ifdef CONFIG_TRACE_GPU_MEM
> +static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_device *vgdev,
> +                                             s64 delta)
> +{
> +       u64 total_mem = atomic64_add_return(delta, &vgdev->total_mem);
> +
> +       trace_gpu_mem_total(0, 0, total_mem);
> +}
> +#else
> +static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_device *, s64)
> +{
> +}
> +#endif
> +
>  int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev, uint32_t *resid)
>  {
>         if (virtio_gpu_virglrenderer_workaround) {
> @@ -104,6 +121,7 @@ static void virtio_gpu_free_object(struct drm_gem_object *obj)
>         struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
>
>         if (bo->created) {
> +               virtio_gpu_trace_total_mem(vgdev, -(obj->size));
>                 virtio_gpu_cmd_unref_resource(vgdev, bo);
>                 virtio_gpu_notify(vgdev);
>                 /* completion handler calls virtio_gpu_cleanup_object() */
> @@ -265,6 +283,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>                 virtio_gpu_object_attach(vgdev, bo, ents, nents);
>         }
>
> +       virtio_gpu_trace_total_mem(vgdev, shmem_obj->base.size);
>         *bo_ptr = bo;
>         return 0;
>
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>

-CC android-kernel-team@google.com
+CC kernel-team@android.com
