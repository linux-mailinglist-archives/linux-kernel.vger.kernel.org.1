Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3862FD273
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390528AbhATOON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:14:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388367AbhATNfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611149632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TuZhxXX0vx11B3Qj3wPxkPeJCMw+rTZdku7noaOiFM4=;
        b=GKMmyI+p9ThyF7X9EgqSMqXqBQ/v+PHtnDbtyNeWDWBmohRdCTzQf2hK7yggOmvk8mUNVI
        jvpkWABH5qVU/y1M5fIV5SSmN3HTiTIrsDC9Xg6cArd0mc7RvHzHGfTGF7hB9Xpvr15yBc
        6cVsLLm5Q+HrUgiqIaPx5Vb2wvzFXZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-Cf47LavbMFGCejYLZROe5w-1; Wed, 20 Jan 2021 08:33:48 -0500
X-MC-Unique: Cf47LavbMFGCejYLZROe5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AF84107ACE3;
        Wed, 20 Jan 2021 13:33:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-182.ams2.redhat.com [10.36.112.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 857A610023B6;
        Wed, 20 Jan 2021 13:33:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id E6BAF18000B3; Wed, 20 Jan 2021 14:33:44 +0100 (CET)
Date:   Wed, 20 Jan 2021 14:33:44 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Yiwei Zhang <zzyiwei@android.com>
Cc:     David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2] drm/virtio: Track total GPU memory for virtio driver
Message-ID: <20210120133344.7kln44nbwb5rjjgu@sirius.home.kraxel.org>
References: <CAKB3++adfpdBHFEyGZ3v2V6zyW+ayg86CLDRKx1ty+OytjYFNw@mail.gmail.com>
 <20210118234057.270930-1-zzyiwei@android.com>
 <CAKMK7uE+7S5q8bU0ibyepb8yQL3QYNjZE+Jwf13+bVfAmoSuhw@mail.gmail.com>
 <CAKB3++aNtrjzFoq4icMWSUvXw7bL69FRM+9t69firXHkiuTwDQ@mail.gmail.com>
 <YAfzxS95Yy86qnBi@phenom.ffwll.local>
 <CAKB3++ZYacAN2ZVSGGm0uEDQtowcS9LDPPYCqt6Pj+-WEFxMSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKB3++ZYacAN2ZVSGGm0uEDQtowcS9LDPPYCqt6Pj+-WEFxMSQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > > > > +       select TRACE_GPU_MEM

> > > > > +#ifdef CONFIG_TRACE_GPU_MEM

That doesn't make sense btw.

> > > > > +#ifdef CONFIG_TRACE_GPU_MEM
> > > > > +static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_device *vgdev,
> > > > > +                                             s64 delta)
> > > > > +{
> > > > > +       u64 total_mem = atomic64_add_return(delta, &vgdev->total_mem);
> > > > > +
> > > > > +       trace_gpu_mem_total(0, 0, total_mem);

Hmm, so no per process tracking (pid arg hard-coded to zero)?
Any plans for that?
The cgroups patches mentioned by Daniel should address that btw.

The gpu_id is hardcoded to zero too.  Shouldn't that be something like
the minor number of the drm device?  Or maybe something else in case you
need drm and non-drm gpu devices work side-by-side?

> > > Thanks for your reply! Android Cuttlefish virtual platform is using
> > > the virtio-gpu driver, and we currently are carrying this small patch
> > > at the downstream side. This is essential for us because:
> > > (1) Android has deprecated debugfs on production devices already

IIRC there have been discussions about a statfs, so you can export stats
with a sane interface without also enabling all the power provided by
debugfs, exactly because of the concerns to do that on production
systems.

Not sure what the state is, seems to not be upstream yet.  That would be
(beside cgroups) another thing to look at.

> > > Android relies on this tracepoint + eBPF to make the GPU memory totals
> > > available at runtime on production devices, which has been enforced
> > > already. Not only game developers can have a reliable kernel total GPU
> > > memory to look at, but also Android leverages this to take GPU memory
> > > usage out from the system lost ram.

Sounds like you define "gpu memory" as "system memory used to store gpu
data".  Is that correct?  What about device memory?

> > > I'm not sure whether the other DRM drivers would like to integrate
> > > this tracepoint(maybe upstream drivers will move away from debugfs
> > > later as well?), but at least we hope virtio-gpu can take this.

Well, it is basically the same for all drivers using the gem shmem
helpers.  So I see little reason why we should do that at virtio-gpu
level.

> Android GPU vendors have integrated this tracepoint to track gpu
> memory usage total(mapped into the gpu address space), which consists
> of below:
> (1) directly allocated via physical page allocator
> (2) imported external memory backed by dma-bufs
> (3) allocated exportable memory backed by dma-bufs

Hmm, the tracepoint doesn't track which of the three groups the memory
belongs to.  Which I think is important, specifically group (2) because
that might already be accounted for by the exporting driver ...

> Our Android kernel team is leading the other side of effort to help
> remove the dma-bufs overlap(those mapped into a gpu device) as a joint
> effort, so that we can accurately explain the memory usage of the
> entire Android system.

I suspect once you figured that you'll notice that this little hack is
rather incomplete.

> For virtio-gpu, since that's used by our reference platform
> Cuttlefish(Cloud Android), we have to integrate the same tracepoint as
> well to enforce the use of this tracepoint and the eBPF stuff built on
> top to support runtime query of gpu memory on production devices. For
> virtio-gpu at this moment, we only want to track GEM allocations since
> PRIME import is currently not supported/used in Cuttlefish. That's all
> we are doing in this small patch.

take care,
  Gerd

