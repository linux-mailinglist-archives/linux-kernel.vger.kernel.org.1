Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED12E2C7D57
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgK3D1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:27:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727156AbgK3D1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606706745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PKqxfTAarK2PmpFylMjiQ+MEy5YRoBV5xq5ZWEkarc0=;
        b=FbTyj6CQphG1Zdkly9plqy8glBzJqi28a+iAxlWw0Gcjo6phMnEiWgntos+U3R7+17i6Zp
        DL4TA6BiaTDmYIZ7Eza0jhZd5qfWgk/midw157q8uBm/M13bZ7nYS0zpCajyNk1UsDqKu2
        t3GSZ2ynyUvUllzvlagOhpkQjuMAfq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-Njj5YyWEPbqqoyyntToa0g-1; Sun, 29 Nov 2020 22:25:42 -0500
X-MC-Unique: Njj5YyWEPbqqoyyntToa0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A22371005D65;
        Mon, 30 Nov 2020 03:25:41 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D96B60843;
        Mon, 30 Nov 2020 03:25:32 +0000 (UTC)
Subject: Re: [PATCH v2 12/17] vdpa_sim: add get_config callback in
 vdpasim_dev_attr
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-13-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <f8106986-e19d-ea32-436c-14cddd2b6ff4@redhat.com>
Date:   Mon, 30 Nov 2020 11:25:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-13-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/26 下午10:49, Stefano Garzarella wrote:
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
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 33 +++++++++++++++++++-------------
>   1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index c07ddf6af720..8b87ce0485b6 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -58,6 +58,8 @@ struct vdpasim_virtqueue {
>   #define VDPASIM_NET_FEATURES	(VDPASIM_FEATURES | \
>   				 (1ULL << VIRTIO_NET_F_MAC))
>   
> +struct vdpasim;
> +
>   struct vdpasim_dev_attr {
>   	u64 supported_features;
>   	size_t config_size;
> @@ -65,6 +67,7 @@ struct vdpasim_dev_attr {
>   	u32 id;
>   
>   	work_func_t work_fn;
> +	void (*get_config)(struct vdpasim *vdpasim, void *config);
>   };
>   
>   /* State of each vdpasim device */
> @@ -520,8 +523,6 @@ static u64 vdpasim_get_features(struct vdpa_device *vdpa)
>   static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
>   {
>   	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> -	struct virtio_net_config *config =
> -		(struct virtio_net_config *)vdpasim->config;
>   
>   	/* DMA mapping must be done by driver */
>   	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
> @@ -529,15 +530,6 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
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
>   
>   	return 0;
>   }
> @@ -593,8 +585,12 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
>   {
>   	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>   
> -	if (offset + len < vdpasim->dev_attr.config_size)
> -		memcpy(buf, vdpasim->config + offset, len);
> +	if (offset + len > vdpasim->dev_attr.config_size)
> +		return;
> +
> +	vdpasim->dev_attr.get_config(vdpasim, vdpasim->config);
> +
> +	memcpy(buf, vdpasim->config + offset, len);
>   }


I wonder how much value we can get from vdpasim->config consider we've 
already had get_config() method.

Is it possible to copy to the buffer directly here?

Thanks


>   
>   static void vdpasim_set_config(struct vdpa_device *vdpa, unsigned int offset,
> @@ -737,6 +733,16 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
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
> @@ -745,6 +751,7 @@ static int __init vdpasim_dev_init(void)
>   	dev_attr.supported_features = VDPASIM_NET_FEATURES;
>   	dev_attr.nvqs = VDPASIM_VQ_NUM;
>   	dev_attr.config_size = sizeof(struct virtio_net_config);
> +	dev_attr.get_config = vdpasim_net_get_config;
>   	dev_attr.work_fn = vdpasim_net_work;
>   
>   	vdpasim_dev = vdpasim_create(&dev_attr);

