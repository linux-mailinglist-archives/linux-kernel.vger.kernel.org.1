Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E5F2E05DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 06:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgLVF44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 00:56:56 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:57089 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLVF4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 00:56:55 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608616589; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=1thyFUC//ehpP0yAbCIk5YNRG3RLSn2U56velYq8ZPo=; b=KUmSVqEDY7mOqAt2hkfFknAL8nu36JXLtzL4oqzVNdEnBEv0qX/YlJO1/agSSwvKDCq8OSVU
 Ckj0wHdjATPHgB0qwiz9g2cxGJ5URpiKzVTK2iHDFbJx9g4LWwEtUGOexpfhQQH9Db8PxhOu
 thQ4xZkNVCzVJxAth6WfOcoiv3k=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fe18a65b00c0d7ad48cc43f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Dec 2020 05:55:49
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7ACDDC43466; Tue, 22 Dec 2020 05:55:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [192.168.43.216] (unknown [106.76.209.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A59FC433CA;
        Tue, 22 Dec 2020 05:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A59FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v3] lib: stackdepot: Add support to configure
 STACK_HASH_SIZE
To:     Minchan Kim <minchan@kernel.org>,
        Alexander Potapenko <glider@google.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        dan.j.williams@intel.com, broonie@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>, qcai@redhat.com,
        ylal@codeaurora.org, vinmenon@codeaurora.org,
        kasan-dev <kasan-dev@googlegroups.com>
References: <CAG_fn=UjJQP_gfDm3eJTPY371QTwyDJKXBCN2gs4DvnLP2pbyQ@mail.gmail.com>
 <7f2e171f-fa44-ef96-6cc6-14e615e3e457@codeaurora.org>
 <CAG_fn=VihkHLx7nHRrzQRuHeL-UYRezcyGLDQMJY+d1O5AkJfA@mail.gmail.com>
 <601d4b1a-8526-f7ad-d0f3-305894682109@codeaurora.org>
 <CAG_fn=V8e8y1fbOaYUD5SfDSQ9+Tc3r7w6ZSoJ-ZNFJvvq-Aeg@mail.gmail.com>
 <9e0d2c07-af1f-a1d3-fb0d-dbf2ae669f96@codeaurora.org>
 <CAG_fn=UXQUGiDqmChqD-xX-yF5Jp+7K+oHwKPrO9DZL-zW_4KQ@mail.gmail.com>
 <48df48fe-dc36-83a4-1c11-e9d0cf230372@codeaurora.org>
 <6110a26b-dc87-b6f9-e679-aa60917403de@codeaurora.org>
 <CAG_fn=VjejHtY8=cuuFkixpXd6A6q1C==6RAaUC3Vb5_4hZkcg@mail.gmail.com>
 <X+EFmQz6JKfpdswG@google.com>
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <d769a7b1-89a2-aabe-f274-db132f7229d1@codeaurora.org>
Date:   Tue, 22 Dec 2020 11:25:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <X+EFmQz6JKfpdswG@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/22/2020 1:59 AM, Minchan Kim wrote:
> On Mon, Dec 21, 2020 at 04:04:09PM +0100, Alexander Potapenko wrote:
>> On Mon, Dec 21, 2020 at 12:15 PM Vijayanand Jitta <vjitta@codeaurora.org> wrote:
>>>
>>>
>>>
>>> On 12/18/2020 2:10 PM, Vijayanand Jitta wrote:
>>>>
>>>>
>>>> On 12/17/2020 4:24 PM, Alexander Potapenko wrote:
>>>>>>> Can you provide an example of a use case in which the user wants to
>>>>>>> use the stack depot of a smaller size without disabling it completely,
>>>>>>> and that size cannot be configured statically?
>>>>>>> As far as I understand, for the page owner example you gave it's
>>>>>>> sufficient to provide a switch that can disable the stack depot if
>>>>>>> page_owner=off.
>>>>>>>
>>>>>> There are two use cases here,
>>>>>>
>>>>>> 1. We don't want to consume memory when page_owner=off ,boolean flag
>>>>>> would work here.
>>>>>>
>>>>>> 2. We would want to enable page_owner on low ram devices but we don't
>>>>>> want stack depot to consume 8 MB of memory, so for this case we would
>>>>>> need a configurable stack_hash_size so that we can still use page_owner
>>>>>> with lower memory consumption.
>>>>>>
>>>>>> So, a configurable stack_hash_size would work for both these use cases,
>>>>>> we can set it to '0' for first case and set the required size for the
>>>>>> second case.
>>>>>
>>>>> Will a combined solution with a boolean boot-time flag and a static
>>>>> CONFIG_STACKDEPOT_HASH_SIZE work for these cases?
>>>>> I suppose low-memory devices have a separate kernel config anyway?
>>>>>
>>>>
>>>> Yes, the combined solution will also work but i think having a single
>>>> run time config is simpler instead of having two things to configure.
>>>>
>>>
>>> To add to it we started of with a CONFIG first, after the comments from
>>> Minchan (https://lkml.org/lkml/2020/11/3/2121) we decided to switch to
>>> run time param.
>>>
>>> Quoting Minchan's comments below:
>>>
>>> "
>>> 1. When we don't use page_owner, we don't want to waste any memory for
>>> stackdepot hash array.
>>> 2. When we use page_owner, we want to have reasonable stackdeport hash array
>>>
>>> With this configuration, it couldn't meet since we always need to
>>> reserve a reasonable size for the array.
>>> Can't we make the hash size as a kernel parameter?
>>> With it, we could use it like this.
>>>
>>> 1. page_owner=off, stackdepot_stack_hash=0 -> no more wasted memory
>>> when we don't use page_owner
>>> 2. page_owner=on, stackdepot_stack_hash=8M -> reasonable hash size
>>> when we use page_owner.
>>> "
>>
>> Minchan, what do you think about making the hash size itself a static
>> parameter, while letting the user disable stackdepot completely at
>> runtime?
>> As noted before, I am concerned that moving a low-level configuration
>> bit (which essentially means "save 8Mb - (1 << stackdepot_stack_hash)
>> of static memory") to the boot parameters will be unused by most
>> admins and may actually trick them into thinking they reduce the
>> overall stackdepot memory consumption noticeably.
>> I also suppose device vendors may prefer setting a fixed (maybe
>> non-default) hash size for low-memory devices rather than letting the
>> admins increase it.
> 
> I am totally fine if we could save the static memory alloation when
> the page_owner is not used.
> 
> IOW, page_owner=disable, stackdepot=disable will not consume the 8M
> memory.
> When we want to use page_owner, we could just do like this
> 
> 	page_owner=enable, stackdepot=enable
> 
> (Maybe we need something to make warning if stackdepot is disabled
> but someone want to use it, for example, KASAN?)
> 
> Vijayanand, If we could work this this, should we still need the
> config option, then? 
> 

Michan, We would still need config option so that we can reduce the
memory consumption on low ram devices using config.

Alex, On this,
"I also suppose device vendors may prefer setting a fixed (maybe
non-default) hash size for low-memory devices rather than letting the
admins increase it."
I see kernel param swiotlb does similar thing i.e; '0' to disable and
set a value to configure size.

I am fine with either of the approaches,

1. I can split this patch into two
   i)  A bool variable to enable/disable stack depot.
   ii) A config for the size.

(or)

2. A run time param - '0' to disable and set a valid size to enable.

Let me know your comments.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
