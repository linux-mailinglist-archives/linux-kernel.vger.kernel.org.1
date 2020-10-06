Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF93284378
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 02:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgJFApj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 20:45:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:37998 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgJFApj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 20:45:39 -0400
IronPort-SDR: ThpEB1RxMfaoukI/eJ+9FjOOrLJizEpi4UFgw4R8Igy4alARkoRhA0ssNB+se87u9lUqQFd9sv
 HS5nkTSdq74A==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="163511992"
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="163511992"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 05 Oct 2020 17:45:39 -0700
IronPort-SDR: sdLt+WG5kroCEue5dSYKRx7UAWYevQPfDZMW+tG8m2+KbDqeybGtqc1aZQkr/duTsX8x+nUd90
 K0qTc17Ta/ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="417755291"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP; 05 Oct 2020 17:25:18 -0700
Date:   Mon, 5 Oct 2020 17:27:17 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] drivers core: Introduce CPU type sysfs interface
Message-ID: <20201006002717.GC6041@ranerica-svr.sc.intel.com>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
 <20201003084934.GA14035@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003084934.GA14035@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 03, 2020 at 10:49:34AM +0200, Borislav Petkov wrote:
> On Fri, Oct 02, 2020 at 06:17:41PM -0700, Ricardo Neri wrote:
> > Patch 1 of the series proposes the generic interface, with hooks
> > that architectures can override to suit their needs. The three patches
> > patches implement such interface for x86 (as per request from Boris,
> > I pulled patch 2 from a separate submission [1]).
> 
> So I ask you to show me the whole thing, how this is supposed to be used
> in a *real* use case and you're sending me a couple of patches which
> report these heterogeneous or whatever they're gonna be called CPUs.
> 
> Are you telling me that all this development effort was done so that
> you can report heterogeneity in sysfs? Or you just had to come up with
> *something*?
> 
> Let me try again: please show me the *big* *picture* with all the code
> how this is supposed to be used. In the patches I read a bunch of "may"
> formulations of what is possible and what userspace could do and so on.
> 
> Not that - show me the *full* and *real* use cases which you are
> enabling and which justify all that churn. Instead of leaving it all to
> userspace CPUID and the kernel not caring one bit.
> 
> Does that make more sense?

Yes Boris, thanks for the clarification. The proposed sysfs interface is
one instance in which we use cpuinfo_x86.x86_cpu_type. I have other
changes that use this new member. I will post them.

> 
> > [1]. https://lkml.org/lkml/2020/10/2/1013
> 
> For supplying links, we use lore.kernel.org/r/<message-id> solely.
> Please use that from now on.

Sure Boris, I will use lore.kernel.org in the future.

Thanks and BR,
Ricardo
