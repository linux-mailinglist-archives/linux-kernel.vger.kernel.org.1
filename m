Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963052F9807
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 04:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbhARC6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 21:58:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731397AbhARC6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 21:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610938629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LedkJCf2woputitHVAf5yD7dLglL44/GLUzYpe6i5Ac=;
        b=CCl5CT5HkbbI0WYFEu4qyBj/xh2YI/pk8tRlCAHUz9T8YeRvhNtID18pSVIEmzURtu+xc7
        sOX0IDCe2gsH5p02mx4zlhOrACSOymfHQUCyvGRasRcxG+is7VQQhzW+DOisIzaGJko8QI
        tjewS2Hm0MK4JJ6sByeFPVTZpquj6NE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453--H6RMxbAPcaOGMYXHLPdGA-1; Sun, 17 Jan 2021 21:57:07 -0500
X-MC-Unique: -H6RMxbAPcaOGMYXHLPdGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5600F8145F7;
        Mon, 18 Jan 2021 02:57:06 +0000 (UTC)
Received: from [10.72.13.12] (ovpn-13-12.pek2.redhat.com [10.72.13.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7072D71C97;
        Mon, 18 Jan 2021 02:57:04 +0000 (UTC)
Subject: Re: [PATCH] virtio_ring: boolean values to a bool variable
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1610704825-17724-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <1d311c25-9051-ddcd-e7e1-5adbb8a913f9@redhat.com>
Date:   Mon, 18 Jan 2021 10:57:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1610704825-17724-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/1/15 下午6:00, Jiapeng Zhong wrote:
> Fix the following coccicheck warnings:
>
> ./drivers/virtio/virtio_ring.c:1637:1-29: WARNING: Assignment of
> 0/1 to bool variable.
>
> ./drivers/virtio/virtio_ring.c:1636:1-30: WARNING: Assignment of
> 0/1 to bool variable.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>


It looks to me it's not the only places:

git grep avail_wrap_counter
drivers/virtio/virtio_ring.c:                   bool avail_wrap_counter;
drivers/virtio/virtio_ring.c: vq->packed.avail_wrap_counter ^= 1;
drivers/virtio/virtio_ring.c: vq->packed.avail_wrap_counter ^= 1;
drivers/virtio/virtio_ring.c:   if (wrap_counter != 
vq->packed.avail_wrap_counter)
drivers/virtio/virtio_ring.c:   vq->packed.avail_wrap_counter = 1;

Thanks


> ---
>   drivers/virtio/virtio_ring.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 71e16b5..5adb361 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1633,8 +1633,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
>   	vq->packed.vring.device = device;
>   
>   	vq->packed.next_avail_idx = 0;
> -	vq->packed.avail_wrap_counter = 1;
> -	vq->packed.used_wrap_counter = 1;
> +	vq->packed.avail_wrap_counter = true;
> +	vq->packed.used_wrap_counter = true;
>   	vq->packed.event_flags_shadow = 0;
>   	vq->packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
>   

