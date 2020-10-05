Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49723283643
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgJENI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:08:56 -0400
Received: from verein.lst.de ([213.95.11.211]:59012 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbgJENI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:08:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7EDB367373; Mon,  5 Oct 2020 15:08:52 +0200 (CEST)
Date:   Mon, 5 Oct 2020 15:08:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Auger Eric <eric.auger@redhat.com>, joro@8bytes.org,
        iommu@lists.linux-foundation.org, robin.murphy@arm.com,
        dwmw2@infradead.org, eric.auger.pro@gmail.com,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>, hch@lst.de
Subject: Re: [RFC 0/3] iommu: Reserved regions for IOVAs beyond dma_mask
 and iommu aperture
Message-ID: <20201005130852.GB2163@lst.de>
References: <20200928195037.22654-1-eric.auger@redhat.com> <20200928164224.12350d84@w520.home> <1cbaf3e7-cf88-77f6-4cc4-46dcd60eb649@redhat.com> <20200929121849.455af184@w520.home> <20201005104410.GA12138@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005104410.GA12138@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 11:44:10AM +0100, Lorenzo Pieralisi wrote:
> > I see that there are both OF and ACPI hooks in pci_dma_configure() and
> > both modify dev->dma_mask, which is what pci-sysfs is exposing here,
> > but I'm not convinced this even does what it's intended to do.  The
> > driver core calls this via the bus->dma_configure callback before
> > probing a driver, but then what happens when the driver calls
> > pci_set_dma_mask()?  This is just a wrapper for dma_set_mask() and I
> > don't see anywhere that would take into account the existing
> > dev->dma_mask.  It seems for example that pci_dma_configure() could
> > produce a 42 bit mask as we have here, then the driver could override
> > that with anything that the dma_ops.dma_supported() callback finds
> > acceptable, and I don't see any instances where the current
> > dev->dma_mask is considered.  Am I overlooking something? 
> 
> I don't think so but Christoph and Robin can provide more input on
> this - it is a long story.
> 
> ACPI and OF bindings set a default dma_mask (and dev->bus_dma_limit),
> this does not prevent a driver from overriding the dev->dma_mask but DMA
> mapping code still takes into account the dev->bus_dma_limit.
> 
> This may help:
> 
> git log -p 03bfdc31176c

This is at best a historic artefact.  Bus drivers have no business
messing with the DMA mask, dev->bus_dma_limit is the way to communicate
addressing limits on the bus (or another interconnect closer to the CPU).
