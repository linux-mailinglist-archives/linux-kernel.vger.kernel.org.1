Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C3D2E09B8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 12:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgLVLcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 06:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgLVLcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 06:32:23 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE81C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 03:31:43 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o17so31220880lfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 03:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dktppCPPYMDKn4HOO01Dz0vwMPZoiSAvjPyH/cDbuxs=;
        b=KCGAbCNSCZqsh0bouzDx+e4SdfpeS2sEpYp+e+JcX50HpbmSNuBOisfejMHsiuXydD
         x3RaIE6VxrDWm5lbBzACSxu2qoOHstuBnunt33AszjmHk621Uo7Gf42PI0mYmJe2jHlz
         wzJeVzlCSKaIqSebn7GzqfttH4bVeWWosE9ZQDjB3Ks8b9/sl5+vPwcAOTKSHPKc9QNI
         0EFMED45qG9163hZu7spfwpAR0XOutzytX5A59ruf0MHxyeumAsHr1ymWg61GSRh48OQ
         PbI221ZHXDoSUU9shBxsfM83wyBp3FNQCuR9sPDIJJtNw5Jiie6TY1/Kht8fvrVvbdjB
         6eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dktppCPPYMDKn4HOO01Dz0vwMPZoiSAvjPyH/cDbuxs=;
        b=SXd45AHR0m14iizSj8ZOobdUuo8iZWRt4KKGAg0aejx2t2/coWtHIcFgb4UNF+SQAF
         I9CcvW5v2WoiL5fxyZ+VSxpC414ojawFiQXManXm4WNrHHdfcK69Sykhnkzg8nvStVEW
         YVQtzVZcRhG7vBf+byOYiSvqDVNMhi/Du/BtSk9brNwK+58kftgXZWhvVABdZ3nWja8a
         IfS6x8MoeXpMRLALaI3fJ4xw+xE4MAqxM/luZHnuMJ/Q0jxZoasPCVMISzI6bmpIr+oA
         W+oISBDWHUXdpSwPGIohm1l3+CnK29gCjxAOHbwhTDuGDthElB0qCGCj7bXuFYEWkK0m
         Xr6g==
X-Gm-Message-State: AOAM530ItG9EXyXbSGN7pSERFBfHy18kUpz4RCYag7KmCqGJGg87nlEX
        13LQq/YEB0rmgDSi/CYa5kO537jb/TQDW9NxrP3Axt7iYlU=
X-Google-Smtp-Source: ABdhPJz2RX/hH/l6q8Lu1P56grKew2x2adDu0FLbY8RKWdzQEwckfLp/pTFh9j2MvfDUWnBkxH2BqHfa4+kPCnD41ZU=
X-Received: by 2002:a05:6512:3238:: with SMTP id f24mr8589581lfe.29.1608636701577;
 Tue, 22 Dec 2020 03:31:41 -0800 (PST)
MIME-Version: 1.0
References: <20201221162519.GA22504@open-light-1.localdomain> <7bf0e895-52d6-9e2d-294b-980c33cf08e4@redhat.com>
In-Reply-To: <7bf0e895-52d6-9e2d-294b-980c33cf08e4@redhat.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Tue, 22 Dec 2020 19:31:29 +0800
Message-ID: <CA+2MQi89v=DZJZ7b-QaMsU2f42j4SRW47XcZvLtBj10YeqRGgQ@mail.gmail.com>
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

On Tue, Dec 22, 2020 at 4:47 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 21.12.20 17:25, Liang Li wrote:
> > The first version can be found at: https://lkml.org/lkml/2020/4/12/42
> >
> > Zero out the page content usually happens when allocating pages with
> > the flag of __GFP_ZERO, this is a time consuming operation, it makes
> > the population of a large vma area very slowly. This patch introduce
> > a new feature for zero out pages before page allocation, it can help
> > to speed up page allocation with __GFP_ZERO.
> >
> > My original intention for adding this feature is to shorten VM
> > creation time when SR-IOV devicde is attached, it works good and the
> > VM creation time is reduced by about 90%.
> >
> > Creating a VM [64G RAM, 32 CPUs] with GPU passthrough
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > QEMU use 4K pages, THP is off
> >                   round1      round2      round3
> > w/o this patch:    23.5s       24.7s       24.6s
> > w/ this patch:     10.2s       10.3s       11.2s
> >
> > QEMU use 4K pages, THP is on
> >                   round1      round2      round3
> > w/o this patch:    17.9s       14.8s       14.9s
> > w/ this patch:     1.9s        1.8s        1.9s
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >
>
> I am still not convinces that we want/need this for this (main) use
> case. Why can't we use huge pages for such use cases (that really care
> about VM creation time) and rather deal with pre-zeroing of huge pages
> instead?
>
> If possible, I'd like to avoid GFP_ZERO (for reasons already discussed).
>

Yes, for VM creation, we can simply use hugetlb for that, just like what
I have done in the other series 'mm: support free hugepage pre zero out'
I send the v2 because I think VM creation is just one example we can benefi=
t
from.

> > Obviously, it can do more than this. We can benefit from this feature
> > in the flowing case:
> >
> > Interactive sence
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Shorten application lunch time on desktop or mobile phone, it can help
> > to improve the user experience. Test shows on a
> > server [Intel(R) Xeon(R) CPU E5-2620 v3 @ 2.40GHz], zero out 1GB RAM by
> > the kernel will take about 200ms, while some mainly used application
> > like Firefox browser, Office will consume 100 ~ 300 MB RAM just after
> > launch, by pre zero out free pages, it means the application launch
> > time will be reduced about 20~60ms (can be visual sensed?). May be
> > we can make use of this feature to speed up the launch of Andorid APP
> > (I didn't do any test for Android).
>
> I am not really sure if you can actually visually sense a difference in
> your examples. Startup time of an application is not just memory
> allocation (page zeroing) time. It would be interesting of much of a
> difference this actually makes in practice. (e.g., firefox startup time
> etc.)

Yes, using Firefox and Office as an example seems not convincing, maybe a
large Game APP which consumes several GB of RAM is better.

> >
> > Virtulization
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Speed up VM creation and shorten guest boot time, especially for PCI
> > SR-IOV device passthrough scenario. Compared with some of the para
> > vitalization solutions, it is easy to deploy because it=E2=80=99s trans=
parent
> > to guest and can handle DMA properly in BIOS stage, while the para
> > virtualization solution can=E2=80=99t handle it well.
>
> What is the "para virtualization" approach you are talking about?

I refer two topic in the KVM forum 2020, the doc can give more details :
https://static.sched.com/hosted_files/kvmforum2020/48/coIOMMU.pdf
https://static.sched.com/hosted_files/kvmforum2020/51/The%20Practice%20Meth=
od%20to%20Speed%20Up%2010x%20Boot-up%20Time%20for%20Guest%20in%20Alibaba%20=
Cloud.pdf

and the flowing link is mine:
https://static.sched.com/hosted_files/kvmforum2020/90/Speed%20Up%20Creation=
%20of%20a%20VM%20With%20Passthrough%20GPU.pdf
>
> >
> > Improve guest performance when use VIRTIO_BALLOON_F_REPORTING for memor=
y
> > overcommit. The VIRTIO_BALLOON_F_REPORTING feature will report guest pa=
ge
> > to the VMM, VMM will unmap the corresponding host page for reclaim,
> > when guest allocate a page just reclaimed, host will allocate a new pag=
e
> > and zero it out for guest, in this case pre zero out free page will hel=
p
> > to speed up the proccess of fault in and reduce the performance impacti=
on.
>
> Such faults in the VMM are no different to other faults, when first
> accessing a page to be populated. Again, I wonder how much of a
> difference it actually makes.
>

I am not just referring to faults in the VMM, I mean the whole process
that handles guest page faults.
without VIRTIO_BALLOON_F_REPORTING, pages used by guests will be zero
out only once by host. With VIRTIO_BALLOON_F_REPORTING, free pages are
reclaimed by the host and may return to the host buddy
free list. When the pages are given back to the guest, the host kernel
needs to zero out it again. It means
with VIRTIO_BALLOON_F_REPORTING, guest memory performance will be
degraded for frequently
zero out operation on host side. The performance degradation will be
obvious for huge page case. Free
page pre zero out can help to make guest memory performance almost the
same as without
VIRTIO_BALLOON_F_REPORTING.

> >
> > Speed up kernel routine
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > This can=E2=80=99t be guaranteed because we don=E2=80=99t pre zero out =
all the free pages,
> > but is true for most case. It can help to speed up some important syste=
m
> > call just like fork, which will allocate zero pages for building page
> > table. And speed up the process of page fault, especially for huge page
> > fault. The POC of Hugetlb free page pre zero out has been done.
>
> Would be interesting to have an actual example with some numbers.

I will try to do some tests to get some numbers.

> >
> > Security
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > This is a weak version of "introduce init_on_alloc=3D1 and init_on_free=
=3D1
> > boot options", which zero out page in a asynchronous way. For users can=
't
> > tolerate the impaction of 'init_on_alloc=3D1' or 'init_on_free=3D1' bri=
ngs,
> > this feauture provide another choice.
> "we don=E2=80=99t pre zero out all the free pages" so this is of little a=
ctual use.

OK. It seems none of the reasons listed above is strong enough for
this feature, above all of them, which one is likely to become the
most strong one?  From the implementation, you will find it is
configurable, users don't want to use it can turn it off.  This is not
an option?

Thanks for your comments,  David.

Liang
