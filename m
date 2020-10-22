Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E629B29567F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 04:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895190AbgJVCpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 22:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895183AbgJVCpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 22:45:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69E6C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 19:45:38 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b6so179899pju.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 19:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kONrq/lRtklL1Qqq4SPUIkJR3qq5A1gBIILz2gGUwb4=;
        b=tbsBipmQmIUWj3rztkdcEygRjAbt9YQF+z+XR87qeJFHpK5vQgX/LOdCtB9wbwRXDr
         kBEQLiiE6Zn/i/ui8CDv77vasMVSdl2QJYPku87wMhWhmXGsYVG/DuGccEugsNRXdRlz
         7QteN6yuPG2Y5KMSiznapWkXP7Nrna9dSi0bVQEpLg9VYTQ2WXDIObfeXs0BfUx/JciZ
         E2zWzBU+RJ1wNg8fiya2a7ENBa3n5rW3zvYmNRwDoio1aC3gFiB9dFy22eNo60tRrqb2
         S2Ugnlqu5yNCnRi+fXnEdrjD9LJ7yBJZQGJxQeaVT0SLQF13ya8wyJQLl2sciVgNFpB5
         xK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kONrq/lRtklL1Qqq4SPUIkJR3qq5A1gBIILz2gGUwb4=;
        b=FE4I9a/NzcgLuQYzNw02DjIdFbj0Rn5CQFTBU6/oVUR+gTjZbCW7AJOSR78bvNZJ1I
         3E/YckFgbkQazGSvJv3H9mmsfFuKq4ojdo1MuHuyxxL7yZUrkIZYw96c+eQWfCF7jw7r
         AgOnWsAgQ8L7QJ9zCSJwjzhmJ2ZMhHRoydPeQpzx3C7//LnzsByNaVfsaNKu5q2j8LRc
         BlHFPdU5WBujxr+dNgmryNYwcNYCiEZhrmEoSdHUaQ/0TgrBHsazKMypSw6MXNvqrLIw
         N6hFCaU7MMS1o6EE0hXkRkEJHO5ny7MxO4LtDOSDGVr8MbQUMYBgfBua0zKigN1gh9+0
         ot7w==
X-Gm-Message-State: AOAM531W/NpngSl/pFGlISXKRGOWqIH+lehRyXT7fR8xYL1er2x4bKyP
        yv3XWGcrZ13h/cDGEqwQ5zwONREj6kYCSw==
X-Google-Smtp-Source: ABdhPJzzmGkjj1kW8pPUT7PDWhaDs8EkgTx32Mkx04ju06cTsVG33FQ5AgUOn0BN0hgBAvDTa3KcAA==
X-Received: by 2002:a17:90b:198d:: with SMTP id mv13mr357993pjb.13.1603334738261;
        Wed, 21 Oct 2020 19:45:38 -0700 (PDT)
Received: from [10.2.24.220] ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id v16sm212387pgk.26.2020.10.21.19.45.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 19:45:37 -0700 (PDT)
Subject: PING: [PATCH] block: add io_error stat for block device
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200910022026.632617-1-pizhenwei@bytedance.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <e6dfc767-a54e-d14e-c6c4-fcb68f43180a@bytedance.com>
Date:   Thu, 22 Oct 2020 10:45:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200910022026.632617-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jens

What do you think about this, adding io error stat for block devices is 
reasonable?

On 9/10/20 10:20 AM, zhenwei pi wrote:
> Currently if hitting block req error, block layer only prints error
> log with a rate limitation. Then agent has to parse kernel log to
> record what happens.
> 
> In this patch, add read/write/discard/flush stat counter to record
> io errors.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   block/blk-core.c          | 14 +++++++++++---
>   block/genhd.c             | 19 +++++++++++++++++++
>   include/linux/part_stat.h |  1 +
>   3 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 10c08ac50697..8f1424835700 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1558,9 +1558,17 @@ bool blk_update_request(struct request *req, blk_status_t error,
>   		req->q->integrity.profile->complete_fn(req, nr_bytes);
>   #endif
>   
> -	if (unlikely(error && !blk_rq_is_passthrough(req) &&
> -		     !(req->rq_flags & RQF_QUIET)))
> -		print_req_error(req, error, __func__);
> +	if (unlikely(error && !blk_rq_is_passthrough(req))) {
> +		if (op_is_flush(req_op(req)))
> +			part_stat_inc(&req->rq_disk->part0,
> +				io_errors[STAT_FLUSH]);
> +		else
> +			part_stat_inc(&req->rq_disk->part0,
> +				io_errors[op_stat_group(req_op(req))]);
> +
> +		if (!(req->rq_flags & RQF_QUIET))
> +			print_req_error(req, error, __func__);
> +	}
>   
>   	blk_account_io_completion(req, nr_bytes);
>   
> diff --git a/block/genhd.c b/block/genhd.c
> index 99c64641c314..852035095485 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -104,6 +104,7 @@ static void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
>   			stat->sectors[group] += ptr->sectors[group];
>   			stat->ios[group] += ptr->ios[group];
>   			stat->merges[group] += ptr->merges[group];
> +			stat->io_errors[group] += ptr->io_errors[group];
>   		}
>   
>   		stat->io_ticks += ptr->io_ticks;
> @@ -1374,6 +1375,22 @@ static ssize_t disk_discard_alignment_show(struct device *dev,
>   	return sprintf(buf, "%d\n", queue_discard_alignment(disk->queue));
>   }
>   
> +static ssize_t io_error_show(struct device *dev,
> +		      struct device_attribute *attr, char *buf)
> +{
> +	struct hd_struct *p = dev_to_part(dev);
> +	struct disk_stats stat;
> +
> +	part_stat_read_all(p, &stat);
> +
> +	return sprintf(buf,
> +		"%8lu %8lu %8lu %8lu\n",
> +		stat.io_errors[STAT_READ],
> +		stat.io_errors[STAT_WRITE],
> +		stat.io_errors[STAT_DISCARD],
> +		stat.io_errors[STAT_FLUSH]);
> +}
> +
>   static DEVICE_ATTR(range, 0444, disk_range_show, NULL);
>   static DEVICE_ATTR(ext_range, 0444, disk_ext_range_show, NULL);
>   static DEVICE_ATTR(removable, 0444, disk_removable_show, NULL);
> @@ -1386,6 +1403,7 @@ static DEVICE_ATTR(capability, 0444, disk_capability_show, NULL);
>   static DEVICE_ATTR(stat, 0444, part_stat_show, NULL);
>   static DEVICE_ATTR(inflight, 0444, part_inflight_show, NULL);
>   static DEVICE_ATTR(badblocks, 0644, disk_badblocks_show, disk_badblocks_store);
> +static DEVICE_ATTR(io_error, 0444, io_error_show, NULL);
>   
>   #ifdef CONFIG_FAIL_MAKE_REQUEST
>   ssize_t part_fail_show(struct device *dev,
> @@ -1437,6 +1455,7 @@ static struct attribute *disk_attrs[] = {
>   #ifdef CONFIG_FAIL_IO_TIMEOUT
>   	&dev_attr_fail_timeout.attr,
>   #endif
> +	&dev_attr_io_error.attr,
>   	NULL
>   };
>   
> diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
> index 24125778ef3e..4fe3836d2308 100644
> --- a/include/linux/part_stat.h
> +++ b/include/linux/part_stat.h
> @@ -9,6 +9,7 @@ struct disk_stats {
>   	unsigned long sectors[NR_STAT_GROUPS];
>   	unsigned long ios[NR_STAT_GROUPS];
>   	unsigned long merges[NR_STAT_GROUPS];
> +	unsigned long io_errors[NR_STAT_GROUPS];
>   	unsigned long io_ticks;
>   	local_t in_flight[2];
>   };
> 

-- 
zhenwei pi
