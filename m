Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C232C7D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgK3D3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:29:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbgK3D3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606706887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+ktcSCRfDfRJj94km371nTtLoxOjOvm9VnMZIoOpy4=;
        b=Th29JUBzDav0AxCGwFtnW2rjoA8AmzWY9Qw6oZd1CWF1tQlVluXmJDzOIGkaEqhBy4J0sH
        OMBiVNZCWV/iZdklbA4vFZA1X46yd+xoasRHxTU6Lkluui8m1TF9+UJ7+jMHMBVbbtlQjx
        P6nIfITZDhITv6BZvTK/Z4gIHGaqxB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-mRD_QdrDMKy7xeEWn7PLGQ-1; Sun, 29 Nov 2020 22:28:05 -0500
X-MC-Unique: mRD_QdrDMKy7xeEWn7PLGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 983381842141;
        Mon, 30 Nov 2020 03:28:04 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BD6E60C5F;
        Mon, 30 Nov 2020 03:27:52 +0000 (UTC)
Subject: Re: [PATCH v2 13/17] vdpa_sim: set vringh notify callback
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-14-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <5569e198-22be-514a-744a-1bef9a3b95ce@redhat.com>
Date:   Mon, 30 Nov 2020 11:27:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-14-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/26 下午10:49, Stefano Garzarella wrote:
> Instead of calling the vq callback directly, we can leverage the
> vringh_notify() function, adding vdpasim_vq_notify() and setting it
> in the vringh notify callback.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 8b87ce0485b6..4327efd6d41e 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -120,6 +120,17 @@ static struct vdpasim *dev_to_sim(struct device *dev)
>   	return vdpa_to_sim(vdpa);
>   }
>   
> +static void vdpasim_vq_notify(struct vringh *vring)
> +{
> +	struct vdpasim_virtqueue *vq =
> +		container_of(vring, struct vdpasim_virtqueue, vring);
> +
> +	if (!vq->cb)
> +		return;
> +
> +	vq->cb(vq->private);
> +}
> +
>   static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>   {
>   	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
> @@ -131,6 +142,8 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>   			  (uintptr_t)vq->driver_addr,
>   			  (struct vring_used *)
>   			  (uintptr_t)vq->device_addr);
> +
> +	vq->vring.notify = vdpasim_vq_notify;


Do we need to clear notify during reset?

Other looks good.


>   }
>   
>   static void vdpasim_vq_reset(struct vdpasim *vdpasim,
> @@ -220,10 +233,10 @@ static void vdpasim_net_work(struct work_struct *work)
>   		smp_wmb();
>   
>   		local_bh_disable();
> -		if (txq->cb)
> -			txq->cb(txq->private);
> -		if (rxq->cb)
> -			rxq->cb(rxq->private);
> +		if (vringh_need_notify_iotlb(&txq->vring) > 0)
> +			vringh_notify(&txq->vring);
> +		if (vringh_need_notify_iotlb(&rxq->vring) > 0)
> +			vringh_notify(&rxq->vring);
>   		local_bh_enable();
>   
>   		if (++pkts > 4) {

