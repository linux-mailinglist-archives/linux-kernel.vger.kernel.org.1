Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB09A284372
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 02:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgJFApH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 20:45:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:56837 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgJFApH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 20:45:07 -0400
IronPort-SDR: 6t03kDZHaiDABBHXhYt6qRJAGIg8lm9sGuF/GVao20rpEJVYU3HxrGqymv+zpv5eKhMUNTX1nf
 K5HD8b28DqOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="160906977"
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="160906977"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 17:45:05 -0700
IronPort-SDR: QM01MoaC9xArvZX+kA+YOb/6d5JYYJnP66d5LYEPEGNFoTPL49ORKFouEyi8Qa7Cy/zTDvIukf
 bfjLsCV2Iiuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="417755058"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP; 05 Oct 2020 17:22:05 -0700
Date:   Mon, 5 Oct 2020 17:24:04 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH 0/3] x86: Add initial support to discover Intel hybrid
 CPUs
Message-ID: <20201006002404.GB6041@ranerica-svr.sc.intel.com>
References: <20201002201931.2826-1-ricardo.neri-calderon@linux.intel.com>
 <87r1qgccku.fsf@nanos.tec.linutronix.de>
 <20201003021730.GA19361@agluck-desk2.amr.corp.intel.com>
 <20201003090413.GB14035@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003090413.GB14035@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 03, 2020 at 11:04:29AM +0200, Borislav Petkov wrote:
> On Fri, Oct 02, 2020 at 07:17:30PM -0700, Luck, Tony wrote:
> > On Sat, Oct 03, 2020 at 03:39:29AM +0200, Thomas Gleixner wrote:
> > > On Fri, Oct 02 2020 at 13:19, Ricardo Neri wrote:
> > > > Add support to discover and enumerate CPUs in Intel hybrid parts. A hybrid
> > > > part has CPUs with more than one type of micro-architecture. Thus, certain
> > > > features may only be present in a specific CPU type.
> > > >
> > > > It is useful to know the type of CPUs present in a system. For instance,
> > > > perf may need to handle CPUs differently depending on the type of micro-
> > > > architecture. Decoding machine check error logs may need the additional
> > > > micro-architecture type information, so include that in the log.
> > > 
> > > 'It is useful' as justification just makes me barf.
> > 
> > This isn't "hetero" ... all of the cores are architecturally the same.
> 
> But it says above "A hybrid part has CPUs with more than one type of
> micro-architecture."
> 
> So which is it?

Yes, even though they have different micro-architectures, all instructions and
features will be the same across CPUs.

> 
> > If CPUID says that some feature is supported, then it will be supported
> > on all of the cores.
> 
> Ok.
> 
> > There might be some model specific performance counter events that only
> > apply to some cores.
> 
> That sounds like the perf counter scheduling code would have to pay
> attention to what is supported. I think we have some functionality for
> that due to some AMD parts but I'd prefer if Peter comments here.
> 
> > Or a machine check error code that is logged in the model specific
> > MSCOD field of IA32_MCi_STATUS. But any and all code can run on any
> > core.
> 
> As long as that is consumed only by userspace I guess that's ok. The
> moment someone starts to want to differentiate on what kind of CPU
> kernel code runs and acts accordingly, then it becomes ugly so we better
> hash it out upfront.

We are not planning to implement changes as such.

Thanks and BR,
Ricardo
