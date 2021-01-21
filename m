Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4D72FEF80
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbhAUPv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:51:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387592AbhAUPs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:48:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0929723A5E;
        Thu, 21 Jan 2021 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611244098;
        bh=ESCY3rt1UpVAToMmeAThDINvSacKiOsK2nc/NRoNF9g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LCFe42rTpo0PlaukO40aoasQL5/Qys43MShy5ZOg+JcG27AZaNRJ4cHu3ZE/cf8rR
         HIq5i0dftrTxshUnv+icHC5DHyTHfgXx2miR6yKQvenRHR5EcVuOpasmEc7yPQPVKD
         cwEyOANH8KznmYsj7P/LmxN8ew+znCkYwD6N0a4Tn3GZxCRNczrWFg3Bw2fLc+J8b0
         mk+EobIZoCcxbqX8JNLKcWwjnfwQR3O98R8GTEtgLU8u20ZLIEKiWn8pxnDTKeDO9I
         oRgIbCp6Cch6hzf1mS9uVrtxlnUuCLlYvc71A4V2HcSXBy2GIVc5mXErflL3r+khjI
         CV+PqF7WZ5l5A==
Received: by mail-lf1-f51.google.com with SMTP id q12so3121811lfo.12;
        Thu, 21 Jan 2021 07:48:17 -0800 (PST)
X-Gm-Message-State: AOAM5331vcJOl/amW0j3d0GT9m1oztV2dB7L5jgF4g8I93bhnRUeIGGz
        MtSWYtbAV/o/mmn6YNmHzmEQxqkjWO3L77uRxg==
X-Google-Smtp-Source: ABdhPJxClIBHDNh0ezMtBn3tEIUpA6A69KltrTNKbOdslOUCg3ST6RYu/puKZCvzOeFiwKhVG1uu2/TgGhoFpNLSPDU=
X-Received: by 2002:a17:906:958f:: with SMTP id r15mr70711ejx.360.1611244095545;
 Thu, 21 Jan 2021 07:48:15 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org> <20210106034124.30560-6-tientzu@chromium.org>
 <20210120165348.GA220770@robh.at.kernel.org> <313f8052-a591-75de-c4c2-ee9ea8f02e7f@arm.com>
 <CAL_JsqKjTqcCbCLksRbCh7=f-A3Y09A3jNqtUApaA+p=RKd_Eg@mail.gmail.com> <c0d631de-8840-4f6e-aebf-41bb8449f78c@arm.com>
In-Reply-To: <c0d631de-8840-4f6e-aebf-41bb8449f78c@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 21 Jan 2021 09:48:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLv-FaiY_k+wS=iXG5AtccsXSBtvTfEGHvsN-VNqXdwpA@mail.gmail.com>
Message-ID: <CAL_JsqLv-FaiY_k+wS=iXG5AtccsXSBtvTfEGHvsN-VNqXdwpA@mail.gmail.com>
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

On Wed, Jan 20, 2021 at 7:10 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-01-20 21:31, Rob Herring wrote:
> > On Wed, Jan 20, 2021 at 11:30 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 2021-01-20 16:53, Rob Herring wrote:
> >>> On Wed, Jan 06, 2021 at 11:41:23AM +0800, Claire Chang wrote:
> >>>> Introduce the new compatible string, restricted-dma-pool, for restricted
> >>>> DMA. One can specify the address and length of the restricted DMA memory
> >>>> region by restricted-dma-pool in the device tree.
> >>>
> >>> If this goes into DT, I think we should be able to use dma-ranges for
> >>> this purpose instead. Normally, 'dma-ranges' is for physical bus
> >>> restrictions, but there's no reason it can't be used for policy or to
> >>> express restrictions the firmware has enabled.
> >>
> >> There would still need to be some way to tell SWIOTLB to pick up the
> >> corresponding chunk of memory and to prevent the kernel from using it
> >> for anything else, though.
> >
> > Don't we already have that problem if dma-ranges had a very small
> > range? We just get lucky because the restriction is generally much
> > more RAM than needed.
>
> Not really - if a device has a naturally tiny addressing capability that
> doesn't even cover ZONE_DMA32 where the regular SWIOTLB buffer will be
> allocated then it's unlikely to work well, but that's just crap system
> design. Yes, memory pressure in ZONE_DMA{32} is particularly problematic
> for such limited devices, but it's irrelevant to the issue at hand here.

Yesterday's crap system design is today's security feature. Couldn't
this feature make crap system design work better?

> What we have here is a device that's not allowed to see *kernel* memory
> at all. It's been artificially constrained to a particular region by a
> TZASC or similar, and the only data which should ever be placed in that

May have been constrained, but that's entirely optional.

In the optional case where the setup is entirely up to the OS, I don't
think this belongs in the DT at all. Perhaps that should be solved
first.

> region is data intended for that device to see. That way if it tries to
> go rogue it physically can't start slurping data intended for other
> devices or not mapped for DMA at all. The bouncing is an important part
> of this - I forget the title off-hand but there was an interesting paper
> a few years ago which demonstrated that even with an IOMMU, streaming
> DMA of in-place buffers could reveal enough adjacent data from the same
> page to mount an attack on the system. Memory pressure should be
> immaterial since the size of each bounce pool carveout will presumably
> be tuned for the needs of the given device.
>
> > In any case, wouldn't finding all the dma-ranges do this? We're
> > already walking the tree to find the max DMA address now.
>
> If all you can see are two "dma-ranges" properties, how do you propose
> to tell that one means "this is the extent of what I can address, please
> set my masks and dma-range-map accordingly and try to allocate things
> where I can reach them" while the other means "take this output range
> away from the page allocator and hook it up as my dedicated bounce pool,
> because it is Serious Security Time"? Especially since getting that
> choice wrong either way would be a Bad Thing.

Either we have some heuristic based on the size or we add some hint.
The point is let's build on what we already have for defining DMA
accessible memory in DT rather than some parallel mechanism.

Rob
