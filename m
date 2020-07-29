Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF59232653
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 22:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgG2Uk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 16:40:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:6863 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgG2Uk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:40:59 -0400
IronPort-SDR: IlclRdZ/dBHb+STlDvBZu9yxeteqsh63vbHdzoI91hcGP8DAejxu48+5e9PFIvmPwGZb1bRjpc
 0E/IXcRuhwsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="213027585"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="213027585"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 13:40:58 -0700
IronPort-SDR: f2Oxby9co8guUXawubDpyXpSuYqAnvH1MxNMVgFG1KeFEl3QKBohgwatooPdO6785yPW2i6ivU
 Psq5ocl7x5dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="328762989"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jul 2020 13:40:57 -0700
Date:   Wed, 29 Jul 2020 20:40:57 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     peterz@infradead.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/bus_lock: Enable bus lock detection
Message-ID: <20200729204057.GB318595@otcwcpicx6.sc.intel.com>
References: <1595021700-68460-1-git-send-email-fenghua.yu@intel.com>
 <20200729084947.GY119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729084947.GY119549@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

On Wed, Jul 29, 2020 at 10:49:47AM +0200, peterz@infradead.org wrote:
> On Fri, Jul 17, 2020 at 02:35:00PM -0700, Fenghua Yu wrote:
> 
> > #DB for bus lock detect fixes all issues in #AC for split lock detect:
> > 1) It's architectural ... just need to look at one CPUID bit to know it
> >    exists
> > 2) The IA32_DEBUGCTL MSR, which reports bus lock in #DB, is per-thread.
> >    So each process or guest can have different behavior.
> 
> And it generates a whole new problem due to #DB being an IST, and
> 
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index b038695f36c5..58725567da39 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -812,6 +812,16 @@ static void handle_debug(struct pt_regs *regs, unsigned long dr6, bool user)
> >  	if (!user && !dr6)
> >  		return;
> >  
> > +	/* Handle bus lock. */
> > +	if (!(dr6 & DR_BUS_LOCK)) {
> > +		cond_local_irq_enable(regs);
> > +		if (user)
> > +			handle_user_bus_lock(regs);
> > +		else
> > +			handle_kernel_bus_lock(regs);
> > +		goto out;
> > +	}
> > +
> >  	/*
> >  	 * If dr6 has no reason to give us about the origin of this trap,
> >  	 * then it's very likely the result of an icebp/int01 trap.
> 
> we very much rely on #DB never recursing, which we carefully crafted by
> disallowing hardare breakpoints on noinstr code and clearing DR7 early.
> 
> But now it can... please keep the pieces.

Can we disable Bus Lock Detection before handle it and re-enable it
after handle it? Will that resolve the recursion issue?

Thanks.

-Fenghua
