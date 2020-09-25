Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7CB2786D8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgIYMRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:17:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbgIYMRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:17:15 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53DF021D7A;
        Fri, 25 Sep 2020 12:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601036234;
        bh=XBOGVADyRxetCSDG8LFr0DEFTM84cESKBNfqIwpBAuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z8MFMwi9Zi2SP34/29rLB27fe787anXuP5LpulqHya6LT+4OAkQa0taY8NqOwwdEo
         VlY8NnyCjfBc67Wu3dPcKOxuOwgZPcclL7aogKzo9fE2ZK1PVjKhEhJzbCyYyi/4Yr
         n0WccoiaQHQAy6U0CLtOC0C8qdYPIbiT2w21SfQY=
Date:   Fri, 25 Sep 2020 14:17:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        wang.yi59@zte.com.cn, huang.zijiang@zte.com.cn,
        rikard.falkeborn@gmail.com, lee.jones@linaro.org, mst@redhat.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH 3/5] misc: vop: simply return the saved dma address
 instead of virt_to_phys
Message-ID: <20200925121729.GC2680110@kroah.com>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
 <20200925072630.8157-4-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925072630.8157-4-sherry.sun@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 03:26:28PM +0800, Sherry Sun wrote:
> For noncoherent platform, the device page and vring should allocated by
> dma_alloc_coherent, when user space wants to get its physical address,
> virt_to_phys cannot be used, should simply return the saved device page
> dma address by get_dp_dma callback and the vring dma address saved
> in mic_vqconfig.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/misc/mic/bus/vop_bus.h    |  2 ++
>  drivers/misc/mic/host/mic_boot.c  |  8 ++++++++
>  drivers/misc/mic/vop/vop_vringh.c | 12 ++++++++++--
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/mic/bus/vop_bus.h b/drivers/misc/mic/bus/vop_bus.h
> index 4fa02808c1e2..d891eacae358 100644
> --- a/drivers/misc/mic/bus/vop_bus.h
> +++ b/drivers/misc/mic/bus/vop_bus.h
> @@ -75,6 +75,7 @@ struct vop_driver {
>   *                 node to add/remove/configure virtio devices.
>   * @get_dp: Get access to the virtio device page used by the self
>   *          node to add/remove/configure virtio devices.
> + * @get_dp_dma: Get dma address of the virtio device page.
>   * @send_intr: Send an interrupt to the peer node on a specified doorbell.
>   * @remap: Map a buffer with the specified DMA address and length.
>   * @unmap: Unmap a buffer previously mapped.
> @@ -92,6 +93,7 @@ struct vop_hw_ops {
>  	void (*ack_interrupt)(struct vop_device *vpdev, int num);
>  	void __iomem * (*get_remote_dp)(struct vop_device *vpdev);
>  	void * (*get_dp)(struct vop_device *vpdev);
> +	dma_addr_t (*get_dp_dma)(struct vop_device *vpdev);
>  	void (*send_intr)(struct vop_device *vpdev, int db);
>  	void __iomem * (*remap)(struct vop_device *vpdev,
>  				  dma_addr_t pa, size_t len);
> diff --git a/drivers/misc/mic/host/mic_boot.c b/drivers/misc/mic/host/mic_boot.c
> index fb5b3989753d..ced03662cd8f 100644
> --- a/drivers/misc/mic/host/mic_boot.c
> +++ b/drivers/misc/mic/host/mic_boot.c
> @@ -88,6 +88,13 @@ static void *__mic_get_dp(struct vop_device *vpdev)
>  	return mdev->dp;
>  }
>  
> +static dma_addr_t __mic_get_dp_dma(struct vop_device *vpdev)
> +{
> +	struct mic_device *mdev = vpdev_to_mdev(&vpdev->dev);
> +
> +	return mdev->dp_dma_addr;
> +}
> +
>  static void __iomem *__mic_get_remote_dp(struct vop_device *vpdev)
>  {
>  	return NULL;
> @@ -119,6 +126,7 @@ static struct vop_hw_ops vop_hw_ops = {
>  	.ack_interrupt = __mic_ack_interrupt,
>  	.next_db = __mic_next_db,
>  	.get_dp = __mic_get_dp,
> +	.get_dp_dma = __mic_get_dp_dma,
>  	.get_remote_dp = __mic_get_remote_dp,
>  	.send_intr = __mic_send_intr,
>  	.remap = __mic_ioremap,
> diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
> index fc8d8ff9ded3..aa2dd240c11e 100644
> --- a/drivers/misc/mic/vop/vop_vringh.c
> +++ b/drivers/misc/mic/vop/vop_vringh.c
> @@ -1076,6 +1076,7 @@ vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
>  		 unsigned long *size, unsigned long *pa)
>  {
>  	struct vop_device *vpdev = vdev->vpdev;
> +	struct mic_vqconfig *vqconfig = mic_vq_config(vdev->dd);
>  	unsigned long start = MIC_DP_SIZE;
>  	int i;
>  
> @@ -1088,7 +1089,14 @@ vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
>  	 * ....
>  	 */
>  	if (!offset) {
> -		*pa = virt_to_phys(vpdev->hw_ops->get_dp(vpdev));
> +		if (vpdev->hw_ops->get_dp_dma)
> +			*pa = vpdev->hw_ops->get_dp_dma(vpdev);
> +		else {
> +			dev_err(vop_dev(vdev), "can't get device page physical address\n");
> +			WARN_ON(1);

Don't crash kernels that have panic_on_warn set for things you can
recover from.

> +			return -1;

Use a real error value, do not make them up.

thanks,

greg k-h
