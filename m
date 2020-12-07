Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5792D0A38
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 06:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgLGFcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 00:32:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33639 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgLGFcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 00:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607319084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d55VwrXw/oQIP2ez330kLeMcIKkbjKXF47nSb09mhYg=;
        b=KZ6ne07TSDB8in5k4Iy1ATf6wF682NW/w7MFGQHR1gqGQykkdKaxyQOoQH5hcaVi+C2y5l
        pKsoDo9j/kHAtoFldQ/GA0JX2FD4rVX9RHgIBSLTGF+gWMfpRoy0gHD5bjkfHlWMIEuav4
        TQddXUFCL95CE3ByEEaoLW9O4bu13Ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-1Bb0k3JvOu6PW9sbZ4OsJQ-1; Mon, 07 Dec 2020 00:31:19 -0500
X-MC-Unique: 1Bb0k3JvOu6PW9sbZ4OsJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A660A107ACE4;
        Mon,  7 Dec 2020 05:31:18 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8F545D9DC;
        Mon,  7 Dec 2020 05:31:00 +0000 (UTC)
Subject: Re: [PATCH v3 15/19] vdpa_sim: set vringh notify callback
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-16-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d9403e25-41a2-cfbe-efa9-8952b8e1b881@redhat.com>
Date:   Mon, 7 Dec 2020 13:30:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203170511.216407-16-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/4 上午1:05, Stefano Garzarella wrote:
> Instead of calling the vq callback directly, we can leverage the
> vringh_notify() function, adding vdpasim_vq_notify() and setting it
> in the vringh notify callback.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
> v3:
> - cleared notify during reset [Jason]
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 03a8717f80ea..1243b02488f7 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -123,6 +123,17 @@ static struct vdpasim *dev_to_sim(struct device *dev)
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
> @@ -134,6 +145,8 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>   			  (uintptr_t)vq->driver_addr,
>   			  (struct vring_used *)
>   			  (uintptr_t)vq->device_addr);
> +
> +	vq->vring.notify = vdpasim_vq_notify;
>   }
>   
>   static void vdpasim_vq_reset(struct vdpasim *vdpasim,
> @@ -147,6 +160,8 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
>   	vq->private = NULL;
>   	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
>   			  VDPASIM_QUEUE_MAX, false, NULL, NULL, NULL);
> +
> +	vq->vring.notify = NULL;
>   }
>   
>   static void vdpasim_reset(struct vdpasim *vdpasim)
> @@ -223,10 +238,10 @@ static void vdpasim_net_work(struct work_struct *work)
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

