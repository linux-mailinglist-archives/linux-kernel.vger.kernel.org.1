Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030DA2792E4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgIYVDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbgIYVDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:03:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A0AC0613E8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:26:04 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id bw23so38639pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CU6ZoY19qNew+bacQz7VRCDPOd80ooSB94ZtPhhMDDo=;
        b=x/2Q/KRtrT3AG0fWovV2R4PZtZswFHFXlfJTyUxV4Oc9vB0J42p5vxPtBzEANB+PIy
         iN1hZPCqnzrFyZ7JBM3XnshEvqaS2apL/ywpSAc6UJdF1+bYpER8ES8PKB2/zEtWv3qi
         g9VBamYBmmy6vmsPaZXunwZ5TzTAiw0Aaaaop65lLzsBnPLWJWV/tLIm8qq162sR5fq+
         Ovht6uCrbOTZmvJMkW5/PwidWsVclA1PE7LVG5NuOC6Cv9/02Qz6ZqYTURFEu+Cbrj6r
         f+VwZX4LWuuCyavET9Rmf3rtKFpGm5z6bsxfb9ozLsb9H2BkkX4iE/yvoIxeq3/5BKkR
         KY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CU6ZoY19qNew+bacQz7VRCDPOd80ooSB94ZtPhhMDDo=;
        b=PGOUzaO8DFCab49OPiJ84c11XjwQ6Twvkmmz6OtSQnKE75TocXTV2aFkDptrHOpRa9
         q9n23dhGJgwLeh9kT//ZY9U3bYIJYtGg6rhFPRKrfqo+++uwK6snSZagNcH2heqc7Agi
         5qZKWHS6EnFqWUUQR3pxRdHyMruhID50YaW96bQqMxd5RuTY61eCup7cxIiDDo5NlxCu
         vonRkuz/AZSD+K8NkeAJ/ft+Za0DfrUTGtmnTj2hQYX7Cp/pyHXKg3WMwADlIbJCXdnT
         GHw4ozos6sOeci7YYVpg5PZVk/dMIfy/HfliM/E6LIKcVv6Kz/XC/jb14GHpRIif92Vg
         pdBg==
X-Gm-Message-State: AOAM531aAvIu8EwN7/xjzcV9gN72MurBCa6dmbyF/B9T5d41JD7l4184
        bDNrYzgfORDxsVq+p7Q91avFKgx/7TAmSQ==
X-Google-Smtp-Source: ABdhPJzuRIAde0XkdTJMcVQqs0/gYS4ilV0UQDlaks4rICRq07WDXiVNwzG7rudI1Nde6MNN2hQ5Jw==
X-Received: by 2002:a17:90a:4cc6:: with SMTP id k64mr82968pjh.103.1601061961083;
        Fri, 25 Sep 2020 12:26:01 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 134sm3434605pfa.93.2020.09.25.12.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 12:26:00 -0700 (PDT)
Subject: Re: [PATCH] [v2] blk-mq: add cond_resched() in
 __blk_mq_alloc_rq_maps()
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200917081311.11428-1-tian.xianting@h3c.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c55b365d-c6b0-6207-f326-6d58dd113d18@kernel.dk>
Date:   Fri, 25 Sep 2020 13:25:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917081311.11428-1-tian.xianting@h3c.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/20 2:13 AM, Xianting Tian wrote:
> We found it takes more time of blk_mq_alloc_rq_maps() in kernel space when
> testing nvme hot-plugging. The test and anlysis as below.
> 
> Debug code,
> 1, blk_mq_alloc_rq_maps():
>         u64 start, end;
>         depth = set->queue_depth;
>         start = ktime_get_ns();
>         pr_err("[%d:%s switch:%ld,%ld] queue depth %d, nr_hw_queues %d\n",
>                         current->pid, current->comm, current->nvcsw, current->nivcsw,
>                         set->queue_depth, set->nr_hw_queues);
>         do {
>                 err = __blk_mq_alloc_rq_maps(set);
>                 if (!err)
>                         break;
> 
>                 set->queue_depth >>= 1;
>                 if (set->queue_depth < set->reserved_tags + BLK_MQ_TAG_MIN) {
>                         err = -ENOMEM;
>                         break;
>                 }
>         } while (set->queue_depth);
>         end = ktime_get_ns();
>         pr_err("[%d:%s switch:%ld,%ld] all hw queues init cost time %lld ns\n",
>                         current->pid, current->comm,
>                         current->nvcsw, current->nivcsw, end - start);
> 
> 2, __blk_mq_alloc_rq_maps():
>         u64 start, end;
>         for (i = 0; i < set->nr_hw_queues; i++) {
>                 start = ktime_get_ns();
>                 if (!__blk_mq_alloc_rq_map(set, i))
>                         goto out_unwind;
>                 end = ktime_get_ns();
>                 pr_err("hw queue %d init cost time %lld\n", i, end - start);
>         }
> 
> Test nvme hot-plugging with above debug code, we found it totally cost more
> than 3ms in kernel space without being scheduled out when alloc rqs for all
> 16 hw queues with depth 1024, each hw queue cost about 140-250us. The time
> cost will be increased with hw queue number and queue depth increasing. And
> if __blk_mq_alloc_rq_maps() returns -ENOMEM, it will try "queue_depth >>= 1",
> more time will be consumed.
> 	[  428.428771] nvme nvme0: pci function 10000:01:00.0
> 	[  428.428798] nvme 10000:01:00.0: enabling device (0000 -> 0002)
> 	[  428.428806] pcieport 10000:00:00.0: can't derive routing for PCI INT A
> 	[  428.428809] nvme 10000:01:00.0: PCI INT A: no GSI
> 	[  432.593374] [4688:kworker/u33:8 switch:663,2] queue depth 30, nr_hw_queues 1
> 	[  432.593404] hw queue 0 init cost time 22883 ns
> 	[  432.593408] [4688:kworker/u33:8 switch:663,2] all hw queues init cost time 35960 ns
> 	[  432.595953] nvme nvme0: 16/0/0 default/read/poll queues
> 	[  432.595958] [4688:kworker/u33:8 switch:700,2] queue depth 1023, nr_hw_queues 16
> 	[  432.596203] hw queue 0 init cost time 242630 ns
> 	[  432.596441] hw queue 1 init cost time 235913 ns
> 	[  432.596659] hw queue 2 init cost time 216461 ns
> 	[  432.596877] hw queue 3 init cost time 215851 ns
> 	[  432.597107] hw queue 4 init cost time 228406 ns
> 	[  432.597336] hw queue 5 init cost time 227298 ns
> 	[  432.597564] hw queue 6 init cost time 224633 ns
> 	[  432.597785] hw queue 7 init cost time 219954 ns
> 	[  432.597937] hw queue 8 init cost time 150930 ns
> 	[  432.598082] hw queue 9 init cost time 143496 ns
> 	[  432.598231] hw queue 10 init cost time 147261 ns
> 	[  432.598397] hw queue 11 init cost time 164522 ns
> 	[  432.598542] hw queue 12 init cost time 143401 ns
> 	[  432.598692] hw queue 13 init cost time 148934 ns
> 	[  432.598841] hw queue 14 init cost time 147194 ns
> 	[  432.598991] hw queue 15 init cost time 148942 ns
> 	[  432.598993] [4688:kworker/u33:8 switch:700,2] all hw queues init cost time 3035099 ns
> 	[  432.602611]  nvme0n1: p1
> 
> So use this patch to trigger schedule between each hw queue init, to avoid
> other threads getting stuck. We call cond_resched() only when
> "queue depth >= 512". We are not in atomic context when executing
> __blk_mq_alloc_rq_maps(), so it is safe to call cond_resched().
> 
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> ---
>  block/blk-mq.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b3d2785ee..5a71fe53a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3255,11 +3255,16 @@ void blk_mq_exit_queue(struct request_queue *q)
>  static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
>  {
>  	int i;
> +	unsigned int depth = set->queue_depth;
>  
> -	for (i = 0; i < set->nr_hw_queues; i++)
> +	for (i = 0; i < set->nr_hw_queues; i++) {
>  		if (!__blk_mq_alloc_map_and_request(set, i))
>  			goto out_unwind;
>  
> +		if (depth >= 512)
> +			cond_resched();
> +	}
> +
>  	return 0;

I generally dislike

if (some_num)
	cond_resched();

particularly when it's not a true hot path. How about just making the
cond_resched() unconditional? I suspect that will be just fine.

-- 
Jens Axboe

