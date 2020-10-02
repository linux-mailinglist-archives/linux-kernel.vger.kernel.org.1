Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F102A281D4A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 23:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgJBVAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 17:00:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:44664 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBVAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 17:00:31 -0400
IronPort-SDR: 0GXbjNjKMZfzjqhbHUXcIoUB8LOC/LoKrZFK8vubNUFtZFy6+lI7yXWjp1psdiBdX3Msx7Roxl
 ncs3vhkCMLVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="163941361"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="163941361"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 14:00:30 -0700
IronPort-SDR: dRGMH4fBf/uaXhBuHbKd+MPThXrMW0Y+vIfhYFOx7GKk19+6EaF3rUwAU+UoOhOw+Pm3wxGVKT
 G2VvN2iGzOuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="510400794"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 02 Oct 2020 14:00:30 -0700
Date:   Fri, 2 Oct 2020 14:02:31 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 2/3] x86/cpu: Describe hybrid CPUs in cpuinfo_x86
Message-ID: <20201002210231.GA3222@ranerica-svr.sc.intel.com>
References: <20201002201931.2826-1-ricardo.neri-calderon@linux.intel.com>
 <20201002201931.2826-3-ricardo.neri-calderon@linux.intel.com>
 <20201002203452.GE17436@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002203452.GE17436@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 10:34:52PM +0200, Borislav Petkov wrote:
> On Fri, Oct 02, 2020 at 01:19:30PM -0700, Ricardo Neri wrote:
> > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> > index 35ad8480c464..0778b3ad26b3 100644
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -932,6 +932,11 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
> >  		c->x86_capability[CPUID_D_1_EAX] = eax;
> >  	}
> >  
> > +	if (cpu_has(c, X86_FEATURE_HYBRID_CPU)) {
> > +		cpuid_count(0x0000001a, 0, &eax, &ebx, &ecx, &edx);
> > +		c->x86_cpu_type = eax;
> 
> 		c->x86_cpu_type = cpuid_eax(0x0000001a);
> 
> should do too.

Thank you for the quick feedback Boris! Sure I can implement it as you
suggest.

> 
> But send this patch together with the code that uses it.

Sure I can submit it along with the code using it.

What about patches 1 and 3? Should I resubmit the series with only
those?

Thanks and BR,
Ricardo
