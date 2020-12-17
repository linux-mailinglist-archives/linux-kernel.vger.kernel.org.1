Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02242DCC1E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 06:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgLQFjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 00:39:18 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:10149 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgLQFjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 00:39:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608183533; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=fx7Tz/nVdMvLtLJw7sh1i68g+xg7p/d9LVklZVoMisY=; b=nEDJPARiPzhQ7NWaEY9a7jwafD5GNpCCnPcthWjVVleY871ex0K/ihVEVESr/xcgTGKY/hao
 bCGX3cIHynyxLAAnFYNZeo21FfdM1FBPrVIqnbAswuR0ZqVgimU4flGHYrfIqahZNVkG7cVQ
 1Lgalgh5HEhvo9l7lKQ3zrtOLzM=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fdaeecb0564dfefcdaf0d76 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Dec 2020 05:38:19
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6D262C433C6; Thu, 17 Dec 2020 05:38:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.105] (unknown [182.18.191.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B310C433CA;
        Thu, 17 Dec 2020 05:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B310C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v3] lib: stackdepot: Add support to configure
 STACK_HASH_SIZE
To:     Alexander Potapenko <glider@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        dan.j.williams@intel.com, broonie@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>, qcai@redhat.com,
        ylal@codeaurora.org, vinmenon@codeaurora.org
References: <1607576401-25609-1-git-send-email-vjitta@codeaurora.org>
 <CAG_fn=VKsrYx+YOGPnZw_Q5t6Fx7B59FSUuphj7Ou+DDFKQ+8Q@mail.gmail.com>
 <77e98f0b-c9c3-9380-9a57-ff1cd4022502@codeaurora.org>
 <CAG_fn=WbN6unD3ASkLUcEmZvALOj=dvC0yp6CcJFkV+3mmhwxw@mail.gmail.com>
 <6cc89f7b-bf40-2fd3-96ce-2a02d7535c91@codeaurora.org>
 <CAG_fn=VOHag5AUwFbOj_cV+7RDAk8UnjjqEtv2xmkSDb_iTYcQ@mail.gmail.com>
 <255400db-67d5-7f42-8dcb-9a440e006b9d@codeaurora.org>
 <f901afa5-7c46-ceba-2ae9-6186afdd99c0@codeaurora.org>
 <CAG_fn=UjJQP_gfDm3eJTPY371QTwyDJKXBCN2gs4DvnLP2pbyQ@mail.gmail.com>
 <7f2e171f-fa44-ef96-6cc6-14e615e3e457@codeaurora.org>
 <CAG_fn=VihkHLx7nHRrzQRuHeL-UYRezcyGLDQMJY+d1O5AkJfA@mail.gmail.com>
 <601d4b1a-8526-f7ad-d0f3-305894682109@codeaurora.org>
 <CAG_fn=V8e8y1fbOaYUD5SfDSQ9+Tc3r7w6ZSoJ-ZNFJvvq-Aeg@mail.gmail.com>
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <9e0d2c07-af1f-a1d3-fb0d-dbf2ae669f96@codeaurora.org>
Date:   Thu, 17 Dec 2020 11:08:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAG_fn=V8e8y1fbOaYUD5SfDSQ9+Tc3r7w6ZSoJ-ZNFJvvq-Aeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/2020 7:04 PM, Alexander Potapenko wrote:
>>> To reiterate, I think you don't need a tunable stack_hash_order
>>> parameter if the only use case is to disable the stack depot.
>>> Maybe it is enough to just add a boolean flag?
>>
>> There are multiple users of stackdepot they might still want to use
>> stack depot but with a lower memory footprint instead of MAX_SIZE
>> so, a configurable size might help here ?
> 
> Can you provide an example of a use case in which the user wants to
> use the stack depot of a smaller size without disabling it completely,
> and that size cannot be configured statically?
> As far as I understand, for the page owner example you gave it's
> sufficient to provide a switch that can disable the stack depot if
> page_owner=off.
> 
There are two use cases here,

1. We don't want to consume memory when page_owner=off ,boolean flag
would work here.

2. We would want to enable page_owner on low ram devices but we don't
want stack depot to consume 8 MB of memory, so for this case we would
need a configurable stack_hash_size so that we can still use page_owner
with lower memory consumption.

So, a configurable stack_hash_size would work for both these use cases,
we can set it to '0' for first case and set the required size for the
second case.

>>> Or even go further and disable the stack depot in the same place that
>>> disables page owner, as the user probably doesn't want to set two
>>> flags instead of one?
>>>
>>
>> Since, page owner is not the only user of stack depot we can't take that
>> decision of disabling stack depot if page owner is disabled.
> 
> Agreed, but if multiple subsystems want to use stackdepot together, it
> is even harder to estimate the total memory consumption.
> How likely is it that none of them will need MAX_SIZE?
> 
>>>> Minchan,
>>>> This should be fine right ? Do you see any issue with disabling
>>>> stack depot completely ?
>>>>
>>>> Thanks,
>>>> Vijay
>>>>
>>>>>> Thanks,
>>>>>> Vijay
>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Vijay
>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>> Vijay
>>>>>>>>>>>
>>>>>>>>>>> --
>>>>>>>>>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
>>>>>>>>>>> member of Code Aurora Forum, hosted by The Linux Foundation
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
>>>>>>>>> member of Code Aurora Forum, hosted by The Linux Foundation
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>> --
>>>>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
>>>>>> member of Code Aurora Forum, hosted by The Linux Foundation
>>>>>
>>>>>
>>>>>
>>>>
>>>> --
>>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
>>>> member of Code Aurora Forum, hosted by The Linux Foundation
>>>
>>>
>>>
>>
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
>> member of Code Aurora Forum, hosted by The Linux Foundation
> 
> 
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
