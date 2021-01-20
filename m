Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15342FD945
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392132AbhATTPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390308AbhATSxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:53:03 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F3FC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:52:23 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id c7so26362813qke.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhIkOUZOblAQse4XwZNGgQU6EmoqDVg3Bv3cqMUh/Zo=;
        b=Nym5PwGod2FKWPmPFJWy/hjPATUevNi3u5U5TAkjW68d2ugCx78nh7rHrTIAR5+dVb
         NXJTlbCiXZngdUPQMKEPY7q7VUofNFjBezWYtibtG3AKrnKLiNMqkEg6hORmkaewj1HM
         FxJGbmzrFIY9CDGfmctoAlMb7wUIOtG0v7/9Z7TI1rZrA34fBFSlVXaqfrodRozY8yWA
         B5P85Kn/VchwIOS66hIvMRIELah5SE5WX6zAMhD0OgUP4gE9QEl9HVZsrHUF6FVy96P+
         EKqw4TWFM9w9EXmNjv/gUIrfesHONCxweQN3KFHU0KtoA322W9GNddsrWahYRJ7/XD9b
         INWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhIkOUZOblAQse4XwZNGgQU6EmoqDVg3Bv3cqMUh/Zo=;
        b=sNhd7J3/f3NominWhy/4KKt/KqjPqjZ34SB9hxqgQ/zPcfcGD/ZyhoJx3KDlMp+vNz
         nvsCvkhu4H+w0yMR+wc4J5ChZb7jrzGvVXd+6V8fXX+RDIwAjzN1ReAZmXNela3OgQZz
         lBsHkYZeA4LLmdeZSofbMGJb3aRS5dylJqCVk65yrOcwc2BIrKnUb1Z0pdqEpu4oRzBe
         QTjdFlS6Osue5D6X161yNSNM8uwHcmhvNtO0VpXWEMMn9VgGo6h3rjDOEJRaHt0PBAL9
         H69axdtI2dt64PI7uvMwAWYBZMar4GEM9+ycwkC0P+bE+6oNrMNeospppMuUaIQL+DdO
         Tv9g==
X-Gm-Message-State: AOAM532vjmZ34wKEGKQ15+0umvFdmxTWViPRdS6ecGyJDxNUB4i/+t4l
        EqoCEuf/fvkaPjFUv1/FRJ8oZA1i7DSHFmtZfv+rXOO1dM2+pg==
X-Google-Smtp-Source: ABdhPJwheheOeCGsCkOKJfzmnMPZ2ThRHl0+fcKmfDVHneAEPB3ntBn3Lfs2byWQCAFaAhSfCTOr0NxirOjfSwzhWYM=
X-Received: by 2002:a37:afc2:: with SMTP id y185mr11007194qke.499.1611168742396;
 Wed, 20 Jan 2021 10:52:22 -0800 (PST)
MIME-Version: 1.0
References: <CAKB3++adfpdBHFEyGZ3v2V6zyW+ayg86CLDRKx1ty+OytjYFNw@mail.gmail.com>
 <20210118234057.270930-1-zzyiwei@android.com> <CAKMK7uE+7S5q8bU0ibyepb8yQL3QYNjZE+Jwf13+bVfAmoSuhw@mail.gmail.com>
 <CAKB3++aNtrjzFoq4icMWSUvXw7bL69FRM+9t69firXHkiuTwDQ@mail.gmail.com>
 <YAfzxS95Yy86qnBi@phenom.ffwll.local> <CAKB3++ZYacAN2ZVSGGm0uEDQtowcS9LDPPYCqt6Pj+-WEFxMSQ@mail.gmail.com>
 <20210120133344.7kln44nbwb5rjjgu@sirius.home.kraxel.org>
In-Reply-To: <20210120133344.7kln44nbwb5rjjgu@sirius.home.kraxel.org>
From:   =?UTF-8?B?WWl3ZWkgWmhhbmfigI4=?= <zzyiwei@android.com>
Date:   Wed, 20 Jan 2021 10:52:11 -0800
Message-ID: <CAKB3++YQtx3odtt+dOHCgNusccsXt5yjeZqD4KzfiuusT=pWZQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: Track total GPU memory for virtio driver
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 5:33 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > > > > +       select TRACE_GPU_MEM
>
> > > > > > +#ifdef CONFIG_TRACE_GPU_MEM
>
> That doesn't make sense btw.

Do you recommend we just select it or leave it an option?

> > > > > > +#ifdef CONFIG_TRACE_GPU_MEM
> > > > > > +static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_device *vgdev,
> > > > > > +                                             s64 delta)
> > > > > > +{
> > > > > > +       u64 total_mem = atomic64_add_return(delta, &vgdev->total_mem);
> > > > > > +
> > > > > > +       trace_gpu_mem_total(0, 0, total_mem);
>
> Hmm, so no per process tracking (pid arg hard-coded to zero)?
> Any plans for that?
> The cgroups patches mentioned by Daniel should address that btw.

Android GPU vendors do report the totals for each process as well. For
Cuttlefish virtual platform, we haven't yet required that, and want to
get the global total in place first.

> The gpu_id is hardcoded to zero too.  Shouldn't that be something like
> the minor number of the drm device?  Or maybe something else in case you
> need drm and non-drm gpu devices work side-by-side?

For drm driver integration, I'd definitely vote for using the
primary->index. Non-drm gpu devices, if co-exists, need to avoid using
the duplicate id if possible(though there's no system wide id). I'll
send an update later.

> > > > Thanks for your reply! Android Cuttlefish virtual platform is using
> > > > the virtio-gpu driver, and we currently are carrying this small patch
> > > > at the downstream side. This is essential for us because:
> > > > (1) Android has deprecated debugfs on production devices already
>
> IIRC there have been discussions about a statfs, so you can export stats
> with a sane interface without also enabling all the power provided by
> debugfs, exactly because of the concerns to do that on production
> systems.
>
> Not sure what the state is, seems to not be upstream yet.  That would be
> (beside cgroups) another thing to look at.
>
> > > > Android relies on this tracepoint + eBPF to make the GPU memory totals
> > > > available at runtime on production devices, which has been enforced
> > > > already. Not only game developers can have a reliable kernel total GPU
> > > > memory to look at, but also Android leverages this to take GPU memory
> > > > usage out from the system lost ram.
>
> Sounds like you define "gpu memory" as "system memory used to store gpu
> data".  Is that correct?  What about device memory?

The total definition does include all device memory being used as well
for numa devices.(If my understanding of your question is correct.)

> > > > I'm not sure whether the other DRM drivers would like to integrate
> > > > this tracepoint(maybe upstream drivers will move away from debugfs
> > > > later as well?), but at least we hope virtio-gpu can take this.
>
> Well, it is basically the same for all drivers using the gem shmem
> helpers.  So I see little reason why we should do that at virtio-gpu
> level.

This can be a starting point. Another reason would be I'm fearing that
this tracepoint approach might be more difficult to get upstreamed at
drm layer level, since later we may want to get to per-process total
tracking, which would be making more sense at device driver level.

> > Android GPU vendors have integrated this tracepoint to track gpu
> > memory usage total(mapped into the gpu address space), which consists
> > of below:
> > (1) directly allocated via physical page allocator
> > (2) imported external memory backed by dma-bufs
> > (3) allocated exportable memory backed by dma-bufs
>
> Hmm, the tracepoint doesn't track which of the three groups the memory
> belongs to.  Which I think is important, specifically group (2) because
> that might already be accounted for by the exporting driver ...

The tracepoint only cares about a total number, but I'm not against
the idea to extend the tracepoint with categorization. However, I
believe the dma-bufs core can track which dma-buf gets attached/mapped
to some devices. So that those overlap between dma-buf heaps and the
gpu memory total we are tracking here can be canceled out.

> > Our Android kernel team is leading the other side of effort to help
> > remove the dma-bufs overlap(those mapped into a gpu device) as a joint
> > effort, so that we can accurately explain the memory usage of the
> > entire Android system.
>
> I suspect once you figured that you'll notice that this little hack is
> rather incomplete.

Despite the dma-buf side effort, we still wish to have this tracepoint
integrated in virtio-gpu just for a global total at this moment. So we
can have all enforcement in place for Android given the downstream
drivers are still not drm-based. Upon system tracing, event based
update via tracepoint is much more efficient and accurate than polling
the fs nodes(too much overhead on SeLinux).

> > For virtio-gpu, since that's used by our reference platform
> > Cuttlefish(Cloud Android), we have to integrate the same tracepoint as
> > well to enforce the use of this tracepoint and the eBPF stuff built on
> > top to support runtime query of gpu memory on production devices. For
> > virtio-gpu at this moment, we only want to track GEM allocations since
> > PRIME import is currently not supported/used in Cuttlefish. That's all
> > we are doing in this small patch.
>
> take care,
>   Gerd
>
