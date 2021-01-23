Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2535C3016D4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 17:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbhAWQe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 11:34:56 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:24107 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbhAWQex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 11:34:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611419669; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=oT7MRBChsv+idL281B/pS9tqQFqOqOFuyvZzg95aFI0=; b=aWihURE5AzSoTItDlDMwbcb7U19tlCwah4lfXg0ZZIQUkIeS4/NabWbp0/gqoJ0PARV3XPRA
 Vl1Lm1LLsQd/cvsuxj0ZCdhK0a4aLHeGTcNgn6FP31d99QPgk+7IB+kXZP05Sl409aB06JR+
 42zwcp9EIhg/5XwrvKAoSHWzx9E=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 600c4ff6fb02735e8cf5561d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 23 Jan 2021 16:33:58
 GMT
Sender: gkohli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F1A0DC43461; Sat, 23 Jan 2021 16:33:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.4] (unknown [136.185.226.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC1ACC433ED;
        Sat, 23 Jan 2021 16:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC1ACC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH v1] trace: Fix race in trace_open and buffer resize call
To:     Denis Efremov <efremov@linux.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>
References: <1601976833-24377-1-git-send-email-gkohli@codeaurora.org>
 <f06efd7b-c7b5-85c9-1a0e-6bb865111ede@linux.com>
 <20210121140951.2a554a5e@gandalf.local.home>
 <021b1b38-47ce-bc8b-3867-99160cc85523@linux.com>
 <20210121153732.43d7b96b@gandalf.local.home> <YAqwD/ivTgVJ7aap@kroah.com>
 <8e17ad41-b62b-5d39-82ef-3ee6ea9f4278@codeaurora.org>
 <20210122093758.320bb4f9@gandalf.local.home>
 <5959315a-507a-00df-031a-e60d45c1f7ab@linux.com>
From:   Gaurav Kohli <gkohli@codeaurora.org>
Message-ID: <46d1f82b-1eb4-a828-c79c-e6556eccf9d5@codeaurora.org>
Date:   Sat, 23 Jan 2021 22:03:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <5959315a-507a-00df-031a-e60d45c1f7ab@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/2021 4:19 PM, Denis Efremov wrote:
> 
> 
> On 1/22/21 5:37 PM, Steven Rostedt wrote:
>> On Fri, 22 Jan 2021 16:55:29 +0530
>> Gaurav Kohli <gkohli@codeaurora.org> wrote:
>>
>>>>> That could possibly work.
>>>
>>> Yes, this will work, As i have tested similar patch for internal testing
>>> for kernel branches like 5.4/4.19.
>>
>> Can you or Denis send a proper patch for Greg to backport? I'll review it,
>> test it and give my ack to it, so Greg can take it without issue.
>>
> 
> I can prepare the patch, but it will be compile-tested only from my side. Honestly,
> I think it's better when the patch and its backports have the same author and
> commit message. And I can't test the fix by myself as I don't know how to reproduce
> conditions for the bug. I think it's better if Gaurav will prepare this backport,
> unless he have reasons for me to do it or maybe just don't have enough time nowadays.
> Gaurav, if you want to somehow mention me you add my Reported-by:
> 
> Thanks,
> Denis
> 

Sure I will do, I have never posted on backport branches. Let me check 
and post it.

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
