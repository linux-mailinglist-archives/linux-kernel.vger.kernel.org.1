Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424AE28439C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 03:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgJFBDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 21:03:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:40548 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgJFBDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 21:03:43 -0400
IronPort-SDR: z7qNy0qSt7+NlGzaDqeCAZOO0YKLdN4vXg/FDM1q/0kWlZW0yjAqgtI5tPz7GhmdQ5yjlLRAMa
 0W2wwVAxnVAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="163516279"
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="163516279"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 18:03:37 -0700
IronPort-SDR: l/hk0RQ1WxctL9a2Cd7opHT9VeB6DFDQoCZ0YmMqdNF60bwim2UNe5n3JkNdogkEZd5Y1W9/OQ
 KJogBOqQSGLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="353187746"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Oct 2020 18:03:37 -0700
Date:   Mon, 5 Oct 2020 18:05:36 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 4/4] x86/cpu/topology: Implement the CPU type sysfs
 interface
Message-ID: <20201006010536.GE6041@ranerica-svr.sc.intel.com>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
 <20201003011745.7768-5-ricardo.neri-calderon@linux.intel.com>
 <20201003085506.GB114893@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003085506.GB114893@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 03, 2020 at 10:55:06AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 02, 2020 at 06:17:45PM -0700, Ricardo Neri wrote:
> > Recent Intel processors combine CPUs with different types of micro-
> > architecture in the same package. There may be applications interested in
> > knowing the type topology of the system. For instance, it can be used to
> > to determine which subsets of CPUs share a common feature.
> > 
> > Implement cpu_type sysfs interfaces for Intel processors.
> > 
> > For example, in a system with four Intel Atom CPUs and one Intel Core CPU,
> > these entries look as below. In this example, the native model IDs for
> > both types of CPUs are 0:
> > 
> > user@host:~$: ls /sys/devices/system/cpu/types
> > intel_atom_0 intel_core_0
> > 
> > user@host:~$ ls /sys/devices/system/cpu/types/intel_atom_0
> > cpulist cpumap
> > 
> > user@host:~$ ls /sys/devices/system/cpu/types/intel_core_0
> > cpulist cpumap
> > 
> > user@host:~$ cat /sys/devices/system/cpu/types/intel_atom/cpumap
> > 0f
> > 
> > user@host:~$ cat /sys/devices/system/cpu/types/intel_atom/cpulist
> > 0-3
> > 
> > user@nost:~$ cat /sys/devices/system/cpu/types/intel_core/cpumap
> > 10
> > 
> > user@host:~$ cat /sys/devices/system/cpu/types/intel_core/cpulist
> > 4
> 
> You used the same changelog text here as you did in patch 1/4, why?

In both changesets, if merged, somebody could conveniently do git show
on either commit quickly see the result intent of the changeset.

Would it make it better if in patch 1/4 I put an hypothetical generic
example?

Something like:

user@host:~$: ls /sys/devices/system/cpu/types
<arch>_<type_a> <arch><type_b>

Thanks and BR,
Ricardo
