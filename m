Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E87D2C7D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgK3DMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:12:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbgK3DMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606705855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4KewpQpJ2xxc8QiHxV7xo3WlelLLRPqTYNLbo5LfcAc=;
        b=ChVcprNsLfIZ6uSVX21L+WqmhilLTM2J5wtkUmzGTSvFOSAXEa1RtR7a2t9kIAu+1iY7A/
        HHE7f664VfdZAJF+Hoe5uyjJhXvZ6vYbwuf+nEvYiit0BUgGtubSN1973ZF4pMNJjSkEKd
        CtNdaaPXDJGCPScJuuOID0jBieorCbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-C6Wd65HPOQ-cARkVP5vysw-1; Sun, 29 Nov 2020 22:10:51 -0500
X-MC-Unique: C6Wd65HPOQ-cARkVP5vysw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BFD957202;
        Mon, 30 Nov 2020 03:10:50 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D2E727C26;
        Mon, 30 Nov 2020 03:10:39 +0000 (UTC)
Subject: Re: [PATCH v2 07/17] vdpa_sim: add device id field in
 vdpasim_dev_attr
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-8-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <0fb8b4be-4287-6bff-e430-3c9e8aae0daa@redhat.com>
Date:   Mon, 30 Nov 2020 11:10:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-8-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/26 下午10:49, Stefano Garzarella wrote:
> Remove VDPASIM_DEVICE_ID macro and add 'id' field in vdpasim_dev_attr,
> that will be returned by vdpasim_get_device_id().
>
> Use VIRTIO_ID_NET for vDPA-net simulator device id.
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
> index f98262add0e1..393b54a9f0e4 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -44,7 +44,6 @@ struct vdpasim_virtqueue {
>   
>   #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
>   #define VDPASIM_QUEUE_MAX 256
> -#define VDPASIM_DEVICE_ID 0x1
>   #define VDPASIM_VENDOR_ID 0
>   #define VDPASIM_IOTLB_LIMIT 0 /* unlimited */
>   #define VDPASIM_VQ_NUM 0x2
> @@ -57,6 +56,7 @@ static u64 vdpasim_features = (1ULL << VIRTIO_F_ANY_LAYOUT) |
>   
>   struct vdpasim_dev_attr {
>   	int nvqs;
> +	u32 id;
>   };
>   
>   /* State of each vdpasim device */
> @@ -536,7 +536,9 @@ static u16 vdpasim_get_vq_num_max(struct vdpa_device *vdpa)
>   
>   static u32 vdpasim_get_device_id(struct vdpa_device *vdpa)
>   {
> -	return VDPASIM_DEVICE_ID;
> +	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> +
> +	return vdpasim->dev_attr.id;
>   }
>   
>   static u32 vdpasim_get_vendor_id(struct vdpa_device *vdpa)
> @@ -719,6 +721,7 @@ static int __init vdpasim_dev_init(void)
>   {
>   	struct vdpasim_dev_attr dev_attr = {};
>   
> +	dev_attr.id = VIRTIO_ID_NET;
>   	dev_attr.nvqs = VDPASIM_VQ_NUM;
>   
>   	vdpasim_dev = vdpasim_create(&dev_attr);

