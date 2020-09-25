Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540912786C9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgIYMPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:15:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbgIYMPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:15:48 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA3FD2086A;
        Fri, 25 Sep 2020 12:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601036147;
        bh=OPlVwC5/XZSGKZj/eOaKDszpdunXRYZ9UxT1yqlhGh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=chbVXPVra51UmOyp0m9wLoFowrH0fujF5nUJPWkpbvSkiqtQmu/XZYhWyg8eXihLL
         ghmVcMwW2RJT+akATHO+2rlvuoaOrnCSzV+4xIMvuLZYITM555AgTy9+gaGVC0He/L
         znYNd5Y+tOxsbUFhU2oZPYNIrAT2nW1hd4uGxISg=
Date:   Fri, 25 Sep 2020 14:16:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        wang.yi59@zte.com.cn, huang.zijiang@zte.com.cn,
        rikard.falkeborn@gmail.com, lee.jones@linaro.org, mst@redhat.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH 1/5] misc: vop: change the way of allocating vring for
 noncoherent platform
Message-ID: <20200925121600.GA2680110@kroah.com>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
 <20200925072630.8157-2-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925072630.8157-2-sherry.sun@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 03:26:26PM +0800, Sherry Sun wrote:
> For noncoherent platform, we should allocate vring through
> dma_alloc_coherent api to ensure timely synchronization of vring.
> The orginal way which used __get_free_pages and dma_map_single only
> apply to coherent platforms.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/misc/mic/vop/vop_vringh.c | 101 ++++++++++++++++++++----------
>  1 file changed, 67 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
> index f344209ac386..fc8d8ff9ded3 100644
> --- a/drivers/misc/mic/vop/vop_vringh.c
> +++ b/drivers/misc/mic/vop/vop_vringh.c
> @@ -9,6 +9,7 @@
>  #include <linux/sched.h>
>  #include <linux/poll.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dma-noncoherent.h>
>  
>  #include <linux/mic_common.h>
>  #include "../common/mic_dev.h"
> @@ -67,11 +68,12 @@ static void vop_virtio_init_post(struct vop_vdev *vdev)
>  			dev_warn(vop_dev(vdev), "used_address zero??\n");
>  			continue;
>  		}
> -		vdev->vvr[i].vrh.vring.used =
> -			(void __force *)vpdev->hw_ops->remap(
> -			vpdev,
> -			le64_to_cpu(vqconfig[i].used_address),
> -			used_size);
> +		if (dev_is_dma_coherent(vop_dev(vdev)))
> +			vdev->vvr[i].vrh.vring.used =
> +				(void __force *)vpdev->hw_ops->remap(
> +				vpdev,
> +				le64_to_cpu(vqconfig[i].used_address),
> +				used_size);

That's really hard to read, don't you agree?  We can go longer than 80
columns now, and why the __force?



>  	}
>  
>  	vdev->dc->used_address_updated = 0;
> @@ -298,9 +300,14 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
>  		mutex_init(&vvr->vr_mutex);
>  		vr_size = PAGE_ALIGN(round_up(vring_size(num, MIC_VIRTIO_RING_ALIGN), 4) +
>  			sizeof(struct _mic_vring_info));
> -		vr->va = (void *)
> -			__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> -					 get_order(vr_size));
> +
> +		if (!dev_is_dma_coherent(vop_dev(vdev)))
> +			vr->va = dma_alloc_coherent(vop_dev(vdev), vr_size,
> +						    &vr_addr, GFP_KERNEL);

Are you sure this is correct?  If dev_is_dma_coherent is NOT true, then
you call dma_alloc_coherent()?


> +		else
> +			vr->va = (void *)
> +				__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> +						 get_order(vr_size));
>  		if (!vr->va) {
>  			ret = -ENOMEM;
>  			dev_err(vop_dev(vdev), "%s %d err %d\n",
> @@ -310,14 +317,17 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
>  		vr->len = vr_size;
>  		vr->info = vr->va + round_up(vring_size(num, MIC_VIRTIO_RING_ALIGN), 4);
>  		vr->info->magic = cpu_to_le32(MIC_MAGIC + vdev->virtio_id + i);
> -		vr_addr = dma_map_single(&vpdev->dev, vr->va, vr_size,
> -					 DMA_BIDIRECTIONAL);
> -		if (dma_mapping_error(&vpdev->dev, vr_addr)) {
> -			free_pages((unsigned long)vr->va, get_order(vr_size));
> -			ret = -ENOMEM;
> -			dev_err(vop_dev(vdev), "%s %d err %d\n",
> -				__func__, __LINE__, ret);
> -			goto err;
> +
> +		if (dev_is_dma_coherent(vop_dev(vdev))) {
> +			vr_addr = dma_map_single(&vpdev->dev, vr->va, vr_size,
> +						 DMA_BIDIRECTIONAL);
> +			if (dma_mapping_error(&vpdev->dev, vr_addr)) {
> +				free_pages((unsigned long)vr->va, get_order(vr_size));
> +				ret = -ENOMEM;
> +				dev_err(vop_dev(vdev), "%s %d err %d\n",
> +						__func__, __LINE__, ret);
> +				goto err;
> +			}

What about if this is not true?

Same for other places in this patch.

thanks,

greg k-h
