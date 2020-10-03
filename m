Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E546282077
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 04:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgJCCRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 22:17:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:21948 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgJCCRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 22:17:40 -0400
IronPort-SDR: DbvXtj9/QnU6o+QSfRgxYL+hTgGmemw6zvNoM+0bE1SXSVNTi+FOQKZxK/FhKZ9yIQ6MU5XMw9
 tiTlgmVE1A1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="143118267"
X-IronPort-AV: E=Sophos;i="5.77,330,1596524400"; 
   d="scan'208";a="143118267"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 19:17:33 -0700
IronPort-SDR: NxpBzfP2PMhshRLo/OmoYMEQM2RZpyh1cWrfqrDvjG4hTC/9wvK3x0E2e/PSHCoOMfaqb6TSZg
 gotq1Ow7Aa+Q==
X-IronPort-AV: E=Sophos;i="5.77,330,1596524400"; 
   d="scan'208";a="511708915"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 19:17:31 -0700
Date:   Fri, 2 Oct 2020 19:17:30 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH 0/3] x86: Add initial support to discover Intel hybrid
 CPUs
Message-ID: <20201003021730.GA19361@agluck-desk2.amr.corp.intel.com>
References: <20201002201931.2826-1-ricardo.neri-calderon@linux.intel.com>
 <87r1qgccku.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1qgccku.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 03, 2020 at 03:39:29AM +0200, Thomas Gleixner wrote:
> On Fri, Oct 02 2020 at 13:19, Ricardo Neri wrote:
> > Add support to discover and enumerate CPUs in Intel hybrid parts. A hybrid
> > part has CPUs with more than one type of micro-architecture. Thus, certain
> > features may only be present in a specific CPU type.
> >
> > It is useful to know the type of CPUs present in a system. For instance,
> > perf may need to handle CPUs differently depending on the type of micro-
> > architecture. Decoding machine check error logs may need the additional
> > micro-architecture type information, so include that in the log.
> 
> 'It is useful' as justification just makes me barf.

This isn't "hetero" ... all of the cores are architecturally the same.
If CPUID says that some feature is supported, then it will be supported
on all of the cores.

There might be some model specific performance counter events that only
apply to some cores. Or a machine check error code that is logged in the
model specific MSCOD field of IA32_MCi_STATUS. But any and all code can run
on any core.

Sure there will be some different power/performance tradeoffs on some
cores. But we already have that with some cores able to achieve higher
turbo frequencies than others.

-Tony
