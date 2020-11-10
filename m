Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CBB2AD335
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgKJKLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:11:13 -0500
Received: from foss.arm.com ([217.140.110.172]:53232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJKLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:11:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D9A611D4;
        Tue, 10 Nov 2020 02:11:11 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D51443F6CF;
        Tue, 10 Nov 2020 02:11:10 -0800 (PST)
Date:   Tue, 10 Nov 2020 10:11:08 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] firmware: arm_scmi: fix missing destroy_workqueue()
Message-ID: <20201110101108.GC30029@e120937-lin>
References: <20201110074221.41235-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110074221.41235-1-miaoqinglang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Nov 10, 2020 at 03:42:21PM +0800, Qinglang Miao wrote:
> destroy_workqueue seems necessary before return from
> scmi_notification_init in the error handling case when
> fails to do devm_kcalloc(). Fix this by simply moving
> devm_kcalloc to the front.
> 
> Fixes: bd31b249692e ("firmware: arm_scmi: Add notification dispatch and delivery")
> Suggested-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  v2: fix this problem by simply moving codes.
> 
>  drivers/firmware/arm_scmi/notify.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> index 2754f9d01636..fdb2cc95dfde 100644
> --- a/drivers/firmware/arm_scmi/notify.c
> +++ b/drivers/firmware/arm_scmi/notify.c
> @@ -1468,17 +1468,17 @@ int scmi_notification_init(struct scmi_handle *handle)
>  	ni->gid = gid;
>  	ni->handle = handle;
>  
> +	ni->registered_protocols = devm_kcalloc(handle->dev, SCMI_MAX_PROTO,
> +						sizeof(char *), GFP_KERNEL);
> +	if (!ni->registered_protocols)
> +		goto err;
> +
>  	ni->notify_wq = alloc_workqueue("scmi_notify",
>  					WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
>  					0);
>  	if (!ni->notify_wq)
>  		goto err;
>  
> -	ni->registered_protocols = devm_kcalloc(handle->dev, SCMI_MAX_PROTO,
> -						sizeof(char *), GFP_KERNEL);
> -	if (!ni->registered_protocols)
> -		goto err;
> -
>  	mutex_init(&ni->pending_mtx);
>  	hash_init(ni->pending_events_handlers);
>  

Looks good to me.

Just be aware that it seems you're patch is not based on top of
sudeep/for-next/scmi at:

b9ceca6be432 firmware: arm_scmi: Fix duplicate workqueue name

whose top commit indeed changes the workqueue naming style:

1fc2dd1864c2b (Cristian Marussi 2020-07-01 16:53:40 +0100 1476)
b9ceca6be4323 (Florian Fainelli 2020-10-13 19:17:37 -0700 1477)         ni->notify_wq = alloc_workqueue(dev_name(handle->dev),
bd31b249692e2 (Cristian Marussi 2020-07-01 16:53:42 +0100 1478)                                         WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
bd31b249692e2 (Cristian Marussi 2020-07-01 16:53:42 +0100 1479)                                         0);
bd31b249692e2 (Cristian Marussi 2020-07-01 16:53:42 +0100 1480)         if (!ni->notify_wq)
bd31b249692e2 (Cristian Marussi 2020-07-01 16:53:42 +0100 1481)                 goto err;
bd31b249692e2 (Cristian Marussi 2020-07-01 16:53:42 +0100 1482)

So I'm a bit worried it could fail to apply cleanly as it is, it would
be better if possible to rebase it on top of for-next/scmi.

Beside this

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks

Cristian

> -- 
> 2.23.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
