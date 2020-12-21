Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF342DFB6F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 12:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgLULPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 06:15:53 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:40393 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLULPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 06:15:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608549328; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=Y4CbVjRa9PKJTQWOMPwKVt5xzYyrbkTeQUsDXoEzPFU=; b=A9dIibCSRmXbMy3MFKt3q6kVEUwOV3RWsLj4RmRGrm+yDP1rUcVRLokMjKbm3Xt62W3MssJ/
 1YKpOZm4A3F4U2qXqzeViOeSvtN8gEmv/uQ4aaLa/B6/5tAVbz2riSbfXC5fuTT7H0zPVTU6
 1S4Vh+nwSYJQ65eQrxO7pUk45GY=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5fe083ab7549779c5b126d5e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Dec 2020 11:14:51
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3680EC433ED; Mon, 21 Dec 2020 11:14:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [192.168.0.100] (unknown [182.18.191.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D2058C433C6;
        Mon, 21 Dec 2020 11:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2058C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v3] lib: stackdepot: Add support to configure
 STACK_HASH_SIZE
From:   Vijayanand Jitta <vjitta@codeaurora.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        dan.j.williams@intel.com, broonie@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>, qcai@redhat.com,
        ylal@codeaurora.org, vinmenon@codeaurora.org,
        kasan-dev <kasan-dev@googlegroups.com>
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
 <9e0d2c07-af1f-a1d3-fb0d-dbf2ae669f96@codeaurora.org>
 <CAG_fn=UXQUGiDqmChqD-xX-yF5Jp+7K+oHwKPrO9DZL-zW_4KQ@mail.gmail.com>
 <48df48fe-dc36-83a4-1c11-e9d0cf230372@codeaurora.org>
Message-ID: <6110a26b-dc87-b6f9-e679-aa60917403de@codeaurora.org>
Date:   Mon, 21 Dec 2020 16:44:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <48df48fe-dc36-83a4-1c11-e9d0cf230372@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/18/2020 2:10 PM, Vijayanand Jitta wrote:
> 
> 
> On 12/17/2020 4:24 PM, Alexander Potapenko wrote:
>>>> Can you provide an example of a use case in which the user wants to
>>>> use the stack depot of a smaller size without disabling it completely,
>>>> and that size cannot be configured statically?
>>>> As far as I understand, for the page owner example you gave it's
>>>> sufficient to provide a switch that can disable the stack depot if
>>>> page_owner=off.
>>>>
>>> There are two use cases here,
>>>
>>> 1. We don't want to consume memory when page_owner=off ,boolean flag
>>> would work here.
>>>
>>> 2. We would want to enable page_owner on low ram devices but we don't
>>> want stack depot to consume 8 MB of memory, so for this case we would
>>> need a configurable stack_hash_size so that we can still use page_owner
>>> with lower memory consumption.
>>>
>>> So, a configurable stack_hash_size would work for both these use cases,
>>> we can set it to '0' for first case and set the required size for the
>>> second case.
>>
>> Will a combined solution with a boolean boot-time flag and a static
>> CONFIG_STACKDEPOT_HASH_SIZE work for these cases?
>> I suppose low-memory devices have a separate kernel config anyway?
>>
> 
> Yes, the combined solution will also work but i think having a single
> run time config is simpler instead of having two things to configure.
> 

To add to it we started of with a CONFIG first, after the comments from
Minchan (https://lkml.org/lkml/2020/11/3/2121) we decided to switch to
run time param.

Quoting Minchan's comments below:

"
1. When we don't use page_owner, we don't want to waste any memory for
stackdepot hash array.
2. When we use page_owner, we want to have reasonable stackdeport hash array

With this configuration, it couldn't meet since we always need to
reserve a reasonable size for the array.
Can't we make the hash size as a kernel parameter?
With it, we could use it like this.

1. page_owner=off, stackdepot_stack_hash=0 -> no more wasted memory
when we don't use page_owner
2. page_owner=on, stackdepot_stack_hash=8M -> reasonable hash size
when we use page_owner.
"

Thanks,
Vijay
>> My concern is that exposing yet another knob to users won't really
>> solve their problems, because the hash size alone doesn't give enough
>> control over stackdepot memory footprint (we also have stack_slabs,
>> which may get way bigger than 8Mb).
>>
> 
> True, stack_slabs can consume more memory but they consume most only
> when stack depot is used as they are allocated in stack_depot_save path.
> when stack depot is not used they consume 8192 * sizeof(void) bytes at
> max. So nothing much we can do here since static allocation is not much
> and memory consumption depends up on stack depot usage, unlike
> stack_hash_table where 8mb is preallocated.
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
