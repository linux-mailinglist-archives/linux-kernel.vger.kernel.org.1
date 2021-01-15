Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6A22F899A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 00:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbhAOXpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 18:45:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726607AbhAOXpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 18:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610754256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FFW1VUjwMynufyzYqhPYoWPpgrZOI0t/FMMBS/7NFuk=;
        b=KnUq2JMAtbvMt2lc37ftHymD/File3pBO7OjEpAFNvDDTnP8MYGxmTDyuR6rCcXpmtRfc4
        bkAxFaTFeZp5Ls+iNfe8Bn9uda3fdTCqZNRUTGVSGEWgUUwr5+JEI9UfVeVUBLXkS2f5aL
        6lPfv3ZBs1nd1Vx/SDw6mRn4x0lSgD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-hWKr_bYZNwaEcqZInJIslA-1; Fri, 15 Jan 2021 18:44:14 -0500
X-MC-Unique: hWKr_bYZNwaEcqZInJIslA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D817F107ACF8;
        Fri, 15 Jan 2021 23:44:11 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-255.phx2.redhat.com [10.3.112.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52BDA5D751;
        Fri, 15 Jan 2021 23:44:10 +0000 (UTC)
Date:   Fri, 15 Jan 2021 16:44:09 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Keqian Zhu <zhukeqian1@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <kvm@vger.kernel.org>,
        <kvmarm@lists.cs.columbia.edu>, Cornelia Huck <cohuck@redhat.com>,
        Will Deacon <will@kernel.org>, "Marc Zyngier" <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>
Subject: Re: [PATCH 6/6] vfio/iommu_type1: Drop parameter "pgsize" of
 update_user_bitmap
Message-ID: <20210115164409.3e7ddb28@omen.home.shazbot.org>
In-Reply-To: <20210107044401.19828-7-zhukeqian1@huawei.com>
References: <20210107044401.19828-1-zhukeqian1@huawei.com>
        <20210107044401.19828-7-zhukeqian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jan 2021 12:44:01 +0800
Keqian Zhu <zhukeqian1@huawei.com> wrote:

> We always use the smallest supported page size of vfio_iommu as
> pgsize. Drop parameter "pgsize" of update_user_bitmap.
> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 82649a040148..bceda5e8baaa 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -978,10 +978,9 @@ static void vfio_update_pgsize_bitmap(struct vfio_iommu *iommu)
>  }
>  
>  static int update_user_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
> -			      struct vfio_dma *dma, dma_addr_t base_iova,
> -			      size_t pgsize)
> +			      struct vfio_dma *dma, dma_addr_t base_iova)
>  {
> -	unsigned long pgshift = __ffs(pgsize);
> +	unsigned long pgshift = __ffs(iommu->pgsize_bitmap);
>  	unsigned long nbits = dma->size >> pgshift;
>  	unsigned long bit_offset = (dma->iova - base_iova) >> pgshift;
>  	unsigned long copy_offset = bit_offset / BITS_PER_LONG;
> @@ -1046,7 +1045,7 @@ static int vfio_iova_dirty_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
>  		if (dma->iova > iova + size - 1)
>  			break;
>  
> -		ret = update_user_bitmap(bitmap, iommu, dma, iova, pgsize);
> +		ret = update_user_bitmap(bitmap, iommu, dma, iova);
>  		if (ret)
>  			return ret;
>  
> @@ -1192,7 +1191,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  
>  		if (unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
>  			ret = update_user_bitmap(bitmap->data, iommu, dma,
> -						 unmap->iova, pgsize);
> +						 unmap->iova);
>  			if (ret)
>  				break;
>  		}

Same as the previous, both call sites already have both pgsize and
pgshift, pass both rather than recalculate.  Thanks,

Alex

