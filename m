Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD0D2E0B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 15:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgLVOBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 09:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgLVOBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:01:52 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A92C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:01:11 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id l11so32264767lfg.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hI5vOGLTb6+d/ZiBGujMN42RTQ0cnMqktl558H/e2DE=;
        b=ULLYhOa+G6D2xLAi91PV7GcuH43KR/Vj6VD0unco1IU9a44FQy92CmCHJUIQS8sGub
         aQ/sLJ/a5ly/+/V+7KCkbXyCeJBISUZDUOxAfghZ3gclrtXWCorvN22+KXoHZFGuvXWC
         W+CW+1xtkFWUQuAMM191VB1S6NDzkn+fG/Yi4s9yaLqs6HB5X4ygBmnpN9tx6A5pwgDI
         ebWrTtJ86jvjFtVd5Qzh2nDxJAwHuSW6ti2gADY8HX9ehqgWdhpD+eYIzc3g3es0uwzM
         yFbjpfR/Vnh3fBeX7ld+5aCyB6J9+CTYTOnt+7WGfEF/yJ8vkmSirwhokzbRfP68pLHt
         9kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hI5vOGLTb6+d/ZiBGujMN42RTQ0cnMqktl558H/e2DE=;
        b=rCbri4YdHxJsOpvlQxB3iyJLwjVXdnPYwBNPufHzLb4eJ+r5OXY6N1Yv/VB1whD7ku
         9u/h0IB7VjwMa0aUQEW9wMelzolWZvYJlDGaWYnldZxfyG/vBJM+pQ/y9RQkt90ZYq1e
         EiUC9hCu2rDJl7SsNplYe+MjBP4ycu4AOv2mbsKXJRnP5mTVbcKyzruCLZWhhmfLLDXs
         h1kQIvBQUYdT+mDYWv4dbA0Z/qovfegr1VW545GhHHl4q0xg9xC05BFYtFW4q+xNSiy+
         cJXXDVZqUytQzy8JLm4iPLpfM1O1nlnc0TCsPCKmsRJcoCUdm0iOf2P5LcsELnHJEIB4
         VE1A==
X-Gm-Message-State: AOAM5325dwkhlzgc+vrwm2n6tijKIXUP+jL/txTDxYiPbtNqjdrCxNn7
        6V6n2zYrNGhw6Vu+Xp3ygo5PfJdCy7Gg/JpFbIQgrQ5QZ+UVng==
X-Google-Smtp-Source: ABdhPJzh49zs0ovSSN1JIwZGOGUUFsVpbNgHk7cOXudWZ790T2phedRcAZavLNNHZ16x5VoG8+QY4ysmFZ9yvBk/WWM=
X-Received: by 2002:a05:6512:1112:: with SMTP id l18mr8449686lfg.538.1608645669043;
 Tue, 22 Dec 2020 06:01:09 -0800 (PST)
MIME-Version: 1.0
References: <20201221162519.GA22504@open-light-1.localdomain>
 <7bf0e895-52d6-9e2d-294b-980c33cf08e4@redhat.com> <CA+2MQi89v=DZJZ7b-QaMsU2f42j4SRW47XcZvLtBj10YeqRGgQ@mail.gmail.com>
 <840ff69d-20d5-970a-1635-298000196f3e@redhat.com>
In-Reply-To: <840ff69d-20d5-970a-1635-298000196f3e@redhat.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Tue, 22 Dec 2020 22:00:56 +0800
Message-ID: <CA+2MQi87+N87x+gLuJPurst38AfFQhnc9eyHr8On55d1+WY5zQ@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://static.sched.com/hosted_files/kvmforum2020/51/The%20Practice%20Meth=
od%20to%20Speed%20Up%2010x%20Boot-up%20Time%20for%20Guest%20in%20Alibaba%20=
Cloud.pdf
> >
> > and the flowing link is mine:
> > https://static.sched.com/hosted_files/kvmforum2020/90/Speed%20Up%20Crea=
tion%20of%20a%20VM%20With%20Passthrough%20GPU.pdf
>
> Thanks for the pointers! I actually did watch your presentation.

You're welcome!  And thanks for your time! :)
> >>
> >>>
> >>> Improve guest performance when use VIRTIO_BALLOON_F_REPORTING for mem=
ory
> >>> overcommit. The VIRTIO_BALLOON_F_REPORTING feature will report guest =
page
> >>> to the VMM, VMM will unmap the corresponding host page for reclaim,
> >>> when guest allocate a page just reclaimed, host will allocate a new p=
age
> >>> and zero it out for guest, in this case pre zero out free page will h=
elp
> >>> to speed up the proccess of fault in and reduce the performance impac=
tion.
> >>
> >> Such faults in the VMM are no different to other faults, when first
> >> accessing a page to be populated. Again, I wonder how much of a
> >> difference it actually makes.
> >>
> >
> > I am not just referring to faults in the VMM, I mean the whole process
> > that handles guest page faults.
> > without VIRTIO_BALLOON_F_REPORTING, pages used by guests will be zero
> > out only once by host. With VIRTIO_BALLOON_F_REPORTING, free pages are
> > reclaimed by the host and may return to the host buddy
> > free list. When the pages are given back to the guest, the host kernel
> > needs to zero out it again. It means
> > with VIRTIO_BALLOON_F_REPORTING, guest memory performance will be
> > degraded for frequently
> > zero out operation on host side. The performance degradation will be
> > obvious for huge page case. Free
> > page pre zero out can help to make guest memory performance almost the
> > same as without
> > VIRTIO_BALLOON_F_REPORTING.
>
> Yes, what I am saying is that this fault handling is no different to
> ordinary faults when accessing a virtual memory location the first time
> and populating a page. The only difference is that it happens
> continuously, not only the first time we touch a page.
>
> And we might be able to improve handling in the hypervisor in the
> future. We have been discussing using MADV_FREE instead of MADV_DONTNEED
> in QEMU for handling free page reporting. Then, guest reported pages
> will only get reclaimed by the hypervisor when there is actual memory
> pressure in the hypervisor (e.g., when about to swap). And zeroing a
> page is an obvious improvement over going to swap. The price for zeroing
> pages has to be paid at one point.
>
> Also note that we've been discussing cache-related things already. If
> you zero out before giving the page to the guest, the page will already
> be in the cache - where the guest directly wants to access it.
>

OK, that's very reasonable and much better. Looking forward for your work.

> >>>
> >>> Security
> >>> =3D=3D=3D=3D=3D=3D=3D=3D
> >>> This is a weak version of "introduce init_on_alloc=3D1 and init_on_fr=
ee=3D1
> >>> boot options", which zero out page in a asynchronous way. For users c=
an't
> >>> tolerate the impaction of 'init_on_alloc=3D1' or 'init_on_free=3D1' b=
rings,
> >>> this feauture provide another choice.
> >> "we don=E2=80=99t pre zero out all the free pages" so this is of littl=
e actual use.
> >
> > OK. It seems none of the reasons listed above is strong enough for
>
> I was rather saying that for security it's of little use IMHO.
> Application/VM start up time might be improved by using huge pages (and
> pre-zeroing these). Free page reporting might be improved by using
> MADV_FREE instead of MADV_DONTNEED in the hypervisor.
>
> > this feature, above all of them, which one is likely to become the
> > most strong one?  From the implementation, you will find it is
> > configurable, users don't want to use it can turn it off.  This is not
> > an option?
>
> Well, we have to maintain the feature and sacrifice a page flag. For
> example, do we expect someone explicitly enabling the feature just to
> speed up startup time of an app that consumes a lot of memory? I highly
> doubt it.

In our production environment, there are three main applications have such
requirement, one is QEMU [creating a VM with SR-IOV passthrough device],
anther other two are DPDK related applications, DPDK OVS and SPDK vhost,
for best performance, they populate memory when starting up. For SPDK vhost=
,
we make use of the VHOST_USER_GET/SET_INFLIGHT_FD feature for
vhost 'live' upgrade, which is done by killing the old process and
starting a new
one with the new binary. In this case, we want the new process started as q=
uick
as possible to shorten the service downtime. We really enable this feature
to speed up startup time for them  :)

> I'd love to hear opinions of other people. (a lot of people are offline
> until beginning of January, including, well, actually me :) )

OK. I will wait some time for others' feedback. Happy holidays!

thanks!

Liang
