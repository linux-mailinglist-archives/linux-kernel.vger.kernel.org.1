Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24E72C3376
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 22:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733284AbgKXVp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 16:45:26 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57266 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733214AbgKXVpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:45:25 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AOLcioX116118;
        Tue, 24 Nov 2020 21:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=x7TyNlTxEv75IqmKVjcxr+IqU0wh1bm4MXFGLNn5yvo=;
 b=MkCdcLWGESs9ZwS3ubZ/yDnS+vdD5Li1aKNS73WvGi2kZ2+jHxxkR6bbvg1m02ZuwmCS
 yrCIv1CTfcrvyRboyF9d51GnO+Wi3KEcF21OrOQQyRifEDJ6qj9mstGJ5x0dBS62CbLL
 ZnLiapu8Y4Zv9CEWfGy0kVvAOrriZwAT8NSL5J3ymVNpbvBD3ujs7z3HKskbbb8oXf+4
 xm6u7FxwHjFFCa+qmuANppBlaJsUZcVKht01DsHOfbNUtEqECh0+I+8uLX4aNOHsMxhu
 116qaGD0+lgTz0sNlc1gotASuTkvd4uK+iFitKBuptUijzmYdvs6mXnyw4JJErkNZrl2 YQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34xrdaw8j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Nov 2020 21:44:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AOLe0i7024367;
        Tue, 24 Nov 2020 21:44:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34ycfnuvjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Nov 2020 21:44:54 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AOLinXL013178;
        Tue, 24 Nov 2020 21:44:49 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Nov 2020 13:44:49 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 8C6696A00A8; Tue, 24 Nov 2020 16:46:45 -0500 (EST)
Date:   Tue, 24 Nov 2020 16:46:45 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Jianxiong Gao <jxgao@google.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] [PATCH] Adding offset keeping option when mapping data
 via SWIOTLB.
Message-ID: <20201124214645.GB5805@char.us.oracle.com>
References: <20201123221807.3344263-1-jxgao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123221807.3344263-1-jxgao@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011240127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011240127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 02:18:07PM -0800, Jianxiong Gao wrote:
> NVMe driver and other applications may depend on the data offset
> to operate correctly. Currently when unaligned data is mapped via
> SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. When
> booting with --swiotlb=force option and using NVMe as interface,
> running mkfs.xfs on Rhel fails because of the unalignment issue.

RHEL? So a specific RHEL kernel. Is there a Red Hat bug created
for this that can be linked to this patch to make it easier
for folks to figure this?

Why would you be using swiotlb=force?
Ah, you are using AMD SEV!

> This patch adds an option to make sure the mapped data preserves
> its offset of the orginal addrss. Tested on latest kernel that

s/addrss/address/
> this patch fixes the issue.
> 
> Signed-off-by: Jianxiong Gao <jxgao@google.com>
> Acked-by: David Rientjes <rientjes@google.com>
> ---
>  drivers/nvme/host/pci.c     |  3 ++-
>  include/linux/dma-mapping.h |  8 ++++++++
>  kernel/dma/swiotlb.c        | 13 +++++++++++++
>  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 0578ff253c47..a366fb8a1ff0 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -833,7 +833,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
>  	else
>  		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
> -					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
> +				rq_dma_dir(req),
> +			       	DMA_ATTR_NO_WARN|DMA_ATTR_SWIOTLB_KEEP_OFFSET);
>  	if (!nr_mapped)
>  		goto out;
>  
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 956151052d45..e46d23d9fa20 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -61,6 +61,14 @@
>   */
>  #define DMA_ATTR_PRIVILEGED		(1UL << 9)
>  
> +/*
> + * DMA_ATTR_SWIOTLB_KEEP_OFFSET: used to indicate that the buffer has to keep
> + * its offset when mapped via SWIOTLB. Some application functionality depends
> + * on the address offset, thus when buffers are mapped via SWIOTLB, the offset
> + * needs to be preserved.
> + */
> +#define DMA_ATTR_SWIOTLB_KEEP_OFFSET	(1UL << 10)
> +
>  /*
>   * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
>   * be given to a device to use as a DMA source or target.  It is specific to a
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 781b9dca197c..f43d7be1342d 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -483,6 +483,13 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
>  	max_slots = mask + 1
>  		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
>  		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
> + 
> +	/*
> +	 * If we need to keep the offset when mapping, we need to add the offset
> +	 * to the total set we need to allocate in SWIOTLB
> +	 */
> +	if (attrs & DMA_ATTR_SWIOTLB_KEEP_OFFSET)
> +		alloc_size += offset_in_page(orig_addr);
>  
>  	/*
>  	 * For mappings greater than or equal to a page, we limit the stride
> @@ -567,6 +574,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
>  	 */
>  	for (i = 0; i < nslots; i++)
>  		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
> +	/*
> +	 * When keeping the offset of the original data, we need to advance
> +	 * the tlb_addr by the offset of orig_addr.
> +	 */
> +	if (attrs & DMA_ATTR_SWIOTLB_KEEP_OFFSET)
> +		tlb_addr += orig_addr & (PAGE_SIZE - 1);
>  	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>  	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
>  		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
> -- 
> 2.27.0
> 
> 
