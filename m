Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D50247CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 05:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgHRDbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 23:31:03 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:47372 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726228AbgHRDbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:31:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U668IKE_1597721458;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U668IKE_1597721458)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Aug 2020 11:30:58 +0800
Date:   Tue, 18 Aug 2020 11:30:58 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 3/5] block: Add a new helper to attempt to merge a
 bio
Message-ID: <20200818033058.GB46480@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
 <5b932aa51fc2b46c381d7b83d591a6ddbf05b199.1597637287.git.baolin.wang@linux.alibaba.com>
 <20200817062634.GC12248@lst.de>
 <20200817121002.GB79836@VM20190228-100.tbsite.net>
 <20200817122440.GA2213@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817122440.GA2213@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 02:24:40PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 17, 2020 at 08:10:02PM +0800, Baolin Wang wrote:
> > On Mon, Aug 17, 2020 at 08:26:34AM +0200, Christoph Hellwig wrote:
> > > On Mon, Aug 17, 2020 at 12:09:17PM +0800, Baolin Wang wrote:
> > > > There are lots of duplicated code when trying to merge a bio from
> > > > plug list and sw queue, we can introduce a new helper to attempt
> > > > to merge a bio, which can simplify the blk_mq_bio_list_merge()
> > > > and blk_attempt_plug_merge().
> > > 
> > > Looks sensible, but two comments:
> > > 
> > > > +enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
> > > > +					    struct request *rq,
> > > > +					    struct bio *bio,
> > > > +					    unsigned int nr_segs)
> > > > +{
> > > > +	bool merged = false;
> > > > +
> > > > +	if (!blk_rq_merge_ok(rq, bio))
> > > > +		return BIO_MERGE_NONE;
> > > > +
> > > > +	switch (blk_try_merge(rq, bio)) {
> > > > +	case ELEVATOR_BACK_MERGE:
> > > > +		merged = bio_attempt_back_merge(rq, bio, nr_segs);
> > > > +		break;
> > > > +	case ELEVATOR_FRONT_MERGE:
> > > > +		merged = bio_attempt_front_merge(rq, bio, nr_segs);
> > > > +		break;
> > > > +	case ELEVATOR_DISCARD_MERGE:
> > > > +		merged = bio_attempt_discard_merge(q, rq, bio);
> > > > +		break;
> > > 
> > > Can't we also switch the bio_attempt_*merge helpers to return
> > > enum bio_merge_status to simplify this a bit?
> > 
> > Yes, will do.
> > 
> > > 
> > > Also I think these helpers can be marked static now, although I didn't
> > > actually apply your series, so I might have missed something.
> > 
> > Cause this function will be used by blk_mq_bio_list_merge() in
> > blk-mq-sched.c, it should be exported.
> 
> Shouldn't blk_mq_bio_list_merge move to blk-merge.c as well?

Yes, I can move it to blk-merge.c and rename to a generic name.

