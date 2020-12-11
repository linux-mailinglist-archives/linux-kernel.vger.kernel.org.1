Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DFF2D778D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 15:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405537AbgLKOOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 09:14:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:60610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405421AbgLKONg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:13:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D0D9AC10;
        Fri, 11 Dec 2020 14:12:54 +0000 (UTC)
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
To:     Enzo Matsumiya <ematsumiya@suse.de>, linux-nvme@lists.infradead.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20201209213228.5044-1-ematsumiya@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <4ebb1b8c-4bb0-6ebf-3417-d4aee1bdd3a8@suse.de>
Date:   Fri, 11 Dec 2020 15:12:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201209213228.5044-1-ematsumiya@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/20 10:32 PM, Enzo Matsumiya wrote:
> Fix a possible NULL pointer dereference when trying to read
> hwmon sysfs entries associated to NVMe-oF devices that were
> hot-removed or disconnected.
> 
> Unregister the NVMe hwmon device upon controller teardown
> (nvme_stop_ctrl()).
> 
> Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
> ---
>   drivers/nvme/host/core.c  | 1 +
>   drivers/nvme/host/hwmon.c | 8 ++++++++
>   drivers/nvme/host/nvme.h  | 2 ++
>   3 files changed, 11 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9a270e49df17..becc80a0c3b8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4344,6 +4344,7 @@ EXPORT_SYMBOL_GPL(nvme_complete_async_event);
>   
>   void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>   {
> +	nvme_hwmon_exit(ctrl);
>   	nvme_mpath_stop(ctrl);
>   	nvme_stop_keep_alive(ctrl);
>   	flush_work(&ctrl->async_event_work);
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 552dbc04567b..7f62cca4c577 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -71,6 +71,9 @@ static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>   	int temp;
>   	int err;
>   
> +	if (data->ctrl->state != NVME_CTRL_LIVE)
> +		return -EAGAIN;
> +
>   	/*
>   	 * First handle attributes which don't require us to read
>   	 * the smart log.
> @@ -253,3 +256,8 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>   
>   	return 0;
>   }
> +
> +void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
> +{
> +	hwmon_device_unregister(ctrl->dev);
> +}
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 567f7ad18a91..621e9b1575f6 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -807,11 +807,13 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
>   
>   #ifdef CONFIG_NVME_HWMON
>   int nvme_hwmon_init(struct nvme_ctrl *ctrl);
> +void nvme_hwmon_exit(struct nvme_ctrl *ctrl);
>   #else
>   static inline int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>   {
>   	return 0;
>   }
> +static inline void nvme_hwmon_exit(struct nvme_ctrl *ctrl) { }
>   #endif
>   
>   u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> 
Something's fishy here.
The hwmon attributes should have been created only once for the lifetime 
of the controller (creation is protected by '!initialized').
And the hwmon lifetime should've been controlled by the lifetime of the 
controller (which to my knowledge was the idea behind the devm_* thingies).
So why do we have to deallocate the hwmon attributes?
And why on reset? And who's re-creating them after reset, seeing that 
'initialized' should be true?
Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
