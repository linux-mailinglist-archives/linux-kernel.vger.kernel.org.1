Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A762C3E67
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 11:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgKYKsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 05:48:14 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:51916 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgKYKsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:48:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606301292; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=L5saGe6/ZlLQr7DhjJiJmljcVp2FFn6Pd1pWRpwTtv4=; b=RZq5Q+7aNtxX1JQ8aQOiRAZd6851DMxehDZN7PxsDVeknHOMuAxs0FhnF6X70cYlY7Qv0AZb
 4C8JWVGcrWxUUk2tjf0PJa7E7EMnRE/CUaOo7vp42wsyllzwiWx34wZqnYaAPtv4f/sKzHgx
 zpTYMOVUeRMtgqe95akvwm2EbRk=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fbe366b1dba509aae79a4a8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Nov 2020 10:48:11
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AEEE6C43465; Wed, 25 Nov 2020 10:48:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.154.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C0E1EC43460;
        Wed, 25 Nov 2020 10:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0E1EC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH] mm: memory_hotplug: put migration failure information
 under DEBUG_VM
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "vinmenon@codeaurora.org" <vinmenon@codeaurora.org>
References: <1606140196-6053-1-git-send-email-charante@codeaurora.org>
 <20201123141354.GQ27488@dhcp22.suse.cz>
 <bfa430f6-a6a6-8b08-2776-cb62197619c0@codeaurora.org>
 <20201124074141.GR27488@dhcp22.suse.cz>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <685882be-10d7-e313-cb6c-f3f45fc2dd08@codeaurora.org>
Date:   Wed, 25 Nov 2020 16:18:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201124074141.GR27488@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/2020 1:11 PM, Michal Hocko wrote:
> On Mon 23-11-20 20:40:40, Charan Teja Kalla wrote:
>>
>> Thanks Michal!
>> On 11/23/2020 7:43 PM, Michal Hocko wrote:
>>> On Mon 23-11-20 19:33:16, Charan Teja Reddy wrote:
>>>> When the pages are failed to get isolate or migrate, the page owner
>>>> information along with page info is dumped. If there are continuous
>>>> failures in migration(say page is pinned) or isolation, the log buffer
>>>> is simply getting flooded with the page owner information. As most of
>>>> the times page info is sufficient to know the causes for failures of
>>>> migration or isolation, place the page owner information under DEBUG_VM.
>>>
>>> I do not see why this path is any different from others that call
>>> dump_page. Page owner can add a very valuable information to debug
>>> the underlying reasons for failures here. It is an opt-in debugging
>>> feature which needs to be enabled explicitly. So I would argue users
>>> are ready to accept a lot of data in the kernel log.
>>
>> Just thinking how frequently failures can happen in those paths. In the
>> memory hotplug path, we can flood the page owner logs just by making one
>> page pinned.
> 
> If you are operating on a movable zone then pages shouldn't be pinned
> for unbound amount of time. Yeah there are some ways to break this
> fundamental assumption but this is a bigger problem that needs a
> solution.
> 
>> Say If it is anonymous page, the page owner information
>> shows is something like below, which is not really telling anything
>> other than how the pinned page is allocated.
> 
> Well you can tell an anonymous page from __dump_page, all right, but
> this is not true universally.
> 
>> page last allocated via order 0, migratetype Movable, gfp_mask
>> 0x100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO)
>>   prep_new_page+0x7c/0x1a4
>>   get_page_from_freelist+0x1ac/0x1c4
>>   __alloc_pages_nodemask+0x12c/0x378
>>   do_anonymous_page+0xac/0x3b4
>>   handle_pte_fault+0x2a4/0x3bc
>>   __handle_speculative_fault+0x208/0x3c0
>>   do_page_fault+0x280/0x508
>>   do_translation_fault+0x3c/0x54
>>   do_mem_abort+0x64/0xf4
>>   el0_da+0x1c/0x20
>>  page last free stack trace:
>>   free_pcp_prepare+0x320/0x454
>>   free_unref_page_list+0x9c/0x2a4
>>   release_pages+0x370/0x3c8
>>   free_pages_and_swap_cache+0xdc/0x10c
>>   tlb_flush_mmu+0x110/0x134
>>   tlb_finish_mmu+0x48/0xc0
>>   unmap_region+0x104/0x138
>>   __do_munmap+0x2ec/0x3b4
>>   __arm64_sys_munmap+0x80/0xd8
>>
>> I see at some places in the kernel where they put the dump_page under
>> DEBUG_VM, but in the end I agree that it is up to the users need. Then
>> there are some users who don't care for these page owner logs.
> 
> Well, as I've said page_owner requires an explicit enabling and I would
> expect that if somebody enables this tracking then it is expected to see
> the information when we dump a page state.
> 
>> And an issue on Embedded systems with these continuous logs being
>> printed to the console is the watchdog timeouts, because console logging
>> happens by disabling the interrupts.
> 
> Are you enabling page_owner on those systems unconditionally?
> 

Yes, We do always enable the page owner on just the internal debug
builds for memory analysis, But never on the production kernels. And on
these builds excessive logging, at times because of a pinned page,
causing the watchdog timeouts, is the problem.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
