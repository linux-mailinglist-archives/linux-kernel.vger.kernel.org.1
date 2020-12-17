Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2B42DCF51
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgLQKOx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Dec 2020 05:14:53 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:50846 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbgLQKOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:14:52 -0500
Received: by mail-io1-f71.google.com with SMTP id l5so26795214ioj.17
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=jwkgMR3eXWOutZUQmDQ0RmutTgbPG98+mbFwVoQzpTg=;
        b=MzsGmpDoHefnP3Bl6ztXD8UlYBGOqslq9FRo0o9n8BMMhW+QwuTdwb1PqmLsLfMhYp
         GTfpWU1II8bIRdV9GrReTpL68U9HYKJXC+vmM4vHB0WM7cCC65mm0jXMRmmqgoVm/hqg
         +DyVaZrvCCtk/obElpyMBZyH4yIP0aJXOWtNniYad5ahnp5km5TFd3jMSZ9nuNRhSHZS
         0xh//dfz0tmZcbKlpTI6Ypbo+cPaAzemXhzsjia2VeUn8FAOH10dXQWCzUEIn+jYjvTJ
         2PvkoTCsEksJzYBuQmFn6EMn0iwr5il2xrz1LOBfUTviaraC0N8OPSyBQTsIHHWE8Zgj
         sEzw==
X-Gm-Message-State: AOAM533rgaErEfKOmV/076ot56lI4dp4UL5+cKq04YfOO9VoE9KqVCfH
        3lem8gKNUXsXlAi5cN95PlQnvu4ntjaNKi4e/2j0r9Evy0Op
X-Google-Smtp-Source: ABdhPJz8FMyRLKZFFJRNdHYkK7gFlwDtEYLmVLF81hHp8jzwHVSSpmR7IQ5Wwd1PRGyK84TtTm0gmjBV50K7le7EphBonomRSqSN
MIME-Version: 1.0
X-Received: by 2002:a05:6638:bc1:: with SMTP id g1mr46838161jad.27.1608200050100;
 Thu, 17 Dec 2020 02:14:10 -0800 (PST)
Date:   Thu, 17 Dec 2020 02:14:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6cd8d05b6a640ae@google.com>
Subject: upstream boot error: UBSAN: null-ptr-deref in corrupted
From:   syzbot <syzbot+73d662376f16e2a7336d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    accefff5 Merge tag 'arm-soc-omap-genpd-5.11' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14567b7f500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e6efc730c219bd4
dashboard link: https://syzkaller.appspot.com/bug?extid=73d662376f16e2a7336d
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+73d662376f16e2a7336d@syzkaller.appspotmail.com

Linux version 5.10.0-syzkaller (syzkaller@syzkaller) (clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b), GNU ld (GNU Binutils for Ubuntu) 2.26.1) #0 SMP PREEMPT now
Command line: BOOT_IMAGE=/vmlinuz root=/dev/sda1 console=ttyS0 earlyprintk=serial vsyscall=native oops=panic panic_on_warn=1 nmi_watchdog=panic panic=86400 net.ifnames=0 sysctl.kernel.hung_task_all_cpu_backtrace=1
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x00000000bfffcfff] usable
BIOS-e820: [mem 0x00000000bfffd000-0x00000000bfffffff] reserved
BIOS-e820: [mem 0x00000000fffbc000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000023fffffff] usable
printk: bootconsole [earlyser0] enabled
ERROR: earlyprintk= earlyser already used
ERROR: earlyprintk= earlyser already used
ERROR: earlyprintk= earlyser already used
nopcid: PCID feature disabled
Malformed early option 'vsyscall'
Malformed early option 'vsyscall'
NX (Execute Disable) protection: active
SMBIOS 2.4 present.
DMI: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Hypervisor detected: KVM
kvm-clock: Using msrs 4b564d01 and 4b564d00
kvm-clock: cpu 0, msr dde2001, primary cpu clock
kvm-clock: using sched offset of 3478136367 cycles
clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
tsc: Detected 2300.000 MHz processor
last_pfn = 0x240000 max_arch_pfn = 0x400000000
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
last_pfn = 0xbfffd max_arch_pfn = 0x400000000
found SMP MP-table at [mem 0x000f25a0-0x000f25af]
Using GB pages for direct mapping
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000F2320 000014 (v00 Google)
ACPI: RSDT 0x00000000BFFFFFA0 000038 (v01 Google GOOGRSDT 00000001 GOOG 00000001)
ACPI: FACP 0x00000000BFFFF340 0000F4 (v02 Google GOOGFACP 00000001 GOOG 00000001)
================================================================================
UBSAN: null-ptr-deref in drivers/acpi/acpica/tbfadt.c:459:37
member access within null pointer of type 'struct acpi_table_fadt'
CPU: 0 PID: 0 Comm: swapper Not tainted 5.10.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
================================================================================
ACPI: DSDT 0x00000000BFFFDA80 0018BA (v01 Google GOOGDSDT 00000001 GOOG 00000001)
ACPI: FACS 0x00000000BFFFDA40 000040
ACPI: FACS 0x00000000BFFFDA40 000040
ACPI: SRAT 0x00000000BFFFFE70 0000C8 (v03 Google GOOGSRAT 00000001 GOOG 00000001)
ACPI: APIC 0x00000000BFFFFDC0 000076 (v05 Google GOOGAPIC 00000001 GOOG 00000001)
ACPI: SSDT 0x00000000BFFFF440 000980 (v01 Google GOOGSSDT 00000001 GOOG 00000001)
ACPI: WAET 0x00000000BFFFFE40 000028 (v01 Google GOOGWAET 00000001 GOOG 00000001)
SRAT: PXM 0 -> APIC 0x00 -> Node 0
SRAT: PXM 0 -> APIC 0x01 -> Node 0
ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x23fffffff]
NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x100000000-0x23fffffff] -> [mem 0x00000000-0x23fffffff]
Faking node 0 at [mem 0x0000000000000000-0x000000013fffffff] (5120MB)
Faking node 1 at [mem 0x0000000140000000-0x000000023fffffff] (4096MB)
NODE_DATA(0) allocated [mem 0x13fffb000-0x13fffffff]
NODE_DATA(1) allocated [mem 0x23fff8000-0x23fffcfff]
Zone ranges:
  DMA      [mem 0x0000000000001000-0x0000000000ffffff]
  DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
  Normal   [mem 0x0000000100000000-0x000000023fffffff]
  Device   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000001000-0x000000000009efff]
  node   0: [mem 0x0000000000100000-0x00000000bfffcfff]
  node   0: [mem 0x0000000100000000-0x000000013fffffff]
  node   1: [mem 0x0000000140000000-0x000000023fffffff]
Zeroed struct page in unavailable ranges: 101 pages
Initmem setup node 0 [mem 0x0000000000001000-0x000000013fffffff]
Initmem setup node 1 [mem 0x0000000140000000-0x000000023fffffff]
kasan: KernelAddressSanitizer initialized
ACPI: PM-Timer IO Port: 0xb008
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
Using ACPI (MADT) for SMP configuration information
smpboot: Allowing 2 CPUs, 0 hotplug CPUs
PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
PM: hibernation: Registered nosave memory: [mem 0xbfffd000-0xbfffffff]
PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xfffbbfff]
PM: hibernation: Registered nosave memory: [mem 0xfffbc000-0xffffffff]
[mem 0xc0000000-0xfffbbfff] available for PCI devices
Booting paravirtualized kernel on KVM
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:2 nr_node_ids:2
percpu: Embedded 63 pages/cpu s221000 r8192 d28856 u1048576
kvm-guest: stealtime: cpu 0, msr b9e1fb00
kvm-guest: PV spinlocks enabled
PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
Built 2 zonelists, mobility grouping on.  Total pages: 2064261
Policy zone: Normal
Kernel command line: earlyprintk=serial oops=panic panic_on_warn=1 nmi_watchdog=panic panic=86400 net.ifnames=0 sysctl.kernel.hung_task_all_cpu_backtrace=1 ima_policy=tcb watchdog_thresh=55 workqueue.watchdog_thresh=140 kvm-intel.nested=1 nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000 nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000 nf-conntrack-sane.ports=20000 vivid.n_devs=16 vivid.multiplanar=1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2 netrom.nr_ndevs=16 rose.rose_ndevs=16 spec_store_bypass_disable=prctl numa=fake=2 nopcid dummy_hcd.num=8 binder.debug_mask=0 rcupdate.rcu_expedited=1 root=/dev/sda console=ttyS0 vsyscall=native BOOT_IMAGE=/vmlinuz root=/dev/sda1 console=ttyS0 earlyprintk=serial vsyscall=native oops=panic panic_on_warn=1 nmi_watchdog=panic panic=86400 net.ifnames=0 sysctl.kernel.hung_task_all_cpu_backtrace=1
mem auto-init: stack:off, heap alloc:on, heap free:off
Memory: 6874060K/8388204K available (124958K kernel code, 24337K rwdata, 32104K rodata, 3276K init, 26932K bss, 1513888K reserved, 0K cma-reserved)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=2
Running RCU self tests
rcu: Preemptible hierarchical RCU implementation.
rcu: 	RCU lockdep checking is enabled.
rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
rcu: 	RCU callback double-/use-after-free debug enabled.
rcu: 	RCU debug extended QS entry/exit.
	All grace periods are expedited (rcu_expedited).
	Trampoline variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
random: crng done (trusting CPU's manufacturer)
Console: colour VGA+ 80x25
printk: console [ttyS0] enabled
printk: console [ttyS0] enabled
printk: bootconsole [earlyser0] disabled
printk: bootconsole [earlyser0] disabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8192
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     32768
... MAX_LOCKDEP_CHAINS:      65536
... CHAINHASH_SIZE:          32768
 memory used by lock dependency info: 6365 kB
 memory used for stack traces: 4224 kB
 per task-struct memory footprint: 1920 bytes
mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
ACPI: Core revision 20201113
APIC: Switch to symmetric I/O mode setup
..TIMER: vector=0x30 apic1=0 pin1=0 apic2=-1 pin2=-1
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x212735223b2, max_idle_ns: 440795277976 ns
Calibrating delay loop (skipped) preset value.. 4600.00 BogoMIPS (lpj=23000000)
pid_max: default: 32768 minimum: 301
LSM: Security Framework initializing
Yama: becoming mindful.
TOMOYO Linux initialized
Smack:  Initializing.
Smack:  Netfilter enabled.
Smack:  IPv6 Netfilter enabled.
LSM support for eBPF active
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, vmalloc)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, vmalloc)
Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, vmalloc)
Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Spectre V2 : Spectre mitigation: kernel not compiled with retpoline; no mitigation available!
Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
MDS: Mitigation: Clear CPU buffers
Freeing SMP alternatives memory: 88K
kvm-clock: cpu 1, msr dde2041, secondary cpu clock


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
