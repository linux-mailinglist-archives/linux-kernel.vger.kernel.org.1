Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29501F4B00
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 03:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgFJBlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 21:41:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58404 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbgFJBlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 21:41:19 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9364C63D51F743076B0C;
        Wed, 10 Jun 2020 09:41:15 +0800 (CST)
Received: from [10.133.219.224] (10.133.219.224) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 10 Jun 2020 09:41:11 +0800
Subject: Re: [RFC 1/2] Eliminate over- and under-counting of io_ticks
To:     Josh Snyder <joshs@netflix.com>, Jens Axboe <axboe@kernel.dk>,
        "Mikulas Patocka" <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Josh Snyder <josh@code406.com>
References: <20200609040724.448519-1-joshs@netflix.com>
 <20200609040724.448519-2-joshs@netflix.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <0b7e623e-2146-5e44-f486-ba9e1657f2a3@huawei.com>
Date:   Wed, 10 Jun 2020 09:41:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20200609040724.448519-2-joshs@netflix.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.224]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020/6/9 12:07, Josh Snyder wrote:
> Previously, io_ticks could be under-counted. Consider these I/Os along
> the time axis (in jiffies):
> 
>   t          012345678
>   io1        |----|
>   io2            |---|
> 
> Under the old approach, io_ticks would count up to 6, like so:
> 
>   t          012345678
>   io1        |----|
>   io2            |---|
>   stamp      0   45  8
>   io_ticks   1   23  6
> 
> With this change, io_ticks instead counts to 8, eliminating the
> under-counting:
> 
>   t          012345678
>   io1        |----|
>   io2            |---|
>   stamp      0    5  8
>   io_ticks   0    5  8
> 
For the following case, the under-counting is still possible if io2 wins cmpxchg():

  t          0123456
  io1        |-----|
  io2           |--|
  stamp      0     6
  io_ticks   0     3

However considering patch 2 tries to improve sampling rate to 1 us, the problem will gone.

> It was also possible for io_ticks to be over-counted. Consider a
> workload that issues I/Os deterministically at intervals of 8ms (125Hz).
> If each I/O takes 1ms, then the true utilization is 12.5%. The previous
> implementation will increment io_ticks once for each jiffy in which an
> I/O ends. Since the workload issues an I/O reliably for each jiffy, the
> reported utilization will be 100%. This commit changes the approach such
> that only I/Os which cross a boundary between jiffies are counted. With
> this change, the given workload would count an I/O tick on every eighth
> jiffy, resulting in a (correct) calculated utilization of 12.5%.
> 
> Signed-off-by: Josh Snyder <joshs@netflix.com>
> Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
> ---
>  block/blk-core.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d1b79dfe9540..a0bbd9e099b9 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1396,14 +1396,22 @@ unsigned int blk_rq_err_bytes(const struct request *rq)
>  }
>  EXPORT_SYMBOL_GPL(blk_rq_err_bytes);
>  
> -static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
> +static void update_io_ticks(struct hd_struct *part, unsigned long now, unsigned long start)
>  {
>  	unsigned long stamp;
> +	unsigned long elapsed;
>  again:
>  	stamp = READ_ONCE(part->stamp);
>  	if (unlikely(stamp != now)) {
> -		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
> -			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
> +		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp)) {
> +			// stamp denotes the last IO to finish
> +			// If this IO started before stamp, then there was overlap between this IO
> +			// and that one. We increment only by the non-overlap time.
> +			// If not, there was no overlap and we increment by our own time,
> +			// disregarding stamp.
> +			elapsed = now - (start < stamp ? stamp : start);
> +			__part_stat_add(part, io_ticks, elapsed);
> +		}
>  	}
>  	if (part->partno) {
>  		part = &part_to_disk(part)->part0;
> @@ -1439,7 +1447,7 @@ void blk_account_io_done(struct request *req, u64 now)
>  		part_stat_lock();
>  		part = req->part;
>  
> -		update_io_ticks(part, jiffies, true);
> +		update_io_ticks(part, jiffies, nsecs_to_jiffies(req->start_time_ns));
>  		part_stat_inc(part, ios[sgrp]);
>  		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
>  		part_stat_unlock();
> @@ -1456,7 +1464,6 @@ void blk_account_io_start(struct request *rq)
>  	rq->part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
>  
>  	part_stat_lock();
> -	update_io_ticks(rq->part, jiffies, false);
>  	part_stat_unlock();
>  }
>  
> @@ -1468,7 +1475,6 @@ unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
>  	unsigned long now = READ_ONCE(jiffies);
>  
>  	part_stat_lock();
> -	update_io_ticks(part, now, false);
>  	part_stat_inc(part, ios[sgrp]);
>  	part_stat_add(part, sectors[sgrp], sectors);
>  	part_stat_local_inc(part, in_flight[op_is_write(op)]);
> @@ -1487,7 +1493,7 @@ void disk_end_io_acct(struct gendisk *disk, unsigned int op,
>  	unsigned long duration = now - start_time;
>  
>  	part_stat_lock();
> -	update_io_ticks(part, now, true);
> +	update_io_ticks(part, now, start_time);
>  	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
>  	part_stat_local_dec(part, in_flight[op_is_write(op)]);
>  	part_stat_unlock();
> 
