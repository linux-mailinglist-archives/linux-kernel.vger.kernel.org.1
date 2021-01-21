Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE0C2FE613
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbhAUJPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:15:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726123AbhAUJLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611220221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D1kcGlOMSwavSnP0eXUEZoq8M6+Ra7+wQw7QLTpKYvw=;
        b=QZibtuM/iRu0ItfP6ZwbZhDDEnV4pSPjduRJMmbVEAzt5fSMsk/bByXB/MvpJGu69/nJxh
        iOx9/EFjS59fUnw266uVxz6AZRHJe894eFLuDln0P8TQVdZldB2aozK6F4AijijV/mGKwh
        7UL0DvlOYPIbUapjplXq5jXDMNMB9BI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-8VFkhlzHOPGuQIw531T11Q-1; Thu, 21 Jan 2021 04:10:17 -0500
X-MC-Unique: 8VFkhlzHOPGuQIw531T11Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07D338144E0;
        Thu, 21 Jan 2021 09:10:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-182.ams2.redhat.com [10.36.112.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6A5B6A8E4;
        Thu, 21 Jan 2021 09:10:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2084518000A0; Thu, 21 Jan 2021 10:10:13 +0100 (CET)
Date:   Thu, 21 Jan 2021 10:10:13 +0100
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
Message-ID: <20210121091013.wlqyukat2w7fow33@sirius.home.kraxel.org>
References: <CAKB3++adfpdBHFEyGZ3v2V6zyW+ayg86CLDRKx1ty+OytjYFNw@mail.gmail.com>
 <20210118234057.270930-1-zzyiwei@android.com>
 <CAKMK7uE+7S5q8bU0ibyepb8yQL3QYNjZE+Jwf13+bVfAmoSuhw@mail.gmail.com>
 <CAKB3++aNtrjzFoq4icMWSUvXw7bL69FRM+9t69firXHkiuTwDQ@mail.gmail.com>
 <YAfzxS95Yy86qnBi@phenom.ffwll.local>
 <CAKB3++ZYacAN2ZVSGGm0uEDQtowcS9LDPPYCqt6Pj+-WEFxMSQ@mail.gmail.com>
 <20210120133344.7kln44nbwb5rjjgu@sirius.home.kraxel.org>
 <CAKB3++YQtx3odtt+dOHCgNusccsXt5yjeZqD4KzfiuusT=pWZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKB3++YQtx3odtt+dOHCgNusccsXt5yjeZqD4KzfiuusT=pWZQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 10:52:11AM -0800, Yiwei Zhang wrote:
> On Wed, Jan 20, 2021 at 5:33 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> >   Hi,
> >
> > > > > > > +       select TRACE_GPU_MEM
> >
> > > > > > > +#ifdef CONFIG_TRACE_GPU_MEM
> >
> > That doesn't make sense btw.
> 
> Do you recommend we just select it or leave it an option?

The patch selects it (which makes sense given the small size).
The #ifdef is pointless then ...

> > > > > > > +#ifdef CONFIG_TRACE_GPU_MEM
> > > > > > > +static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_device *vgdev,
> > > > > > > +                                             s64 delta)
> > > > > > > +{
> > > > > > > +       u64 total_mem = atomic64_add_return(delta, &vgdev->total_mem);
> > > > > > > +
> > > > > > > +       trace_gpu_mem_total(0, 0, total_mem);
> >
> > Hmm, so no per process tracking (pid arg hard-coded to zero)?
> > Any plans for that?
> > The cgroups patches mentioned by Daniel should address that btw.
> 
> Android GPU vendors do report the totals for each process as well. For
> Cuttlefish virtual platform, we haven't yet required that, and want to
> get the global total in place first.

That means no plans yet?

> > > > > Android relies on this tracepoint + eBPF to make the GPU memory totals
> > > > > available at runtime on production devices, which has been enforced
> > > > > already. Not only game developers can have a reliable kernel total GPU
> > > > > memory to look at, but also Android leverages this to take GPU memory
> > > > > usage out from the system lost ram.
> >
> > Sounds like you define "gpu memory" as "system memory used to store gpu
> > data".  Is that correct?  What about device memory?
> 
> The total definition does include all device memory being used as well
> for numa devices.(If my understanding of your question is correct.)

device memory == gpu-owned memory, typically exposed to as pci memory bar.

qemu stdvga for example stores gem objects in device memory (unless it
runs out of vram, then ttm allocates from / moves into main memory).

> > > > > I'm not sure whether the other DRM drivers would like to integrate
> > > > > this tracepoint(maybe upstream drivers will move away from debugfs
> > > > > later as well?), but at least we hope virtio-gpu can take this.
> >
> > Well, it is basically the same for all drivers using the gem shmem
> > helpers.  So I see little reason why we should do that at virtio-gpu
> > level.
> 
> This can be a starting point. Another reason would be I'm fearing that
> this tracepoint approach might be more difficult to get upstreamed at
> drm layer level, since later we may want to get to per-process total
> tracking, which would be making more sense at device driver level.

Tracking in __drm_gem_shmem_create + drm_gem_shmem_free_object should
give you pretty much the same results, with the major difference being
that it works for all shmem-based drivers.

Of course just moving the trace points doesn't solve the other issues
discussed.

> > > Android GPU vendors have integrated this tracepoint to track gpu
> > > memory usage total(mapped into the gpu address space), which consists
> > > of below:
> > > (1) directly allocated via physical page allocator
> > > (2) imported external memory backed by dma-bufs
> > > (3) allocated exportable memory backed by dma-bufs
> >
> > Hmm, the tracepoint doesn't track which of the three groups the memory
> > belongs to.  Which I think is important, specifically group (2) because
> > that might already be accounted for by the exporting driver ...
> 
> The tracepoint only cares about a total number, but I'm not against
> the idea to extend the tracepoint with categorization. However, I
> believe the dma-bufs core can track which dma-buf gets attached/mapped
> to some devices. So that those overlap between dma-buf heaps and the
> gpu memory total we are tracking here can be canceled out.

Yep, maybe.  Which is *exactly* why Daniel keeps asking for the big
picture and how this integrates/interacts with the dma-buf accounting
which seems to be in the works too.

Note that dma-bufs are not only used for cross-device sharing.  They are
also used to pass handles from one application to another (application
to wayland compositor or x server for example).  Which doesn't matter
much for the totals, but for per-process accounting you need a plan how
to account these shared buffers.

> > I suspect once you figured that you'll notice that this little hack is
> > rather incomplete.
> 
> Despite the dma-buf side effort, we still wish to have this tracepoint
> integrated in virtio-gpu just for a global total at this moment.

I don't feel like merging patches with obvious shortcomings which have
a high chance to end up as technical dept.

The question how this interacts with dma-buf accounting must be
clarified.

I'd also suggest to join forces with the cgroups people.  The problem
space has alot of overlap.  Even if we end up with multiple ways to
export the accounting data the spots you have to hook into to actually
do the accounting should be largely identical.

take care,
  Gerd

