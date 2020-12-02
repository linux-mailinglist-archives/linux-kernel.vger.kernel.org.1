Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5902CB387
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 04:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgLBDdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 22:33:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbgLBDdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 22:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606879911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yKLXCDYMlCe0T1Csz6DQegVq//DPh0P/XNAgLwBm+qQ=;
        b=QyQVOUiQ5R+y1uxrKuvOA9b1DsVA3CpYbXdNCFexDPtb/GQP6pqkWqq6iuvq7/2cDVzs6q
        ZTLYqEqcpdf3V9i9jptaoWCGOP5gRYLrsXNHcrTUlWFpL7WvfPu52Du0Fgg4Wn4Yx1tyXh
        gytSyFryNAWLo+pDUNHQ2SWtYxlKUDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-p5Jh3mhvPgeXWnFaXEIYzA-1; Tue, 01 Dec 2020 22:31:49 -0500
X-MC-Unique: p5Jh3mhvPgeXWnFaXEIYzA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0255F185E483;
        Wed,  2 Dec 2020 03:31:48 +0000 (UTC)
Received: from T590 (ovpn-13-72.pek2.redhat.com [10.72.13.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72E4A19C47;
        Wed,  2 Dec 2020 03:31:39 +0000 (UTC)
Date:   Wed, 2 Dec 2020 11:31:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, hare@suse.de,
        ppvk@codeaurora.org, bvanassche@acm.org, kashyap.desai@broadcom.com
Subject: Re: [RFC PATCH] blk-mq: Clean up references when freeing rqs
Message-ID: <20201202033134.GD494805@T590>
References: <1606827738-238646-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606827738-238646-1-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 09:02:18PM +0800, John Garry wrote:
> It has been reported many times that a use-after-free can be intermittently
> found when iterating busy requests:
> 
> - https://lore.kernel.org/linux-block/8376443a-ec1b-0cef-8244-ed584b96fa96@huawei.com/
> - https://lore.kernel.org/linux-block/5c3ac5af-ed81-11e4-fee3-f92175f14daf@acm.org/T/#m6c1ac11540522716f645d004e2a5a13c9f218908
> - https://lore.kernel.org/linux-block/04e2f9e8-79fa-f1cb-ab23-4a15bf3f64cc@kernel.dk/
> 
> The issue is that when we switch scheduler or change queue nr_requests,
> the driver tagset may keep references to the stale requests.
> 
> As a solution, clean up any references to those requests in the driver
> tagset when freeing. This is done with a cmpxchg to make safe any race
> with setting the driver tagset request from another queue.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> --
> Set as RFC as I need to test more. And not sure on solution method, as
> Bart had another idea.
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index d1eafe2c045c..9b042c7036b3 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -621,7 +621,7 @@ void blk_mq_sched_free_requests(struct request_queue *q)
>  
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		if (hctx->sched_tags)
> -			blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i);
> +			blk_mq_free_rqs_ext(q->tag_set, hctx->sched_tags, i, hctx->tags);
>  	}
>  }
>  
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 9c92053e704d..562db72e7d79 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -576,7 +576,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>  			return -ENOMEM;
>  		}
>  
> -		blk_mq_free_rqs(set, *tagsptr, hctx->queue_num);
> +		blk_mq_free_rqs_ext(set, *tagsptr, hctx->queue_num, hctx->tags);
>  		blk_mq_free_rq_map(*tagsptr, flags);
>  		*tagsptr = new;
>  	} else {
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 55bcee5dc032..f3aad695cd25 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2271,8 +2271,8 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>  	return BLK_QC_T_NONE;
>  }
>  
> -void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
> -		     unsigned int hctx_idx)
> +void blk_mq_free_rqs_ext(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
> +		     unsigned int hctx_idx, struct blk_mq_tags *references)
>  {
>  	struct page *page;
>  
> @@ -2281,10 +2281,13 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>  
>  		for (i = 0; i < tags->nr_tags; i++) {
>  			struct request *rq = tags->static_rqs[i];
> +			int j;
>  
>  			if (!rq)
>  				continue;
>  			set->ops->exit_request(set, rq, hctx_idx);
> +			for (j = 0; references && j < references->nr_tags; j++)
> +				cmpxchg(&references->rqs[j], rq, 0);

Seems you didn't address the comment in the following link:

	https://lore.kernel.org/linux-block/10331543-9e45-ae63-8cdb-17e5a2a3b7ef@huawei.com/

The request to be freed may still be refered in another path, such as blk_mq_queue_tag_busy_iter
or blk_mq_tagset_busy_iter(), and cmpxchg() doesn't drain/wait for other refers.

Thanks,
Ming

