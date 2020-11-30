Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FB02C7D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgK3DWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:22:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbgK3DWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606706443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=02n+GAz8jVQazuCSdq+blVnMw+ge3tAwB9SJiGGhAsg=;
        b=hXBLOdO/T949zyKacQVd3L+FW62asml8vh4IOqGopMZW5puQ9Y5lWejypieOUFk6q1TrBo
        qb11vAPdVvblD9Kgvo/UKGf1mRTUBaVrNVzBu+GbC1vW8YCtem4t2QgZoQ9P+s9rFyNdy0
        qClxbI+YfQ1KETA3yPaa3if6jKRGqXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-BgspEzxuNNmNQB5qCdeCfg-1; Sun, 29 Nov 2020 22:20:39 -0500
X-MC-Unique: BgspEzxuNNmNQB5qCdeCfg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F7791E7EF;
        Mon, 30 Nov 2020 03:20:38 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42CCF189B6;
        Mon, 30 Nov 2020 03:20:26 +0000 (UTC)
Subject: Re: [PATCH v2 10/17] vdpa_sim: store parsed MAC address in a buffer
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-11-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <56441d58-df03-1e4c-4178-a10c7ba9a3e3@redhat.com>
Date:   Mon, 30 Nov 2020 11:20:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-11-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/26 下午10:49, Stefano Garzarella wrote:
> As preparation for the next patches, we store the MAC address,
> parsed during the vdpasim_create(), in a buffer that will be used
> to fill 'config' together with other configurations.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)


Acked-by: Jason Wang <jasowang@redhat.com>


>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index b84d9acd130c..9f2ca3a77025 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -29,6 +29,8 @@ static char *macaddr;
>   module_param(macaddr, charp, 0);
>   MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
>   
> +u8 macaddr_buf[ETH_ALEN];
> +
>   struct vdpasim_virtqueue {
>   	struct vringh vring;
>   	struct vringh_kiov iov;
> @@ -386,13 +388,13 @@ static struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
>   		goto err_iommu;
>   
>   	if (macaddr) {
> -		mac_pton(macaddr, vdpasim->config.mac);
> -		if (!is_valid_ether_addr(vdpasim->config.mac)) {
> +		mac_pton(macaddr, macaddr_buf);
> +		if (!is_valid_ether_addr(macaddr_buf)) {
>   			ret = -EADDRNOTAVAIL;
>   			goto err_iommu;
>   		}
>   	} else {
> -		eth_random_addr(vdpasim->config.mac);
> +		eth_random_addr(macaddr_buf);
>   	}
>   
>   	for (i = 0; i < dev_attr->nvqs; i++)
> @@ -528,6 +530,8 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
>   
>   	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
>   	config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
> +	memcpy(config->mac, macaddr_buf, ETH_ALEN);
> +
>   	return 0;
>   }
>   

