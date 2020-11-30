Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743462C7D14
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgK3DC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:02:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726188AbgK3DC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606705290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DBXG6FueBvNQUjOC0EjXTSMz58tXDXhMp19nfDV0Sso=;
        b=D9D4iFjWYEtyz1GwsPw9hTVZZXPjMkA+QLkDNOTrtZ+LnoIbUhUw5uqc+IxNKlOtnSCjvy
        sxNgiG4jM9zJgYrIuat2s5y4cPKGJRnpsOSwjIvcfx7apaX/7F0omKENyU2ts6/JohUYWJ
        v1KR3sL++JDXkOAxMgRxLYX57wQD3Is=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-JxC8mnLeOWutsvNqJfjsMg-1; Sun, 29 Nov 2020 22:01:28 -0500
X-MC-Unique: JxC8mnLeOWutsvNqJfjsMg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B2DE9A22B;
        Mon, 30 Nov 2020 03:01:27 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18ABC1A882;
        Mon, 30 Nov 2020 03:01:17 +0000 (UTC)
Subject: Re: [PATCH v2 01/17] vdpa: remove unnecessary 'default n' in Kconfig
 entries
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-2-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <f1ac66eb-e0f9-96c7-0282-f661d10b7378@redhat.com>
Date:   Mon, 30 Nov 2020 11:01:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-2-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/26 下午10:49, Stefano Garzarella wrote:
> 'default n' is not necessary since it is already the default when
> nothing is specified.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vdpa/Kconfig | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 358f6048dd3c..4019ceb88181 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -14,7 +14,6 @@ config VDPA_SIM
>   	select DMA_OPS
>   	select VHOST_RING
>   	select GENERIC_NET_UTILS
> -	default n
>   	help
>   	  vDPA networking device simulator which loop TX traffic back
>   	  to RX. This device is used for testing, prototyping and
> @@ -23,7 +22,6 @@ config VDPA_SIM
>   config IFCVF
>   	tristate "Intel IFC VF vDPA driver"
>   	depends on PCI_MSI
> -	default n
>   	help
>   	  This kernel module can drive Intel IFC VF NIC to offload
>   	  virtio dataplane traffic to hardware.
> @@ -41,7 +39,6 @@ config MLX5_VDPA_NET
>   	tristate "vDPA driver for ConnectX devices"
>   	select MLX5_VDPA
>   	depends on MLX5_CORE
> -	default n
>   	help
>   	  VDPA network driver for ConnectX6 and newer. Provides offloading
>   	  of virtio net datapath such that descriptors put on the ring will

