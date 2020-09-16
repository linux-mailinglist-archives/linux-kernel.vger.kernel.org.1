Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559F426BCFD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgIPG0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgIPGZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:25:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFC6C061788;
        Tue, 15 Sep 2020 23:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=NpdXKEwksWa1XZYlNarFyqRn8b12MyzAj276D3yK6dM=; b=DiEO4Fy7eGXklbW1BOd3cLaMWf
        YRAbD4GInefYhF3rL8pyAZkGa4EGDNch9+dg+ZjmGoMgXyCvCbbDhpvNVfaWGxStJsDMTc6MaMD86
        Hi6CJT4Pok+iAxlFHT+9GEoUL95sxaKh+2TfgTJEL9NnMBLpWSmadZyC0E/6sfdo8tTL1+g0uIviP
        COY0IPNuei/HB0iRprHSbjhv+snLKgFQGcnWe/yNr/GsvhcaoNH5RLA8cy8Ruyom9UnuEdLGyydoG
        +IWica3UXkmjgu+kw5GQwgnNrWeMo380r4SQOyxxK6oQQmedob6eEuxVM1BCYARTdaKxqAL9deIXp
        +MEu9pVA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIQt8-0007X7-46; Wed, 16 Sep 2020 06:25:54 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: admin-guide: fix kernel-parameters.txt sort
 order
Message-ID: <d4d114f5-a36b-8cc4-b782-90bbbb01ae47@infradead.org>
Date:   Tue, 15 Sep 2020 23:25:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Sort entries in kernel-parameters.txt roughly into dictionary order.
I know this isn't perfect, but it's a huge improvement.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
When is the best time to merge a patch like this?

This patch depends on
[PATCH] Documentation: kernel-parameters: clarify "module." parameters
from 2020-09-15.

 Documentation/admin-guide/kernel-parameters.txt |  735 +++++++-------
 1 file changed, 368 insertions(+), 367 deletions(-)

--- lnx-59-rc5.orig/Documentation/admin-guide/kernel-parameters.txt
+++ lnx-59-rc5/Documentation/admin-guide/kernel-parameters.txt
@@ -355,21 +355,16 @@
 			      useful so that a dump capture kernel won't be
 			      shot down by NMI
 
-	autoconf=	[IPV6]
-			See Documentation/networking/ipv6.rst.
-
-	show_lapic=	[APIC,X86] Advanced Programmable Interrupt Controller
-			Limit apic dumping. The parameter defines the maximal
-			number of local apics being dumped. Also it is possible
-			to set it to "all" by meaning -- no limit here.
-			Format: { 1 (default) | 2 | ... | all }.
-			The parameter valid if only apic=debug or
-			apic=verbose is specified.
-			Example: apic=debug show_lapic=all
-
 	apm=		[APM] Advanced Power Management
 			See header of arch/x86/kernel/apm_32.c.
 
+	apparmor=	[APPARMOR] Disable or enable AppArmor at boot time
+			Format: { "0" | "1" }
+			See security/apparmor/Kconfig help text
+			0 -- disable.
+			1 -- enable.
+			Default value is set via kernel config option.
+
 	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
 			Format: <io>,<irq>,<nodeID>
 
@@ -410,6 +405,9 @@
 			Format: <int> (must be >=0)
 			Default: 64
 
+	autoconf=	[IPV6]
+			See Documentation/networking/ipv6.rst.
+
 	bau=		[X86_UV] Enable the BAU on SGI UV.  The default
 			behavior is to disable the BAU (i.e. bau=0).
 			Format: { "0" | "1" }
@@ -531,6 +529,20 @@
 
 	cio_ignore=	[S390]
 			See Documentation/s390/common_io.rst for details.
+
+	clearcpuid=BITNUM [X86]
+			Disable CPUID feature X for the kernel. See
+			arch/x86/include/asm/cpufeatures.h for the valid bit
+			numbers. Note the Linux specific bits are not necessarily
+			stable over kernel options, but the vendor specific
+			ones should be.
+			Also note that user programs calling CPUID directly
+			or using the feature without checking anything
+			will still see it. This just prevents it from
+			being used by the kernel or shown in /proc/cpuinfo.
+			Also note the kernel might malfunction if you disable
+			some critical bits.
+
 	clk_ignore_unused
 			[CLK]
 			Prevents the clock framework from automatically gating
@@ -577,19 +589,6 @@
 			loops can be debugged more effectively on production
 			systems.
 
-	clearcpuid=BITNUM [X86]
-			Disable CPUID feature X for the kernel. See
-			arch/x86/include/asm/cpufeatures.h for the valid bit
-			numbers. Note the Linux specific bits are not necessarily
-			stable over kernel options, but the vendor specific
-			ones should be.
-			Also note that user programs calling CPUID directly
-			or using the feature without checking anything
-			will still see it. This just prevents it from
-			being used by the kernel or shown in /proc/cpuinfo.
-			Also note the kernel might malfunction if you disable
-			some critical bits.
-
 	cma=nn[MG]@[start[MG][-end[MG]]]
 			[ARM,X86,KNL]
 			Sets the size of kernel global memory area for
@@ -694,6 +693,24 @@
 			0: default value, disable debugging
 			1: enable debugging at boot time
 
+	cpcihp_generic=	[HW,PCI] Generic port I/O CompactPCI driver
+			Format:
+			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
+
+	cpu0_hotplug	[X86] Turn on CPU0 hotplug feature when
+			CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
+			Some features depend on CPU0. Known dependencies are:
+			1. Resume from suspend/hibernate depends on CPU0.
+			Suspend/hibernate will fail if CPU0 is offline and you
+			need to online CPU0 before suspend/hibernate.
+			2. PIC interrupts also depend on CPU0. CPU0 can't be
+			removed if a PIC interrupt is detected.
+			It's said poweroff/reboot may depend on CPU0 on some
+			machines although I haven't seen such issues so far
+			after CPU0 is offline on a few tested machines.
+			If the dependencies are under your control, you can
+			turn on cpu0_hotplug.
+
 	cpuidle.off=1	[CPU_IDLE]
 			disable the cpuidle sub-system
 
@@ -714,9 +731,13 @@
 			on every CPU online, such as boot, and resume from suspend.
 			Default: 10000
 
-	cpcihp_generic=	[HW,PCI] Generic port I/O CompactPCI driver
-			Format:
-			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
+	crash_kexec_post_notifiers
+			Run kdump after running panic-notifiers and dumping
+			kmsg. This only for the users who doubt kdump always
+			succeeds in any situation.
+			Note that this also increases risks of kdump failure,
+			because some panic notifiers can make the crashed
+			kernel more unstable.
 
 	crashkernel=size[KMG][@offset[KMG]]
 			[KNL] Using kexec, Linux can switch to a 'crash kernel'
@@ -888,42 +909,15 @@
 	dhash_entries=	[KNL]
 			Set number of hash buckets for dentry cache.
 
+	disable=	[IPV6]
+			See Documentation/networking/ipv6.rst.
+
 	disable_1tb_segments [PPC]
 			Disables the use of 1TB hash page table segments. This
 			causes the kernel to fall back to 256MB segments which
 			can be useful when debugging issues that require an SLB
 			miss to occur.
 
-	stress_slb	[PPC]
-			Limits the number of kernel SLB entries, and flushes
-			them frequently to increase the rate of SLB faults
-			on kernel addresses.
-
-	disable=	[IPV6]
-			See Documentation/networking/ipv6.rst.
-
-	hardened_usercopy=
-                        [KNL] Under CONFIG_HARDENED_USERCOPY, whether
-                        hardening is enabled for this boot. Hardened
-                        usercopy checking is used to protect the kernel
-                        from reading or writing beyond known memory
-                        allocation boundaries as a proactive defense
-                        against bounds-checking flaws in the kernel's
-                        copy_to_user()/copy_from_user() interface.
-                on      Perform hardened usercopy checks (default).
-                off     Disable hardened usercopy checks.
-
-	disable_radix	[PPC]
-			Disable RADIX MMU mode on POWER9
-
-	radix_hcall_invalidate=on  [PPC/PSERIES]
-			Disable RADIX GTSE feature and use hcall for TLB
-			invalidate.
-
-	disable_tlbie	[PPC]
-			Disable TLBIE instruction. Currently does not work
-			with KVM, with HASH MMU, or with coherent accelerators.
-
 	disable_cpu_apicid= [X86,APIC,SMP]
 			Format: <int>
 			The number of initial APIC ID for the
@@ -933,16 +927,21 @@
 			causing system reset or hang due to sending
 			INIT from AP to BSP.
 
-	perf_v4_pmi=	[X86,INTEL]
-			Format: <bool>
-			Disable Intel PMU counter freezing feature.
-			The feature only exists starting from
-			Arch Perfmon v4 (Skylake and newer).
-
 	disable_ddw	[PPC/PSERIES]
 			Disable Dynamic DMA Window support. Use this if
 			to workaround buggy firmware.
 
+	disable_radix	[PPC]
+			Disable RADIX MMU mode on POWER9
+
+	radix_hcall_invalidate=on  [PPC/PSERIES]
+			Disable RADIX GTSE feature and use hcall for TLB
+			invalidate.
+
+	disable_tlbie	[PPC]
+			Disable TLBIE instruction. Currently does not work
+			with KVM, with HASH MMU, or with coherent accelerators.
+
 	disable_ipv6=	[IPV6]
 			See Documentation/networking/ipv6.rst.
 
@@ -1024,12 +1023,6 @@
 			Documentation/admin-guide/dynamic-debug-howto.rst
 			for details.
 
-	nopku		[X86] Disable Memory Protection Keys CPU feature found
-			in some Intel CPUs.
-
-	<module>.async_probe [KNL]
-			Enable asynchronous probe on this module.
-
 	early_ioremap_debug [KNL]
 			Enable debug messages in early_ioremap support. This
 			is useful for tracking down temporary early mappings
@@ -1216,17 +1209,6 @@
 			force: enforce the use of EDAC to report H/W event.
 			default: on.
 
-	ekgdboc=	[X86,KGDB] Allow early kernel console debugging
-			ekgdboc=kbd
-
-			This is designed to be used in conjunction with
-			the boot argument: earlyprintk=vga
-
-			This parameter works in place of the kgdboc parameter
-			but can only be used if the backing tty is available
-			very early in the boot process. For early debugging
-			via a serial port see kgdboc_earlycon instead.
-
 	edd=		[EDD]
 			Format: {"off" | "on" | "skip[mbr]"}
 
@@ -1288,6 +1270,17 @@
 	eisa_irq_edge=	[PARISC,HW]
 			See header of drivers/parisc/eisa.c.
 
+	ekgdboc=	[X86,KGDB] Allow early kernel console debugging
+			ekgdboc=kbd
+
+			This is designed to be used in conjunction with
+			the boot argument: earlyprintk=vga
+
+			This parameter works in place of the kgdboc parameter
+			but can only be used if the backing tty is available
+			very early in the boot process. For early debugging
+			via a serial port see kgdboc_earlycon instead.
+
 	elanfreq=	[X86-32]
 			See comment before function elanfreq_setup() in
 			arch/x86/kernel/cpu/cpufreq/elanfreq.c.
@@ -1438,6 +1431,10 @@
 			Don't use this when you are not running on the
 			android emulator
 
+	gpio-mockup.gpio_mockup_ranges
+			[HW] Sets the ranges of gpiochip of for this device.
+			Format: <start1>,<end1>,<start2>,<end2>...
+
 	gpt		[EFI] Forces disk with valid GPT signature but
 			invalid Protective MBR to be treated as GPT. If the
 			primary GPT is corrupted, it enables the backup/alternate
@@ -1461,9 +1458,16 @@
 			Format: <unsigned int> such that (rxsize & ~0x1fffc0) == 0.
 			Default: 1024
 
-	gpio-mockup.gpio_mockup_ranges
-			[HW] Sets the ranges of gpiochip of for this device.
-			Format: <start1>,<end1>,<start2>,<end2>...
+	hardened_usercopy=
+                        [KNL] Under CONFIG_HARDENED_USERCOPY, whether
+                        hardening is enabled for this boot. Hardened
+                        usercopy checking is used to protect the kernel
+                        from reading or writing beyond known memory
+                        allocation boundaries as a proactive defense
+                        against bounds-checking flaws in the kernel's
+                        copy_to_user()/copy_from_user() interface.
+                on      Perform hardened usercopy checks (default).
+                off     Disable hardened usercopy checks.
 
 	hardlockup_all_cpu_backtrace=
 			[KNL] Should the hard-lockup detector generate
@@ -1485,6 +1489,15 @@
 			corresponding firmware-first mode error processing
 			logic will be disabled.
 
+	hibernate=	[HIBERNATION]
+		noresume	Don't check if there's a hibernation image
+				present during boot.
+		nocompress	Don't compress/decompress hibernation images.
+		no		Disable hibernation and resume.
+		protect_image	Turn on image protection during restoration
+				(that will set all pages holding image data
+				during restoration read-only).
+
 	highmem=nn[KMG]	[KNL,BOOT] forces the highmem zone to have an exact
 			size of <nn>. This works even on boxes that have no
 			highmem otherwise. This also works to reduce highmem
@@ -1507,14 +1520,6 @@
 	hpet_mmap=	[X86, HPET_MMAP] Allow userspace to mmap HPET
 			registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
 
-	hugetlb_cma=	[HW] The size of a cma area used for allocation
-			of gigantic hugepages.
-			Format: nn[KMGTPE]
-
-			Reserve a cma area of given size and allocate gigantic
-			hugepages using the cma allocator. If enabled, the
-			boot-time allocation of gigantic hugepages is skipped.
-
 	hugepages=	[HW] Number of HugeTLB pages to allocate at boot.
 			If this follows hugepagesz (below), it specifies
 			the number of pages of hugepagesz to be allocated.
@@ -1534,6 +1539,14 @@
 			Documentation/admin-guide/mm/hugetlbpage.rst.
 			Format: size[KMG]
 
+	hugetlb_cma=	[HW] The size of a cma area used for allocation
+			of gigantic hugepages.
+			Format: nn[KMGTPE]
+
+			Reserve a cma area of given size and allocate gigantic
+			hugepages using the cma allocator. If enabled, the
+			boot-time allocation of gigantic hugepages is skipped.
+
 	hung_task_panic=
 			[KNL] Should the hung task detector generate panics.
 			Format: 0 | 1
@@ -1554,12 +1567,6 @@
 				      which allow the hypervisor to 'idle' the
 				      guest on lock contention.
 
-	keep_bootcon	[KNL]
-			Do not unregister boot console at start. This is only
-			useful for debugging when something happens in the window
-			between unregistering the boot console and initializing
-			the real console.
-
 	i2c_bus=	[HW]	Override the default board specific I2C bus speed
 				or register an additional I2C bus that is not
 				registered from board initialization code.
@@ -1826,6 +1833,10 @@
 			0 -- basic integrity auditing messages. (Default)
 			1 -- additional integrity auditing messages.
 
+	intel_idle.max_cstate=	[KNL,HW,ACPI,X86]
+			0	disables intel_idle and fall back on acpi_idle.
+			1 to 9	specify maximum depth of C-state.
+
 	intel_iommu=	[DMAR] Intel IOMMU driver (DMAR) option
 		on
 			Enable intel iommu driver.
@@ -1872,10 +1883,6 @@
 			devices as the trusted ones, hence might expose security
 			risks of DMA attacks.
 
-	intel_idle.max_cstate=	[KNL,HW,ACPI,X86]
-			0	disables intel_idle and fall back on acpi_idle.
-			1 to 9	specify maximum depth of C-state.
-
 	intel_pstate=	[X86]
 			disable
 			  Do not enable intel_pstate as the default
@@ -2100,17 +2107,18 @@
 	js=		[HW,JOY] Analog joystick
 			See Documentation/input/joydev/joystick.rst.
 
-	nokaslr		[KNL]
-			When CONFIG_RANDOMIZE_BASE is set, this disables
-			kernel and module base offset ASLR (Address Space
-			Layout Randomization).
-
 	kasan_multi_shot
 			[KNL] Enforce KASAN (Kernel Address Sanitizer) to print
 			report on every invalid memory access. Without this
 			parameter KASAN will print report only for the first
 			invalid access.
 
+	keep_bootcon	[KNL]
+			Do not unregister boot console at start. This is only
+			useful for debugging when something happens in the window
+			between unregistering the boot console and initializing
+			the real console.
+
 	keepinitrd	[HW,ARM]
 
 	kernelcore=	[KNL,X86,IA-64,PPC]
@@ -2439,8 +2447,6 @@
 			If there are multiple matching configurations changing
 			the same attribute, the last one is used.
 
-	memblock=debug	[KNL] Enable memblock debug messages.
-
 	load_ramdisk=	[RAM] List of ramdisks to load from floppy
 			See Documentation/admin-guide/blockdev/ramdisk.rst.
 
@@ -2575,14 +2581,14 @@
 			[SECURITY] Choose order of LSM initialization. This
 			overrides CONFIG_LSM, and the "security=" parameter.
 
-	machvec=	[IA-64] Force the use of a particular machine-vector
-			(machvec) in a generic kernel.
-			Example: machvec=hpzx1
-
 	machtype=	[Loongson] Share the same kernel image file between different
 			 yeeloong laptop.
 			Example: machtype=lemote-yeeloong-2f-7inch
 
+	machvec=	[IA-64] Force the use of a particular machine-vector
+			(machvec) in a generic kernel.
+			Example: machvec=hpzx1
+
 	max_addr=nn[KMG]	[KNL,BOOT,ia64] All physical memory greater
 			than or equal to this physical address is ignored.
 
@@ -2665,6 +2671,8 @@
 	mem=nopentium	[BUGS=X86-32] Disable usage of 4MB pages for kernel
 			memory.
 
+	memblock=debug	[KNL] Enable memblock debug messages.
+
 	memchunk=nn[KMG]
 			[KNL,SH] Allow user to override the default size for
 			per-device physically contiguous DMA buffers.
@@ -2863,6 +2871,9 @@
 			log everything. Information is printed at KERN_DEBUG
 			so loglevel=8 may also need to be specified.
 
+	<module>.async_probe [KNL]
+			Enable asynchronous probe on this module.
+
 	module.sig_enforce
 			[KNL] When CONFIG_MODULE_SIG is set, this means that
 			modules without (valid) signatures will fail to load.
@@ -2909,20 +2920,6 @@
 	mtdparts=	[MTD]
 			See drivers/mtd/parsers/cmdlinepart.c
 
-	multitce=off	[PPC]  This parameter disables the use of the pSeries
-			firmware feature for updating multiple TCE entries
-			at a time.
-
-	onenand.bdry=	[HW,MTD] Flex-OneNAND Boundary Configuration
-
-			Format: [die0_boundary][,die0_lock][,die1_boundary][,die1_lock]
-
-			boundary - index of last SLC block on Flex-OneNAND.
-				   The remaining blocks are configured as MLC blocks.
-			lock	 - Configure if Flex-OneNAND boundary should be locked.
-				   Once locked, the boundary cannot be changed.
-				   1 indicates lock status, 0 indicates unlock status.
-
 	mtdset=		[ARM]
 			ARM/S3C2412 JIVE boot control
 
@@ -2949,6 +2946,10 @@
 			Used for mtrr cleanup. It is spare mtrr entries number.
 			Set to 2 or more if your graphical card needs more.
 
+	multitce=off	[PPC]  This parameter disables the use of the pSeries
+			firmware feature for updating multiple TCE entries
+			at a time.
+
 	n2=		[NET] SDL Inc. RISCom/N2 synchronous serial card
 
 	netdev=		[NET] Network devices parameters
@@ -2958,6 +2959,11 @@
 			This usage is only documented in each driver source
 			file if at all.
 
+	netpoll.carrier_timeout=
+			[NET] Specifies amount of time (in seconds) that
+			netpoll should wait for a carrier. By default netpoll
+			waits 4 seconds.
+
 	nf_conntrack.acct=
 			[NETFILTER] Enable connection tracking flow accounting
 			0 to disable accounting
@@ -3090,11 +3096,6 @@
 			These settings can be accessed at runtime via
 			the nmi_watchdog and hardlockup_panic sysctls.
 
-	netpoll.carrier_timeout=
-			[NET] Specifies amount of time (in seconds) that
-			netpoll should wait for a carrier. By default netpoll
-			waits 4 seconds.
-
 	no387		[BUGS=X86-32] Tells the kernel to use the 387 maths
 			emulation library even if a 387 maths coprocessor
 			is present.
@@ -3102,7 +3103,22 @@
 	no5lvl		[X86-64] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
 
-	nofsgsbase	[X86] Disables FSGSBASE instructions.
+	no-kvmapf	[X86,KVM] Disable paravirtualized asynchronous page
+			fault handling.
+
+	no-kvmclock	[X86,KVM] Disable paravirtualized KVM clock driver
+
+	no-scroll	[VGA] Disables scrollback.
+			This is required for the Braillex ib80-piezo Braille
+			reader made by F.H. Papenmeier (Germany).
+
+	no-steal-acc	[X86,PV_OPS,ARM64] Disable paravirtualized steal time
+			accounting. steal time is computed, but won't
+			influence scheduler behaviour
+
+	no-vmw-sched-clock
+			[X86,PV_OPS] Disable paravirtualized VMware scheduler
+			clock and use the default one.
 
 	no_console_suspend
 			[HW] Never suspend the console
@@ -3119,16 +3135,12 @@
 			/sys/module/printk/parameters/console_suspend) to
 			turn on/off it dynamically.
 
-	novmcoredd	[KNL,KDUMP]
-			Disable device dump. Device dump allows drivers to
-			append dump data to vmcore so you can collect driver
-			specified debug info.  Drivers can append the data
-			without any limit and this data is stored in memory,
-			so this may cause significant memory stress.  Disabling
-			device dump can help save memory but the driver debug
-			data will be no longer available.  This parameter
-			is only available when CONFIG_PROC_VMCORE_DEVICE_DUMP
-			is set.
+	no_file_caps	Tells the kernel not to honor file capabilities.  The
+			only way then for a file to be executed with privilege
+			is to be setuid root or executed by root.
+
+	no_timer_check	[X86,APIC] Disables the code which tests for
+			broken timer IRQ sources.
 
 	noaliencache	[MM, NUMA, SLAB] Disables the allocation of alien
 			caches in the slab allocator.  Saves per-node memory,
@@ -3164,14 +3176,6 @@
 			noexec=on: enable non-executable mappings (default)
 			noexec=off: disable non-executable mappings
 
-	nosmap		[X86,PPC]
-			Disable SMAP (Supervisor Mode Access Prevention)
-			even if it is supported by processor.
-
-	nosmep		[X86,PPC]
-			Disable SMEP (Supervisor Mode Execution Prevention)
-			even if it is supported by processor.
-
 	noexec32	[X86-64]
 			This affects only 32-bit executables.
 			noexec32=on: enable non-executable mappings (default)
@@ -3179,60 +3183,14 @@
 			noexec32=off: disable non-executable mappings
 				read implies executable mappings
 
+	nofsgsbase	[X86] Disables FSGSBASE instructions.
+
 	nofpu		[MIPS,SH] Disable hardware FPU at boot time.
 
 	nofxsr		[BUGS=X86-32] Disables x86 floating point extended
 			register save and restore. The kernel will only save
 			legacy floating-point registers on task switch.
 
-	nohugeiomap	[KNL,X86,PPC] Disable kernel huge I/O mappings.
-
-	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
-			Equivalent to smt=1.
-
-			[KNL,X86] Disable symmetric multithreading (SMT).
-			nosmt=force: Force disable SMT, cannot be undone
-				     via the sysfs control file.
-
-	nospectre_v1	[X86,PPC] Disable mitigations for Spectre Variant 1
-			(bounds check bypass). With this option data leaks are
-			possible in the system.
-
-	nospectre_v2	[X86,PPC_FSL_BOOK3E,ARM64] Disable all mitigations for
-			the Spectre variant 2 (indirect branch prediction)
-			vulnerability. System may allow data leaks with this
-			option.
-
-	nospec_store_bypass_disable
-			[HW] Disable all mitigations for the Speculative Store Bypass vulnerability
-
-	noxsave		[BUGS=X86] Disables x86 extended register state save
-			and restore using xsave. The kernel will fallback to
-			enabling legacy floating-point and sse state.
-
-	noxsaveopt	[X86] Disables xsaveopt used in saving x86 extended
-			register states. The kernel will fall back to use
-			xsave to save the states. By using this parameter,
-			performance of saving the states is degraded because
-			xsave doesn't support modified optimization while
-			xsaveopt supports it on xsaveopt enabled systems.
-
-	noxsaves	[X86] Disables xsaves and xrstors used in saving and
-			restoring x86 extended register state in compacted
-			form of xsave area. The kernel will fall back to use
-			xsaveopt and xrstor to save and restore the states
-			in standard form of xsave area. By using this
-			parameter, xsave area per process might occupy more
-			memory on xsaves enabled systems.
-
-	nohlt		[BUGS=ARM,SH] Tells the kernel that the sleep(SH) or
-			wfi(ARM) instruction doesn't work correctly and not to
-			use it. This is also useful when using JTAG debugger.
-
-	no_file_caps	Tells the kernel not to honor file capabilities.  The
-			only way then for a file to be executed with privilege
-			is to be setuid root or executed by root.
-
 	nohalt		[IA-64] Tells the kernel not to use the power saving
 			function PAL_HALT_LIGHT when idle. This increases
 			power-consumption. On the positive side, it reduces
@@ -3242,6 +3200,12 @@
 
 	nohibernate	[HIBERNATION] Disable hibernation and resume.
 
+	nohlt		[BUGS=ARM,SH] Tells the kernel that the sleep(SH) or
+			wfi(ARM) instruction doesn't work correctly and not to
+			use it. This is also useful when using JTAG debugger.
+
+	nohugeiomap	[KNL,X86,PPC] Disable kernel huge I/O mappings.
+
 	nohz=		[KNL] Boottime enable/disable dynamic ticks
 			Valid arguments: on, off
 			Default: on
@@ -3261,9 +3225,6 @@
 	noirqdebug	[X86-32] Disables the code which attempts to detect and
 			disable unhandled interrupt sources.
 
-	no_timer_check	[X86,APIC] Disables the code which tests for
-			broken timer IRQ sources.
-
 	noisapnp	[ISAPNP] Disables ISA PnP code.
 
 	noinitrd	[RAM] Tells the kernel not to load any configured
@@ -3279,18 +3240,10 @@
 
 	nojitter	[IA-64] Disables jitter checking for ITC timers.
 
-	no-kvmclock	[X86,KVM] Disable paravirtualized KVM clock driver
-
-	no-kvmapf	[X86,KVM] Disable paravirtualized asynchronous page
-			fault handling.
-
-	no-vmw-sched-clock
-			[X86,PV_OPS] Disable paravirtualized VMware scheduler
-			clock and use the default one.
-
-	no-steal-acc	[X86,PV_OPS,ARM64] Disable paravirtualized steal time
-			accounting. steal time is computed, but won't
-			influence scheduler behaviour
+	nokaslr		[KNL]
+			When CONFIG_RANDOMIZE_BASE is set, this disables
+			kernel and module base offset ASLR (Address Space
+			Layout Randomization).
 
 	nolapic		[X86-32,APIC] Do not enable or use the local APIC.
 
@@ -3306,46 +3259,93 @@
 	nomfgpt		[X86-32] Disable Multi-Function General Purpose
 			Timer usage (for AMD Geode machines).
 
+	nomodule	Disable module load
+
 	nonmi_ipi	[X86] Disable using NMI IPIs during panic/reboot to
 			shutdown the other cpus.  Instead use the REBOOT_VECTOR
 			irq.
 
-	nomodule	Disable module load
-
 	nopat		[X86] Disable PAT (page attribute table extension of
 			pagetables) support.
 
 	nopcid		[X86-64] Disable the PCID cpu feature.
 
+	nopku		[X86] Disable Memory Protection Keys CPU feature found
+			in some Intel CPUs.
+
+	nopv=		[X86,XEN,KVM,HYPER_V,VMWARE]
+			Disables the PV optimizations forcing the guest to run
+			as generic guest with no PV drivers. Currently support
+			XEN HVM, KVM, HYPER_V and VMWARE guest.
+
+	nopvspin	[X86,XEN,KVM]
+			Disables the qspinlock slow path using PV optimizations
+			which allow the hypervisor to 'idle' the guest on lock
+			contention.
+
 	norandmaps	Don't use address space randomization.  Equivalent to
 			echo 0 > /proc/sys/kernel/randomize_va_space
 
-	noreplace-smp	[X86-32,SMP] Don't replace SMP instructions
-			with UP alternatives
-
 	nordrand	[X86] Disable kernel use of the RDRAND and
 			RDSEED instructions even if they are supported
 			by the processor.  RDRAND and RDSEED are still
 			available to user space applications.
 
+	noreplace-smp	[X86-32,SMP] Don't replace SMP instructions
+			with UP alternatives
+
 	noresume	[SWSUSP] Disables resume and restores original swap
 			space.
 
-	no-scroll	[VGA] Disables scrollback.
-			This is required for the Braillex ib80-piezo Braille
-			reader made by F.H. Papenmeier (Germany).
-
 	nosbagart	[IA-64]
 
 	nosep		[BUGS=X86-32] Disables x86 SYSENTER/SYSEXIT support.
 
+	nosmap		[X86,PPC]
+			Disable SMAP (Supervisor Mode Access Prevention)
+			even if it is supported by processor.
+
+	nosmep		[X86,PPC]
+			Disable SMEP (Supervisor Mode Execution Prevention)
+			even if it is supported by processor.
+
 	nosmp		[SMP] Tells an SMP kernel to act as a UP kernel,
 			and disable the IO APIC.  legacy for "maxcpus=0".
 
+	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
+			Equivalent to smt=1.
+
+			[KNL,X86] Disable symmetric multithreading (SMT).
+			nosmt=force: Force disable SMT, cannot be undone
+				     via the sysfs control file.
+
 	nosoftlockup	[KNL] Disable the soft-lockup detector.
 
+	nospectre_v1	[X86,PPC] Disable mitigations for Spectre Variant 1
+			(bounds check bypass). With this option data leaks are
+			possible in the system.
+
+	nospectre_v2	[X86,PPC_FSL_BOOK3E,ARM64] Disable all mitigations for
+			the Spectre variant 2 (indirect branch prediction)
+			vulnerability. System may allow data leaks with this
+			option.
+
+	nospec_store_bypass_disable
+			[HW] Disable all mitigations for the Speculative Store Bypass vulnerability
+
 	nosync		[HW,M68K] Disables sync negotiation for all devices.
 
+	novmcoredd	[KNL,KDUMP]
+			Disable device dump. Device dump allows drivers to
+			append dump data to vmcore so you can collect driver
+			specified debug info.  Drivers can append the data
+			without any limit and this data is stored in memory,
+			so this may cause significant memory stress.  Disabling
+			device dump can help save memory but the driver debug
+			data will be no longer available.  This parameter
+			is only available when CONFIG_PROC_VMCORE_DEVICE_DUMP
+			is set.
+
 	nowatchdog	[KNL] Disable both lockup detectors, i.e.
 			soft-lockup and NMI watchdog (hard-lockup).
 
@@ -3353,19 +3353,24 @@
 
 	nox2apic	[X86-64,APIC] Do not enable x2APIC mode.
 
-	cpu0_hotplug	[X86] Turn on CPU0 hotplug feature when
-			CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
-			Some features depend on CPU0. Known dependencies are:
-			1. Resume from suspend/hibernate depends on CPU0.
-			Suspend/hibernate will fail if CPU0 is offline and you
-			need to online CPU0 before suspend/hibernate.
-			2. PIC interrupts also depend on CPU0. CPU0 can't be
-			removed if a PIC interrupt is detected.
-			It's said poweroff/reboot may depend on CPU0 on some
-			machines although I haven't seen such issues so far
-			after CPU0 is offline on a few tested machines.
-			If the dependencies are under your control, you can
-			turn on cpu0_hotplug.
+	noxsave		[BUGS=X86] Disables x86 extended register state save
+			and restore using xsave. The kernel will fallback to
+			enabling legacy floating-point and sse state.
+
+	noxsaveopt	[X86] Disables xsaveopt used in saving x86 extended
+			register states. The kernel will fall back to use
+			xsave to save the states. By using this parameter,
+			performance of saving the states is degraded because
+			xsave doesn't support modified optimization while
+			xsaveopt supports it on xsaveopt enabled systems.
+
+	noxsaves	[X86] Disables xsaves and xrstors used in saving and
+			restoring x86 extended register state in compacted
+			form of xsave area. The kernel will fall back to use
+			xsaveopt and xrstor to save and restore the states
+			in standard form of xsave area. By using this
+			parameter, xsave area per process might occupy more
+			memory on xsaves enabled systems.
 
 	nps_mtm_hs_ctr=	[KNL,ARC]
 			This parameter sets the maximum duration, in
@@ -3415,8 +3420,15 @@
 			For example, to override I2C bus2:
 			omap_mux=i2c2_scl.i2c2_scl=0x100,i2c2_sda.i2c2_sda=0x100
 
-	oprofile.timer=	[HW]
-			Use timer interrupt instead of performance counters
+	onenand.bdry=	[HW,MTD] Flex-OneNAND Boundary Configuration
+
+			Format: [die0_boundary][,die0_lock][,die1_boundary][,die1_lock]
+
+			boundary - index of last SLC block on Flex-OneNAND.
+				   The remaining blocks are configured as MLC blocks.
+			lock	 - Configure if Flex-OneNAND boundary should be locked.
+				   Once locked, the boundary cannot be changed.
+				   1 indicates lock status, 0 indicates unlock status.
 
 	oprofile.cpu_type=	Force an oprofile cpu type
 			This might be useful if you have an older oprofile
@@ -3429,6 +3441,9 @@
 				timer mode (see also oprofile.timer
 				for generic hr timer mode)
 
+	oprofile.timer=	[HW]
+			Use timer interrupt instead of performance counters
+
 	oops=panic	Always panic on oopses. Default is to just kill the
 			process, but there is a small probability of
 			deadlocking the machine.
@@ -3488,14 +3503,6 @@
 	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
 			on a WARN().
 
-	crash_kexec_post_notifiers
-			Run kdump after running panic-notifiers and dumping
-			kmsg. This only for the users who doubt kdump always
-			succeeds in any situation.
-			Note that this also increases risks of kdump failure,
-			because some panic notifiers can make the crashed
-			kernel more unstable.
-
 	parkbd.port=	[HW] Parallel port number the keyboard adapter is
 			connected to, default is 0.
 			Format: <parport#>
@@ -3782,6 +3789,9 @@
 
 	pcmv=		[HW,PCMCIA] BadgePAD 4
 
+	pd.		[PARIDE]
+			See Documentation/admin-guide/blockdev/paride.rst.
+
 	pd_ignore_unused
 			[PM]
 			Keep all power-domains already enabled by bootloader on,
@@ -3789,9 +3799,6 @@
 			for debug and development, but should not be
 			needed on a platform with proper driver support.
 
-	pd.		[PARIDE]
-			See Documentation/admin-guide/blockdev/paride.rst.
-
 	pdcchassis=	[PARISC,HW] Disable/Enable PDC Chassis Status codes at
 			boot time.
 			Format: { 0 | 1 }
@@ -3804,6 +3811,12 @@
 			allocator.  This parameter is primarily	for debugging
 			and performance comparison.
 
+	perf_v4_pmi=	[X86,INTEL]
+			Format: <bool>
+			Disable Intel PMU counter freezing feature.
+			The feature only exists starting from
+			Arch Perfmon v4 (Skylake and newer).
+
 	pf.		[PARIDE]
 			See Documentation/admin-guide/blockdev/paride.rst.
 
@@ -3817,13 +3830,13 @@
 			Format: { parport<nr> | timid | 0 }
 			See also Documentation/admin-guide/parport.rst.
 
+	pm_debug_messages	[SUSPEND,KNL]
+			Enable suspend/resume debug messages during boot up.
+
 	pmtmr=		[X86] Manual setup of pmtmr I/O Port.
 			Override pmtimer IOPort with a hex value.
 			e.g. pmtmr=0x508
 
-	pm_debug_messages	[SUSPEND,KNL]
-			Enable suspend/resume debug messages during boot up.
-
 	pnp.debug=1	[PNP]
 			Enable PNP debug messages (depends on the
 			CONFIG_PNP_DEBUG_MESSAGES option).  Change at run-time
@@ -3831,12 +3844,6 @@
 			current resource usage; turning this on also shows
 			possible settings and some assignment information.
 
-	pnpacpi=	[ACPI]
-			{ off }
-
-	pnpbios=	[ISAPNP]
-			{ on | off | curr | res | no-curr | no-res }
-
 	pnp_reserve_irq=
 			[ISAPNP] Exclude IRQs for the autoconfiguration
 
@@ -3851,6 +3858,12 @@
 			autoconfiguration.
 			Ranges are in pairs (memory base and size).
 
+	pnpacpi=	[ACPI]
+			{ off }
+
+	pnpbios=	[ISAPNP]
+			{ on | off | curr | res | no-curr | no-res }
+
 	ports=		[IP_VS_FTP] IPVS ftp helper module
 			Default is 21.
 			Up to 8 (IP_VS_APP_MAX_PORTS) ports
@@ -4503,16 +4516,16 @@
 			them.  If <base> is less than 0x10000, the region
 			is assumed to be I/O ports; otherwise it is memory.
 
-	reservetop=	[X86-32]
-			Format: nn[KMG]
-			Reserves a hole at the top of the kernel virtual
-			address space.
-
 	reservelow=	[X86]
 			Format: nn[K]
 			Set the amount of memory to reserve for BIOS at
 			the bottom of the address space.
 
+	reservetop=	[X86-32]
+			Format: nn[KMG]
+			Reserves a hole at the top of the kernel virtual
+			address space.
+
 	reset_devices	[KNL] Force drivers to reset the underlying device
 			during initialization.
 
@@ -4534,15 +4547,6 @@
 			Useful for devices that are detected asynchronously
 			(e.g. USB and MMC devices).
 
-	hibernate=	[HIBERNATION]
-		noresume	Don't check if there's a hibernation image
-				present during boot.
-		nocompress	Don't compress/decompress hibernation images.
-		no		Disable hibernation and resume.
-		protect_image	Turn on image protection during restoration
-				(that will set all pages holding image data
-				during restoration read-only).
-
 	retain_initrd	[RAM] Keep initrd memory after extraction
 
 	rfkill.default_state=
@@ -4566,16 +4570,16 @@
 
 	ro		[KNL] Mount root device read-only on boot
 
-	rodata=		[KNL]
-		on	Mark read-only kernel memory as read-only (default).
-		off	Leave read-only kernel memory writable for debugging.
-
 	rockchip.usb_uart
 			Enable the uart passthrough on the designated usb port
 			on Rockchip SoCs. When active, the signals of the
 			debug-uart get routed to the D+ and D- pins of the usb
 			port and the regular usb controller gets disabled.
 
+	rodata=		[KNL]
+		on	Mark read-only kernel memory as read-only (default).
+		off	Leave read-only kernel memory writable for debugging.
+
 	root=		[KNL] Root filesystem
 			See name_to_dev_t comment in init/do_mounts.c.
 
@@ -4634,15 +4638,6 @@
 			Format: integer between 0 and 10
 			Default is 0.
 
-	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
-			xtime_lock contention on larger systems, and/or RCU lock
-			contention on all systems with CONFIG_MAXSMP set.
-			Format: { "0" | "1" }
-			0 -- disable. (may be 1 via CONFIG_CMDLINE="skew_tick=1"
-			1 -- enable.
-			Note: increases power consumption, thus should only be
-			enabled if running jitter sensitive (HPC/RT) workloads.
-
 	security=	[SECURITY] Choose a legacy "major" security module to
 			enable at boot. This has been deprecated by the
 			"lsm=" parameter.
@@ -4654,22 +4649,31 @@
 			1 -- enable.
 			Default value is 1.
 
-	apparmor=	[APPARMOR] Disable or enable AppArmor at boot time
-			Format: { "0" | "1" }
-			See security/apparmor/Kconfig help text
-			0 -- disable.
-			1 -- enable.
-			Default value is set via kernel config option.
-
 	serialnumber	[BUGS=X86-32]
 
 	shapers=	[NET]
 			Maximal number of shapers.
 
+	show_lapic=	[APIC,X86] Advanced Programmable Interrupt Controller
+			Limit apic dumping. The parameter defines the maximal
+			number of local apics being dumped. Also it is possible
+			to set it to "all" by meaning -- no limit here.
+			Format: { 1 (default) | 2 | ... | all }.
+			The parameter valid if only apic=debug or
+			apic=verbose is specified.
+			Example: apic=debug show_lapic=all
+
 	simeth=		[IA-64]
 	simscsi=
 
-	slram=		[HW,MTD]
+	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
+			xtime_lock contention on larger systems, and/or RCU lock
+			contention on all systems with CONFIG_MAXSMP set.
+			Format: { "0" | "1" }
+			0 -- disable. (may be 1 via CONFIG_CMDLINE="skew_tick=1"
+			1 -- enable.
+			Note: increases power consumption, thus should only be
+			enabled if running jitter sensitive (HPC/RT) workloads.
 
 	slab_nomerge	[MM]
 			Disable merging of slabs with similar size. May be
@@ -4730,6 +4734,8 @@
 			Same with slab_nomerge. This is supported for legacy.
 			See slab_nomerge for more information.
 
+	slram=		[HW,MTD]
+
 	smart2=		[HW]
 			Format: <io1>[,<io2>[,...,<io8>]]
 
@@ -4751,6 +4757,11 @@
 			Format: <integer>
 			Default: -1 (no limit)
 
+	softlockup_all_cpu_backtrace=
+			[KNL] Should the soft-lockup detector generate
+			backtraces on all cpus.
+			Format: 0 | 1
+
 	softlockup_panic=
 			[KNL] Should the soft-lockup detector generate panics.
 			Format: 0 | 1
@@ -4761,14 +4772,61 @@
 			and CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC, which is the
 			respective build-time switch to that functionality.
 
-	softlockup_all_cpu_backtrace=
-			[KNL] Should the soft-lockup detector generate
-			backtraces on all cpus.
-			Format: 0 | 1
-
 	sonypi.*=	[HW] Sony Programmable I/O Control Device driver
 			See Documentation/admin-guide/laptops/sonypi.rst
 
+	spec_store_bypass_disable=
+			[HW] Control Speculative Store Bypass (SSB) Disable mitigation
+			(Speculative Store Bypass vulnerability)
+
+			Certain CPUs are vulnerable to an exploit against a
+			a common industry wide performance optimization known
+			as "Speculative Store Bypass" in which recent stores
+			to the same memory location may not be observed by
+			later loads during speculative execution. The idea
+			is that such stores are unlikely and that they can
+			be detected prior to instruction retirement at the
+			end of a particular speculation execution window.
+
+			In vulnerable processors, the speculatively forwarded
+			store can be used in a cache side channel attack, for
+			example to read memory to which the attacker does not
+			directly have access (e.g. inside sandboxed code).
+
+			This parameter controls whether the Speculative Store
+			Bypass optimization is used.
+
+			On x86 the options are:
+
+			on      - Unconditionally disable Speculative Store Bypass
+			off     - Unconditionally enable Speculative Store Bypass
+			auto    - Kernel detects whether the CPU model contains an
+				  implementation of Speculative Store Bypass and
+				  picks the most appropriate mitigation. If the
+				  CPU is not vulnerable, "off" is selected. If the
+				  CPU is vulnerable the default mitigation is
+				  architecture and Kconfig dependent. See below.
+			prctl   - Control Speculative Store Bypass per thread
+				  via prctl. Speculative Store Bypass is enabled
+				  for a process by default. The state of the control
+				  is inherited on fork.
+			seccomp - Same as "prctl" above, but all seccomp threads
+				  will disable SSB unless they explicitly opt out.
+
+			Default mitigations:
+			X86:	If CONFIG_SECCOMP=y "seccomp", otherwise "prctl"
+
+			On powerpc the options are:
+
+			on,auto - On Power8 and Power9 insert a store-forwarding
+				  barrier on kernel entry and exit. On Power7
+				  perform a software flush on kernel entry and
+				  exit.
+			off	- No action.
+
+			Not specifying this option is equivalent to
+			spec_store_bypass_disable=auto.
+
 	spectre_v2=	[X86] Control mitigation of Spectre variant 2
 			(indirect branch speculation) vulnerability.
 			The default operation protects the kernel from
@@ -4844,58 +4902,6 @@
 			Not specifying this option is equivalent to
 			spectre_v2_user=auto.
 
-	spec_store_bypass_disable=
-			[HW] Control Speculative Store Bypass (SSB) Disable mitigation
-			(Speculative Store Bypass vulnerability)
-
-			Certain CPUs are vulnerable to an exploit against a
-			a common industry wide performance optimization known
-			as "Speculative Store Bypass" in which recent stores
-			to the same memory location may not be observed by
-			later loads during speculative execution. The idea
-			is that such stores are unlikely and that they can
-			be detected prior to instruction retirement at the
-			end of a particular speculation execution window.
-
-			In vulnerable processors, the speculatively forwarded
-			store can be used in a cache side channel attack, for
-			example to read memory to which the attacker does not
-			directly have access (e.g. inside sandboxed code).
-
-			This parameter controls whether the Speculative Store
-			Bypass optimization is used.
-
-			On x86 the options are:
-
-			on      - Unconditionally disable Speculative Store Bypass
-			off     - Unconditionally enable Speculative Store Bypass
-			auto    - Kernel detects whether the CPU model contains an
-				  implementation of Speculative Store Bypass and
-				  picks the most appropriate mitigation. If the
-				  CPU is not vulnerable, "off" is selected. If the
-				  CPU is vulnerable the default mitigation is
-				  architecture and Kconfig dependent. See below.
-			prctl   - Control Speculative Store Bypass per thread
-				  via prctl. Speculative Store Bypass is enabled
-				  for a process by default. The state of the control
-				  is inherited on fork.
-			seccomp - Same as "prctl" above, but all seccomp threads
-				  will disable SSB unless they explicitly opt out.
-
-			Default mitigations:
-			X86:	If CONFIG_SECCOMP=y "seccomp", otherwise "prctl"
-
-			On powerpc the options are:
-
-			on,auto - On Power8 and Power9 insert a store-forwarding
-				  barrier on kernel entry and exit. On Power7
-				  perform a software flush on kernel entry and
-				  exit.
-			off	- No action.
-
-			Not specifying this option is equivalent to
-			spec_store_bypass_disable=auto.
-
 	spia_io_base=	[HW,MTD]
 	spia_fio_base=
 	spia_pedr=
@@ -5008,6 +5014,11 @@
 	stifb=		[HW]
 			Format: bpp:<bpp1>[:<bpp2>[:<bpp3>...]]
 
+	stress_slb	[PPC]
+			Limits the number of kernel SLB entries, and flushes
+			them frequently to increase the rate of SLB faults
+			on kernel addresses.
+
 	sunrpc.min_resvport=
 	sunrpc.max_resvport=
 			[NFS,SUNRPC]
@@ -5579,6 +5590,13 @@
 	vector=		[IA-64,SMP]
 			vector=percpu: enable percpu vector domain
 
+	vga=		[BOOT,X86-32] Select a particular video mode
+			See Documentation/x86/boot.rst and
+			Documentation/admin-guide/svga.rst.
+			Use vga=ask for menu.
+			This is actually a boot loader parameter; the value is
+			passed to the kernel using a special protocol.
+
 	video=		[FB] Frame buffer configuration
 			See Documentation/fb/modedb.rst.
 
@@ -5607,13 +5625,6 @@
 
 			Can be used multiple times for multiple devices.
 
-	vga=		[BOOT,X86-32] Select a particular video mode
-			See Documentation/x86/boot.rst and
-			Documentation/admin-guide/svga.rst.
-			Use vga=ask for menu.
-			This is actually a boot loader parameter; the value is
-			passed to the kernel using a special protocol.
-
 	vm_debug[=options]	[KNL] Available with CONFIG_DEBUG_VM=y.
 			May slow down system boot speed, especially when
 			enabled on systems with a large amount of memory.
@@ -5828,16 +5839,6 @@
 			improve timer resolution at the expense of processing
 			more timer interrupts.
 
-	nopv=		[X86,XEN,KVM,HYPER_V,VMWARE]
-			Disables the PV optimizations forcing the guest to run
-			as generic guest with no PV drivers. Currently support
-			XEN HVM, KVM, HYPER_V and VMWARE guest.
-
-	nopvspin	[X86,XEN,KVM]
-			Disables the qspinlock slow path using PV optimizations
-			which allow the hypervisor to 'idle' the guest on lock
-			contention.
-
 	xirc2ps_cs=	[NET,PCMCIA]
 			Format:
 			<irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]

