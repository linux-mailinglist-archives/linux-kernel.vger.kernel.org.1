Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E9426E1CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 19:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgIQRIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:08:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbgIQRIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:08:10 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18D84206CA;
        Thu, 17 Sep 2020 17:07:54 +0000 (UTC)
Date:   Thu, 17 Sep 2020 18:07:52 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 22/37] arm64: mte: Add in-kernel MTE helpers
Message-ID: <20200917170752.GS10662@gaia>
References: <cover.1600204505.git.andreyknvl@google.com>
 <4ac1ed624dd1b0851d8cf2861b4f4aac4d2dbc83.1600204505.git.andreyknvl@google.com>
 <20200917134653.GB10662@gaia>
 <9ef0a773-71f0-c1d6-b67e-ccf7d8bcbbe6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef0a773-71f0-c1d6-b67e-ccf7d8bcbbe6@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 05:17:00PM +0100, Vincenzo Frascino wrote:
> On 9/17/20 2:46 PM, Catalin Marinas wrote:
> >> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> >> index 52a0638ed967..e238ffde2679 100644
> >> --- a/arch/arm64/kernel/mte.c
> >> +++ b/arch/arm64/kernel/mte.c
> >> @@ -72,6 +74,52 @@ int memcmp_pages(struct page *page1, struct page *page2)
> >>  	return ret;
> >>  }
> >>  
> >> +u8 mte_get_mem_tag(void *addr)
> >> +{
> >> +	if (system_supports_mte())
> >> +		asm volatile(ALTERNATIVE("ldr %0, [%0]",
> >> +					 __MTE_PREAMBLE "ldg %0, [%0]",
> >> +					 ARM64_MTE)
> >> +			     : "+r" (addr));
> > This doesn't do what you think it does. LDG indeed reads the tag from
> > memory but LDR loads the actual data at that address. Instead of the
> > first LDR, you may want something like "mov %0, #0xf << 56" (and use
> > some macros to avoid the hard-coded 56).
> >
> 
> Seems I can't encode a shift of 56 neither in mov nor in orr. I propose to
> replace both with an and of the address with itself.
> This should not change anything.

Then use a NOP.

-- 
Catalin
