Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988592418C2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 11:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgHKJP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 05:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbgHKJPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 05:15:55 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C26DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 02:15:55 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id cq28so8345658edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 02:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2f83cAD6hLFggbL5wDPDL5CQAHmHJh2YdT/JjJ/mVTs=;
        b=QSOFbrhp895XEQx5jjd74TwEycV/CKZ8F8g9Yp+IPBMXFe64/SeDlUK6p7kDo6tYub
         XFKVZM6Ch41mSIIUb49sjVNrhZKZn+C3CTOO4jOW5OmGAeyefhiTQ3OHAhRxkGMozL8E
         oyxYYKpZHbcgCNMBjix491CUZLObcrZRiIdAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2f83cAD6hLFggbL5wDPDL5CQAHmHJh2YdT/JjJ/mVTs=;
        b=AiVnCFp/zuDloH91D7p7tcPN0Tzs7vEkeQafM/Ph1VYaWXTKSnzgtBA+DbfEwAEiF6
         uT2jCMXUkGaqx53+4WS30W/n1dhbojsSAU7+YdkfNYE2/3sxM4gRzm34dMVItoWBFh5K
         UwH9ZvcgtHQsL4bo063E8OOlcVih4QqNo6heLyXM2AkLWhmaH6vGx574yWs4kQpT417a
         6BrhOr/PgHhZq5+TjtsYNX+Lz/HLwD+a8qNOW/BoIl8x4e6htKss4scrlYXrPTgWosce
         M4n/T5T2GG1uF06pxOwTc2fa2XRput8ndiFwYg8rLzqCf43cqSp3NClAxxN8/chdHdYW
         3hCg==
X-Gm-Message-State: AOAM531PBvmq5CW4GCTNz+71DyVDc8iMBnpEeEwcAzzJleiL2dlJad5D
        wfVr2YKIrOxvgwsknF7y9l+tvmmE4cc=
X-Google-Smtp-Source: ABdhPJyYkfhaJKKUl/Br3OqHCIjj55SCvO14+5+zihXJbWi5pMaYzKOtG7hUptr9Hh/ZCdQfKcAohQ==
X-Received: by 2002:aa7:dd15:: with SMTP id i21mr25268326edv.153.1597137349506;
        Tue, 11 Aug 2020 02:15:49 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id cn27sm14240462edb.4.2020.08.11.02.15.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 02:15:48 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id f18so1711647wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 02:15:48 -0700 (PDT)
X-Received: by 2002:a7b:cb50:: with SMTP id v16mr3174224wmj.11.1597137347759;
 Tue, 11 Aug 2020 02:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200728050140.996974-1-tientzu@chromium.org> <20200728050140.996974-5-tientzu@chromium.org>
 <20200731205804.GB756942@bogus> <CALiNf2-BGQ+8Lm6A61oM6v+6N1zRTJYvod7LQLsCmK-ADsrMaw@mail.gmail.com>
 <CAAFQd5Cm+ZGx9ia2sAdvHQC6zC1U=+9AWs7iW7o-qE4g7wZgsw@mail.gmail.com>
In-Reply-To: <CAAFQd5Cm+ZGx9ia2sAdvHQC6zC1U=+9AWs7iW7o-qE4g7wZgsw@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 11 Aug 2020 11:15:35 +0200
X-Gmail-Original-Message-ID: <CAAFQd5AfbN0V3sGCs8vhmeD-MNn3bTvfWBCaT-OY3hgjBUs-LQ@mail.gmail.com>
Message-ID: <CAAFQd5AfbN0V3sGCs8vhmeD-MNn3bTvfWBCaT-OY3hgjBUs-LQ@mail.gmail.com>
Subject: Re: [RFC v2 4/5] dt-bindings: of: Add plumbing for restricted DMA pool
To:     Rob Herring <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>, suzuki.poulose@arm.com,
        dan.j.williams@intel.com, heikki.krogerus@linux.intel.com,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Claire Chang <tientzu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 5:15 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> Hi Claire and Rob,
>
> On Mon, Aug 3, 2020 at 4:26 PM Claire Chang <tientzu@chromium.org> wrote:
> >
> > On Sat, Aug 1, 2020 at 4:58 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Tue, Jul 28, 2020 at 01:01:39PM +0800, Claire Chang wrote:
> > > > Introduce the new compatible string, device-swiotlb-pool, for restricted
> > > > DMA. One can specify the address and length of the device swiotlb memory
> > > > region by device-swiotlb-pool in the device tree.
> > > >
> > > > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > > > ---
> > > >  .../reserved-memory/reserved-memory.txt       | 35 +++++++++++++++++++
> > > >  1 file changed, 35 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > > index 4dd20de6977f..78850896e1d0 100644
> > > > --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > > +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > > @@ -51,6 +51,24 @@ compatible (optional) - standard definition
> > > >            used as a shared pool of DMA buffers for a set of devices. It can
> > > >            be used by an operating system to instantiate the necessary pool
> > > >            management subsystem if necessary.
> > > > +        - device-swiotlb-pool: This indicates a region of memory meant to be
> > >
> > > swiotlb is a Linux thing. The binding should be independent.
> > Got it. Thanks for pointing this out.
> >
> > >
> > > > +          used as a pool of device swiotlb buffers for a given device. When
> > > > +          using this, the no-map and reusable properties must not be set, so the
> > > > +          operating system can create a virtual mapping that will be used for
> > > > +          synchronization. Also, there must be a restricted-dma property in the
> > > > +          device node to specify the indexes of reserved-memory nodes. One can
> > > > +          specify two reserved-memory nodes in the device tree. One with
> > > > +          shared-dma-pool to handle the coherent DMA buffer allocation, and
> > > > +          another one with device-swiotlb-pool for regular DMA to/from system
> > > > +          memory, which would be subject to bouncing. The main purpose for
> > > > +          restricted DMA is to mitigate the lack of DMA access control on
> > > > +          systems without an IOMMU, which could result in the DMA accessing the
> > > > +          system memory at unexpected times and/or unexpected addresses,
> > > > +          possibly leading to data leakage or corruption. The feature on its own
> > > > +          provides a basic level of protection against the DMA overwriting buffer
> > > > +          contents at unexpected times. However, to protect against general data
> > > > +          leakage and system memory corruption, the system needs to provide a
> > > > +          way to restrict the DMA to a predefined memory region.
> > >
> > > I'm pretty sure we already support per device carveouts and I don't
> > > understand how this is different.
> > We use this to bounce streaming DMA in and out of a specially allocated region.
> > I'll try to merge this with the existing one (i.e., shared-dma-pool)
> > to see if that
> > makes things clearer.
> >
>
> Indeed, from the firmware point of view, this is just a carveout, for
> which we have the "shared-dma-pool" compatible string defined already.
>
> However, depending on the device and firmware setup, the way the
> carevout is used may change. I can see the following scenarios:
>
> 1) coherent DMA (dma_alloc_*) within a reserved pool and no
> non-coherent DMA (dma_map_*).
>
> This is how the "memory-region" property is handled today in Linux for
> devices which can only DMA from/to the given memory region. However,
> I'm not sure if no non-coherent DMA is actually enforced in any way by
> the DMA subsystem.
>
> 2) coherent DMA from a reserved pool and non-coherent DMA from system memory
>
> This is the case for the systems which have some dedicated part of
> memory which is guaranteed to be coherent with the DMA, but still can
> do non-coherent DMA to any part of the system memory. Linux handles it
> the same way as 1), which is what made me believe that 1) might not
> actually be handled correctly.
>
> 3) coherent DMA and bounced non-coherent DMA within a reserved pool
> 4) coherent DMA within one pool and bounced non-coherent within another pool
>
> These are the two cases we're interested in. Basically they make it
> possible for non-coherent DMA from arbitrary system memory to be
> bounced through a reserved pool, which the device has access to. The
> current series implements 4), but I'd argue that it:
>
> - is problematic from the firmware point of view, because on most of
> the systems, both pools would be just some carveouts and the fact that
> Linux would use one for coherent and the other for non-coherent DMA
> would be an OS implementation detail,
> - suffers from the static memory split between coherent and
> non-coherent DMA, which could either result in some wasted memory or
> the DMA stopped working after a kernel update if the driver changes
> its allocation pattern,
>
> and so we should rather go with 3).
>
> Now, from the firmware point of view, it doesn't matter how the OS
> uses the carveout, but I think it's still necessary to tell the OS
> about the device DMA capability. Right now we use "memory-region" for
> any kind of reserved memory, but looking at the above scenarios, there
> are 2 cases:
>
> a) the memory region is preferred for the device, e.g. it enables
> coherency, but the device can still DMA across the rest of the system
> memory. This is the case in scenario 2) and is kind of assumed in the
> Linux DMA subsystem, although it's certainly not the case for a lot of
> hardware, even if they use the "memory-region" binding.
>
> b) the memory region is the only region that the device can access.
> This is the case in scenarios 1), 3) and 4).
>
> For this, I'd like to propose a "restricted-dma-region" (feel free to
> suggest a better name) binding, which is explicitly specified to be
> the only DMA-able memory for this device and make Linux use the given
> pool for coherent DMA allocations and bouncing non-coherent DMA.
>
> What do you think?

Rob, Robin, we'd appreciate your feedback on this when you have a
chance to take a look again. Thanks!

Best regards,
Tomasz

>
> Best regards,
> Tomasz
>
> > >
> > > What is the last sentence supposed to imply? You need an IOMMU?
> > The main purpose is to mitigate the lack of DMA access control on
> > systems without an IOMMU.
> > For example, we plan to use this plus a MPU for our PCIe WiFi which is
> > not behind an IOMMU.
> >
> > >
> > > >          - vendor specific string in the form <vendor>,[<device>-]<usage>
> > > >  no-map (optional) - empty property
> > > >      - Indicates the operating system must not create a virtual mapping
> > > > @@ -117,6 +135,16 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
> > > >                       compatible = "acme,multimedia-memory";
> > > >                       reg = <0x77000000 0x4000000>;
> > > >               };
> > > > +
> > > > +             wifi_coherent_mem_region: wifi_coherent_mem_region {
> > > > +                     compatible = "shared-dma-pool";
> > > > +                     reg = <0x50000000 0x400000>;
> > > > +             };
> > > > +
> > > > +             wifi_device_swiotlb_region: wifi_device_swiotlb_region {
> > > > +                     compatible = "device-swiotlb-pool";
> > > > +                     reg = <0x50400000 0x4000000>;
> > > > +             };
> > > >       };
> > > >
> > > >       /* ... */
> > > > @@ -135,4 +163,11 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
> > > >               memory-region = <&multimedia_reserved>;
> > > >               /* ... */
> > > >       };
> > > > +
> > > > +     pcie_wifi: pcie_wifi@0,0 {
> > > > +             memory-region = <&wifi_coherent_mem_region>,
> > > > +                      <&wifi_device_swiotlb_region>;
> > > > +             restricted-dma = <0>, <1>;
> > > > +             /* ... */
> > > > +     };
> > > >  };
> > > > --
> > > > 2.28.0.rc0.142.g3c755180ce-goog
> > > >
