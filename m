Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852892C7D22
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgK3DIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:08:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbgK3DIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606705642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oFDCsOHChBGlkg+TMm2o2PNEDmkjytKBWO+agkAw40U=;
        b=DHwm2Q18tY+tHMwmI1FGyk18YK9LmYi+uIM8f+xNMHk6GacK/KpFj1VDp8egfoz83gWz/w
        54yhPTQkidth7LkkAX6W00jdwX2ZmaC4QwLcCnNXAEMGkYlYH4xFPLXMy0KaV51tkY+vXo
        6ql1AeiyP5RNs1xY0A9WkHU5wvDPlBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-T1TZrg1ZNgmpHuHKu6jruQ-1; Sun, 29 Nov 2020 22:07:20 -0500
X-MC-Unique: T1TZrg1ZNgmpHuHKu6jruQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1FDC879514;
        Mon, 30 Nov 2020 03:07:18 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 410735C1BB;
        Mon, 30 Nov 2020 03:07:10 +0000 (UTC)
Subject: Re: [PATCH v2 04/17] vdpa_sim: remove the limit of IOTLB entries
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-5-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <42989b66-9d53-cc2e-4d8e-5a93aad2efa1@redhat.com>
Date:   Mon, 30 Nov 2020 11:07:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-5-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/26 下午10:49, Stefano Garzarella wrote:
> The simulated devices can support multiple queues, so this limit
> should be defined according to the number of queues supported by
> the device.
>
> Since we are in a simulator, let's simply remove that limit.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v2:
> - added VDPASIM_IOTLB_LIMIT macro [Jason]


Sorry for being unclear. I meant adding a macro like

VHOST_IOTLB_UNLIMITED 0 in vhost_iotlb.h.

And use that in vdpa_sim.

Thanks


> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index ad72f7b1a4eb..40664d87f303 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -46,6 +46,7 @@ struct vdpasim_virtqueue {
>   #define VDPASIM_QUEUE_MAX 256
>   #define VDPASIM_DEVICE_ID 0x1
>   #define VDPASIM_VENDOR_ID 0
> +#define VDPASIM_IOTLB_LIMIT 0 /* unlimited */
>   #define VDPASIM_VQ_NUM 0x2
>   #define VDPASIM_NAME "vdpasim-netdev"
>   
> @@ -365,7 +366,7 @@ static struct vdpasim *vdpasim_create(void)
>   	if (!vdpasim->vqs)
>   		goto err_iommu;
>   
> -	vdpasim->iommu = vhost_iotlb_alloc(2048, 0);
> +	vdpasim->iommu = vhost_iotlb_alloc(VDPASIM_IOTLB_LIMIT, 0);
>   	if (!vdpasim->iommu)
>   		goto err_iommu;
>   

