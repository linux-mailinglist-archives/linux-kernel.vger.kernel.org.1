Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A811D2995AB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790288AbgJZSrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:47:25 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:46237 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1790226AbgJZSrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:47:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603738043; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=IuMktuI/NzJNFZzTb5UtNKt9fniQXDSsFqHN0KzCiy4=;
 b=F6WWq8qn7ukVx3F7/GbgO+XfR2rjAw+J8UYUvOhhF/SApQBLH08RIyzoie47moTwKV/hSkpq
 G8J04w7mEUIUASptHty/PzJePer29dOTDA1K+OzYaE9YowISjutcPItkuSP3NrgHe020zehn
 iUE0pLvSeR1vIUvgn3J0MxF6rHw=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f9719ba0fda47b9a08edc78 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Oct 2020 18:47:22
 GMT
Sender: asutoshd=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CA967C43387; Mon, 26 Oct 2020 18:47:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: asutoshd)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C9E6C433CB;
        Mon, 26 Oct 2020 18:47:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 26 Oct 2020 11:47:21 -0700
From:   asutoshd@codeaurora.org
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Can Guo <cang@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel-team@android.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: Re: [PATCH v2 5/5] scsi: ufs: fix clkgating on/off correctly
In-Reply-To: <20201022201825.GA3329812@google.com>
References: <20201020195258.2005605-1-jaegeuk@kernel.org>
 <20201020195258.2005605-6-jaegeuk@kernel.org>
 <2a8ecc4185b3a5411077f4e3fc66000f@codeaurora.org>
 <20201021045213.GB3004521@google.com>
 <e3e58a89474d23f1b9446fe2e38a7426@codeaurora.org>
 <20201022201825.GA3329812@google.com>
Message-ID: <a2ea723559452252208dca932d0be3f9@codeaurora.org>
X-Sender: asutoshd@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-22 17:53, Jaegeuk Kim wrote:
> On 10/21, Can Guo wrote:
>> On 2020-10-21 12:52, jaegeuk@kernel.org wrote:
>> > On 10/21, Can Guo wrote:
>> > > On 2020-10-21 03:52, Jaegeuk Kim wrote:
>> > > > The below call stack prevents clk_gating at every IO completion.
>> > > > We can remove the condition, ufshcd_any_tag_in_use(), since
>> > > > clkgating_work
>> > > > will check it again.
>> > > >
>> > >
>> > > I think checking ufshcd_any_tag_in_use() in either ufshcd_release() or
>> > > gate_work() can break UFS clk gating's functionality.
>> > >
>> > > ufshcd_any_tag_in_use() was introduced to replace hba->lrb_in_use.
>> > > However,
>> > > they are not exactly same - ufshcd_any_tag_in_use() returns true if
>> > > any tag
>> > > assigned from block layer is still in use, but tags are released
>> > > asynchronously
>> > > (through block softirq), meaning it does not reflect the real
>> > > occupation of
>> > > UFS host.
>> > > That is after UFS host finishes all tasks, ufshcd_any_tag_in_use()
>> > > can still
>> > > return true.
>> > >
>> > > This change only removes the check of ufshcd_any_tag_in_use() in
>> > > ufshcd_release(),
>> > > but having the check of it in gate_work() can still prevent gating
>> > > from
>> > > happening.
>> > > The current change works for you maybe because the tags are release
>> > > before
>> > > hba->clk_gating.delay_ms expires, but if hba->clk_gating.delay_ms is
>> > > shorter
>> > > or
>> > > somehow block softirq is retarded, gate_work() may have chance to see
>> > > ufshcd_any_tag_in_use()
>> > > returns true. What do you think?
>> >
>> > I don't think this breaks clkgating, but fix the wrong condition check
>> > which
>> > prevented gate_work at all. As you mentioned, even if this schedules
>> > gate_work
>> > by racy conditions, gate_work will handle it as a last resort.
>> >
>> 
>> If clocks cannot be gated after the last task is cleared from UFS 
>> host, then
>> clk gating
>> is broken, no? Assume UFS has completed the last task in its queue, as 
>> this
>> change says,
>> ufshcd_any_tag_in_use() is preventing ufshcd_release() from invoking
>> gate_work().
>> Similarly, ufshcd_any_tag_in_use() can prevent gate_work() from doing 
>> its
>> real work -
>> disabling the clocks. Do you agree?
>> 
>>         if (hba->clk_gating.active_reqs
>>                 || hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL
>>                 || ufshcd_any_tag_in_use(hba) || 
>> hba->outstanding_tasks
>>                 || hba->active_uic_cmd || hba->uic_async_done)
>>                 goto rel_lock;
> 
> I see the point, but this happens only when clkgate_delay_ms is too 
> short
> to give enough time for releasing tag. If it's correctly set, I think 
> there'd
> be no problem, unless softirq was delayed by other RT threads which is 
> just
> a corner case tho.
> 
>> 
>> Thanks,
>> 
>> Can Guo.
>> 
>> > >
>> > > Thanks,
>> > >
>> > > Can Guo.
>> > >
>> > > In __ufshcd_transfer_req_compl
>> > > Ihba->lrb_in_use is cleared immediately when UFS driver
>> > > finishes all tasks
>> > >
>> > > > ufshcd_complete_requests(struct ufs_hba *hba)
>> > > >   ufshcd_transfer_req_compl()
>> > > >     __ufshcd_transfer_req_compl()
>> > > >       __ufshcd_release(hba)
>> > > >         if (ufshcd_any_tag_in_use() == 1)
>> > > >            return;
>> > > >   ufshcd_tmc_handler(hba);
>> > > >     blk_mq_tagset_busy_iter();
>> > > >
>> > > > Cc: Alim Akhtar <alim.akhtar@samsung.com>
>> > > > Cc: Avri Altman <avri.altman@wdc.com>
>> > > > Cc: Can Guo <cang@codeaurora.org>
>> > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> > > > ---
>> > > >  drivers/scsi/ufs/ufshcd.c | 2 +-
>> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > > >
>> > > > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> > > > index b5ca0effe636..cecbd4ace8b4 100644
>> > > > --- a/drivers/scsi/ufs/ufshcd.c
>> > > > +++ b/drivers/scsi/ufs/ufshcd.c
>> > > > @@ -1746,7 +1746,7 @@ static void __ufshcd_release(struct ufs_hba *hba)
>> > > >
>> > > >  	if (hba->clk_gating.active_reqs || hba->clk_gating.is_suspended ||
>> > > >  	    hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL ||
>> > > > -	    ufshcd_any_tag_in_use(hba) || hba->outstanding_tasks ||
>> > > > +	    hba->outstanding_tasks ||
>> > > >  	    hba->active_uic_cmd || hba->uic_async_done)
>> > > >  		return;

How about checking outstanding_reqs as well, say in 
ufshcd_any_tag_in_use() ?

-asd
