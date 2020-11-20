Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AF72BA42B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 09:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgKTIAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 03:00:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgKTIAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605859208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2xPbyKm5kWucgRMomxf8Rd7DQvx68gwcIIgnF4Qsb0=;
        b=e81QCtJFJIemUmOHJbLSX6twNOLDJEOxQLeU2NXiBN1oflJLTFJ7NLbxVmlnMv+JFzHGlU
        ZSrlx6O31YyxHvyrOgoEbeTeCycNb58jjsLjMDkqZab+cbYsiayxDBiR9UO8iuAp22NztR
        5ozyL4zZfM5wwJ8yNW5HGGbYMz/0pvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-EchVDhMNOPeNgw6Nsp9LSQ-1; Fri, 20 Nov 2020 03:00:06 -0500
X-MC-Unique: EchVDhMNOPeNgw6Nsp9LSQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AFB0801B16;
        Fri, 20 Nov 2020 08:00:05 +0000 (UTC)
Received: from gondolin (ovpn-112-250.ams2.redhat.com [10.36.112.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D1CD60C15;
        Fri, 20 Nov 2020 08:00:02 +0000 (UTC)
Date:   Fri, 20 Nov 2020 09:00:00 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390: cmf: fix use-after-free in enable_cmf
Message-ID: <20201120090000.5ac4b5b8.cohuck@redhat.com>
In-Reply-To: <20201120074850.31609-1-miaoqinglang@huawei.com>
References: <20201120074850.31609-1-miaoqinglang@huawei.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 15:48:50 +0800
Qinglang Miao <miaoqinglang@huawei.com> wrote:

> kfree(cdev) is called in put_device in the error branch. So that
> device_unlock(&cdev->dev) would raise a use-after-free bug. In fact,
> there's no need to call device_unlock after put_device.
> 
> Fix it by adding simply return after put_device.
> 
> Fixes: a6ef15652d26 ("s390/cio: fix use after free in cmb processing")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/s390/cio/cmf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
> index 72dd2471e..e95ca476f 100644
> --- a/drivers/s390/cio/cmf.c
> +++ b/drivers/s390/cio/cmf.c
> @@ -1149,9 +1149,12 @@ int enable_cmf(struct ccw_device *cdev)
>  		sysfs_remove_group(&cdev->dev.kobj, cmbops->attr_group);
>  		cmbops->free(cdev);
>  	}
> +
>  out:
> -	if (ret)
> +	if (ret) {
>  		put_device(&cdev->dev);

The put_device() here undoes a get_device() further up in the function.
There is at least one more reference remaining, held by the caller of
enable_cmf(). Returning here would actually introduce a bug (missing
unlock).

> +		return ret;
> +	}
>  out_unlock:
>  	device_unlock(&cdev->dev);
>  	return ret;

