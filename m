Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F379F25D595
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 12:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgIDKDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 06:03:46 -0400
Received: from 8bytes.org ([81.169.241.247]:41080 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgIDKDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:03:45 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1952D3D5; Fri,  4 Sep 2020 12:03:42 +0200 (CEST)
Date:   Fri, 4 Sep 2020 12:03:40 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Tom Murphy <murphyt7@tcd.ie>
Cc:     iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/5] Convert the intel iommu driver to the dma-iommu
 api
Message-ID: <20200904100340.GT6714@8bytes.org>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903201839.7327-1-murphyt7@tcd.ie>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Tom,

On Thu, Sep 03, 2020 at 09:18:32PM +0100, Tom Murphy wrote:
> Tom Murphy (5):
>   iommu: Handle freelists when using deferred flushing in iommu drivers
>   iommu: Add iommu_dma_free_cpu_cached_iovas function
>   iommu: allow the dma-iommu api to use bounce buffers
>   iommu/vt-d: Convert intel iommu driver to the iommu ops
>   DO NOT MERGE: iommu: disable list appending in dma-iommu

Thanks for your continued work on this. As discussed in the
microconference, Lu Baolu will take this over now and we can hopefully
merge it soon.

Thanks,

	Joerg
