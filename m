Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF312822AC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 10:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgJCIxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 04:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgJCIxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 04:53:51 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E2B1206CA;
        Sat,  3 Oct 2020 08:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601715228;
        bh=HcgqBGE09irkojJtdyjOuxCCM61C77apzbY3I8klqMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zVKOzoM8HCydSAfceqyGx7t6JZE0Cp++V7RU1fpnjiQA/Ze+mJJ2wUu+5SRS/pKs/
         nSBFNREsprtZ/5guOL3mRqalUDjC6KpJQIUBe/PgsSi4ei17b6RrSpGjq+y/UqNy5M
         w6kF/J22KK0oKPm+HQV3t9JUYOk3cPVYEiwHq5Fs=
Date:   Sat, 3 Oct 2020 10:53:45 +0200
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
Message-ID: <20201003085345.GA114893@kroah.com>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
 <20201003011745.7768-2-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003011745.7768-2-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 06:17:42PM -0700, Ricardo Neri wrote:
> Hybrid CPU topologies combine CPUs of different microarchitectures in the
> same die. Thus, even though the instruction set is compatible among all
> CPUs, there may still be differences in features (e.g., some CPUs may
> have counters that others CPU do not). There may be applications
> interested in knowing the type of micro-architecture topology of the
> system to make decisions about process affinity.
> 
> While the existing sysfs for capacity (/sys/devices/system/cpu/cpuX/
> cpu_capacity) may be used to infer the types of micro-architecture of the
> CPUs in the platform, it may not be entirely accurate. For instance, two
> subsets of CPUs with different types of micro-architecture may have the
> same capacity due to power or thermal constraints.
> 
> Create the new directory /sys/devices/system/cpu/types. Under such
> directory, create individual subdirectories for each type of CPU micro-
> architecture. Each subdirectory will have cpulist and cpumap files. This
> makes it convenient for user space to read all the CPUs of the same type
> at once without having to inspect each CPU individually.
> 
> Implement a generic interface using weak functions that architectures can
> override to indicate a) support for CPU types, b) the CPU type number, and
> c) a string to identify the CPU vendor and type.
> 
> For example, an x86 system with one Intel Core and four Intel Atom CPUs
> would look like this (other architectures have the hooks to use whatever
> directory naming convention below "types" that meets their needs):
> 
> user@host:~$: ls /sys/devices/system/cpu/types
> intel_atom_0  intel_core_0
> 
> user@host:~$ ls /sys/devices/system/cpu/types/intel_atom_0
> cpulist cpumap
> 
> user@host:~$ ls /sys/devices/system/cpu/types/intel_core_0
> cpulist cpumap
> 
> user@host:~$ cat /sys/devices/system/cpu/types/intel_atom_0/cpumap
> 0f
> 
> user@host:~$ cat /sys/devices/system/cpu/types/intel_atom_0/cpulist
> 0-3
> 
> user@ihost:~$ cat /sys/devices/system/cpu/types/intel_core_0/cpumap
> 10
> 
> user@host:~$ cat /sys/devices/system/cpu/types/intel_core_0/cpulist
> 4

The output of 'tree' sometimes makes it easier to see here, or:
	grep -R . *
also works well.

> On non-hybrid systems, the /sys/devices/system/cpu/types directory is not
> created. Add a hook for this purpose.

Why should these not show up if the system is not "hybrid"?

> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Suggested-by: Len Brown <len.brown@intel.com> # Necessity of the interface
> Suggested-by: Dave Hansen <dave.hansen@intel.com> # Details of the interface
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      |  13 ++
>  drivers/base/cpu.c                            | 214 ++++++++++++++++++
>  include/linux/cpu.h                           |  12 +
>  include/linux/cpuhotplug.h                    |   1 +
>  4 files changed, 240 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index b555df825447..bcb3d7195102 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -614,3 +614,16 @@ Description:	SPURR ticks for cpuX when it was idle.
>  
>  		This sysfs interface exposes the number of SPURR ticks
>  		for cpuX when it was idle.
> +
> +What:		/sys/devices/system/cpu/types
> +		/sys/devices/system/cpu/types/<vendor>_<cpu_type>/cpumap
> +		/sys/devices/system/cpu/types/<vendor>_<cpu_type>/cpulist

Please split these up into different entries, because:

> +Date:		Oct 2020
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:	Types of CPUs in hybrid systems
> +
> +		If a platform has CPUs with more than one type of micro-
> +		architecture, there is one directory for each type of CPU.
> +		Inside each directory, the files cpumap and cpulist contain
> +		a mask and a list representing CPUs of the same type of micro-
> +		architecture. These files only contain CPUs currently online.

You don't describe what mask and list actualy represent.  I have no clue
what they mean, so odds are, others will not either.

> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index d2136ab9b14a..7e98b11b15a1 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -607,11 +607,225 @@ static void __init cpu_register_vulnerabilities(void)
>  static inline void cpu_register_vulnerabilities(void) { }
>  #endif
>  
> +static ssize_t cpulist_show(struct device *device,
> +			    struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct cpumask *mask = dev_get_drvdata(device);
> +
> +	if (!mask)
> +		return -EINVAL;

How can mask be NULL?

> +
> +	return cpumap_print_to_pagebuf(true, buf, mask);
> +}
> +
> +static ssize_t cpumap_show(struct device *device,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct cpumask *mask = dev_get_drvdata(device);
> +
> +	if (!mask)
> +		return -EINVAL;

Again, how can that be true?

> +
> +	return cpumap_print_to_pagebuf(false, buf, mask);
> +}
> +
> +static DEVICE_ATTR_RO(cpumap);
> +static DEVICE_ATTR_RO(cpulist);
> +
> +static struct attribute *cpu_type_attrs[] = {
> +	&dev_attr_cpumap.attr,
> +	&dev_attr_cpulist.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group cpu_type_attr_group = {
> +	.attrs = cpu_type_attrs,
> +};
> +
> +static const struct attribute_group *cpu_type_attr_groups[] = {
> +	&cpu_type_attr_group,
> +	NULL,
> +};

ATTRIBUTE_GROUPS()?

> +
> +/* Root device for the cpu_type sysfs entries */
> +static struct device *cpu_type_device;
> +/*

No extra blank line?

> + * An array of cpu_type devices. One per each type of supported CPU micro-
> + * architecture.
> + */
> +static struct device *cpu_type_devices[CPUTYPES_MAX_NR];
> +
> +/**
> + * arch_get_cpu_type() - Get the CPU type number
> + * @cpu:	Index of the CPU of which the index is needed
> + *
> + * Get the CPU type number of @cpu, a non-zero unsigned 32-bit number that
> + * uniquely identifies a type of CPU micro-architecture. All CPUs of the same
> + * type have the same type number. Type numbers are defined by each CPU
> + * architecture.
> + */
> +u32 __weak arch_get_cpu_type(int cpu)

Can you just have this "cpu type" be an enumerated type so we have a
clue as to what they really are?  Each arch can then define it, right?

> +{
> +	return 0;
> +}
> +
> +/**
> + * arch_has_cpu_type() - Check if CPU types are supported
> + *
> + * Returns true if the running platform supports CPU types. This is true if the
> + * platform has CPUs of more than one type of micro-architecture. Otherwise,
> + * returns false.
> + */
> +bool __weak arch_has_cpu_type(void)
> +{
> +	return false;
> +}
> +
> +/**
> + * arch_get_cpu_type_name() - Get the CPU type name
> + * @cpu_type:	Type of CPU micro-architecture.
> + *
> + * Returns a string name associated with the CPU micro-architecture type as
> + * indicated in @cpu_type. The format shall be <vendor>_<cpu_type>. Returns
> + * NULL if the CPU type is not known.
> + */
> +const char __weak *arch_get_cpu_type_name(u32 cpu_type)
> +{
> +	return NULL;
> +}

Why is vendor part of this?  Shouldn't it just be arch?

I say this as "vendor" is kind of "interesting" when it comes to other
arches...

Speaking of other arches, we all know that other arches have this
feature as well, have you worked with any other groups to verify that
this interface will also work with them?

> +
> +static int cpu_type_create_device(int cpu, int idx)
> +{
> +	u32 cpu_type = arch_get_cpu_type(cpu);
> +	struct cpumask *mask;
> +	const char *name;
> +	char buf[64];
> +
> +	mask = kzalloc(cpumask_size(), GFP_KERNEL);
> +	if (!mask)
> +		return -ENOMEM;
> +
> +	name = arch_get_cpu_type_name(cpu_type);
> +	if (!name) {
> +		snprintf(buf, sizeof(buf), "unknown_%u", cpu_type);

If there is no name, why are you still making one up?

Shouldn't you just not create it at all?

> +		name = buf;
> +	}
> +
> +	cpu_type_devices[idx] = cpu_device_create(cpu_type_device, mask,
> +						  cpu_type_attr_groups, name);
> +	if (IS_ERR(cpu_type_devices[idx]))
> +		goto free_cpumask;
> +
> +	cpumask_set_cpu(cpu, mask);
> +	return 0;
> +
> +free_cpumask:
> +	kfree(mask);
> +	return -ENOMEM;
> +}
> +
> +static int cpu_type_sysfs_online(unsigned int cpu)
> +{
> +	u32 cpu_type = arch_get_cpu_type(cpu);
> +	struct cpumask *mask;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(cpu_type_devices); i++) {
> +		u32 this_cpu_type;
> +
> +		/*
> +		 * The first devices in the array are used first. Thus, create
> +		 * a new device as well as sysfs directory and for the type of
> +		 * @cpu.
> +		 */
> +		if (!cpu_type_devices[i])
> +			return cpu_type_create_device(cpu, i);
> +
> +		mask = dev_get_drvdata(cpu_type_devices[i]);
> +		if (!mask && !cpumask_weight(mask)) {
> +			/*
> +			 * We should not be here. Be paranoid about
> +			 * NULL pointers.
> +			 */
> +			dev_err(cpu_type_devices[i], "CPU mask is invalid");
> +			return -EINVAL;
> +		}
> +
> +		this_cpu_type = arch_get_cpu_type(cpumask_first(mask));
> +		if (cpu_type == this_cpu_type) {
> +			cpumask_set_cpu(cpu, mask);
> +			return 0;
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static int cpu_type_sysfs_offline(unsigned int cpu)
> +{
> +	u32 cpu_type = arch_get_cpu_type(cpu);
> +	struct cpumask *mask;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(cpu_type_devices); i++) {
> +		u32 this_cpu_type;
> +
> +		if (!cpu_type_devices[i])
> +			continue;
> +
> +		mask = dev_get_drvdata(cpu_type_devices[i]);
> +		if (!mask && !cpumask_weight(mask)) {
> +			/*
> +			 * We should not be here. Be paranoid about
> +			 * NULL pointers.
> +			 */
> +			dev_err(cpu_type_devices[i], "CPU mask is invalid");
> +			continue;
> +		}
> +
> +		this_cpu_type = arch_get_cpu_type(cpumask_first(mask));
> +		if (cpu_type == this_cpu_type) {
> +			cpumask_clear_cpu(cpu, mask);
> +			return 0;
> +		}
> +	}
> +
> +	/*
> +	 * If we are here, no matching cpu_type was found. This CPU was not
> +	 * accounted for at hotplug online.
> +	 */
> +	pr_warn("Unexpected CPU offline!\n");
> +
> +	return -ENODEV;
> +}
> +
> +static void __init cpu_type_sysfs_register(void)
> +{
> +	struct device *dev = cpu_subsys.dev_root;
> +	int ret;
> +
> +	if (!arch_has_cpu_type())
> +		return;
> +
> +	cpu_type_device = cpu_device_create(dev, NULL, NULL, "types");

This feels like an abuse of cpu_device_create(), doesn't it?

> +	if (IS_ERR(cpu_type_device))
> +		return;
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_BASE_CPUTYPE_ONLINE,
> +				"base/cpu_type_sysfs:online",
> +				cpu_type_sysfs_online, cpu_type_sysfs_offline);
> +	if (ret)
> +		dev_warn(dev, "failed to CPU type sysfs\n");
> +}
> +
>  void __init cpu_dev_init(void)
>  {
>  	if (subsys_system_register(&cpu_subsys, cpu_root_attr_groups))
>  		panic("Failed to register CPU subsystem");
>  
>  	cpu_dev_register_generic();
> +	cpu_type_sysfs_register();
>  	cpu_register_vulnerabilities();
>  }
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 8aa84c052fdf..76fba70c7801 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -228,4 +228,16 @@ static inline int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval) { return 0;
>  extern bool cpu_mitigations_off(void);
>  extern bool cpu_mitigations_auto_nosmt(void);
>  
> +#ifndef CPUTYPES_MAX_NR
> +/*
> + * The maximum number of types of cpus. Architecture-specific implementations
> + * shall override this value.
> + */
> +#define CPUTYPES_MAX_NR 0
> +#endif
> +
> +extern u32 arch_get_cpu_type(int cpu);
> +extern bool arch_has_cpu_type(void);
> +extern const char *arch_get_cpu_type_name(u32 cpu_type);
> +
>  #endif /* _LINUX_CPU_H_ */
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 6f524bbf71a2..fd90ccb6652c 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -186,6 +186,7 @@ enum cpuhp_state {
>  	CPUHP_AP_WATCHDOG_ONLINE,
>  	CPUHP_AP_WORKQUEUE_ONLINE,
>  	CPUHP_AP_RCUTREE_ONLINE,
> +	CPUHP_AP_BASE_CPUTYPE_ONLINE,
>  	CPUHP_AP_BASE_CACHEINFO_ONLINE,

I'm all for messing with enumerated type values, but why put it in this
part of the list and not right before the next one?

thanks,

greg k-h
