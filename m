Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A7D2FD12E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389768AbhATNNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbhATMiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:38:50 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00961C061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 04:38:09 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id d189so24813744oig.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 04:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cUvq+3j2UZsZMpqSR7hZFwIpt01vjr1BcAn5QPI98HI=;
        b=JVRsRUNObTpASX4m1samBC1mklhZy/jQS2Omjrbh3aPUgrmW/63lHzLRHRqFip9OYI
         1bhPk86QOLo9KEGMI61x5hBjdnmBd1UQ6H1RjTadiLLz1b5aObuyok2rCgLLcas2gI6y
         YRVrgt1aZN9mOeIP+9/M1PYwW1LgWQrKbAsdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cUvq+3j2UZsZMpqSR7hZFwIpt01vjr1BcAn5QPI98HI=;
        b=Q/EM32LvVolM0PHUwc5ZY8jrf0kkI7P/dhso8Otapl8gaDdLjofcHiiWYCNxzbqwAt
         goO9YqO5GaIvnsb4yeKwm6uH4lLg5dgRAwd8fQuYYB7QNRVrIa639KmL9zQgpCo5KPKo
         XCHvTKzbf8tAocVGIvj0AMuBNHHAveOtGW3qPaCgc3bJuqivmWfrfyR6y0R+bTO53kP0
         YwIdUfcaNoPDIVbmteS/eOE9Z/0iQtFkbqAYu/mfGGP03d/L6DtYT60JPAvWYcR+LUD0
         6DVr6aNEe1aPnH4dgtGLeNaLNCFC3UDb6txjZI6d1vFn688O042VQ0eaUmzjGKx59DTx
         xl0A==
X-Gm-Message-State: AOAM533HIsZExRurOcdk8GXBmjAI1pdMpeLu9pS3q6numUCLtXSiLn9S
        Q5nhVYlDtlk/d9bctrdl/U87+8izdivyDtX/Pj9y1A==
X-Google-Smtp-Source: ABdhPJyLEhvQVDZvawZb4fB5BWgVVbsvjXs0uZbHyF2fRaWuYnahTZBfwUesFW975l8pjFlccP3Tw3QDeGrbbX911GA=
X-Received: by 2002:aca:4ac5:: with SMTP id x188mr2636242oia.14.1611146289366;
 Wed, 20 Jan 2021 04:38:09 -0800 (PST)
MIME-Version: 1.0
References: <CAKB3++adfpdBHFEyGZ3v2V6zyW+ayg86CLDRKx1ty+OytjYFNw@mail.gmail.com>
 <20210118234057.270930-1-zzyiwei@android.com> <CAKMK7uE+7S5q8bU0ibyepb8yQL3QYNjZE+Jwf13+bVfAmoSuhw@mail.gmail.com>
 <CAKB3++aNtrjzFoq4icMWSUvXw7bL69FRM+9t69firXHkiuTwDQ@mail.gmail.com>
 <YAfzxS95Yy86qnBi@phenom.ffwll.local> <CAKB3++ZYacAN2ZVSGGm0uEDQtowcS9LDPPYCqt6Pj+-WEFxMSQ@mail.gmail.com>
In-Reply-To: <CAKB3++ZYacAN2ZVSGGm0uEDQtowcS9LDPPYCqt6Pj+-WEFxMSQ@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 20 Jan 2021 13:37:57 +0100
Message-ID: <CAKMK7uE3xF80AsJ1zGfSM-KTry=ikJ-S-Dn6nK8ZAvCSWw2FHQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: Track total GPU memory for virtio driver
To:     Yiwei Zhang <zzyiwei@android.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 10:51 AM Yiwei Zhang=E2=80=8E <zzyiwei@android.com>=
 wrote:
>
> On Wed, Jan 20, 2021 at 1:11 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Tue, Jan 19, 2021 at 11:08:12AM -0800, Yiwei Zhang wrote:
> > > On Mon, Jan 18, 2021 at 11:03 PM Daniel Vetter <daniel@ffwll.ch> wrot=
e:
> > > >
> > > > On Tue, Jan 19, 2021 at 12:41 AM Yiwei Zhang <zzyiwei@android.com> =
wrote:
> > > > >
> > > > > On the success of virtio_gpu_object_create, add size of newly all=
ocated
> > > > > bo to the tracled total_mem. In drm_gem_object_funcs.free, after =
the gem
> > > > > bo lost its last refcount, subtract the bo size from the tracked
> > > > > total_mem if the original underlying memory allocation is success=
ful.
> > > > >
> > > > > Signed-off-by: Yiwei Zhang <zzyiwei@android.com>
> > > >
> > > > Isn't this something that ideally we'd for everyone? Also tracepoin=
t
> > > > for showing the total feels like tracepoint abuse, usually we show
> > > > totals somewhere in debugfs or similar, and tracepoint just for wha=
t's
> > > > happening (i.e. which object got deleted/created).
> > > >
> > > > What is this for exactly?
> > > > -Daniel
> > > >
> > > > > ---
> > > > >  drivers/gpu/drm/virtio/Kconfig          |  1 +
> > > > >  drivers/gpu/drm/virtio/virtgpu_drv.h    |  4 ++++
> > > > >  drivers/gpu/drm/virtio/virtgpu_object.c | 19 +++++++++++++++++++
> > > > >  3 files changed, 24 insertions(+)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/vir=
tio/Kconfig
> > > > > index b925b8b1da16..e103b7e883b1 100644
> > > > > --- a/drivers/gpu/drm/virtio/Kconfig
> > > > > +++ b/drivers/gpu/drm/virtio/Kconfig
> > > > > @@ -5,6 +5,7 @@ config DRM_VIRTIO_GPU
> > > > >         select DRM_KMS_HELPER
> > > > >         select DRM_GEM_SHMEM_HELPER
> > > > >         select VIRTIO_DMA_SHARED_BUFFER
> > > > > +       select TRACE_GPU_MEM
> > > > >         help
> > > > >            This is the virtual GPU driver for virtio.  It can be =
used with
> > > > >            QEMU based VMMs (like KVM or Xen).
> > > > > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/d=
rm/virtio/virtgpu_drv.h
> > > > > index 6a232553c99b..7c60e7486bc4 100644
> > > > > --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> > > > > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > > > > @@ -249,6 +249,10 @@ struct virtio_gpu_device {
> > > > >         spinlock_t resource_export_lock;
> > > > >         /* protects map state and host_visible_mm */
> > > > >         spinlock_t host_visible_lock;
> > > > > +
> > > > > +#ifdef CONFIG_TRACE_GPU_MEM
> > > > > +       atomic64_t total_mem;
> > > > > +#endif
> > > > >  };
> > > > >
> > > > >  struct virtio_gpu_fpriv {
> > > > > diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gp=
u/drm/virtio/virtgpu_object.c
> > > > > index d69a5b6da553..1e16226cebbe 100644
> > > > > --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> > > > > +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> > > > > @@ -25,12 +25,29 @@
> > > > >
> > > > >  #include <linux/dma-mapping.h>
> > > > >  #include <linux/moduleparam.h>
> > > > > +#ifdef CONFIG_TRACE_GPU_MEM
> > > > > +#include <trace/events/gpu_mem.h>
> > > > > +#endif
> > > > >
> > > > >  #include "virtgpu_drv.h"
> > > > >
> > > > >  static int virtio_gpu_virglrenderer_workaround =3D 1;
> > > > >  module_param_named(virglhack, virtio_gpu_virglrenderer_workaroun=
d, int, 0400);
> > > > >
> > > > > +#ifdef CONFIG_TRACE_GPU_MEM
> > > > > +static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_=
device *vgdev,
> > > > > +                                             s64 delta)
> > > > > +{
> > > > > +       u64 total_mem =3D atomic64_add_return(delta, &vgdev->tota=
l_mem);
> > > > > +
> > > > > +       trace_gpu_mem_total(0, 0, total_mem);
> > > > > +}
> > > > > +#else
> > > > > +static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_=
device *, s64)
> > > > > +{
> > > > > +}
> > > > > +#endif
> > > > > +
> > > > >  int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev, =
uint32_t *resid)
> > > > >  {
> > > > >         if (virtio_gpu_virglrenderer_workaround) {
> > > > > @@ -104,6 +121,7 @@ static void virtio_gpu_free_object(struct drm=
_gem_object *obj)
> > > > >         struct virtio_gpu_device *vgdev =3D bo->base.base.dev->de=
v_private;
> > > > >
> > > > >         if (bo->created) {
> > > > > +               virtio_gpu_trace_total_mem(vgdev, -(obj->size));
> > > > >                 virtio_gpu_cmd_unref_resource(vgdev, bo);
> > > > >                 virtio_gpu_notify(vgdev);
> > > > >                 /* completion handler calls virtio_gpu_cleanup_ob=
ject() */
> > > > > @@ -265,6 +283,7 @@ int virtio_gpu_object_create(struct virtio_gp=
u_device *vgdev,
> > > > >                 virtio_gpu_object_attach(vgdev, bo, ents, nents);
> > > > >         }
> > > > >
> > > > > +       virtio_gpu_trace_total_mem(vgdev, shmem_obj->base.size);
> > > > >         *bo_ptr =3D bo;
> > > > >         return 0;
> > > > >
> > > > > --
> > > > > 2.30.0.284.gd98b1dd5eaa7-goog
> > > > >
> > > >
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch
> > >
> > > Thanks for your reply! Android Cuttlefish virtual platform is using
> > > the virtio-gpu driver, and we currently are carrying this small patch
> > > at the downstream side. This is essential for us because:
> > > (1) Android has deprecated debugfs on production devices already
> > > (2) Android GPU drivers are not DRM based, and this won't change in a
> > > short term.
> > >
> > > Android relies on this tracepoint + eBPF to make the GPU memory total=
s
> > > available at runtime on production devices, which has been enforced
> > > already. Not only game developers can have a reliable kernel total GP=
U
> > > memory to look at, but also Android leverages this to take GPU memory
> > > usage out from the system lost ram.
> > >
> > > I'm not sure whether the other DRM drivers would like to integrate
> > > this tracepoint(maybe upstream drivers will move away from debugfs
> > > later as well?), but at least we hope virtio-gpu can take this.
> >
> > There's already another proposal from Android people for tracking dma-b=
uf
> > (in dma-buf heaps/ion) usage. I think we need something which is overal=
l
> > integrated, otherwise we have a complete mess of partial solutions.
> >
> > Also there's work going on to add cgroups support to gpu drivers (pushe=
d
> > by amd and intel folks, latest rfc have been quite old), so that's anot=
her
> > proposal for gpu memory usage tracking.
> >
> > Also for upstream we need something which works with upstream gpu drive=
rs
> > (even if you don't end up using that in shipping products). So that's
> > another reason maybe why a quick hack in the virtio gpu driver isn't th=
e
> > best approach here.
> >
> > I guess a good approach would be if Android at least can get to somethi=
ng
> > unified (gpu driver, virtio-gpu, dma-buf heaps), and then we need to
> > figure out how to mesh that with the cgroups side somehow.
> >
> > Also note that at least on dma-buf we already have some other debug
> > features (for android), so an overall "how does this all fit together"
> > would be good.
> > -Daniel
> >
> > >
> > > Many thanks!
> > > Yiwei
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
>
> The entire story is to better explain Android system memory usage.
> They fit together so that the dma-bufs overlap can be removed.
>
> Android GPU vendors have integrated this tracepoint to track gpu
> memory usage total(mapped into the gpu address space), which consists
> of below:
> (1) directly allocated via physical page allocator
> (2) imported external memory backed by dma-bufs
> (3) allocated exportable memory backed by dma-bufs
>
> Our Android kernel team is leading the other side of effort to help
> remove the dma-bufs overlap(those mapped into a gpu device) as a joint
> effort, so that we can accurately explain the memory usage of the
> entire Android system.
>
> For virtio-gpu, since that's used by our reference platform
> Cuttlefish(Cloud Android), we have to integrate the same tracepoint as
> well to enforce the use of this tracepoint and the eBPF stuff built on
> top to support runtime query of gpu memory on production devices. For
> virtio-gpu at this moment, we only want to track GEM allocations since
> PRIME import is currently not supported/used in Cuttlefish. That's all
> we are doing in this small patch.

Ok if the plan is to have that as a hard requirement for android
across all android uapi drivers, then
- this needs to be done across all upstream drivers too (otherwise we
don't have that uapi)
- usual open source requirements for new uapi (but I don't think that
should be a problem, these parts of android are all open I think)
- figuring out the overlap with the dma-buf account, before we merge either

Otherwise I don't see how this can work and be backed with upstreams
"never break uapi" guarantee.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
