Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24572D0A36
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 06:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgLGFa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 00:30:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725681AbgLGFa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 00:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607318971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p9SyX3Wbogf9IuwRBc6i2Dzncrlgn1ZL50RBQLD9/wk=;
        b=Ymu1xTBQRbyOvIWYyTyN5PTUvY77CZnTY1wTJXJtqpyYu1wMc97VdYtMwQ4Ylx+IhaAOsT
        ZGBrxTp7v/GwB+7n1GZrYzrspvHTX4SXcC7haGz2tBCY6Vg0YCOmruOHa9W5CpB6WZ8IoG
        vsOTMMs9KQfOucb57+fNzjANkY0qnjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-ffOF8WXdNR2oi5-NL-dTHA-1; Mon, 07 Dec 2020 00:29:29 -0500
X-MC-Unique: ffOF8WXdNR2oi5-NL-dTHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6703C801B12;
        Mon,  7 Dec 2020 05:29:28 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BACC6614EB;
        Mon,  7 Dec 2020 05:29:18 +0000 (UTC)
Subject: Re: [PATCH v3 13/19] vdpa_sim: add get_config callback in
 vdpasim_dev_attr
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-14-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <829a5026-a68c-6d02-49ef-f237dcae2460@redhat.com>
Date:   Mon, 7 Dec 2020 13:29:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203170511.216407-14-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/4 上午1:05, Stefano Garzarella wrote:
> The get_config callback can be used by the device to fill the
> config structure.
> The callback will be invoked in vdpasim_get_config() before copying
> bytes into caller buffer.
>
> Move vDPA-net config updates from vdpasim_set_features() in the
> new vdpasim_net_get_config() callback.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v3:
> - checked if get_config callback is set before call it
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 35 +++++++++++++++++++-------------
>   1 file changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index fe71ed7890e1..f935ade0806b 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -60,6 +60,8 @@ struct vdpasim_virtqueue {
>   #define VDPASIM_NET_FEATURES	(VDPASIM_FEATURES | \
>   				 (1ULL << VIRTIO_NET_F_MAC))
>   
> +struct vdpasim;
> +
>   struct vdpasim_dev_attr {
>   	u64 supported_features;
>   	size_t config_size;
> @@ -67,6 +69,7 @@ struct vdpasim_dev_attr {
>   	u32 id;
>   
>   	work_func_t work_fn;
> +	void (*get_config)(struct vdpasim *vdpasim, void *config);
>   };
>   
>   /* State of each vdpasim device */
> @@ -522,8 +525,6 @@ static u64 vdpasim_get_features(struct vdpa_device *vdpa)
>   static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
>   {
>   	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> -	struct virtio_net_config *config =
> -		(struct virtio_net_config *)vdpasim->config;
>   
>   	/* DMA mapping must be done by driver */
>   	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
> @@ -531,16 +532,6 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
>   
>   	vdpasim->features = features & vdpasim->dev_attr.supported_features;
>   
> -	/* We generally only know whether guest is using the legacy interface
> -	 * here, so generally that's the earliest we can set config fields.
> -	 * Note: We actually require VIRTIO_F_ACCESS_PLATFORM above which
> -	 * implies VIRTIO_F_VERSION_1, but let's not try to be clever here.
> -	 */
> -
> -	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
> -	config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
> -	memcpy(config->mac, macaddr_buf, ETH_ALEN);


Patch looks good to me.

But we need Michael to confirm whether doing moving like this is safe. I 
guess what has been done were trying to make sure get_config() fail 
before set_features(), but it's not clear to me whether it's useful.

Thanks


> -
>   	return 0;
>   }
>   
> @@ -595,8 +586,13 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
>   {
>   	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>   
> -	if (offset + len < vdpasim->dev_attr.config_size)
> -		memcpy(buf, vdpasim->config + offset, len);
> +	if (offset + len > vdpasim->dev_attr.config_size)
> +		return;
> +
> +	if (vdpasim->dev_attr.get_config)
> +		vdpasim->dev_attr.get_config(vdpasim, vdpasim->config);
> +
> +	memcpy(buf, vdpasim->config + offset, len);
>   }
>   
>   static void vdpasim_set_config(struct vdpa_device *vdpa, unsigned int offset,
> @@ -739,6 +735,16 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
>   	.free                   = vdpasim_free,
>   };
>   
> +static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
> +{
> +	struct virtio_net_config *net_config =
> +		(struct virtio_net_config *)config;
> +
> +	net_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
> +	net_config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
> +	memcpy(net_config->mac, macaddr_buf, ETH_ALEN);
> +}
> +
>   static int __init vdpasim_dev_init(void)
>   {
>   	struct vdpasim_dev_attr dev_attr = {};
> @@ -747,6 +753,7 @@ static int __init vdpasim_dev_init(void)
>   	dev_attr.supported_features = VDPASIM_NET_FEATURES;
>   	dev_attr.nvqs = VDPASIM_VQ_NUM;
>   	dev_attr.config_size = sizeof(struct virtio_net_config);
> +	dev_attr.get_config = vdpasim_net_get_config;
>   	dev_attr.work_fn = vdpasim_net_work;
>   
>   	vdpasim_dev = vdpasim_create(&dev_attr);

