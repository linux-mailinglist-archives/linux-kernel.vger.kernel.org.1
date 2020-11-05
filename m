Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294342A738E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387840AbgKEADp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:03:45 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:24722 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731343AbgKEADm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:03:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604534621; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=+0WnlWc0h6ylWdn3v/K8WxY0ja4ryNOQxixoZcWIBvQ=;
 b=my7fkLi53OPPYtbr8pX7tldLgtAvUQs7U1HGA7jbH0RwJXAGo4JlhLlMBtSFv64d2yxV2Qki
 2hC/4GPRVgTu8HFvOI9o7KIkrGJ4dtlgk1zGYy3Ytyz0GcQBwHN/swQ0Di1FXIiL2+6yPwbt
 xjPe7NRPVJMXl8L0/eHsD1OOpxU=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fa3415c77d543c3c7c86714 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 05 Nov 2020 00:03:40
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 363ACC43382; Thu,  5 Nov 2020 00:03:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52C2DC433FE;
        Thu,  5 Nov 2020 00:03:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 Nov 2020 16:03:36 -0800
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Gavin Shan <gshan@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v4] arm64/mm: add fallback option to allocate virtually
 contiguous memory
In-Reply-To: <d6c06f2ef39bbe6c715b2f6db76eb16155fdcee6.1602722808.git.sudaraja@codeaurora.org>
References: <cover.1602722808.git.sudaraja@codeaurora.org>
 <d6c06f2ef39bbe6c715b2f6db76eb16155fdcee6.1602722808.git.sudaraja@codeaurora.org>
Message-ID: <4ca1e695f81b368a5487bdaa9b421a95@codeaurora.org>
X-Sender: sudaraja@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-16 11:56, Sudarshan Rajagopalan wrote:

Hello Will, Catalin,

Did you have a chance to review this patch? It is reviewed by others and 
haven't seen any Nacks. This patch will be useful to have so that memory 
hotremove doesn't fail when such PMD_SIZE pages aren't available.. which 
is usually the case in low RAM devices.

> When section mappings are enabled, we allocate vmemmap pages from
> physically continuous memory of size PMD_SIZE using
> vmemmap_alloc_block_buf(). Section mappings are good to reduce TLB
> pressure. But when system is highly fragmented and memory blocks are
> being hot-added at runtime, its possible that such physically 
> continuous
> memory allocations can fail. Rather than failing the memory hot-add
> procedure, add a fallback option to allocate vmemmap pages from
> discontinuous pages using vmemmap_populate_basepages().
> 
> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 75df62fea1b6..44486fd0e883 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1121,8 +1121,11 @@ int __meminit vmemmap_populate(unsigned long
> start, unsigned long end, int node,
>  			void *p = NULL;
> 
>  			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
> -			if (!p)
> -				return -ENOMEM;
> +			if (!p) {
> +				if (vmemmap_populate_basepages(addr, next, node, altmap))
> +					return -ENOMEM;
> +				continue;
> +			}
> 
>  			pmd_set_huge(pmdp, __pa(p), __pgprot(PROT_SECT_NORMAL));
>  		} else

-- 
Sudarshan

--
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
