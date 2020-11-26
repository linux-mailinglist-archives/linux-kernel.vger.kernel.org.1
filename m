Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54D12C566B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391108AbgKZNq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:46:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390856AbgKZNq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606398417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4fux52JZVbYIP0imVmVjqUi5Uo7xuob2S06QEGrh7kY=;
        b=GmAvT2UGLE1u729MDCHqAmHI5jrrlKuOKywOm33kTGAzGKB5DLiB7+PSspWJ/R05GkrkN5
        eKg0QwF98ZKMDUtBGxgepEy2gCfOp4SA9enqnt/qnWjLzisv4nNlei/lZ6dICxKYOUBa22
        CHPK5GaaxLayGUAHXnGMeCXoGV9FTZw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-FuvUb5dMPXuzFhBWHzEpgA-1; Thu, 26 Nov 2020 08:46:55 -0500
X-MC-Unique: FuvUb5dMPXuzFhBWHzEpgA-1
Received: by mail-wr1-f69.google.com with SMTP id b12so1322771wru.15
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4fux52JZVbYIP0imVmVjqUi5Uo7xuob2S06QEGrh7kY=;
        b=HqPsE1IkUvfh1TAqZg/PjHgWhNFui5xf+W3PYadDx99wMgvHHN/ys/Nam7jLz7uZ2r
         MqsRicHWdhxr5zCZKZ+cozs47P0Cvj1oVJhh9HDxKmRQt3aorHKDvH17XxmvpzeVseIu
         UkiGmVmyb4D+KdkZoGhunQUIe7H6etdCeG03r18ACYWVHMQi5n7gQMpB4Uz389DVfGk+
         izlXM7CHA9bsFEpNJ6dGRY2r3J29CqEGYBhON06G9rQm0FX58vAsaECD8S3d6SorO4xm
         e3LhmGXXBfkM0AnDX54iB5aBhxSICfU6tDcf/n/N3S/mMl4OIbXO52J8Xq3SdIUCeD8a
         SYgw==
X-Gm-Message-State: AOAM533FibhqM0UsKweKxNKMW/D3Zq7breAkRPsf8XhSfm+Djs37rt2E
        PVonUPX9ioJFIDtQBO8YZOoXy1Lefj4dWxhAtyEIXRZ5OtOu1ucFl26qJokO/kmRmlq1AQnThNa
        czAiiViRkrGiIMCiN5FI+5sD/
X-Received: by 2002:adf:e681:: with SMTP id r1mr4144386wrm.348.1606398413850;
        Thu, 26 Nov 2020 05:46:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxw+3CWLYRpcTsMY8NIsQON707J+gRNov1rZzUPVVJNEemKGfl92Fkv/opMwC56b2e3kVnVBg==
X-Received: by 2002:adf:e681:: with SMTP id r1mr4144365wrm.348.1606398413606;
        Thu, 26 Nov 2020 05:46:53 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id w17sm9051203wru.82.2020.11.26.05.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:46:52 -0800 (PST)
Date:   Thu, 26 Nov 2020 08:46:50 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com
Subject: Re: [PATCH V2 01/14] virtio-pci: do not access iomem via
 virtio_pci_device directly
Message-ID: <20201126084436-mutt-send-email-mst@kernel.org>
References: <20201126092604.208033-1-jasowang@redhat.com>
 <20201126092604.208033-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126092604.208033-2-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 05:25:51PM +0800, Jason Wang wrote:
> Instead of accessing iomem via virito_pci_device directly. Add an
> indirect level

well this patch does not add any indirection it's just refactoring.
which is ok of course let's just say it as is.

> to ease the life of splitting out modern virito-pci

typo

> logic.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 76 ++++++++++++++++++------------
>  1 file changed, 46 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 3d6ae5a5e252..df1481fd400c 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -141,12 +141,13 @@ static void __iomem *map_capability(struct pci_dev *dev, int off,
>  static u64 vp_get_features(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
>  	u64 features;
>  
> -	vp_iowrite32(0, &vp_dev->common->device_feature_select);
> -	features = vp_ioread32(&vp_dev->common->device_feature);
> -	vp_iowrite32(1, &vp_dev->common->device_feature_select);
> -	features |= ((u64)vp_ioread32(&vp_dev->common->device_feature) << 32);
> +	vp_iowrite32(0, &cfg->device_feature_select);
> +	features = vp_ioread32(&cfg->device_feature);
> +	vp_iowrite32(1, &cfg->device_feature_select);
> +	features |= ((u64)vp_ioread32(&cfg->device_feature) << 32);
>  
>  	return features;
>  }
> @@ -165,6 +166,7 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
>  static int vp_finalize_features(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
>  	u64 features = vdev->features;
>  
>  	/* Give virtio_ring a chance to accept features. */
> @@ -179,10 +181,10 @@ static int vp_finalize_features(struct virtio_device *vdev)
>  		return -EINVAL;
>  	}
>  
> -	vp_iowrite32(0, &vp_dev->common->guest_feature_select);
> -	vp_iowrite32((u32)vdev->features, &vp_dev->common->guest_feature);
> -	vp_iowrite32(1, &vp_dev->common->guest_feature_select);
> -	vp_iowrite32(vdev->features >> 32, &vp_dev->common->guest_feature);
> +	vp_iowrite32(0, &cfg->guest_feature_select);
> +	vp_iowrite32((u32)vdev->features, &cfg->guest_feature);
> +	vp_iowrite32(1, &cfg->guest_feature_select);
> +	vp_iowrite32(vdev->features >> 32, &cfg->guest_feature);
>  
>  	return 0;
>  }
> @@ -192,6 +194,7 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
>  		   void *buf, unsigned len)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	void __iomem *device = vp_dev->device;
>  	u8 b;
>  	__le16 w;
>  	__le32 l;
> @@ -200,21 +203,21 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
>  
>  	switch (len) {
>  	case 1:
> -		b = ioread8(vp_dev->device + offset);
> +		b = ioread8(device + offset);
>  		memcpy(buf, &b, sizeof b);
>  		break;
>  	case 2:
> -		w = cpu_to_le16(ioread16(vp_dev->device + offset));
> +		w = cpu_to_le16(ioread16(device + offset));
>  		memcpy(buf, &w, sizeof w);
>  		break;
>  	case 4:
> -		l = cpu_to_le32(ioread32(vp_dev->device + offset));
> +		l = cpu_to_le32(ioread32(device + offset));
>  		memcpy(buf, &l, sizeof l);
>  		break;
>  	case 8:
> -		l = cpu_to_le32(ioread32(vp_dev->device + offset));
> +		l = cpu_to_le32(ioread32(device + offset));
>  		memcpy(buf, &l, sizeof l);
> -		l = cpu_to_le32(ioread32(vp_dev->device + offset + sizeof l));
> +		l = cpu_to_le32(ioread32(device + offset + sizeof l));
>  		memcpy(buf + sizeof l, &l, sizeof l);
>  		break;
>  	default:
> @@ -228,6 +231,7 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
>  		   const void *buf, unsigned len)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	void __iomem *device = vp_dev->device;
>  	u8 b;
>  	__le16 w;
>  	__le32 l;
> @@ -237,21 +241,21 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
>  	switch (len) {
>  	case 1:
>  		memcpy(&b, buf, sizeof b);
> -		iowrite8(b, vp_dev->device + offset);
> +		iowrite8(b, device + offset);
>  		break;
>  	case 2:
>  		memcpy(&w, buf, sizeof w);
> -		iowrite16(le16_to_cpu(w), vp_dev->device + offset);
> +		iowrite16(le16_to_cpu(w), device + offset);
>  		break;
>  	case 4:
>  		memcpy(&l, buf, sizeof l);
> -		iowrite32(le32_to_cpu(l), vp_dev->device + offset);
> +		iowrite32(le32_to_cpu(l), device + offset);
>  		break;
>  	case 8:
>  		memcpy(&l, buf, sizeof l);
> -		iowrite32(le32_to_cpu(l), vp_dev->device + offset);
> +		iowrite32(le32_to_cpu(l), device + offset);
>  		memcpy(&l, buf + sizeof l, sizeof l);
> -		iowrite32(le32_to_cpu(l), vp_dev->device + offset + sizeof l);
> +		iowrite32(le32_to_cpu(l), device + offset + sizeof l);
>  		break;
>  	default:
>  		BUG();
> @@ -261,35 +265,43 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
>  static u32 vp_generation(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> -	return vp_ioread8(&vp_dev->common->config_generation);
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
> +
> +	return vp_ioread8(&cfg->config_generation);
>  }
>  
>  /* config->{get,set}_status() implementations */
>  static u8 vp_get_status(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> -	return vp_ioread8(&vp_dev->common->device_status);
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
> +
> +	return vp_ioread8(&cfg->device_status);
>  }
>  
>  static void vp_set_status(struct virtio_device *vdev, u8 status)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
> +
>  	/* We should never be setting status to 0. */
>  	BUG_ON(status == 0);
> -	vp_iowrite8(status, &vp_dev->common->device_status);
> +	vp_iowrite8(status, &cfg->device_status);
>  }
>  
>  static void vp_reset(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
> +
>  	/* 0 status means a reset. */
> -	vp_iowrite8(0, &vp_dev->common->device_status);
> +	vp_iowrite8(0, &cfg->device_status);
>  	/* After writing 0 to device_status, the driver MUST wait for a read of
>  	 * device_status to return 0 before reinitializing the device.
>  	 * This will flush out the status write, and flush in device writes,
>  	 * including MSI-X interrupts, if any.
>  	 */
> -	while (vp_ioread8(&vp_dev->common->device_status))
> +	while (vp_ioread8(&cfg->device_status))
>  		msleep(1);
>  	/* Flush pending VQ/configuration callbacks. */
>  	vp_synchronize_vectors(vdev);
> @@ -297,11 +309,13 @@ static void vp_reset(struct virtio_device *vdev)
>  
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
>  {
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
> +
>  	/* Setup the vector used for configuration events */
> -	vp_iowrite16(vector, &vp_dev->common->msix_config);
> +	vp_iowrite16(vector, &cfg->msix_config);
>  	/* Verify we had enough resources to assign the vector */
>  	/* Will also flush the write out to device */
> -	return vp_ioread16(&vp_dev->common->msix_config);
> +	return vp_ioread16(&cfg->msix_config);
>  }
>  
>  static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
> @@ -407,6 +421,7 @@ static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  			      struct irq_affinity *desc)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
>  	struct virtqueue *vq;
>  	int rc = vp_find_vqs(vdev, nvqs, vqs, callbacks, names, ctx, desc);
>  
> @@ -417,8 +432,8 @@ static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  	 * this, there's no way to go back except reset.
>  	 */
>  	list_for_each_entry(vq, &vdev->vqs, list) {
> -		vp_iowrite16(vq->index, &vp_dev->common->queue_select);
> -		vp_iowrite16(1, &vp_dev->common->queue_enable);
> +		vp_iowrite16(vq->index, &cfg->queue_select);
> +		vp_iowrite16(1, &cfg->queue_enable);
>  	}
>  
>  	return 0;
> @@ -428,14 +443,15 @@ static void del_vq(struct virtio_pci_vq_info *info)
>  {
>  	struct virtqueue *vq = info->vq;
>  	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
>  
> -	vp_iowrite16(vq->index, &vp_dev->common->queue_select);
> +	vp_iowrite16(vq->index, &cfg->queue_select);
>  
>  	if (vp_dev->msix_enabled) {
>  		vp_iowrite16(VIRTIO_MSI_NO_VECTOR,
> -			     &vp_dev->common->queue_msix_vector);
> +			     &cfg->queue_msix_vector);
>  		/* Flush the write out to device */
> -		vp_ioread16(&vp_dev->common->queue_msix_vector);
> +		vp_ioread16(&cfg->queue_msix_vector);
>  	}
>  
>  	if (!vp_dev->notify_base)
> -- 
> 2.25.1

