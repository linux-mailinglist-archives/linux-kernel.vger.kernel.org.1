Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2932D2D099C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 05:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgLGEB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 23:01:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46588 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbgLGEB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 23:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607313630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xNjTsielO4F3/rlOTAeVEcwEo4ih/pfIX8Fxa5vfASY=;
        b=WUuCyscMV/0uDf1w7m0rjckAcT7G1C7Cc9Eu0v0L9mGmCeWEavnLWeVmstO5+KSyzf10Ex
        k7zjr6PSzTGKzPWuqlXntAKsnqul4pMBexKbioq1bpvvsvuedH5u+olmMIaxyY5cZlcr3C
        pnrNKfjwCRxoKERo+GN03ui6u5imI/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-fGf-jxRoOX-zOv3r-DnZCg-1; Sun, 06 Dec 2020 23:00:29 -0500
X-MC-Unique: fGf-jxRoOX-zOv3r-DnZCg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A61581CAF6;
        Mon,  7 Dec 2020 04:00:27 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA2A25C1BB;
        Mon,  7 Dec 2020 04:00:08 +0000 (UTC)
Subject: Re: [PATCH v3 05/19] vdpa_sim: remove the limit of IOTLB entries
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-6-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d7b00b70-9785-db1f-1e42-7b9172b7ad90@redhat.com>
Date:   Mon, 7 Dec 2020 12:00:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203170511.216407-6-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/4 上午1:04, Stefano Garzarella wrote:
> The simulated devices can support multiple queues, so this limit
> should be defined according to the number of queues supported by
> the device.
>
> Since we are in a simulator, let's simply remove that limit.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


Rethink about this, since simulator can be used by VM, so the allocation 
is actually guest trigger-able when vIOMMU is enabled.

This means we need a limit somehow, (e.g I remember swiotlb is about 
64MB by default). Or having a module parameter for this.

Btw, have you met any issue when using 2048, I guess it can happen when 
we run several processes in parallel?


> ---
> v3:
> - used VHOST_IOTLB_UNLIMITED macro [Jason]
> v2:
> - added VDPASIM_IOTLB_LIMIT macro [Jason]
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 295a770caac0..688aceaa6543 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -368,7 +368,7 @@ static struct vdpasim *vdpasim_create(void)
>   	if (!vdpasim->vqs)
>   		goto err_iommu;
>   
> -	vdpasim->iommu = vhost_iotlb_alloc(2048, 0);
> +	vdpasim->iommu = vhost_iotlb_alloc(VHOST_IOTLB_UNLIMITED, 0);
>   	if (!vdpasim->iommu)
>   		goto err_iommu;
>   

