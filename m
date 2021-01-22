Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C532FFB8D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 05:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbhAVEEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 23:04:20 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:17072 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbhAVEDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 23:03:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611288191; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=lYiG4Vq3amaV9qOUs9f8gykH1QLqDSir3sXlu0FfLdU=; b=kmqepppt8ywDpEXr8JM2+81VjjzVEo/TkNccNFrHmqjQ8DhUX4nMEMWHSyyLIrXYXPo/siBI
 GZacJwRtYkrqWeyWVYsI+tl8IRg/JuHKNiWNCYc94idb3m21QGglwF4d7XsmMHdZnzbX//gM
 8L+8Rzcm3gjGdQs+U6uwKlZEhzI=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 600a4e7c5677aca7bdec23a2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 Jan 2021 04:03:08
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6F4A0C43461; Fri, 22 Jan 2021 04:03:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.106] (unknown [182.18.191.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9E38DC433CA;
        Fri, 22 Jan 2021 04:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E38DC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v5 2/2] lib: stackdepot: Add support to disable stack
 depot
To:     Minchan Kim <minchan@kernel.org>
Cc:     glider@google.com, akpm@linux-foundation.org,
        dan.j.williams@intel.com, broonie@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, ylal@codeaurora.org,
        vinmenon@codeaurora.org
References: <1610963802-11042-1-git-send-email-vjitta@codeaurora.org>
 <1610963802-11042-2-git-send-email-vjitta@codeaurora.org>
 <YAobhDFEJKa26OwH@google.com>
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <45c640f3-9a38-8ed1-634a-8561c34a4a17@codeaurora.org>
Date:   Fri, 22 Jan 2021 09:33:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAobhDFEJKa26OwH@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/22/2021 5:55 AM, Minchan Kim wrote:
> On Mon, Jan 18, 2021 at 03:26:42PM +0530, vjitta@codeaurora.org wrote:
>> From: Vijayanand Jitta <vjitta@codeaurora.org>
>>
>> Add a kernel parameter stack_depot_disable to disable
>> stack depot. So that stack hash table doesn't consume
>> any memory when stack depot is disabled.
> 
> The usecase is CONFIG_PAGE_OWNER without page_owner=on.
> Without this patch, stackdepot will consume the memory
> for the hashtable. By default, it's 8M which is never trivial.
> 
> With this option, in CONFIG_PAGE_OWNER configured system,
> page_owner=off, stack_depot_disable in kernel command line,
> we could save the wasted memory for the hashtable.
> 

Sure, will update the commit text with above details.
>>
>> Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
>> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
> 
> Please also update kernel-parameters.txt.
> 

Sure.
>> ---
>>  include/linux/stackdepot.h |  1 +
>>  init/main.c                |  2 ++
>>  lib/stackdepot.c           | 33 +++++++++++++++++++++++++++++----
>>  3 files changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
>> index 24d49c7..eafd9aa 100644
>> --- a/include/linux/stackdepot.h
>> +++ b/include/linux/stackdepot.h
>> @@ -21,4 +21,5 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>>  
>>  unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_entries);
>>  
>> +int stack_depot_init(void);
>>  #endif
>> diff --git a/init/main.c b/init/main.c
>> index 32b2a8a..8fcf9bb 100644
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -98,6 +98,7 @@
>>  #include <linux/mem_encrypt.h>
>>  #include <linux/kcsan.h>
>>  #include <linux/init_syscalls.h>
>> +#include <linux/stackdepot.h>
>>  
>>  #include <asm/io.h>
>>  #include <asm/bugs.h>
>> @@ -827,6 +828,7 @@ static void __init mm_init(void)
>>  	page_ext_init_flatmem();
>>  	init_debug_pagealloc();
>>  	report_meminit();
>> +	stack_depot_init();
>>  	mem_init();
>>  	kmem_cache_init();
>>  	kmemleak_init();
>> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
>> index dff8521..d20e6fd 100644
>> --- a/lib/stackdepot.c
>> +++ b/lib/stackdepot.c
>> @@ -31,6 +31,8 @@
>>  #include <linux/stackdepot.h>
>>  #include <linux/string.h>
>>  #include <linux/types.h>
>> +#include <linux/vmalloc.h>
> 
> Why do we need vmalloc?
> 

Its not needed, will remove it.

> Otherwise, looks good to me.
> Thank you!
> 

Thanks for the review.

Thanks,
Vijay
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
