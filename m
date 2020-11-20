Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BF42BAA08
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgKTMYc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Nov 2020 07:24:32 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:54613 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727518AbgKTMYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:24:31 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23054655-1500050 
        for multiple; Fri, 20 Nov 2020 12:24:02 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201120101719.3172693-1-baolu.lu@linux.intel.com>
References: <20201120101719.3172693-1-baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 0/7] Convert the intel iommu driver to the dma-iommu api
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, Will Deacon <will@kernel.org>
Date:   Fri, 20 Nov 2020 12:24:01 +0000
Message-ID: <160587504147.19364.17448380121292539865@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lu Baolu (2020-11-20 10:17:12)
> Lu Baolu (3):
>   iommu: Add quirk for Intel graphic devices in map_sg
>   iommu/vt-d: Update domain geometry in iommu_ops.at(de)tach_dev
>   iommu/vt-d: Cleanup after converting to dma-iommu ops
> 
> Tom Murphy (4):
>   iommu: Handle freelists when using deferred flushing in iommu drivers
>   iommu: Add iommu_dma_free_cpu_cached_iovas()
>   iommu: Allow the dma-iommu api to use bounce buffers
>   iommu/vt-d: Convert intel iommu driver to the iommu ops

Something that may be of interest is that we encounter problems with
using intel-iommu across a PCI remove event. All HW generations fail
with faults like:

DMAR: DRHD: handling fault status reg 3
DMAR: [DMA Write] Request device [00:02.0] PASID ffffffff fault addr 4b822000 [fault reason 02] Present bit in context entry is clear

i.e. they all report missing present bit after re-adding the device to the
iommu group. Forcing an identity map (or disabling iommu) works fine.

I applied this series just on the off-chance it changed the symptoms; it
does not. If you have any ideas on how to chase down this fault, that
would be very useful. We have a few other DMAR faults visible on many
platforms, all "[fault reason 07] Next page table ptr is invalid" that
are again not affected by this series, that we also need to resolve.
-Chris
