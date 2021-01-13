Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55622F41CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbhAMCbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbhAMCa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:30:59 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDE5C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:30:19 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h205so516188lfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pt5UETlRzxEfmCNnvTax6McqJSupC0kHJNd5M5Tk3YM=;
        b=TsRjhDJkIvx/eu/8Dfs4u/eA7XHGiCILe+X3MR73vyisdMsXXh5PtmdLED/GVKRM+1
         LWflHDw8pdNICFvV071XU8B6r5bQq/1VBUv+Ec3de3hTbcADu8hsQUglrP6RJcjXqNAA
         ojQ8dIj4rncwInw25v4xZFWxyiQ12aaKWhq88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pt5UETlRzxEfmCNnvTax6McqJSupC0kHJNd5M5Tk3YM=;
        b=pc7rynU5WXlwt84qvUy5ITW4C0OfDiu/M6E1HpApXDRa3NGc/GZhgAXRKnXtQ0JQEk
         phAt4suV85VQVfR29TaofRYmPFIaMDpZcX2X5LGOEOHG3PQh3z7AI5JuWVcvfYg1eM7v
         FNQtThm5AgpJ5dnojiNYOyNMGPTMoK0otnLNKzSiQKZ8UN53wTcRL2ZoecZKNKqtCdqE
         1F9hpMO2LFtwcHHhoEUvOH2X/3P/rTJtITD3x7Yq9uvEMKVHO9Wy9nnEHO/rzlGf+EOg
         X4bzKGw6Z6XL9JWyLpoHtNGprTIad7nkabHSNTzfFvq8vfTjPjWLrtkNkJbwqdRKY6Jh
         o/hA==
X-Gm-Message-State: AOAM531jo3+hTwzWGTpjyhVU3L2EQoS0j8jNAwT7Cd0qqtjUZ86R51aj
        uSyEcDC9bPwMjnqG90Imf2/OZQzccfS7UQ==
X-Google-Smtp-Source: ABdhPJygHQCBg5OiLmWeWRW6JQ32ur7QF6idHo+OLzbyI8CXuj06VAioibSfZqv5WCKeet7moLYU/Q==
X-Received: by 2002:a19:651a:: with SMTP id z26mr787246lfb.306.1610505017224;
        Tue, 12 Jan 2021 18:30:17 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id e15sm52178lfc.106.2021.01.12.18.30.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 18:30:16 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id o10so470530lfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:30:16 -0800 (PST)
X-Received: by 2002:adf:9b91:: with SMTP id d17mr94123wrc.32.1610505010644;
 Tue, 12 Jan 2021 18:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org> <d7043239-12cf-3636-4726-2e3b90917dc6@gmail.com>
 <CALiNf28sU1VtGB7LeTXExkMwQiCeg8N5arqyEjw0CPZP72R4dg@mail.gmail.com>
 <78871151-947d-b085-db03-0d0bd0b55632@gmail.com> <CALiNf29_PmLJTVLksSHp3NFAaL52idqehSMOtatJ=jaM2Muq1g@mail.gmail.com>
 <23a09b9a-70fc-a7a8-f3ea-b0bfa60507f0@gmail.com>
In-Reply-To: <23a09b9a-70fc-a7a8-f3ea-b0bfa60507f0@gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 13 Jan 2021 11:29:58 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DX=AdaYSYQbxgnrYYojkM5q7EE_Qs-BYPOiNjcQWbN1A@mail.gmail.com>
Message-ID: <CAAFQd5DX=AdaYSYQbxgnrYYojkM5q7EE_Qs-BYPOiNjcQWbN1A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/6] Restricted DMA
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Claire Chang <tientzu@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, grant.likely@arm.com,
        xypron.glpk@gmx.de, Thierry Reding <treding@nvidia.com>,
        mingo@kernel.org, bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Wed, Jan 13, 2021 at 3:01 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 1/11/21 11:48 PM, Claire Chang wrote:
> > On Fri, Jan 8, 2021 at 1:59 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >> On 1/7/21 9:42 AM, Claire Chang wrote:
> >>
> >>>> Can you explain how ATF gets involved and to what extent it does help,
> >>>> besides enforcing a secure region from the ARM CPU's perpsective? Does
> >>>> the PCIe root complex not have an IOMMU but can somehow be denied access
> >>>> to a region that is marked NS=0 in the ARM CPU's MMU? If so, that is
> >>>> still some sort of basic protection that the HW enforces, right?
> >>>
> >>> We need the ATF support for memory MPU (memory protection unit).
> >>> Restricted DMA (with reserved-memory in dts) makes sure the predefined memory
> >>> region is for PCIe DMA only, but we still need MPU to locks down PCIe access to
> >>> that specific regions.
> >>
> >> OK so you do have a protection unit of some sort to enforce which region
> >> in DRAM the PCIE bridge is allowed to access, that makes sense,
> >> otherwise the restricted DMA region would only be a hint but nothing you
> >> can really enforce. This is almost entirely analogous to our systems then.
> >
> > Here is the example of setting the MPU:
> > https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8183/drivers/emi_mpu/emi_mpu.c#L132
> >
> >>
> >> There may be some value in standardizing on an ARM SMCCC call then since
> >> you already support two different SoC vendors.
> >>
> >>>
> >>>>
> >>>> On Broadcom STB SoCs we have had something similar for a while however
> >>>> and while we don't have an IOMMU for the PCIe bridge, we do have a a
> >>>> basic protection mechanism whereby we can configure a region in DRAM to
> >>>> be PCIe read/write and CPU read/write which then gets used as the PCIe
> >>>> inbound region for the PCIe EP. By default the PCIe bridge is not
> >>>> allowed access to DRAM so we must call into a security agent to allow
> >>>> the PCIe bridge to access the designated DRAM region.
> >>>>
> >>>> We have done this using a private CMA area region assigned via Device
> >>>> Tree, assigned with a and requiring the PCIe EP driver to use
> >>>> dma_alloc_from_contiguous() in order to allocate from this device
> >>>> private CMA area. The only drawback with that approach is that it
> >>>> requires knowing how much memory you need up front for buffers and DMA
> >>>> descriptors that the PCIe EP will need to process. The problem is that
> >>>> it requires driver modifications and that does not scale over the number
> >>>> of PCIe EP drivers, some we absolutely do not control, but there is no
> >>>> need to bounce buffer. Your approach scales better across PCIe EP
> >>>> drivers however it does require bounce buffering which could be a
> >>>> performance hit.
> >>>
> >>> Only the streaming DMA (map/unmap) needs bounce buffering.
> >>
> >> True, and typically only on transmit since you don't really control
> >> where the sk_buff are allocated from, right? On RX since you need to
> >> hand buffer addresses to the WLAN chip prior to DMA, you can allocate
> >> them from a pool that already falls within the restricted DMA region, right?
> >>
> >
> > Right, but applying bounce buffering to RX will make it more secure.
> > The device won't be able to modify the content after unmap. Just like what
> > iommu_unmap does.
>
> Sure, however the goals of using bounce buffering equally applies to RX
> and TX in that this is the only layer sitting between a stack (block,
> networking, USB, etc.) and the underlying device driver that scales well
> in order to massage a dma_addr_t to be within a particular physical range.
>
> There is however room for improvement if the drivers are willing to
> change their buffer allocation strategy. When you receive Wi-Fi frames
> you need to allocate buffers for the Wi-Fi device to DMA into, and that
> happens ahead of the DMA transfers by the Wi-Fi device. At buffer
> allocation time you could very well allocate these frames from the
> restricted DMA region without having to bounce buffer them since the
> host CPU is in control over where and when to DMA into.
>

That is, however, still a trade-off between saving that one copy and
protection from the DMA tampering with the packet contents when the
kernel is reading them. Notice how the copy effectively makes a
snapshot of the contents, guaranteeing that the kernel has a
consistent view of the packet, which is not true if the DMA could
modify the buffer contents in the middle of CPU accesses.

Best regards,
Tomasz

> The issue is that each network driver may implement its own buffer
> allocation strategy, some may simply call netdev_alloc_skb() which gives
> zero control over where the buffer comes from unless you play tricks
> with NUMA node allocations and somehow declare that your restricted DMA
> region is a different NUMA node. If the driver allocates pages and then
> attaches a SKB to that page using build_skb(), then you have much more
> control over where that page comes from, and this is where using a
> device private CMA are helps, because you can just do
> dma_alloc_from_contiguous() and that will ensure that the pages are
> coming from your specific CMA area.
>
> Few questions on the implementation:
>
> - is there any warning or error being printed if the restricted DMA
> region is outside of a device's DMA addressable range?
>
> - are there are any helpful statistics that could be shown to indicate
> that the restricted DMA region was sized too small, e.g.: that
> allocation of a DMA buffer failed because we ran out of space in the
> swiotlb pool?
>
> >
> >>> I also added alloc/free support in this series
> >>> (https://lore.kernel.org/patchwork/patch/1360995/), so dma_direct_alloc() will
> >>> try to allocate memory from the predefined memory region.
> >>>
> >>> As for the performance hit, it should be similar to the default swiotlb.
> >>> Here are my experiment results. Both SoCs lack IOMMU for PCIe.
> >>>
> >>> PCIe wifi vht80 throughput -
> >>>
> >>>   MTK SoC                  tcp_tx     tcp_rx    udp_tx   udp_rx
> >>>   w/o Restricted DMA  244.1     134.66   312.56   350.79
> >>>   w/ Restricted DMA    246.95   136.59   363.21   351.99
> >>>
> >>>   Rockchip SoC           tcp_tx     tcp_rx    udp_tx   udp_rx
> >>>   w/o Restricted DMA  237.87   133.86   288.28   361.88
> >>>   w/ Restricted DMA    256.01   130.95   292.28   353.19
> >>
> >> How come you get better throughput with restricted DMA? Is it because
> >> doing DMA to/from a contiguous region allows for better grouping of
> >> transactions from the DRAM controller's perspective somehow?
> >
> > I'm not sure, but actually, enabling the default swiotlb for wifi also helps the
> > throughput a little bit for me.
>
> OK, it would be interesting if you could get to the bottom of why
> performance does increase with swiotlb.
> --
> Florian
