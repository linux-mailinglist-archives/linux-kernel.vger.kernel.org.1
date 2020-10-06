Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434E2284776
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 09:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgJFHhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 03:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgJFHhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 03:37:47 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AD4420789;
        Tue,  6 Oct 2020 07:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601969866;
        bh=GXj/FhHy/xOz5Avkl+n0ZiQDzSQIl/qp/OlFQDMTwok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y61YesSGpL+/tE5dfXTx0IrqApDwXLdX3J5gWZk75zR5uB+Ujz5NHa/ilZxvdos97
         pkOSOMRrS4N1LvHz34slvyiPpZ4O3yYZrT6pkZaE3iIJMZqmVDgf1eAVpTU6/gYHhp
         g1i+OVCyuXj8wCMXW0tLytYkvjOf6L/uczSOoaz0=
Date:   Tue, 6 Oct 2020 09:37:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     x86@kernel.org, Borislav Petkov <bp@suse.de>,
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
Message-ID: <20201006073744.GA6753@kroah.com>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
 <20201003011745.7768-2-ricardo.neri-calderon@linux.intel.com>
 <20201003085345.GA114893@kroah.com>
 <20201006005736.GD6041@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006005736.GD6041@ranerica-svr.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 05:57:36PM -0700, Ricardo Neri wrote:
> On Sat, Oct 03, 2020 at 10:53:45AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Oct 02, 2020 at 06:17:42PM -0700, Ricardo Neri wrote:
> > > Hybrid CPU topologies combine CPUs of different microarchitectures in the
> > > same die. Thus, even though the instruction set is compatible among all
> > > CPUs, there may still be differences in features (e.g., some CPUs may
> > > have counters that others CPU do not). There may be applications
> > > interested in knowing the type of micro-architecture topology of the
> > > system to make decisions about process affinity.
> > > 
> > > While the existing sysfs for capacity (/sys/devices/system/cpu/cpuX/
> > > cpu_capacity) may be used to infer the types of micro-architecture of the
> > > CPUs in the platform, it may not be entirely accurate. For instance, two
> > > subsets of CPUs with different types of micro-architecture may have the
> > > same capacity due to power or thermal constraints.
> > > 
> > > Create the new directory /sys/devices/system/cpu/types. Under such
> > > directory, create individual subdirectories for each type of CPU micro-
> > > architecture. Each subdirectory will have cpulist and cpumap files. This
> > > makes it convenient for user space to read all the CPUs of the same type
> > > at once without having to inspect each CPU individually.
> > > 
> > > Implement a generic interface using weak functions that architectures can
> > > override to indicate a) support for CPU types, b) the CPU type number, and
> > > c) a string to identify the CPU vendor and type.
> > > 
> > > For example, an x86 system with one Intel Core and four Intel Atom CPUs
> > > would look like this (other architectures have the hooks to use whatever
> > > directory naming convention below "types" that meets their needs):
> > > 
> > > user@host:~$: ls /sys/devices/system/cpu/types
> > > intel_atom_0  intel_core_0
> > > 
> > > user@host:~$ ls /sys/devices/system/cpu/types/intel_atom_0
> > > cpulist cpumap
> > > 
> > > user@host:~$ ls /sys/devices/system/cpu/types/intel_core_0
> > > cpulist cpumap
> > > 
> > > user@host:~$ cat /sys/devices/system/cpu/types/intel_atom_0/cpumap
> > > 0f
> > > 
> > > user@host:~$ cat /sys/devices/system/cpu/types/intel_atom_0/cpulist
> > > 0-3
> > > 
> > > user@ihost:~$ cat /sys/devices/system/cpu/types/intel_core_0/cpumap
> > > 10
> > > 
> > > user@host:~$ cat /sys/devices/system/cpu/types/intel_core_0/cpulist
> > > 4
> 
> Thank you for the quick and detailed Greg!
> 
> > 
> > The output of 'tree' sometimes makes it easier to see here, or:
> > 	grep -R . *
> > also works well.
> 
> Indeed, this would definitely make it more readable.
> 
> > 
> > > On non-hybrid systems, the /sys/devices/system/cpu/types directory is not
> > > created. Add a hook for this purpose.
> > 
> > Why should these not show up if the system is not "hybrid"?
> 
> My thinking was that on a non-hybrid system, it does not make sense to
> create this interface, as all the CPUs will be of the same type.

Why not just have this an attribute type in the existing cpuX directory?
Why do this have to be a totally separate directory and userspace has to
figure out to look in two different spots for the same cpu to determine
what it is?

That feels wasteful, it should be much simpler to use the existing
object, right?

That way, you also show the "type" of all cpus, no matter if they are
"hybrid" or not, again, making userspace deal with things in a much
simpler manner.

> > > +/**
> > > + * arch_get_cpu_type() - Get the CPU type number
> > > + * @cpu:	Index of the CPU of which the index is needed
> > > + *
> > > + * Get the CPU type number of @cpu, a non-zero unsigned 32-bit number that
> > > + * uniquely identifies a type of CPU micro-architecture. All CPUs of the same
> > > + * type have the same type number. Type numbers are defined by each CPU
> > > + * architecture.
> > > + */
> > > +u32 __weak arch_get_cpu_type(int cpu)
> > 
> > Can you just have this "cpu type" be an enumerated type so we have a
> > clue as to what they really are?  Each arch can then define it, right?
> 
> Do you mean that each arch can have its own definition of the same
> enumeration or that all archs share a common enumeration?

Each arch should have its own definition of this enumerated type.

> > > +/**
> > > + * arch_get_cpu_type_name() - Get the CPU type name
> > > + * @cpu_type:	Type of CPU micro-architecture.
> > > + *
> > > + * Returns a string name associated with the CPU micro-architecture type as
> > > + * indicated in @cpu_type. The format shall be <vendor>_<cpu_type>. Returns
> > > + * NULL if the CPU type is not known.
> > > + */
> > > +const char __weak *arch_get_cpu_type_name(u32 cpu_type)
> > > +{
> > > +	return NULL;
> > > +}
> > 
> > Why is vendor part of this?  Shouldn't it just be arch?
> > 
> > I say this as "vendor" is kind of "interesting" when it comes to other
> > arches...
> 
> I thought of this as maybe intel_atcm vs a potential amd_minizen. I
> guess arch is sufficient, as there will never be an amd_atom.

Even if there is, that can be part of the cpu "type" that you have for
your enumerated type, right?

thanks,

greg k-h
