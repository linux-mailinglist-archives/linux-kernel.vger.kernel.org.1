Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A53426E1AF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 19:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgIQREu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728807AbgIQQ7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:59:01 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5906E2064B;
        Thu, 17 Sep 2020 16:58:58 +0000 (UTC)
Date:   Thu, 17 Sep 2020 17:58:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marco Elver <elver@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2 27/37] arm64: mte: Switch GCR_EL1 in kernel entry and
 exit
Message-ID: <20200917165855.GH10662@gaia>
References: <cover.1600204505.git.andreyknvl@google.com>
 <c801517c8c6c0b14ac2f5d9e189ff86fdbf1d495.1600204505.git.andreyknvl@google.com>
 <20200917165221.GF10662@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917165221.GF10662@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 05:52:21PM +0100, Catalin Marinas wrote:
> On Tue, Sep 15, 2020 at 11:16:09PM +0200, Andrey Konovalov wrote:
> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index ff34461524d4..79a6848840bd 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -175,6 +175,28 @@ alternative_else_nop_endif
> >  #endif
> >  	.endm
> >  
> > +	.macro mte_restore_gcr, el, tsk, tmp, tmp2
> > +#ifdef CONFIG_ARM64_MTE
> > +alternative_if_not ARM64_MTE
> > +	b	1f
> > +alternative_else_nop_endif
> > +	.if	\el == 0
> > +	ldr	\tmp, [\tsk, #THREAD_GCR_EL1_USER]
> > +	.else
> > +	ldr_l	\tmp, gcr_kernel_excl
> > +	.endif
> > +	/*
> > +	 * Calculate and set the exclude mask preserving
> > +	 * the RRND (bit[16]) setting.
> > +	 */
> > +	mrs_s	\tmp2, SYS_GCR_EL1
> > +	bfi	\tmp2, \tmp, #0, #16
> > +	msr_s	SYS_GCR_EL1, \tmp2
> > +	isb
> > +1:
> > +#endif
> > +	.endm
> > +
> >  	.macro	kernel_entry, el, regsize = 64
> >  	.if	\regsize == 32
> >  	mov	w0, w0				// zero upper 32 bits of x0
> > @@ -214,6 +236,8 @@ alternative_else_nop_endif
> >  
> >  	ptrauth_keys_install_kernel tsk, x20, x22, x23
> >  
> > +	mte_restore_gcr 1, tsk, x22, x23
> > +
> >  	scs_load tsk, x20
> >  	.else
> >  	add	x21, sp, #S_FRAME_SIZE
> > @@ -332,6 +356,8 @@ alternative_else_nop_endif
> >  	/* No kernel C function calls after this as user keys are set. */
> >  	ptrauth_keys_install_user tsk, x0, x1, x2
> >  
> > +	mte_restore_gcr 0, tsk, x0, x1
> 
> Some nitpicks on these macros to match the ptrauth_keys_* above. Define
> separate mte_set_{user,kernel}_gcr macros with a common mte_set_gcr that
> is used by both.

One more thing - the new mte_set_kernel_gcr should probably skip the
GCR_EL1 update if KASAN_HW_TAGS is disabled.

-- 
Catalin
