Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77AE2F5221
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 19:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbhAMSdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 13:33:09 -0500
Received: from verein.lst.de ([213.95.11.211]:33066 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbhAMSdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 13:33:08 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A66E868B02; Wed, 13 Jan 2021 19:32:19 +0100 (CET)
Date:   Wed, 13 Jan 2021 19:32:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Claire Chang <tientzu@chromium.org>, robh+dt@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        joro@8bytes.org, will@kernel.org, frowand.list@gmail.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, m.szyprowski@samsung.com,
        grant.likely@arm.com, xypron.glpk@gmx.de, treding@nvidia.com,
        mingo@kernel.org, bauerman@linux.ibm.com, peterz@infradead.org,
        gregkh@linuxfoundation.org, saravanak@google.com,
        rafael.j.wysocki@intel.com, heikki.krogerus@linux.intel.com,
        andriy.shevchenko@linux.intel.com, rdunlap@infradead.org,
        dan.j.williams@intel.com, bgolaszewski@baylibre.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, tfiga@chromium.org,
        drinkcat@chromium.org
Subject: Re: [RFC PATCH v3 4/6] swiotlb: Add restricted DMA alloc/free
 support.
Message-ID: <20210113183218.GB19254@lst.de>
References: <20210106034124.30560-1-tientzu@chromium.org> <20210106034124.30560-5-tientzu@chromium.org> <20210113124847.GC1383@lst.de> <82bb75bc-11e6-ac94-9d24-7c896e3aae98@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82bb75bc-11e6-ac94-9d24-7c896e3aae98@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 06:27:08PM +0000, Robin Murphy wrote:
>> Can we hook in somewhat lower level in the dma-direct code so that all
>> the remapping in dma-direct can be reused instead of duplicated?  That
>> also becomes important if we want to use non-remapping uncached support,
>> e.g. on mips or x86, or the direct changing of the attributes that Will
>> planned to look into for arm64.
>
> Indeed, AFAICS this ought to boil down to a direct equivalent of 
> __dma_direct_alloc_pages() - other than the address there should be no 
> conceptual difference between pages from the restricted pool and those from 
> the regular page allocator, so this probably deserves to be plumbed in as 
> an alternative to that.

Yes, that's what I mean.  You managed to word it much better, though.
