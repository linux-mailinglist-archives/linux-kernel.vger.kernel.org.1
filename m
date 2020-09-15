Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BC126B293
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgIOWt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:49:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:20289 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbgIOPns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:43:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600184615; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=4+/7PZHVKulEoyXiC4dXX+dMmnRUKoZCYv7DqvmWz8o=;
 b=LYTNGdcdHI/SV298Dp7jGLXbzc7dgKLS13HbiryaM3UijXQnoptPLu9svCS6P28L8fku1q3G
 R7h5Wn1Y5kEBTeDAXTFkIaMujNd5f3ycrHbup3vA7pvAnCBKfSGf2nzDySOrnViyPejYhHcH
 Hy+lxnOS1lSDOlPUuJ/jrT8QSk0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f60de90947f606f7ee5257e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 15:32:32
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BEF92C433C8; Tue, 15 Sep 2020 15:32:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 07F77C433CA;
        Tue, 15 Sep 2020 15:32:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Sep 2020 21:02:30 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mathieu.poirier@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ohad@wizery.com,
        rishabhb@codeaurora.org
Subject: Re: [PATCH] remoteproc: Fixup coredump debugfs disable request
In-Reply-To: <20200915151837.GC478@uller>
References: <20200915073416.20864-1-sibis@codeaurora.org>
 <20200915151837.GC478@uller>
Message-ID: <e9709b3ceb5d4136ecac77d5416edde8@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bjorn,
Thanks for taking time to review the
patch.

On 2020-09-15 20:48, Bjorn Andersson wrote:
> On Tue 15 Sep 07:34 UTC 2020, Sibi Sankar wrote:
> 
>> Currently the coredump debugfs entry takes in "disable" to set the
>> coredump state to "disabled". Let's just accept the expected state
>> instead.
>> 
> 
> I like this patch, but rather than arguing that it should match the 
> name
> of the internal state I think you should either argue that when read 
> you
> get "disabled" back or that "disabled" would make it consistent with 
> the
> recovery.

Sure, I'll re-word the commit message.
I probably choose the read back argument
because that's what was odd about it in
the first place.

> 
> Regards,
> Bjorn
> 
>> Fixes: 3afdc59e43904 ("remoteproc: Add coredump debugfs entry")
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  drivers/remoteproc/remoteproc_debugfs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/remoteproc/remoteproc_debugfs.c 
>> b/drivers/remoteproc/remoteproc_debugfs.c
>> index 2e3b3e22e1d01..7ca823f6aa638 100644
>> --- a/drivers/remoteproc/remoteproc_debugfs.c
>> +++ b/drivers/remoteproc/remoteproc_debugfs.c
>> @@ -94,7 +94,7 @@ static ssize_t rproc_coredump_write(struct file 
>> *filp,
>>  		goto out;
>>  	}
>> 
>> -	if (!strncmp(buf, "disable", count)) {
>> +	if (!strncmp(buf, "disabled", count)) {
>>  		rproc->dump_conf = RPROC_COREDUMP_DISABLED;
>>  	} else if (!strncmp(buf, "inline", count)) {
>>  		rproc->dump_conf = RPROC_COREDUMP_INLINE;
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
