Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D82D2B3C03
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 05:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgKPEMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 23:12:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726531AbgKPEMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 23:12:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605499955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7Vss3nxtQh7qgaw4fJV/OR1O3wbN/QeZ53EHIIQef8=;
        b=WfLX7DMxdn4VEGhyci4r98om1wybh46qE4bfXD/J1ZN8fi95zeQUSAiQznEc+Bgi3fPs/E
        Wlr/ZGfsAo/rHfNOqXYvEKBOihUN9X6aoqEhmLNXtwMdHhQ8LUShY2ZPRhPhxxCTds6QeR
        +SjtRFL7n+2UaJWFHT37p75uGAMoHe8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-7AP2DiVXP1KPnH_efDnqxQ-1; Sun, 15 Nov 2020 23:12:33 -0500
X-MC-Unique: 7AP2DiVXP1KPnH_efDnqxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FF4F8015FB;
        Mon, 16 Nov 2020 04:12:32 +0000 (UTC)
Received: from [10.72.13.126] (ovpn-13-126.pek2.redhat.com [10.72.13.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B26618439;
        Mon, 16 Nov 2020 04:12:23 +0000 (UTC)
Subject: Re: [PATCH RFC 05/12] vdpa_sim: remove the limit of IOTLB entries
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-6-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <67e0358e-0ae8-75e9-156f-4156f58387d9@redhat.com>
Date:   Mon, 16 Nov 2020 12:12:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-6-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/13 下午9:47, Stefano Garzarella wrote:
> The simulated devices can support multiple queues, so this limit
> should be defined according to the number of queues supported by
> the device.
>
> Since we are in a simulator, let's simply remove that limit.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>

It would be good to introduce a macro instead of using the magic 0 here.

Thanks


> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 2b4fea354413..9c9717441bbe 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -230,7 +230,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
>   		goto err_iommu;
>   	set_dma_ops(dev, &vdpasim_dma_ops);
>   
> -	vdpasim->iommu = vhost_iotlb_alloc(2048, 0);
> +	vdpasim->iommu = vhost_iotlb_alloc(0, 0);
>   	if (!vdpasim->iommu)
>   		goto err_iommu;
>   

