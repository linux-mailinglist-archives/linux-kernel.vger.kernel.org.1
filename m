Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 403451A1DB7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 11:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgDHJBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 05:01:09 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:62953 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbgDHJBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:01:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586336468; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=ioV0hD7yVG8wHh03kVR20mogkH+ndszSU6pwn+sJw7o=; b=wa11HWxOUQCx8aMaqKqqh/xk9g4dZ+Eh5pSGTed4OnTEAG1jStWKbnM4JQcER1x2zyMb82Og
 TOLCC/5Y4aagaD2C5DQ3q1Ns9x3NMB4P1BsvevMJmJuOIxxTEjfkSkpEcgw7HtcowTpzkFDy
 nkeZFFd0xIpdO//68pt0IjT+zog=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8d92b0.7f8f48a6be30-smtp-out-n02;
 Wed, 08 Apr 2020 09:00:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C792FC43637; Wed,  8 Apr 2020 09:00:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89A98C433BA;
        Wed,  8 Apr 2020 09:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89A98C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Wed, 8 Apr 2020 14:30:24 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stummala@codeaurora.org
Subject: Re: [PATCH v3] f2fs: fix long latency due to discard during umount
Message-ID: <20200408090024.GC20234@codeaurora.org>
References: <1585550730-1858-1-git-send-email-stummala@codeaurora.org>
 <20200331184655.GB198665@google.com>
 <20200401092201.GB20234@codeaurora.org>
 <20200403171943.GC68460@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403171943.GC68460@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

On Fri, Apr 03, 2020 at 10:19:43AM -0700, Jaegeuk Kim wrote:
> On 04/01, Sahitya Tummala wrote:
> > Hi Jaegeuk,
> > 
> > On Tue, Mar 31, 2020 at 11:46:55AM -0700, Jaegeuk Kim wrote:
> > > On 03/30, Sahitya Tummala wrote:
> > > > F2FS already has a default timeout of 5 secs for discards that
> > > > can be issued during umount, but it can take more than the 5 sec
> > > > timeout if the underlying UFS device queue is already full and there
> > > > are no more available free tags to be used. In that case, submit_bio()
> > > > will wait for the already queued discard requests to complete to get
> > > > a free tag, which can potentially take way more than 5 sec.
> > > > 
> > > > Fix this by submitting the discard requests with REQ_NOWAIT
> > > > flags during umount. This will return -EAGAIN for UFS queue/tag full
> > > > scenario without waiting in the context of submit_bio(). The FS can
> > > > then handle these requests by retrying again within the stipulated
> > > > discard timeout period to avoid long latencies.
> > > 
> > > Sorry, Sahitya, but, do we really need to do like this? How about just
> > > controlling # of outstanding discarding bios in __issue_discard_cmd()?
> > 
> > Do you mean something like this?
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 1a62b27..860dd43 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -1099,7 +1099,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
> >         } else if (discard_type == DPOLICY_FSTRIM) {
> >                 dpolicy->io_aware = false;
> >         } else if (discard_type == DPOLICY_UMOUNT) {
> > -               dpolicy->max_requests = UINT_MAX;
> > +               dpolicy->max_requests = 30;
> 
> Can we use max queue depth of the block device?

I think it should be limited to 8 or 16 as Chao suggested, so that we can have
better control on the given timeout value? Thoughts?

Thanks,

> 
> >                 dpolicy->io_aware = false;
> >                 /* we need to issue all to keep CP_TRIMMED_FLAG */
> >                 dpolicy->granularity = 1;
> > @@ -1470,12 +1470,14 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> >         struct list_head *pend_list;
> >         struct discard_cmd *dc, *tmp;
> >         struct blk_plug plug;
> > -       int i, issued = 0;
> > +       int i, issued;
> >         bool io_interrupted = false;
> > 
> >         if (dpolicy->timeout != 0)
> >                 f2fs_update_time(sbi, dpolicy->timeout);
> > 
> > +retry:
> > +       issued = 0;
> >         for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
> >                 if (dpolicy->timeout != 0 &&
> >                                 f2fs_time_over(sbi, dpolicy->timeout))
> > @@ -1522,6 +1524,11 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> >                         break;
> >         }
> > 
> > +       if (dpolicy->type == DPOLICY_UMOUNT && issued) {
> > +               __wait_all_discard_cmd(sbi, dpolicy);
> > +               goto retry;
> > +       }
> > +
> >         if (!issued && io_interrupted)
> >                 issued = -1;
> > 
> > Thanks,
> > 
> > > 
> > > > 
> > > > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > > > ---
> > > > v3:
> > > > -Handle the regression reported by Chao with v2.
> > > > -simplify the logic to split the dc with multiple bios incase any bio returns
> > > >  EAGAIN and retry those new dc within 5 sec timeout.
> > > > 
> > > >  fs/f2fs/segment.c | 65 +++++++++++++++++++++++++++++++++++++++++++------------
> > > >  1 file changed, 51 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > > index fb3e531..55d18c7 100644
> > > > --- a/fs/f2fs/segment.c
> > > > +++ b/fs/f2fs/segment.c
> > > > @@ -1029,13 +1029,16 @@ static void f2fs_submit_discard_endio(struct bio *bio)
> > > >  	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
> > > >  	unsigned long flags;
> > > >  
> > > > -	dc->error = blk_status_to_errno(bio->bi_status);
> > > > -
> > > >  	spin_lock_irqsave(&dc->lock, flags);
> > > > +	if (!dc->error)
> > > > +		dc->error = blk_status_to_errno(bio->bi_status);
> > > > +
> > > >  	dc->bio_ref--;
> > > > -	if (!dc->bio_ref && dc->state == D_SUBMIT) {
> > > > -		dc->state = D_DONE;
> > > > -		complete_all(&dc->wait);
> > > > +	if (!dc->bio_ref) {
> > > > +		if (dc->error || dc->state == D_SUBMIT) {
> > > > +			dc->state = D_DONE;
> > > > +			complete_all(&dc->wait);
> > > > +		}
> > > >  	}
> > > >  	spin_unlock_irqrestore(&dc->lock, flags);
> > > >  	bio_put(bio);
> > > > @@ -1124,10 +1127,13 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
> > > >  	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> > > >  	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
> > > >  					&(dcc->fstrim_list) : &(dcc->wait_list);
> > > > -	int flag = dpolicy->sync ? REQ_SYNC : 0;
> > > > +	int flag;
> > > >  	block_t lstart, start, len, total_len;
> > > >  	int err = 0;
> > > >  
> > > > +	flag = dpolicy->sync ? REQ_SYNC : 0;
> > > > +	flag |= dpolicy->type == DPOLICY_UMOUNT ? REQ_NOWAIT : 0;
> > > > +
> > > >  	if (dc->state != D_PREP)
> > > >  		return 0;
> > > >  
> > > > @@ -1192,10 +1198,6 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
> > > >  		dc->bio_ref++;
> > > >  		spin_unlock_irqrestore(&dc->lock, flags);
> > > >  
> > > > -		atomic_inc(&dcc->queued_discard);
> > > > -		dc->queued++;
> > > > -		list_move_tail(&dc->list, wait_list);
> > > > -
> > > >  		/* sanity check on discard range */
> > > >  		__check_sit_bitmap(sbi, lstart, lstart + len);
> > > >  
> > > > @@ -1203,6 +1205,29 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
> > > >  		bio->bi_end_io = f2fs_submit_discard_endio;
> > > >  		bio->bi_opf |= flag;
> > > >  		submit_bio(bio);
> > > > +		if (flag & REQ_NOWAIT) {
> > > > +			if (dc->error == -EAGAIN) {
> > > > +				spin_lock_irqsave(&dc->lock, flags);
> > > > +				dc->len -= len;
> > > > +				if (!dc->len) {
> > > > +					dc->len = total_len;
> > > > +					dc->state = D_PREP;
> > > > +					reinit_completion(&dc->wait);
> > > > +				} else {
> > > > +					dcc->undiscard_blks -= total_len;
> > > > +					if (dc->state == D_PARTIAL)
> > > > +						dc->state = D_SUBMIT;
> > > > +				}
> > > > +				err = dc->error;
> > > > +				dc->error = 0;
> > > > +				spin_unlock_irqrestore(&dc->lock, flags);
> > > > +				break;
> > > > +			}
> > > > +		}
> > > > +
> > > > +		atomic_inc(&dcc->queued_discard);
> > > > +		dc->queued++;
> > > > +		list_move_tail(&dc->list, wait_list);
> > > >  
> > > >  		atomic_inc(&dcc->issued_discard);
> > > >  
> > > > @@ -1214,8 +1239,9 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
> > > >  		len = total_len;
> > > >  	}
> > > >  
> > > > -	if (!err && len)
> > > > -		__update_discard_tree_range(sbi, bdev, lstart, start, len);
> > > > +	if ((!err || err == -EAGAIN) && total_len && dc->start != start)
> > > > +		__update_discard_tree_range(sbi, bdev, lstart, start,
> > > > +					total_len);
> > > >  	return err;
> > > >  }
> > > >  
> > > > @@ -1470,12 +1496,15 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> > > >  	struct list_head *pend_list;
> > > >  	struct discard_cmd *dc, *tmp;
> > > >  	struct blk_plug plug;
> > > > -	int i, issued = 0;
> > > > +	int i, err, issued = 0;
> > > >  	bool io_interrupted = false;
> > > > +	bool retry;
> > > >  
> > > >  	if (dpolicy->timeout != 0)
> > > >  		f2fs_update_time(sbi, dpolicy->timeout);
> > > >  
> > > > +retry:
> > > > +	retry = false;
> > > >  	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
> > > >  		if (dpolicy->timeout != 0 &&
> > > >  				f2fs_time_over(sbi, dpolicy->timeout))
> > > > @@ -1509,7 +1538,12 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> > > >  				break;
> > > >  			}
> > > >  
> > > > -			__submit_discard_cmd(sbi, dpolicy, dc, &issued);
> > > > +			err = __submit_discard_cmd(sbi, dpolicy, dc, &issued);
> > > > +			if (err == -EAGAIN) {
> > > > +				congestion_wait(BLK_RW_ASYNC,
> > > > +						DEFAULT_IO_TIMEOUT);
> > > > +				retry = true;
> > > > +			}
> > > >  
> > > >  			if (issued >= dpolicy->max_requests)
> > > >  				break;
> > > > @@ -1522,6 +1556,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> > > >  			break;
> > > >  	}
> > > >  
> > > > +	if (retry)
> > > > +		goto retry;
> > > > +
> > > >  	if (!issued && io_interrupted)
> > > >  		issued = -1;
> > > >  
> > > > -- 
> > > > Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> > > > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> > 
> > -- 
> > --
> > Sent by a consultant of the Qualcomm Innovation Center, Inc.
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
