Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C811AC610
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 16:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394345AbgDPOco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 10:32:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21539 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2441617AbgDPONF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587046384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qNntSaDxiqQE0nc9G3mcZOQc9KN1Sy1W+eODELlogRA=;
        b=YVgF20992ef0i1TZkmhzY+BZ+2qOGFHnYFRKk1WR1xOGEzazpoEJwsmHFxV3lIfvHzQ2R6
        PjiscgijANUDfmWKJsn58ylcguDt8vSgISi1FX5j55qodM0IJyvgvlCOcth+g3g2sdAu4M
        GXi7pN3mdQwcwix50KUWJHi9e2sJtdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-Pehw_FgROHeDUDYGKd5YHw-1; Thu, 16 Apr 2020 10:12:57 -0400
X-MC-Unique: Pehw_FgROHeDUDYGKd5YHw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9613107ACCD;
        Thu, 16 Apr 2020 14:12:26 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B3B95D9E2;
        Thu, 16 Apr 2020 14:12:21 +0000 (UTC)
Date:   Thu, 16 Apr 2020 22:12:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: Put driver tag in blk_mq_dispatch_rq_list() when
 no budget
Message-ID: <20200416141216.GA2907988@T590>
References: <1587035931-125028-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587035931-125028-1-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 07:18:51PM +0800, John Garry wrote:
> If in blk_mq_dispatch_rq_list() we find no budget, then we break of the
> dispatch loop, but the request may keep the driver tag, evaulated
> in 'nxt' in the previous loop iteration.
> 
> Fix by putting the driver tag for that request.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8e56884fd2e9..a7785df2c944 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1222,8 +1222,10 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>  		rq = list_first_entry(list, struct request, queuelist);
>  
>  		hctx = rq->mq_hctx;
> -		if (!got_budget && !blk_mq_get_dispatch_budget(hctx))
> +		if (!got_budget && !blk_mq_get_dispatch_budget(hctx)) {
> +			blk_mq_put_driver_tag(rq);
>  			break;
> +		}
>  
>  		if (!blk_mq_get_driver_tag(rq)) {
>  			/*
> -- 
> 2.16.4
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

