Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CE82FCE21
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbhATKSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:18:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731615AbhATJmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611135645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RxiOqDLfd7ZmjS2d56GvOI/ZMgLLa6YMuHpy80UpW9E=;
        b=IAr8owZzTcAiCNgrmU6MKNJwoqIPP9zDgGR56Sp5glv6qJsJxqKAUJxOFJlrkQXcx9jXxJ
        oyR+oFTeuHs6LTClNx1c/faWlnW5yuj6NRwZo4wdj+0JFEmMMZf85QIFQu6XHnK342/t8a
        3cctoOa5iEEgekILrOOegVzTKeKD9WM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-ayZB8iwrMIKN1Fyn-i1-IQ-1; Wed, 20 Jan 2021 04:40:43 -0500
X-MC-Unique: ayZB8iwrMIKN1Fyn-i1-IQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70F688015C4;
        Wed, 20 Jan 2021 09:40:42 +0000 (UTC)
Received: from [10.36.115.161] (ovpn-115-161.ams2.redhat.com [10.36.115.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 345E260C69;
        Wed, 20 Jan 2021 09:40:37 +0000 (UTC)
Subject: Re: [PATCH] virtio-mem: Assign boolean values to a bool variable
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Tian Tao <tiantao6@hisilicon.com>
References: <1611129031-82818-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <81a1817d-a1f5-dfca-550c-3e3f62cf3a9d@redhat.com>
Date:   Wed, 20 Jan 2021 10:40:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1611129031-82818-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.21 08:50, Jiapeng Zhong wrote:
> Fix the following coccicheck warnings:
> 
> ./drivers/virtio/virtio_mem.c:2580:2-25: WARNING: Assignment
> of 0/1 to bool variable.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 9fc9ec4..85a272c 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2577,7 +2577,7 @@ static int virtio_mem_probe(struct virtio_device *vdev)
>  	 * actually in use (e.g., trying to reload the driver).
>  	 */
>  	if (vm->plugged_size) {
> -		vm->unplug_all_required = 1;
> +		vm->unplug_all_required = true;
>  		dev_info(&vm->vdev->dev, "unplugging all memory is required\n");
>  	}
>  
> 

Hi,

we already had a fix on the list for quite a while:

https://lkml.kernel.org/r/1609233239-60313-1-git-send-email-tiantao6@hisilicon.com

However, looks like Michael queued your patch on the vhost tree instead.

-- 
Thanks,

David / dhildenb

