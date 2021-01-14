Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13A92F6312
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbhANOZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:25:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbhANOZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:25:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1090A208C3;
        Thu, 14 Jan 2021 14:25:15 +0000 (UTC)
Date:   Thu, 14 Jan 2021 14:25:13 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 3/4] arm64: mte: Enable async tag check fault
Message-ID: <20210114142512.GB16561@gaia>
References: <20210107172908.42686-1-vincenzo.frascino@arm.com>
 <20210107172908.42686-4-vincenzo.frascino@arm.com>
 <20210113181121.GF27045@gaia>
 <efbb0722-eb4e-7be2-b929-77ec91cc0ae0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efbb0722-eb4e-7be2-b929-77ec91cc0ae0@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 10:24:25AM +0000, Vincenzo Frascino wrote:
> On 1/13/21 6:11 PM, Catalin Marinas wrote:
> > On Thu, Jan 07, 2021 at 05:29:07PM +0000, Vincenzo Frascino wrote:
> >>  static inline void mte_sync_tags(pte_t *ptep, pte_t pte)
> >>  {
> >>  }
> >> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> >> index 5346953e4382..74b020ce72d7 100644
> >> --- a/arch/arm64/kernel/entry-common.c
> >> +++ b/arch/arm64/kernel/entry-common.c
> >> @@ -37,6 +37,8 @@ static void noinstr enter_from_kernel_mode(struct pt_regs *regs)
> >>  	lockdep_hardirqs_off(CALLER_ADDR0);
> >>  	rcu_irq_enter_check_tick();
> >>  	trace_hardirqs_off_finish();
> >> +
> >> +	mte_check_tfsr_el1();
> >>  }
> >>  
> >>  /*
> >> @@ -47,6 +49,8 @@ static void noinstr exit_to_kernel_mode(struct pt_regs *regs)
> >>  {
> >>  	lockdep_assert_irqs_disabled();
> >>  
> >> +	mte_check_tfsr_el1();
> >> +
> >>  	if (interrupts_enabled(regs)) {
> >>  		if (regs->exit_rcu) {
> >>  			trace_hardirqs_on_prepare();
> >> @@ -243,6 +247,8 @@ asmlinkage void noinstr enter_from_user_mode(void)
> >>  
> >>  asmlinkage void noinstr exit_to_user_mode(void)
> >>  {
> >> +	mte_check_tfsr_el1();
> > 
> > While for kernel entry the asynchronous faults are sync'ed automatically
> > with TFSR_EL1, we don't have this for exit, so we'd need an explicit
> > DSB. But rather than placing it here, it's better if we add a bool sync
> > argument to mte_check_tfsr_el1() which issues a dsb() before checking
> > the register. I think that's the only place where such argument would be
> > true (for now).
> 
> Good point, I will add the dsb() in mte_check_tfsr_el1() but instead of a bool
> parameter I will add something more explicit.

Or rename the function to mte_check_tfsr_el1_no_sync() and have a static
inline mte_check_tfsr_el1() which issues a dsb() before calling the
*no_sync variant.

Adding an enum instead here is not worth it (if that's what you meant by
not using a bool).

-- 
Catalin
