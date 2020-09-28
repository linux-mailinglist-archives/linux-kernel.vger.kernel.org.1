Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A9927B079
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgI1PCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgI1PCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:02:12 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBDFC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 08:02:11 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u19so1451413ion.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BtfV6bpXCJFDpCMN7bu71yNu0tlMBra7T0uiOWhSyJE=;
        b=I5qLDhNV0oLKQ947yGK9jdD+M8oAe6Dbn6pBKNtdbVkPqUgpaVdLRffCHvEtgMjdU4
         IXcrnr6s8Jm0t7jNU0wpXEE9JUYTOGdVgOkNiyL8dnVIZ2ScKXDuaGV1bTQEXsgxIByK
         /nmPoyQuO0YCIe2L1DQUqhsceZkTgxeWfQE1lBb/C/huEWq7DFc/aYJtdHZcH/5ahLfl
         NVetIlAJBIrxZ47GDEwSzHNeQwRZJRGuRwRitxOh2NvUGFGHAf2AuwxkQro0NgsD7qnZ
         qIDhYEF3AldTtRV6G+g4jaDoVAELc4WpQ91qxGE8NEN+xJGHEcJBEeUDYwWbWWLPMPuW
         R3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BtfV6bpXCJFDpCMN7bu71yNu0tlMBra7T0uiOWhSyJE=;
        b=jU+JCVRcVtxmHAA2+Dz2frwAnY7lYg+3AXov48wP/aJW/XY3zSStDTxz5zgPBlgpUS
         2tfPMomrbU19E0qgMYBUDKMAjeMCrbpb0x3nsoOIlHt9kMgFTT+3JTX4/MJrx6tuRWwL
         ABIBDCLzdqew/k0+fKlgtQjgzvYkkIiT0F/01k8AaYEOqshzb8AkVdhnconDgTcD/Cpv
         qgnEx3/t+qUNHsEsALV7nD/WbpqwDyqlBeFErSc8akbjqtAJwHG/C9xGIE3+C+U/Zi31
         LlRIOa3J6a7Hm7A1KoSWrdSC3sKLwvMH3CjXFsT9Z/xrNUxr6UW/KxrnRnmfEriYo3kN
         pUoA==
X-Gm-Message-State: AOAM531cfImqC5DrvBXkPceTvfpUDT3CH0rCHsuBEAGGhlgjimgMvuK+
        PUtEJLATYP8IpLluNokhoiF5au3XLzj4lw==
X-Google-Smtp-Source: ABdhPJzAeUdNPZe/O71w2NnO6/VQW0/EAz4vnandaJHGhZbRgl1g0TfJvt3zrmPyYnpAzozvurwCdw==
X-Received: by 2002:a02:c72c:: with SMTP id h12mr1573342jao.86.1601305330041;
        Mon, 28 Sep 2020 08:02:10 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h1sm694701ilr.69.2020.09.28.08.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 08:02:08 -0700 (PDT)
Subject: Re: [PATCH] [v3] blk-mq: add cond_resched() in
 __blk_mq_alloc_rq_maps()
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200926023947.1891-1-tian.xianting@h3c.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <10a8580b-45d6-49f4-812b-1d110b1cb655@kernel.dk>
Date:   Mon, 28 Sep 2020 09:02:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200926023947.1891-1-tian.xianting@h3c.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/20 8:39 PM, Xianting Tian wrote:
> We found blk_mq_alloc_rq_maps() takes more time in kernel space when
> testing nvme device hot-plugging. The test and anlysis as below.
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
>                 pr_err("hw queue %d init cost time %lld ns\n", i, end - start);
>         }
> 
> Test nvme hot-plugging with above debug code, we found it totally cost more
> than 3ms in kernel space without being scheduled out when alloc rqs for all
> 16 hw queues with depth 1023, each hw queue cost about 140-250us. The cost
> time will be increased with hw queue number and queue depth increasing. And
> in an extreme case, if __blk_mq_alloc_rq_maps() returns -ENOMEM, it will try
> "queue_depth >>= 1", more time will be consumed.
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
> other threads getting stuck. It is not in atomic context when executing
> __blk_mq_alloc_rq_maps(), so it is safe to call cond_resched().

Applied for 5.10, thanks.

-- 
Jens Axboe

