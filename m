Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB2B2D5272
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 05:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgLJEDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 23:03:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731957AbgLJECe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 23:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607572867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aENoo7jeptz7oTELH++s7yl2mherQeWG6u6Xhzawxno=;
        b=HWW1FJXZ3Zfckq8aBGc6LWn+WbqD5kPPgip8H2ONyV6ysL32BCt+1Twixv8xtu0qZ5Y7hW
        b/teJvrrJ4DoNugSFhKg2MbVAheQZyYFv8QI330XAIkLjhhrF+GMEAn4U9BARd1XDyFd92
        1ss0wz33fX6xTIv4GVjFSjiuykLEcFo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-gXrAR2EcMQyTbVSTA_hf9Q-1; Wed, 09 Dec 2020 23:01:04 -0500
X-MC-Unique: gXrAR2EcMQyTbVSTA_hf9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03A82800D53;
        Thu, 10 Dec 2020 04:01:03 +0000 (UTC)
Received: from T590 (ovpn-13-118.pek2.redhat.com [10.72.13.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D154819C78;
        Thu, 10 Dec 2020 04:00:55 +0000 (UTC)
Date:   Thu, 10 Dec 2020 12:00:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq-tag: make blk_mq_tag_busy() return void
Message-ID: <20201210040051.GA1377508@T590>
References: <20201208074002.31539-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208074002.31539-1-tian.xianting@h3c.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 03:40:02PM +0800, Xianting Tian wrote:
> As no one cares about the return value of blk_mq_tag_busy() and
> __blk_mq_tag_busy(), so make them return void.
> 
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> ---
>  block/blk-mq-tag.c | 4 ++--
>  block/blk-mq-tag.h | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 9c92053e7..21ff7d156 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -21,7 +21,7 @@
>   * to get tag when first time, the other shared-tag users could reserve
>   * budget for it.
>   */
> -bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
> +void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>  {
>  	if (blk_mq_is_sbitmap_shared(hctx->flags)) {
>  		struct request_queue *q = hctx->queue;
> @@ -36,7 +36,7 @@ bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>  			atomic_inc(&hctx->tags->active_queues);
>  	}
>  
> -	return true;
> +	return;
>  }
>  
>  /*
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index 7d3e6b333..dd80e5a85 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -60,15 +60,15 @@ enum {
>  	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
>  };
>  
> -extern bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
> +extern void __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
>  extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
>  
> -static inline bool blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
> +static inline void blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>  {
>  	if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
> -		return false;
> +		return;
>  
> -	return __blk_mq_tag_busy(hctx);
> +	__blk_mq_tag_busy(hctx);

The above can be simplified as:

  	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
		__blk_mq_tag_busy(hctx);

Otherwise, looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

