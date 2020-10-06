Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC68284348
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 02:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgJFATd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 20:19:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:4481 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbgJFATc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 20:19:32 -0400
IronPort-SDR: aVsSHVFW/EiEuqQ7ig6tkbbSxh8ngC9RjbWyO/Yke7u5W3aObLAMcQvhTsaTDa0Kemkl5AF+sx
 C68mb5vyIAPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="181728110"
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="181728110"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 17:19:31 -0700
IronPort-SDR: kPyl5uQwkHKITjzSTyz+g8GIGYXmZebx9jOz1mw4FgMbnqcvwRw8S+avdifpEkX9uXXZrPaRo4
 X8fqJ3sB2VhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="296754851"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 05 Oct 2020 17:19:31 -0700
Date:   Mon, 5 Oct 2020 17:21:30 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>, x86@kernel.org,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH 0/3] x86: Add initial support to discover Intel hybrid
 CPUs
Message-ID: <20201006002130.GA6041@ranerica-svr.sc.intel.com>
References: <20201002201931.2826-1-ricardo.neri-calderon@linux.intel.com>
 <87r1qgccku.fsf@nanos.tec.linutronix.de>
 <20201003021730.GA19361@agluck-desk2.amr.corp.intel.com>
 <87lfgnd1tm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfgnd1tm.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 03, 2020 at 12:46:29PM +0200, Thomas Gleixner wrote:
> On Fri, Oct 02 2020 at 19:17, Tony Luck wrote:
> 
> > On Sat, Oct 03, 2020 at 03:39:29AM +0200, Thomas Gleixner wrote:
> >> On Fri, Oct 02 2020 at 13:19, Ricardo Neri wrote:
> >> > Add support to discover and enumerate CPUs in Intel hybrid parts. A hybrid
> >> > part has CPUs with more than one type of micro-architecture. Thus, certain
> >> > features may only be present in a specific CPU type.
> >> >
> >> > It is useful to know the type of CPUs present in a system. For instance,
> >> > perf may need to handle CPUs differently depending on the type of micro-
> >> > architecture. Decoding machine check error logs may need the additional
> >> > micro-architecture type information, so include that in the log.
> >> 
> >> 'It is useful' as justification just makes me barf.
> >
> > This isn't "hetero" ... all of the cores are architecturally the same.
> 
> The above clearly says:
> 
> >> > A hybrid part has CPUs with more than one type of micro-architecture.
> 
> Can you folks talk to each other and chose non-ambigous wording in
> changelogs and cover letters?
> 
> > If CPUID says that some feature is supported, then it will be supported
> > on all of the cores.
> 
> That's a different story.

Thank you for the quick reply, Thomas.

I am sorry if my cover letter was not sufficiently clear. I see now that
I should have done a more detailed discussion of the terminology.

Yes, all features and instructions as enumerated in CPUID will be
supported in all CPUs. Thus, the kernel will not have to check if a
feature is supported before running. The hetero/hybrid part means to
reflect that more than one types of CPUs will be present in the package,
and the main difference is power and performance. The same kernel and user code
will run on all CPUs without any other further check.

> 
> > There might be some model specific performance counter events that only
> > apply to some cores. Or a machine check error code that is logged in the
> > model specific MSCOD field of IA32_MCi_STATUS. But any and all code can run
> > on any core.
> 
> Ok. The perf side should be doable, IIRC we already have something like
> that, but Peter should know better.
> 
> > Sure there will be some different power/performance tradeoffs on some
> > cores. But we already have that with some cores able to achieve higher
> > turbo frequencies than others.
> 
> Right, that's not a problem.

We are also working this front.

Thanks and BR,
Ricardo
