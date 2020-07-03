Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27C52138B9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 12:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgGCKlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 06:41:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43731 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgGCKlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:41:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49ys2R4MTvz9sQt;
        Fri,  3 Jul 2020 20:41:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1593772881;
        bh=ouQdbcbhXEsmtXFYa0vga5m4RkRqU+lSip6svPkAoWE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=R6OndPXLKtiDiQ1Yg6qZjpgHLC6/QS2AlJZYtOzMgFSeYNh6Sx3B0ltJCzh7sjte5
         WiiVS0RAL5X390ALRNp7CDkU1RVQeSH9Wca2ibJ08WXyPDBnyYO+Gxoy56H8T0H24A
         F6WMbq5RKm4waWWNoG6ZJkS8Z04QD4Qfen0kPPO+o9GKjqMlrQM4oL+Hip9uWVFMld
         UPez+VVedhg6+MIFlsUQ+LqzA6fjTMk4Lbg8v+KsyVDGxyvtiP2F5mRej5ntf0lZ9k
         3JqKlIL/mXbyppKeQNjGxRorukCOGXpRzvqKB7CGr+jE5Hsx4Z3fp9XtqzVesL+Bm3
         JD0xFqCJG+Szw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 (RESEND) 2/3] mm/sparsemem: Enable vmem_altmap support in vmemmap_alloc_block_buf()
In-Reply-To: <20200702140752.GF22241@gaia>
References: <1592442930-9380-1-git-send-email-anshuman.khandual@arm.com> <1592442930-9380-3-git-send-email-anshuman.khandual@arm.com> <20200702140752.GF22241@gaia>
Date:   Fri, 03 Jul 2020 20:43:33 +1000
Message-ID: <87blkw7uay.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin Marinas <catalin.marinas@arm.com> writes:
> On Thu, Jun 18, 2020 at 06:45:29AM +0530, Anshuman Khandual wrote:
>> There are many instances where vmemap allocation is often switched between
>> regular memory and device memory just based on whether altmap is available
>> or not. vmemmap_alloc_block_buf() is used in various platforms to allocate
>> vmemmap mappings. Lets also enable it to handle altmap based device memory
>> allocation along with existing regular memory allocations. This will help
>> in avoiding the altmap based allocation switch in many places.
>> 
>> While here also implement a regular memory allocation fallback mechanism
>> when the first preferred device memory allocation fails. This will ensure
>> preserving the existing semantics on powerpc platform. To summarize there
>> are three different methods to call vmemmap_alloc_block_buf().
>> 
>> (., NULL,   false) /* Allocate from system RAM */
>> (., altmap, false) /* Allocate from altmap without any fallback */
>> (., altmap, true)  /* Allocate from altmap with fallback (system RAM) */
> [...]
>> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
>> index bc73abf0bc25..01e25b56eccb 100644
>> --- a/arch/powerpc/mm/init_64.c
>> +++ b/arch/powerpc/mm/init_64.c
>> @@ -225,12 +225,12 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>  		 * fall back to system memory if the altmap allocation fail.
>>  		 */
>>  		if (altmap && !altmap_cross_boundary(altmap, start, page_size)) {
>> -			p = altmap_alloc_block_buf(page_size, altmap);
>> -			if (!p)
>> -				pr_debug("altmap block allocation failed, falling back to system memory");
>> +			p = vmemmap_alloc_block_buf(page_size, node,
>> +						    altmap, true);
>> +		} else {
>> +			p = vmemmap_alloc_block_buf(page_size, node,
>> +						    NULL, false);
>>  		}
>> -		if (!p)
>> -			p = vmemmap_alloc_block_buf(page_size, node);
>>  		if (!p)
>>  			return -ENOMEM;
>
> Is the fallback argument actually necessary. It may be cleaner to just
> leave the code as is with the choice between altmap and NULL. If an arch
> needs a fallback (only powerpc), they have the fallback in place
> already. I don't see the powerpc code any better after this change.

Yeah I agree.

cheers
