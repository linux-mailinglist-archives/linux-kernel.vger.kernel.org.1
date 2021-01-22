Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87242FFDC8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbhAVH7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbhAVH7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:59:14 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D17C061786
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 23:58:34 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id q9so4014462qkn.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 23:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LlnD7Zwth8kJl753Ww9WFQKiEwV5qtL3iOD2rycD9tA=;
        b=u4WEuEwO/1CKmHHMGX4MJ/0miWGn1+qvGeCtAWRuFR8Ia0p8WS68kV4SGcAnrMSqY5
         sCwks3YyAFHgbzVHmMx8ByINsANRc8IXaixQD4MpAIOtKlmUEqgP01m4pVXAFj22TLam
         j0MuCMZxld4VWgAeMWRdEV76PAYQkOLkTgUGYapklSsh2tDdCyYPTacDaGzJfqQHA0te
         GnHSdnkqB3f6+8gLirmFLrs0HpmcwBnjCx8iimf/zTb14CuiTufLdcId4sTrcOW4My0n
         Hv24bipUbjAmrsRuBNezwPiWb3/3GBVDW/vaj202yjjpiwp9CfFsKsGNBzXA9C/BrxD4
         LYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LlnD7Zwth8kJl753Ww9WFQKiEwV5qtL3iOD2rycD9tA=;
        b=WUHzYm1/Z4FZJioIdadxk6qakoEkH/HEmddwv0Y5viDWDlCL5aA6uUxriV2Vq744Gt
         yotLBJMH5zynMTz5cOXBDSpFpuvSdQGygovH6pQhzfhJfTCGIkxCXXJ9ol3LNs3JW916
         IQYZeesrzwTPc3Sv0ycHw4p59jh/PRPSgjuE+n1CbdDHpqmNQNO+0QwBOw6XWNV0O8QB
         xOQLu+SLtYfc/lyuFCMiaE3y2WwLEIIhzzZNsXXDfBoJxTgJlrnfgkmDtR10yqbCUkVQ
         R1u5mOtUWLZo6UUR7C+AmojAil+V0hPQb86wvAIdLchbIv+4iw0YyMa+63kvyADt4q2Z
         L8WQ==
X-Gm-Message-State: AOAM531Lz1ai5YKImNcL+5p/a0rBOFBXG27N0b5HeCwtS4OG6CY836Cp
        tKRvmwCeh7y5bOTpK03b/QFPE09TyL0i2qqdBUtmrb6+pA1QAPtN
X-Google-Smtp-Source: ABdhPJzFcCeg4URy8hQIO6n6N8vcypHwKE9xDwf10IPfxm54qBxw3QFlquRMI+KZRoFUBwYtR1hIxDUtZJ28l4yfFyk=
X-Received: by 2002:a05:620a:21db:: with SMTP id h27mr3687267qka.121.1611302312854;
 Thu, 21 Jan 2021 23:58:32 -0800 (PST)
MIME-Version: 1.0
References: <20210122053159.1720274-1-zzyiwei@android.com> <20210122054011.1722954-1-zzyiwei@android.com>
In-Reply-To: <20210122054011.1722954-1-zzyiwei@android.com>
From:   =?UTF-8?B?WWl3ZWkgWmhhbmfigI4=?= <zzyiwei@android.com>
Date:   Thu, 21 Jan 2021 23:58:22 -0800
Message-ID: <CAKB3++bLzn5YVaR3iUTHtNYwBeG6Z27NjtWZ1q-xmjOkApAQwg@mail.gmail.com>
Subject: Re: [PATCH v4] drm/virtio: Track total GPU memory for virtio driver
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 9:40 PM Yiwei Zhang <zzyiwei@android.com> wrote:
>
> On the success of virtio_gpu_object_create, add size of newly allocated
> bo to the tracked total_mem. In drm_gem_object_funcs.free, after the gem
> bo loses its last refcount, subtract the bo size from the tracked
> total_mem if the original underlying memory allocation is successful.
>
> It's more accurate to do this in device driver layer to best match when
> the underlying resource gets allocated and destroyed during tracing.
>
> Signed-off-by: Yiwei Zhang <zzyiwei@android.com>
> ---
>  drivers/gpu/drm/virtio/Kconfig          |  1 +
>  drivers/gpu/drm/virtio/virtgpu_drv.h    |  2 ++
>  drivers/gpu/drm/virtio/virtgpu_object.c | 11 +++++++++++
>  3 files changed, 14 insertions(+)
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
> index 6a232553c99b..c5622f9b591f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -249,6 +249,8 @@ struct virtio_gpu_device {
>         spinlock_t resource_export_lock;
>         /* protects map state and host_visible_mm */
>         spinlock_t host_visible_lock;
> +
> +       atomic64_t total_mem;
>  };
>
>  struct virtio_gpu_fpriv {
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index d69a5b6da553..e2251fc41509 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -25,12 +25,21 @@
>
>  #include <linux/dma-mapping.h>
>  #include <linux/moduleparam.h>
> +#include <trace/events/gpu_mem.h>
>
>  #include "virtgpu_drv.h"
>
>  static int virtio_gpu_virglrenderer_workaround = 1;
>  module_param_named(virglhack, virtio_gpu_virglrenderer_workaround, int, 0400);
>
> +static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_device *vgdev,
> +                                             s64 delta)
> +{
> +       u64 total_mem = atomic64_add_return(delta, &vgdev->total_mem);
> +
> +       trace_gpu_mem_total(vgdev->ddev->primary->index, 0, total_mem);
> +}
> +
>  int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev, uint32_t *resid)
>  {
>         if (virtio_gpu_virglrenderer_workaround) {
> @@ -104,6 +113,7 @@ static void virtio_gpu_free_object(struct drm_gem_object *obj)
>         struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
>
>         if (bo->created) {
> +               virtio_gpu_trace_total_mem(vgdev, -(obj->size));
>                 virtio_gpu_cmd_unref_resource(vgdev, bo);
>                 virtio_gpu_notify(vgdev);
>                 /* completion handler calls virtio_gpu_cleanup_object() */
> @@ -265,6 +275,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>                 virtio_gpu_object_attach(vgdev, bo, ents, nents);
>         }
>
> +       virtio_gpu_trace_total_mem(vgdev, shmem_obj->base.size);
>         *bo_ptr = bo;
>         return 0;
>
> --
> 2.30.0.280.ga3ce27912f-goog
>

Re Gerd and Daniel:

I'm not sure why we want to couple this patch too much with the
dma-bufs tracking. The tracepoint added here itself is pretty useful
for tracking gem bo total usage in virtio gpu upon tracing. The
original purpose for integrating this tracepoint in all Android gpu
kernel drivers is to just track total gpu memory usage and serve the
accurate data to game developers in a much easier way. It's something
they can rely on for robust testing and regression monitoring.

The only overlap with the dma-buf side is when we export a bo via
prime to a dma-buf. But still, the total here is already useful for
this particular device. Using which approach to account for the
overlap wouldn't block this small integration from my understanding.

Besides, there's no plan for adding per-process gem total tracking in
virtio-gpu at this moment. This patch should be light enough to carry
without worrying about tech debt I believe.

Many thanks!
Yiwei
