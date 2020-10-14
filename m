Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C67E28E442
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbgJNQSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:18:37 -0400
Received: from foss.arm.com ([217.140.110.172]:52786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729651AbgJNQSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:18:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A541D6E;
        Wed, 14 Oct 2020 09:18:36 -0700 (PDT)
Received: from bogus (unknown [10.57.12.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC1AD3F71F;
        Wed, 14 Oct 2020 09:18:34 -0700 (PDT)
Date:   Wed, 14 Oct 2020 17:18:29 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] firmware: arm_scmi: Fix duplicate workqueue name
Message-ID: <20201014160120.4x2l7hozf376gk3l@bogus>
References: <20201014021737.287340-1-f.fainelli@gmail.com>
 <20201014091806.GB20315@bogus>
 <20201014130524.cj42wknvzdpgsbsr@bogus>
 <20201014134819.GA24061@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014134819.GA24061@e120937-lin>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 02:48:19PM +0100, Cristian Marussi wrote:

[...]

> >
> > I have pushed a version with above change [1], please check if you are
> > happy with that ?
> >
> > [1] https://git.kernel.org/sudeep.holla/linux/c/b2cd15549b
>
> I agree with the need to retain _notify name, but I'm not so sure about
> the above patch...which is:
>

I agree, I thought about it and just cooked up this as a quick solution.
I will move to that, even I wasn't happy with this TBH.

> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> index c24e427dce0d7..f60fa630dd98f 100644
> --- a/drivers/firmware/arm_scmi/notify.c
> +++ b/drivers/firmware/arm_scmi/notify.c
> @@ -1461,6 +1461,7 @@ static const struct scmi_notify_ops notify_ops = {
>  int scmi_notification_init(struct scmi_handle *handle)
>  {
>  	void *gid;
> +	char scmi_wq_name[32];
>  	struct scmi_notify_instance *ni;
>
>  	gid = devres_open_group(handle->dev, NULL, GFP_KERNEL);
> @@ -1474,7 +1475,8 @@ int scmi_notification_init(struct scmi_handle *handle)
>  	ni->gid = gid;
>  	ni->handle = handle;
>
> -	ni->notify_wq = alloc_workqueue("scmi_notify",
> +	sprintf(scmi_wq_name, "%s_notify", dev_name(handle->dev));
> +	ni->notify_wq = alloc_workqueue(scmi_wq_name,
>  					WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
>  					0);
>  	if (!ni->notify_wq)
>
> ...does not expose a potential buffer overflow given that the dev_name now comes
> from the DT chosen name for this SCMI server instance ?
>
> I'd use snprintf and enlarge a bit the static scmi_wq_name[] to fit a max
> device bane plus "_notify".
>
> Regards
> Cristian

--
Regards,
Sudeep
