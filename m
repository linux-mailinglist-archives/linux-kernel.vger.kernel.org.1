Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF632A44AE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgKCMAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:00:42 -0500
Received: from foss.arm.com ([217.140.110.172]:47630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbgKCMAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:00:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5DA4106F;
        Tue,  3 Nov 2020 04:00:40 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF3CC3F718;
        Tue,  3 Nov 2020 04:00:38 -0800 (PST)
Subject: Re: [PATCH v4 4/7] iommu: Add quirk for Intel graphic devices in
 map_sg
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
References: <20200927063437.13988-1-baolu.lu@linux.intel.com>
 <20200927063437.13988-5-baolu.lu@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <281f22ed-8b36-fc20-4b08-27ef168f941d@arm.com>
Date:   Tue, 3 Nov 2020 12:00:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20200927063437.13988-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-27 07:34, Lu Baolu wrote:
> Combining the sg segments exposes a bug in the Intel i915 driver which
> causes visual artifacts and the screen to freeze. This is most likely
> because of how the i915 handles the returned list. It probably doesn't
> respect the returned value specifying the number of elements in the list
> and instead depends on the previous behaviour of the Intel iommu driver
> which would return the same number of elements in the output list as in
> the input list.
> 
> Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/dma-iommu.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 3526db774611..e7e4d758f51a 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -879,6 +879,33 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
>   	unsigned int cur_len = 0, max_len = dma_get_max_seg_size(dev);
>   	int i, count = 0;
>   
> +	/*
> +	 * The Intel graphic driver is used to assume that the returned
> +	 * sg list is not combound. This blocks the efforts of converting
> +	 * Intel IOMMU driver to dma-iommu api's. Add this quirk to make the
> +	 * device driver work and should be removed once it's fixed in i915
> +	 * driver.
> +	 */
> +	if (IS_ENABLED(CONFIG_DRM_I915) && dev_is_pci(dev) &&
> +	    to_pci_dev(dev)->vendor == PCI_VENDOR_ID_INTEL &&
> +	    (to_pci_dev(dev)->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
> +		for_each_sg(sg, s, nents, i) {
> +			unsigned int s_iova_off = sg_dma_address(s);
> +			unsigned int s_length = sg_dma_len(s);
> +			unsigned int s_iova_len = s->length;
> +
> +			s->offset += s_iova_off;
> +			s->length = s_length;
> +			sg_dma_address(s) = dma_addr + s_iova_off;
> +			sg_dma_len(s) = s_length;
> +			dma_addr += s_iova_len;
> +
> +			pr_info_once("sg combining disabled due to i915 driver\n");
> +		}
> +
> +		return nents;
> +	}

BTW, a much less invasive workaround would be to simply override 
seg_mask to 0. That's enough to make sure that no segment looks eligible 
for merging.

Robin.

> +
>   	for_each_sg(sg, s, nents, i) {
>   		/* Restore this segment's original unaligned fields first */
>   		unsigned int s_iova_off = sg_dma_address(s);
> 
