Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371C62B3C14
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 05:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgKPEUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 23:20:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbgKPEUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 23:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605500408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b/zBHbSGh+sm8yLVC4/oST7xymuxq5Efw+Tm5E/iazs=;
        b=S74Y2bIvYs04mB6Q5fE3KSZoShwjExvRhk7C6NEPMyeeRE+dozmpRReC12Xe9/o74dCBy/
        0kMgrgvoGyWmHhyM370Oi4zB+TTPw3S9uj3YExZDhssRhyPwnDVkzL5EKvoKhXK5lsmucE
        8hWkOLr5+68YJJ0JxkLVSvRle7ScsH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-yEma_x8EPtyLRI7i3TqwDA-1; Sun, 15 Nov 2020 23:20:06 -0500
X-MC-Unique: yEma_x8EPtyLRI7i3TqwDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 989631074653;
        Mon, 16 Nov 2020 04:20:05 +0000 (UTC)
Received: from [10.72.13.126] (ovpn-13-126.pek2.redhat.com [10.72.13.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18EA860C84;
        Mon, 16 Nov 2020 04:19:56 +0000 (UTC)
Subject: Re: [PATCH RFC 09/12] vdpa_sim: make vdpasim->buffer size
 configurable
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-10-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <433bbdf4-b69c-7ae8-a734-923ffac646eb@redhat.com>
Date:   Mon, 16 Nov 2020 12:19:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-10-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/13 下午9:47, Stefano Garzarella wrote:
> Allow each device to specify the size of the buffer allocated
> in vdpa_sim.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.h     | 1 +
>   drivers/vdpa/vdpa_sim/vdpa_sim.c     | 2 +-
>   drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 1 +
>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 1 +
>   4 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> index f7e1fe0a88d3..cc21e07aa2f7 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -49,6 +49,7 @@ struct vdpasim_device {
>   
>   struct vdpasim_init_attr {
>   	struct vdpasim_device device;
> +	size_t buffer_size;
>   	int batch_mapping;
>   
>   	work_func_t	work_fn;
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index bd034fbf4683..3863d49e0d6d 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -223,7 +223,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
>   	if (!vdpasim->iommu)
>   		goto err_iommu;
>   
> -	vdpasim->buffer = kvmalloc(PAGE_SIZE, GFP_KERNEL);
> +	vdpasim->buffer = kvmalloc(attr->buffer_size, GFP_KERNEL);
>   	if (!vdpasim->buffer)
>   		goto err_iommu;
>   
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index f456a0e4e097..122a3c039507 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -100,6 +100,7 @@ static int __init vdpasim_blk_init(void)
>   	attr.device.update_config = vdpasim_blk_update_config;
>   
>   	attr.work_fn = vdpasim_blk_work;
> +	attr.buffer_size = PAGE_SIZE;
>   
>   	vdpasim_blk_dev = vdpasim_create(&attr);
>   	if (IS_ERR(vdpasim_blk_dev)) {
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> index b9372fdf2415..d0a1403f64b2 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -124,6 +124,7 @@ static int __init vdpasim_net_init(void)
>   
>   	attr.work_fn = vdpasim_net_work;
>   	attr.batch_mapping = batch_mapping;
> +	attr.buffer_size = PAGE_SIZE;
>   
>   	vdpasim_net_dev = vdpasim_create(&attr);
>   	if (IS_ERR(vdpasim_net_dev)) {

