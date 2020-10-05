Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098432835E7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgJEMng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:43:36 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:37944 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgJEMng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:43:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601901814; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=tU0TqlUvWa2j8PEBBpsVnjkiW09OMXXbmI8+GEaHnO8=; b=JxUxk4lhNhjB1mLVvK2Be0ywXxAANtfVZ7XtHEUwnafzS0qy+OzgZ+VlOtuXeX4x+AE806ss
 iDpfDqxO/1xkfY7tFU5on8gqrdmR6b8jE9CTMNUl1ruokfuQ4/qPsst93SmgY6czPe3zCMXC
 EgER0LK5uud+T5uwLurCNBPUlqA=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f7b14d842f9861fb100958b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 05 Oct 2020 12:43:04
 GMT
Sender: pkondeti=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10560C433C8; Mon,  5 Oct 2020 12:43:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D38BDC433CA;
        Mon,  5 Oct 2020 12:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D38BDC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pkondeti@codeaurora.org
Date:   Mon, 5 Oct 2020 18:12:58 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Yun Hsiang <hsiang023167@gmail.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] sched/uclamp: release per-task uclamp control if
 user set to default value
Message-ID: <20201005124258.GA11335@codeaurora.org>
References: <20200928082643.133257-1-hsiang023167@gmail.com>
 <8272de8d-9868-d419-e2bb-d5e2c0614b63@arm.com>
 <20201002053812.GA176142@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002053812.GA176142@ubuntu>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 01:38:12PM +0800, Yun Hsiang wrote:
> On Wed, Sep 30, 2020 at 03:12:51PM +0200, Dietmar Eggemann wrote:
> Hi Dietmar,
> 
> > Hi Yun,
> > 
> > On 28/09/2020 10:26, Yun Hsiang wrote:
> > > If the user wants to release the util clamp and let cgroup to control it,
> > > we need a method to reset.
> > > 
> > > So if the user set the task uclamp to the default value (0 for UCLAMP_MIN
> > > and 1024 for UCLAMP_MAX), reset the user_defined flag to release control.
> > > 
> > > Signed-off-by: Yun Hsiang <hsiang023167@gmail.com>
> > 
> > could you explain with a little bit more detail why you would need this
> > feature?
> > 
> > Currently we assume that once the per-task uclamp (user-defined) values
> > are set, you could only change the effective uclamp values of this task
> > by (1) moving it into another taskgroup or (2) changing the system
> > default uclamp values.
> > 
> 
> Assume a module that controls group (such as top-app in android) uclamp and
> task A in the group.
> Once task A set uclamp, it will not be affected by the group setting.
> If task A doesn't want to control itself anymore,
> it can not go back to the initial state to let the module(group) control.
> But the other tasks in the group will be affected by the group.
> 
> The policy might be
> 1) if the task wants to control it's uclamp, use task uclamp value
> (but under group uclamp constraint)
> 2) if the task doesn't want to control it's uclamp, use group uclamp value.
> 
> If the policy is proper, we need a reset method for per-task uclamp.

Right. It would be nice to have the capability to reset per-task uclamp
settings. In Android, I have seen tasks in top-app affining to Big cluster.
When these tasks move to background, the cpuset automatically override the
affinity of tasks. If the same use case is extended to use uclamp to set a
high value for some tasks in top-app, there should be a way to reset the
uclamp settings when they are moved to background. I don't know if we ever
see this implemented in Android.

> 
> > > ---
> > >  kernel/sched/core.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 9a2fbf98fd6f..fa63d70d783a 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -1187,6 +1187,7 @@ static void __setscheduler_uclamp(struct task_struct *p,
> > >  				  const struct sched_attr *attr)
> > >  {
> > >  	enum uclamp_id clamp_id;
> > > +	bool user_defined;
> > >  
> > >  	/*
> > >  	 * On scheduling class change, reset to default clamps for tasks
> > > @@ -1210,14 +1211,16 @@ static void __setscheduler_uclamp(struct task_struct *p,
> > >  	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
> > >  		return;
> > >  
> > > +	user_defined = attr->sched_util_min == 0 ? false : true;
> > >  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> > >  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
> > > -			      attr->sched_util_min, true);
> > > +			      attr->sched_util_min, user_defined);
> > >  	}
> > >  
> > > +	user_defined = attr->sched_util_max == 1024 ? false : true;

This does not work for all cases. Lets say a task is in a cgroup which
restricts uclamp.max. The task want to lift this restriction by setting
uclamp.max = 1024. With your approach, we don't honor this. Correct?

> > >  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> > >  		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
> > > -			      attr->sched_util_max, true);
> > > +			      attr->sched_util_max, user_defined);
> > >  	}
> > >  }

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

