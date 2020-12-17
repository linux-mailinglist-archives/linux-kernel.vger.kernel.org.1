Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFAA2DD82E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 19:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbgLQSWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 13:22:11 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:41040 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgLQSWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 13:22:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608229311; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=uDlTTR0Cfma4aSUzb8Egeut+U21yuCwXAadjUdyUhZA=;
 b=Aa7qzhDKlaj1lf5aZyxByDMRi9pkJpuwHlokOmknOmm2xce/uRVkMkvhirdbtq+HX0z9ZFh5
 I49y5VcPzjjXNEMffFqTZqxSB9ByvU92+RCtkFCOvPLEs4UyOyLz+Os2vYj/kIt+5Fwg/tIe
 mwVMBVdG1XQyQVDf78MTFFVhP/4=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5fdba1a2ca81d9e625eab5e6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Dec 2020 18:21:22
 GMT
Sender: rishabhb=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B0F90C433ED; Thu, 17 Dec 2020 18:21:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19D7BC433CA;
        Thu, 17 Dec 2020 18:21:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Dec 2020 10:21:20 -0800
From:   rishabhb@codeaurora.org
To:     Alex Elder <elder@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH] remoteproc: Create a separate workqueue for recovery
 tasks
In-Reply-To: <dc9940f0-7fe3-d1da-acb5-580ae7366c9b@linaro.org>
References: <1607806087-27244-1-git-send-email-rishabhb@codeaurora.org>
 <X9k+xmg9SULEbJXe@builder.lan>
 <dc9940f0-7fe3-d1da-acb5-580ae7366c9b@linaro.org>
Message-ID: <87c3f902b94bc243fc28e0ce79303dd4@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-17 08:12, Alex Elder wrote:
> On 12/15/20 4:55 PM, Bjorn Andersson wrote:
>> On Sat 12 Dec 14:48 CST 2020, Rishabh Bhatnagar wrote:
>> 
>>> Create an unbound high priority workqueue for recovery tasks.
> 
> I have been looking at a different issue that is caused by
> crash notification.
> 
> What happened was that the modem crashed while the AP was
> in system suspend (or possibly even resuming) state.  And
> there is no guarantee that the system will have called a
> driver's ->resume callback when the crash notification is
> delivered.
> 
> In my case (in the IPA driver), handling a modem crash
> cannot be done while the driver is suspended; i.e. the
> activities in its ->resume callback must be completed
> before we can recover from the crash.
> 
> For this reason I might like to change the way the
> crash notification is handled, but what I'd rather see
> is to have the work queue not run until user space
> is unfrozen, which would guarantee that all drivers
> that have registered for a crash notification will
> be resumed when the notification arrives.
> 
> I'm not sure how that interacts with what you are
> looking for here.  I think the workqueue could still
> be unbound, but its work would be delayed longer before
> any notification (and recovery) started.
> 
> 					-Alex
> 
> 
In that case, maybe adding a "WQ_FREEZABLE" flag might help?
> 
>> This simply repeats $subject
>> 
>>> Recovery time is an important parameter for a subsystem and there
>>> might be situations where multiple subsystems crash around the same
>>> time.  Scheduling into an unbound workqueue increases parallelization
>>> and avoids time impact.
>> 
>> You should be able to write this more succinctly. The important part 
>> is
>> that you want an unbound work queue to allow recovery to happen in
>> parallel - which naturally implies that you care about recovery 
>> latency.
>> 
>>> Also creating a high priority workqueue
>>> will utilize separate worker threads with higher nice values than
>>> normal ones.
>>> 
>> 
>> This doesn't describe why you need the higher priority.
>> 
>> 
>> I believe, and certainly with the in-line coredump, that we're running
>> our recovery work for way too long to be queued on the system_wq. As
>> such the content of the patch looks good!
>> 
>> Regards,
>> Bjorn
>> 
>>> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>>> ---
>>>   drivers/remoteproc/remoteproc_core.c | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/remoteproc/remoteproc_core.c 
>>> b/drivers/remoteproc/remoteproc_core.c
>>> index 46c2937..8fd8166 100644
>>> --- a/drivers/remoteproc/remoteproc_core.c
>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>> @@ -48,6 +48,8 @@ static DEFINE_MUTEX(rproc_list_mutex);
>>>   static LIST_HEAD(rproc_list);
>>>   static struct notifier_block rproc_panic_nb;
>>>   +static struct workqueue_struct *rproc_wq;
>>> +
>>>   typedef int (*rproc_handle_resource_t)(struct rproc *rproc,
>>>   				 void *, int offset, int avail);
>>>   @@ -2475,7 +2477,7 @@ void rproc_report_crash(struct rproc *rproc, 
>>> enum rproc_crash_type type)
>>>   		rproc->name, rproc_crash_to_string(type));
>>>     	/* create a new task to handle the error */
>>> -	schedule_work(&rproc->crash_handler);
>>> +	queue_work(rproc_wq, &rproc->crash_handler);
>>>   }
>>>   EXPORT_SYMBOL(rproc_report_crash);
>>>   @@ -2520,6 +2522,10 @@ static void __exit rproc_exit_panic(void)
>>>     static int __init remoteproc_init(void)
>>>   {
>>> +	rproc_wq = alloc_workqueue("rproc_wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
>>> +	if (!rproc_wq)
>>> +		return -ENOMEM;
>>> +
>>>   	rproc_init_sysfs();
>>>   	rproc_init_debugfs();
>>>   	rproc_init_cdev();
>>> @@ -2536,6 +2542,7 @@ static void __exit remoteproc_exit(void)
>>>   	rproc_exit_panic();
>>>   	rproc_exit_debugfs();
>>>   	rproc_exit_sysfs();
>>> +	destroy_workqueue(rproc_wq);
>>>   }
>>>   module_exit(remoteproc_exit);
>>>   -- The Qualcomm Innovation Center, Inc. is a member of the Code 
>>> Aurora Forum,
>>> a Linux Foundation Collaborative Project
>>> 
