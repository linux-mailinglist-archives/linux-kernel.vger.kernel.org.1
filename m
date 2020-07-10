Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC5A21B126
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 10:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgGJIXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 04:23:07 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:53011 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbgGJIXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:23:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U2GtUMy_1594369384;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U2GtUMy_1594369384)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Jul 2020 16:23:04 +0800
Date:   Fri, 10 Jul 2020 16:23:04 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: Remove unnecessary validation before calling
 blk_mq_sched_completed_request()
Message-ID: <20200710082304.GB29262@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <969d0e9f637b2a0dbfb3d284abfbed6fc7665ea4.1593846855.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <969d0e9f637b2a0dbfb3d284abfbed6fc7665ea4.1593846855.git.baolin.wang7@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jul 04, 2020 at 03:28:21PM +0800, Baolin Wang wrote:
> We've already validated the 'q->elevator' before calling ->ops.completed_request()
> in blk_mq_sched_completed_request(), thus no need to validate rq->internal_tag again,
> and remove it.

A gentle ping?

> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  block/blk-mq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index abcf590f6238..78572b2e1675 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -550,8 +550,7 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
>  		blk_stat_add(rq, now);
>  	}
>  
> -	if (rq->internal_tag != BLK_MQ_NO_TAG)
> -		blk_mq_sched_completed_request(rq, now);
> +	blk_mq_sched_completed_request(rq, now);
>  
>  	blk_account_io_done(rq, now);
>  
> -- 
> 2.17.1
