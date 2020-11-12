Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71CD2B0541
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 13:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgKLM4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 07:56:52 -0500
Received: from z5.mailgun.us ([104.130.96.5]:57704 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLM4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 07:56:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605185811; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=YGbiqQVX0zn5ulohah4Bb/Xz8yjVkbbJmLwpnFLalJE=; b=O7+njpy5fkPwU4k3Xa1US9K/nfV7pX8KWVZ6oyy01xtdodKJx/qzMorPXfPVxj7K0376bzsj
 t+XudiqRQBdlg2C7uGXPxux4HANFe33X+E0psTKWShrTq7RuVtmix8p3rVm3wfXrbyrL9bzf
 iA84nYtqcp6A0cWhfoyUMK748KM=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5fad310c25da3a0fa9e83c72 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 12 Nov 2020 12:56:44
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A0918C433C8; Thu, 12 Nov 2020 12:56:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.104] (unknown [182.18.191.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 81A28C433C8;
        Thu, 12 Nov 2020 12:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 81A28C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH] lib: stackdepot: Add support to configure STACK_HASH_SIZE
From:   Vijayanand Jitta <vjitta@codeaurora.org>
To:     Minchan Kim <minchan@kernel.org>, linux-mm <linux-mm@kvack.org>
Cc:     glider@google.com, Dan Williams <dan.j.williams@intel.com>,
        broonie@kernel.org, mhiramat@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yogesh Lal <ylal@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>
References: <1603372546-27118-1-git-send-email-vjitta@codeaurora.org>
 <CAEwNFnBvxu7+oNkcO9D70OFrxQXswcJG4OvDPyzNf7kpXfpSuw@mail.gmail.com>
 <282d7028-498d-50b3-37d4-2381571f9f9e@codeaurora.org>
Message-ID: <ed4a1e75-3e3a-4950-7bb5-3d83db7bf054@codeaurora.org>
Date:   Thu, 12 Nov 2020 18:26:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <282d7028-498d-50b3-37d4-2381571f9f9e@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/2020 3:59 PM, Vijayanand Jitta wrote:
> 
> 
> On 11/4/2020 4:57 AM, Minchan Kim wrote:
>> Sorry if this mail corrupts the mail thread or had heavy mangling
>> since I lost this mail from my mailbox so I am sending this mail by
>> web gmail.
>>
>> On Thu, Oct 22, 2020 at 10:18 AM <vjitta@codeaurora.org> wrote:
>>>
>>> From: Yogesh Lal <ylal@codeaurora.org>
>>>
>>> Use STACK_HASH_ORDER_SHIFT to configure STACK_HASH_SIZE.
>>>
>>> Aim is to have configurable value for  STACK_HASH_SIZE,
>>> so depend on use case one can configure it.
>>>
>>> One example is of Page Owner, default value of
>>> STACK_HASH_SIZE lead stack depot to consume 8MB of static memory.
>>> Making it configurable and use lower value helps to enable features like
>>> CONFIG_PAGE_OWNER without any significant overhead.
>>>
>>> Signed-off-by: Yogesh Lal <ylal@codeaurora.org>
>>> Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
>>> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
>>> ---
>>>  lib/Kconfig      | 9 +++++++++
>>>  lib/stackdepot.c | 3 +--
>>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/lib/Kconfig b/lib/Kconfig
>>> index 18d76b6..b3f8259 100644
>>> --- a/lib/Kconfig
>>> +++ b/lib/Kconfig
>>> @@ -651,6 +651,15 @@ config STACKDEPOT
>>>         bool
>>>         select STACKTRACE
>>>
>>> +config STACK_HASH_ORDER_SHIFT
>>> +       int "stack depot hash size (12 => 4KB, 20 => 1024KB)"
>>> +       range 12 20
>>> +       default 20
>>> +       depends on STACKDEPOT
>>> +       help
>>> +        Select the hash size as a power of 2 for the stackdepot hash table.
>>> +        Choose a lower value to reduce the memory impact.
>>> +
>>>  config SBITMAP
>>>         bool
>>>
>>> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
>>> index 2caffc6..413c20b 100644
>>> --- a/lib/stackdepot.c
>>> +++ b/lib/stackdepot.c
>>> @@ -142,8 +142,7 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
>>>         return stack;
>>>  }
>>>
>>> -#define STACK_HASH_ORDER 20
>>> -#define STACK_HASH_SIZE (1L << STACK_HASH_ORDER)
>>> +#define STACK_HASH_SIZE (1L << CONFIG_STACK_HASH_ORDER_SHIFT)
>>>  #define STACK_HASH_MASK (STACK_HASH_SIZE - 1)
>>>  #define STACK_HASH_SEED 0x9747b28c
>>>
>>> --
>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>>> 2.7.4
>>>
>>
>> 1. When we don't use page_owner, we don't want to waste any memory for
>> stackdepot hash array.
>> 2. When we use page_owner, we want to have reasonable stackdeport hash array
>>
>> With this configuration, it couldn't meet since we always need to
>> reserve a reasonable size for the array.
>> Can't we make the hash size as a kernel parameter?
>> With it, we could use it like this.
>>
>> 1. page_owner=off, stackdepot_stack_hash=0 -> no more wasted memory
>> when we don't use page_owner
>> 2. page_owner=on, stackdepot_stack_hash=8M -> reasonable hash size
>> when we use page_owner.
>>
>>
> 
> This idea looks fine to me. Andrew and others would like to hear your
> comments as well on this before implementing.
> 
> Thanks,
> Vijay
> 

Awaiting for comments from Andrew and others.

Thanks,
Vijay
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
