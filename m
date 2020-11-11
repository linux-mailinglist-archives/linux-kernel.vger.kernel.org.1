Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2F12AEABB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 09:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgKKIBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 03:01:44 -0500
Received: from z5.mailgun.us ([104.130.96.5]:32115 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgKKIBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:01:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605081701; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=ESMIsSZamxEqIVFkr7gnFfQ/A8f1g3wW9ZxP7w4Evwo=; b=b5BJMq29/5KKsE88b2+SgteNSeKYNYp2c6Mto5JE7ZpLeQLaTBE38b7mVmSnqOd5wa9Riy0t
 cuAsHAcbb2TZiAdH33gS792rtbdiVnfzbrD9b2jSE9UA0Sl6QS5ywbRa2bFrvPsvqfyHT6JV
 /kaFtfxzOc8wYwUMdydRQ/drrz0=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5fab9a2e97cfcbc962a71ec9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Nov 2020 08:00:46
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 72912C433CB; Wed, 11 Nov 2020 08:00:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.43.20] (unknown [106.208.38.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60FBBC433C8;
        Wed, 11 Nov 2020 08:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60FBBC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH] mm: memblock: add more debug logs
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
References: <1605010798-17545-1-git-send-email-faiyazm@codeaurora.org>
 <20201110181605.GC4758@kernel.org>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <f1e3c3c8-ed4f-9283-e221-7faec10fdd8d@codeaurora.org>
Date:   Wed, 11 Nov 2020 13:30:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201110181605.GC4758@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/10/2020 11:46 PM, Mike Rapoport wrote:
> Hi,
>
> On Tue, Nov 10, 2020 at 05:49:58PM +0530, Faiyaz Mohammed wrote:
>> Exact caller of memblock_phys_alloc_range is not available with
>> "memblock=debug". Below information is not enough for memory accounting.
>> for example:
>> [    0.000000] memblock_reserve: [0x000000023fc6b000-0x000000023fc6bfff] memblock_alloc_range_nid+0xc0/0x188
>>
>> To enhance the memblock_dbg information or to get the exact owner of the
>> memblock_reserve, add debug logs in memblock_phys_alloc_range function.
> Why would you want to use memblock=debug for memory accounting or for
> tracking of the owners of the reserved memory?
We do memblock reserved accounting to track owners to know size of memory

allocated by different drivers/owners through memblock_reserve, which help

in comparing different kernel version and in optimizations.

>
>> After adding logs:
>> [    0.000000] memblock_phys_alloc_range: 4096 bytes align=0x1000 from=0x0000000000000000 max_addr=0x0000000000000000 early_pgtable_alloc+0x24/0x178
>> [    0.000000] memblock_reserve: [0x000000023fc6b000-0x000000023fc6bfff] memblock_alloc_range_nid+0xc0/0x188
>>
>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
>> ---
>>   mm/memblock.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 049df41..f65af9f 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1419,6 +1419,9 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
>>   					     phys_addr_t start,
>>   					     phys_addr_t end)
>>   {
>> +	memblock_dbg("%s: %llu bytes align=0x%llx from=%pa max_addr=%pa %pS\n",
>> +			__func__, (u64)size, (u64)align, &start, &end,
>> +			(void *)_RET_IP_);
>>   	return memblock_alloc_range_nid(size, align, start, end, NUMA_NO_NODE,
>>   					false);
>>   }
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
>> member of the Code Aurora Forum, hosted by The Linux Foundation
>>
