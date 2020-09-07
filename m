Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE7D25F3C8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 09:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgIGHUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 03:20:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22261 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726410AbgIGHUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599463199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZeNko4pESS3Q5hreBnvD+2G1nQFuRZeaG+6VRmgcaOc=;
        b=FGln6H5KVmuuDoHMuHC6oCMl5vYVzShI7AEO29GJRRbvaJDrGNa6VjJAs0P8bgOFQG21fw
        vF82rsnaUzZcXMDJRbyDEdFPJ0gGtarMM2pV8WJvyvcmEJCHhAolBvvbOfxTWs9270dc0R
        MPSDPHhZEszOr+CDNBKUCmY8W65zL6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-rwpon1HINYiDXr0VSSIdVw-1; Mon, 07 Sep 2020 03:19:58 -0400
X-MC-Unique: rwpon1HINYiDXr0VSSIdVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F876107465A;
        Mon,  7 Sep 2020 07:19:57 +0000 (UTC)
Received: from T590 (ovpn-13-4.pek2.redhat.com [10.72.13.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CBE778B29;
        Mon,  7 Sep 2020 07:19:50 +0000 (UTC)
Date:   Mon, 7 Sep 2020 15:19:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] blk-mq: Fix refcounting leak in __blk_mq_register_dev()
Message-ID: <20200907071946.GA1058569@T590>
References: <20200905125206.GE183976@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905125206.GE183976@mwanda>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05, 2020 at 03:52:06PM +0300, Dan Carpenter wrote:
> There is a kobject_add() hidden in the call to kobject_add().
> 
> 	ret = kobject_add(q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
>                                       ^^^^^^^^^^^^^^^^^^^^^^^
> 
> It needs to be release on the error path.
> 
> Fixes: 320ae51feed5 ("blk-mq: new multi-queue block IO queueing mechanism")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  block/blk-mq-sysfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index 062229395a50..5a63659163c1 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -321,7 +321,7 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
>  
>  	ret = kobject_add(q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
>  	if (ret < 0)
> -		goto out;
> +		goto out_kobj;
>  
>  	kobject_uevent(q->mq_kobj, KOBJ_ADD);
>  
> @@ -333,8 +333,7 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
>  
>  	q->mq_sysfs_init_done = true;
>  
> -out:
> -	return ret;
> +	return 0;
>  
>  unreg:
>  	while (--i >= 0)
> @@ -342,6 +341,7 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
>  
>  	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
>  	kobject_del(q->mq_kobj);
> +out_kobj:
>  	kobject_put(&dev->kobj);
>  	return ret;
>  }
> -- 
> 2.28.0
> 

Looks good fix:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

