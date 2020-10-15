Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2124D28EE9A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgJOIgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:32802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729723AbgJOIgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:36:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 576012075B;
        Thu, 15 Oct 2020 08:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602750971;
        bh=hP94CwWS7xvhTtF8wHiWx81RZLTLeMuk1epq5z2bU60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Txd/JrrpLD6X5BUFspoeQ16zqYuMvFY/nGUubsShJbaDZD/vXpFyWkRVj1Db6IsFt
         sP2wBydRlaO/qSJTch7wm2jzfKeziqjJgYgqPtA5Z/sPQwdIOEOL6oree26WZRVPbN
         z3oI29eBZ5kFodoa2KvHQwD5FsU9Q5D0mDLAr5VA=
Date:   Thu, 15 Oct 2020 09:36:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
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
Message-ID: <20201015083605.GA4537@willie-the-truck>
References: <cover.1602722808.git.sudaraja@codeaurora.org>
 <d6c06f2ef39bbe6c715b2f6db76eb16155fdcee6.1602722808.git.sudaraja@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6c06f2ef39bbe6c715b2f6db76eb16155fdcee6.1602722808.git.sudaraja@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 05:51:23PM -0700, Sudarshan Rajagopalan wrote:
> When section mappings are enabled, we allocate vmemmap pages from
> physically continuous memory of size PMD_SIZE using
> vmemmap_alloc_block_buf(). Section mappings are good to reduce TLB
> pressure. But when system is highly fragmented and memory blocks are
> being hot-added at runtime, its possible that such physically continuous
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

Please can you fix the subject? I have three copies of "PATCH v3" from
different days in my inbox. I know it sounds trivial, but getting these
little things right really helps with review, especially when it's sitting
amongst a sea of other patches.

Thanks,

Will
