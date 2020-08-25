Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925EA251471
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 10:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgHYIjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 04:39:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:62291 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbgHYIjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:39:46 -0400
IronPort-SDR: 6hf9NM6ewjQSKZwP43xw4/WIGF6gqWLnwNiVLyha8zyY/fqXmKfYoZ48+qPa2x2swHtdm1Cmqm
 3prENlFcsZ8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143731051"
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="143731051"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 01:39:45 -0700
IronPort-SDR: khKc+1k2dfxF4I/hhwwK2jpkKpV+l8pJZgUuRxWOG5P6qT2C7oPwsHNpHHjbSHvSUUY3InWVO4
 8r+GKvbUE2Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="328791951"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2020 01:39:44 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kAUHs-00BHJo-Jf; Tue, 25 Aug 2020 11:26:36 +0300
Date:   Tue, 25 Aug 2020 11:26:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v1] sched/topology: Make compiler happy about unused
 constant definitions
Message-ID: <20200825082636.GQ1891694@smile.fi.intel.com>
References: <20200824153902.57875-1-andriy.shevchenko@linux.intel.com>
 <jhjeenwdl7u.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jhjeenwdl7u.mognet@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 06:09:41PM +0100, Valentin Schneider wrote:
> On 24/08/20 16:39, Andy Shevchenko wrote:
> > Compilation of almost each file ends up with
> >
> >  In file included from .../include/linux/energy_model.h:10,
> >                 from .../include/linux/device.h:16,
> >                 from .../drivers/spi/spi.c:8:
> >  .../include/linux/sched/topology.h:30:27: warning: ‘SD_DEGENERATE_GROUPS_MASK’ defined but not used [-Wunused-const-variable=]
> >     30 | static const unsigned int SD_DEGENERATE_GROUPS_MASK =
> >        |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
> >  ...
> >
> > Make compiler happy by annotating the static constants with __maybwe_unused.
> >
> 
> That should see some use as long as the build is for SMP. This whole region
> is guarded by #ifdef CONFIG_SMP, so an !SMP build shouldn't trigger this.

Isn't SMP is default for most of the kernel builds?
And honestly I didn't get the purpose of this comment.

> With what config/kernel are you getting this?

x86_64_defconfig from the kernel sources with some drivers added (SMP or so has
not been touched, DEBUG_SHED was enabled once to confirm that another static
const has same issue).

-- 
With Best Regards,
Andy Shevchenko


