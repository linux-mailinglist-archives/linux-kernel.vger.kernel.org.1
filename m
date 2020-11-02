Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9602A29B1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgKBLob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:44:31 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:38613 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728487AbgKBLoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:44:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UDzBHD5_1604317461;
Received: from 30.0.183.43(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UDzBHD5_1604317461)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Nov 2020 19:44:22 +0800
Subject: Re: [PATCH] nvme: Simplify the nvme_req_qid()
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <3ddb02eee7765d63328da3e1499a26da5cd20f1b.1603785673.git.baolin.wang@linux.alibaba.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <2735ac5c-3d7a-0829-368a-2066e75fe635@linux.alibaba.com>
Date:   Mon, 2 Nov 2020 19:44:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <3ddb02eee7765d63328da3e1499a26da5cd20f1b.1603785673.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Use the request's '->mq_hctx->queue_num' directly to simplify the
> nvme_req_qid() function.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Gentle ping?

> ---
>   drivers/nvme/host/nvme.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index cc11113..0b62b62 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -178,7 +178,8 @@ static inline u16 nvme_req_qid(struct request *req)
>   {
>   	if (!req->q->queuedata)
>   		return 0;
> -	return blk_mq_unique_tag_to_hwq(blk_mq_unique_tag(req)) + 1;
> +
> +	return req->mq_hctx->queue_num + 1;
>   }
>   
>   /* The below value is the specific amount of delay needed before checking
> 
