Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358DD2BA404
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgKTHzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:55:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbgKTHzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605858937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZmsWa73xJX7Zl/5qDm9Mu9Q7eTlqakfw9KEp58NMOX4=;
        b=bz7zgQlwTSHwRLuGCaulmBy+JYzf3p6d7nqV0aSXLzRttLPW/YnciQH+2FVWaAY1MgIl2R
        6r+tx6skG/CV1S2bQN/7uj9QaeeN3c/48KodTfDCXTlXnjV5VmqsVI0jtgBp8KhTObyfmI
        ItQGTgFbuNpIAID6VMgD3MK2p2UZyTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-QQqtNERFNX-rsBb1AvrZOg-1; Fri, 20 Nov 2020 02:55:33 -0500
X-MC-Unique: QQqtNERFNX-rsBb1AvrZOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 992BC107ACE3;
        Fri, 20 Nov 2020 07:55:31 +0000 (UTC)
Received: from gondolin (ovpn-112-250.ams2.redhat.com [10.36.112.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E40A619D9B;
        Fri, 20 Nov 2020 07:55:29 +0000 (UTC)
Date:   Fri, 20 Nov 2020 08:55:26 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390: cio: fix two use-after-free bugs in device.c
Message-ID: <20201120085526.257a5596.cohuck@redhat.com>
In-Reply-To: <20201120074849.31557-1-miaoqinglang@huawei.com>
References: <20201120074849.31557-1-miaoqinglang@huawei.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 15:48:49 +0800
Qinglang Miao <miaoqinglang@huawei.com> wrote:

> put_device calls release function which do kfree() inside.
> So following use of sch&cdev would cause use-after-free bugs.
> 
> Fix these by simply adjusting the position of put_device.
> 
> Fixes: 37db8985b211 ("s390/cio: add basic protected virtualization support")
> Fixes: 74bd0d859dc3 ("s390/cio: fix unlocked access of online member")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/s390/cio/device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
> index b29fe8d50..69492417b 100644
> --- a/drivers/s390/cio/device.c
> +++ b/drivers/s390/cio/device.c
> @@ -1664,10 +1664,10 @@ void __init ccw_device_destroy_console(struct ccw_device *cdev)
>  	struct io_subchannel_private *io_priv = to_io_private(sch);
>  
>  	set_io_private(sch, NULL);
> -	put_device(&sch->dev);
> -	put_device(&cdev->dev);
>  	dma_free_coherent(&sch->dev, sizeof(*io_priv->dma_area),
>  			  io_priv->dma_area, io_priv->dma_area_dma);
> +	put_device(&sch->dev);
> +	put_device(&cdev->dev);

That change looks reasonable.

>  	kfree(io_priv);
>  }
>  
> @@ -1774,8 +1774,8 @@ static int ccw_device_remove(struct device *dev)
>  				      ret, cdev->private->dev_id.ssid,
>  				      cdev->private->dev_id.devno);
>  		/* Give up reference obtained in ccw_device_set_online(). */
> -		put_device(&cdev->dev);
>  		spin_lock_irq(cdev->ccwlock);
> +		put_device(&cdev->dev);

As the comment above states, the put_device() gives up the reference
obtained in ccw_device_set_online(). There's at least one more
reference remaining (held by the caller of the remove function). Moving
the put_device() does not fix anything here.

>  	}
>  	ccw_device_set_timeout(cdev, 0);
>  	cdev->drv = NULL;

