Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3092517C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 13:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgHYLhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 07:37:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:22623 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729922AbgHYLgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 07:36:33 -0400
IronPort-SDR: 0N08EGjPgl3UeHDBT5dOrHfMS80y/fZv/7K3D3lvLDI6tisDn1qpF1/32yXSvV8+GP+EhhLGXB
 l9ywlGMiTxQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="135636937"
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="135636937"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 04:36:32 -0700
IronPort-SDR: IM7/iMbO6x32zcZVy1wLv15VTUDoppFVniq6THKiFu4g35nsZt4PUVUsF/HGSwhtLXh5uO154z
 ROvN51sruulw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="328839867"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2020 04:36:26 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kAXBK-00BJR9-Ss; Tue, 25 Aug 2020 14:32:02 +0300
Date:   Tue, 25 Aug 2020 14:32:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v1] sched/topology: Make compiler happy about unused
 constant definitions
Message-ID: <20200825113202.GX1891694@smile.fi.intel.com>
References: <20200824153902.57875-1-andriy.shevchenko@linux.intel.com>
 <jhjeenwdl7u.mognet@arm.com>
 <20200825082636.GQ1891694@smile.fi.intel.com>
 <jhjd03fdrn3.mognet@arm.com>
 <jhjblizdofu.mognet@arm.com>
 <20200825112405.GU1891694@smile.fi.intel.com>
 <20200825112605.GV1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200825112605.GV1891694@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 02:26:05PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 25, 2020 at 02:24:05PM +0300, Andy Shevchenko wrote:
> > On Tue, Aug 25, 2020 at 11:12:21AM +0100, Valentin Schneider wrote:
> > > On 25/08/20 10:03, Valentin Schneider wrote:
> > > > On 25/08/20 09:26, Andy Shevchenko wrote:
> > > >> On Mon, Aug 24, 2020 at 06:09:41PM +0100, Valentin Schneider wrote:
> > > >>> On 24/08/20 16:39, Andy Shevchenko wrote:
> > > >>> > Compilation of almost each file ends up with
> > > >>> >
> > > >>> >  In file included from .../include/linux/energy_model.h:10,
> > > >>> >                 from .../include/linux/device.h:16,
> > > >>> >                 from .../drivers/spi/spi.c:8:
> > > >>> >  .../include/linux/sched/topology.h:30:27: warning: ‘SD_DEGENERATE_GROUPS_MASK’ defined but not used [-Wunused-const-variable=]
> > > >>> >     30 | static const unsigned int SD_DEGENERATE_GROUPS_MASK =
> > > >>> >        |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > >>> >  ...
> > > >>> >
> > > >>> > Make compiler happy by annotating the static constants with __maybwe_unused.
> > > 
> > > > Sorry, that's what I get for trying to be too succinct; what I tried to say
> > > > was that SD_DEGENERATE_GROUPS_MASK should very much be used for SMP. If the
> > > > build is !SMP, it shouldn't even be defined, IOW I'm perplexed as to where
> > > > this is coming from.
> > > 
> > > So I see how having this as a constvar rather than a constexpr is somewhat
> > > daft (we get an instance per compilation unit), but none of my compilers
> > > seem to complain (even with W=1). AFAIA the kernelbot didn't catch any of
> > > it either.

And even without compiler or any other analyzer / bot I can 100% sure tell that
spi.c does *not* use that symbol.

-- 
With Best Regards,
Andy Shevchenko


