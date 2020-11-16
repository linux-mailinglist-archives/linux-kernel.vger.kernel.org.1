Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1192B3C13
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 05:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgKPETb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 23:19:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbgKPETa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 23:19:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605500370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oRixjjrThv6WRA1ni2cjNfsJ7/babpRlPyaRC5yiRXI=;
        b=RUZJqldG4g662FnR2sSAq8ZtgZpki9YSOQYzMtMwnXTBLa8qtbtVnPaqSePbDM1M7tB2U8
        CTpimkzM6W2UmQmrjArFdgoFN1FOwPPTFWmziF42JeSvi5otINfrPKLu7xNUMO7h/WjeIO
        zjb/JOUaTazvswdaoBHDGtpyq0arXlg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-JbdGTnARPB-1fZl4jQsoxA-1; Sun, 15 Nov 2020 23:19:28 -0500
X-MC-Unique: JbdGTnARPB-1fZl4jQsoxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39A451074654;
        Mon, 16 Nov 2020 04:19:27 +0000 (UTC)
Received: from [10.72.13.126] (ovpn-13-126.pek2.redhat.com [10.72.13.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 367795D9CC;
        Mon, 16 Nov 2020 04:19:18 +0000 (UTC)
Subject: Re: [PATCH RFC 08/12] vdpa_sim: use kvmalloc to allocate
 vdpasim->buffer
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-9-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9956d3c1-8464-ef70-a21a-7abaaa948fd2@redhat.com>
Date:   Mon, 16 Nov 2020 12:19:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-9-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/13 下午9:47, Stefano Garzarella wrote:
> The next patch will make the buffer size configurable from each
> device.
> Since the buffer could be larger than a page, we use kvmalloc()
> instead of kmalloc().
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 9c29c2013661..bd034fbf4683 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -223,7 +223,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
>   	if (!vdpasim->iommu)
>   		goto err_iommu;
>   
> -	vdpasim->buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	vdpasim->buffer = kvmalloc(PAGE_SIZE, GFP_KERNEL);
>   	if (!vdpasim->buffer)
>   		goto err_iommu;
>   
> @@ -495,7 +495,7 @@ static void vdpasim_free(struct vdpa_device *vdpa)
>   	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>   
>   	cancel_work_sync(&vdpasim->work);
> -	kfree(vdpasim->buffer);
> +	kvfree(vdpasim->buffer);
>   	if (vdpasim->iommu)
>   		vhost_iotlb_free(vdpasim->iommu);
>   	kfree(vdpasim->vqs);

