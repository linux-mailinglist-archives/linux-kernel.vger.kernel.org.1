Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718622FEDF6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbhAUPEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731979AbhAUN0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:26:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681C0C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:25:50 -0800 (PST)
Received: from zn.tnic (p200300ec2f157500c7fc2d457faa3c9f.dip0.t-ipconnect.de [IPv6:2003:ec:2f15:7500:c7fc:2d45:7faa:3c9f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 252EA1EC009F;
        Thu, 21 Jan 2021 14:25:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611235548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jvlCWjXWGIBQt4nxHNiZRsf/XdhFBhdMgqMBnmemIms=;
        b=Ew7NXBrBdyvaPSXS0e25IBDdoFacN8Idm78Ih7jYiAVHIgu4k7ymmZXdxvZskpTqfgvmDd
        yNZ4MPQ15wzFtdv9a01fUcvhrwl7CKW1uDFc09AvDceOcgcloTWTmIdAbPa0KN23CevO8+
        OwqI4IviHp4mXz9xvvEKQJp8JKFdxdk=
Date:   Thu, 21 Jan 2021 14:25:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/setup: don't remove E820_TYPE_RAM for pfn 0
Message-ID: <20210121132542.GB32060@zn.tnic>
References: <20210111194017.22696-1-rppt@kernel.org>
 <20210111194017.22696-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210111194017.22696-2-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 09:40:16PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The first 4Kb of memory is a BIOS owned area and to avoid its allocation
> for the kernel it was not listed in e820 tables as memory. As the result,
> pfn 0 was never recognised by the generic memory management and it is not a
> part of neither node 0 nor ZONE_DMA.
> 
> If set_pfnblock_flags_mask() would be ever called for the pageblock
> corresponding to the first 2Mbytes of memory, having pfn 0 outside of
> ZONE_DMA would trigger
> 
> 	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
> 
> Along with reserving the first 4Kb in e820 tables, several first pages are
> reserved with memblock in several places during setup_arch(). These
> reservations are enough to ensure the kernel does not touch the BIOS area
> and it is not necessary to remove E820_TYPE_RAM for pfn 0.
> 
> Remove the update of e820 table that changes the type of pfn 0 and move the
> comment describing why it was done to trim_low_memory_range() that reserves
> the beginning of the memory.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/x86/kernel/setup.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)

FWIW,

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
