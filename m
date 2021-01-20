Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD872FDFE7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 04:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404689AbhATXzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 18:55:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733269AbhATVcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:32:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59FD52368A;
        Wed, 20 Jan 2021 21:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611178292;
        bh=9CXXn3DwKkTTYhGUSuO/SI53HoPSF8zgyeHYS4YvRdY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZmvEQDVtsexRf8n+ZOC1JbuBQnuBhbV+r3jD4kU3Q1tMAid8yX+yqYfJEbOdcXgMA
         rj/QXs5sTJEgKtheY4gImRh4zCXvn8N2ChQdofm3pHRivCgOB+sxuai3yKlikVUe8k
         0BmRxe14MAaAn1jeMSxzxdQbEaIjPFqRcdtyHRGAO007v7GUojsrvuJx0vbYiLCW4y
         CE8T7v8FgFjOOFzn6XDR1a3R7a15VGz6LfvNskEJWJ+wrvKK3PCEo/X4rrgHOkc5EU
         75qDn57wy4vXYALFVoUbkz6Mt+vLxPPKyyUcaTDi5ZRLHNNoPHr3mcqRXma66ALKFJ
         ALtCNmZmqRqOg==
Received: by mail-ed1-f49.google.com with SMTP id d22so76419edy.1;
        Wed, 20 Jan 2021 13:31:32 -0800 (PST)
X-Gm-Message-State: AOAM532/KVUKVt254MTD6P8nSQDMd2LjTVg/rD0zc+DIZF+ZlLMvwNBt
        vB7ykdKkCU5Pwo1LmWdSaHIzxhd9Xi0AhQ6/oQ==
X-Google-Smtp-Source: ABdhPJxxe7bmkr1qiyEvYmjNhUT8+sw1iAGIkRYDudgLedU+OdBCuc6+RqAv/YoEJ2MAoQJ7R76moo3AN8Iijs+CzYU=
X-Received: by 2002:a05:6402:1751:: with SMTP id v17mr8944895edx.289.1611178290171;
 Wed, 20 Jan 2021 13:31:30 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org> <20210106034124.30560-6-tientzu@chromium.org>
 <20210120165348.GA220770@robh.at.kernel.org> <313f8052-a591-75de-c4c2-ee9ea8f02e7f@arm.com>
In-Reply-To: <313f8052-a591-75de-c4c2-ee9ea8f02e7f@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 20 Jan 2021 15:31:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKjTqcCbCLksRbCh7=f-A3Y09A3jNqtUApaA+p=RKd_Eg@mail.gmail.com>
Message-ID: <CAL_JsqKjTqcCbCLksRbCh7=f-A3Y09A3jNqtUApaA+p=RKd_Eg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/6] dt-bindings: of: Add restricted DMA pool
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Claire Chang <tientzu@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Grant Likely <grant.likely@arm.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Thierry Reding <treding@nvidia.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        xen-devel@lists.xenproject.org, Tomasz Figa <tfiga@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:30 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-01-20 16:53, Rob Herring wrote:
> > On Wed, Jan 06, 2021 at 11:41:23AM +0800, Claire Chang wrote:
> >> Introduce the new compatible string, restricted-dma-pool, for restricted
> >> DMA. One can specify the address and length of the restricted DMA memory
> >> region by restricted-dma-pool in the device tree.
> >
> > If this goes into DT, I think we should be able to use dma-ranges for
> > this purpose instead. Normally, 'dma-ranges' is for physical bus
> > restrictions, but there's no reason it can't be used for policy or to
> > express restrictions the firmware has enabled.
>
> There would still need to be some way to tell SWIOTLB to pick up the
> corresponding chunk of memory and to prevent the kernel from using it
> for anything else, though.

Don't we already have that problem if dma-ranges had a very small
range? We just get lucky because the restriction is generally much
more RAM than needed.

In any case, wouldn't finding all the dma-ranges do this? We're
already walking the tree to find the max DMA address now.

> >> Signed-off-by: Claire Chang <tientzu@chromium.org>
> >> ---
> >>   .../reserved-memory/reserved-memory.txt       | 24 +++++++++++++++++++
> >>   1 file changed, 24 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> >> index e8d3096d922c..44975e2a1fd2 100644
> >> --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> >> +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> >> @@ -51,6 +51,20 @@ compatible (optional) - standard definition
> >>             used as a shared pool of DMA buffers for a set of devices. It can
> >>             be used by an operating system to instantiate the necessary pool
> >>             management subsystem if necessary.
> >> +        - restricted-dma-pool: This indicates a region of memory meant to be
> >> +          used as a pool of restricted DMA buffers for a set of devices. The
> >> +          memory region would be the only region accessible to those devices.
> >> +          When using this, the no-map and reusable properties must not be set,
> >> +          so the operating system can create a virtual mapping that will be used
> >> +          for synchronization. The main purpose for restricted DMA is to
> >> +          mitigate the lack of DMA access control on systems without an IOMMU,
> >> +          which could result in the DMA accessing the system memory at
> >> +          unexpected times and/or unexpected addresses, possibly leading to data
> >> +          leakage or corruption. The feature on its own provides a basic level
> >> +          of protection against the DMA overwriting buffer contents at
> >> +          unexpected times. However, to protect against general data leakage and
> >> +          system memory corruption, the system needs to provide way to restrict
> >> +          the DMA to a predefined memory region.
> >>           - vendor specific string in the form <vendor>,[<device>-]<usage>
> >>   no-map (optional) - empty property
> >>       - Indicates the operating system must not create a virtual mapping
> >> @@ -120,6 +134,11 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
> >>                      compatible = "acme,multimedia-memory";
> >>                      reg = <0x77000000 0x4000000>;
> >>              };
> >> +
> >> +            restricted_dma_mem_reserved: restricted_dma_mem_reserved {
> >> +                    compatible = "restricted-dma-pool";
> >> +                    reg = <0x50000000 0x400000>;
> >> +            };
> >>      };
> >>
> >>      /* ... */
> >> @@ -138,4 +157,9 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
> >>              memory-region = <&multimedia_reserved>;
> >>              /* ... */
> >>      };
> >> +
> >> +    pcie_device: pcie_device@0,0 {
> >> +            memory-region = <&restricted_dma_mem_reserved>;
> >
> > PCI hosts often have inbound window configurations that limit the
> > address range and translate PCI to bus addresses. Those windows happen
> > to be configured by dma-ranges. In any case, wouldn't you want to put
> > the configuration in the PCI host node? Is there a usecase of
> > restricting one PCIe device and not another?
>
> The general design seems to accommodate devices having their own pools
> such that they can't even snoop on each others' transient DMA data. If
> the interconnect had a way of wiring up, say, PCI RIDs to AMBA NSAIDs,
> then in principle you could certainly apply that to PCI endpoints too
> (presumably you'd also disallow them from peer-to-peer transactions at
> the PCI level too).

At least for PCI, I think we can handle this. We have the BDF in the
3rd address cell in dma-ranges. The Openfirmware spec says those are 0
in the case of ranges. It doesn't talk about dma-ranges though. But I
think we could extend it to allow for BDF. Though typically with PCIe
every device is behind its own bridge and each bridge node can have a
dma-ranges.

Rob
