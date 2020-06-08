Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A774B1F1D67
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 18:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgFHQds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 12:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730568AbgFHQdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:33:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8256DC08C5C2;
        Mon,  8 Jun 2020 09:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M4IpX9vCx5XU8eioIsU7NGWUWWO8cHPb1jHlxyOyyGg=; b=opiquRzwa1LbP1kzG+qTNZPWws
        W9qPVzkXvPnFamug755ST+UJF0z5Erpy5A9Wl8yKEfKulj8hdI/NCvo0tZIjAZSzzYrvGfJYfIf7U
        ayNiz65Ud/8ZVFfym/peXVOC+R+atRbvssLUNVjHEulEXzGCjd5029zpFdq330WhpnKSG81wVn9ef
        UtQzVO2xDVqC0jP8dewh4zsg02oLZKAgENgC3+weGMF+biS1TmOn5MVT8wIlozxuUybo5ONKAqBBh
        ZkCTmnLM2lumjjIDD+ZdXNiScGT1xERToKZ077yJYKLAPw5ocmY/MQtrUpYU7gGHh38dekys9+04U
        JHI16ilw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiKiU-0005XO-DI; Mon, 08 Jun 2020 16:33:42 +0000
Date:   Mon, 8 Jun 2020 09:33:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: blk-softirq vs smp_call_function_single_async()
Message-ID: <20200608163342.GA5155@infradead.org>
References: <20200608115800.GA2531@hirez.programming.kicks-ass.net>
 <20200608154557.GA26611@infradead.org>
 <20200608155833.GC2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608155833.GC2531@hirez.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 05:58:33PM +0200, Peter Zijlstra wrote:
> > A request can only be completed once.
> 
> Sure, but that doesn't help.
> 
> CPU0				CPU1
> 
>  raise_blk_irq()		BLOCK_SOFTIRQ
>    IPI -> CPU1
> 
> 				// picks up thing from CPU0
> 				req->complete(req);
> 
> 
> 	<big hole where CSD is active and request completed>
> 
> 				<IPI>
> 				  trigger_softirq()
> 
> 
> What happens to a struct request after completion, is it free()d
> or reused? If reused, how do we guarantee CSD completion before
> free()ing?

The request is freed in the block layer sense by __blk_mq_free_request
(which doesn't actually free the memory, so it eventually gets reused).

__blk_mq_free_request is called from blk_mq_end_request which
is called from the drivers ->complete_rq method, which is called
from the block softirq.

What is the method to guaranteed CSD completion?
