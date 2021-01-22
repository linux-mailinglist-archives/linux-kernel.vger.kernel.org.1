Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A754230042D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbhAVN2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:28:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbhAVN1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:27:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71C9C23437;
        Fri, 22 Jan 2021 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611322022;
        bh=TFRhEbqOYGrPg5oqvZVpaacX5O5OSugUVOmvFlNjpHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WES5Cm1GzYFPymGEhfK8FTVVWR1u6M1vvW13aa9LwGcq3rhxId09iMjJocQDvk8hm
         iG1Sbab84JE57V4aIaKSycb5d1IxgqWLfDlpqcsYdlYW/r+3CFkyg5EZZPoi8pryad
         tfK1K/MHOVDOaiLC9aTyHscXWl+zhxwPiHHL0wBewy5GBjh8bQz84GgHpRSxOtNzgY
         /cz2yHVcmYMua4UV/bCQjZlA74eHzcPoyB3QGRvbfP/ssHCB/ADoBi3hcX1BkEEJIQ
         PX67b5+eXPGAwDZCS+35ypd0ENmdD27/qMkRwvBLLpU9w4GJyV02QzzSWzQqLVkKVE
         f6GtWRRs8geow==
Date:   Fri, 22 Jan 2021 13:26:57 +0000
From:   Will Deacon <will@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: add support for BBML
Message-ID: <20210122132657.GF24102@willie-the-truck>
References: <20201126034230.777-1-thunder.leizhen@huawei.com>
 <20210122125132.GB24102@willie-the-truck>
 <34a9c164-389d-30cd-11a3-8796eb7bca93@arm.com>
 <ad8cb736-6760-8aab-b11e-f296ec12301b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad8cb736-6760-8aab-b11e-f296ec12301b@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 09:21:20PM +0800, Leizhen (ThunderTown) wrote:
> On 2021/1/22 21:00, Robin Murphy wrote:
> > On 2021-01-22 12:51, Will Deacon wrote:
> >> On Thu, Nov 26, 2020 at 11:42:30AM +0800, Zhen Lei wrote:
> >>>   -        tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
> >>> -        if (__arm_lpae_unmap(data, NULL, iova, sz, lvl, tblp) != sz) {
> >>> -            WARN_ON(1);
> >>> -            return -EINVAL;
> >>> +        switch (cfg->bbml) {
> >>> +        case 0:
> >>> +            /*
> >>> +             * We need to unmap and free the old table before
> >>> +             * overwriting it with a block entry.
> >>> +             */
> >>> +            tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
> >>> +            if (__arm_lpae_unmap(data, NULL, iova, sz, lvl, tblp) != sz) {
> >>> +                WARN_ON(1);
> >>> +                return -EINVAL;
> >>> +            }
> >>> +            break;
> >>> +        case 1:
> >>> +            __arm_lpae_init_pte(data, paddr, prot, lvl, ptep, ARM_LPAE_PTE_nT);
> >>> +
> >>> +            io_pgtable_tlb_flush_walk(iop, iova, sz, ARM_LPAE_GRANULE(data));
> >>> +            tblp = iopte_deref(pte, data);
> >>> +            __arm_lpae_free_pgtable(data, lvl + 1, tblp);
> >>> +            break;
> >>> +        case 2:
> >>> +            __arm_lpae_init_pte(data, paddr, prot, lvl, ptep, 0);
> >>> +
> >>> +            io_pgtable_tlb_flush_walk(iop, iova, sz, ARM_LPAE_GRANULE(data));
> >>> +            tblp = iopte_deref(pte, data);
> >>> +            __arm_lpae_free_pgtable(data, lvl + 1, tblp);
> >>> +            return 0;
> >>
> >> Sorry, but I really don't understand what you're trying to do here. The old
> >> code uses BBM for the table -> block path so we don't need anything extra
> >> here. The dodgy case is when we unmap part of a block, and end up installing
> >> a table via arm_lpae_split_blk_unmap(). We can't use BBM there because there
> >> could be ongoing DMA to parts of the block mapping that we want to remain in
> >> place.
> >>
> >> Are you seeing a problem in practice?
> > 
> > Right, I was under the assumption that we could ignore BBML because we
> > should never have a legitimate reason to split blocks. I'm certainly not
> > keen on piling any more complexity into split_blk_unmap, because the
> > IOMMU API clearly doesn't have a well-defined behaviour for that case
> > anyway - some other drivers will just unmap the entire block, and IIRC
> > there was a hint somewhere in VFIO that it might actually expect that
> > behaviour.
> 
> I'm going home. I'll answer you two tomorrow.

It can wait until Monday! Have a good weekend :)

Will
