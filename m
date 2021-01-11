Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90242F1A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733120AbhAKQBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:01:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:39468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729275AbhAKQBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:01:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1C57EB18B;
        Mon, 11 Jan 2021 16:00:20 +0000 (UTC)
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
To:     Daniel Wagner <dwagner@suse.de>,
        Enzo Matsumiya <ematsumiya@suse.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20201209213228.5044-1-ematsumiya@suse.de>
 <4ebb1b8c-4bb0-6ebf-3417-d4aee1bdd3a8@suse.de>
 <20201230143805.2v4izgkzbnisssvr@beryllium.lan>
 <20201230151653.ozlqlwef7f2tarwz@beryllium.lan>
 <20201230153138.4f2jd2yd2vkqndby@beryllium.lan>
 <20210104210610.hliiupywksawgei3@hyori>
 <20210105094545.3tq7c6ev5yn3bhyi@beryllium.lan>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <412d45ef-40af-24c3-4aa2-042ecbba05cd@suse.de>
Date:   Mon, 11 Jan 2021 17:00:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210105094545.3tq7c6ev5yn3bhyi@beryllium.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/21 10:45 AM, Daniel Wagner wrote:
> On Mon, Jan 04, 2021 at 06:06:10PM -0300, Enzo Matsumiya wrote:
>> @Daniel maybe try tweaking your tests to use a smaller controller
>> loss timeout (-l option)? I do this on my tests because the default
>> value kicks in about 30min after hot-removal -- i.e. you
>> have to actually wait for the timeout to expire to trigger the bug.
> 
> As far I can tell, the blktests test I am using will trigger the same
> bug. The problem is that the lifetime of hwmon sysfs entry should be
> aligned to the lifetime of the nvme sysfs entry. Currently, hwmon's
> lifetime is bound to the lifetime of the ctl sysfs entry. When the nvme
> entry goes away (and obviously also the underlying device), the hwmon
> sysfs entry still references it.
> 
Yeah, using the controller node for devm allocations is quite dodgy.
Does this one help?


diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 6fdd07fb3001..7260af028cf7 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -226,7 +226,7 @@ static const struct hwmon_chip_info

  int nvme_hwmon_init(struct nvme_ctrl *ctrl)
  {
-       struct device *dev = ctrl->dev;
+       struct device *dev = ctrl->device;
         struct nvme_hwmon_data *data;
         struct device *hwmon;
         int err;
@@ -240,8 +240,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)

         err = nvme_hwmon_get_smart_log(data);
         if (err) {
-               dev_warn(ctrl->device,
-                       "Failed to read smart log (error %d)\n", err);
+               dev_warn(dev, "Failed to read smart log (error %d)\n", err);
                 devm_kfree(dev, data);
                 return err;
         }


Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
