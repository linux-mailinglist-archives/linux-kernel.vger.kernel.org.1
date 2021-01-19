Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055D62FBFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404691AbhASTT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730676AbhASTJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:09:28 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBA0C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:08:24 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 19so22967806qkm.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3UvSSj7FihiEFVi0RGPwt1INmt76yzIjTycQHPLRAfM=;
        b=ZMtqNibv8mF11Vx2yC6cc6h8bkhNBMC4+hjLOJX2JbTYFfxgJfZz5nYhVAzGp6A1Xj
         z0+qyRYZW7ROj1Cg5sW+UQVmT+SnIc2USYejRzCJnTjtKYE8J3WQbzqVMZ5FiJFG97UG
         Ebp4OWPoetgrzq3ohwTgViRaiFNN089B4jIzhoYDgDQj9MpaAp4c7SrU+sDFAQ4fIZzM
         nsKREWlUBZ97nW4Lt0wyfKhKsyoqjALt6Fa2UgX9Wpmu1fZWjvoFhswoufeGIco9BJQy
         0xJq8ByhLV5IkW/MsFOYNTEvK7H52f1a9nFgVeJLPNrGfV5f5bNIW+xQXIsJDVToxzRc
         Gv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3UvSSj7FihiEFVi0RGPwt1INmt76yzIjTycQHPLRAfM=;
        b=gpTm2R8VMzE7TmRXjWBzQeG2gfKJjiU2gFdJO0x45L+0smJQWRZlOd0ZHyIYvyl1MX
         R1F0Tqsxb2gu6B9dYPfsH0fxEIjZYWUQzahXYO+vDCYUK3LS9Gv31zVG0D2affZAEBwU
         xYtWWbS8bKnfnVGXShkEV+jVi+DQRuwn8u48If8EkQ6HMlh0Is7aNGYldTz/kPcBUclE
         oQxUZ0oUaJsolu60ZWj98BEKtSKvQ1q9k1CmKeYBRyK0bzyWmK3+6yBDBr4ZWLRP4utz
         yTDYYcWm3Mh2ifIh8+LuOgRG/Xl/QR8e8zG7eX3TbXpWqawoHW7fcioKsazlFwJHUwf5
         6Wbw==
X-Gm-Message-State: AOAM531N/oSjQeR8LjSWy0mIfT3/bqnciYMCPD+NOJzpEkxwRporTEgD
        mvOrnFzuwktKqoxd+Z6kycbzhKh3fuHAFah9bZ32LSOkybcl1C22
X-Google-Smtp-Source: ABdhPJzuVOPoCj0aRbqV9LR8ha00BJ3589ff8a3Agw9tVpcuBaHbMvOz/1fsBmo5ODDdaDbnxDLmXvEav/ZmTtLOKsc=
X-Received: by 2002:a37:afc2:: with SMTP id y185mr5930151qke.499.1611083302926;
 Tue, 19 Jan 2021 11:08:22 -0800 (PST)
MIME-Version: 1.0
References: <CAKB3++adfpdBHFEyGZ3v2V6zyW+ayg86CLDRKx1ty+OytjYFNw@mail.gmail.com>
 <20210118234057.270930-1-zzyiwei@android.com> <CAKMK7uE+7S5q8bU0ibyepb8yQL3QYNjZE+Jwf13+bVfAmoSuhw@mail.gmail.com>
In-Reply-To: <CAKMK7uE+7S5q8bU0ibyepb8yQL3QYNjZE+Jwf13+bVfAmoSuhw@mail.gmail.com>
From:   =?UTF-8?B?WWl3ZWkgWmhhbmfigI4=?= <zzyiwei@android.com>
Date:   Tue, 19 Jan 2021 11:08:12 -0800
Message-ID: <CAKB3++aNtrjzFoq4icMWSUvXw7bL69FRM+9t69firXHkiuTwDQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: Track total GPU memory for virtio driver
To:     Daniel Vetter <daniel@ffwll.ch>
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

On Mon, Jan 18, 2021 at 11:03 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Jan 19, 2021 at 12:41 AM Yiwei Zhang <zzyiwei@android.com> wrote:
> >
> > On the success of virtio_gpu_object_create, add size of newly allocated
> > bo to the tracled total_mem. In drm_gem_object_funcs.free, after the gem
> > bo lost its last refcount, subtract the bo size from the tracked
> > total_mem if the original underlying memory allocation is successful.
> >
> > Signed-off-by: Yiwei Zhang <zzyiwei@android.com>
>
> Isn't this something that ideally we'd for everyone? Also tracepoint
> for showing the total feels like tracepoint abuse, usually we show
> totals somewhere in debugfs or similar, and tracepoint just for what's
> happening (i.e. which object got deleted/created).
>
> What is this for exactly?
> -Daniel
>
> > ---
> >  drivers/gpu/drm/virtio/Kconfig          |  1 +
> >  drivers/gpu/drm/virtio/virtgpu_drv.h    |  4 ++++
> >  drivers/gpu/drm/virtio/virtgpu_object.c | 19 +++++++++++++++++++
> >  3 files changed, 24 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
> > index b925b8b1da16..e103b7e883b1 100644
> > --- a/drivers/gpu/drm/virtio/Kconfig
> > +++ b/drivers/gpu/drm/virtio/Kconfig
> > @@ -5,6 +5,7 @@ config DRM_VIRTIO_GPU
> >         select DRM_KMS_HELPER
> >         select DRM_GEM_SHMEM_HELPER
> >         select VIRTIO_DMA_SHARED_BUFFER
> > +       select TRACE_GPU_MEM
> >         help
> >            This is the virtual GPU driver for virtio.  It can be used with
> >            QEMU based VMMs (like KVM or Xen).
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > index 6a232553c99b..7c60e7486bc4 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > @@ -249,6 +249,10 @@ struct virtio_gpu_device {
> >         spinlock_t resource_export_lock;
> >         /* protects map state and host_visible_mm */
> >         spinlock_t host_visible_lock;
> > +
> > +#ifdef CONFIG_TRACE_GPU_MEM
> > +       atomic64_t total_mem;
> > +#endif
> >  };
> >
> >  struct virtio_gpu_fpriv {
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> > index d69a5b6da553..1e16226cebbe 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> > @@ -25,12 +25,29 @@
> >
> >  #include <linux/dma-mapping.h>
> >  #include <linux/moduleparam.h>
> > +#ifdef CONFIG_TRACE_GPU_MEM
> > +#include <trace/events/gpu_mem.h>
> > +#endif
> >
> >  #include "virtgpu_drv.h"
> >
> >  static int virtio_gpu_virglrenderer_workaround = 1;
> >  module_param_named(virglhack, virtio_gpu_virglrenderer_workaround, int, 0400);
> >
> > +#ifdef CONFIG_TRACE_GPU_MEM
> > +static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_device *vgdev,
> > +                                             s64 delta)
> > +{
> > +       u64 total_mem = atomic64_add_return(delta, &vgdev->total_mem);
> > +
> > +       trace_gpu_mem_total(0, 0, total_mem);
> > +}
> > +#else
> > +static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_device *, s64)
> > +{
> > +}
> > +#endif
> > +
> >  int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev, uint32_t *resid)
> >  {
> >         if (virtio_gpu_virglrenderer_workaround) {
> > @@ -104,6 +121,7 @@ static void virtio_gpu_free_object(struct drm_gem_object *obj)
> >         struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
> >
> >         if (bo->created) {
> > +               virtio_gpu_trace_total_mem(vgdev, -(obj->size));
> >                 virtio_gpu_cmd_unref_resource(vgdev, bo);
> >                 virtio_gpu_notify(vgdev);
> >                 /* completion handler calls virtio_gpu_cleanup_object() */
> > @@ -265,6 +283,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
> >                 virtio_gpu_object_attach(vgdev, bo, ents, nents);
> >         }
> >
> > +       virtio_gpu_trace_total_mem(vgdev, shmem_obj->base.size);
> >         *bo_ptr = bo;
> >         return 0;
> >
> > --
> > 2.30.0.284.gd98b1dd5eaa7-goog
> >
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

Thanks for your reply! Android Cuttlefish virtual platform is using
the virtio-gpu driver, and we currently are carrying this small patch
at the downstream side. This is essential for us because:
(1) Android has deprecated debugfs on production devices already
(2) Android GPU drivers are not DRM based, and this won't change in a
short term.

Android relies on this tracepoint + eBPF to make the GPU memory totals
available at runtime on production devices, which has been enforced
already. Not only game developers can have a reliable kernel total GPU
memory to look at, but also Android leverages this to take GPU memory
usage out from the system lost ram.

I'm not sure whether the other DRM drivers would like to integrate
this tracepoint(maybe upstream drivers will move away from debugfs
later as well?), but at least we hope virtio-gpu can take this.

Many thanks!
Yiwei
