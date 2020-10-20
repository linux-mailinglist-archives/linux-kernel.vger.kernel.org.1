Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C3F28A7DA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 16:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgJKOxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 10:53:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:53634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgJKOxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 10:53:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9EE40AC3F;
        Sun, 11 Oct 2020 14:53:23 +0000 (UTC)
Subject: Re: [PATCH] block: switch to pr_warn() in __device_add_disk()
To:     Rustam Kovhaev <rkovhaev@gmail.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20201011130347.562264-1-rkovhaev@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <745dd869-00ba-19fd-3643-27a92326f424@suse.de>
Date:   Sun, 11 Oct 2020 16:53:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201011130347.562264-1-rkovhaev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/20 3:03 PM, Rustam Kovhaev wrote:
> syzbot triggered a warning while fuzzing with failslab fault injection
> enabled
> let's convert WARN_ON() to pr_warn()
> 
> Reported-and-tested-by: syzbot+f41893bb8c45cd18cf08@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=f41893bb8c45cd18cf08
> Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
> ---
>   block/genhd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 99c64641c314..be9ce35cf0fe 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -822,7 +822,8 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
>   		/* Register BDI before referencing it from bdev */
>   		dev->devt = devt;
>   		ret = bdi_register(bdi, "%u:%u", MAJOR(devt), MINOR(devt));
> -		WARN_ON(ret);
> +		if (ret)
> +			pr_warn("%s: failed to register backing dev info\n", disk->disk_name);
>   		bdi_set_owner(bdi, dev);
>   		blk_register_region(disk_devt(disk), disk->minors, NULL,
>   				    exact_match, exact_lock, disk);
> 
Please, don't. Where is the point in continuing here?
I'd rather have it fixed up properly, either by having a return value to 
__device_add_disk() or by allowing the caller to check (eg by checking 
GENHD_FL_UP) if the call succeeded.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
