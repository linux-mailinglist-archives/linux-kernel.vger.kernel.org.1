Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59628E98B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 02:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgJOAyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 20:54:19 -0400
Received: from z5.mailgun.us ([104.130.96.5]:56312 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgJOAyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 20:54:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602723258; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=+HO83zVozbjmjmrTw3BXSFRiDICh8PBslnNPmAVQkMY=;
 b=cQ47C5YFi8rncif2vBTIzoSZSBKKr2/PJKCEZl0HRdQS/nTFgN/ZFN8QR5tnMdLMOE1Ys1mE
 7Nwe9MlAaqClIEjWOJr1pheIHZPQJtp+0H4difaLGoNbERZ+MRGj0VcrSF79/PQOGNNPnUyX
 72vNB2zNXrocDFETUihSnqKiTj8=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f879dba4f8cc67c31d6f00f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 15 Oct 2020 00:54:18
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A92AEC433FE; Thu, 15 Oct 2020 00:54:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D433FC433C9;
        Thu, 15 Oct 2020 00:54:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 14 Oct 2020 17:54:16 -0700
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gavin Shan <gshan@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v3] arm64/mm: add fallback option to allocate virtually
 contiguous memory
In-Reply-To: <bbc27422-7057-2859-56d3-ccbff49e0d43@arm.com>
References: <cover.1602542734.git.sudaraja@codeaurora.org>
 <339118202d0a4741ec22f215830dc8d9ba1ccd49.1602542734.git.sudaraja@codeaurora.org>
 <bbc27422-7057-2859-56d3-ccbff49e0d43@arm.com>
Message-ID: <f231f9c29e44d154e1e8fcf2eed0a645@codeaurora.org>
X-Sender: sudaraja@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-13 04:38, Anshuman Khandual wrote:
> On 10/13/2020 04:35 AM, Sudarshan Rajagopalan wrote:
>> When section mappings are enabled, we allocate vmemmap pages from 
>> physically
>> continuous memory of size PMD_SIZE using vmemmap_alloc_block_buf(). 
>> Section
>> mappings are good to reduce TLB pressure. But when system is highly 
>> fragmented
>> and memory blocks are being hot-added at runtime, its possible that 
>> such
>> physically continuous memory allocations can fail. Rather than failing 
>> the
>> memory hot-add procedure, add a fallback option to allocate vmemmap 
>> pages from
>> discontinuous pages using vmemmap_populate_basepages().
> 
> There is a checkpatch warning here, which could be fixed while merging 
> ?
> 
> WARNING: Possible unwrapped commit description (prefer a maximum 75
> chars per line)
> #7:
> When section mappings are enabled, we allocate vmemmap pages from 
> physically
> 
> total: 0 errors, 1 warnings, 13 lines checked
> 

Thanks Anshuman for the review. I sent out an updated patch fixing the 
checkpatch warning.

>> 
>> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Logan Gunthorpe <logang@deltatee.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Steven Price <steven.price@arm.com>
> 
> Nonetheless, this looks fine. Did not see any particular problem
> while creating an experimental vmemmap with interleaving section
> and base page mapping.
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
>> ---
>>  arch/arm64/mm/mmu.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 75df62fea1b6..44486fd0e883 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1121,8 +1121,11 @@ int __meminit vmemmap_populate(unsigned long 
>> start, unsigned long end, int node,
>>  			void *p = NULL;
>> 
>>  			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
>> -			if (!p)
>> -				return -ENOMEM;
>> +			if (!p) {
>> +				if (vmemmap_populate_basepages(addr, next, node, altmap))
>> +					return -ENOMEM;
>> +				continue;
>> +			}
>> 
>>  			pmd_set_huge(pmdp, __pa(p), __pgprot(PROT_SECT_NORMAL));
>>  		} else
>> 


Sudarshan

--
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
