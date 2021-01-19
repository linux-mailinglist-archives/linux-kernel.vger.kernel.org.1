Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47242FB279
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 08:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbhASHHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 02:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbhASHEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 02:04:44 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A51C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 23:03:56 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id r189so10547717oih.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 23:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJfr3/AKEq2QADngtAYKe4AoRRhjmaDaH7m9gP7iKZk=;
        b=QTuZQk1jhavaArScLuX825QGN1+4u8iMeAhAGEf2hdFQElT6hBH3OAqp4GWM414T3x
         OhPOEAy1Kz4ZpI9WwoduNX7BOyU8O0lkt1T0VPwCR4IHdm7ulmCEgVs3HjF7Kuo9bVPU
         5zKNsh/v5pHUSHc8+qbV8FUIcMLMob2pq56xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJfr3/AKEq2QADngtAYKe4AoRRhjmaDaH7m9gP7iKZk=;
        b=m1zYUF/XJYuCuRqhAtg9JQuNx4MCvrPXv0FeziZn7NGNTmKJT9raattwJqvYUhSBAs
         25/LnVZ8fN4Z41U6Tmz4YjvnYR6xT/KYJ5di+0iJaKJFMlBK+NcM3+gttQEYzDr1Cbq7
         zDRkzjkf5TAP8nkbHkDu4iyrmno8aICvsWuUuWmQD5wIWeprjGqwpa4PQ9uFixX6sAGP
         1ID5//wcS2zmBPrWjhuzkC3r9QFrIiB9/vd8yKhY7PwSyD6rxP/edlwXQ1hMPFfttyMG
         Zg2OSBGni6EQaUG7jKVPc2yAPwcnli9hypNWYCanP5HROF37pwUu7ZKfazrSt/xkwc8w
         gj1w==
X-Gm-Message-State: AOAM530QrHfOE0crDL25/ZJ9PFIry1FeVzGW98l2uouDLsRYbSZzBViW
        Fk+F8hZz7IST8K1pivZqZykEAtk1kGENHTFJlibAVQ==
X-Google-Smtp-Source: ABdhPJwzWPH2WmifDkmYPSJv8qrdqWCijQwai9Z73gYetT9ZosaVToylZDsq4xxrQohrbu5edGpgeFpegU9SJ40pzxU=
X-Received: by 2002:aca:ad92:: with SMTP id w140mr1708049oie.128.1611039835927;
 Mon, 18 Jan 2021 23:03:55 -0800 (PST)
MIME-Version: 1.0
References: <CAKB3++adfpdBHFEyGZ3v2V6zyW+ayg86CLDRKx1ty+OytjYFNw@mail.gmail.com>
 <20210118234057.270930-1-zzyiwei@android.com>
In-Reply-To: <20210118234057.270930-1-zzyiwei@android.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 19 Jan 2021 08:03:44 +0100
Message-ID: <CAKMK7uE+7S5q8bU0ibyepb8yQL3QYNjZE+Jwf13+bVfAmoSuhw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: Track total GPU memory for virtio driver
To:     Yiwei Zhang <zzyiwei@android.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 12:41 AM Yiwei Zhang <zzyiwei@android.com> wrote:
>
> On the success of virtio_gpu_object_create, add size of newly allocated
> bo to the tracled total_mem. In drm_gem_object_funcs.free, after the gem
> bo lost its last refcount, subtract the bo size from the tracked
> total_mem if the original underlying memory allocation is successful.
>
> Signed-off-by: Yiwei Zhang <zzyiwei@android.com>

Isn't this something that ideally we'd for everyone? Also tracepoint
for showing the total feels like tracepoint abuse, usually we show
totals somewhere in debugfs or similar, and tracepoint just for what's
happening (i.e. which object got deleted/created).

What is this for exactly?
-Daniel

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


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
