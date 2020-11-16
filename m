Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4572B4045
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 10:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgKPJux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:50:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727418AbgKPJuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605520250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1tFy2QDhVKk++GXQ1cATriAqBAtzlx74HcCkbk1BOfw=;
        b=B+0G3Pw3m0RK0lOk3V06roUvmVcFXszNbpYfDbuVPDNouC6nBebvAK/jFa6xHHfdNrwjWf
        kPl0FGjdfBIGEtRgNOAGZX0fYZwUuuRPEd2//DvBEaU+JUmvyf0dABqOs2k/0GecfcqNX0
        x4iCC6Bx5cP6g/M2q0eWKzC4+EoDC2Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-dbjl-ATVNWKtwheX1LHfVw-1; Mon, 16 Nov 2020 04:50:48 -0500
X-MC-Unique: dbjl-ATVNWKtwheX1LHfVw-1
Received: by mail-wr1-f69.google.com with SMTP id d8so10824350wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 01:50:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1tFy2QDhVKk++GXQ1cATriAqBAtzlx74HcCkbk1BOfw=;
        b=mXr0MnWAF6RykmcCqlZJDV7ntCHYE6C7dMagjCCxhyIK/ofG+0IhfFeiHUCtJccTXY
         yab3hg9Mys1ojy/X/ssnPMmBlw9NQnD2/bHog5Va1gn6VggnHp+U5vyyhlHDLsDTEfvt
         pxt/R3qLL+MOpeX2uo3WSzn4TERlG9v4UR0LE1odwW6/2QibGT9UVKZB+yG/nRU1JDwg
         7Dn+/PysQWOs666bgcelIP2y5TgfsehTEf2vd4JwRHPx3MFNJ02sh/OP5Sz8dzYG+p1n
         SFeemIK+cLIK+cJDiCKRrc7YtpRMuOr4frAA+VAjizIYsg6cv4XtDkV1XPivlxjw+IgQ
         d/Xg==
X-Gm-Message-State: AOAM530yoXkd90ZiEsVAkHeUTa2aDD3C84RUmS5GS1lKv0FblU+VNDfK
        IsDp+87D38/fjPEZwuz9qeKOhJQTz5Hvm/sXB8Gnh9XfIruWwTM91ZGnMI84uKjxEACenUus1nW
        4qJW5Vwa7msa63CeS5m3KmP4o
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr14438507wmr.179.1605520247241;
        Mon, 16 Nov 2020 01:50:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysy4H0AGXU4sqyTmIIkBPHVyFghUL0GznzWcsb550MbEY/P8U+UOZWEvnSZRrYpKJEFvf6wg==
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr14438489wmr.179.1605520247024;
        Mon, 16 Nov 2020 01:50:47 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
        by smtp.gmail.com with ESMTPSA id a144sm5284763wmd.47.2020.11.16.01.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 01:50:46 -0800 (PST)
Date:   Mon, 16 Nov 2020 04:50:43 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 12/12] vdpa_sim_blk: implement ramdisk behaviour
Message-ID: <20201116045029-mutt-send-email-mst@kernel.org>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-13-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113134712.69744-13-sgarzare@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 02:47:12PM +0100, Stefano Garzarella wrote:
> The previous implementation wrote only the status of each request.
> This patch implements a more accurate block device simulator,
> providing a ramdisk-like behavior.
> 
> Also handle VIRTIO_BLK_T_GET_ID request, always answering the
> "vdpa_blk_sim" string.

Maybe an ioctl to specify the id makes more sense.

> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 151 +++++++++++++++++++++++----
>  1 file changed, 133 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index 8e41b3ab98d5..68e74383322f 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/blkdev.h>
>  #include <uapi/linux/virtio_blk.h>
>  
>  #include "vdpa_sim.h"
> @@ -24,10 +25,137 @@
>  
>  static struct vdpasim *vdpasim_blk_dev;
>  
> +static int vdpasim_blk_handle_req(struct vdpasim *vdpasim,
> +				  struct vdpasim_virtqueue *vq)
> +{
> +	size_t wrote = 0, to_read = 0, to_write = 0;
> +	struct virtio_blk_outhdr hdr;
> +	uint8_t status;
> +	uint32_t type;
> +	ssize_t bytes;
> +	loff_t offset;
> +	int i, ret;
> +
> +	vringh_kiov_cleanup(&vq->riov);
> +	vringh_kiov_cleanup(&vq->wiov);
> +
> +	ret = vringh_getdesc_iotlb(&vq->vring, &vq->riov, &vq->wiov,
> +				   &vq->head, GFP_ATOMIC);
> +	if (ret != 1)
> +		return ret;
> +
> +	for (i = 0; i < vq->wiov.used; i++)
> +		to_write += vq->wiov.iov[i].iov_len;
> +	to_write -= 1; /* last byte is the status */
> +
> +	for (i = 0; i < vq->riov.used; i++)
> +		to_read += vq->riov.iov[i].iov_len;
> +
> +	bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->riov, &hdr, sizeof(hdr));
> +	if (bytes != sizeof(hdr))
> +		return 0;
> +
> +	to_read -= bytes;
> +
> +	type = le32_to_cpu(hdr.type);
> +	offset = le64_to_cpu(hdr.sector) << SECTOR_SHIFT;
> +	status = VIRTIO_BLK_S_OK;
> +
> +	switch (type) {
> +	case VIRTIO_BLK_T_IN:
> +		if (offset + to_write > VDPASIM_BLK_CAPACITY << SECTOR_SHIFT) {
> +			dev_err(&vdpasim->vdpa.dev,
> +				"reading over the capacity - offset: 0x%llx len: 0x%lx\n",
> +				offset, to_write);
> +			status = VIRTIO_BLK_S_IOERR;
> +			break;
> +		}
> +
> +		bytes = vringh_iov_push_iotlb(&vq->vring, &vq->wiov,
> +					      vdpasim->buffer + offset,
> +					      to_write);
> +		if (bytes < 0) {
> +			dev_err(&vdpasim->vdpa.dev,
> +				"vringh_iov_push_iotlb() error: %ld offset: 0x%llx len: 0x%lx\n",
> +				bytes, offset, to_write);
> +			status = VIRTIO_BLK_S_IOERR;
> +			break;
> +		}
> +
> +		wrote += bytes;
> +		break;
> +
> +	case VIRTIO_BLK_T_OUT:
> +		if (offset + to_read > VDPASIM_BLK_CAPACITY << SECTOR_SHIFT) {
> +			dev_err(&vdpasim->vdpa.dev,
> +				"writing over the capacity - offset: 0x%llx len: 0x%lx\n",
> +				offset, to_read);
> +			status = VIRTIO_BLK_S_IOERR;
> +			break;
> +		}
> +
> +		bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->riov,
> +					      vdpasim->buffer + offset,
> +					      to_read);
> +		if (bytes < 0) {
> +			dev_err(&vdpasim->vdpa.dev,
> +				"vringh_iov_pull_iotlb() error: %ld offset: 0x%llx len: 0x%lx\n",
> +				bytes, offset, to_read);
> +			status = VIRTIO_BLK_S_IOERR;
> +			break;
> +		}
> +		break;
> +
> +	case VIRTIO_BLK_T_GET_ID: {
> +		char id[VIRTIO_BLK_ID_BYTES] = "vdpa_blk_sim";
> +
> +		bytes = vringh_iov_push_iotlb(&vq->vring,
> +					      &vq->wiov, id,
> +					      VIRTIO_BLK_ID_BYTES);
> +		if (bytes < 0) {
> +			dev_err(&vdpasim->vdpa.dev,
> +				"vringh_iov_push_iotlb() error: %ld\n", bytes);
> +			status = VIRTIO_BLK_S_IOERR;
> +			break;
> +		}
> +
> +		wrote += bytes;
> +		break;
> +	}
> +
> +	default:
> +		dev_warn(&vdpasim->vdpa.dev,
> +			 "Unsupported request type %d\n", type);
> +		status = VIRTIO_BLK_S_IOERR;
> +		break;
> +	}
> +
> +	/* if VIRTIO_BLK_T_IN or VIRTIO_BLK_T_GET_ID fail, we need to skip
> +	 * the remaining bytes to put the status in the last byte
> +	 */
> +	if (to_write - wrote > 0) {
> +		vringh_iov_push_iotlb(&vq->vring, &vq->wiov, NULL,
> +				      to_write - wrote);
> +	}
> +
> +	/* last byte is the status */
> +	bytes = vringh_iov_push_iotlb(&vq->vring, &vq->wiov, &status, 1);
> +	if (bytes != 1)
> +		return 0;
> +
> +	wrote += bytes;
> +
> +	/* Make sure data is wrote before advancing index */
> +	smp_wmb();
> +
> +	vringh_complete_iotlb(&vq->vring, vq->head, wrote);
> +
> +	return ret;
> +}
> +
>  static void vdpasim_blk_work(struct work_struct *work)
>  {
>  	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
> -	u8 status = VIRTIO_BLK_S_OK;
>  	int i;
>  
>  	spin_lock(&vdpasim->lock);
> @@ -41,21 +169,7 @@ static void vdpasim_blk_work(struct work_struct *work)
>  		if (!vq->ready)
>  			continue;
>  
> -		while (vringh_getdesc_iotlb(&vq->vring, &vq->riov, &vq->wiov,
> -					    &vq->head, GFP_ATOMIC) > 0) {
> -
> -			int write;
> -
> -			vq->wiov.i = vq->wiov.used - 1;
> -			write = vringh_iov_push_iotlb(&vq->vring, &vq->wiov, &status, 1);
> -			if (write <= 0)
> -				break;
> -
> -			/* Make sure data is wrote before advancing index */
> -			smp_wmb();
> -
> -			vringh_complete_iotlb(&vq->vring, vq->head, write);
> -
> +		while (vdpasim_blk_handle_req(vdpasim, vq) > 0) {
>  			/* Make sure used is visible before rasing the interrupt. */
>  			smp_wmb();
>  
> @@ -67,6 +181,7 @@ static void vdpasim_blk_work(struct work_struct *work)
>  				vq->cb(vq->private);
>  			local_bh_enable();
>  		}
> +
>  	}
>  out:
>  	spin_unlock(&vdpasim->lock);
> @@ -84,7 +199,7 @@ static void vdpasim_blk_update_config(struct vdpasim *vdpasim)
>  	config->num_queues = cpu_to_vdpasim16(vdpasim, VDPASIM_BLK_VQ_NUM);
>  	config->min_io_size = cpu_to_vdpasim16(vdpasim, 1);
>  	config->opt_io_size = cpu_to_vdpasim32(vdpasim, 1);
> -	config->blk_size = cpu_to_vdpasim32(vdpasim, 512);
> +	config->blk_size = cpu_to_vdpasim32(vdpasim, SECTOR_SIZE);
>  }
>  
>  static int __init vdpasim_blk_init(void)
> @@ -100,7 +215,7 @@ static int __init vdpasim_blk_init(void)
>  	attr.device.update_config = vdpasim_blk_update_config;
>  
>  	attr.work_fn = vdpasim_blk_work;
> -	attr.buffer_size = PAGE_SIZE;
> +	attr.buffer_size = VDPASIM_BLK_CAPACITY << SECTOR_SHIFT;
>  
>  	vdpasim_blk_dev = vdpasim_create(&attr);
>  	if (IS_ERR(vdpasim_blk_dev)) {
> -- 
> 2.26.2

