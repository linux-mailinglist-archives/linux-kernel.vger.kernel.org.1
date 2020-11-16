Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209C62B3C95
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 06:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgKPFZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 00:25:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21590 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbgKPFZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 00:25:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605504350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=idWyoh7qRbmkwmAn0b59fT2mdkgJ00GkL/2MJYUzIjo=;
        b=e8bai97ithVujj29iog96SA1D5Xv7SHRVLlBUkIURTqvMVuXjcdL9XygPNxwE/z49XGXUo
        jgD/ml4QcS16UbCf0G9Wu3zSOVNuPQ1wECJjT5l7OaBq+HPKDkWuc67t9XRjs0EYfwMc6g
        8o8fQWk77tMWYK4uEdHLUg7pDcUEiLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-4WXemXDFM6qUD7zKhShcKw-1; Mon, 16 Nov 2020 00:25:44 -0500
X-MC-Unique: 4WXemXDFM6qUD7zKhShcKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CF5710074C5;
        Mon, 16 Nov 2020 05:25:43 +0000 (UTC)
Received: from [10.72.13.92] (ovpn-13-92.pek2.redhat.com [10.72.13.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A83466B8E5;
        Mon, 16 Nov 2020 05:25:33 +0000 (UTC)
Subject: Re: [PATCH RFC 12/12] vdpa_sim_blk: implement ramdisk behaviour
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-13-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <56d8c992-44ca-f365-fb92-f5da94896680@redhat.com>
Date:   Mon, 16 Nov 2020 13:25:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-13-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/13 下午9:47, Stefano Garzarella wrote:
> The previous implementation wrote only the status of each request.
> This patch implements a more accurate block device simulator,
> providing a ramdisk-like behavior.
>
> Also handle VIRTIO_BLK_T_GET_ID request, always answering the
> "vdpa_blk_sim" string.


Let's use a separate patch for this.


>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 151 +++++++++++++++++++++++----
>   1 file changed, 133 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index 8e41b3ab98d5..68e74383322f 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -7,6 +7,7 @@
>    */
>   
>   #include <linux/module.h>
> +#include <linux/blkdev.h>
>   #include <uapi/linux/virtio_blk.h>
>   
>   #include "vdpa_sim.h"
> @@ -24,10 +25,137 @@
>   
>   static struct vdpasim *vdpasim_blk_dev;
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


It looks to me we should do those after vringh_get_desc_iotlb()? See 
comment above vringh_getdesc_kern().


> +
> +	ret = vringh_getdesc_iotlb(&vq->vring, &vq->riov, &vq->wiov,
> +				   &vq->head, GFP_ATOMIC);
> +	if (ret != 1)
> +		return ret;
> +
> +	for (i = 0; i < vq->wiov.used; i++)
> +		to_write += vq->wiov.iov[i].iov_len;


It's better to introduce a helper for this (or consider to use iov 
iterator).


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


Let's use a global static one?


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
>   static void vdpasim_blk_work(struct work_struct *work)
>   {
>   	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
> -	u8 status = VIRTIO_BLK_S_OK;
>   	int i;
>   
>   	spin_lock(&vdpasim->lock);
> @@ -41,21 +169,7 @@ static void vdpasim_blk_work(struct work_struct *work)
>   		if (!vq->ready)
>   			continue;
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
>   			/* Make sure used is visible before rasing the interrupt. */
>   			smp_wmb();
>   
> @@ -67,6 +181,7 @@ static void vdpasim_blk_work(struct work_struct *work)
>   				vq->cb(vq->private);
>   			local_bh_enable();
>   		}
> +


Unnecessary change.

Thanks


