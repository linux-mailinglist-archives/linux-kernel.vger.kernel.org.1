Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F24B2DCBBA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 05:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgLQEbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 23:31:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbgLQEbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 23:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608179407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QdO71qRUUAyY5eL/yMHU3bjLmoNw6kNHGPr/hpOtBbg=;
        b=Y8WJxYxO5YpQFOP/vmlq+VN7pMoE5pfQVafgPa8VfmZ8pDc2hpgubo+ZJbZmmHbDSyWotv
        cD2Ij2KKktOUOlSPzflZSp4MuxF1JACun0bpd1RKSAYaQxLVZ0rKs6Ktki3qF91bZLw0QK
        MREmxlBYSEQB/dc1Meb8Vn9nK0XF+YI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-ZG7HCQpgMceVHl9ij-eGrQ-1; Wed, 16 Dec 2020 23:30:02 -0500
X-MC-Unique: ZG7HCQpgMceVHl9ij-eGrQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E65A6100F340;
        Thu, 17 Dec 2020 04:30:00 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2210F19814;
        Thu, 17 Dec 2020 04:29:49 +0000 (UTC)
Subject: Re: [PATCH v4 04/18] vdpa_sim: make IOTLB entries limit configurable
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Oren Duer <oren@nvidia.com>, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shahaf Shuler <shahafs@nvidia.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        linux-kernel@vger.kernel.org
References: <20201215144256.155342-1-sgarzare@redhat.com>
 <20201215144256.155342-5-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <648d7b72-134c-0dfb-8d91-8c2eda51e86c@redhat.com>
Date:   Thu, 17 Dec 2020 12:29:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201215144256.155342-5-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/15 下午10:42, Stefano Garzarella wrote:
> Some devices may require a higher limit for the number of IOTLB
> entries, so let's make it configurable through a module parameter.
>
> By default, it's initialized with the current limit (2048).
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 07ccc8609784..d716bfaadb3b 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -31,6 +31,11 @@ static int batch_mapping = 1;
>   module_param(batch_mapping, int, 0444);
>   MODULE_PARM_DESC(batch_mapping, "Batched mapping 1 -Enable; 0 - Disable");
>   
> +static int max_iotlb_entries = 2048;
> +module_param(max_iotlb_entries, int, 0444);
> +MODULE_PARM_DESC(max_iotlb_entries,
> +		 "Maximum number of iotlb entries. 0 means unlimited. (default: 2048)");
> +
>   static char *macaddr;
>   module_param(macaddr, charp, 0);
>   MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
> @@ -371,7 +376,7 @@ static struct vdpasim *vdpasim_create(void)
>   	if (!vdpasim->vqs)
>   		goto err_iommu;
>   
> -	vdpasim->iommu = vhost_iotlb_alloc(2048, 0);
> +	vdpasim->iommu = vhost_iotlb_alloc(max_iotlb_entries, 0);
>   	if (!vdpasim->iommu)
>   		goto err_iommu;
>   

