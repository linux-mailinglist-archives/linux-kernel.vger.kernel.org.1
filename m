Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDA22D552F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387640AbgLJIQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733155AbgLJIQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:16:07 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870E3C061793
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 00:15:27 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id w3so4086897otp.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 00:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olWrAE9JSl9kyhmzpxdnQFXpcomh9eOZ+RfshA6M+Yw=;
        b=p6vfVBFEHoqspcfUNgn7sdgCPUwg36wBSjUfb4RLyJ5vULAwLKN8GmiD6e33Ac8VER
         FHjrYoCNFIe95KV0RX2o8nIfoYplxquDDBIrmfd7JKKvmFFKtM7pWvdbEurFdl0S+ixF
         a9WQ7JW4DjKNcbPrKFxaHPTaUsgn16vKzBa02kR0EjoU02V4pI6BZwvElTZfSnsE5U47
         FO9QCOfjziR2mf4UreXeSdxMFAqv2P08icJDjBfNGQoS1VkLg1peKe+fS9PJGTp6YjU4
         nnDn4b9KTTXh4iWvfxY5u22uy3SpZLdJHQwIhSObuqCNepIpcwc+QkYtjVkMO+J6fFF4
         xlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olWrAE9JSl9kyhmzpxdnQFXpcomh9eOZ+RfshA6M+Yw=;
        b=pYs188ZmZ3OCyaxvxs7oMfYPkesjfHzyUeW1wC6bXa40D7X5xDVexwpyYmcHrscDcU
         VcJDqcko0SSgYHZjxkYE5//7NSTetN/3QmADqNU2ZTGZxuO8TChxrHPoLcns6Fuf9G9/
         Jn7rgvhwu2CmVD1vaF/wqdanhe269yBEqyi9M6I5x29Xr6l5UxhyJWnVBVaToUGBCZjJ
         MzilGVCt/X69BaTFQPYY4AKpiTLnLVpwYbZuEszzIqsPYCRGwMyxDDPKpz30jNHTiBAn
         tOn8jwmhdlCm/zv7KM/Lh+peg35vvHP/h3XW7vApjko3CwdJpeQ3zZ6d48I+I51Agpqa
         3F/g==
X-Gm-Message-State: AOAM53265S5NpPIGShceZLkWa1DmzUN2b/FEwjDRoTJGFc6D4G3j5+ZT
        Ao4paD9boqLEpw1MLFWgHX/zrcvd+Tg4nhHn5nixog==
X-Google-Smtp-Source: ABdhPJzESi9phEemd0Mo7b+JZyuIKDL6cbPIDC8u/pLidmYe6NDQenscRoW5LI/oInq9snMQmz4nqWLuWYa3ePUC+pk=
X-Received: by 2002:a05:6830:1411:: with SMTP id v17mr1298573otp.352.1607588126592;
 Thu, 10 Dec 2020 00:15:26 -0800 (PST)
MIME-Version: 1.0
References: <20201117181935.3613581-1-minchan@kernel.org> <20201117181935.3613581-5-minchan@kernel.org>
 <CGME20201118030110epcas2p1105a09711ea2c123f19f413b32372764@epcas2p1.samsung.com>
 <CALAqxLWqDLHpOHNEayvhDjJeXjEk_uneH2=d9fy8M87EjKfReA@mail.gmail.com>
 <20201119011431.GA136599@KEI> <CALAqxLV=r-V6u8hq2fTmxq855nT7QPkkjyAYdPeZRkYPBi_CKg@mail.gmail.com>
 <X9Fjd+eSStUJskOV@google.com>
In-Reply-To: <X9Fjd+eSStUJskOV@google.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 10 Dec 2020 00:15:15 -0800
Message-ID: <CALAqxLWthd8bEDRMWmuOf8dOCW8=cFao9HBawKGuRhQZkdgXXw@mail.gmail.com>
Subject: Re: [PATCH 4/4] dma-heap: Devicetree binding for chunk heap
To:     Minchan Kim <minchan@kernel.org>
Cc:     Hyesoo Yu <hyesoo.yu@samsung.com>,
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
        <linaro-mm-sig@lists.linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 3:53 PM Minchan Kim <minchan@kernel.org> wrote:
> On Wed, Nov 18, 2020 at 07:19:07PM -0800, John Stultz wrote:
> > The CMA heap currently only registers the default CMA heap, as we
> > didn't want to expose all CMA regions and there's otherwise no way to
> > pick and choose.
>
> Yub.
>
> dma-buf really need a way to make exclusive CMA area. Otherwise, default
> CMA would be shared among drivers and introduce fragmentation easily
> since we couldn't control other drivers. In such aspect, I don't think
> current cma-heap works if userspace needs big memory chunk.

Yes, the default CMA region is not always optimal.

That's why I was hopeful for Kunihiko Hayashi's patch to allow for
exposing specific cma regions:
  https://lore.kernel.org/lkml/1594948208-4739-1-git-send-email-hayashi.kunihiko@socionext.com/

I think it would be a good solution, but all we need is *some* driver
which can be considered the primary user/owner of the cma region which
would then explicitly export it via the dmabuf heaps.

> Here, the problem is there is no in-kernel user to bind the specific
> CMA area because the owner will be random in userspace via dma-buf
> interface.

Well, while I agree that conceptually the dmabuf heaps allow for
allocations for multi-device pipelines, and thus are not tied to
specific devices. I do think that the memory types exposed are likely
to have specific devices/drivers in the pipeline that it matters most
to. So I don't see a big issue with the in-kernel driver registering a
specific CMA region as a dmabuf heap.

> > > Is there a reason to use dma-heap framework to add cma-area for specific device ?
> > >
> > > Even if some in-tree users register dma-heap with cma-area, the buffers could be allocated in user-land and these could be shared among other devices.
> > > For exclusive access, I guess, the device don't need to register dma-heap for cma area.
> > >
> >
> > It's not really about exclusive access. More just that if you want to
> > bind a memory reservation/region (cma or otherwise), at least for DTS,
> > it needs to bind with some device in DT.
> >
> > Then the device driver can register that region with a heap driver.
> > This avoids adding new Linux-specific software bindings to DT. It
> > becomes a driver implementation detail instead. The primary user of
> > the heap type would probably be a practical pick (ie the display or
> > isp driver).
>
> If it's the only solution, we could create some dummy driver which has
> only module_init and bind it from there but I don't think it's a good
> idea.

Yea, an un-upstreamable dummy driver is maybe what it devolves to in
the worst case. But I suspect it would be cleaner for a display or ISP
driver that benefits most from the heap type to add the reserved
memory reference to their DT node, and on init for them to register
the region with the dmabuf heap code.


> > The other potential solution Rob has suggested is that we create some
> > tag for the memory reservation (ie: like we do with cma: "reusable"),
> > which can be used to register the region to a heap. But this has the
> > problem that each tag has to be well defined and map to a known heap.
>
> Do you think that's the only solution to make progress for this feature?
> Then, could you elaborate it a bit more or any other ideas from dma-buf
> folks?

I'm skeptical of that DT tag approach working out, as we'd need a new
DT binding for the new tag name, and we'd have to do so for each new
heap type that needs this (so non-default cma, your chunk heap,
whatever other similar heap types that use reserved regions folks come
up with).  Having *some* driver take ownership for the reserved region
and register it with the appropriate heap type seems much
cleaner/flexible and avoids mucking with the DT ABI.

thanks
-john
