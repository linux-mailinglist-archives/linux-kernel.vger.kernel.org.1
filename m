Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FC92C40E7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 14:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgKYNJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 08:09:01 -0500
Received: from z5.mailgun.us ([104.130.96.5]:12852 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgKYNJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:09:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606309740; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=wCJRRp0K1xVBYnPLLsaAQKWw98Ye4+26A8piSTi3UeA=; b=D1/ppKeY5KxGCHNSMqTC1DJMtiAm/6JpjIkcIRbiTdcaC14aKAEwrg7BVNRHx2rs6YyKKWtl
 Lr5FgQr5iuBt8jvZi7nDrolZihEodJSKT/PHRHgJU0Qzmuz3JD88kh3melorcrbDE+hOxdUJ
 b8y4qykeyjyKg4SoPIEfN3vhxDE=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5fbe576a1b731a5d9caef5e3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Nov 2020 13:08:58
 GMT
Sender: stummala=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A16A6C43463; Wed, 25 Nov 2020 13:08:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0CE36C433ED;
        Wed, 25 Nov 2020 13:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0CE36C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=stummala@codeaurora.org
Date:   Wed, 25 Nov 2020 18:38:51 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Chao Yu' <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] f2fs: change to use rwsem for cp_mutex
Message-ID: <20201125130851.GA22157@codeaurora.org>
References: <1606109312-1944-1-git-send-email-stummala@codeaurora.org>
 <7f5213fb9b334d1290f019ab8ed6ee71@AcuMS.aculab.com>
 <a1b9a134-97a8-6fb7-2fdc-d4de91dff849@huawei.com>
 <effbe4f5edaf4d45a64d12c65e0dc6b0@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <effbe4f5edaf4d45a64d12c65e0dc6b0@AcuMS.aculab.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, Nov 24, 2020 at 09:12:12AM +0000, David Laight wrote:
> From: Chao Yu
> > Sent: 24 November 2020 03:12
> > 
> > On 2020/11/24 1:05, David Laight wrote:
> > > From: Sahitya Tummala
> > >> Sent: 23 November 2020 05:29
> > >>
> > >> Use rwsem to ensure serialization of the callers and to avoid
> > >> starvation of high priority tasks, when the system is under
> > >> heavy IO workload.
> > >
> > > I can't see any read lock requests.
> > >
> > > So why the change?
> > 
> > Hi David,
> > 
> > You can check the context of this patch in below link:
> > 
> > https://lore.kernel.org/linux-f2fs-devel/8e094021b958f9fe01df1183a2677882@codeaurora.org/T/#t
> > 
> > BTW, the root cause here is that mutex lock won't serialize callers, so there
> > could be potential starvation problem when this lock is always grabbed by high
> > priority tasks.
> 
> That doesn't seem right.
> 
> If I read the above correctly it was high priority tasks that were
> being 'starved' precisely because mutex lock serializes wakers.

Actually it can happen for any random task irrespective of the priority.
In my case, I was observing that the thread that went to sleep first is
not able to acquire the lock first and other new threads that came in
just around the mutex unlock time were acquiring the lock.

> 
> If you have a lock that is contended so much that it is held 100%
> of the time you need a different locking strategy.
> 
> IIRC mutex locks are 'ticket' locks so that only one thread is woken
> each time the mutex is released, and they are woken in the order
> they went to sleep.

AFAIK mutex locks doesn't *strictly* enforce FIFO order. The lock is released
before waking the first waiting task. The waiting task has to run to claim
the lock. So the lock is available for other tasks in this *short* window.

Thanks,

> 
> While this behaviour might not be the one you want, relying on
> rwsem (which might happen currently to work differently) doesn't
> seem the correct long term fix.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
