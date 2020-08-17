Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCE724660E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 14:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgHQMKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 08:10:55 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:60475 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbgHQMKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:10:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U61eCyj_1597666252;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U61eCyj_1597666252)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Aug 2020 20:10:52 +0800
Date:   Mon, 17 Aug 2020 20:10:52 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 4/5] block: Remove blk_mq_attempt_merge() function
Message-ID: <20200817121052.GC79836@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
 <b9ae58ae4bc8b16a53fabd35ce163897286d856a.1597637287.git.baolin.wang@linux.alibaba.com>
 <20200817063153.GD12248@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817063153.GD12248@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 08:31:53AM +0200, Christoph Hellwig wrote:
> On Mon, Aug 17, 2020 at 12:09:18PM +0800, Baolin Wang wrote:
> >  		unsigned int nr_segs)
> >  {
> > @@ -447,7 +425,16 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
> >  			!list_empty_careful(&ctx->rq_lists[type])) {
> >  		/* default per sw-queue merge */
> >  		spin_lock(&ctx->lock);
> > -		ret = blk_mq_attempt_merge(q, hctx, ctx, bio, nr_segs);
> > +		/*
> > +		 * Reverse check our software queue for entries that we could
> > +		 * potentially merge with. Currently includes a hand-wavy stop
> > +		 * count of 8, to not spend too much time checking for merges.
> > +		 */
> > +		if (blk_mq_bio_list_merge(q, &ctx->rq_lists[type], bio, nr_segs)) {
> > +			ctx->rq_merged++;
> > +			ret = true;
> > +		}
> > +
> >  		spin_unlock(&ctx->lock);
> 
> This adds an overly long line.  That being said the whole thing could
> be nicely simplified to:
> 
> 	...
> 
> 	if (e && e->type->ops.bio_merge)
> 		return e->type->ops.bio_merge(hctx, bio, nr_segs);
> 
> 	if (!(hctx->flags & BLK_MQ_F_SHOULD_MERGE) ||
> 	    list_empty_careful(&ctx->rq_lists[hctx->type]))
> 		return false;
> 
> 	/*
> 	 * Reverse check our software queue for entries that we could
> 	 * potentially merge with. Currently includes a hand-wavy stop count of
> 	 * 8, to not spend too much time checking for merges.
> 	 */
> 	spin_lock(&ctx->lock);
> 	ret = blk_mq_bio_list_merge(q, &ctx->rq_lists[type], bio, nr_segs);
> 	if (ret)
> 		ctx->rq_merged++;
> 	spin_unlock(&ctx->lock);
> 
> Also I think it would make sense to move the locking into
> blk_mq_bio_list_merge.

Sure, will do in next version.

