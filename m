Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C8828E11A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgJNNTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbgJNNTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:19:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE65C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NsxfGZI5FsrZuIKKJv1Ka5EVh1Pb3wRIxRiJpIsxzEo=; b=S7iaX19h+wMk1uPDvVabBN2KwA
        KUTsOTrzforg28nN9AWuuGkeCqFuHBFU2gp2lWDFu8Rxq+pcBcrRTl9uJjdUMg+n6qWSQ9+JMOpOJ
        tnD+9jFeUlSeNMEd6boN/ezDwKtjzTR9HZaUPO9/zGIpV8jyUX4TBdd93S+F8YQ3u2b3Ekk2Yb+MS
        Y60bx9jEhW5PCHc1u+/xJ8WA/whPz8BJ8otXHqor6/RXTPhQtJsNLb8uVmJquQsi0ZuV2/fgjhaSS
        skzYX5BAtqkffUdROC+/Y89rnCwlHdhrss8CMJGF4j8eVjyalRmbqd+WEns3mSSEi3mQGGAmBqyuj
        Ci06AALA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSggQ-0006q8-N0; Wed, 14 Oct 2020 13:19:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39E8030015A;
        Wed, 14 Oct 2020 15:19:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22132201A8545; Wed, 14 Oct 2020 15:19:10 +0200 (CEST)
Date:   Wed, 14 Oct 2020 15:19:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     qianjun.kernel@gmail.com
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH 1/1] Sched/fair: Improve the accuracy of sched_stat_wait
 statistics
Message-ID: <20201014131910.GG2628@hirez.programming.kicks-ass.net>
References: <20201009092530.223-1-qianjun.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009092530.223-1-qianjun.kernel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 05:25:30PM +0800, qianjun.kernel@gmail.com wrote:
> From: jun qian <qianjun.kernel@gmail.com>
> 
> When the sched_schedstat changes from 0 to 1, some sched se maybe
> already in the runqueue, the se->statistics.wait_start will be 0.
> So it will let the (rq_of(cfs_rq)) - se->statistics.wait_start)
> wrong. We need to avoid this scenario.
> 
> Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

This SoB chain isn't valid. Did Yafang's tag need to a reviewed-by or
something?

> ---
>  kernel/sched/fair.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1a68a05..6f8ca0c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -906,6 +906,15 @@ static void update_curr_fair(struct rq *rq)
>  	if (!schedstat_enabled())
>  		return;
>  
> +	/*
> +	 * When the sched_schedstat changes from 0 to 1, some sched se
> +	 * maybe already in the runqueue, the se->statistics.wait_start
> +	 * will be 0.So it will let the delta wrong. We need to avoid this
> +	 * scenario.
> +	 */
> +	if (unlikely(!schedstat_val(se->statistics.wait_start)))
> +		return;
> +
>  	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
>  
>  	if (entity_is_task(se)) {
> -- 
> 1.8.3.1
> 
