Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149452D0998
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 04:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgLGD5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 22:57:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726482AbgLGD5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 22:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607313346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5t7w+CXAhJbK4V7KFhz3B7Y30H+N9uWN7m7f9MGMPd4=;
        b=CzPHNyL2AJuJCPX958yB41lSMQBdnkYFnmaMy2YIxnJT4FXbyEqBHiBqFENYh/A0ZBHHsS
        Se5zNXPSjZ1N7djwHSAiPogP2qIY34/D2uGXaPqfFyrvxtKQe75CNqYSVpdgJQAr+sxfNd
        slP859I2RTYl7cXw4NbWe2DRUIoICWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-qffgb6xVPC2ywIbW0NQoYQ-1; Sun, 06 Dec 2020 22:55:42 -0500
X-MC-Unique: qffgb6xVPC2ywIbW0NQoYQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DD7D107ACE3;
        Mon,  7 Dec 2020 03:55:41 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 447FA1A262;
        Mon,  7 Dec 2020 03:55:32 +0000 (UTC)
Subject: Re: [PATCH v3 04/19] vhost/iotlb: add VHOST_IOTLB_UNLIMITED macro
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-5-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <52ab5f00-c59b-9cfa-3837-10c1391fea33@redhat.com>
Date:   Mon, 7 Dec 2020 11:55:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203170511.216407-5-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/4 上午1:04, Stefano Garzarella wrote:
> It's possible to allocate an unlimited IOTLB calling
> vhost_iotlb_alloc() with 'limit' = 0.
>
> Add a new macro (VHOST_IOTLB_UNLIMITED) for this case and document
> it in the vhost_iotlb_alloc() documentation block.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   include/linux/vhost_iotlb.h | 2 ++
>   drivers/vhost/iotlb.c       | 3 ++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/vhost_iotlb.h b/include/linux/vhost_iotlb.h
> index 6b09b786a762..47019f97f795 100644
> --- a/include/linux/vhost_iotlb.h
> +++ b/include/linux/vhost_iotlb.h
> @@ -4,6 +4,8 @@
>   
>   #include <linux/interval_tree_generic.h>
>   
> +#define VHOST_IOTLB_UNLIMITED 0
> +
>   struct vhost_iotlb_map {
>   	struct rb_node rb;
>   	struct list_head link;
> diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
> index 0fd3f87e913c..80fdde78ee5a 100644
> --- a/drivers/vhost/iotlb.c
> +++ b/drivers/vhost/iotlb.c
> @@ -100,7 +100,8 @@ EXPORT_SYMBOL_GPL(vhost_iotlb_del_range);
>   
>   /**
>    * vhost_iotlb_alloc - add a new vhost IOTLB
> - * @limit: maximum number of IOTLB entries
> + * @limit: maximum number of IOTLB entries (use VHOST_IOTLB_UNLIMITED for an
> + *         unlimited IOTLB)
>    * @flags: VHOST_IOTLB_FLAG_XXX
>    *
>    * Returns an error is memory allocation fails

