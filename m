Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25BE2B8A62
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 04:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgKSDTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 22:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgKSDTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 22:19:20 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D98C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 19:19:19 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id k26so4815293oiw.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 19:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2H1F3Ka0Ka6X1YRsJFJYW9O6FRzLC0ev/xiBm/ktwsY=;
        b=IyWxWBURU+L3lmO9KtVhwYIiuruSmn9ZlAcdweefmTY5hAECqpXAaF/Q6hROSqENTV
         rwiFeUc5CbI4nOCvIfKSE1SdCRTqL+TTTM7mnf9axLFoIti2sbuSrlqkxXkIHYOXe09F
         Po5URQbjzkMHe/gbBrO+p4j+MJqV3szMdw/7uIuFsmP/ZvfIcDnysACiLZkSy1RLIkVn
         FD9EsqbfamHxVSHAnQFe9NnluhjfSemN68nnDk4HSsiYw9ISIy+6jXCVQEmc1KQCov49
         QKdlaU8Jts+5w7P0Bpvn0eqdF9AgaGSrysflrv+tBrQn50EyIR6WKMR4HaJxHU8REJoU
         4jHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2H1F3Ka0Ka6X1YRsJFJYW9O6FRzLC0ev/xiBm/ktwsY=;
        b=owTC9qSpWm15q6ZpxNK0mzndtkFim/Hzq0QQRjxSSw5eq9nTMiwhRE5ArMsKYHxhmV
         2ZJAcm+zGQQcRy3BcMFlUaqLw5eDH1IKbPH1noCgnIyRXH9Pfox1G4R4dXs63rsmbTiD
         MaVIFgpMjYd/On6e73MfQUPrAiO7O/DTa0DGiOdD/Ao1lBg7P6IhxelX+5V/ljBaJffz
         QSzmMmqjEqTAmJr9hItx5Uavis31hu0U3JVT6ABwwY/qc+eJevE2oVOBthY4+7CgLUW/
         l6ZqBEqLRb0tuRFKdJxXDAOPyMGTmOLQNj1YoCebtnM8XL52IEXLpjScJ69v6qUQMaif
         KE1g==
X-Gm-Message-State: AOAM5305D2zaxz4nr0KA1K0A6p+mHacGZJ3OsOavFH6nV4eDfK3wBVCJ
        t5JEJunNTN/J3tmBToAClYFAp7Ne99b0ljerjmykHQ==
X-Google-Smtp-Source: ABdhPJwiWiMPc8ySQheAiJ+dOGvXYSSllZWJP6v01aEX68C0WjWv5jKCxWcHdCZq8zmoeaKI9163QlcRHy4zl2ArzSg=
X-Received: by 2002:a05:6808:4b:: with SMTP id v11mr1511116oic.169.1605755958902;
 Wed, 18 Nov 2020 19:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20201117181935.3613581-1-minchan@kernel.org> <20201117181935.3613581-5-minchan@kernel.org>
 <CGME20201118030110epcas2p1105a09711ea2c123f19f413b32372764@epcas2p1.samsung.com>
 <CALAqxLWqDLHpOHNEayvhDjJeXjEk_uneH2=d9fy8M87EjKfReA@mail.gmail.com> <20201119011431.GA136599@KEI>
In-Reply-To: <20201119011431.GA136599@KEI>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 18 Nov 2020 19:19:07 -0800
Message-ID: <CALAqxLV=r-V6u8hq2fTmxq855nT7QPkkjyAYdPeZRkYPBi_CKg@mail.gmail.com>
Subject: Re: [PATCH 4/4] dma-heap: Devicetree binding for chunk heap
To:     Hyesoo Yu <hyesoo.yu@samsung.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>, david@redhat.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        Suren Baghdasaryan <surenb@google.com>,
        KyongHo Cho <pullip.cho@samsung.com>,
        John Dias <joaodias@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 5:22 PM Hyesoo Yu <hyesoo.yu@samsung.com> wrote:
>
> On Tue, Nov 17, 2020 at 07:00:54PM -0800, John Stultz wrote:
> > So I suspect Rob will push back on this as he has for other dt
> > bindings related to ion/dmabuf heaps (I tried to push a similar
> > solution to exporting multiple CMA areas via dmabuf heaps).
> >
> > The proposal he seemed to like best was having an in-kernel function
> > that a driver would call to initialize the heap (associated with the
> > CMA region the driver is interested in). Similar to Kunihiko Hayashi's
> > patch here:
> >   - https://lore.kernel.org/lkml/1594948208-4739-1-git-send-email-hayashi.kunihiko@socionext.com/
> >
> > The one sticking point for that patch (which I think is a good one),
> > is that we don't have any in-tree users, so it couldn't be merged yet.
> >
> > A similar approach might be good here, but again we probably need to
> > have at least one in-tree user which could call such a registration
> > function.
>
> Thanks for your review.
>
> The chunk heap is not considered for device-specific reserved memory and specific driver.
> It is similar to system heap, but it only collects high-order pages by using specific cma-area for performance.

So, yes I agree, the chunk heap isn't device specific. It's just that
the CMA regions usually are tied to devices.

The main objection to this style of solution has been due to the fact
that the DTS is supposed to describe the physical hardware (in an OS
agnostic way), rather than define configuration info for Linux
software drivers.

Obviously this can be quibbled about, as the normal way of tying
devices to CMA has some assumptions of what the driver will use that
region for, rather than somehow representing a physical tie between a
memory reservation and a device. Nonetheless, Rob has been hesitant to
take any sort of ION/DmaBuf Heap DT devices, and has been more
interested in some device having the memory reservation reference and
the driver for that doing the registration.

> It is strange that there is in-tree user who registers chunk heap.
> (Wouldn't it be strange for some users to register the system heap?)

Well, as there's no reservation/configuration needed, the system heap
can register itself.

The CMA heap currently only registers the default CMA heap, as we
didn't want to expose all CMA regions and there's otherwise no way to
pick and choose.

> Is there a reason to use dma-heap framework to add cma-area for specific device ?
>
> Even if some in-tree users register dma-heap with cma-area, the buffers could be allocated in user-land and these could be shared among other devices.
> For exclusive access, I guess, the device don't need to register dma-heap for cma area.
>

It's not really about exclusive access. More just that if you want to
bind a memory reservation/region (cma or otherwise), at least for DTS,
it needs to bind with some device in DT.

Then the device driver can register that region with a heap driver.
This avoids adding new Linux-specific software bindings to DT. It
becomes a driver implementation detail instead. The primary user of
the heap type would probably be a practical pick (ie the display or
isp driver).

The other potential solution Rob has suggested is that we create some
tag for the memory reservation (ie: like we do with cma: "reusable"),
which can be used to register the region to a heap. But this has the
problem that each tag has to be well defined and map to a known heap.

thanks
-john
