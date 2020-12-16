Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D204E2DC0C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgLPNHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:07:45 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:48342 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPNHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:07:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608124043; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=6JgvWp7ZVD21CpZKxCnVB4KpwQZh1UoqqLy0S7CrRg8=; b=g2fPoHSxrrk1y00uBu1ogIHk5HwEsxSa+Ki/BV5W9QMh5xiolGMILcZpdwF/xSAP7/HvHVJe
 fAatFVvYhs9OlCFbIL+mLJ+cm5FPitPsSE1UQ+NfDaolU6vG0VIcGCh32zBDdlKb7V6Og627
 ZqJFQwCClJPa0QEBXZBdMoXnDN4=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fda0669bfd08afb0d3fbe30 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Dec 2020 13:06:49
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1D5A1C43467; Wed, 16 Dec 2020 13:06:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.105] (unknown [182.18.191.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A32C4C433CA;
        Wed, 16 Dec 2020 13:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A32C4C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v3] lib: stackdepot: Add support to configure
 STACK_HASH_SIZE
To:     Alexander Potapenko <glider@google.com>,
        Minchan Kim <minchan@kernel.org>
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
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <7f2e171f-fa44-ef96-6cc6-14e615e3e457@codeaurora.org>
Date:   Wed, 16 Dec 2020 18:36:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAG_fn=UjJQP_gfDm3eJTPY371QTwyDJKXBCN2gs4DvnLP2pbyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/2020 1:56 PM, Alexander Potapenko wrote:
> On Wed, Dec 16, 2020 at 4:43 AM Vijayanand Jitta <vjitta@codeaurora.org> wrote:
>>
>>
>>
>> On 12/14/2020 4:02 PM, Vijayanand Jitta wrote:
>>>
>>>
>>> On 12/14/2020 3:04 PM, Alexander Potapenko wrote:
>>>> On Mon, Dec 14, 2020 at 5:02 AM Vijayanand Jitta <vjitta@codeaurora.org> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 12/11/2020 6:55 PM, Alexander Potapenko wrote:
>>>>>> On Fri, Dec 11, 2020 at 1:45 PM Vijayanand Jitta <vjitta@codeaurora.org> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 12/11/2020 2:06 PM, Alexander Potapenko wrote:
>>>>>>>> On Thu, Dec 10, 2020 at 6:01 AM <vjitta@codeaurora.org> wrote:
>>>>>>>>>
>>>>>>>>> From: Yogesh Lal <ylal@codeaurora.org>
>>>>>>>>>
>>>>>>>>> Add a kernel parameter stack_hash_order to configure STACK_HASH_SIZE.
>>>>>>>>>
>>>>>>>>> Aim is to have configurable value for STACK_HASH_SIZE, so that one
>>>>>>>>> can configure it depending on usecase there by reducing the static
>>>>>>>>> memory overhead.
>>>>>>>>>
>>>>>>>>> One example is of Page Owner, default value of STACK_HASH_SIZE lead
>>>>>>>>> stack depot to consume 8MB of static memory. Making it configurable
>>>>>>>>> and use lower value helps to enable features like CONFIG_PAGE_OWNER
>>>>>>>>> without any significant overhead.
>>>>>>>>
>>>>>>>> Can we go with a static CONFIG_ parameter instead?
>>>>>>>> Guess most users won't bother changing the default anyway, and for
>>>>>>>> CONFIG_PAGE_OWNER users changing the size at boot time is not strictly
>>>>>>>> needed.
>>>>>>>>
>>>>>>> Thanks for review.
>>>>>>>
>>>>>>> One advantage of having run time parameter is we can simply set it to a
>>>>>>> lower value at runtime if page_owner=off thereby reducing the memory
>>>>>>> usage or use default value if we want to use page owner so, we have some
>>>>>>> some flexibility here. This is not possible with static parameter as we
>>>>>>> have to have some predefined value.
>>>>>>
>>>>>> If we are talking about a configuration in which page_owner is the
>>>>>> only stackdepot user in the system, then for page_owner=off it
>>>>>> probably makes more sense to disable stackdepot completely instead of
>>>>>> setting it to a lower value. This is a lot easier to do in terms of
>>>>>> correctness.
>>>>>> But if there are other users (e.g. KASAN), their stackdepot usage may
>>>>>> actually dominate that of page_owner.
>>>>>>
>>>>>>>>> -static struct stack_record *stack_table[STACK_HASH_SIZE] = {
>>>>>>>>> -       [0 ...  STACK_HASH_SIZE - 1] = NULL
>>>>>>>>> +static unsigned int stack_hash_order = 20;
>>>>>>>>
>>>>>>>> Please initialize with MAX_STACK_HASH_ORDER instead.
>>>>>>>>
>>>>>>>
>>>>>>> Sure, will update this.
>>>>>>>
>>>>>>
>>>>>>
>>>>>>>>> +
>>>>>>>>> +static int __init init_stackdepot(void)
>>>>>>>>> +{
>>>>>>>>> +       size_t size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
>>>>>>>>> +
>>>>>>>>> +       stack_table = vmalloc(size);
>>>>>>>>> +       memcpy(stack_table, stack_table_def, size);
>>>>>>>>
>>>>>>>> Looks like you are assuming stack_table_def already contains some data
>>>>>>>> by this point.
>>>>>>>> But if STACK_HASH_SIZE shrinks this memcpy() above will just copy some
>>>>>>>> part of the table, whereas the rest will be lost.
>>>>>>>> We'll need to:
>>>>>>>> - either explicitly decide we can afford losing this data (no idea how
>>>>>>>> bad this can potentially be),
>>>>>>>> - or disallow storing anything prior to full stackdepot initialization
>>>>>>>> (then we don't need stack_table_def),
>>>>>>>> - or carefully move all entries to the first part of the table.
>>>>>>>>
>>>>>>>> Alex
>>>>>>>>
>>>>>>>
>>>>>>> The hash for stack_table_def is computed using the run time parameter
>>>>>>> stack_hash_order, though stack_table_def is a bigger array it will only
>>>>>>> use the entries that are with in the run time configured STACK_HASH_SIZE
>>>>>>> range. so, there will be no data loss during copy.
>>>>>>
>>>>>> Do we expect any data to be stored into stack_table_def before
>>>>>> setup_stack_hash_order() is called?
>>>>>> If the answer is no, then we could probably drop stack_table_def and
>>>>>> allocate the table right in setup_stack_hash_order()?
>>>>>>
>>>>>
>>>>> Yes, we do see an allocation from stack depot even before init is called
>>>>> from kasan, thats the reason for having stack_table_def.
>>>>> This is the issue reported due to that on v2, so i added stack_table_def.
>>>>> https://lkml.org/lkml/2020/12/3/839
>>>>
>>>> But at that point STACK_HASH_SIZE is still equal to 1L <<
>>>> MAX_STACK_HASH_ORDER, isn't it?
>>>> Then we still need to take care of the records that fit into the
>>>> bigger array, but not the smaller one.
>>>>
>>>
>>> At this point early_param is already called which sets stack_hash_order.
>>> So, STACK_HASH_SIZE will be set to this updated value and not
>>> MAX_STACK_HASH_SIZE.So, no additional entires in the bigger array.
>>>
>>> Thanks,
>>> Vijay
>>>
>>
>> Let me know if there are any other concerns.
> 
> I still think there are implicit assumptions that should at least be
> written down in the comments.

Sure, will add the comments.

> As far as I understand the code, here is what happens here:
> 
> 0. No stacks are recorded.
> 1. early_param is called to set stack_hash_order to a value
> potentially smaller than MAX_STACK_HASH_SIZE.
> 2. KASAN (or other users) records some stacks into stack_table_def
> (capped at new STACK_HASH_SIZE)
> 3. init_stackdepot() allocates a new stack_table and copies the
> contents of stack_table_def into it
> 4. Further stacks are recorded into the new stack_table
> 
> If this is how the things work, I agree we don't need to account for
> the part of stack_table_def past STACK_HASH_SIZE.
> Not allocating stack_table when setting stack_hash_order is probably
> also justified, as we don't have SLAB or vmalloc at that point.
> 

That's Right.

> But I am still curious if a runtime parameter that disables the
> stackdepot completely will solve your problem.
> Allocating a small amount of memory when you actually don't want to
> allocate any sounds suboptimal.
> 

I think disabling stack depot completely should be fine, we can make
STACK_HASH_SIZE as runtime parameter instead of stack_hash_order and set
stack_hash_size to 0 to disable stack depot completely.

Minchan,
This should be fine right ? Do you see any issue with disabling
stack depot completely ?

Thanks,
Vijay

>> Thanks,
>> Vijay
>>
>>>>> Thanks,
>>>>> Vijay
>>>>>
>>>>>>> Thanks,
>>>>>>> Vijay
>>>>>>>
>>>>>>> --
>>>>>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
>>>>>>> member of Code Aurora Forum, hosted by The Linux Foundation
>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>> --
>>>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
>>>>> member of Code Aurora Forum, hosted by The Linux Foundation
>>>>
>>>>
>>>>
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
