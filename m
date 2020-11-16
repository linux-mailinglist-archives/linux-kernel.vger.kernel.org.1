Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1742B423E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgKPLIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:08:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgKPLIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605524892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZXX/wZqiroUfD/O74sRJcUfHvErWOcCKorfJ8YBwuSM=;
        b=LJdCOgP99pen6+gmpoWHEhukfH0B8mTP1n5iQ1BWtPZvRODHGh74HLDZFvKRLWaUxjv/+N
        snxTHXKICaJ2EOYa0Ia27yUqU3KQ4TIOuphNgsh63NlmYUVu7R8oMeKkDQV1NHa/HX6t/j
        Fq6bhCfA8coe+i0IjCqYCy2D7tkMaQA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-i1bmGA-dNWq-QJ_ficXIoA-1; Mon, 16 Nov 2020 06:08:09 -0500
X-MC-Unique: i1bmGA-dNWq-QJ_ficXIoA-1
Received: by mail-wm1-f71.google.com with SMTP id y1so10063997wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:08:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZXX/wZqiroUfD/O74sRJcUfHvErWOcCKorfJ8YBwuSM=;
        b=jbiKasyevLI6YLfy5dfipb7m23H+DS53MV7KKVUdZL23GHAXTCX+pa7AKltEWdk+8G
         T+SBL2QAgFC26/+NOV81Is9AjAkNLxEv0GG/FcaCWwU2WIuqYFifeVXK9mVm3E9ARuO8
         Lw2OYHguVLW9hUIlKMIr0p/rri/0Sfs3AK9NB5NECFHJlQjLZpcgWTgD1v1P3pbyAt77
         ssbgOJPYelprzu/7NytYY2qxZ7All7qD7P0NWtw2yVjN7RPSYpr6sYHnqt6k2l0FgOWg
         QB1Cs5vbLY6wE5dRlvczabhD8hVf4HakMkt5Ibtoti5Ub/4BHB0SK1jKBAxxuQZ4tzX4
         OuaQ==
X-Gm-Message-State: AOAM530IDWJQAGJjh8yrigeJO8U4XHwf/8xwdxm0ghgoJTetLx8PZGjD
        pbBe0YOdIFlJC1ex810CvCCMa/arxfPV18P4HzGeCg8vTzoPYY6Uqy8bBvtax38RVR84aJZrWs9
        YQRVOayNwqCX0/Md5S+z5pnHW
X-Received: by 2002:adf:f602:: with SMTP id t2mr7940581wrp.40.1605524888368;
        Mon, 16 Nov 2020 03:08:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxz0hQkQCVM7hHaRIfa6NDF4VzNeIvWdO00UDUV/f+MZSCAifF0VGRZOYOApyIH9wUNSun9jA==
X-Received: by 2002:adf:f602:: with SMTP id t2mr7940555wrp.40.1605524888154;
        Mon, 16 Nov 2020 03:08:08 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id p10sm22850438wre.2.2020.11.16.03.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 03:08:07 -0800 (PST)
Date:   Mon, 16 Nov 2020 12:08:05 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 12/12] vdpa_sim_blk: implement ramdisk behaviour
Message-ID: <20201116110805.efspwzkuw2sdnaca@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-13-sgarzare@redhat.com>
 <56d8c992-44ca-f365-fb92-f5da94896680@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56d8c992-44ca-f365-fb92-f5da94896680@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 01:25:31PM +0800, Jason Wang wrote:
>
>On 2020/11/13 下午9:47, Stefano Garzarella wrote:
>>The previous implementation wrote only the status of each request.
>>This patch implements a more accurate block device simulator,
>>providing a ramdisk-like behavior.
>>
>>Also handle VIRTIO_BLK_T_GET_ID request, always answering the
>>"vdpa_blk_sim" string.
>
>
>Let's use a separate patch for this.
>

Okay, I'll do.

>
>>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 151 +++++++++++++++++++++++----
>>  1 file changed, 133 insertions(+), 18 deletions(-)
>>
>>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>>index 8e41b3ab98d5..68e74383322f 100644
>>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>>@@ -7,6 +7,7 @@
>>   */
>>  #include <linux/module.h>
>>+#include <linux/blkdev.h>
>>  #include <uapi/linux/virtio_blk.h>
>>  #include "vdpa_sim.h"
>>@@ -24,10 +25,137 @@
>>  static struct vdpasim *vdpasim_blk_dev;
>>+static int vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>>+				  struct vdpasim_virtqueue *vq)
>>+{
>>+	size_t wrote = 0, to_read = 0, to_write = 0;
>>+	struct virtio_blk_outhdr hdr;
>>+	uint8_t status;
>>+	uint32_t type;
>>+	ssize_t bytes;
>>+	loff_t offset;
>>+	int i, ret;
>>+
>>+	vringh_kiov_cleanup(&vq->riov);
>>+	vringh_kiov_cleanup(&vq->wiov);
>
>
>It looks to me we should do those after vringh_get_desc_iotlb()? See 
>comment above vringh_getdesc_kern().

Do you mean after the last vringh_iov_push_iotlb()?

Because vringh_kiov_cleanup() will free the allocated iov[].

>
>
>>+
>>+	ret = vringh_getdesc_iotlb(&vq->vring, &vq->riov, &vq->wiov,
>>+				   &vq->head, GFP_ATOMIC);
>>+	if (ret != 1)
>>+		return ret;
>>+
>>+	for (i = 0; i < vq->wiov.used; i++)
>>+		to_write += vq->wiov.iov[i].iov_len;
>
>
>It's better to introduce a helper for this (or consider to use iov 
>iterator).

Okay, I'll try to find the best solution.

>
>
>>+	to_write -= 1; /* last byte is the status */
>>+
>>+	for (i = 0; i < vq->riov.used; i++)
>>+		to_read += vq->riov.iov[i].iov_len;
>>+
>>+	bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->riov, &hdr, sizeof(hdr));
>>+	if (bytes != sizeof(hdr))
>>+		return 0;
>>+
>>+	to_read -= bytes;
>>+
>>+	type = le32_to_cpu(hdr.type);
>>+	offset = le64_to_cpu(hdr.sector) << SECTOR_SHIFT;
>>+	status = VIRTIO_BLK_S_OK;
>>+
>>+	switch (type) {
>>+	case VIRTIO_BLK_T_IN:
>>+		if (offset + to_write > VDPASIM_BLK_CAPACITY << 
>>SECTOR_SHIFT) {
>>+			dev_err(&vdpasim->vdpa.dev,
>>+				"reading over the capacity - offset: 
>>0x%llx len: 0x%lx\n",
>>+				offset, to_write);
>>+			status = VIRTIO_BLK_S_IOERR;
>>+			break;
>>+		}
>>+
>>+		bytes = vringh_iov_push_iotlb(&vq->vring, &vq->wiov,
>>+					      vdpasim->buffer + offset,
>>+					      to_write);
>>+		if (bytes < 0) {
>>+			dev_err(&vdpasim->vdpa.dev,
>>+				"vringh_iov_push_iotlb() error: %ld offset: 0x%llx len: 0x%lx\n",
>>+				bytes, offset, to_write);
>>+			status = VIRTIO_BLK_S_IOERR;
>>+			break;
>>+		}
>>+
>>+		wrote += bytes;
>>+		break;
>>+
>>+	case VIRTIO_BLK_T_OUT:
>>+		if (offset + to_read > VDPASIM_BLK_CAPACITY << SECTOR_SHIFT) {
>>+			dev_err(&vdpasim->vdpa.dev,
>>+				"writing over the capacity - offset: 0x%llx len: 0x%lx\n",
>>+				offset, to_read);
>>+			status = VIRTIO_BLK_S_IOERR;
>>+			break;
>>+		}
>>+
>>+		bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->riov,
>>+					      vdpasim->buffer + offset,
>>+					      to_read);
>>+		if (bytes < 0) {
>>+			dev_err(&vdpasim->vdpa.dev,
>>+				"vringh_iov_pull_iotlb() error: %ld offset: 0x%llx len: 0x%lx\n",
>>+				bytes, offset, to_read);
>>+			status = VIRTIO_BLK_S_IOERR;
>>+			break;
>>+		}
>>+		break;
>>+
>>+	case VIRTIO_BLK_T_GET_ID: {
>>+		char id[VIRTIO_BLK_ID_BYTES] = "vdpa_blk_sim";
>
>
>Let's use a global static one?

I'll do.

>
>
>>+
>>+		bytes = vringh_iov_push_iotlb(&vq->vring,
>>+					      &vq->wiov, id,
>>+					      VIRTIO_BLK_ID_BYTES);
>>+		if (bytes < 0) {
>>+			dev_err(&vdpasim->vdpa.dev,
>>+				"vringh_iov_push_iotlb() error: %ld\n", bytes);
>>+			status = VIRTIO_BLK_S_IOERR;
>>+			break;
>>+		}
>>+
>>+		wrote += bytes;
>>+		break;
>>+	}
>>+
>>+	default:
>>+		dev_warn(&vdpasim->vdpa.dev,
>>+			 "Unsupported request type %d\n", type);
>>+		status = VIRTIO_BLK_S_IOERR;
>>+		break;
>>+	}
>>+
>>+	/* if VIRTIO_BLK_T_IN or VIRTIO_BLK_T_GET_ID fail, we need to skip
>>+	 * the remaining bytes to put the status in the last byte
>>+	 */
>>+	if (to_write - wrote > 0) {
>>+		vringh_iov_push_iotlb(&vq->vring, &vq->wiov, NULL,
>>+				      to_write - wrote);
>>+	}
>>+
>>+	/* last byte is the status */
>>+	bytes = vringh_iov_push_iotlb(&vq->vring, &vq->wiov, &status, 1);
>>+	if (bytes != 1)
>>+		return 0;
>>+
>>+	wrote += bytes;
>>+
>>+	/* Make sure data is wrote before advancing index */
>>+	smp_wmb();
>>+
>>+	vringh_complete_iotlb(&vq->vring, vq->head, wrote);
>>+
>>+	return ret;
>>+}
>>+
>>  static void vdpasim_blk_work(struct work_struct *work)
>>  {
>>  	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
>>-	u8 status = VIRTIO_BLK_S_OK;
>>  	int i;
>>  	spin_lock(&vdpasim->lock);
>>@@ -41,21 +169,7 @@ static void vdpasim_blk_work(struct work_struct *work)
>>  		if (!vq->ready)
>>  			continue;
>>-		while (vringh_getdesc_iotlb(&vq->vring, &vq->riov, &vq->wiov,
>>-					    &vq->head, GFP_ATOMIC) > 0) {
>>-
>>-			int write;
>>-
>>-			vq->wiov.i = vq->wiov.used - 1;
>>-			write = vringh_iov_push_iotlb(&vq->vring, &vq->wiov, &status, 1);
>>-			if (write <= 0)
>>-				break;
>>-
>>-			/* Make sure data is wrote before advancing 
>>index */
>>-			smp_wmb();
>>-
>>-			vringh_complete_iotlb(&vq->vring, vq->head, write);
>>-
>>+		while (vdpasim_blk_handle_req(vdpasim, vq) > 0) {
>>  			/* Make sure used is visible before rasing the interrupt. */
>>  			smp_wmb();
>>@@ -67,6 +181,7 @@ static void vdpasim_blk_work(struct work_struct *work)
>>  				vq->cb(vq->private);
>>  			local_bh_enable();
>>  		}
>>+
>
>
>Unnecessary change.

Removed.

Thanks,
Stefano

