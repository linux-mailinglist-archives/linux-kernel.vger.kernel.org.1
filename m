Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208132848D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 10:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgJFIv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 04:51:58 -0400
Received: from foss.arm.com ([217.140.110.172]:42224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgJFIv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 04:51:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9659A113E;
        Tue,  6 Oct 2020 01:51:57 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCBB13F71F;
        Tue,  6 Oct 2020 01:51:55 -0700 (PDT)
Date:   Tue, 6 Oct 2020 09:51:53 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
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
Message-ID: <20201006085152.tro3cypebbyw4ng7@e107158-lin.cambridge.arm.com>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo

Adding some people who might be interested.

On 10/02/20 18:17, Ricardo Neri wrote:
> Hybrid CPU topologies combine processors with more than one type of
> micro-architecture. Hence, it is possible that individual CPUs support
> slightly different features (e.g., performance counters) and different
> performance properties. Thus, there may be user space entities interested
> in knowing the topology of the system based on the types of available
> CPUs.
> 
> Currently, there exists an interface for the CPU capacity (/sys/devices/
> system/cpu/cpuX/cpu_capacity). However, CPU capacity does not always map
> to CPU types (by the way, I will submit a separate series to bring such
> interface to x86).

Why do you need to do this mapping?

> 
> This series proposes the new interface /sys/devices/system/cpu/types
> which, in hybrid parts, creates a subdirectory for each type of CPU.
> Each subdirectory contains a CPU list and a CPU map that user space can
> query.

Why user space needs to query this info?

The rationale is missing the intention behind all of this. It seems you're
expecting software to parse this info and take decisions based on that?

Thanks

--
Qais Yousef

> 
> Patch 1 of the series proposes the generic interface, with hooks
> that architectures can override to suit their needs. The three patches
> patches implement such interface for x86 (as per request from Boris,
> I pulled patch 2 from a separate submission [1]).
> 
> Thanks and BR,
> Ricardo
> 
> [1]. https://lkml.org/lkml/2020/10/2/1013
> 
> Ricardo Neri (4):
>   drivers core: Introduce CPU type sysfs interface
>   x86/cpu: Describe hybrid CPUs in cpuinfo_x86
>   x86/cpu/intel: Add function to get name of hybrid CPU types
>   x86/cpu/topology: Implement the CPU type sysfs interface
> 
>  .../ABI/testing/sysfs-devices-system-cpu      |  13 ++
>  arch/x86/include/asm/intel-family.h           |   4 +
>  arch/x86/include/asm/processor.h              |  13 ++
>  arch/x86/include/asm/topology.h               |   2 +
>  arch/x86/kernel/cpu/common.c                  |   3 +
>  arch/x86/kernel/cpu/cpu.h                     |   3 +
>  arch/x86/kernel/cpu/intel.c                   |  23 ++
>  arch/x86/kernel/cpu/topology.c                |  23 ++
>  drivers/base/cpu.c                            | 214 ++++++++++++++++++
>  include/linux/cpu.h                           |  12 +
>  include/linux/cpuhotplug.h                    |   1 +
>  11 files changed, 311 insertions(+)
> 
> -- 
> 2.17.1
> 
