Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A4024664D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 14:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgHQM0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 08:26:11 -0400
Received: from verein.lst.de ([213.95.11.211]:56693 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgHQM0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:26:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6D81168B02; Mon, 17 Aug 2020 14:26:08 +0200 (CEST)
Date:   Mon, 17 Aug 2020 14:26:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        ming.lei@redhat.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 5/5] block: Remove __blk_mq_sched_bio_merge()
 helper
Message-ID: <20200817122608.GB2213@lst.de>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com> <4ad0888df567a8bd75676b618ad87147c634d7b0.1597637287.git.baolin.wang@linux.alibaba.com> <20200817063241.GE12248@lst.de> <20200817121408.GD79836@VM20190228-100.tbsite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817121408.GD79836@VM20190228-100.tbsite.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 08:14:08PM +0800, Baolin Wang wrote:
> On Mon, Aug 17, 2020 at 08:32:41AM +0200, Christoph Hellwig wrote:
> > On Mon, Aug 17, 2020 at 12:09:19PM +0800, Baolin Wang wrote:
> > > The blk_mq_sched_bio_merge() just wrap the __blk_mq_sched_bio_merge(), and
> > > no other places will use __blk_mq_sched_bio_merge(). Thus we can combine
> > > these 2 similar functions into one function.
> > 
> > I think the idea was to avoid the function call for the nomerges fast
> > path.  Not sure if that is really worth it.
> 
> Um, no places will use __blk_mq_sched_bio_merge(), not sure if it is a
> good choice we still keep an unused and similar function?

Well, blk_mq_sched_bio_merge calls __blk_mq_sched_bio_merge, after
performing two fast path checks.
