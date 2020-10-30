Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFDF2A0B10
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgJ3Q1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:27:49 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:34467 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgJ3Q1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:27:48 -0400
Received: by mail-pg1-f177.google.com with SMTP id t14so5662430pgg.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+hzec4lN/YYt6Ib6dkarONNDLEZayiNMnwleliRCwBA=;
        b=h9AkI7vucEo2q/VQfVgWU8GfBowN84TOPdYm/DOzkhb3zx2TGFex99PmSzwpBAfUiv
         0rZBWaBl39iO5ndj2HgywBLX1s6tmm8DO4CT9kM/tblJu7m7A+V7gJJztDnT8e+yOuLf
         Joj2n2Gu9KvdU+EIg8rDM1lSqcaf9Yy51HEMv2vZdCSYdLzpClPRYPpr/g/bXRa6+PtG
         Cj1f0Wu/Fo2FXmxKN2J+5x8gZXSA2eudQDGmGkS+zuS+wFW0e0tjAcAYgZuLyvWePpql
         jXXFgoKNI9S6FSbbAuhk32oD/AqjFGwZBQSlAZIyiHb6v7GwOHGrTtz/IkGdQ6Lf8ljD
         zAkQ==
X-Gm-Message-State: AOAM533liXdj4mo60c4oQR1I3IlLZwhntQUFeGgrP1WXL4waceA25I5t
        gWrp+F1jx/W28u9Lh+gs4N4=
X-Google-Smtp-Source: ABdhPJz5mv1GP6Hb41AbbLfzSjPfW2wV8FXdH7+dJBQcBnbac3WoRQYyeYv41xWHPqduG97oLv3UYg==
X-Received: by 2002:a17:90a:4a95:: with SMTP id f21mr3516968pjh.223.1604075265755;
        Fri, 30 Oct 2020 09:27:45 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id bx24sm4014465pjb.20.2020.10.30.09.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 09:27:44 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9E659419C3; Fri, 30 Oct 2020 16:27:43 +0000 (UTC)
Date:   Fri, 30 Oct 2020 16:27:43 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mateusz Nosek <mateusznosek0@gmail.com>, mcgrof@kernel.org
Subject: Re: [PATCH 2/3] mm, page_poison: use static key more efficiently
Message-ID: <20201030162743.GA17058@42.do-not-panic.com>
References: <20201026173358.14704-1-vbabka@suse.cz>
 <20201026173358.14704-3-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026173358.14704-3-vbabka@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 06:33:57PM +0100, Vlastimil Babka wrote:
> Commit 11c9c7edae06 ("mm/page_poison.c: replace bool variable with static key")
> changed page_poisoning_enabled() to a static key check. However, the function
> is not inlined, so each check still involves a function call with overhead not
> eliminated when page poisoning is disabled.
> 
> Analogically to how debug_pagealloc is handled, this patch converts
> page_poisoning_enabled() back to boolean check, and introduces
> page_poisoning_enabled_static() for fast paths. Both functions are inlined.
> 
> Also optimize the check that enables page poisoning instead of debug_pagealloc
> for architectures without proper debug_pagealloc support. Move the check to
> init_mem_debugging() to enable a single static key instead of having two
> static branches in page_poisoning_enabled_static().
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

<sad trombone>

This patchset causes a regression x86_64 as a guest. I was able
to bisect this on the following linux-next tags:

next-20201015 OK
next-20201023 OK
next-20201026 OK
next-20201027 BAD
next-20201028 BAD

Bisection inside next-20201027 lands me on:

"mm, page_alloc: do not rely on the order of page_poison and init_on_alloc/free parameters"

which is part of this patchset, however, reverting that patch causes a
conflict, likely due to a subsequent patch in this series. So I decided
to try before the patch set and after and this confirms the bisection.

Before this patchset, on patch titled, "mm: forbid splitting special
mappings" I see no issue, but after this patch set, on the patch titled
"mm, page_alloc: reduce static keys in prep_new_page()" I get a crash.
The crash log is attached.

</sad trombone>

<upbeat trombone>

The good news it that this can be easily reproduced in a jiffy if you
use kdevops [0] on Debian (the default) on vagrant.

[0] https://github.com/mcgrof/kdevops

-- Logs begin at Wed 2020-10-28 01:30:20 UTC, end at Wed 2020-10-28 19:16:03 UTC. --
Oct 28 19:13:04 kdevops kernel: Linux version 5.10.0-rc1-next-20201027 (vagrant@kdevops) (gcc (Debian 10.2.0-15) 10.2.0, GNU ld (GNU Binutils for Debian) 2.35.1) #1 SMP Wed Oct 28 15:14:07 UTC 2020
Oct 28 19:13:04 kdevops kernel: Command line: BOOT_IMAGE=/boot/vmlinuz-5.10.0-rc1-next-20201027 root=UUID=232d7b2f-c31e-4bbe-bffe-0ac429e4cb18 ro console=tty0 console=tty1 console=ttyS0,38400n8
Oct 28 19:13:04 kdevops kernel: x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
Oct 28 19:13:04 kdevops kernel: x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
Oct 28 19:13:04 kdevops kernel: x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
Oct 28 19:13:04 kdevops kernel: x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
Oct 28 19:13:04 kdevops kernel: x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
Oct 28 19:13:04 kdevops kernel: BIOS-provided physical RAM map:
Oct 28 19:13:04 kdevops kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
Oct 28 19:13:04 kdevops kernel: BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
Oct 28 19:13:04 kdevops kernel: BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
Oct 28 19:13:04 kdevops kernel: BIOS-e820: [mem 0x0000000000100000-0x00000000bffdafff] usable
Oct 28 19:13:04 kdevops kernel: BIOS-e820: [mem 0x00000000bffdb000-0x00000000bfffffff] reserved
Oct 28 19:13:04 kdevops kernel: BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
Oct 28 19:13:04 kdevops kernel: BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
Oct 28 19:13:04 kdevops kernel: BIOS-e820: [mem 0x0000000100000000-0x000000023fffffff] usable
Oct 28 19:13:04 kdevops kernel: NX (Execute Disable) protection: active
Oct 28 19:13:04 kdevops kernel: SMBIOS 2.8 present.
Oct 28 19:13:04 kdevops kernel: DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1 04/01/2014
Oct 28 19:13:04 kdevops kernel: Hypervisor detected: KVM
Oct 28 19:13:04 kdevops kernel: kvm-clock: Using msrs 4b564d01 and 4b564d00
Oct 28 19:13:04 kdevops kernel: kvm-clock: cpu 0, msr 2110e2001, primary cpu clock
Oct 28 19:13:04 kdevops kernel: kvm-clock: using sched offset of 63760873909837 cycles
Oct 28 19:13:04 kdevops kernel: clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
Oct 28 19:13:04 kdevops kernel: tsc: Detected 1992.014 MHz processor
Oct 28 19:13:04 kdevops kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
Oct 28 19:13:04 kdevops kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
Oct 28 19:13:04 kdevops kernel: last_pfn = 0x240000 max_arch_pfn = 0x400000000
Oct 28 19:13:04 kdevops kernel: MTRR default type: write-back
Oct 28 19:13:04 kdevops kernel: MTRR fixed ranges enabled:
Oct 28 19:13:04 kdevops kernel:   00000-9FFFF write-back
Oct 28 19:13:04 kdevops kernel:   A0000-BFFFF uncachable
Oct 28 19:13:04 kdevops kernel:   C0000-FFFFF write-protect
Oct 28 19:13:04 kdevops kernel: MTRR variable ranges enabled:
Oct 28 19:13:04 kdevops kernel:   0 base 00C0000000 mask FFC0000000 uncachable
Oct 28 19:13:04 kdevops kernel:   1 disabled
Oct 28 19:13:04 kdevops kernel:   2 disabled
Oct 28 19:13:04 kdevops kernel:   3 disabled
Oct 28 19:13:04 kdevops kernel:   4 disabled
Oct 28 19:13:04 kdevops kernel:   5 disabled
Oct 28 19:13:04 kdevops kernel:   6 disabled
Oct 28 19:13:04 kdevops kernel:   7 disabled
Oct 28 19:13:04 kdevops kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
Oct 28 19:13:04 kdevops kernel: last_pfn = 0xbffdb max_arch_pfn = 0x400000000
Oct 28 19:13:04 kdevops kernel: found SMP MP-table at [mem 0x000f5c10-0x000f5c1f]
Oct 28 19:13:04 kdevops kernel: Using GB pages for direct mapping
Oct 28 19:13:04 kdevops kernel: RAMDISK: [mem 0x2f65b000-0x33b24fff]
Oct 28 19:13:04 kdevops kernel: ACPI: Early table checksum verification disabled
Oct 28 19:13:04 kdevops kernel: ACPI: RSDP 0x00000000000F5BD0 000014 (v00 BOCHS )
Oct 28 19:13:04 kdevops kernel: ACPI: RSDT 0x00000000BFFE137A 000034 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
Oct 28 19:13:04 kdevops kernel: ACPI: FACP 0x00000000BFFE11F6 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
Oct 28 19:13:04 kdevops kernel: ACPI: DSDT 0x00000000BFFDFCC0 001536 (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
Oct 28 19:13:04 kdevops kernel: ACPI: FACS 0x00000000BFFDFC80 000040
Oct 28 19:13:04 kdevops kernel: ACPI: APIC 0x00000000BFFE126A 0000B0 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
Oct 28 19:13:04 kdevops kernel: ACPI: HPET 0x00000000BFFE131A 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
Oct 28 19:13:04 kdevops kernel: ACPI: WAET 0x00000000BFFE1352 000028 (v01 BOCHS  BXPCWAET 00000001 BXPC 00000001)
Oct 28 19:13:04 kdevops kernel: ACPI: Local APIC address 0xfee00000
Oct 28 19:13:04 kdevops kernel: No NUMA configuration found
Oct 28 19:13:04 kdevops kernel: Faking a node at [mem 0x0000000000000000-0x000000023fffffff]
Oct 28 19:13:04 kdevops kernel: NODE_DATA(0) allocated [mem 0x23fffb000-0x23fffffff]
Oct 28 19:13:04 kdevops kernel: Zone ranges:
Oct 28 19:13:04 kdevops kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
Oct 28 19:13:04 kdevops kernel:   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
Oct 28 19:13:04 kdevops kernel:   Normal   [mem 0x0000000100000000-0x000000023fffffff]
Oct 28 19:13:04 kdevops kernel:   Device   empty
Oct 28 19:13:04 kdevops kernel: Movable zone start for each node
Oct 28 19:13:04 kdevops kernel: Early memory node ranges
Oct 28 19:13:04 kdevops kernel:   node   0: [mem 0x0000000000001000-0x000000000009efff]
Oct 28 19:13:04 kdevops kernel:   node   0: [mem 0x0000000000100000-0x00000000bffdafff]
Oct 28 19:13:04 kdevops kernel:   node   0: [mem 0x0000000100000000-0x000000023fffffff]
Oct 28 19:13:04 kdevops kernel: Zeroed struct page in unavailable ranges: 135 pages
Oct 28 19:13:04 kdevops kernel: Initmem setup node 0 [mem 0x0000000000001000-0x000000023fffffff]
Oct 28 19:13:04 kdevops kernel: On node 0 totalpages: 2097017
Oct 28 19:13:04 kdevops kernel:   DMA zone: 64 pages used for memmap
Oct 28 19:13:04 kdevops kernel:   DMA zone: 21 pages reserved
Oct 28 19:13:04 kdevops kernel:   DMA zone: 3998 pages, LIFO batch:0
Oct 28 19:13:04 kdevops kernel:   DMA32 zone: 12224 pages used for memmap
Oct 28 19:13:04 kdevops kernel:   DMA32 zone: 782299 pages, LIFO batch:63
Oct 28 19:13:04 kdevops kernel:   Normal zone: 20480 pages used for memmap
Oct 28 19:13:04 kdevops kernel:   Normal zone: 1310720 pages, LIFO batch:63
Oct 28 19:13:04 kdevops kernel: ACPI: PM-Timer IO Port: 0x608
Oct 28 19:13:04 kdevops kernel: ACPI: Local APIC address 0xfee00000
Oct 28 19:13:04 kdevops kernel: ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
Oct 28 19:13:04 kdevops kernel: IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
Oct 28 19:13:04 kdevops kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Oct 28 19:13:04 kdevops kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
Oct 28 19:13:04 kdevops kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Oct 28 19:13:04 kdevops kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
Oct 28 19:13:04 kdevops kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
Oct 28 19:13:04 kdevops kernel: ACPI: IRQ0 used by override.
Oct 28 19:13:04 kdevops kernel: ACPI: IRQ5 used by override.
Oct 28 19:13:04 kdevops kernel: ACPI: IRQ9 used by override.
Oct 28 19:13:04 kdevops kernel: ACPI: IRQ10 used by override.
Oct 28 19:13:04 kdevops kernel: ACPI: IRQ11 used by override.
Oct 28 19:13:04 kdevops kernel: Using ACPI (MADT) for SMP configuration information
Oct 28 19:13:04 kdevops kernel: ACPI: HPET id: 0x8086a201 base: 0xfed00000
Oct 28 19:13:04 kdevops kernel: TSC deadline timer available
Oct 28 19:13:04 kdevops kernel: smpboot: Allowing 8 CPUs, 0 hotplug CPUs
Oct 28 19:13:04 kdevops kernel: PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
Oct 28 19:13:04 kdevops kernel: PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
Oct 28 19:13:04 kdevops kernel: PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
Oct 28 19:13:04 kdevops kernel: PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
Oct 28 19:13:04 kdevops kernel: PM: hibernation: Registered nosave memory: [mem 0xbffdb000-0xbfffffff]
Oct 28 19:13:04 kdevops kernel: PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xfeffbfff]
Oct 28 19:13:04 kdevops kernel: PM: hibernation: Registered nosave memory: [mem 0xfeffc000-0xfeffffff]
Oct 28 19:13:04 kdevops kernel: PM: hibernation: Registered nosave memory: [mem 0xff000000-0xfffbffff]
Oct 28 19:13:04 kdevops kernel: PM: hibernation: Registered nosave memory: [mem 0xfffc0000-0xffffffff]
Oct 28 19:13:04 kdevops kernel: [mem 0xc0000000-0xfeffbfff] available for PCI devices
Oct 28 19:13:04 kdevops kernel: Booting paravirtualized kernel on KVM
Oct 28 19:13:04 kdevops kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
Oct 28 19:13:04 kdevops kernel: setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:1
Oct 28 19:13:04 kdevops kernel: percpu: Embedded 55 pages/cpu s185112 r8192 d31976 u262144
Oct 28 19:13:04 kdevops kernel: pcpu-alloc: s185112 r8192 d31976 u262144 alloc=1*2097152
Oct 28 19:13:04 kdevops kernel: pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
Oct 28 19:13:04 kdevops kernel: kvm-guest: stealtime: cpu 0, msr 237c18580
Oct 28 19:13:04 kdevops kernel: kvm-guest: PV spinlocks disabled, no host support
Oct 28 19:13:04 kdevops kernel: Built 1 zonelists, mobility grouping on.  Total pages: 2064228
Oct 28 19:13:04 kdevops kernel: Policy zone: Normal
Oct 28 19:13:04 kdevops kernel: Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.10.0-rc1-next-20201027 root=UUID=232d7b2f-c31e-4bbe-bffe-0ac429e4cb18 ro console=tty0 console=tty1 console=ttyS0,38400n8
Oct 28 19:13:04 kdevops kernel: Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
Oct 28 19:13:04 kdevops kernel: Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
Oct 28 19:13:04 kdevops kernel: mem auto-init: stack:off, heap alloc:off, heap free:off
Oct 28 19:13:04 kdevops kernel: Memory: 8073336K/8388068K available (12295K kernel code, 1774K rwdata, 3772K rodata, 1628K init, 7424K bss, 314472K reserved, 0K cma-reserved)
Oct 28 19:13:04 kdevops kernel: random: get_random_u64 called from __kmem_cache_create+0x2e/0x560 with crng_init=0
Oct 28 19:13:04 kdevops kernel: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
Oct 28 19:13:04 kdevops kernel: ftrace: allocating 34960 entries in 137 pages
Oct 28 19:13:04 kdevops kernel: ftrace: allocated 137 pages with 3 groups
Oct 28 19:13:04 kdevops kernel: rcu: Hierarchical RCU implementation.
Oct 28 19:13:04 kdevops kernel: rcu:         RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=8.
Oct 28 19:13:04 kdevops kernel:         Rude variant of Tasks RCU enabled.
Oct 28 19:13:04 kdevops kernel:         Tracing variant of Tasks RCU enabled.
Oct 28 19:13:04 kdevops kernel: rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
Oct 28 19:13:04 kdevops kernel: rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
Oct 28 19:13:04 kdevops kernel: NR_IRQS: 33024, nr_irqs: 488, preallocated irqs: 16
Oct 28 19:13:04 kdevops kernel: Console: colour VGA+ 80x25
Oct 28 19:13:04 kdevops kernel: printk: console [tty0] enabled
Oct 28 19:13:04 kdevops kernel: printk: console [ttyS0] enabled
Oct 28 19:13:04 kdevops kernel: ACPI: Core revision 20200925
Oct 28 19:13:04 kdevops kernel: clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
Oct 28 19:13:04 kdevops kernel: APIC: Switch to symmetric I/O mode setup
Oct 28 19:13:04 kdevops kernel: x2apic enabled
Oct 28 19:13:04 kdevops kernel: Switched APIC routing to physical x2apic.
Oct 28 19:13:04 kdevops kernel: ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Oct 28 19:13:04 kdevops kernel: clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x396d6c2a251, max_idle_ns: 881590442397 ns
Oct 28 19:13:04 kdevops kernel: Calibrating delay loop (skipped) preset value.. 3984.02 BogoMIPS (lpj=7968056)
Oct 28 19:13:04 kdevops kernel: pid_max: default: 32768 minimum: 301
Oct 28 19:13:04 kdevops kernel: LSM: Security Framework initializing
Oct 28 19:13:04 kdevops kernel: Yama: becoming mindful.
Oct 28 19:13:04 kdevops kernel: AppArmor: AppArmor initialized
Oct 28 19:13:04 kdevops kernel: TOMOYO Linux initialized
Oct 28 19:13:04 kdevops kernel: Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
Oct 28 19:13:04 kdevops kernel: Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
Oct 28 19:13:04 kdevops kernel: x86/cpu: User Mode Instruction Prevention (UMIP) activated
Oct 28 19:13:04 kdevops kernel: Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
Oct 28 19:13:04 kdevops kernel: Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
Oct 28 19:13:04 kdevops kernel: Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Oct 28 19:13:04 kdevops kernel: Spectre V2 : Mitigation: Enhanced IBRS
Oct 28 19:13:04 kdevops kernel: Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
Oct 28 19:13:04 kdevops kernel: Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
Oct 28 19:13:04 kdevops kernel: Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
Oct 28 19:13:04 kdevops kernel: SRBDS: Mitigation: TSX disabled
Oct 28 19:13:04 kdevops kernel: Freeing SMP alternatives memory: 32K
Oct 28 19:13:04 kdevops kernel: smpboot: CPU0: Intel Core Processor (Skylake, IBRS) (family: 0x6, model: 0x5e, stepping: 0x3)
Oct 28 19:13:04 kdevops kernel: Performance Events: unsupported p6 CPU model 94 no PMU driver, software events only.
Oct 28 19:13:04 kdevops kernel: rcu: Hierarchical SRCU implementation.
Oct 28 19:13:04 kdevops kernel: NMI watchdog: Perf NMI watchdog permanently disabled
Oct 28 19:13:04 kdevops kernel: smp: Bringing up secondary CPUs ...
Oct 28 19:13:04 kdevops kernel: x86: Booting SMP configuration:
Oct 28 19:13:04 kdevops kernel: .... node  #0, CPUs:      #1
Oct 28 19:13:04 kdevops kernel: kvm-clock: cpu 1, msr 2110e2041, secondary cpu clock
Oct 28 19:13:04 kdevops kernel: smpboot: CPU 1 Converting physical 0 to logical die 1
Oct 28 19:13:04 kdevops kernel: kvm-guest: stealtime: cpu 1, msr 237c58580
Oct 28 19:13:04 kdevops kernel:  #2
Oct 28 19:13:04 kdevops kernel: kvm-clock: cpu 2, msr 2110e2081, secondary cpu clock
Oct 28 19:13:04 kdevops kernel: smpboot: CPU 2 Converting physical 0 to logical die 2
Oct 28 19:13:04 kdevops kernel: kvm-guest: stealtime: cpu 2, msr 237c98580
Oct 28 19:13:04 kdevops kernel:  #3
Oct 28 19:13:04 kdevops kernel: kvm-clock: cpu 3, msr 2110e20c1, secondary cpu clock
Oct 28 19:13:04 kdevops kernel: smpboot: CPU 3 Converting physical 0 to logical die 3
Oct 28 19:13:04 kdevops kernel: kvm-guest: stealtime: cpu 3, msr 237cd8580
Oct 28 19:13:04 kdevops kernel:  #4
Oct 28 19:13:04 kdevops kernel: kvm-clock: cpu 4, msr 2110e2101, secondary cpu clock
Oct 28 19:13:04 kdevops kernel: smpboot: CPU 4 Converting physical 0 to logical die 4
Oct 28 19:13:04 kdevops kernel: kvm-guest: stealtime: cpu 4, msr 237d18580
Oct 28 19:13:04 kdevops kernel:  #5
Oct 28 19:13:04 kdevops kernel: kvm-clock: cpu 5, msr 2110e2141, secondary cpu clock
Oct 28 19:13:04 kdevops kernel: smpboot: CPU 5 Converting physical 0 to logical die 5
Oct 28 19:13:04 kdevops kernel: kvm-guest: stealtime: cpu 5, msr 237d58580
Oct 28 19:13:04 kdevops kernel:  #6
Oct 28 19:13:04 kdevops kernel: kvm-clock: cpu 6, msr 2110e2181, secondary cpu clock
Oct 28 19:13:04 kdevops kernel: smpboot: CPU 6 Converting physical 0 to logical die 6
Oct 28 19:13:04 kdevops kernel: kvm-guest: stealtime: cpu 6, msr 237d98580
Oct 28 19:13:04 kdevops kernel:  #7
Oct 28 19:13:04 kdevops kernel: kvm-clock: cpu 7, msr 2110e21c1, secondary cpu clock
Oct 28 19:13:04 kdevops kernel: smpboot: CPU 7 Converting physical 0 to logical die 7
Oct 28 19:13:04 kdevops kernel: kvm-guest: stealtime: cpu 7, msr 237dd8580
Oct 28 19:13:04 kdevops kernel: smp: Brought up 1 node, 8 CPUs
Oct 28 19:13:04 kdevops kernel: smpboot: Max logical packages: 8
Oct 28 19:13:04 kdevops kernel: smpboot: Total of 8 processors activated (31872.22 BogoMIPS)
Oct 28 19:13:04 kdevops kernel: devtmpfs: initialized
Oct 28 19:13:04 kdevops kernel: x86/mm: Memory block size: 128MB
Oct 28 19:13:04 kdevops kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
Oct 28 19:13:04 kdevops kernel: futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
Oct 28 19:13:04 kdevops kernel: pinctrl core: initialized pinctrl subsystem
Oct 28 19:13:04 kdevops kernel: NET: Registered protocol family 16
Oct 28 19:13:04 kdevops kernel: audit: initializing netlink subsys (disabled)
Oct 28 19:13:04 kdevops kernel: audit: type=2000 audit(1603912377.860:1): state=initialized audit_enabled=0 res=1
Oct 28 19:13:04 kdevops kernel: thermal_sys: Registered thermal governor 'fair_share'
Oct 28 19:13:04 kdevops kernel: thermal_sys: Registered thermal governor 'bang_bang'
Oct 28 19:13:04 kdevops kernel: thermal_sys: Registered thermal governor 'step_wise'
Oct 28 19:13:04 kdevops kernel: thermal_sys: Registered thermal governor 'user_space'
Oct 28 19:13:04 kdevops kernel: cpuidle: using governor ladder
Oct 28 19:13:04 kdevops kernel: cpuidle: using governor menu
Oct 28 19:13:04 kdevops kernel: ACPI: bus type PCI registered
Oct 28 19:13:04 kdevops kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
Oct 28 19:13:04 kdevops kernel: PCI: Using configuration type 1 for base access
Oct 28 19:13:04 kdevops kernel: HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
Oct 28 19:13:04 kdevops kernel: HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
Oct 28 19:13:04 kdevops kernel: ACPI: Added _OSI(Module Device)
Oct 28 19:13:04 kdevops kernel: ACPI: Added _OSI(Processor Device)
Oct 28 19:13:04 kdevops kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
Oct 28 19:13:04 kdevops kernel: ACPI: Added _OSI(Processor Aggregator Device)
Oct 28 19:13:04 kdevops kernel: ACPI: Added _OSI(Linux-Dell-Video)
Oct 28 19:13:04 kdevops kernel: ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
Oct 28 19:13:04 kdevops kernel: ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
Oct 28 19:13:04 kdevops kernel: ACPI: 1 ACPI AML tables successfully acquired and loaded
Oct 28 19:13:04 kdevops kernel: ACPI: Interpreter enabled
Oct 28 19:13:04 kdevops kernel: ACPI: (supports S0 S3 S4 S5)
Oct 28 19:13:04 kdevops kernel: ACPI: Using IOAPIC for interrupt routing
Oct 28 19:13:04 kdevops kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Oct 28 19:13:04 kdevops kernel: ACPI: Enabled 2 GPEs in block 00 to 0F
Oct 28 19:13:04 kdevops kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
Oct 28 19:13:04 kdevops kernel: acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
Oct 28 19:13:04 kdevops kernel: acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [3] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [4] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [5] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [6] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [7] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [8] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [9] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [10] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [11] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [12] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [13] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [14] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [15] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [16] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [17] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [18] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [19] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [20] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [21] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [22] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [23] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [24] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [25] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [26] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [27] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [28] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [29] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [30] registered
Oct 28 19:13:04 kdevops kernel: acpiphp: Slot [31] registered
Oct 28 19:13:04 kdevops kernel: PCI host bridge to bus 0000:00
Oct 28 19:13:04 kdevops kernel: pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
Oct 28 19:13:04 kdevops kernel: pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
Oct 28 19:13:04 kdevops kernel: pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
Oct 28 19:13:04 kdevops kernel: pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
Oct 28 19:13:04 kdevops kernel: pci_bus 0000:00: root bus resource [mem 0x240000000-0x2bfffffff window]
Oct 28 19:13:04 kdevops kernel: pci_bus 0000:00: root bus resource [bus 00-ff]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
Oct 28 19:13:04 kdevops kernel: pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
Oct 28 19:13:04 kdevops kernel: pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
Oct 28 19:13:04 kdevops kernel: pci 0000:00:01.1: reg 0x20: [io  0xc120-0xc12f]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:01.2: [8086:7020] type 00 class 0x0c0300
Oct 28 19:13:04 kdevops kernel: pci 0000:00:01.2: reg 0x20: [io  0xc0c0-0xc0df]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
Oct 28 19:13:04 kdevops kernel: pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
Oct 28 19:13:04 kdevops kernel: pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
Oct 28 19:13:04 kdevops kernel: pci 0000:00:02.0: [1013:00b8] type 00 class 0x030000
Oct 28 19:13:04 kdevops kernel: pci 0000:00:02.0: reg 0x10: [mem 0xfc000000-0xfdffffff pref]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:02.0: reg 0x14: [mem 0xfebd8000-0xfebd8fff]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:02.0: reg 0x30: [mem 0xfebc0000-0xfebcffff pref]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:03.0: [1af4:1001] type 00 class 0x010000
Oct 28 19:13:04 kdevops kernel: pci 0000:00:03.0: reg 0x10: [io  0xc000-0xc07f]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:03.0: reg 0x14: [mem 0xfebd9000-0xfebd9fff]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:03.0: reg 0x20: [mem 0xfe000000-0xfe003fff 64bit pref]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:04.0: [1af4:1002] type 00 class 0x00ff00
Oct 28 19:13:04 kdevops kernel: pci 0000:00:04.0: reg 0x10: [io  0xc080-0xc0bf]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:04.0: reg 0x20: [mem 0xfe004000-0xfe007fff 64bit pref]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:05.0: [8086:25ab] type 00 class 0x088000
Oct 28 19:13:04 kdevops kernel: pci 0000:00:05.0: reg 0x10: [mem 0xfebda000-0xfebda00f]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:06.0: [1af4:1000] type 00 class 0x020000
Oct 28 19:13:04 kdevops kernel: pci 0000:00:06.0: reg 0x10: [io  0xc0e0-0xc0ff]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:06.0: reg 0x14: [mem 0xfebdb000-0xfebdbfff]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:06.0: reg 0x20: [mem 0xfe008000-0xfe00bfff 64bit pref]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:06.0: reg 0x30: [mem 0xfeb40000-0xfeb7ffff pref]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:07.0: [1af4:1000] type 00 class 0x020000
Oct 28 19:13:04 kdevops kernel: pci 0000:00:07.0: reg 0x10: [io  0xc100-0xc11f]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:07.0: reg 0x14: [mem 0xfebdc000-0xfebdcfff]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:07.0: reg 0x20: [mem 0xfe00c000-0xfe00ffff 64bit pref]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:07.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:08.0: [8086:5845] type 00 class 0x010802
Oct 28 19:13:04 kdevops kernel: pci 0000:00:08.0: reg 0x10: [mem 0xfebd0000-0xfebd1fff 64bit]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:08.0: reg 0x20: [mem 0xfebdd000-0xfebddfff]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:09.0: [8086:5845] type 00 class 0x010802
Oct 28 19:13:04 kdevops kernel: pci 0000:00:09.0: reg 0x10: [mem 0xfebd2000-0xfebd3fff 64bit]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:09.0: reg 0x20: [mem 0xfebde000-0xfebdefff]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:0a.0: [8086:5845] type 00 class 0x010802
Oct 28 19:13:04 kdevops kernel: pci 0000:00:0a.0: reg 0x10: [mem 0xfebd4000-0xfebd5fff 64bit]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:0a.0: reg 0x20: [mem 0xfebdf000-0xfebdffff]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:0b.0: [8086:5845] type 00 class 0x010802
Oct 28 19:13:04 kdevops kernel: pci 0000:00:0b.0: reg 0x10: [mem 0xfebd6000-0xfebd7fff 64bit]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:0b.0: reg 0x20: [mem 0xfebe0000-0xfebe0fff]
Oct 28 19:13:04 kdevops kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
Oct 28 19:13:04 kdevops kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
Oct 28 19:13:04 kdevops kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
Oct 28 19:13:04 kdevops kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
Oct 28 19:13:04 kdevops kernel: ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
Oct 28 19:13:04 kdevops kernel: iommu: Default domain type: Translated 
Oct 28 19:13:04 kdevops kernel: pci 0000:00:02.0: vgaarb: setting as boot VGA device
Oct 28 19:13:04 kdevops kernel: pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
Oct 28 19:13:04 kdevops kernel: pci 0000:00:02.0: vgaarb: bridge control possible
Oct 28 19:13:04 kdevops kernel: vgaarb: loaded
Oct 28 19:13:04 kdevops kernel: pps_core: LinuxPPS API ver. 1 registered
Oct 28 19:13:04 kdevops kernel: pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
Oct 28 19:13:04 kdevops kernel: PTP clock support registered
Oct 28 19:13:04 kdevops kernel: EDAC MC: Ver: 3.0.0
Oct 28 19:13:04 kdevops kernel: PCI: Using ACPI for IRQ routing
Oct 28 19:13:04 kdevops kernel: PCI: pci_cache_line_size set to 64 bytes
Oct 28 19:13:04 kdevops kernel: e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
Oct 28 19:13:04 kdevops kernel: e820: reserve RAM buffer [mem 0xbffdb000-0xbfffffff]
Oct 28 19:13:04 kdevops kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
Oct 28 19:13:04 kdevops kernel: hpet0: 3 comparators, 64-bit 100.000000 MHz counter
Oct 28 19:13:04 kdevops kernel: clocksource: Switched to clocksource kvm-clock
Oct 28 19:13:04 kdevops kernel: VFS: Disk quotas dquot_6.6.0
Oct 28 19:13:04 kdevops kernel: VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Oct 28 19:13:04 kdevops kernel: AppArmor: AppArmor Filesystem Enabled
Oct 28 19:13:04 kdevops kernel: pnp: PnP ACPI init
Oct 28 19:13:04 kdevops kernel: pnp 00:00: Plug and Play ACPI device, IDs PNP0501 (active)
Oct 28 19:13:04 kdevops kernel: pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
Oct 28 19:13:04 kdevops kernel: pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
Oct 28 19:13:04 kdevops kernel: pnp 00:03: [dma 2]
Oct 28 19:13:04 kdevops kernel: pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
Oct 28 19:13:04 kdevops kernel: pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
Oct 28 19:13:04 kdevops kernel: pnp: PnP ACPI: found 5 devices
Oct 28 19:13:04 kdevops kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Oct 28 19:13:04 kdevops kernel: NET: Registered protocol family 2
Oct 28 19:13:04 kdevops kernel: tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
Oct 28 19:13:04 kdevops kernel: TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
Oct 28 19:13:04 kdevops kernel: TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
Oct 28 19:13:04 kdevops kernel: TCP: Hash tables configured (established 65536 bind 65536)
Oct 28 19:13:04 kdevops kernel: UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
Oct 28 19:13:04 kdevops kernel: UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, linear)
Oct 28 19:13:04 kdevops kernel: NET: Registered protocol family 1
Oct 28 19:13:04 kdevops kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
Oct 28 19:13:04 kdevops kernel: pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
Oct 28 19:13:04 kdevops kernel: pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
Oct 28 19:13:04 kdevops kernel: pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
Oct 28 19:13:04 kdevops kernel: pci_bus 0000:00: resource 8 [mem 0x240000000-0x2bfffffff window]
Oct 28 19:13:04 kdevops kernel: pci 0000:00:01.0: PIIX3: Enabling Passive Release
Oct 28 19:13:04 kdevops kernel: pci 0000:00:00.0: Limiting direct PCI/PCI transfers
Oct 28 19:13:04 kdevops kernel: pci 0000:00:01.0: Activating ISA DMA hang workarounds
Oct 28 19:13:04 kdevops kernel: PCI Interrupt Link [LNKD] enabled at IRQ 11
Oct 28 19:13:04 kdevops kernel: pci 0000:00:01.2: quirk_usb_early_handoff+0x0/0x700 took 254127 usecs
Oct 28 19:13:04 kdevops kernel: pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
Oct 28 19:13:04 kdevops kernel: PCI: CLS 0 bytes, default 64
Oct 28 19:13:04 kdevops kernel: Unpacking initramfs...
Oct 28 19:13:04 kdevops kernel: Freeing initrd memory: 70440K
Oct 28 19:13:04 kdevops kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Oct 28 19:13:04 kdevops kernel: software IO TLB: mapped [mem 0x00000000bbfdb000-0x00000000bffdb000] (64MB)
Oct 28 19:13:04 kdevops kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x396d6c2a251, max_idle_ns: 881590442397 ns
Oct 28 19:13:04 kdevops kernel: Initialise system trusted keyrings
Oct 28 19:13:04 kdevops kernel: workingset: timestamp_bits=40 max_order=21 bucket_order=0
Oct 28 19:13:04 kdevops kernel: zbud: loaded
Oct 28 19:13:04 kdevops kernel: Key type asymmetric registered
Oct 28 19:13:04 kdevops kernel: Asymmetric key parser 'x509' registered
Oct 28 19:13:04 kdevops kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
Oct 28 19:13:04 kdevops kernel: io scheduler mq-deadline registered
Oct 28 19:13:04 kdevops kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Oct 28 19:13:04 kdevops kernel: intel_idle: Please enable MWAIT in BIOS SETUP
Oct 28 19:13:04 kdevops kernel: Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Oct 28 19:13:04 kdevops kernel: 00:00: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
Oct 28 19:13:04 kdevops kernel: Linux agpgart interface v0.103
Oct 28 19:13:04 kdevops kernel: AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
Oct 28 19:13:04 kdevops kernel: AMD-Vi: AMD IOMMUv2 functionality not available on this system
Oct 28 19:13:04 kdevops kernel: i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
Oct 28 19:13:04 kdevops kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct 28 19:13:04 kdevops kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Oct 28 19:13:04 kdevops kernel: mousedev: PS/2 mouse device common for all mice
Oct 28 19:13:04 kdevops kernel: rtc_cmos 00:04: RTC can wake from S4
Oct 28 19:13:04 kdevops kernel: input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
Oct 28 19:13:04 kdevops kernel: rtc_cmos 00:04: registered as rtc0
Oct 28 19:13:04 kdevops kernel: rtc_cmos 00:04: setting system clock to 2020-10-28T19:13:00 UTC (1603912380)
Oct 28 19:13:04 kdevops kernel: rtc_cmos 00:04: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
Oct 28 19:13:04 kdevops kernel: intel_pstate: CPU model not supported
Oct 28 19:13:04 kdevops kernel: ledtrig-cpu: registered to indicate activity on CPUs
Oct 28 19:13:04 kdevops kernel: NET: Registered protocol family 10
Oct 28 19:13:04 kdevops kernel: Segment Routing with IPv6
Oct 28 19:13:04 kdevops kernel: mip6: Mobile IPv6
Oct 28 19:13:04 kdevops kernel: NET: Registered protocol family 17
Oct 28 19:13:04 kdevops kernel: mpls_gso: MPLS GSO support
Oct 28 19:13:04 kdevops kernel: IPI shorthand broadcast: enabled
Oct 28 19:13:04 kdevops kernel: sched_clock: Marking stable (1606138559, 98545979)->(1857469343, -152784805)
Oct 28 19:13:04 kdevops kernel: registered taskstats version 1
Oct 28 19:13:04 kdevops kernel: Loading compiled-in X.509 certificates
Oct 28 19:13:04 kdevops kernel: zswap: loaded using pool lzo/zbud
Oct 28 19:13:04 kdevops kernel: kmemleak: Kernel memory leak detector initialized (mem pool available: 15495)
Oct 28 19:13:04 kdevops kernel: Key type ._fscrypt registered
Oct 28 19:13:04 kdevops kernel: Key type .fscrypt registered
Oct 28 19:13:04 kdevops kernel: Key type fscrypt-provisioning registered
Oct 28 19:13:04 kdevops kernel: AppArmor: AppArmor sha1 policy hashing enabled
Oct 28 19:13:04 kdevops kernel: Freeing unused kernel image (initmem) memory: 1628K
Oct 28 19:13:04 kdevops kernel: Write protecting the kernel read-only data: 18432k
Oct 28 19:13:04 kdevops kernel: Freeing unused kernel image (text/rodata gap) memory: 2040K
Oct 28 19:13:04 kdevops kernel: Freeing unused kernel image (rodata/data gap) memory: 324K
Oct 28 19:13:04 kdevops kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
Oct 28 19:13:04 kdevops kernel: Run /init as init process
Oct 28 19:13:04 kdevops kernel:   with arguments:
Oct 28 19:13:04 kdevops kernel:     /init
Oct 28 19:13:04 kdevops kernel:   with environment:
Oct 28 19:13:04 kdevops kernel:     HOME=/
Oct 28 19:13:04 kdevops kernel:     TERM=linux
Oct 28 19:13:04 kdevops kernel:     BOOT_IMAGE=/boot/vmlinuz-5.10.0-rc1-next-20201027
Oct 28 19:13:04 kdevops kernel: floppy: module verification failed: signature and/or required key missing - tainting kernel
Oct 28 19:13:04 kdevops kernel: piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
Oct 28 19:13:04 kdevops kernel: SCSI subsystem initialized
Oct 28 19:13:04 kdevops kernel: ACPI: bus type USB registered
Oct 28 19:13:04 kdevops kernel: input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input3
Oct 28 19:13:04 kdevops kernel: usbcore: registered new interface driver usbfs
Oct 28 19:13:04 kdevops kernel: input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input2
Oct 28 19:13:04 kdevops kernel: usbcore: registered new interface driver hub
Oct 28 19:13:04 kdevops kernel: FDC 0 is a S82078B
Oct 28 19:13:04 kdevops kernel: usbcore: registered new device driver usb
Oct 28 19:13:04 kdevops kernel: nvme nvme0: pci function 0000:00:08.0
Oct 28 19:13:04 kdevops kernel: libata version 3.00 loaded.
Oct 28 19:13:04 kdevops kernel: nvme nvme1: pci function 0000:00:09.0
Oct 28 19:13:04 kdevops kernel: nvme nvme2: pci function 0000:00:0a.0
Oct 28 19:13:04 kdevops kernel: nvme nvme3: pci function 0000:00:0b.0
Oct 28 19:13:04 kdevops kernel: ata_piix 0000:00:01.1: version 2.13
Oct 28 19:13:04 kdevops kernel: ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Oct 28 19:13:04 kdevops kernel: uhci_hcd: USB Universal Host Controller Interface driver
Oct 28 19:13:04 kdevops kernel: scsi host0: ata_piix
Oct 28 19:13:04 kdevops kernel: scsi host1: ata_piix
Oct 28 19:13:04 kdevops kernel: ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc120 irq 14
Oct 28 19:13:04 kdevops kernel: ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc128 irq 15
Oct 28 19:13:04 kdevops kernel: nvme nvme0: 8/0/0 default/read/poll queues
Oct 28 19:13:04 kdevops kernel: PCI Interrupt Link [LNKA] enabled at IRQ 10
Oct 28 19:13:04 kdevops kernel: PCI Interrupt Link [LNKB] enabled at IRQ 10
Oct 28 19:13:04 kdevops kernel: PCI Interrupt Link [LNKC] enabled at IRQ 11
Oct 28 19:13:04 kdevops kernel: uhci_hcd 0000:00:01.2: UHCI Host Controller
Oct 28 19:13:04 kdevops kernel: uhci_hcd 0000:00:01.2: new USB bus registered, assigned bus number 1
Oct 28 19:13:04 kdevops kernel: uhci_hcd 0000:00:01.2: detected 2 ports
Oct 28 19:13:04 kdevops kernel: nvme nvme1: 8/0/0 default/read/poll queues
Oct 28 19:13:04 kdevops kernel: uhci_hcd 0000:00:01.2: irq 11, io base 0x0000c0c0
Oct 28 19:13:04 kdevops kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.10
Oct 28 19:13:04 kdevops kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Oct 28 19:13:04 kdevops kernel: usb usb1: Product: UHCI Host Controller
Oct 28 19:13:04 kdevops kernel: nvme nvme3: 8/0/0 default/read/poll queues
Oct 28 19:13:04 kdevops kernel: usb usb1: Manufacturer: Linux 5.10.0-rc1-next-20201027 uhci_hcd
Oct 28 19:13:04 kdevops kernel: usb usb1: SerialNumber: 0000:00:01.2
Oct 28 19:13:04 kdevops kernel: nvme nvme2: 8/0/0 default/read/poll queues
Oct 28 19:13:04 kdevops kernel: hub 1-0:1.0: USB hub found
Oct 28 19:13:04 kdevops kernel: hub 1-0:1.0: 2 ports detected
Oct 28 19:13:04 kdevops kernel: virtio_blk virtio0: [vda] 41943040 512-byte logical blocks (21.5 GB/20.0 GiB)
Oct 28 19:13:04 kdevops kernel: vda: detected capacity change from 0 to 21474836480
Oct 28 19:13:04 kdevops kernel: virtio_net virtio3 ens7: renamed from eth1
Oct 28 19:13:04 kdevops kernel:  vda: vda1
Oct 28 19:13:04 kdevops kernel: random: fast init done
Oct 28 19:13:04 kdevops kernel: virtio_net virtio2 ens6: renamed from eth0
Oct 28 19:13:04 kdevops kernel: raid6: avx2x4   gen() 36481 MB/s
Oct 28 19:13:04 kdevops kernel: raid6: avx2x4   xor() 15571 MB/s
Oct 28 19:13:04 kdevops kernel: raid6: avx2x2   gen() 43711 MB/s
Oct 28 19:13:04 kdevops kernel: raid6: avx2x2   xor() 27110 MB/s
Oct 28 19:13:04 kdevops kernel: raid6: avx2x1   gen() 35089 MB/s
Oct 28 19:13:04 kdevops kernel: raid6: avx2x1   xor() 22494 MB/s
Oct 28 19:13:04 kdevops kernel: raid6: sse2x4   gen() 18229 MB/s
Oct 28 19:13:04 kdevops kernel: raid6: sse2x4   xor() 10145 MB/s
Oct 28 19:13:04 kdevops kernel: raid6: sse2x2   gen() 18267 MB/s
Oct 28 19:13:04 kdevops kernel: raid6: sse2x2   xor() 10673 MB/s
Oct 28 19:13:04 kdevops kernel: raid6: sse2x1   gen() 14997 MB/s
Oct 28 19:13:04 kdevops kernel: raid6: sse2x1   xor()  7538 MB/s
Oct 28 19:13:04 kdevops kernel: raid6: using algorithm avx2x2 gen() 43711 MB/s
Oct 28 19:13:04 kdevops kernel: raid6: .... xor() 27110 MB/s, rmw enabled
Oct 28 19:13:04 kdevops kernel: raid6: using avx2x2 recovery algorithm
Oct 28 19:13:04 kdevops kernel: xor: automatically using best checksumming function   avx       
Oct 28 19:13:04 kdevops kernel: Btrfs loaded, crc32c=crc32c-intel
Oct 28 19:13:04 kdevops kernel: EXT4-fs (vda1): mounted filesystem with ordered data mode. Opts: (null)
Oct 28 19:13:04 kdevops kernel: Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
Oct 28 19:13:04 kdevops systemd[1]: Inserted module 'autofs4'
Oct 28 19:13:04 kdevops systemd[1]: systemd 246.6-2 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
Oct 28 19:13:04 kdevops systemd[1]: Detected virtualization kvm.
Oct 28 19:13:04 kdevops systemd[1]: Detected architecture x86-64.
Oct 28 19:13:04 kdevops systemd[1]: Set hostname to <kdevops>.
Oct 28 19:13:04 kdevops kernel: random: lvmconfig: uninitialized urandom read (4 bytes read)
Oct 28 19:13:04 kdevops systemd[1]: Queued start job for default target Graphical Interface.
Oct 28 19:13:04 kdevops systemd[1]: Created slice system-getty.slice.
Oct 28 19:13:04 kdevops systemd[1]: Created slice system-modprobe.slice.
Oct 28 19:13:04 kdevops systemd[1]: Created slice system-serial\x2dgetty.slice.
Oct 28 19:13:04 kdevops systemd[1]: Created slice User and Session Slice.
Oct 28 19:13:04 kdevops systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
Oct 28 19:13:04 kdevops systemd[1]: Started Forward Password Requests to Wall Directory Watch.
Oct 28 19:13:04 kdevops systemd[1]: Condition check resulted in Arbitrary Executable File Formats File System Automount Point being skipped.
Oct 28 19:13:04 kdevops systemd[1]: Reached target Local Encrypted Volumes.
Oct 28 19:13:04 kdevops systemd[1]: Reached target Paths.
Oct 28 19:13:04 kdevops systemd[1]: Reached target Slices.
Oct 28 19:13:04 kdevops systemd[1]: Reached target Swap.
Oct 28 19:13:04 kdevops systemd[1]: Listening on Device-mapper event daemon FIFOs.
Oct 28 19:13:04 kdevops systemd[1]: Listening on LVM2 poll daemon socket.
Oct 28 19:13:04 kdevops systemd[1]: Listening on RPCbind Server Activation Socket.
Oct 28 19:13:04 kdevops systemd[1]: Listening on Syslog Socket.
Oct 28 19:13:04 kdevops systemd[1]: Listening on fsck to fsckd communication Socket.
Oct 28 19:13:04 kdevops systemd[1]: Listening on initctl Compatibility Named Pipe.
Oct 28 19:13:04 kdevops systemd[1]: Listening on Journal Audit Socket.
Oct 28 19:13:04 kdevops systemd[1]: Listening on Journal Socket (/dev/log).
Oct 28 19:13:04 kdevops systemd[1]: Listening on Journal Socket.
Oct 28 19:13:04 kdevops systemd[1]: Listening on Network Service Netlink Socket.
Oct 28 19:13:04 kdevops systemd[1]: Listening on udev Control Socket.
Oct 28 19:13:04 kdevops systemd[1]: Listening on udev Kernel Socket.
Oct 28 19:13:04 kdevops systemd[1]: Mounting Huge Pages File System...
Oct 28 19:13:04 kdevops systemd[1]: Mounting POSIX Message Queue File System...
Oct 28 19:13:04 kdevops systemd[1]: Mounting Kernel Debug File System...
Oct 28 19:13:04 kdevops systemd[1]: Mounting Kernel Trace File System...
Oct 28 19:13:04 kdevops systemd[1]: Starting Create list of static device nodes for the current kernel...
Oct 28 19:13:04 kdevops systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
Oct 28 19:13:04 kdevops systemd[1]: Starting Load Kernel Module drm...
Oct 28 19:13:04 kdevops kernel: random: lvm: uninitialized urandom read (4 bytes read)
Oct 28 19:13:04 kdevops systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
Oct 28 19:13:04 kdevops systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
Oct 28 19:13:04 kdevops systemd[1]: Starting Journal Service...
Oct 28 19:13:04 kdevops systemd[1]: Starting Load Kernel Modules...
Oct 28 19:13:04 kdevops systemd[1]: Starting Remount Root and Kernel File Systems...
Oct 28 19:13:04 kdevops systemd[1]: Starting Coldplug All udev Devices...
Oct 28 19:13:04 kdevops systemd[1]: Mounted Huge Pages File System.
Oct 28 19:13:04 kdevops systemd[1]: Mounted POSIX Message Queue File System.
Oct 28 19:13:04 kdevops systemd[1]: Mounted Kernel Debug File System.
Oct 28 19:13:04 kdevops kernel: EXT4-fs (vda1): re-mounted. Opts: errors=remount-ro
Oct 28 19:13:04 kdevops kernel: Loading iSCSI transport class v2.0-870.
Oct 28 19:13:04 kdevops systemd[1]: Mounted Kernel Trace File System.
Oct 28 19:13:04 kdevops systemd[1]: Finished Create list of static device nodes for the current kernel.
Oct 28 19:13:04 kdevops systemd[1]: modprobe@drm.service: Succeeded.
Oct 28 19:13:04 kdevops systemd[1]: Finished Load Kernel Module drm.
Oct 28 19:13:04 kdevops systemd[1]: Finished Remount Root and Kernel File Systems.
Oct 28 19:13:04 kdevops systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
Oct 28 19:13:04 kdevops systemd[1]: Condition check resulted in Platform Persistent Storage Archival being skipped.
Oct 28 19:13:04 kdevops systemd[1]: Starting Load/Save Random Seed...
Oct 28 19:13:04 kdevops systemd[1]: Starting Create System Users...
Oct 28 19:13:04 kdevops kernel: iscsi: registered transport (tcp)
Oct 28 19:13:04 kdevops systemd[1]: Finished Load Kernel Modules.
Oct 28 19:13:04 kdevops systemd[1]: Condition check resulted in FUSE Control File System being skipped.
Oct 28 19:13:04 kdevops systemd[1]: Condition check resulted in Kernel Configuration File System being skipped.
Oct 28 19:13:04 kdevops systemd[1]: Starting Apply Kernel Variables...
Oct 28 19:13:04 kdevops systemd[1]: Finished Create System Users.
Oct 28 19:13:04 kdevops systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
Oct 28 19:13:04 kdevops systemd[1]: Starting Create Static Device Nodes in /dev...
Oct 28 19:13:04 kdevops systemd[1]: Finished Apply Kernel Variables.
Oct 28 19:13:04 kdevops systemd[1]: Finished Create Static Device Nodes in /dev.
Oct 28 19:13:04 kdevops systemd[1]: Reached target Local File Systems (Pre).
Oct 28 19:13:04 kdevops systemd[1]: Starting Rule-based Manager for Device Events and Files...
Oct 28 19:13:04 kdevops systemd[1]: Finished Coldplug All udev Devices.
Oct 28 19:13:04 kdevops systemd[1]: Starting Helper to synchronize boot up for ifupdown...
Oct 28 19:13:04 kdevops systemd[1]: Finished Helper to synchronize boot up for ifupdown.
Oct 28 19:13:04 kdevops systemd[1]: Started Rule-based Manager for Device Events and Files.
Oct 28 19:13:04 kdevops systemd[1]: Starting Network Service...
Oct 28 19:13:04 kdevops kernel: input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
Oct 28 19:13:04 kdevops systemd[1]: Found device /dev/ttyS0.
Oct 28 19:13:04 kdevops kernel: ACPI: Power Button [PWRF]
Oct 28 19:13:04 kdevops kernel: i6300ESB timer 0000:00:05.0: initialized. heartbeat=30 sec (nowayout=0)
Oct 28 19:13:04 kdevops kernel: cryptd: max_cpu_qlen set to 1000
Oct 28 19:13:04 kdevops systemd[1]: Found device QEMU NVMe Ctrl data.
Oct 28 19:13:04 kdevops systemd[1]: Mounting /data...
Oct 28 19:13:04 kdevops kernel: BUG: unable to handle page fault for address: ffffffffb7d3e3b8
Oct 28 19:13:04 kdevops kernel: #PF: supervisor write access in kernel mode
Oct 28 19:13:04 kdevops kernel: #PF: error_code(0x0003) - permissions violation
Oct 28 19:13:04 kdevops kernel: PGD 210a0e067 P4D 210a0e067 PUD 210a0f063 PMD 112816063 PTE 800000021093e161
Oct 28 19:13:04 kdevops kernel: Oops: 0003 [#1] SMP NOPTI
Oct 28 19:13:04 kdevops kernel: CPU: 5 PID: 312 Comm: systemd-udevd Tainted: G            E     5.10.0-rc1-next-20201027 #1
Oct 28 19:13:04 kdevops kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1 04/01/2014
Oct 28 19:13:04 kdevops kernel: RIP: 0010:jump_label_module_notify+0x20b/0x2d0
Oct 28 19:13:04 kdevops kernel: Code: 0d da f5 21 49 a8 02 0f 85 db 00 00 00 48 83 e0 fc 48 c7 02 00 00 00 00 48 89 42 08 48 8b 43 08 83 e0 03 48 09 c2 48 83 ca 02 <48> 89 53 08 4d 89 66 10 49 89 6e 08 48 8b 43 08 a8 02 0f 84 98 00
Oct 28 19:13:04 kdevops kernel: RSP: 0018:ffffaf6f0039bcf0 EFLAGS: 00010282
Oct 28 19:13:04 kdevops kernel: input: PC Speaker as /devices/platform/pcspkr/input/input5
Oct 28 19:13:04 kdevops kernel: RAX: 0000000000000000 RBX: ffffffffb7d3e3b0 RCX: 0000000000000001
Oct 28 19:13:04 kdevops kernel: RDX: ffff9b7f154075c2 RSI: ffffffffb6df8577 RDI: ffffffffb7d3e3b0
Oct 28 19:13:04 kdevops kernel: RBP: ffffffffc06ea000 R08: 0000000000000020 R09: ffffffffb7efcd50
Oct 28 19:13:04 kdevops kernel: R10: 0000000000000003 R11: 0000000000000008 R12: ffffffffc06eb200
Oct 28 19:13:04 kdevops kernel: R13: ffffffffc06ea040 R14: ffff9b7f15407040 R15: ffffffffc06ea008
Oct 28 19:13:04 kdevops kernel: FS:  00007fded4a9f8c0(0000) GS:ffff9b8037d40000(0000) knlGS:0000000000000000
Oct 28 19:13:04 kdevops kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Oct 28 19:13:04 kdevops kernel: CR2: ffffffffb7d3e3b8 CR3: 0000000113c74003 CR4: 0000000000370ee0
Oct 28 19:13:04 kdevops kernel: Call Trace:
Oct 28 19:13:04 kdevops kernel:  blocking_notifier_call_chain_robust+0x64/0xd0
Oct 28 19:13:04 kdevops kernel:  ? mutex_lock+0xe/0x30
Oct 28 19:13:04 kdevops systemd[1]: Started Journal Service.
Oct 28 19:13:04 kdevops kernel:  load_module+0x1e30/0x2650
Oct 28 19:13:04 kdevops kernel:  __do_sys_finit_module+0xb1/0x110
Oct 28 19:13:04 kdevops kernel:  do_syscall_64+0x33/0x80
Oct 28 19:13:04 kdevops kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Oct 28 19:13:04 kdevops kernel: RIP: 0033:0x7fded4f49919
Oct 28 19:13:04 kdevops kernel: Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 47 55 0c 00 f7 d8 64 89 01 48
Oct 28 19:13:04 kdevops kernel: RSP: 002b:00007fffb9c0b1f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
Oct 28 19:13:04 kdevops kernel: RAX: ffffffffffffffda RBX: 000055ec99597d90 RCX: 00007fded4f49919
Oct 28 19:13:04 kdevops kernel: RDX: 0000000000000000 RSI: 00007fded50d5e4d RDI: 0000000000000006
Oct 28 19:13:04 kdevops kernel: RBP: 0000000000020000 R08: 0000000000000000 R09: 000055ec995a0998
Oct 28 19:13:04 kdevops kernel: R10: 0000000000000006 R11: 0000000000000246 R12: 00007fded50d5e4d
Oct 28 19:13:04 kdevops kernel: R13: 0000000000000000 R14: 000055ec9959a460 R15: 000055ec99597d90
Oct 28 19:13:04 kdevops kernel: Modules linked in: drm_kms_helper(E+) cryptd(E) glue_helper(E) serio_raw(E) pcspkr(E) virtio_balloon(E+) i6300esb(E) cec(E) button(E) iscsi_tcp(E) libiscsi_tcp(E) libiscsi(E) scsi_transport_iscsi(E) drm(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc16(E) mbcache(E) jbd2(E) btrfs(E) blake2b_generic(E) xor(E) zstd_compress(E) raid6_pq(E) libcrc32c(E) crc32c_generic(E) virtio_net(E) net_failover(E) virtio_blk(E) failover(E) ata_generic(E) uhci_hcd(E) ehci_hcd(E) ata_piix(E) nvme(E) crc32c_intel(E) psmouse(E) usbcore(E) libata(E) scsi_mod(E) nvme_core(E) virtio_pci(E) i2c_piix4(E) virtio_ring(E) t10_pi(E) virtio(E) floppy(E)
Oct 28 19:13:04 kdevops kernel: CR2: ffffffffb7d3e3b8
Oct 28 19:13:04 kdevops kernel: ---[ end trace c8e99de72a30068a ]---
Oct 28 19:13:04 kdevops kernel: RIP: 0010:jump_label_module_notify+0x20b/0x2d0
Oct 28 19:13:04 kdevops kernel: Code: 0d da f5 21 49 a8 02 0f 85 db 00 00 00 48 83 e0 fc 48 c7 02 00 00 00 00 48 89 42 08 48 8b 43 08 83 e0 03 48 09 c2 48 83 ca 02 <48> 89 53 08 4d 89 66 10 49 89 6e 08 48 8b 43 08 a8 02 0f 84 98 00
Oct 28 19:13:04 kdevops kernel: RSP: 0018:ffffaf6f0039bcf0 EFLAGS: 00010282
Oct 28 19:13:04 kdevops kernel: RAX: 0000000000000000 RBX: ffffffffb7d3e3b0 RCX: 0000000000000001
Oct 28 19:13:04 kdevops kernel: RDX: ffff9b7f154075c2 RSI: ffffffffb6df8577 RDI: ffffffffb7d3e3b0
Oct 28 19:13:04 kdevops kernel: RBP: ffffffffc06ea000 R08: 0000000000000020 R09: ffffffffb7efcd50
Oct 28 19:13:04 kdevops kernel: R10: 0000000000000003 R11: 0000000000000008 R12: ffffffffc06eb200
Oct 28 19:13:04 kdevops kernel: R13: ffffffffc06ea040 R14: ffff9b7f15407040 R15: ffffffffc06ea008
Oct 28 19:13:04 kdevops kernel: FS:  00007fded4a9f8c0(0000) GS:ffff9b8037d40000(0000) knlGS:0000000000000000
Oct 28 19:13:04 kdevops kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Oct 28 19:13:04 kdevops kernel: CR2: ffffffffb7d3e3b8 CR3: 0000000113c74003 CR4: 0000000000370ee0
Oct 28 19:13:05 kdevops kernel: random: crng init done
Oct 28 19:14:34 kdevops kernel: audit: type=1400 audit(1603912474.268:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=359 comm="apparmor_parser"
Oct 28 19:14:34 kdevops kernel: audit: type=1400 audit(1603912474.268:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=361 comm="apparmor_parser"
Oct 28 19:14:34 kdevops kernel: audit: type=1400 audit(1603912474.268:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=361 comm="apparmor_parser"
Oct 28 19:14:34 kdevops kernel: audit: type=1400 audit(1603912474.272:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=360 comm="apparmor_parser"
Oct 28 19:14:34 kdevops kernel: audit: type=1400 audit(1603912474.272:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=360 comm="apparmor_parser"
Oct 28 19:14:34 kdevops kernel: audit: type=1400 audit(1603912474.272:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=360 comm="apparmor_parser"
