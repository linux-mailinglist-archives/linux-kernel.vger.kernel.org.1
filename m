Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535772C9F0D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgLAKVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:21:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726003AbgLAKVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606817993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=knQxcFi9c+keJfS52OVAxQ/QeZhgfa+b2kzcTUqwOy8=;
        b=NPqhfNVdxNrGxEVwMMqNfng5px0RK9EoYUnE+nH3vgxF7rTf895JBrstvJVXNPnPxaDJ/e
        8sp1e0Izj+fcn5zS9jNfC/NyISWoyF2Nig3if6AYKEu/zwadKEYEI6jDLl6iNTQF2fxqlp
        QOJAmH/aYFxk55oYMwsYEHelkrdqygk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-GexQxWKbNvmsvTgySBhIZw-1; Tue, 01 Dec 2020 05:19:49 -0500
X-MC-Unique: GexQxWKbNvmsvTgySBhIZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A408A1092BA0;
        Tue,  1 Dec 2020 10:19:47 +0000 (UTC)
Received: from gondolin (ovpn-113-138.ams2.redhat.com [10.36.113.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1C9260BE5;
        Tue,  1 Dec 2020 10:19:45 +0000 (UTC)
Date:   Tue, 1 Dec 2020 11:19:43 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@de.ibm.com>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390: cio: fix use-after-free in
 ccw_device_destroy_console
Message-ID: <20201201111943.626cb86f.cohuck@redhat.com>
In-Reply-To: <20201201063150.82128-1-miaoqinglang@huawei.com>
References: <20201201063150.82128-1-miaoqinglang@huawei.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Dec 2020 14:31:50 +0800
Qinglang Miao <miaoqinglang@huawei.com> wrote:

> put_device calls release function which do kfree() inside.
> So following use of sch&cdev would cause use-after-free bugs.
> 
> Fix these by simply adjusting the position of put_device.
> 
> Fixes: 37db8985b211 ("s390/cio: add basic protected virtualization support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  This patch is indeed a v2 of older one. Considering that the
>  patch's name has changed, I think a normal prefix 'PATCH' is
>  better.
> 
>  drivers/s390/cio/device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

