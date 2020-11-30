Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9454D2C7D61
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgK3Dat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:30:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726304AbgK3Dat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606706962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GKKzsrpUozh4PU7wUtMTDjDRAex2JbMT/+19r/pxuBo=;
        b=BonLHe66ETxoq2YCtw80sAiN+ZcpxQigDEcbiGNWM2idGfOwkaxx50qV65WtTKK+d48XGs
        aHvtBCEy+XQKNnHJ+Oiui+eq/HxGuSnocgL8aQ2vYG53uGB6xTfYXFBsthez2xqnfMTZe1
        LoZ+3S134o5pBQx6ggzSQbIoOL1ogEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-iJ9iWcX4P0e550Bf4Qwlzw-1; Sun, 29 Nov 2020 22:29:19 -0500
X-MC-Unique: iJ9iWcX4P0e550Bf4Qwlzw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB158802B47;
        Mon, 30 Nov 2020 03:29:17 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6259F60C5F;
        Mon, 30 Nov 2020 03:29:09 +0000 (UTC)
Subject: Re: [PATCH v2 16/17] vdpa_sim: split vdpasim_virtqueue's iov field in
 out_iov and in_iov
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-17-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <5c01a00d-e7a9-2513-7e9f-39fc620c17c0@redhat.com>
Date:   Mon, 30 Nov 2020 11:29:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-17-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/26 下午10:49, Stefano Garzarella wrote:
> vringh_getdesc_iotlb() manages 2 iovs for writable and readable
> descriptors. This is very useful for the block device, where for
> each request we have both types of descriptor.
>
> Let's split the vdpasim_virtqueue's iov field in out_iov and
> in_iov to use them with vringh_getdesc_iotlb().
>
> We are using VIRTIO terminology for "out" (readable by the device)
> and "in" (writable by the device) descriptors.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v2:
> - used VIRTIO terminology [Stefan]
> ---


Acked-by: Jason Wang <jasowang@redhat.com>


>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index f5f41f20ee0b..f8ee261ef4ae 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -33,7 +33,8 @@ u8 macaddr_buf[ETH_ALEN];
>   
>   struct vdpasim_virtqueue {
>   	struct vringh vring;
> -	struct vringh_kiov iov;
> +	struct vringh_kiov in_iov;
> +	struct vringh_kiov out_iov;
>   	unsigned short head;
>   	bool ready;
>   	u64 desc_addr;
> @@ -197,12 +198,12 @@ static void vdpasim_net_work(struct work_struct *work)
>   
>   	while (true) {
>   		total_write = 0;
> -		err = vringh_getdesc_iotlb(&txq->vring, &txq->iov, NULL,
> +		err = vringh_getdesc_iotlb(&txq->vring, &txq->out_iov, NULL,
>   					   &txq->head, GFP_ATOMIC);
>   		if (err <= 0)
>   			break;
>   
> -		err = vringh_getdesc_iotlb(&rxq->vring, NULL, &rxq->iov,
> +		err = vringh_getdesc_iotlb(&rxq->vring, NULL, &rxq->in_iov,
>   					   &rxq->head, GFP_ATOMIC);
>   		if (err <= 0) {
>   			vringh_complete_iotlb(&txq->vring, txq->head, 0);
> @@ -210,13 +211,13 @@ static void vdpasim_net_work(struct work_struct *work)
>   		}
>   
>   		while (true) {
> -			read = vringh_iov_pull_iotlb(&txq->vring, &txq->iov,
> +			read = vringh_iov_pull_iotlb(&txq->vring, &txq->out_iov,
>   						     vdpasim->buffer,
>   						     PAGE_SIZE);
>   			if (read <= 0)
>   				break;
>   
> -			write = vringh_iov_push_iotlb(&rxq->vring, &rxq->iov,
> +			write = vringh_iov_push_iotlb(&rxq->vring, &rxq->in_iov,
>   						      vdpasim->buffer, read);
>   			if (write <= 0)
>   				break;

