Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BFF2C7D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgK3DRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:17:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726188AbgK3DRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606706180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3YOBvfhhlFFo3dwfriq09oew+AgJp9hrH3M7EIqOG/o=;
        b=Xr/cSmwNk8kv8tkdq/fVesX0lUa67+tUgh7zXGt5ix/m05I7ieACzOO6JckZqfySpbm14h
        sY35oVdYyrhhFtz4RQwdzDHBih+VAKhy8M9T3w9FPtu4BkWcLpeMvnJZnQLUbG5UZ8fkjW
        IaiLNCAYRwPT1LFPjnmRClky4ff5vd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-7lw4UWtvM06MFf3UiC0MfQ-1; Sun, 29 Nov 2020 22:16:18 -0500
X-MC-Unique: 7lw4UWtvM06MFf3UiC0MfQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 778C11E7EF;
        Mon, 30 Nov 2020 03:16:17 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F6135D9D2;
        Mon, 30 Nov 2020 03:16:08 +0000 (UTC)
Subject: Re: [PATCH v2 09/17] vdpa_sim: add work_fn in vdpasim_dev_attr
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-10-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6824a28b-8611-d83e-259c-d84be8513683@redhat.com>
Date:   Mon, 30 Nov 2020 11:16:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-10-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/26 下午10:49, Stefano Garzarella wrote:
> Rename vdpasim_work() in vdpasim_net_work() and add it to
> the vdpasim_dev_attr structure.
>
> Co-developed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)


Acked-by: Jason Wang <jasowang@redhat.com>


>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 36677fc3631b..b84d9acd130c 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -60,6 +60,8 @@ struct vdpasim_dev_attr {
>   	u64 supported_features;
>   	int nvqs;
>   	u32 id;
> +
> +	work_func_t work_fn;
>   };
>   
>   /* State of each vdpasim device */
> @@ -153,7 +155,7 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
>   	++vdpasim->generation;
>   }
>   
> -static void vdpasim_work(struct work_struct *work)
> +static void vdpasim_net_work(struct work_struct *work)
>   {
>   	struct vdpasim *vdpasim = container_of(work, struct
>   						 vdpasim, work);
> @@ -360,7 +362,7 @@ static struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
>   		goto err_alloc;
>   
>   	vdpasim->dev_attr = *dev_attr;
> -	INIT_WORK(&vdpasim->work, vdpasim_work);
> +	INIT_WORK(&vdpasim->work, dev_attr->work_fn);
>   	spin_lock_init(&vdpasim->lock);
>   	spin_lock_init(&vdpasim->iommu_lock);
>   
> @@ -730,6 +732,7 @@ static int __init vdpasim_dev_init(void)
>   	dev_attr.id = VIRTIO_ID_NET;
>   	dev_attr.supported_features = VDPASIM_NET_FEATURES;
>   	dev_attr.nvqs = VDPASIM_VQ_NUM;
> +	dev_attr.work_fn = vdpasim_net_work;
>   
>   	vdpasim_dev = vdpasim_create(&dev_attr);
>   

