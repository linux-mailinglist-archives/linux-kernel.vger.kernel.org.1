Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBD92AC2DC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgKIRvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:51:40 -0500
Received: from foss.arm.com ([217.140.110.172]:43808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgKIRvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:51:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B46931B;
        Mon,  9 Nov 2020 09:51:39 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E47893F718;
        Mon,  9 Nov 2020 09:51:38 -0800 (PST)
Date:   Mon, 9 Nov 2020 17:51:36 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: arm_scmi: fix missing destroy_workqueue() on
 error in scmi_notification_init
Message-ID: <20201109175136.GB42652@e120937-lin>
References: <20201109091517.55895-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109091517.55895-1-miaoqinglang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 05:15:17PM +0800, Qinglang Miao wrote:
> Add the missing destroy_workqueue() before return from
> scmi_notification_init in the error handling case when
> fails to do devm_kcalloc().
> 
> Fixes: bd31b249692e ("firmware: arm_scmi: Add notification dispatch and delivery")
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/firmware/arm_scmi/notify.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> index 2754f9d01636..3048e57d9731 100644
> --- a/drivers/firmware/arm_scmi/notify.c
> +++ b/drivers/firmware/arm_scmi/notify.c
> @@ -1476,8 +1476,10 @@ int scmi_notification_init(struct scmi_handle *handle)
>  
>  	ni->registered_protocols = devm_kcalloc(handle->dev, SCMI_MAX_PROTO,
>  						sizeof(char *), GFP_KERNEL);
> -	if (!ni->registered_protocols)
> +	if (!ni->registered_protocols) {
> +		destroy_workqueue(ni->notify_wq);
>  		goto err;
> +	}
>  

Good catch, looks good to me.

Even better you could move the above alloc_workqueue() block down here
so that you can avoid all together the additional destroy_workqueue() on
the above error path.

Thanks

Cristian


>  	mutex_init(&ni->pending_mtx);
>  	hash_init(ni->pending_events_handlers);
> -- 
> 2.23.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
