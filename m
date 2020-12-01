Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD132C950D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 03:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgLACLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 21:11:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32635 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726862AbgLACL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 21:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606788603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X9yqkeagiwWUX6i1ZL2g3fEa1Nr+b6dYnQRiS0J8QY4=;
        b=D2ljJRJdhEiu2sb0eJSD+Mr+5vAX3fQxHhWMejVCQ3LB9vZML/skq59edPIJcWxcFQtqK5
        3/KGZN2XgI/ZwY8upJZOzuon+PA6PGyJ2ovcp9P4wdhsn3fowrJePrR4wBCWQ8TG4jtGsR
        OzxeKzWmHZu+qVEDQftKmr6V50/OHSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-mHdQwyL4OICAMBU4Q-OgNg-1; Mon, 30 Nov 2020 21:09:59 -0500
X-MC-Unique: mHdQwyL4OICAMBU4Q-OgNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0194A1823E41;
        Tue,  1 Dec 2020 02:09:58 +0000 (UTC)
Received: from T590 (ovpn-13-175.pek2.redhat.com [10.72.13.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BE4260873;
        Tue,  1 Dec 2020 02:09:48 +0000 (UTC)
Date:   Tue, 1 Dec 2020 10:09:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: Remove 'running from the wrong CPU' warning
Message-ID: <20201201020944.GA257374@T590>
References: <20201130101921.52754-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130101921.52754-1-dwagner@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:19:21AM +0100, Daniel Wagner wrote:
> It's guaranteed that no request is in flight when a hctx is going
> offline. This warning is only triggered when the wq's CPU is hot
> plugged and the blk-mq is not synced up yet.
> 
> As this state is temporary and the request is still processed
> correctly, better remove the warning as this is the fast path.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> v2:
>   - remove the warning as suggested by Ming
> v1:
>   - initial version
>     https://lore.kernel.org/linux-block/20201126095152.19151-1-dwagner@suse.de/
> 
>  block/blk-mq.c | 25 -------------------------
>  1 file changed, 25 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 55bcee5dc032..7e6761804f86 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1495,31 +1495,6 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>  {
>  	int srcu_idx;
>  
> -	/*
> -	 * We should be running this queue from one of the CPUs that
> -	 * are mapped to it.
> -	 *
> -	 * There are at least two related races now between setting
> -	 * hctx->next_cpu from blk_mq_hctx_next_cpu() and running
> -	 * __blk_mq_run_hw_queue():
> -	 *
> -	 * - hctx->next_cpu is found offline in blk_mq_hctx_next_cpu(),
> -	 *   but later it becomes online, then this warning is harmless
> -	 *   at all
> -	 *
> -	 * - hctx->next_cpu is found online in blk_mq_hctx_next_cpu(),
> -	 *   but later it becomes offline, then the warning can't be
> -	 *   triggered, and we depend on blk-mq timeout handler to
> -	 *   handle dispatched requests to this hctx
> -	 */
> -	if (!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
> -		cpu_online(hctx->next_cpu)) {
> -		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %s\n",
> -			raw_smp_processor_id(),
> -			cpumask_empty(hctx->cpumask) ? "inactive": "active");
> -		dump_stack();
> -	}
> -
>  	/*
>  	 * We can't run the queue inline with ints disabled. Ensure that
>  	 * we catch bad users of this early.
> -- 
> 2.16.4
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

