Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0932A277EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 05:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgIYDza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 23:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgIYDz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 23:55:29 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E3FC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 20:55:29 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so1865626pfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 20:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xooAm+nzHDKUmhA7KnJFrzuEUz5aEJj5OOERMoX+Apw=;
        b=cl7sEd4zK9qe6c/idSdCPhU/eVkiBisuP3ms3rl6nxDBxjg0NQopII0ZKggzTpHdpV
         3NUlbm4Gb2JphGVX8ZiCIurb+CSSvDgVHZiErxG0qcBqjOoh+lqvRWBe+39epxrhyI2e
         wdtBEULRcscMBANnoaC/z96czMMLFSQ882lOaarckmIJ8H5hK0u7jG9U9gvY+pIYkGq3
         5kZwQy247k1+LAYliCxuKq+sO1EwYVrp4keJU4rCLzWVWN3GvNg6KcmJ+3bDcMd1pC9Y
         iMe4hMmGxTZm9a+jiSO28Wq+UUumtsVqNS/aeSIYWlRt/E6e+S8jLOGYnSC9I2235W8p
         5nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xooAm+nzHDKUmhA7KnJFrzuEUz5aEJj5OOERMoX+Apw=;
        b=uTXXNkCO5RsH8qHMHxMagD8yma+0Zb25faZx0dQOTl5Cega8ExD5wFuSDHbohMI8/4
         Gdkn0C8xE2PbGm0ejf+rdvejPsm9l/OtGMoE+PJwDfXhuiJLOmGAYvgEtO4lExJUiC95
         f9XY4JJeWf1Xub8ajbNC4Y64z28SyB1Vaa/2O2k5GSkCAAMeY4lYzBNmuoxEGFxPF1Aq
         a6rsaNfIVus6i0Zv6AWSiQddInxiaRDhCLHFZ3v9HcvgJZAdaYc4fwTX09bmnnfmdBrh
         f7cabDfYmOs02w6mnA+5R9okGX20XysGHLm2KnoJNNDWVjwQfTu1thXWTMgkKDnZtmTV
         BIkA==
X-Gm-Message-State: AOAM530E7XcQrdLn0dCP41SP8nwL0OEeaoTlljQEFeZ0//gT4F2Nqv79
        l1SlXIPcrKX0nmkT7ypEkvMg58HHpfF+5/1q
X-Google-Smtp-Source: ABdhPJw51STaiPoOczsy3779WPHuzafpI4wjAFzrFFTLUalheMmxR6zViKqnUzcdWcCH8chj6h5YfA==
X-Received: by 2002:aa7:989a:0:b029:142:2501:34da with SMTP id r26-20020aa7989a0000b0290142250134damr2273625pfl.51.1601006128985;
        Thu, 24 Sep 2020 20:55:28 -0700 (PDT)
Received: from [10.2.24.220] ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id f207sm957890pfa.54.2020.09.24.20.55.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 20:55:28 -0700 (PDT)
Subject: PING: [PATCH] block: add io_error stat for block device
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200910022026.632617-1-pizhenwei@bytedance.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <367d1851-7580-72a9-d8db-a374459dddf4@bytedance.com>
Date:   Fri, 25 Sep 2020 11:55:23 +0800
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

How do you think about error stat of a block device?

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
