Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FE229686D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 04:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374500AbgJWCHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 22:07:14 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S374489AbgJWCHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 22:07:14 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 173DF4436115AF78727F;
        Fri, 23 Oct 2020 10:07:12 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 23 Oct 2020 10:07:11 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Fri, 23
 Oct 2020 10:07:11 +0800
Subject: Re: [External] Re: [PATCH] nvme-rdma: handle nvme completion data
 length
To:     zhenwei pi <pizhenwei@bytedance.com>
CC:     <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
        <axboe@fb.com>, <linux-kernel@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, Yibo Zhu <zhuyibo@bytedance.com>
References: <20201022083850.1334880-1-pizhenwei@bytedance.com>
 <04a97f73-ba13-a4b5-3ea4-fc438391507e@huawei.com>
 <1c78dbe5-47a4-1590-e064-681cba5fb01d@bytedance.com>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <c2891e98-a81c-7f3a-3b19-1e34bd1f212c@huawei.com>
Date:   Fri, 23 Oct 2020 10:07:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1c78dbe5-47a4-1590-e064-681cba5fb01d@bytedance.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme705-chm.china.huawei.com (10.1.199.101) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/10/22 18:05, zhenwei pi wrote:
> On 10/22/20 5:55 PM, Chao Leng wrote:
>>
>>
>> On 2020/10/22 16:38, zhenwei pi wrote:
>>> Hit a kernel warning:
>>> refcount_t: underflow; use-after-free.
>>> WARNING: CPU: 0 PID: 0 at lib/refcount.c:28
>>>
>>> RIP: 0010:refcount_warn_saturate+0xd9/0xe0
>>> Call Trace:
>>>   <IRQ>
>>>   nvme_rdma_recv_done+0xf3/0x280 [nvme_rdma]
>>>   __ib_process_cq+0x76/0x150 [ib_core]
>>>   ...
>>>
>>> The reason is that a zero bytes message received from target, and the
>>> host side continues to process without length checking, then the
>>> previous CQE is processed twice.
>>>
>>> Handle data length, ignore zero bytes message, and try to recovery for
>>> corrupted CQE case.
>>>
>>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>>> ---
>>>   drivers/nvme/host/rdma.c | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>>> index 9e378d0a0c01..9f5112040d43 100644
>>> --- a/drivers/nvme/host/rdma.c
>>> +++ b/drivers/nvme/host/rdma.c
>>> @@ -1767,6 +1767,17 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
>>>           return;
>>>       }
>>> +    if (unlikely(!wc->byte_len)) {
>>> +        /* zero bytes message could be ignored */
>>> +        return;
Resource leak, need nvme_rdma_post_recv.
>>> +    } else if (unlikely(wc->byte_len < len)) {
>>> +        /* Corrupted completion, try to recovry */
>>> +        dev_err(queue->ctrl->ctrl.device,
>>> +            "Unexpected nvme completion length(%d)\n", wc->byte_len);
>>> +        nvme_rdma_error_recovery(queue->ctrl);
>>> +        return;
>>> +    }
>> !wc->byte_len and wc->byte_len < len may be the same type of anomaly.
>> Why do different error handling?
>> In which scenario zero bytes message received from target? fault inject test or normal test/run?
> 
> Zero bytes message could be used as transport layer keep alive mechanism (I's also developing target side transport layer keep alive now. To reclaim resource, target side needs to close dead connections even kato is set as 0).
nvme over fabric protocol do not define this.
May be async event is a option for target keep alive(if kato set as 0).
> 
>>> +
>>>       ib_dma_sync_single_for_cpu(ibdev, qe->dma, len, DMA_FROM_DEVICE);
>>>       /*
>>>        * AEN requests are special as they don't time out and can
>>>
> 
