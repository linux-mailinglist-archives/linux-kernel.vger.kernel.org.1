Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFE828080F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgJATvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:51:53 -0400
Received: from z5.mailgun.us ([104.130.96.5]:35375 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgJATvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:51:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601581913; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=q1wY2p0rUtdwprAqpqKnal9AO5BAuts9QPzd0435wBY=;
 b=i0X7xV+qg1xjwFHS90qxg1qpbJoBPFVZOf32rC9xNUMB4dpu3Y8Ep/Y+SfLo1My+NgQ1nUsq
 EF8L4By6jV4+zVAoFUPB3R0jkLUmW/fAzsWciw0vUCZDY6/45fZbM92z5Y+4GDrnSG4bZItU
 3wuuNGX3gTSJqouLuYJXhirJd3c=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f76332ece84f363c7574377 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Oct 2020 19:51:10
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 62451C433F1; Thu,  1 Oct 2020 19:51:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B333C433CA;
        Thu,  1 Oct 2020 19:51:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Oct 2020 12:51:09 -0700
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2] arm64/mm: add fallback option to allocate virtually
 contiguous memory
In-Reply-To: <eda84c3d-fc3d-1b9a-c79a-ef91668f3feb@arm.com>
References: <cover.1601506266.git.sudaraja@codeaurora.org>
 <a2d91c1b5874a1217e473ffd33cd4f765a0e78b7.1601506266.git.sudaraja@codeaurora.org>
 <eda84c3d-fc3d-1b9a-c79a-ef91668f3feb@arm.com>
Message-ID: <8201828cdd82e9c18588c95e7bdda59f@codeaurora.org>
X-Sender: sudaraja@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-30 17:30, Anshuman Khandual wrote:
> On 10/01/2020 04:43 AM, Sudarshan Rajagopalan wrote:
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
>> 
>> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Logan Gunthorpe <logang@deltatee.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Steven Price <steven.price@arm.com>
>> ---
>>  arch/arm64/mm/mmu.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 75df62f..9edbbb8 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1121,8 +1121,18 @@ int __meminit vmemmap_populate(unsigned long 
>> start, unsigned long end, int node,
>>  			void *p = NULL;
>> 
>>  			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
>> -			if (!p)
>> -				return -ENOMEM;
>> +			if (!p) {
>> +				if (altmap)
>> +					return -ENOMEM;	/* no fallback */
> 
> Why ? If huge pages inside a vmemmap section might have been allocated
> from altmap, the base page could also fallback on altmap. If this patch
> has just followed the existing x86 semantics, it was written [1] long
> back before vmemmap_populate_basepages() supported altmap allocation.
> While adding that support [2] recently, it was deliberate not to change
> x86 semantics as it was a platform decision. Nonetheless, it makes 
> sense
> to fallback on altmap bases pages if and when required.
> 
> [1] 4b94ffdc4163 (x86, mm: introduce vmem_altmap to augment 
> vmemmap_populate())
> [2] 1d9cfee7535c (mm/sparsemem: enable vmem_altmap support in
> vmemmap_populate_basepages())

Yes agreed. We can allow fallback on altmap as well. I did indeed follow 
x86 semantics. Will send the updated patch.

Sudarshan

--
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
