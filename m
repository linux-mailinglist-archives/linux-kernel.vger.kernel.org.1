Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A48A2EF9E2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbhAHVEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:04:00 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:29484 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbhAHVEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:04:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610139814; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=P2i/w2NGM6kNbgN8vyY6XxmXd+fcd/x2L+FLno+MqfE=;
 b=Mm+SvarPs81VykYyb7bm2LQMLjJk5u06n1PH72NvZe+mtFc3aPHN2Cgc9Tuw1D0cVXiq5TDk
 Ldr0xQEoL1c6HhPSFeHpbfXFPZ2yob8wtYgDvVEdaLo/hjjRZ3EJeXIu8kKlSgmlvFUK0pfl
 8M1SbRwkVeVmZetXZpstvf8N8+s=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ff8c888415a6293c51dd1ce (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 08 Jan 2021 21:03:04
 GMT
Sender: rishabhb=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B0D3AC433CA; Fri,  8 Jan 2021 21:03:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD5FBC433C6;
        Fri,  8 Jan 2021 21:03:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 08 Jan 2021 13:03:02 -0800
From:   rishabhb@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Alex Elder <elder@linaro.org>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH] remoteproc: Create a separate workqueue for recovery
 tasks
In-Reply-To: <X+E/W2Sf6fkNaiTC@builder.lan>
References: <1607806087-27244-1-git-send-email-rishabhb@codeaurora.org>
 <X9k+xmg9SULEbJXe@builder.lan>
 <dc9940f0-7fe3-d1da-acb5-580ae7366c9b@linaro.org>
 <87c3f902b94bc243fc28e0ce79303dd4@codeaurora.org>
 <35e2106f-d738-4018-50f2-17afcbc627f7@linaro.org>
 <X+E/W2Sf6fkNaiTC@builder.lan>
Message-ID: <65cb9eb0837cd4edee2f2902055f412c@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-21 16:35, Bjorn Andersson wrote:
> On Thu 17 Dec 12:49 CST 2020, Alex Elder wrote:
> 
>> On 12/17/20 12:21 PM, rishabhb@codeaurora.org wrote:
>> > On 2020-12-17 08:12, Alex Elder wrote:
>> > > On 12/15/20 4:55 PM, Bjorn Andersson wrote:
>> > > > On Sat 12 Dec 14:48 CST 2020, Rishabh Bhatnagar wrote:
>> > > >
>> > > > > Create an unbound high priority workqueue for recovery tasks.
>> > >
>> > > I have been looking at a different issue that is caused by
>> > > crash notification.
>> > >
>> > > What happened was that the modem crashed while the AP was
>> > > in system suspend (or possibly even resuming) state.  And
>> > > there is no guarantee that the system will have called a
>> > > driver's ->resume callback when the crash notification is
>> > > delivered.
>> > >
>> > > In my case (in the IPA driver), handling a modem crash
>> > > cannot be done while the driver is suspended; i.e. the
>> > > activities in its ->resume callback must be completed
>> > > before we can recover from the crash.
>> > >
>> > > For this reason I might like to change the way the
>> > > crash notification is handled, but what I'd rather see
>> > > is to have the work queue not run until user space
>> > > is unfrozen, which would guarantee that all drivers
>> > > that have registered for a crash notification will
>> > > be resumed when the notification arrives.
>> > >
>> > > I'm not sure how that interacts with what you are
>> > > looking for here.  I think the workqueue could still
>> > > be unbound, but its work would be delayed longer before
>> > > any notification (and recovery) started.
>> > >
>> > >                     -Alex
>> > >
>> > >
>> > In that case, maybe adding a "WQ_FREEZABLE" flag might help?
>> 
>> Yes, exactly.  But how does that affect whatever you were
>> trying to do with your patch?
>> 
> 
> I don't see any impact on Rishabh's change in particular, syntactically
> it would just be a matter of adding another flag and the impact would 
> be
> separate from his patch.
> 
> In other words, creating a separate work queue to get the long running
> work off the system_wq and making sure that these doesn't run during
> suspend & resume seems very reasonable to me.
> 
> The one piece that I'm still contemplating is the HIPRIO, I would like
> to better understand the actual impact - or perhaps is this a result of
> everyone downstream moving all their work to HIPRIO work queues,
> starving the recovery?
> 
Hi Bjorn,
You are right, this is a result of downstream having HIPRIO workqueues
therefore starving recovery. I don't have actual data to support the 
flag
as of now. If needed for now we can skip this flag and add it later with
sufficient data?
> Regards,
> Bjorn
