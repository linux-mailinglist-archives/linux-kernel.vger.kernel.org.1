Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE402D922A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 05:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438504AbgLNED3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 23:03:29 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:13756 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgLNED3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 23:03:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607918590; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=i22EcmyWH8Hp8CG7yrzbU/C02hjjP4ee80TirhMJZzA=; b=A3MTug6wmEnTNjz528YgBtbPJrlgIcml45BNBQB9iHfOCVaq5K8nAaSweTOVuYywP51dC1Dt
 K5AvSmwKt5NLnmEa7Vl9ciSkIN0i0ET6Ecl85EWe4ADGgdHEG6DIb9HrSAXD51lMqeOFBxFZ
 KSqba+y1lwZGwD9S3199mSMf5j8=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fd6e3e253d7c5ba600b988f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Dec 2020 04:02:42
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6695BC43462; Mon, 14 Dec 2020 04:02:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.105] (unknown [182.18.191.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E385CC433CA;
        Mon, 14 Dec 2020 04:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E385CC433CA
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
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <6cc89f7b-bf40-2fd3-96ce-2a02d7535c91@codeaurora.org>
Date:   Mon, 14 Dec 2020 09:32:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAG_fn=WbN6unD3ASkLUcEmZvALOj=dvC0yp6CcJFkV+3mmhwxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2020 6:55 PM, Alexander Potapenko wrote:
> On Fri, Dec 11, 2020 at 1:45 PM Vijayanand Jitta <vjitta@codeaurora.org> wrote:
>>
>>
>>
>> On 12/11/2020 2:06 PM, Alexander Potapenko wrote:
>>> On Thu, Dec 10, 2020 at 6:01 AM <vjitta@codeaurora.org> wrote:
>>>>
>>>> From: Yogesh Lal <ylal@codeaurora.org>
>>>>
>>>> Add a kernel parameter stack_hash_order to configure STACK_HASH_SIZE.
>>>>
>>>> Aim is to have configurable value for STACK_HASH_SIZE, so that one
>>>> can configure it depending on usecase there by reducing the static
>>>> memory overhead.
>>>>
>>>> One example is of Page Owner, default value of STACK_HASH_SIZE lead
>>>> stack depot to consume 8MB of static memory. Making it configurable
>>>> and use lower value helps to enable features like CONFIG_PAGE_OWNER
>>>> without any significant overhead.
>>>
>>> Can we go with a static CONFIG_ parameter instead?
>>> Guess most users won't bother changing the default anyway, and for
>>> CONFIG_PAGE_OWNER users changing the size at boot time is not strictly
>>> needed.
>>>
>> Thanks for review.
>>
>> One advantage of having run time parameter is we can simply set it to a
>> lower value at runtime if page_owner=off thereby reducing the memory
>> usage or use default value if we want to use page owner so, we have some
>> some flexibility here. This is not possible with static parameter as we
>> have to have some predefined value.
> 
> If we are talking about a configuration in which page_owner is the
> only stackdepot user in the system, then for page_owner=off it
> probably makes more sense to disable stackdepot completely instead of
> setting it to a lower value. This is a lot easier to do in terms of
> correctness.
> But if there are other users (e.g. KASAN), their stackdepot usage may
> actually dominate that of page_owner.
> 
>>>> -static struct stack_record *stack_table[STACK_HASH_SIZE] = {
>>>> -       [0 ...  STACK_HASH_SIZE - 1] = NULL
>>>> +static unsigned int stack_hash_order = 20;
>>>
>>> Please initialize with MAX_STACK_HASH_ORDER instead.
>>>
>>
>> Sure, will update this.
>>
> 
> 
>>>> +
>>>> +static int __init init_stackdepot(void)
>>>> +{
>>>> +       size_t size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
>>>> +
>>>> +       stack_table = vmalloc(size);
>>>> +       memcpy(stack_table, stack_table_def, size);
>>>
>>> Looks like you are assuming stack_table_def already contains some data
>>> by this point.
>>> But if STACK_HASH_SIZE shrinks this memcpy() above will just copy some
>>> part of the table, whereas the rest will be lost.
>>> We'll need to:
>>> - either explicitly decide we can afford losing this data (no idea how
>>> bad this can potentially be),
>>> - or disallow storing anything prior to full stackdepot initialization
>>> (then we don't need stack_table_def),
>>> - or carefully move all entries to the first part of the table.
>>>
>>> Alex
>>>
>>
>> The hash for stack_table_def is computed using the run time parameter
>> stack_hash_order, though stack_table_def is a bigger array it will only
>> use the entries that are with in the run time configured STACK_HASH_SIZE
>> range. so, there will be no data loss during copy.
> 
> Do we expect any data to be stored into stack_table_def before
> setup_stack_hash_order() is called?
> If the answer is no, then we could probably drop stack_table_def and
> allocate the table right in setup_stack_hash_order()?
> 

Yes, we do see an allocation from stack depot even before init is called
from kasan, thats the reason for having stack_table_def.
This is the issue reported due to that on v2, so i added stack_table_def.
https://lkml.org/lkml/2020/12/3/839

Thanks,
Vijay

>> Thanks,
>> Vijay
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
