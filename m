Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639942856BD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 04:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgJGCsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 22:48:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:7978 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgJGCsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 22:48:21 -0400
IronPort-SDR: AvY0VRcd9cDyNoCNG7MrCn4wqraqYaQgW1MT1AjVaoqGCME0wUxrX71agos+QrKwFPz9w8LDF+
 1OqWNnXcQ8Ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="164023036"
X-IronPort-AV: E=Sophos;i="5.77,345,1596524400"; 
   d="scan'208";a="164023036"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 19:48:21 -0700
IronPort-SDR: s6HO7/FR1WAiFLPtL05oZhwbxHXpjFPCLQL+psg5yfaA45HluqLeVh4JkYmvUBBNjPVYhpfz7C
 RUQ8LOiTmPoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,345,1596524400"; 
   d="scan'208";a="517590479"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 06 Oct 2020 19:48:21 -0700
Date:   Tue, 6 Oct 2020 19:50:19 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH 0/4] drivers core: Introduce CPU type sysfs interface
Message-ID: <20201007025019.GA27938@ranerica-svr.sc.intel.com>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
 <20201006085152.tro3cypebbyw4ng7@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006085152.tro3cypebbyw4ng7@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 09:51:53AM +0100, Qais Yousef wrote:
> Hi Ricardo

Hi Qais,

Thanks for chiming in.

> 
> Adding some people who might be interested.
> 
> On 10/02/20 18:17, Ricardo Neri wrote:
> > Hybrid CPU topologies combine processors with more than one type of
> > micro-architecture. Hence, it is possible that individual CPUs support
> > slightly different features (e.g., performance counters) and different
> > performance properties. Thus, there may be user space entities interested
> > in knowing the topology of the system based on the types of available
> > CPUs.
> > 
> > Currently, there exists an interface for the CPU capacity (/sys/devices/
> > system/cpu/cpuX/cpu_capacity). However, CPU capacity does not always map
> > to CPU types (by the way, I will submit a separate series to bring such
> > interface to x86).
> 
> Why do you need to do this mapping?
> 
> > 
> > This series proposes the new interface /sys/devices/system/cpu/types
> > which, in hybrid parts, creates a subdirectory for each type of CPU.
> > Each subdirectory contains a CPU list and a CPU map that user space can
> > query.
> 
> Why user space needs to query this info?
> 
> The rationale is missing the intention behind all of this. It seems you're
> expecting software to parse this info and take decisions based on that?

I propose this interface to be consumed for application or libraries
wanting to know the topology of the system. Perhaps, a utility program
that wants to depict CPUs by type. Another example is a policy manager
wanting to create a cgroup cpuset of CPUs of a given type for
performance reasons. Similarly, a program may want to affinitize itself
to a type of CPU, if for instance certain performance events are only
counted on a given CPU type.

Also, an interface with cpumasks makes it convenient for userspace to
not have to traverse each CPU individually.

   a) add the type of each CPU in /proc/cpuinfo
   b) add the type of each CPU in /sys/devices/system/cpu/cpu#/type
   c) for performance, derive the CPU type from
      /sys/devices/system/cpu/cpu#/cpu_capacity
   d) add an interface similar to what I propose in this series.

None of this imply that certain instructions will be able to run on one
type of CPU but not on another. Instead, better performance may be
obtained on one type CPU vs another.

Thanks and BR,
Ricardo
