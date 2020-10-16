Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4CB290BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 20:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403838AbgJPStE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 14:49:04 -0400
Received: from z5.mailgun.us ([104.130.96.5]:27257 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393025AbgJPStE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:49:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602874144; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=6kSIZLy2TJqD3zONMy0SK+wNFsehhz+E0UJjqKYOEJE=;
 b=CYVXT2H6EjCqBxzErjAJBYFVPobo/9g7p6YIfKRHtDRYgB/EOkB1vdiAcGH/jQ3akmoLJdMB
 XYy/DSk8xwHXMQcycK5USJRteAOoidawMLKBerNCQ5khaDQUlVbvfzpRS3T4kp4vkPyeKLU8
 PhX0g3pjPwbcVAz2QWYOrnSyhC4=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f89eb1ff9168450eab3f965 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Oct 2020 18:49:03
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 73619C43385; Fri, 16 Oct 2020 18:49:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED731C433F1;
        Fri, 16 Oct 2020 18:49:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 16 Oct 2020 11:49:02 -0700
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gavin Shan <gshan@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v3] arm64/mm: add fallback option to allocate virtually
 contiguous memory
In-Reply-To: <20201015083605.GA4537@willie-the-truck>
References: <cover.1602722808.git.sudaraja@codeaurora.org>
 <d6c06f2ef39bbe6c715b2f6db76eb16155fdcee6.1602722808.git.sudaraja@codeaurora.org>
 <20201015083605.GA4537@willie-the-truck>
Message-ID: <541f79b6b5f3640c1e4978931ae93a38@codeaurora.org>
X-Sender: sudaraja@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-15 01:36, Will Deacon wrote:
> On Wed, Oct 14, 2020 at 05:51:23PM -0700, Sudarshan Rajagopalan wrote:
>> When section mappings are enabled, we allocate vmemmap pages from
>> physically continuous memory of size PMD_SIZE using
>> vmemmap_alloc_block_buf(). Section mappings are good to reduce TLB
>> pressure. But when system is highly fragmented and memory blocks are
>> being hot-added at runtime, its possible that such physically 
>> continuous
>> memory allocations can fail. Rather than failing the memory hot-add
>> procedure, add a fallback option to allocate vmemmap pages from
>> discontinuous pages using vmemmap_populate_basepages().
>> 
>> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Logan Gunthorpe <logang@deltatee.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Steven Price <steven.price@arm.com>
>> ---
>>  arch/arm64/mm/mmu.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> Please can you fix the subject? I have three copies of "PATCH v3" from
> different days in my inbox. I know it sounds trivial, but getting these
> little things right really helps with review, especially when it's 
> sitting
> amongst a sea of other patches.

Yes sure, sorry about that - will change it to "PATCH v4" to make it 
stand out from other patches.

> 
> Thanks,
> 
> Will


Sudarshan

--
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
