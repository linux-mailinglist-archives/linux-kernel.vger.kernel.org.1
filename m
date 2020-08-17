Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D04D246649
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 14:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgHQMY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 08:24:57 -0400
Received: from verein.lst.de ([213.95.11.211]:56682 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgHQMYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:24:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A767468B02; Mon, 17 Aug 2020 14:24:40 +0200 (CEST)
Date:   Mon, 17 Aug 2020 14:24:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        ming.lei@redhat.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 3/5] block: Add a new helper to attempt to merge
 a bio
Message-ID: <20200817122440.GA2213@lst.de>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com> <5b932aa51fc2b46c381d7b83d591a6ddbf05b199.1597637287.git.baolin.wang@linux.alibaba.com> <20200817062634.GC12248@lst.de> <20200817121002.GB79836@VM20190228-100.tbsite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817121002.GB79836@VM20190228-100.tbsite.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 08:10:02PM +0800, Baolin Wang wrote:
> On Mon, Aug 17, 2020 at 08:26:34AM +0200, Christoph Hellwig wrote:
> > On Mon, Aug 17, 2020 at 12:09:17PM +0800, Baolin Wang wrote:
> > > There are lots of duplicated code when trying to merge a bio from
> > > plug list and sw queue, we can introduce a new helper to attempt
> > > to merge a bio, which can simplify the blk_mq_bio_list_merge()
> > > and blk_attempt_plug_merge().
> > 
> > Looks sensible, but two comments:
> > 
> > > +enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
> > > +					    struct request *rq,
> > > +					    struct bio *bio,
> > > +					    unsigned int nr_segs)
> > > +{
> > > +	bool merged = false;
> > > +
> > > +	if (!blk_rq_merge_ok(rq, bio))
> > > +		return BIO_MERGE_NONE;
> > > +
> > > +	switch (blk_try_merge(rq, bio)) {
> > > +	case ELEVATOR_BACK_MERGE:
> > > +		merged = bio_attempt_back_merge(rq, bio, nr_segs);
> > > +		break;
> > > +	case ELEVATOR_FRONT_MERGE:
> > > +		merged = bio_attempt_front_merge(rq, bio, nr_segs);
> > > +		break;
> > > +	case ELEVATOR_DISCARD_MERGE:
> > > +		merged = bio_attempt_discard_merge(q, rq, bio);
> > > +		break;
> > 
> > Can't we also switch the bio_attempt_*merge helpers to return
> > enum bio_merge_status to simplify this a bit?
> 
> Yes, will do.
> 
> > 
> > Also I think these helpers can be marked static now, although I didn't
> > actually apply your series, so I might have missed something.
> 
> Cause this function will be used by blk_mq_bio_list_merge() in
> blk-mq-sched.c, it should be exported.

Shouldn't blk_mq_bio_list_merge move to blk-merge.c as well?
