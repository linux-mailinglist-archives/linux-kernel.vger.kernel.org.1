Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508D42F5071
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbhAMQz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:55:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbhAMQz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:55:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DC072339D;
        Wed, 13 Jan 2021 16:54:44 +0000 (UTC)
Date:   Wed, 13 Jan 2021 16:54:41 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kasan, arm64: fix pointer tags in KASAN reports
Message-ID: <20210113165441.GC27045@gaia>
References: <cover.1610553773.git.andreyknvl@google.com>
 <1965508bcbec62699715d32bef91628ef55b4b44.1610553774.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1965508bcbec62699715d32bef91628ef55b4b44.1610553774.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 05:03:30PM +0100, Andrey Konovalov wrote:
> As of the "arm64: expose FAR_EL1 tag bits in siginfo" patch, the address
> that is passed to report_tag_fault has pointer tags in the format of 0x0X,
> while KASAN uses 0xFX format (note the difference in the top 4 bits).
> 
> Fix up the pointer tag before calling kasan_report.
> 
> Link: https://linux-review.googlesource.com/id/I9ced973866036d8679e8f4ae325de547eb969649
> Fixes: dceec3ff7807 ("arm64: expose FAR_EL1 tag bits in siginfo")
> Fixes: 4291e9ee6189 ("kasan, arm64: print report from tag fault handler")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/mm/fault.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 3c40da479899..a218f6f2fdc8 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -304,6 +304,8 @@ static void report_tag_fault(unsigned long addr, unsigned int esr,
>  {
>  	bool is_write  = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
>  
> +	/* The format of KASAN tags is 0xF<x>. */
> +	addr |= (0xF0UL << MTE_TAG_SHIFT);

Ah, I see, that top 4 bits are zeroed by do_tag_check_fault(). When this
was added, the only tag faults were generated for user addresses.

Anyway, I'd rather fix it in there based on bit 55, something like (only
compile-tested):

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 3c40da479899..2b71079d2d32 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -709,10 +709,11 @@ static int do_tag_check_fault(unsigned long far, unsigned int esr,
 			      struct pt_regs *regs)
 {
 	/*
-	 * The architecture specifies that bits 63:60 of FAR_EL1 are UNKNOWN for tag
-	 * check faults. Mask them out now so that userspace doesn't see them.
+	 * The architecture specifies that bits 63:60 of FAR_EL1 are UNKNOWN
+	 * for tag check faults. Set them to the corresponding bits in the
+	 * untagged address.
 	 */
-	far &= (1UL << 60) - 1;
+	far = (untagged_addr(far) & ~MTE_TAG_MASK) | (far & MTE_TAG_MASK) ;
 	do_bad_area(far, esr, regs);
 	return 0;
 }

-- 
Catalin
