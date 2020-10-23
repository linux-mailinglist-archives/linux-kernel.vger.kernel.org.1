Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E66296B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 10:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460731AbgJWIp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 04:45:28 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3651 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S460686AbgJWIp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 04:45:28 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 496BE74777AFF58E673F;
        Fri, 23 Oct 2020 16:45:25 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 23 Oct 2020 16:45:24 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Fri, 23
 Oct 2020 16:45:24 +0800
Subject: Re: [PATCH v2] nvme-rdma: handle nvme completion data length
To:     zhenwei pi <pizhenwei@bytedance.com>, <kbusch@kernel.org>,
        <hch@lst.de>, <sagi@grimberg.me>, <axboe@fb.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>
References: <20201023065910.1358586-1-pizhenwei@bytedance.com>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <33381bb5-6daa-5f47-9e3c-a57eeb490950@huawei.com>
Date:   Fri, 23 Oct 2020 16:45:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201023065910.1358586-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2020/10/23 14:59, zhenwei pi wrote:
> Hit a kernel warning:
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 0 PID: 0 at lib/refcount.c:28
> 
> RIP: 0010:refcount_warn_saturate+0xd9/0xe0
> Call Trace:
>   <IRQ>
>   nvme_rdma_recv_done+0xf3/0x280 [nvme_rdma]
>   __ib_process_cq+0x76/0x150 [ib_core]
>   ...
> 
> The reason is that a zero bytes message received from target, and the
> host side continues to process without length checking, then the
> previous CQE is processed twice.
> 
> Handle data length, ignore zero bytes message, and try to recovery for
> corrupted CQE case.
> 
> Thanks to Chao Leng for suggestions.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/nvme/host/rdma.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 9e378d0a0c01..2ecadd309f4a 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1767,6 +1767,21 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
>   		return;
>   	}
>   
> +	/* received data length checking */
> +	if (unlikely(wc->byte_len < len)) {
> +		/* zero bytes message could be ignored */
> +		if (!wc->byte_len) {
> +			nvme_rdma_post_recv(queue, qe);
> +			return;
> +		}
> +
> +		/* corrupted completion, try to recovry */
> +		dev_err(queue->ctrl->ctrl.device,
> +			"Unexpected nvme completion length(%d)\n", wc->byte_len);
> +		nvme_rdma_error_recovery(queue->ctrl);
> +		return;
> +	}
> +
>   	ib_dma_sync_single_for_cpu(ibdev, qe->dma, len, DMA_FROM_DEVICE);
>   	/*
>   	 * AEN requests are special as they don't time out and can
> 
