Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF612FAA44
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394082AbhARTdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:33:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:54928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390400AbhARLhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:37:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B046CAC63;
        Mon, 18 Jan 2021 11:37:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 749321E0816; Mon, 18 Jan 2021 12:37:02 +0100 (CET)
Date:   Mon, 18 Jan 2021 12:37:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] block: Fix an error handling in add_partition
Message-ID: <20210118113702.GB19606@quack2.suse.cz>
References: <20210117085346.25095-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117085346.25095-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 17-01-21 16:53:42, Dinghao Liu wrote:
> Once we have called device_initialize(), we should use put_device() to
> give up the reference on error, just like what we have done on failure
> of device_add().
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Changelog:
> 
> v2: - Refine commit message.
> 
> v3: - Add '[v3]' to the title.
> ---
>  block/partitions/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index e7d776db803b..23460cee9de5 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -384,7 +384,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
>  
>  	err = blk_alloc_devt(bdev, &devt);
>  	if (err)
> -		goto out_bdput;
> +		goto out_put;
>  	pdev->devt = devt;
>  
>  	/* delay uevent until 'holders' subdir is created */
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
