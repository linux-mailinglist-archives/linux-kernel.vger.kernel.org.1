Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6436B2B0306
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgKLKsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:48:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbgKLKsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:48:14 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6B1A2068D;
        Thu, 12 Nov 2020 10:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605178092;
        bh=ShG+wm8d1JPKuVmYO3I+ksi7Z+FgBHSVFUtNFUQc39c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRNoViLK7AcP1OFJiipCtcOfaiBjjPs4Hl2b+kKoWh3AETGWKj1k5XRqnTgvmb27d
         c+v/LmIRIVc2MlxMPRORxX3D9d0olkeJUghgXE7Qvt4bPH9zASTyL+5qsJtUeGMBUN
         6WUbbQa+T55INey66shi9TR/qJ0+79a0Hz3JNVt8=
Date:   Thu, 12 Nov 2020 11:49:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Brice Goglin <brice.goglin@gmail.com>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/4] drivers core: Introduce CPU type sysfs interface
Message-ID: <X60TJ2u47WK3yY/y@kroah.com>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
 <20201003011745.7768-2-ricardo.neri-calderon@linux.intel.com>
 <20201003085345.GA114893@kroah.com>
 <20201006005736.GD6041@ranerica-svr.sc.intel.com>
 <20201006073744.GA6753@kroah.com>
 <20201007031447.GB27938@ranerica-svr.sc.intel.com>
 <20201007051546.GA47583@kroah.com>
 <7233394d-982b-72cd-ceb9-d81161bd826f@gmail.com>
 <X6zZaKt57Xl9NnuN@kroah.com>
 <d7ac96f2-10e8-209d-2903-1bbe8fc552f4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7ac96f2-10e8-209d-2903-1bbe8fc552f4@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 10:10:57AM +0100, Brice Goglin wrote:
> 
> Le 12/11/2020 à 07:42, Greg Kroah-Hartman a écrit :
> > On Thu, Nov 12, 2020 at 07:19:48AM +0100, Brice Goglin wrote:
> >> Le 07/10/2020 à 07:15, Greg Kroah-Hartman a écrit :
> >>> On Tue, Oct 06, 2020 at 08:14:47PM -0700, Ricardo Neri wrote:
> >>>> On Tue, Oct 06, 2020 at 09:37:44AM +0200, Greg Kroah-Hartman wrote:
> >>>>> On Mon, Oct 05, 2020 at 05:57:36PM -0700, Ricardo Neri wrote:
> >>>>>> On Sat, Oct 03, 2020 at 10:53:45AM +0200, Greg Kroah-Hartman wrote:
> >>>>>>> On Fri, Oct 02, 2020 at 06:17:42PM -0700, Ricardo Neri wrote:
> >>>>>>>> Hybrid CPU topologies combine CPUs of different microarchitectures in the
> >>>>>>>> same die. Thus, even though the instruction set is compatible among all
> >>>>>>>> CPUs, there may still be differences in features (e.g., some CPUs may
> >>>>>>>> have counters that others CPU do not). There may be applications
> >>>>>>>> interested in knowing the type of micro-architecture topology of the
> >>>>>>>> system to make decisions about process affinity.
> >>>>>>>>
> >>>>>>>> While the existing sysfs for capacity (/sys/devices/system/cpu/cpuX/
> >>>>>>>> cpu_capacity) may be used to infer the types of micro-architecture of the
> >>>>>>>> CPUs in the platform, it may not be entirely accurate. For instance, two
> >>>>>>>> subsets of CPUs with different types of micro-architecture may have the
> >>>>>>>> same capacity due to power or thermal constraints.
> >>>>>>>>
> >>>>>>>> Create the new directory /sys/devices/system/cpu/types. Under such
> >>>>>>>> directory, create individual subdirectories for each type of CPU micro-
> >>>>>>>> architecture. Each subdirectory will have cpulist and cpumap files. This
> >>>>>>>> makes it convenient for user space to read all the CPUs of the same type
> >>>>>>>> at once without having to inspect each CPU individually.
> >>>>>>>>
> >>>>>>>> Implement a generic interface using weak functions that architectures can
> >>>>>>>> override to indicate a) support for CPU types, b) the CPU type number, and
> >>>>>>>> c) a string to identify the CPU vendor and type.
> >>>>>>>>
> >>>>>>>> For example, an x86 system with one Intel Core and four Intel Atom CPUs
> >>>>>>>> would look like this (other architectures have the hooks to use whatever
> >>>>>>>> directory naming convention below "types" that meets their needs):
> >>>>>>>>
> >>>>>>>> user@host:~$: ls /sys/devices/system/cpu/types
> >>>>>>>> intel_atom_0  intel_core_0
> >>>>>>>>
> >>>>>>>> user@host:~$ ls /sys/devices/system/cpu/types/intel_atom_0
> >>>>>>>> cpulist cpumap
> >>>>>>>>
> >>>>>>>> user@host:~$ ls /sys/devices/system/cpu/types/intel_core_0
> >>>>>>>> cpulist cpumap
> >>>>>>>>
> >>>>>>>> user@host:~$ cat /sys/devices/system/cpu/types/intel_atom_0/cpumap
> >>>>>>>> 0f
> >>>>>>>>
> >>>>>>>> user@host:~$ cat /sys/devices/system/cpu/types/intel_atom_0/cpulist
> >>>>>>>> 0-3
> >>>>>>>>
> >>>>>>>> user@ihost:~$ cat /sys/devices/system/cpu/types/intel_core_0/cpumap
> >>>>>>>> 10
> >>>>>>>>
> >>>>>>>> user@host:~$ cat /sys/devices/system/cpu/types/intel_core_0/cpulist
> >>>>>>>> 4
> >>>>>> Thank you for the quick and detailed Greg!
> >>>>>>
> >>>>>>> The output of 'tree' sometimes makes it easier to see here, or:
> >>>>>>> 	grep -R . *
> >>>>>>> also works well.
> >>>>>> Indeed, this would definitely make it more readable.
> >>>>>>
> >>>>>>>> On non-hybrid systems, the /sys/devices/system/cpu/types directory is not
> >>>>>>>> created. Add a hook for this purpose.
> >>>>>>> Why should these not show up if the system is not "hybrid"?
> >>>>>> My thinking was that on a non-hybrid system, it does not make sense to
> >>>>>> create this interface, as all the CPUs will be of the same type.
> >>>>> Why not just have this an attribute type in the existing cpuX directory?
> >>>>> Why do this have to be a totally separate directory and userspace has to
> >>>>> figure out to look in two different spots for the same cpu to determine
> >>>>> what it is?
> >>>> But if the type is located under cpuX, usespace would need to traverse
> >>>> all the CPUs and create its own cpu masks. Under the types directory it
> >>>> would only need to look once for each type of CPU, IMHO.
> >>> What does a "mask" do?  What does userspace care about this?  You would
> >>> have to create it by traversing the directories you are creating anyway,
> >>> so it's not much different, right?
> >>
> >> Hello
> >>
> >> Sorry for the late reply. As the first userspace consumer of this
> >> interface [1], I can confirm that reading a single file to get the mask
> >> would be better, at least for performance reason. On large platforms, we
> >> already have to read thousands of sysfs files to get CPU topology and
> >> cache information, I'd be happy not to read one more file per cpu.
> >>
> >> Reading these sysfs files is slow, and it does not scale well when
> >> multiple processes read them in parallel.
> > Really?  Where is the slowdown?  Would something like readfile() work
> > better for you for that?
> > 	https://lore.kernel.org/linux-api/20200704140250.423345-1-gregkh@linuxfoundation.org/
> 
> 
> I guess readfile would improve the sequential case by avoiding syscalls
> but it would not improve the parallel case since syscalls shouldn't have
> any parallel issue?

syscalls should not have parallel issues at all.

> We've been watching the status of readfile() since it was posted on LKML
> 6 months ago, but we were actually wondering if it would end up being
> included at some point.

It needs a solid reason to be merged.  My "test" benchmarks are fun to
run, but I have yet to find a real need for it anywhere as the
open/read/close syscall overhead seems to be lost in the noise on any
real application workload that I can find.

If you have a real need, and it reduces overhead and cpu usage, I'm more
than willing to update the patchset and resubmit it.

> > How does multiple processes slow anything down, there shouldn't be any
> > shared locks here.
> 
> 
> When I benchmarked this in 2016, reading a single (small) sysfs file was
> 41x slower when running 64 processes simultaneously on a 64-core Knights
> Landing than reading from a single process. On a SGI Altix UV with 12x
> 8-core CPUs, reading from one process per CPU (12 total) was 60x slower
> (which could mean NUMA affinity matters), and reading from one process
> per core (96 total) was 491x slower.
> 
> I will try to find some time to dig further on recent kernels with perf
> and readfile (both machines were running RHEL7).

2016 was a long time ago in kernel-land, please retest on a kernel.org
release, not a RHEL monstrosity.

> >> There are ways to avoid this
> >> multiple discoveries by sharing hwloc info through XML or shmem, but it
> >> will take years before all developers of different runtimes all
> >> implement this :)
> > I don't understand, what exactly are you suggesting we do here instead?
> 
> 
> I was just saying userspace has ways to mitigate the issue but it will
> take time because many different projects are involved.

I still don't understand, what issue are you referring to?

thanks,

greg k-h
