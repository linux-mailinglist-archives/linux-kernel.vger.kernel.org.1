Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884832FAF5C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 05:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbhASEMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 23:12:31 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:40866 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbhASEJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 23:09:28 -0500
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jan 2021 23:09:28 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611029345; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=hqSaBJC25YzefV/w05jd1KbxgKk1Mst3ZpX3NfFPPZo=; b=X37eaPAH/Sb651mrGrOFvgbNfp+nVH/MzVWzmsgxKdzLXpH0FM1Nj0QQJYyBJPHs7DG7xHtb
 oW4WZ+uzfqpAptGM3wGZ0e3/8fLoj71MtfR0dhhzsxShWzzF7Gwue1IYNAm/+vrpSVsLedXk
 WpidGhjS+pVAonpeJ58GYj1jKI8=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 600659dc1e3bf9b669a40135 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 19 Jan 2021 04:02:36
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 34EBBC43461; Tue, 19 Jan 2021 04:02:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.106] (unknown [182.18.191.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E53EAC433C6;
        Tue, 19 Jan 2021 04:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E53EAC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v4 1/2] lib: stackdepot: Add support to configure
 STACK_HASH_SIZE
From:   Vijayanand Jitta <vjitta@codeaurora.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     minchan@kernel.org, glider@google.com, dan.j.williams@intel.com,
        broonie@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, ylal@codeaurora.org,
        vinmenon@codeaurora.org, Thomas Gleixner <tglx@linutronix.de>
References: <1609332331-2456-1-git-send-email-vjitta@codeaurora.org>
 <20210104151223.34f97a033e966c9cc89915cb@linux-foundation.org>
 <50635706-e3b0-20da-a053-facb1430b1d1@codeaurora.org>
Message-ID: <f97ae1cd-974d-f8bc-9fe4-c1d11464ac12@codeaurora.org>
Date:   Tue, 19 Jan 2021 09:32:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <50635706-e3b0-20da-a053-facb1430b1d1@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/2021 2:54 PM, Vijayanand Jitta wrote:
> 
> 
> On 1/5/2021 4:42 AM, Andrew Morton wrote:
>> On Wed, 30 Dec 2020 18:15:30 +0530 vjitta@codeaurora.org wrote:
>>
>>> Use STACK_HASH_ORDER_SHIFT to configure STACK_HASH_SIZE.
>>>
>>> Aim is to have configurable value for  STACK_HASH_SIZE,
>>> so depend on use case one can configure it.
>>>
>>> One example is of Page Owner, default value of
>>> STACK_HASH_SIZE lead stack depot to consume 8MB of static memory.
>>> Making it configurable and use lower value helps to enable features like
>>> CONFIG_PAGE_OWNER without any significant overhead.
>>
>> Questions regarding the stackdepot code.
>>
>> - stack_table_tmp[] is __initdata.  So after initmem is released,
>>   that "consume 8MB of static memory" should no longer be true.  But
>>   iirc, not all architectures actually release __initdata memory.  Does
>>   your architecture do this?
>>
> Thanks for review comments, I wasn't aware that __initdata is
> architecture dependent, I was assuming that __initdata always frees
> memory and yes the architecture which i am using (arm64) does free
> __inidata.
> 
>> - Stackdepot copies stack_table_tmp[] into vmalloced memory during
>>   initcalls.  Why?  Why not simply make stack_table_tmp[] no longer
>>   __initdata and use that memory for all time?
>>
>>   Presumably because in the stack_depot_disable==true case, we
>>   release stack_table_tmp[] memory, don't vmalloc for a copy of it, and
>>   save a bunch of memory?  If so, this assumes that the __initdata
>>   memory is freed.
>>
> 
> Yes, that correct. assumption here is __initidata will free memory if
> stack_depot_disable=true is set.
> 
>> - Why is that hash table so large?  Is it appropriately sized?
>>
> 
> I think the large size of hash table is justified since the users of
> stack depot like kasan, page owner etc store a very large number of  stacks.
> 
>> - SMP is up and running during init_stackdepot(), I think?  If so, is
>>   that huge memcpy smp-safe?  Can other CPUs be modifying
>>   stack_table_tmp[] while the memcpy is in flight?
>>
>>
>>
> Yes, parallel access could be possible. I will add a locking mechanism
> inplace.
> 
> Thanks,
> Vijay
> 

I have updated the patch avoiding __initdata as per suggestion and the
copy from tmp , can you please review v5.

https://lore.kernel.org/patchwork/patch/1367306/

Thanks,
Vijay

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
