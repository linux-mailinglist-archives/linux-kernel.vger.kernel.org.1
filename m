Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E292B93CD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 14:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgKSNmd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Nov 2020 08:42:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40719 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgKSNmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:42:31 -0500
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kfkC0-0004U9-KM
        for linux-kernel@vger.kernel.org; Thu, 19 Nov 2020 13:41:45 +0000
Received: by mail-pg1-f197.google.com with SMTP id t12so4023673pga.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 05:41:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mhh5k9fYxz6OCtQocggR9c+0e7/ds4Z9sX3wXlEnqvs=;
        b=VrawrVaq9Z8/S6567LDjwUrAJNpWJbppgiGYtGIfDMsV2gCxpDspXzEDtx67EHBnU0
         ip/aDqxSIufrZppLJZyL2r+AN/Yn0lhDj6Llj+iX8XtNdSHuz8uS7aYfUsse70gaPqeA
         TjNDFFvH2iUey+cb1yrDoKrS1q5EfG+klN7BDqA3S1iHFF7HnJbnWvUkH1oraD5Ip8ia
         TNHjyNHn2fMkVd1RW5GHaEEAXkesxLVnjwlMVAzXnoUoaSg/S6+yXMOZ9n7qkgTJ4Phh
         XqIQu8+sL98sYFyaVUlQeuZBKJvfRJ1kbbxq6nPCAYfI59xZXSx53Od9ksebSWCAtHEU
         nUeQ==
X-Gm-Message-State: AOAM533mPzJ/WQpwVw3Z7SVxlTZBpdfXcc7ax5kW+DyKRnG2V/b0DcDW
        s5dNboIUcaHVteBqyjp8YDuND4RmY7kPF58h4ZZwcjLXy7joYOdRxvA2KZn9dkQ8183PuM8hdjl
        +J74nscCSE4AHF2dgDN5hhkwxinu9DbSf8pbQRliPGA==
X-Received: by 2002:aa7:9521:0:b029:18b:b43:6cc with SMTP id c1-20020aa795210000b029018b0b4306ccmr9637816pfp.73.1605793301032;
        Thu, 19 Nov 2020 05:41:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8oKF3jyVoxI4i/k/Ku4BuOZ7hlqrsjpKgDe2cx6hWVTiUFZ+l90AkQIVNKLpkTWP7VYDQzg==
X-Received: by 2002:aa7:9521:0:b029:18b:b43:6cc with SMTP id c1-20020aa795210000b029018b0b4306ccmr9637689pfp.73.1605793298848;
        Thu, 19 Nov 2020 05:41:38 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id r3sm7097932pjl.23.2020.11.19.05.41.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 05:41:37 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] USB: quirks: Add USB_QUIRK_DISCONNECT_SUSPEND quirk
 forLenovo A630Z TIO built-in usb-audio card
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1892790617.185900.1605788248261.JavaMail.xmail@bj-wm-cp-6>
Date:   Thu, 19 Nov 2020 21:41:32 +0800
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        johan <johan@kernel.org>, jonathan <jonathan@jdcox.net>,
        tomasz <tomasz@meresinski.eu>,
        Hans de Goede <hdegoede@redhat.com>,
        dlaz <dlaz@chromium.org>,
        "richard.o.dodd" <richard.o.dodd@gmail.com>,
        kerneldev <kerneldev@karsmulder.nl>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <7D73C39C-C3E2-4C08-A773-3D7582A6AA7D@canonical.com>
References: <20201118123039.11696-1-penghao@uniontech.com>
 <49219711-84BE-44FC-BBFE-DD8D609CA26D@canonical.com>
 <1892790617.185900.1605788248261.JavaMail.xmail@bj-wm-cp-6>
To:     =?utf-8?B?5b2t5rWp?= <penghao@uniontech.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi penghao,

> On Nov 19, 2020, at 20:17, 彭浩 <penghao@uniontech.com> wrote:
> 
> root@uos-PC:/sys/bus/usb/devices/usb7# dmesg
> [ 0.000000] Linux version 4.19.0-6-amd64 (debian-kernel@lists.debian.org) (gcc version 8.3.0 (Debian 8.3.0-6)) #1 SMP Uos 4.19.67-11eagle (2020-03-21)

Thanks for the dmesg. But would it be possible to use mainline kernel enable dynamic debug?

But anyway, this is not a regular AMD or Intel platform, so I guess we can merge the quirk as is...

Kai-Heng

> [ 0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.19.0-6-amd64 root=UUID=e5a40c4f-d88e-4a4d-9414-a27892a31be7 ro splash console=ttyS0,115200n8 loglevel=7 DEEPIN_GFXMODE=0,1920x1080,1600x1200,1280x1024,1024x768
> [ 0.000000] Zhaoxin Linux Patch Version is V3.0.2 
> [ 0.000000] With Zhaoxin Shanghai CPU patch V2.0.0
> [ 0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [ 0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [ 0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [ 0.000000] x86/fpu: xstate_offset[2]: 576, xstate_sizes[2]: 256
> [ 0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
> [ 0.000000] BIOS-provided physical RAM map:
> [ 0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dfff] usable
> [ 0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reserved
> [ 0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000096112fff] usable
> [ 0.000000] BIOS-e820: [mem 0x0000000096113000-0x0000000096172fff] type 20
> [ 0.000000] BIOS-e820: [mem 0x0000000096173000-0x0000000096379fff] reserved
> [ 0.000000] BIOS-e820: [mem 0x000000009637a000-0x00000000964ecfff] ACPI NVS
> [ 0.000000] BIOS-e820: [mem 0x00000000964ed000-0x00000000964fdfff] ACPI data
> [ 0.000000] BIOS-e820: [mem 0x00000000964fe000-0x000000009fafefff] usable
> [ 0.000000] BIOS-e820: [mem 0x000000009faff000-0x000000009fffffff] reserved
> [ 0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
> [ 0.000000] BIOS-e820: [mem 0x00000000fe020000-0x00000000fe020fff] reserved
> [ 0.000000] BIOS-e820: [mem 0x00000000feb00000-0x00000000feb7ffff] reserved
> [ 0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [ 0.000000] BIOS-e820: [mem 0x00000000fecc0000-0x00000000fecc0fff] reserved
> [ 0.000000] BIOS-e820: [mem 0x00000000fef00000-0x00000000feffffff] reserved
> [ 0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff] reserved
> [ 0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023fffffff] usable
> [ 0.000000] NX (Execute Disable) protection: active
> [ 0.000000] efi: EFI v2.60 by LENOVO
> [ 0.000000] efi: SMBIOS=0x96333000 ACPI=0x964fd000 ACPI 2.0=0x964fd014 ESRT=0x948c0e98 MEMATTR=0x9485f018 
> [ 0.000000] secureboot: Secure boot could not be determined (mode 0)
> [ 0.000000] SMBIOS 3.1 present.
> [ 0.000000] DMI: LENOVO INVALID/LXCF-ZXE-ZX200-ITX, BIOS M2KKT31A 06/19/2020
> [ 0.000000] tsc: Fast TSC calibration using PIT
> [ 0.000000] tsc: Detected 2594.884 MHz processor
> [ 0.002881] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [ 0.002885] e820: remove [mem 0x000a0000-0x000fffff] usable
> [ 0.002893] last_pfn = 0x240000 max_arch_pfn = 0x400000000
> [ 0.002900] MTRR default type: write-back
> [ 0.002901] MTRR fixed ranges enabled:
> [ 0.002902] 00000-9FFFF write-back
> [ 0.002904] A0000-BFFFF uncachable
> [ 0.002905] C0000-FFFFF write-through
> [ 0.002906] MTRR variable ranges enabled:
> [ 0.002908] 0 base 00A0000000 mask FFE0000000 uncachable
> [ 0.002910] 1 base 00C0000000 mask FFC0000000 uncachable
> [ 0.002911] 2 base 009FC00000 mask FFFFC00000 uncachable
> [ 0.002912] 3 disabled
> [ 0.002913] 4 disabled
> [ 0.002913] 5 disabled
> [ 0.002914] 6 disabled
> [ 0.002915] 7 disabled
> [ 0.002915] 8 disabled
> [ 0.002916] 9 disabled
> [ 0.003467] x86/PAT: Configuration [0-7]: WB WC UC- UC WB WP UC- WT 
> [ 0.003816] last_pfn = 0x9faff max_arch_pfn = 0x400000000
> [ 0.011070] esrt: Reserving ESRT space from 0x00000000948c0e98 to 0x00000000948c0ed0.
> [ 0.011090] Using GB pages for direct mapping
> [ 0.011094] BRK [0x4b201000, 0x4b201fff] PGTABLE
> [ 0.011096] BRK [0x4b202000, 0x4b202fff] PGTABLE
> [ 0.011098] BRK [0x4b203000, 0x4b203fff] PGTABLE
> [ 0.011165] BRK [0x4b204000, 0x4b204fff] PGTABLE
> [ 0.011590] BRK [0x4b205000, 0x4b205fff] PGTABLE
> [ 0.011734] BRK [0x4b206000, 0x4b206fff] PGTABLE
> [ 0.011877] RAMDISK: [mem 0x30970000-0x344affff]
> [ 0.011886] ACPI: Early table checksum verification disabled
> [ 0.011890] ACPI: RSDP 0x00000000964FD014 000024 (v02 LENOVO)
> [ 0.011896] ACPI: XSDT 0x00000000964FC0E8 00005C (v01 LENOVO TC-M2KKT 000011F0 00010013)
> [ 0.011904] ACPI: FACP 0x00000000964FB000 000114 (v06 LENOVO TC-M2KKT 000011F0 00010013)
> [ 0.011911] ACPI: DSDT 0x00000000964F0000 007A42 (v02 LENOVO TC-M2KKT 000011F0 INTL 00010013)
> [ 0.011916] ACPI: FACS 0x00000000963CB000 000040
> [ 0.011920] ACPI: UEFI 0x00000000964E7000 000042 (v01 LENOVO TC-M2KKT 000011F0 00010013)
> [ 0.011925] ACPI: HPET 0x00000000964FA000 000038 (v01 LENOVO TC-M2KKT 000011F0 00010013)
> [ 0.011930] ACPI: APIC 0x00000000964F9000 0000B2 (v03 LENOVO TC-M2KKT 000011F0 00010013)
> [ 0.011934] ACPI: MCFG 0x00000000964F8000 00003C (v01 LENOVO TC-M2KKT 000011F0 00010013)
> [ 0.011939] ACPI: FPDT 0x00000000964EF000 000044 (v01 LENOVO TC-M2KKT 000011F0 00010013)
> [ 0.011943] ACPI: BGRT 0x00000000964EE000 000038 (v01 LENOVO TC-M2KKT 000011F0 00010013)
> [ 0.011954] ACPI: Local APIC address 0xfee00000
> [ 0.012063] No NUMA configuration found
> [ 0.012065] Faking a node at [mem 0x0000000000000000-0x000000023fffffff]
> [ 0.012071] NODE_DATA(0) allocated [mem 0x23fff9000-0x23fffdfff]
> [ 0.012113] Zone ranges:
> [ 0.012115] DMA [mem 0x0000000000001000-0x0000000000ffffff]
> [ 0.012118] DMA32 [mem 0x0000000001000000-0x00000000ffffffff]
> [ 0.012120] Normal [mem 0x0000000100000000-0x000000023fffffff]
> [ 0.012122] Device empty
> [ 0.012124] Movable zone start for each node
> [ 0.012125] Early memory node ranges
> [ 0.012127] node 0: [mem 0x0000000000001000-0x000000000009dfff]
> [ 0.012128] node 0: [mem 0x0000000000100000-0x0000000096112fff]
> [ 0.012130] node 0: [mem 0x00000000964fe000-0x000000009fafefff]
> [ 0.012131] node 0: [mem 0x0000000100000000-0x000000023fffffff]
> [ 0.012137] Reserved but unavailable: 99 pages
> [ 0.012139] Initmem setup node 0 [mem 0x0000000000001000-0x000000023fffffff]
> [ 0.012142] On node 0 totalpages: 1963697
> [ 0.012143] DMA zone: 64 pages used for memmap
> [ 0.012144] DMA zone: 56 pages reserved
> [ 0.012145] DMA zone: 3997 pages, LIFO batch:0
> [ 0.012303] DMA32 zone: 10141 pages used for memmap
> [ 0.012304] DMA32 zone: 648980 pages, LIFO batch:63
> [ 0.039986] Normal zone: 20480 pages used for memmap
> [ 0.039989] Normal zone: 1310720 pages, LIFO batch:63
> [ 0.090242] ACPI: PM-Timer IO Port: 0x808
> [ 0.090248] ACPI: Local APIC address 0xfee00000
> [ 0.090256] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> [ 0.090268] IOAPIC[0]: apic_id 9, version 3, address 0xfec00000, GSI 0-23
> [ 0.090275] IOAPIC[1]: apic_id 10, version 3, address 0xfecc0000, GSI 24-47
> [ 0.090278] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [ 0.090281] ACPI: INT_SRC_OVR (bus 0 bus_irq 7 global_irq 7 dfl dfl)
> [ 0.090283] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [ 0.090285] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 dfl dfl)
> [ 0.090287] ACPI: IRQ0 used by override.
> [ 0.090288] ACPI: IRQ7 used by override.
> [ 0.090289] ACPI: IRQ9 used by override.
> [ 0.090290] ACPI: IRQ11 used by override.
> [ 0.090292] Using ACPI (MADT) for SMP configuration information
> [ 0.090294] ACPI: HPET id: 0x1d178201 base: 0xfeb40000
> [ 0.090309] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> [ 0.090338] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [ 0.090341] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
> [ 0.090343] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
> [ 0.090346] PM: Registered nosave memory: [mem 0x96113000-0x96172fff]
> [ 0.090347] PM: Registered nosave memory: [mem 0x96173000-0x96379fff]
> [ 0.090348] PM: Registered nosave memory: [mem 0x9637a000-0x964ecfff]
> [ 0.090350] PM: Registered nosave memory: [mem 0x964ed000-0x964fdfff]
> [ 0.090353] PM: Registered nosave memory: [mem 0x9faff000-0x9fffffff]
> [ 0.090354] PM: Registered nosave memory: [mem 0xa0000000-0xdfffffff]
> [ 0.090355] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
> [ 0.090357] PM: Registered nosave memory: [mem 0xf0000000-0xfe01ffff]
> [ 0.090358] PM: Registered nosave memory: [mem 0xfe020000-0xfe020fff]
> [ 0.090360] PM: Registered nosave memory: [mem 0xfe021000-0xfeafffff]
> [ 0.090361] PM: Registered nosave memory: [mem 0xfeb00000-0xfeb7ffff]
> [ 0.090362] PM: Registered nosave memory: [mem 0xfeb80000-0xfebfffff]
> [ 0.090364] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
> [ 0.090365] PM: Registered nosave memory: [mem 0xfec01000-0xfecbffff]
> [ 0.090366] PM: Registered nosave memory: [mem 0xfecc0000-0xfecc0fff]
> [ 0.090368] PM: Registered nosave memory: [mem 0xfecc1000-0xfeefffff]
> [ 0.090369] PM: Registered nosave memory: [mem 0xfef00000-0xfeffffff]
> [ 0.090371] PM: Registered nosave memory: [mem 0xff000000-0xff7fffff]
> [ 0.090372] PM: Registered nosave memory: [mem 0xff800000-0xffffffff]
> [ 0.090375] [mem 0xa0000000-0xdfffffff] available for PCI devices
> [ 0.090377] Booting paravirtualized kernel on bare hardware
> [ 0.090381] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [ 0.257396] random: get_random_bytes called from start_kernel+0x93/0x52c with crng_init=0
> [ 0.257406] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:4 nr_node_ids:1
> [ 0.257780] percpu: Embedded 45 pages/cpu s144408 r8192 d31720 u524288
> [ 0.257791] pcpu-alloc: s144408 r8192 d31720 u524288 alloc=1*2097152
> [ 0.257792] pcpu-alloc: [0] 0 1 2 3 
> [ 0.257824] Built 1 zonelists, mobility grouping on. Total pages: 1932956
> [ 0.257826] Policy zone: Normal
> [ 0.257828] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.19.0-6-amd64 root=UUID=e5a40c4f-d88e-4a4d-9414-a27892a31be7 ro splash console=ttyS0,115200n8 loglevel=7 DEEPIN_GFXMODE=0,1920x1080,1600x1200,1280x1024,1024x768
> [ 0.266170] Calgary: detecting Calgary via BIOS EBDA area
> [ 0.266173] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
> [ 0.299905] Memory: 7374188K/7854788K available (10252K kernel code, 1261K rwdata, 3368K rodata, 1592K init, 2184K bss, 480600K reserved, 0K cma-reserved)
> [ 0.300043] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [ 0.300052] ftrace: allocating 32773 entries in 129 pages
> [ 0.318337] rcu: Hierarchical RCU implementation.
> [ 0.318341] rcu: RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=4.
> [ 0.318343] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [ 0.324002] NR_IRQS: 33024, nr_irqs: 864, preallocated irqs: 16
> [ 0.324264] Console: colour dummy device 80x25
> [ 1.114327] console [ttyS0] enabled
> [ 1.117834] ACPI: Core revision 20180810
> [ 1.121929] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
> [ 1.131045] hpet clockevent registered
> [ 1.131050] APIC: Switch to symmetric I/O mode setup
> [ 1.136630] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [ 1.159050] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x25675b7be68, max_idle_ns: 440795294601 ns
> [ 1.169559] Calibrating delay loop (skipped), value calculated using timer frequency.. 5189.76 BogoMIPS (lpj=10379536)
> [ 1.173550] pid_max: default: 32768 minimum: 301
> [ 1.177920] Security Framework initialized
> [ 1.181550] Yama: disabled by default; enable with sysctl kernel.yama.*
> [ 1.185570] AppArmor: AppArmor initialized
> [ 1.189550] LSM initialized: elfverify
> [ 1.195213] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> [ 1.198364] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> [ 1.201605] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
> [ 1.205577] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
> [ 1.213743] With Zhaoxin Shanghai CPU patch V2.0.0
> [ 1.217552] Got Zhaoxin CPU topology from cpuid B leaf, 4 leaf patch V1.0.0
> [ 1.221551] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
> [ 1.225558] Zhaoxin MCE driver patch V1.0.2
> [ 1.229564] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> [ 1.233550] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> [ 1.237550] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [ 1.241550] Spectre V2 : Mitigation: Full generic retpoline
> [ 1.245549] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [ 1.249549] Spectre V2 : Enabling Restricted Speculation for firmware calls
> [ 1.253558] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [ 1.257550] Speculative Store Bypass: Vulnerable
> [ 1.261572] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
> [ 1.274261] Freeing SMP alternatives memory: 24K
> [ 1.294717] TSC deadline timer enabled
> [ 1.294720] smpboot: CPU0: Centaur ZHAOXIN KaiXian KX-6640A@2.6GHz (family: 0x7, model: 0x3b, stepping: 0x0)
> [ 1.297714] Performance Events: no PMU driver, software events only.
> [ 1.301598] rcu: Hierarchical SRCU implementation.
> [ 1.305985] random: crng done (trusting CPU's manufacturer)
> [ 1.309579] NMI watchdog: Perf NMI watchdog permanently disabled
> [ 1.313640] smp: Bringing up secondary CPUs ...
> [ 1.317685] x86: Booting SMP configuration:
> [ 1.321553] .... node #0, CPUs: #1
> [ 0.821311] With Zhaoxin Shanghai CPU patch V2.0.0
> [ 0.821311] Got Zhaoxin CPU topology from cpuid B leaf, 4 leaf patch V1.0.0
> [ 0.821311] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
> [ 1.356639] #2
> [ 0.821311] With Zhaoxin Shanghai CPU patch V2.0.0
> [ 0.821311] Got Zhaoxin CPU topology from cpuid B leaf, 4 leaf patch V1.0.0
> [ 0.821311] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
> [ 1.389706] #3
> [ 0.821311] With Zhaoxin Shanghai CPU patch V2.0.0
> [ 0.821311] Got Zhaoxin CPU topology from cpuid B leaf, 4 leaf patch V1.0.0
> [ 0.821311] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
> [ 1.422776] smp: Brought up 1 node, 4 CPUs
> [ 1.425552] smpboot: Max logical packages: 1
> [ 1.429551] smpboot: Total of 4 processors activated (20759.07 BogoMIPS)
> [ 1.434479] devtmpfs: initialized
> [ 1.437622] x86/mm: Memory block size: 128MB
> [ 1.442534] PM: Registering ACPI NVS region [mem 0x9637a000-0x964ecfff] (1519616 bytes)
> [ 1.445646] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [ 1.449563] futex hash table entries: 1024 (order: 4, 65536 bytes)
> [ 1.453613] pinctrl core: initialized pinctrl subsystem
> [ 1.459077] NET: Registered protocol family 16
> [ 1.461674] audit: initializing netlink subsys (disabled)
> [ 1.465569] audit: type=2000 audit(1594791330.324:1): state=initialized audit_enabled=0 res=1
> [ 1.473552] cpuidle: using governor ladder
> [ 1.477563] cpuidle: using governor menu
> [ 1.481601] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [ 1.485551] ACPI: bus type PCI registered
> [ 1.489551] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [ 1.493631] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
> [ 1.497562] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
> [ 1.501565] PCI: Using configuration type 1 for base access
> [ 1.506655] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [ 1.513552] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [ 1.517681] ACPI: Added _OSI(Module Device)
> [ 1.521551] ACPI: Added _OSI(Processor Device)
> [ 1.525551] ACPI: Added _OSI(3.0 _SCP Extensions)
> [ 1.533550] ACPI: Added _OSI(Processor Aggregator Device)
> [ 1.537550] ACPI: Added _OSI(Linux-Dell-Video)
> [ 1.541550] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [ 1.549888] ACPI: 1 ACPI AML tables successfully acquired and loaded
> [ 1.559480] ACPI: Interpreter enabled
> [ 1.561569] ACPI: (supports S0 S3 S4 S5)
> [ 1.565486] ACPI: Using IOAPIC for interrupt routing
> [ 1.573581] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [ 1.583680] ACPI: Power Resource [PWR0] (off)
> [ 1.592261] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [ 1.597556] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [ 1.605723] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER LTR]
> [ 1.613711] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> [ 1.621551] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> [ 1.629882] PCI host bridge to bus 0000:00
> [ 1.633553] pci_bus 0000:00: root bus resource [io 0x0000-0x03af window]
> [ 1.641552] pci_bus 0000:00: root bus resource [io 0x03e0-0x0cf7 window]
> [ 1.649551] pci_bus 0000:00: root bus resource [io 0x0d00-0xffff window]
> [ 1.653551] pci_bus 0000:00: root bus resource [io 0x03b0-0x03df window]
> [ 1.661551] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [ 1.669551] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
> [ 1.677551] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xfdffffff window]
> [ 1.685551] pci_bus 0000:00: root bus resource [bus 00-ff]
> [ 1.689563] pci 0000:00:00.0: [1d17:1003] type 00 class 0x060000
> [ 1.689634] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
> [ 1.689737] pci 0000:00:00.1: [1d17:31b0] type 00 class 0x060000
> [ 1.689868] pci 0000:00:00.2: [1d17:31b1] type 00 class 0x060000
> [ 1.689997] pci 0000:00:00.3: [1d17:31b2] type 00 class 0x060000
> [ 1.690132] pci 0000:00:00.4: [1d17:31b3] type 00 class 0x060000
> [ 1.690266] pci 0000:00:00.5: [1d17:31b4] type 00 class 0x060000
> [ 1.690333] pci 0000:00:00.5: PME# supported from D0 D3hot D3cold
> [ 1.690435] pci 0000:00:00.6: [1d17:31b5] type 00 class 0x060000
> [ 1.690566] pci 0000:00:01.0: [1d17:3a04] type 00 class 0x030000
> [ 1.690578] pci 0000:00:01.0: reg 0x10: [mem 0xc0400000-0xc047ffff]
> [ 1.690585] pci 0000:00:01.0: reg 0x14: [mem 0xa0000000-0xbfffffff 64bit pref]
> [ 1.690609] pci 0000:00:01.0: BAR 1: assigned to efifb
> [ 1.697566] pci 0000:00:01.0: supports D1 D2
> [ 1.697652] pci 0000:00:01.1: [1d17:9144] type 00 class 0x040300
> [ 1.697663] pci 0000:00:01.1: reg 0x10: [mem 0xc0484000-0xc0487fff]
> [ 1.697700] pci 0000:00:01.1: supports D1 D2
> [ 1.697791] pci 0000:00:03.0: [1d17:0717] type 01 class 0x060400
> [ 1.697852] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
> [ 1.697964] pci 0000:00:03.1: [1d17:0718] type 01 class 0x060400
> [ 1.698024] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
> [ 1.698135] pci 0000:00:03.2: [1d17:0719] type 01 class 0x060400
> [ 1.698195] pci 0000:00:03.2: PME# supported from D0 D3hot D3cold
> [ 1.698314] pci 0000:00:03.3: [1d17:071a] type 01 class 0x060400
> [ 1.698374] pci 0000:00:03.3: PME# supported from D0 D3hot D3cold
> [ 1.698488] pci 0000:00:04.0: [1d17:071b] type 01 class 0x060400
> [ 1.698548] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
> [ 1.698658] pci 0000:00:04.1: [1d17:071c] type 01 class 0x060400
> [ 1.698718] pci 0000:00:04.1: PME# supported from D0 D3hot D3cold
> [ 1.698835] pci 0000:00:05.0: [1d17:071d] type 01 class 0x060400
> [ 1.698894] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
> [ 1.699005] pci 0000:00:05.1: [1d17:071e] type 01 class 0x060400
> [ 1.699064] pci 0000:00:05.1: PME# supported from D0 D3hot D3cold
> [ 1.699191] pci 0000:00:0e.0: [1d17:3038] type 00 class 0x0c0300
> [ 1.699229] pci 0000:00:0e.0: reg 0x20: [io 0xf060-0xf07f]
> [ 1.699267] pci 0000:00:0e.0: supports D1 D2
> [ 1.699269] pci 0000:00:0e.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.699374] pci 0000:00:0e.7: [1d17:3104] type 00 class 0x0c0320
> [ 1.699391] pci 0000:00:0e.7: reg 0x10: [mem 0xc048c000-0xc048c0ff]
> [ 1.699454] pci 0000:00:0e.7: supports D1 D2
> [ 1.699456] pci 0000:00:0e.7: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.699555] pci 0000:00:0f.0: [1d17:9083] type 00 class 0x010601
> [ 1.699578] pci 0000:00:0f.0: reg 0x18: [mem 0xc048d000-0xc048d03f]
> [ 1.699584] pci 0000:00:0f.0: reg 0x1c: [mem 0xc048e000-0xc048e00f]
> [ 1.699590] pci 0000:00:0f.0: reg 0x20: [io 0xf040-0xf05f]
> [ 1.699596] pci 0000:00:0f.0: reg 0x24: [mem 0xc0488000-0xc0489fff]
> [ 1.699634] pci 0000:00:0f.0: PME# supported from D3hot
> [ 1.699748] pci 0000:00:10.0: [1d17:3038] type 00 class 0x0c0300
> [ 1.699786] pci 0000:00:10.0: reg 0x20: [io 0xf020-0xf03f]
> [ 1.699824] pci 0000:00:10.0: supports D1 D2
> [ 1.699826] pci 0000:00:10.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.699922] pci 0000:00:10.1: [1d17:3038] type 00 class 0x0c0300
> [ 1.699960] pci 0000:00:10.1: reg 0x20: [io 0xf000-0xf01f]
> [ 1.699998] pci 0000:00:10.1: supports D1 D2
> [ 1.699999] pci 0000:00:10.1: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.700104] pci 0000:00:10.7: [1d17:3104] type 00 class 0x0c0320
> [ 1.700120] pci 0000:00:10.7: reg 0x10: [mem 0xc048b000-0xc048b0ff]
> [ 1.700184] pci 0000:00:10.7: supports D1 D2
> [ 1.700186] pci 0000:00:10.7: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.700283] pci 0000:00:11.0: [1d17:1001] type 00 class 0x060100
> [ 1.700447] pci 0000:00:11.7: [1d17:31b7] type 00 class 0x060000
> [ 1.700563] pci 0000:00:12.0: [1d17:9204] type 00 class 0x0c0330
> [ 1.700579] pci 0000:00:12.0: reg 0x10: [mem 0xc048a000-0xc048afff 64bit]
> [ 1.700628] pci 0000:00:12.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.700726] pci 0000:00:14.0: [1d17:3288] type 00 class 0x040300
> [ 1.700742] pci 0000:00:14.0: reg 0x10: [mem 0xc0480000-0xc0483fff 64bit]
> [ 1.700797] pci 0000:00:14.0: PME# supported from D0 D3hot D3cold
> [ 1.700958] pci 0000:01:00.0: [1b21:1142] type 00 class 0x0c0330
> [ 1.700986] pci 0000:01:00.0: reg 0x10: [mem 0xc0300000-0xc0307fff 64bit]
> [ 1.701101] pci 0000:01:00.0: PME# supported from D3hot D3cold
> [ 1.701189] pci 0000:00:03.0: PCI bridge to [bus 01]
> [ 1.705555] pci 0000:00:03.0: bridge window [mem 0xc0300000-0xc03fffff]
> [ 1.705606] pci 0000:00:03.1: PCI bridge to [bus 02]
> [ 1.709600] pci 0000:00:03.2: PCI bridge to [bus 03]
> [ 1.713601] pci 0000:00:03.3: PCI bridge to [bus 04]
> [ 1.721599] pci 0000:00:04.0: PCI bridge to [bus 05]
> [ 1.725613] pci 0000:06:00.0: [144d:a808] type 00 class 0x010802
> [ 1.725639] pci 0000:06:00.0: reg 0x10: [mem 0xc0200000-0xc0203fff 64bit]
> [ 1.725830] pci 0000:00:04.1: PCI bridge to [bus 06]
> [ 1.729554] pci 0000:00:04.1: bridge window [mem 0xc0200000-0xc02fffff]
> [ 1.729618] pci 0000:07:00.0: [10ec:8168] type 00 class 0x020000
> [ 1.729645] pci 0000:07:00.0: reg 0x10: [io 0xe000-0xe0ff]
> [ 1.729669] pci 0000:07:00.0: reg 0x18: [mem 0xc0100000-0xc0100fff 64bit]
> [ 1.729685] pci 0000:07:00.0: reg 0x20: [mem 0xc0000000-0xc0003fff 64bit pref]
> [ 1.729775] pci 0000:07:00.0: supports D1 D2
> [ 1.729777] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.729889] pci 0000:00:05.0: PCI bridge to [bus 07]
> [ 1.733553] pci 0000:00:05.0: bridge window [io 0xe000-0xefff]
> [ 1.733556] pci 0000:00:05.0: bridge window [mem 0xc0100000-0xc01fffff]
> [ 1.733560] pci 0000:00:05.0: bridge window [mem 0xc0000000-0xc00fffff 64bit pref]
> [ 1.733607] pci 0000:00:05.1: PCI bridge to [bus 08]
> [ 1.742127] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> [ 1.749602] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> [ 1.753600] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> [ 1.761599] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 10 11 12 14 15)
> [ 1.769600] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> [ 1.777622] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> [ 1.785605] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> [ 1.793604] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> [ 1.801694] pci 0000:00:01.0: vgaarb: setting as boot VGA device
> [ 1.805547] pci 0000:00:01.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [ 1.817558] pci 0000:00:01.0: vgaarb: bridge control possible
> [ 1.821550] vgaarb: loaded
> [ 1.824328] pps_core: LinuxPPS API ver. 1 registered
> [ 1.829551] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti 
> [ 1.837554] PTP clock support registered
> [ 1.841486] EDAC MC: Ver: 3.0.0
> [ 1.845647] Registered efivars operations
> [ 1.853619] PCI: Using ACPI for IRQ routing
> [ 1.862457] PCI: pci_cache_line_size set to 64 bytes
> [ 1.862518] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
> [ 1.862520] e820: reserve RAM buffer [mem 0x96113000-0x97ffffff]
> [ 1.862521] e820: reserve RAM buffer [mem 0x9faff000-0x9fffffff]
> [ 1.862644] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
> [ 1.869555] hpet0: at MMIO 0xfeb40000, IRQs 2, 8, 0
> [ 1.873551] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
> [ 1.883560] clocksource: Switched to clocksource tsc-early
> [ 1.901788] VFS: Disk quotas dquot_6.6.0
> [ 1.905734] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [ 1.912754] AppArmor: AppArmor Filesystem Enabled
> [ 1.917480] pnp: PnP ACPI init
> [ 1.920704] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
> [ 1.927314] system 00:00: [mem 0xfee00000-0xfeefffff] has been reserved
> [ 1.933917] system 00:00: [mem 0xfecc0000-0xfecc0fff] could not be reserved
> [ 1.940865] system 00:00: [mem 0xfeb14000-0xfeb17fff] has been reserved
> [ 1.947466] system 00:00: [mem 0xfeb11000-0xfeb12fff] has been reserved
> [ 1.954068] system 00:00: [mem 0xfe020000-0xfe020fff] has been reserved
> [ 1.960675] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
> [ 1.960853] system 00:01: [mem 0xfeb41000-0xfeb41fff] has been reserved
> [ 1.967460] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
> [ 1.967509] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
> [ 1.967810] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
> [ 1.967896] system 00:04: [io 0x0295-0x0296] has been reserved
> [ 1.973810] system 00:04: [io 0x04d0-0x04d1] has been reserved
> [ 1.979733] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
> [ 1.979874] system 00:05: [io 0x0800-0x08ff window] has been reserved
> [ 1.986392] system 00:05: [io 0x0400-0x041f] has been reserved
> [ 1.992309] system 00:05: [mem 0xfec00000-0xfec00fff] could not be reserved
> [ 1.999257] system 00:05: [mem 0xfeb32000-0xfeb321ff] has been reserved
> [ 2.005862] system 00:05: [mem 0xff800000-0xffffffff] has been reserved
> [ 2.012467] system 00:05: Plug and Play ACPI device, IDs PNP0c01 (active)
> [ 2.012607] pnp: PnP ACPI: found 6 devices
> [ 2.023355] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [ 2.032253] pci 0000:00:03.0: PCI bridge to [bus 01]
> [ 2.037215] pci 0000:00:03.0: bridge window [mem 0xc0300000-0xc03fffff]
> [ 2.044000] pci 0000:00:03.1: PCI bridge to [bus 02]
> [ 2.048970] pci 0000:00:03.2: PCI bridge to [bus 03]
> [ 2.053935] pci 0000:00:03.3: PCI bridge to [bus 04]
> [ 2.058901] pci 0000:00:04.0: PCI bridge to [bus 05]
> [ 2.063870] pci 0000:00:04.1: PCI bridge to [bus 06]
> [ 2.068832] pci 0000:00:04.1: bridge window [mem 0xc0200000-0xc02fffff]
> [ 2.075611] pci 0000:00:05.0: PCI bridge to [bus 07]
> [ 2.080575] pci 0000:00:05.0: bridge window [io 0xe000-0xefff]
> [ 2.086661] pci 0000:00:05.0: bridge window [mem 0xc0100000-0xc01fffff]
> [ 2.093442] pci 0000:00:05.0: bridge window [mem 0xc0000000-0xc00fffff 64bit pref]
> [ 2.101171] pci 0000:00:05.1: PCI bridge to [bus 08]
> [ 2.106138] pci_bus 0000:00: resource 4 [io 0x0000-0x03af window]
> [ 2.106140] pci_bus 0000:00: resource 5 [io 0x03e0-0x0cf7 window]
> [ 2.106142] pci_bus 0000:00: resource 6 [io 0x0d00-0xffff window]
> [ 2.106143] pci_bus 0000:00: resource 7 [io 0x03b0-0x03df window]
> [ 2.106145] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
> [ 2.106147] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
> [ 2.106148] pci_bus 0000:00: resource 10 [mem 0xa0000000-0xfdffffff window]
> [ 2.106150] pci_bus 0000:01: resource 1 [mem 0xc0300000-0xc03fffff]
> [ 2.106153] pci_bus 0000:06: resource 1 [mem 0xc0200000-0xc02fffff]
> [ 2.106154] pci_bus 0000:07: resource 0 [io 0xe000-0xefff]
> [ 2.106156] pci_bus 0000:07: resource 1 [mem 0xc0100000-0xc01fffff]
> [ 2.106157] pci_bus 0000:07: resource 2 [mem 0xc0000000-0xc00fffff 64bit pref]
> [ 2.106243] NET: Registered protocol family 2
> [ 2.110800] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes)
> [ 2.118663] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
> [ 2.126047] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> [ 2.132930] TCP: Hash tables configured (established 65536 bind 65536)
> [ 2.139488] UDP hash table entries: 4096 (order: 5, 131072 bytes)
> [ 2.145609] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
> [ 2.152205] NET: Registered protocol family 1
> [ 2.156566] NET: Registered protocol family 44
> [ 2.161033] pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [ 2.170493] PCI: CLS 64 bytes, default 64
> [ 2.170548] Unpacking initramfs...
> [ 3.356803] Freeing initrd memory: 60672K
> [ 3.360859] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [ 3.367293] software IO TLB: mapped [mem 0x8ec18000-0x92c18000] (64MB)
> [ 3.374625] Initialise system trusted keyrings
> [ 3.379082] Key type blacklist registered
> [ 3.383155] workingset: timestamp_bits=40 max_order=21 bucket_order=0
> [ 3.391294] zbud: loaded
> [ 3.730196] Key type asymmetric registered
> [ 3.734294] Asymmetric key parser 'x509' registered
> [ 3.739175] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
> [ 3.746601] io scheduler noop registered
> [ 3.750529] io scheduler deadline registered
> [ 3.754838] io scheduler cfq registered (default)
> [ 3.759543] io scheduler mq-deadline registered
> [ 3.765538] pcieport 0000:00:03.0: Signaling PME with IRQ 25
> [ 3.771218] pcieport 0000:00:03.1: Signaling PME with IRQ 27
> [ 3.776900] pcieport 0000:00:03.2: Signaling PME with IRQ 29
> [ 3.782584] pcieport 0000:00:03.3: Signaling PME with IRQ 31
> [ 3.788271] pcieport 0000:00:04.0: Signaling PME with IRQ 33
> [ 3.793954] pcieport 0000:00:04.1: Signaling PME with IRQ 35
> [ 3.799636] pcieport 0000:00:05.0: Signaling PME with IRQ 37
> [ 3.805308] pcieport 0000:00:05.1: Signaling PME with IRQ 39
> [ 3.811004] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [ 3.817712] efifb: probing for efifb
> [ 3.821299] efifb: framebuffer at 0xa0000000, using 8128k, total 8128k
> [ 3.827821] efifb: mode is 1920x1080x32, linelength=7680, pages=1
> [ 3.833902] efifb: scrolling: redraw
> [ 3.837475] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [ 3.850551] Console: switching to colour frame buffer device 240x67
> [ 3.864165] fb0: EFI VGA frame buffer device
> [ 3.869290] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [ 3.896293] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [ 3.923799] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> [ 3.931917] Linux agpgart interface v0.103
> [ 3.936109] AMD IOMMUv2 driver by Joerg Roedel 
> [ 3.942108] AMD IOMMUv2 functionality not available on this system
> [ 3.948607] WangXun Gigabit PCI Express Network Driver - version 1.0.2
> [ 3.955123] Copyright (c) 2018 -2019 Beijing WangXun Technology Co., Ltd
> [ 3.961883] WangXun 10 Gigabit PCI Express Network Driver - version 1.1.10
> [ 3.968753] Copyright (c) 2015 -2017 Beijing WangXun Technology Co., Ltd
> [ 3.975520] i8042: PNP: No PS/2 controller found.
> [ 3.980227] i8042: Probing ports directly.
> [ 4.010198] serio: i8042 KBD port at 0x60,0x64 irq 1
> [ 4.015266] mousedev: PS/2 mouse device common for all mice
> [ 4.020881] rtc_cmos 00:02: RTC can wake from S4
> [ 4.025705] rtc_cmos 00:02: registered as rtc0
> [ 4.030168] rtc_cmos 00:02: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
> [ 4.037777] ledtrig-cpu: registered to indicate activity on CPUs
> [ 4.044279] NET: Registered protocol family 10
> [ 4.057428] Segment Routing with IPv6
> [ 4.061124] mip6: Mobile IPv6
> [ 4.064097] NET: Registered protocol family 17
> [ 4.068583] mpls_gso: MPLS GSO support
> [ 4.072607] mce: Using 18 MCE banks
> [ 4.076127] sched_clock: Marking stable (3258784304, 817311072)->(4368614969, -292519593)
> [ 4.084498] registered taskstats version 1
> [ 4.088595] Loading compiled-in X.509 certificates
> [ 4.170505] Loaded X.509 cert 'Debian Secure Boot CA: 6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
> [ 4.179206] Loaded X.509 cert 'Debian Secure Boot Signer: 00a7468def'
> [ 4.185856] Loaded UEFI:db cert '统信软件技术有限公司: ae591c1c82b07dcaeabf404ca0dc5dd0fc54e9e9' linked to secondary sys keyring
> [ 4.198292] Loaded UEFI:db cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53' linked to secondary sys keyring
> [ 4.211332] Loaded UEFI:db cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4' linked to secondary sys keyring
> [ 4.224214] zswap: loaded using pool lzo/zbud
> [ 4.228638] AppArmor: AppArmor sha1 policy hashing enabled
> [ 4.234649] rtc_cmos 00:02: setting system clock to 2020-07-15 05:35:35 UTC (1594791335)
> [ 4.768309] Freeing unused kernel image memory: 1592K
> [ 4.773618] tsc: Refined TSC clocksource calibration: 2594.820 MHz
> [ 4.780137] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x25671eaff82, max_idle_ns: 440795239391 ns
> [ 4.790657] clocksource: Switched to clocksource tsc
> [ 4.797564] Write protecting the kernel read-only data: 16384k
> [ 4.805793] Freeing unused kernel image memory: 2028K
> [ 4.811332] Freeing unused kernel image memory: 728K
> [ 4.828663] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [ 4.835456] Run /init as init process
> [ 4.839515] [hook_mmap_file] command: init, device(2), mount(0), elf enabled: 1
> [ 4.847231] [hook_mmap_file] command: init, device(2), mount(0), elf enabled: 1
> [ 4.855051] [hook_mmap_file] command: init, device(2), mount(0), elf enabled: 1
> [ 4.862789] [hook_mmap_file] command: init, device(2), mount(0), elf enabled: 1
> [ 4.953349] button: module verification failed: signature and/or required key missing - tainting kernel
> [ 4.963676] ACPI: Video Device [EUMA] (multi-head: yes rom: no post: no)
> [ 4.971124] acpi device:17: registered as cooling_device4
> [ 4.971239] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
> [ 4.976847] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input2
> [ 4.985767] ACPI: Power Button [PWRB]
> [ 5.006675] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
> [ 5.014492] ACPI: Power Button [PWRF]
> [ 5.020660] SCSI subsystem initialized
> [ 5.024770] r8169 0000:07:00.0: can't disable ASPM; OS doesn't have ASPM control
> [ 5.024947] nvme nvme0: pci function 0000:06:00.0
> [ 5.038839] ACPI: bus type USB registered
> [ 5.043135] cryptd: max_cpu_qlen set to 1000
> [ 5.043353] usbcore: registered new interface driver usbfs
> [ 5.048452] libata version 3.00 loaded.
> [ 5.052292] libphy: r8169: probed
> [ 5.052604] r8169 0000:07:00.0 eth0: RTL8168g/8111g, 1c:83:41:27:53:c2, XID 4c000800, IRQ 43
> [ 5.052606] r8169 0000:07:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
> [ 5.053596] usbcore: registered new interface driver hub
> [ 5.080421] usbcore: registered new device driver usb
> [ 5.081717] r8169 0000:07:00.0 enp7s0: renamed from eth0
> [ 5.092587] AVX version of gcm_enc/dec engaged.
> [ 5.097345] AES CTR mode by8 optimization enabled
> [ 5.102790] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [ 5.111025] ehci-pci: EHCI PCI platform driver
> [ 5.111036] uhci_hcd: USB Universal Host Controller Interface driver
> [ 5.122633] ehci-pci 0000:00:0e.7: EHCI Host Controller
> [ 5.128149] ehci-pci 0000:00:0e.7: new USB bus registered, assigned bus number 1
> [ 5.128261] ahci 0000:00:0f.0: version 3.0
> [ 5.135923] ehci-pci 0000:00:0e.7: debug port 1
> [ 5.136174] ahci 0000:00:0f.0: SSS flag set, parallel bus scan disabled
> [ 5.140756] ehci-pci 0000:00:0e.7: irq 20, io mem 0xc048c000
> [ 5.154673] padlock_aes: Using PadLock ACE for AES algorithm.
> [ 5.157723] ahci 0000:00:0f.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
> [ 5.169248] ahci 0000:00:0f.0: flags: 64bit ncq sntf ilck stag led clo pio ccc ems sxs apst boh 
> [ 5.178481] ahci 0000:00:0f.0: both AHCI_HFLAG_MULTI_MSI flag set and custom irq handler implemented
> [ 5.181560] ehci-pci 0000:00:0e.7: USB 2.0 started, EHCI 1.00
> [ 5.194176] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
> [ 5.202892] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 5.210470] usb usb1: Product: EHCI Host Controller
> [ 5.215592] usb usb1: Manufacturer: Linux 4.19.0-6-amd64 ehci_hcd
> [ 5.221979] usb usb1: SerialNumber: 0000:00:0e.7
> [ 5.226985] hub 1-0:1.0: USB hub found
> [ 5.230936] hub 1-0:1.0: 2 ports detected
> [ 5.235286] xhci_hcd 0000:00:12.0: xHCI Host Controller
> [ 5.235288] uhci_hcd 0000:00:0e.0: UHCI Host Controller
> [ 5.240805] xhci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 2
> [ 5.246299] uhci_hcd 0000:00:0e.0: new USB bus registered, assigned bus number 3
> [ 5.257595] scsi host0: ahci
> [ 5.258205] nvme nvme0: Shutdown timeout set to 8 seconds
> [ 5.261823] uhci_hcd 0000:00:0e.0: detected 2 ports
> [ 5.265179] scsi host1: ahci
> [ 5.270440] uhci_hcd 0000:00:0e.0: Adjust the UHCI Controllers bit value patch V1.0.0
> [ 5.270471] uhci_hcd 0000:00:0e.0: irq 23, io base 0x0000f060
> [ 5.275662] ata1: SATA max UDMA/133 abar m8192@0xc0488000 port 0xc0488100 irq 44
> [ 5.278658] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
> [ 5.286846] ata2: SATA max UDMA/133 abar m8192@0xc0488000 port 0xc0488180 irq 45
> [ 5.292900] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 5.292902] usb usb3: Product: UHCI Host Controller
> [ 5.305694] nvme0n1: p1 p2 p3
> [ 5.309359] usb usb3: Manufacturer: Linux 4.19.0-6-amd64 uhci_hcd
> [ 5.339385] usb usb3: SerialNumber: 0000:00:0e.0
> [ 5.344348] hub 3-0:1.0: USB hub found
> [ 5.348291] hub 3-0:1.0: 2 ports detected
> [ 5.374428] xhci_hcd 0000:00:12.0: hcc params 0x00205fe3 hci version 0x110 quirks 0x0000000000000010
> [ 5.384161] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
> [ 5.392818] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 5.400412] usb usb2: Product: xHCI Host Controller
> [ 5.405560] usb usb2: Manufacturer: Linux 4.19.0-6-amd64 xhci-hcd
> [ 5.411964] usb usb2: SerialNumber: 0000:00:12.0
> [ 5.416962] hub 2-0:1.0: USB hub found
> [ 5.420913] hub 2-0:1.0: 2 ports detected
> [ 5.425289] xhci_hcd 0000:00:12.0: xHCI Host Controller
> [ 5.425299] ehci-pci 0000:00:10.7: EHCI Host Controller
> [ 5.430797] xhci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 4
> [ 5.436294] ehci-pci 0000:00:10.7: new USB bus registered, assigned bus number 5
> [ 5.444025] With Zhaoxin xHCI root hub speed patch V1.0.0.
> [ 5.444027] xhci_hcd 0000:00:12.0: Host supports USB 3.1 SuperSpeed
> [ 5.444047] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
> [ 5.451857] ehci-pci 0000:00:10.7: debug port 1
> [ 5.457631] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
> [ 5.464206] ehci-pci 0000:00:10.7: irq 21, io mem 0xc048b000
> [ 5.472616] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 5.472618] usb usb4: Product: xHCI Host Controller
> [ 5.472620] usb usb4: Manufacturer: Linux 4.19.0-6-amd64 xhci-hcd
> [ 5.511108] usb usb4: SerialNumber: 0000:00:12.0
> [ 5.516052] hub 4-0:1.0: USB hub found
> [ 5.520015] hub 4-0:1.0: 2 ports detected
> [ 5.615730] ata1: SATA link down (SStatus 0 SControl 300)
> [ 5.935727] ata2: SATA link down (SStatus 0 SControl 300)
> [ 6.217565] ehci-pci 0000:00:10.7: USB 2.0 started, EHCI 1.00
> [ 6.223659] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
> [ 6.232311] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 6.239865] usb usb5: Product: EHCI Host Controller
> [ 6.244970] usb usb5: Manufacturer: Linux 4.19.0-6-amd64 ehci_hcd
> [ 6.251347] usb usb5: SerialNumber: 0000:00:10.7
> [ 6.256333] hub 5-0:1.0: USB hub found
> [ 6.260262] hub 5-0:1.0: 4 ports detected
> [ 6.264675] uhci_hcd 0000:00:10.0: UHCI Host Controller
> [ 6.264678] xhci_hcd 0000:01:00.0: xHCI Host Controller
> [ 6.270197] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 6
> [ 6.275701] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 7
> [ 6.283472] uhci_hcd 0000:00:10.0: detected 2 ports
> [ 6.296300] uhci_hcd 0000:00:10.0: Adjust the UHCI Controllers bit value patch V1.0.0
> [ 6.304553] uhci_hcd 0000:00:10.0: irq 20, io base 0x0000f020
> [ 6.310658] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
> [ 6.319326] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 6.326885] usb usb6: Product: UHCI Host Controller
> [ 6.331982] usb usb6: Manufacturer: Linux 4.19.0-6-amd64 uhci_hcd
> [ 6.338393] usb usb6: SerialNumber: 0000:00:10.0
> [ 6.343339] hub 6-0:1.0: USB hub found
> [ 6.347240] hub 6-0:1.0: 2 ports detected
> [ 6.349563] usb 3-1: new low-speed USB device number 2 using uhci_hcd
> [ 6.351732] uhci_hcd 0000:00:10.1: UHCI Host Controller
> [ 6.351822] xhci_hcd 0000:01:00.0: hcc params 0x0200e081 hci version 0x100 quirks 0x0000000010000410
> [ 6.352133] usb usb7: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
> [ 6.352135] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 6.352136] usb usb7: Product: xHCI Host Controller
> [ 6.352138] usb usb7: Manufacturer: Linux 4.19.0-6-amd64 xhci-hcd
> [ 6.352139] usb usb7: SerialNumber: 0000:01:00.0
> [ 6.352265] hub 7-0:1.0: USB hub found
> [ 6.352276] hub 7-0:1.0: 2 ports detected
> [ 6.352426] xhci_hcd 0000:01:00.0: xHCI Host Controller
> [ 6.352430] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 8
> [ 6.352435] xhci_hcd 0000:01:00.0: Host supports USB 3.0 Enhanced SuperSpeed
> [ 6.352488] usb usb8: We don't know the algorithms for LPM for this host, disabling LPM.
> [ 6.352531] usb usb8: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
> [ 6.352532] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 6.352534] usb usb8: Product: xHCI Host Controller
> [ 6.352535] usb usb8: Manufacturer: Linux 4.19.0-6-amd64 xhci-hcd
> [ 6.352537] usb usb8: SerialNumber: 0000:01:00.0
> [ 6.352652] hub 8-0:1.0: USB hub found
> [ 6.352662] hub 8-0:1.0: 2 ports detected
> [ 6.484110] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 9
> [ 6.491908] uhci_hcd 0000:00:10.1: detected 2 ports
> [ 6.497041] uhci_hcd 0000:00:10.1: Adjust the UHCI Controllers bit value patch V1.0.0
> [ 6.505297] uhci_hcd 0000:00:10.1: irq 22, io base 0x0000f000
> [ 6.511422] usb usb9: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
> [ 6.520127] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 6.527686] usb usb9: Product: UHCI Host Controller
> [ 6.532831] usb usb9: Manufacturer: Linux 4.19.0-6-amd64 uhci_hcd
> [ 6.539238] usb usb9: SerialNumber: 0000:00:10.1
> [ 6.544217] hub 9-0:1.0: USB hub found
> [ 6.548188] hub 9-0:1.0: 2 ports detected
> [ 6.564629] usb 3-1: New USB device found, idVendor=17ef, idProduct=608d, bcdDevice= 1.00
> [ 6.573238] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [ 6.580728] usb 3-1: Product: lenovo USB Optical Mouse
> [ 6.586151] usb 3-1: Manufacturer: PixArt
> [ 6.597586] usb 5-3: new high-speed USB device number 2 using ehci-pci
> [ 6.605809] hidraw: raw HID events driver (C) Jiri Kosina
> [ 6.623898] usbcore: registered new interface driver usbhid
> [ 6.629762] usbhid: USB HID core driver
> [ 6.635128] input: PixArt lenovo USB Optical Mouse as /devices/pci0000:00/0000:00:0e.0/usb3/3-1/3-1:1.0/0003:17EF:608D.0001/input/input4
> [ 6.648121] hid-generic 0003:17EF:608D.0001: input,hidraw0: USB HID v1.11 Mouse [PixArt lenovo USB Optical Mouse] on usb-0000:00:0e.0-1/input0
> [ 6.693570] usb 7-1: new high-speed USB device number 2 using xhci_hcd
> [ 6.753564] raid6: sse2x1 gen() 2602 MB/s
> [ 6.767178] usb 5-3: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice=60.60
> [ 6.775757] usb 5-3: New USB device strings: Mfr=0, Product=1, SerialNumber=0
> [ 6.783240] usb 5-3: Product: USB2.0 Hub
> [ 6.787718] hub 5-3:1.0: USB hub found
> [ 6.791930] hub 5-3:1.0: 4 ports detected
> [ 6.825562] raid6: sse2x1 xor() 2711 MB/s
> [ 6.875601] usb 7-1: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.36
> [ 6.884204] usb 7-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [ 6.891731] usb 7-1: Product: 4-Port USB 2.0 Hub
> [ 6.896568] usb 7-1: Manufacturer: Generic
> [ 6.897567] raid6: sse2x2 gen() 3321 MB/s
> [ 6.904497] hub 7-1:1.0: USB hub found
> [ 6.910383] hub 7-1:1.0: 4 ports detected
> [ 6.969557] raid6: sse2x2 xor() 3026 MB/s
> [ 6.998392] usb 8-1: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
> [ 7.041552] raid6: sse2x4 gen() 4034 MB/s
> [ 7.042803] usb 8-1: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 1.36
> [ 7.054644] usb 8-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [ 7.062105] usb 8-1: Product: 4-Port USB 3.0 Hub
> [ 7.066943] usb 8-1: Manufacturer: Generic
> [ 7.079563] hub 8-1:1.0: USB hub found
> [ 7.085311] hub 8-1:1.0: 4 ports detected
> [ 7.089560] usb 5-3.1: new low-speed USB device number 3 using ehci-pci
> [ 7.113555] raid6: sse2x4 xor() 4521 MB/s
> [ 7.118049] raid6: using algorithm sse2x4 gen() 4034 MB/s
> [ 7.123689] raid6: .... xor() 4521 MB/s, rmw enabled
> [ 7.128921] raid6: using ssse3x2 recovery algorithm
> [ 7.134407] xor: automatically using best checksumming function avx 
> [ 7.142090] async_tx: api initialized (async)
> [ 7.205062] Btrfs loaded, crc32c=crc32c-intel
> [ 7.209561] usb 7-1.1: new full-speed USB device number 3 using xhci_hcd
> [ 7.216991] usb 5-3.1: New USB device found, idVendor=17ef, idProduct=6099, bcdDevice= 1.14
> [ 7.225800] usb 5-3.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [ 7.233460] usb 5-3.1: Product: Lenovo Traditional USB Keyboard
> [ 7.239667] usb 5-3.1: Manufacturer: LiteOn
> [ 7.249150] input: LiteOn Lenovo Traditional USB Keyboard as /devices/pci0000:00/0000:00:10.7/usb5/5-3/5-3.1/5-3.1:1.0/0003:17EF:6099.0002/input/input5
> [ 7.321707] hid-generic 0003:17EF:6099.0002: input,hidraw1: USB HID v1.11 Keyboard [LiteOn Lenovo Traditional USB Keyboard] on usb-0000:00:10.7-3.1/input0
> [ 7.340731] input: LiteOn Lenovo Traditional USB Keyboard System Control as /devices/pci0000:00/0000:00:10.7/usb5/5-3/5-3.1/5-3.1:1.1/0003:17EF:6099.0003/input/input6
> [ 7.413599] input: LiteOn Lenovo Traditional USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:10.7/usb5/5-3/5-3.1/5-3.1:1.1/0003:17EF:6099.0003/input/input7
> [ 7.429446] hid-generic 0003:17EF:6099.0003: input,hidraw2: USB HID v1.11 Device [LiteOn Lenovo Traditional USB Keyboard] on usb-0000:00:10.7-3.1/input1
> [ 7.466443] PM: Image not found (code -22)
> [ 7.520827] EXT4-fs (nvme0n1p2): mounting ext3 file system using the ext4 subsystem
> [ 7.530204] EXT4-fs (nvme0n1p2): mounted filesystem with ordered data mode. Opts: (null)
> [ 7.618747] partition count: 1, comm[1]: init, path: /usr/lib/systemd/systemd, cmdline: (null)
> [ 7.630282] [hook_mmap_file] command: init, device(2), mount(2), elf enabled: 0
> [ 7.666653] usb 7-1.1: New USB device found, idVendor=17ef, idProduct=a012, bcdDevice= 0.55
> [ 7.675450] usb 7-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 7.683140] usb 7-1.1: Product: Thinkcentre TIO24Gen3 for USB-audio
> [ 7.689752] usb 7-1.1: Manufacturer: Lenovo
> [ 7.689756] systemd[1]: RTC configured in localtime, applying delta of 480 minutes to system time.
> [ 7.694173] usb 7-1.1: SerialNumber: 000000000000
> [ 7.714878] systemd[1]: Inserted module 'autofs4'
> [ 7.747446] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> [ 7.769967] systemd[1]: Detected architecture x86-64.
> [ 7.778034] systemd[1]: Set hostname to .
> [ 7.852260] input: Lenovo Thinkcentre TIO24Gen3 for USB-audio Consumer Control as /devices/pci0000:00/0000:00:03.0/0000:01:00.0/usb7/7-1/7-1.1/7-1.1:1.3/0003:17EF:A012.0004/input/input8
> [ 7.886203] systemd[1]: /lib/systemd/system/smbd.service:9: PIDFile= references path below legacy directory /var/run/, updating /var/run/samba/smbd.pid → /run/samba/smbd.pid; please update the unit file accordingly.
> [ 7.909171] systemd[1]: /lib/systemd/system/nmbd.service:9: PIDFile= references path below legacy directory /var/run/, updating /var/run/samba/nmbd.pid → /run/samba/nmbd.pid; please update the unit file accordingly.
> [ 7.929599] input: Lenovo Thinkcentre TIO24Gen3 for USB-audio as /devices/pci0000:00/0000:00:03.0/0000:01:00.0/usb7/7-1/7-1.1/7-1.1:1.3/0003:17EF:A012.0004/input/input9
> [ 7.941458] systemd[1]: Configuration file /lib/systemd/system/deepin-elf-verify.service is marked executable. Please remove executable permission bits. Proceeding anyway.
> [ 7.945524] hid-generic 0003:17EF:A012.0004: input,hiddev0,hidraw3: USB HID v1.00 Device [Lenovo Thinkcentre TIO24Gen3 for USB-audio] on usb-0000:01:00.0-1.1/input3
> [ 7.974125] systemd[1]: Listening on Journal Socket (/dev/log).
> [ 7.984218] systemd[1]: Created slice system-getty.slice.
> [ 7.990483] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
> [ 8.001559] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> [ 8.036569] vfs_monitor: loading out-of-tree module taints kernel.
> [ 8.043640] EXT4-fs (nvme0n1p2): re-mounted. Opts: (null)
> [ 8.052295] mp: /, major: 3, minor: 2
> [ 8.057323] partition count: 1, comm[344]: systemd-modules, path: /usr/lib/systemd/systemd-modules-load, cmdline: /lib/systemd/systemd-modules-load
> [ 8.073569] usb 7-1.2: new high-speed USB device number 4 using xhci_hcd
> [ 8.189079] register_kretprobes 10 ok
> [ 8.220760] usb 7-1.2: New USB device found, idVendor=2ef4, idProduct=4255, bcdDevice= 0.13
> [ 8.230702] usb 7-1.2: New USB device strings: Mfr=3, Product=1, SerialNumber=2
> [ 8.239760] usb 7-1.2: Product: FULL HD 1080P Webcam
> [ 8.239762] usb 7-1.2: Manufacturer: Generic
> [ 8.252243] usb 7-1.2: SerialNumber: 200901010001
> [ 8.268930] systemd-journald[348]: Received request to flush runtime journal from PID 1
> [ 8.278896] systemd-journald[348]: File /var/log/journal/656f5626c57c49ff9e927c0dde45e254/system.journal corrupted or uncleanly shut down, renaming and replacing.
> [ 8.720714] acpi_cpufreq: acpi_cpufreq: failed to register hotplug callbacks
> [ 8.745970] ACPI: AC Adapter [ACDP] (on-line)
> [ 8.832099] zx_core: module license 'Zhaoxin' taints kernel.
> [ 8.838085] Disabling lock debugging due to kernel taint
> [ 8.858296] input: PC Speaker as /devices/platform/pcspkr/input/input10
> [ 8.894687] EFI Variables Facility v0.08 2004-May-17
> [ 8.941768] pstore: Using compression: deflate
> [ 8.950628] HDAC: Support Zhaoxin HDAC ID patch V1.0.0
> [ 8.956493] HDAC: Zhaoxin GFX HDAC patch V2.0.1
> [ 8.958245] Adding 8388604k swap on /dev/nvme0n1p3. Priority:-2 extents:1 across:8388604k SSFS
> [ 8.987405] pstore: Registered efi as persistent store backend
> [ 9.056910] zx info: Shanghai Zhaoxin Semiconductor Co., Ltd.
> [ 9.062972] zx info: Version: 21.00.16 Build on: 02/25/2020
> [ 9.085591] snd_hda_intel 0000:00:01.1: enabling device (0000 -> 0002)
> [ 9.106377] partition /boot/efi [3, 1] added, comm[552]: mount
> [ 9.117761] snd_hda_intel 0000:00:01.1: Disabling MSI
> [ 9.121657] zx info: bus_command: 0x7.
> [ 9.123078] snd_hda_intel 0000:00:01.1: Using LPIB position fix
> [ 9.164993] zx info: *******revision id:0
> [ 9.201183] snd_hda_intel 0000:00:01.1: zx_hda can't get pci_dev 
> [ 9.207647] HDAC: Support Zhaoxin HDAC ID patch V1.0.0
> [ 9.213089] HDAC: Zhaoxin GFX HDAC patch V2.0.1
> [ 9.219024] snd_hda_intel 0000:00:01.1: chipset global capabilities = 0x2001
> [ 9.219034] snd_hda_intel 0000:00:01.1: Clearing TCSEL
> [ 9.219560] zx info: EFI VGA detected, conflicted with zxfb, remove EFI VGA.
> [ 9.222952] snd_hda_intel 0000:00:01.1: CORB reset timeout#1, CORBRP = 0
> [ 9.237727] snd_hda_intel 0000:00:01.1: codec #1 probed OK
> [ 9.237867] snd_hda_intel 0000:00:01.1: codec #2 probed OK
> [ 9.237869] snd_hda_intel 0000:00:01.1: snd_hda_codec_device_init: entry
> [ 9.238910] snd_hda_intel 0000:00:01.1: snd_hda_codec_device_new: entry
> [ 9.239706] snd_hda_intel 0000:00:01.1: snd_hda_codec_device_init: entry
> [ 9.240720] snd_hda_intel 0000:00:01.1: snd_hda_codec_device_new: entry
> [ 9.266095] Console: switching to colour dummy device 80x25
> [ 9.281913] zx 0000:00:01.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=io+mem
> [ 9.291536] zx info: zx->freezable_patch : 0x2.
> [ 9.296321] zx info: query dma mask: ffffffffff
> [ 9.323382] RNG detected
> [ 9.329337] snd_hda_codec_hdmi hdaudioC0D1: zx_hda patch version 002 
> [ 9.338783] snd_hda_codec_hdmi hdaudioC0D1: HDMI status: Codec=1 Pin=3 Presence_Detect=0 ELD_Valid=0
> [ 9.339260] snd_hda_codec_hdmi hdaudioC0D2: zx_hda patch version 002 
> [ 9.350378] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=0 ELD_Valid=0
> [ 9.350564] snd_hda_intel 0000:00:14.0: chipset global capabilities = 0x4401
> [ 9.350581] snd_hda_intel 0000:00:14.0: Clearing TCSEL
> [ 9.351459] input: HDA Zhaoxin GFX HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/sound/card0/input11
> [ 9.364773] snd_hda_intel 0000:00:14.0: codec #0 probed OK
> [ 9.364776] snd_hda_intel 0000:00:14.0: snd_hda_codec_device_init: entry
> [ 9.365120] snd_hda_intel 0000:00:14.0: snd_hda_codec_device_new: entry
> [ 9.368202] input: HDA Zhaoxin GFX HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.1/sound/card0/input12
> [ 9.392983] zx info: bus_command: 0x7.
> [ 9.508649] cputemp cputemp.0: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> [ 9.519313] zx info: *******revision id:0
> [ 9.529439] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 9.529443] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 9.530811] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC233: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> [ 9.542366] snd_hda_codec_realtek hdaudioC1D0: speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [ 9.542369] snd_hda_codec_realtek hdaudioC1D0: hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
> [ 9.542370] snd_hda_codec_realtek hdaudioC1D0: mono: mono_out=0x0
> [ 9.542372] snd_hda_codec_realtek hdaudioC1D0: inputs:
> [ 9.545761] cputemp cputemp.1: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> [ 9.549566] snd_hda_codec_realtek hdaudioC1D0: Mic=0x1a
> [ 9.549568] snd_hda_codec_realtek hdaudioC1D0: Front Mic=0x19
> [ 9.549570] snd_hda_codec_realtek hdaudioC1D0: realtek: Enable default setup for auto mode as fallback
> [ 9.550415] snd_hda_codec_realtek hdaudioC1D0: ==> lo_type=2, wired=1, mio=1, badness=0x0
> [ 9.550418] snd_hda_codec_realtek hdaudioC1D0: multi_outs = 21/0/0/0 : 3/0/0/0 (type HP)
> [ 9.550421] snd_hda_codec_realtek hdaudioC1D0: out path: depth=3 '03:0d:21'
> [ 9.550423] snd_hda_codec_realtek hdaudioC1D0: spk_outs = 14/0/0/0 : 2/0/0/0
> [ 9.550425] snd_hda_codec_realtek hdaudioC1D0: spk path: depth=3 '02:0c:14'
> [ 9.550427] snd_hda_codec_realtek hdaudioC1D0: ==> Best config: lo_type=2, wired=1, mio=1
> [ 9.550429] snd_hda_codec_realtek hdaudioC1D0: multi_outs = 21/0/0/0 : 3/0/0/0 (type HP)
> [ 9.550431] snd_hda_codec_realtek hdaudioC1D0: out path: depth=3 '03:0d:21'
> [ 9.550433] snd_hda_codec_realtek hdaudioC1D0: spk_outs = 14/0/0/0 : 2/0/0/0
> [ 9.550435] snd_hda_codec_realtek hdaudioC1D0: spk path: depth=3 '02:0c:14'
> [ 9.550543] snd_hda_codec_realtek hdaudioC1D0: loopback path: depth=2 '1a:0b'
> [ 9.550830] snd_hda_codec_realtek hdaudioC1D0: input path: depth=3 '1a:23:08'
> [ 9.551122] snd_hda_codec_realtek hdaudioC1D0: input path: depth=3 '1a:22:09'
> [ 9.551167] snd_hda_codec_realtek hdaudioC1D0: loopback path: depth=2 '19:0b'
> [ 9.551170] snd_hda_codec_realtek hdaudioC1D0: input path: depth=3 '19:23:08'
> [ 9.551172] snd_hda_codec_realtek hdaudioC1D0: input path: depth=3 '19:22:09'
> [ 9.551175] snd_hda_codec_realtek hdaudioC1D0: Enable HP auto-muting on NID 0x21
> [ 9.551187] snd_hda_codec_realtek hdaudioC1D0: Enable auto-mic switch on NID 0x1a/0x19/0x0
> [ 9.551880] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 9.551885] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 9.594279] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 9.606060] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 9.610638] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 9.610641] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 9.611153] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:14.0/sound/card1/input13
> [ 9.618788] cputemp cputemp.2: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> [ 9.638103] input: HDA Zhaoxin Mic as /devices/pci0000:00/0000:00:14.0/sound/card1/input14
> [ 9.664655] input: HDA Zhaoxin Front Mic as /devices/pci0000:00/0000:00:14.0/sound/card1/input15
> [ 9.665708] cputemp cputemp.3: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> [ 9.673980] zx info: video memory size: 512M.
> [ 9.673983] zx info: pwm_level.EnablePowerGating.
> [ 9.693672] input: HDA Zhaoxin Front Headphone as /devices/pci0000:00/0000:00:14.0/sound/card1/input16
> [ 9.729775] padlock_sha: Using PadLock ACE for SHA1/SHA256 algorithms.
> [ 9.870701] [DISP] General Info: 
> CBIOS:cbGetSysBiosInfo:pcbe->SysBiosInfo.BootUpDev = 0x0!
> [ 9.881045] [DISP] General Info: cbUpdateShadowInfo_chx: FBSize = 512M DRAMMode = 1 bSnoopOnly = 0
> 
> [ 10.030911] [DISP] General Info: vcp_init_data size = 256
> [ 10.047856] [DISP] General Info: pRomBase addr = 81f03000
> [ 10.062700] IPv6: ADDRCONF(NETDEV_UP): enp7s0: link is not ready
> [ 10.071681] r8169 0000:07:00.0: firmware: direct-loading firmware rtl_nic/rtl8168g-2.fw
> [ 10.080772] Generic PHY r8169-700:00: attached PHY driver [Generic PHY] (mii_bus:phy_addr=r8169-700:00, irq=IGNORE)
> [ 10.169847] [DISP] General Error: cb_GetRegistryParameters is CBIOS_NULL!
> [ 10.191612] media: Linux media interface: v0.10
> [ 10.212458] [DISP] General Error: cb_GetRegistryParameters is CBIOS_NULL!
> [ 10.229635] IPv6: ADDRCONF(NETDEV_UP): enp7s0: link is not ready
> [ 10.292454] videodev: Linux video capture interface: v2.00
> [ 10.353625] zx info: disp cbios_init_hw finished.
> [ 10.358581] zx info: bios supported device: 0x18001
> [ 10.363740] zx info: low_top_address : 0xa0000000
> [ 10.368696] zx info: snoop only: 0
> [ 10.372291] zx info: ta_enable (iov enable): 0
> [ 10.416483] uvcvideo: Found UVC 1.00 device FULL HD 1080P Webcam (2ef4:4255)
> [ 10.438096] uvcvideo 7-1.2:1.0: Entity type for entity Extension 4 was not initialized!
> [ 10.445626] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [ 10.453446] [drm] Driver supports precise vblank timestamp query.
> [ 10.453996] uvcvideo 7-1.2:1.0: Entity type for entity Processing 2 was not initialized!
> [ 10.468370] uvcvideo 7-1.2:1.0: Entity type for entity Camera 1 was not initialized!
> [ 10.477193] usbcore: registered new interface driver snd-usb-audio
> [ 10.480195] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 10.483714] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 10.501199] input: FULL HD 1080P Webcam: FULL HD 1 as /devices/pci0000:00/0000:00:03.0/0000:01:00.0/usb7/7-1/7-1.2/7-1.2:1.0/input/input17
> [ 10.533945] usbcore: registered new interface driver uvcvideo
> [ 10.539988] USB Video Class driver (1.1.1)
> [ 10.578963] [DISP] DP Info: cbDPMonitor_Detect: DP device(0x8000) is not connected!
> [ 10.704198] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: HDMI device on dual mode DP port!
> [ 10.713784] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: DP monitor supported bpc = 8
> [ 10.750909] [DISP] General Info: codec#1 interrupt!
> [ 10.757993] fbcon: zxfb (fb0) is primary device
> [ 10.758036] zx info: To set par on drm fb.
> [ 10.760150] zx info: KMS set mode to path(iga_index-->active_device): 1-->0x10000.
> [ 10.760153] [DISP] General Info: SourceMode: 1920 x 1080!
> [ 10.760154] [DISP] General Info: DestMode: 1920 x 1080 @ 6000!
> [ 10.760155] [DISP] General Info: ScalerMode: 1920 x 1080!
> [ 10.760156] [DISP] General Info: Interlace=0, Signal=1, AsRatio=0, Bpc=8!
> [ 10.760161] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 10.762512] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 10.762514] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 10.762541] zx info: CRTC atomic enable: to turn on vblank and screen of crtc: 1
> [ 10.762547] zx info: To turn on power of device: 0x10000.
> [ 10.798498] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 10.802602] [DISP] DP Info: cbDPPort_OnOff: status = On.
> [ 10.802784] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 10.805679] snd_hda_codec_hdmi hdaudioC0D1: HDMI status: Codec=1 Pin=3 Presence_Detect=0 ELD_Valid=0
> [ 10.805698] [DISP] General Info: codec#1 interrupt!
> [ 10.806162] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=1
> [ 10.811179] snd_hda_codec_hdmi hdaudioC0D2: HDMI: detected monitor TIO24Gen3 at connection type HDMI
> [ 10.811182] snd_hda_codec_hdmi hdaudioC0D2: HDMI: available speakers: FL/FR
> [ 10.811186] snd_hda_codec_hdmi hdaudioC0D2: HDMI: supports coding type LPCM: channels = 2, rates = 32000 44100 48000, bits = 16 20 24
> [ 10.811208] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=0
> [ 10.811212] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 10.811344] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=1
> [ 10.811984] Console: switching to colour frame buffer device 240x67
> [ 10.816446] snd_hda_codec_hdmi hdaudioC0D2: HDMI: detected monitor TIO24Gen3 at connection type HDMI
> [ 10.816448] snd_hda_codec_hdmi hdaudioC0D2: HDMI: available speakers: FL/FR
> [ 10.816452] snd_hda_codec_hdmi hdaudioC0D2: HDMI: supports coding type LPCM: channels = 2, rates = 32000 44100 48000, bits = 16 20 24
> [ 10.967886] zx 0000:00:01.0: fb0: zxfb frame buffer device
> [ 11.009679] zx info: zx can used system memory size: 7644384k. set zx max used size as: 7316704k.
> [ 11.029595] zx info: segment[1]: range: [ 0M -> 511M), size: 511M, start reserved: 8128k
> [ 11.038864] zx info: segment[2]: range: [ 512M -> 2048M), size: 1536M, start reserved: 0k
> [ 11.050724] zx info: segment[3]: range: [2048M -> 2560M), size: 512M, start reserved: 0k
> [ 11.063648] zx info: vesa_tempbuffer_enable: temp allocation 1920*1080*4
> [ 11.072882] zx info: flush_fifo_buffer: gpu_virt_addr=7fc00000, kmd_virt_addr=000000002e76035a
> [ 11.081996] zx info: reg_Mxu_Ctl2,Sys_Vid_Boundary:0x1f, Cam_Sys_Boundary:0x9f.
> [ 11.089649] zx info: reg_Mxu_Ctl2,Virtual_Boundary:0x9f, Snoop_Boundary:0x7f.
> [ 11.097180] zx info: set reg_Mxu_Timeout2 mmio0x490AC = 0x3.
> [ 11.105635] zx info: create fence buffer total num 8704 
> [ 11.111251] zx info: fence buffer segment_id:2, gpu_virt_addr:20000000
> [ 11.119306] zx info: schedule_serialize[0] = 1
> [ 11.129007] zx info: engine0 reserved_memory segment_id:2 gpu_virt_addr:6f9c0000
> [ 11.157659] zx info: schedule_serialize[1] = 0
> [ 11.182226] zx info: engine1 reserved_memory segment_id:2 gpu_virt_addr:6f880000
> [ 11.191531] zx info: schedule_serialize[4] = 0
> [ 11.201578] zx info: engine4 reserved_memory segment_id:2 gpu_virt_addr:6f740000
> [ 11.209145] usb 7-1.1: 2:1: cannot get freq at ep 0x1
> [ 11.212240] zx info: PwmSupportFlags(hw_caps.pwm_auto) : 0x1.
> [ 11.226573] zx info: schedule_serialize[5] = 1
> [ 11.240106] zx info: engine5 reserved_memory segment_id:2 gpu_virt_addr:6f600000
> [ 11.269728] zx info: adapter->ctl_flags.worker_thread_enable 1
> [ 11.275902] zx info: hw caps: secure:0, snoop:1, 64K_page:0, Paging:1, LCS:0, PG_swizzle:0.
> [ 11.284718] zx info: Ctrl: Recovery:1, WK-thread:1, Hang-Dump:0, Debug-Secure:0, OneShot:0, RunOnQT:0, HotPlug-Polling:1, PwmMode:2, RebootPatch:0, NonsnoopEnable:1, Force3DBlt:1
> [ 11.305958] input: Elite Remote Control Driver as /devices/virtual/input/input18
> [ 11.318237] zx info: zx = 000000004f3d07f1, zx->pdev = 00000000f5d77e27, dev = 00000000a2595505, dev->primary = 0000000032e29343
> [ 11.333003] [drm] Initialized zx 33.0.22 02/25/2020 for 0000:00:01.0 on minor 0
> [ 11.474957] [DISP] DP Info: cbDPMonitor_Detect: DP device(0x8000) is not connected!
> [ 11.562685] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: HDMI device on dual mode DP port!
> [ 11.572324] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: DP monitor supported bpc = 8
> [ 11.686949] [DISP] DP Info: cbDPMonitor_Detect: DP device(0x8000) is not connected!
> [ 11.772846] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: HDMI device on dual mode DP port!
> [ 11.782486] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: DP monitor supported bpc = 8
> [ 12.292288] zx info: Gamma of crtc-1 changed, to load gamma table.
> [ 12.654022] r8169 0000:07:00.0 enp7s0: Link is Up - 1Gbps/Full - flow control off
> [ 12.661899] IPv6: ADDRCONF(NETDEV_CHANGE): enp7s0: link becomes ready
> [ 12.730992] [DISP] DP Info: cbDPMonitor_Detect: DP device(0x8000) is not connected!
> [ 12.819478] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: HDMI device on dual mode DP port!
> [ 12.829114] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: DP monitor supported bpc = 8
> [ 12.978964] [DISP] DP Info: cbDPMonitor_Detect: DP device(0x8000) is not connected!
> [ 13.064136] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: HDMI device on dual mode DP port!
> [ 13.073735] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: DP monitor supported bpc = 8
> [ 14.843562] fuse init (API version 7.27)
> [ 184.935894] PM: suspend entry (deep)
> [ 184.939696] PM: Syncing filesystems ... done.
> [ 184.956593] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [ 184.965772] OOM killer disabled.
> [ 184.969198] Freezing remaining freezable tasks ... 
> [ 184.969276] zx info: sleep render thread 0.
> [ 184.969299] zx info: sleep render thread 5.
> [ 184.969300] zx info: sleep render thread 4.
> [ 184.969301] zx info: sleep render thread 1.
> [ 184.992506] (elapsed 0.023 seconds) done.
> [ 184.996676] Suspending console(s) (use no_console_suspend to debug)
> [ 185.003988] serial 00:03: disabled
> [ 185.004994] zx info: pci device(vendor:0x1D17, device:0x3A04) pm suspend
> [ 185.004995] zx info: zx driver suspending, pm event = 2.
> [ 185.005215] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 185.005352] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=0
> [ 185.005357] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 185.005498] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=0
> [ 185.006210] zx info: To turn off power of device: 0x10000.
> [ 185.015110] [DISP] DP Info: cbDPPort_OnOff: status = Off.
> [ 185.015112] zx info: CRTC atomic disable: to turn off vblank and screen of crtc: 1
> [ 185.029457] zx info: drm suspend: save display status finished.
> [ 185.063825] zx info: drm suspend: save drmfb status finished.
> [ 185.063827] zx info: drm suspend: disable irq finished.
> [ 185.063865] zx info: drm suspend: deinit and uninstall irq finished.
> [ 186.148614] ACPI: Preparing to enter system sleep state S3
> [ 186.148956] PM: Saving platform NVS memory
> [ 186.148976] Disabling non-boot CPUs ...
> [ 186.165826] smpboot: CPU 1 is now offline
> [ 186.181851] smpboot: CPU 2 is now offline
> [ 186.197936] smpboot: CPU 3 is now offline
> [ 186.200822] ACPI: Low-level resume complete
> [ 186.200854] PM: Restoring platform NVS memory
> [ 186.201321] Enabling non-boot CPUs ...
> [ 186.201364] x86: Booting SMP configuration:
> [ 186.201365] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 186.212306] With Zhaoxin Shanghai CPU patch V2.0.0
> [ 186.212310] Got Zhaoxin CPU topology from cpuid B leaf, 4 leaf patch V1.0.0
> [ 186.212312] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
> [ 186.212505] cache: parent cpu1 should not be sleeping
> [ 186.212728] platform cputemp.1: parent platform should not be sleeping
> [ 186.212852] CPU1 is up
> [ 186.212881] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 186.223820] With Zhaoxin Shanghai CPU patch V2.0.0
> [ 186.223824] Got Zhaoxin CPU topology from cpuid B leaf, 4 leaf patch V1.0.0
> [ 186.223826] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
> [ 186.224006] cache: parent cpu2 should not be sleeping
> [ 186.224237] platform cputemp.2: parent platform should not be sleeping
> [ 186.224387] CPU2 is up
> [ 186.224417] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 186.235356] With Zhaoxin Shanghai CPU patch V2.0.0
> [ 186.235360] Got Zhaoxin CPU topology from cpuid B leaf, 4 leaf patch V1.0.0
> [ 186.235362] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
> [ 186.235543] cache: parent cpu3 should not be sleeping
> [ 186.235772] platform cputemp.3: parent platform should not be sleeping
> [ 186.235945] CPU3 is up
> [ 186.236889] ACPI: Waking up from system sleep state S3
> [ 186.277983] zx info: pci device(vendor:0x1D17, device:0x3A04) pm resume
> [ 186.277984] zx info: zx driver resume back.
> [ 186.277999] snd_hda_intel 0000:00:01.1: Clearing TCSEL
> [ 186.278048] usb usb3: root hub lost power or was reset
> [ 186.278160] snd_hda_intel 0000:00:14.0: Clearing TCSEL
> [ 186.278435] usb usb6: root hub lost power or was reset
> [ 186.278484] usb usb9: root hub lost power or was reset
> [ 186.278904] serial 00:03: activated
> [ 186.279038] usb usb7: root hub lost power or was reset
> [ 186.279039] usb usb8: root hub lost power or was reset
> [ 186.283711] snd_hda_intel 0000:00:01.1: CORB reset timeout#1, CORBRP = 0
> [ 186.284528] snd_hda_codec_hdmi hdaudioC0D1: HDMI status: Codec=1 Pin=3 Presence_Detect=0 ELD_Valid=0
> [ 186.284672] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=0 ELD_Valid=0
> [ 186.290942] zx info: disp cbios_init_hw finished.
> [ 186.290943] zx info: drm resume: enable and post chip finished.
> [ 186.290990] zx info: drm resume: re-init and install irq finished.
> [ 186.290992] zx info: drm resume: re-enable irq finished.
> [ 186.293396] zx info: drm resume: restore drmfb status finished.
> [ 186.293399] zx info: pm_restore_state enter, cur time 185464(ms)
> [ 186.293400] zx info: glb_init_chip_interface finish, cur time 185464(ms)
> [ 186.294197] zx info: vidmm_restore finish, cur time 185465(ms)
> [ 186.297395] zx info: after reset......
> [ 186.297397] zx info: current engine staus is 0x0 
> [ 186.297399] zx info: current power mgr staus0 is 0xff00fdfd 
> [ 186.297400] zx info: current power mgr staus1 is 0xffffc01f 
> [ 186.297400] zx info: done......
> [ 186.297403] zx info: reg_Mxu_Ctl2,Sys_Vid_Boundary:0x1f, Cam_Sys_Boundary:0x9f.
> [ 186.297404] zx info: reg_Mxu_Ctl2,Virtual_Boundary:0x9f, Snoop_Boundary:0x7f.
> [ 186.297405] zx info: set reg_Mxu_Timeout2 mmio0x490AC = 0x3.
> [ 186.325275] zx info: after engine0(caps=ff, engine_index=0) restore ...
> [ 186.325276] zx info: current engine staus is 0x0 
> [ 186.325278] zx info: current power mgr staus0 is 0xff00fdfd 
> [ 186.325279] zx info: current power mgr staus1 is 0xffffc01f 
> [ 186.353284] zx info: after engine1(caps=40000100, engine_index=1) restore ...
> [ 186.353286] zx info: current engine staus is 0x0 
> [ 186.353287] zx info: current power mgr staus0 is 0xff00fdfd 
> [ 186.353288] zx info: current power mgr staus1 is 0xffffc01f 
> [ 186.353290] zx info: PwmSupportFlags(hw_caps.pwm_auto) : 0x1.
> [ 186.381285] zx info: after engine4(caps=40000100, engine_index=4) restore ...
> [ 186.381286] zx info: current engine staus is 0x0 
> [ 186.381287] zx info: current power mgr staus0 is 0xff0000 
> [ 186.381288] zx info: current power mgr staus1 is 0x3fe0 
> [ 186.387345] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 186.387347] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 186.409286] zx info: after engine5(caps=40000400, engine_index=5) restore ...
> [ 186.409288] zx info: current engine staus is 0x0 
> [ 186.409289] zx info: current power mgr staus0 is 0xff0000 
> [ 186.409290] zx info: current power mgr staus1 is 0x3fe0 
> [ 186.409292] zx info: vidsch_restore finish, cur time 185580(ms)
> [ 186.414256] zx info: cm_restore finish, cur time 185585(ms)
> [ 186.414644] zx info: KMS set mode to path(iga_index-->active_device): 1-->0x10000.
> [ 186.414646] [DISP] General Info: SourceMode: 1920 x 1080!
> [ 186.414647] [DISP] General Info: DestMode: 1920 x 1080 @ 6000!
> [ 186.414648] [DISP] General Info: ScalerMode: 1920 x 1080!
> [ 186.414650] [DISP] General Info: Interlace=0, Signal=1, AsRatio=0, Bpc=8!
> [ 186.414655] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 186.415025] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 186.415026] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 186.415028] zx info: Gamma of crtc-0 changed, to load gamma table.
> [ 186.417604] zx info: Gamma of crtc-1 changed, to load gamma table.
> [ 186.431106] zx info: Gamma of crtc-2 changed, to load gamma table.
> [ 186.442986] zx info: CRTC atomic enable: to turn on vblank and screen of crtc: 1
> [ 186.442993] zx info: To turn on power of device: 0x10000.
> [ 186.445828] nvme nvme0: Shutdown timeout set to 8 seconds
> [ 186.484013] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 186.488105] [DISP] DP Info: cbDPPort_OnOff: status = On.
> [ 186.488270] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 186.488407] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=1
> [ 186.492570] snd_hda_codec_hdmi hdaudioC0D2: HDMI: detected monitor TIO24Gen3 at connection type HDMI
> [ 186.492572] snd_hda_codec_hdmi hdaudioC0D2: HDMI: available speakers: FL/FR
> [ 186.492576] snd_hda_codec_hdmi hdaudioC0D2: HDMI: supports coding type LPCM: channels = 2, rates = 32000 44100 48000, bits = 16 20 24
> [ 186.492584] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 186.492715] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=1
> [ 186.496878] snd_hda_codec_hdmi hdaudioC0D2: HDMI: detected monitor TIO24Gen3 at connection type HDMI
> [ 186.496879] snd_hda_codec_hdmi hdaudioC0D2: HDMI: available speakers: FL/FR
> [ 186.496882] snd_hda_codec_hdmi hdaudioC0D2: HDMI: supports coding type LPCM: channels = 2, rates = 32000 44100 48000, bits = 16 20 24
> [ 186.497769] zx info: drm resume: restore display status finished.
> [ 186.659468] ata2: SATA link down (SStatus 0 SControl 300)
> [ 186.659479] ata1: SATA link down (SStatus 0 SControl 300)
> [ 186.682346] usb 8-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
> [ 186.769319] usb 3-1: reset low-speed USB device number 2 using uhci_hcd
> [ 186.905468] usb 7-1: reset high-speed USB device number 2 using xhci_hcd
> [ 187.429488] usb 7-1.2: reset high-speed USB device number 4 using xhci_hcd
> [ 187.521517] r8169 0000:07:00.0 enp7s0: Link is Down
> [ 188.465552] usb 7-1.1: reset full-speed USB device number 3 using xhci_hcd
> [ 188.837241] r8169 0000:07:00.0 enp7s0: Link is Up - 1Gbps/Full - flow control off
> [ 188.906923] cputemp cputemp.1: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> [ 188.906986] cputemp cputemp.2: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> [ 188.907026] cputemp cputemp.3: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> [ 189.607293] OOM killer enabled.
> [ 189.610561] Restarting tasks ... done.
> [ 189.615927] video LNXVIDEO:00: Restoring backlight state
> [ 189.621629] PM: suspend exit
> [ 613.232360] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 613.232505] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=0
> [ 613.232522] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 613.232670] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=0
> [ 613.233355] zx info: To turn off power of device: 0x10000.
> [ 613.251157] [DISP] DP Info: cbDPPort_OnOff: status = Off.
> [ 613.256988] zx info: CRTC atomic disable: to turn off vblank and screen of crtc: 1
> [ 626.974091] usb 7-1.1: USB disconnect, device number 3
> [ 1507.175663] usb 3-1: USB disconnect, device number 2
> [ 1772.084047] zx info: Gamma of crtc-1 changed, to load gamma table.
> [ 1772.099136] zx info: KMS set mode to path(iga_index-->active_device): 1-->0x10000.
> [ 1772.107175] [DISP] General Info: SourceMode: 1920 x 1080!
> [ 1772.112964] [DISP] General Info: DestMode: 1920 x 1080 @ 6000!
> [ 1772.119387] [DISP] General Info: ScalerMode: 1920 x 1080!
> [ 1772.125195] [DISP] General Info: Interlace=0, Signal=1, AsRatio=0, Bpc=8!
> [ 1772.132450] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 1772.140295] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 1772.147703] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 1772.155067] zx info: CRTC atomic enable: to turn on vblank and screen of crtc: 1
> [ 1772.162862] zx info: To turn on power of device: 0x10000.
> [ 1772.209352] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 1772.220962] [DISP] DP Info: cbDPPort_OnOff: status = On.
> [ 1772.226851] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 1772.227002] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=1
> [ 1772.231227] snd_hda_codec_hdmi hdaudioC0D2: HDMI: detected monitor TIO24Gen3 at connection type HDMI
> [ 1772.231231] snd_hda_codec_hdmi hdaudioC0D2: HDMI: available speakers: FL/FR
> [ 1772.231236] snd_hda_codec_hdmi hdaudioC0D2: HDMI: supports coding type LPCM: channels = 2, rates = 32000 44100 48000, bits = 16 20 24
> [ 1772.231249] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 1772.231393] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=1
> [ 1772.235598] snd_hda_codec_hdmi hdaudioC0D2: HDMI: detected monitor TIO24Gen3 at connection type HDMI
> [ 1772.235600] snd_hda_codec_hdmi hdaudioC0D2: HDMI: available speakers: FL/FR
> [ 1772.235605] snd_hda_codec_hdmi hdaudioC0D2: HDMI: supports coding type LPCM: channels = 2, rates = 32000 44100 48000, bits = 16 20 24
> [ 1774.486691] usb 7-1.1: new full-speed USB device number 5 using xhci_hcd
> [ 1774.947742] usb 7-1.1: New USB device found, idVendor=17ef, idProduct=a012, bcdDevice= 0.55
> [ 1774.956588] usb 7-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 1774.964339] usb 7-1.1: Product: Thinkcentre TIO24Gen3 for USB-audio
> [ 1774.970999] usb 7-1.1: Manufacturer: Lenovo
> [ 1774.975447] usb 7-1.1: SerialNumber: 000000000000
> [ 1775.048590] usb 7-1.1: 2:1: cannot get freq at ep 0x1
> [ 1775.245065] input: Lenovo Thinkcentre TIO24Gen3 for USB-audio Consumer Control as /devices/pci0000:00/0000:00:03.0/0000:01:00.0/usb7/7-1/7-1.1/7-1.1:1.3/0003:17EF:A012.0005/input/input20
> [ 1775.318916] input: Lenovo Thinkcentre TIO24Gen3 for USB-audio as /devices/pci0000:00/0000:00:03.0/0000:01:00.0/usb7/7-1/7-1.1/7-1.1:1.3/0003:17EF:A012.0005/input/input21
> [ 1775.335228] hid-generic 0003:17EF:A012.0005: input,hiddev0,hidraw0: USB HID v1.00 Device [Lenovo Thinkcentre TIO24Gen3 for USB-audio] on usb-0000:01:00.0-1.1/input3
> root@uos-PC:/sys/bus/usb/devices/usb7# 
> Your system is not activated. Please activate as soon as possible for normal use.
> 
> 
> root@uos-PC:/sys/bus/usb/devices/usb7# 
> root@uos-PC:/sys/bus/usb/devices/usb7# lsusb -t
> /: Bus 09.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
> /: Bus 08.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 5000M
> |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 5000M
> /: Bus 07.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 480M
> |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
> |__ Port 1: Dev 6, If 3, Class=Human Interface Device, Driver=usbhid, 12M
> |__ Port 1: Dev 6, If 1, Class=Audio, Driver=snd-usb-audio, 12M
> |__ Port 1: Dev 6, If 2, Class=Audio, Driver=snd-usb-audio, 12M
> |__ Port 1: Dev 6, If 0, Class=Audio, Driver=snd-usb-audio, 12M
> |__ Port 2: Dev 4, If 0, Class=Video, Driver=uvcvideo, 480M
> |__ Port 2: Dev 4, If 1, Class=Video, Driver=uvcvideo, 480M
> /: Bus 06.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
> /: Bus 05.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/4p, 480M
> |__ Port 3: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
> |__ Port 1: Dev 3, If 0, Class=Human Interface Device, Driver=usbhid, 1.5M
> |__ Port 1: Dev 3, If 1, Class=Human Interface Device, Driver=usbhid, 1.5M
> /: Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 5000M
> /: Bus 03.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
> /: Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 480M
> /: Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/2p, 480M
> root@uos-PC:/sys/bus/usb/devices/usb7# dmesg
> [ 0.000000] Linux version 4.19.0-6-amd64 (debian-kernel@lists.debian.org) (gcc version 8.3.0 (Debian 8.3.0-6)) #1 SMP Uos 4.19.67-11eagle (2020-03-21)
> [ 0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.19.0-6-amd64 root=UUID=e5a40c4f-d88e-4a4d-9414-a27892a31be7 ro splash console=ttyS0,115200n8 loglevel=7 DEEPIN_GFXMODE=0,1920x1080,1600x1200,1280x1024,1024x768
> [ 0.000000] Zhaoxin Linux Patch Version is V3.0.2 
> [ 0.000000] With Zhaoxin Shanghai CPU patch V2.0.0
> [ 0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [ 0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [ 0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [ 0.000000] x86/fpu: xstate_offset[2]: 576, xstate_sizes[2]: 256
> [ 0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
> [ 0.000000] BIOS-provided physical RAM map:
> [ 0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dfff] usable
> [ 0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reserved
> [ 0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000096112fff] usable
> [ 0.000000] BIOS-e820: [mem 0x0000000096113000-0x0000000096172fff] type 20
> [ 0.000000] BIOS-e820: [mem 0x0000000096173000-0x0000000096379fff] reserved
> [ 0.000000] BIOS-e820: [mem 0x000000009637a000-0x00000000964ecfff] ACPI NVS
> [ 0.000000] BIOS-e820: [mem 0x00000000964ed000-0x00000000964fdfff] ACPI data
> [ 0.000000] BIOS-e820: [mem 0x00000000964fe000-0x000000009fafefff] usable
> [ 0.000000] BIOS-e820: [mem 0x000000009faff000-0x000000009fffffff] reserved
> [ 0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
> [ 0.000000] BIOS-e820: [mem 0x00000000fe020000-0x00000000fe020fff] reserved
> [ 0.000000] BIOS-e820: [mem 0x00000000feb00000-0x00000000feb7ffff] reserved
> [ 0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [ 0.000000] BIOS-e820: [mem 0x00000000fecc0000-0x00000000fecc0fff] reserved
> [ 0.000000] BIOS-e820: [mem 0x00000000fef00000-0x00000000feffffff] reserved
> [ 0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff] reserved
> [ 0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023fffffff] usable
> [ 0.000000] NX (Execute Disable) protection: active
> [ 0.000000] efi: EFI v2.60 by LENOVO
> [ 0.000000] efi: SMBIOS=0x96333000 ACPI=0x964fd000 ACPI 2.0=0x964fd014 ESRT=0x948c0e98 MEMATTR=0x9485f018 
> [ 0.000000] secureboot: Secure boot could not be determined (mode 0)
> [ 0.000000] SMBIOS 3.1 present.
> [ 0.000000] DMI: LENOVO INVALID/LXCF-ZXE-ZX200-ITX, BIOS M2KKT31A 06/19/2020
> [ 0.000000] tsc: Fast TSC calibration using PIT
> [ 0.000000] tsc: Detected 2594.884 MHz processor
> [ 0.002881] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [ 0.002885] e820: remove [mem 0x000a0000-0x000fffff] usable
> [ 0.002893] last_pfn = 0x240000 max_arch_pfn = 0x400000000
> [ 0.002900] MTRR default type: write-back
> [ 0.002901] MTRR fixed ranges enabled:
> [ 0.002902] 00000-9FFFF write-back
> [ 0.002904] A0000-BFFFF uncachable
> [ 0.002905] C0000-FFFFF write-through
> [ 0.002906] MTRR variable ranges enabled:
> [ 0.002908] 0 base 00A0000000 mask FFE0000000 uncachable
> [ 0.002910] 1 base 00C0000000 mask FFC0000000 uncachable
> [ 0.002911] 2 base 009FC00000 mask FFFFC00000 uncachable
> [ 0.002912] 3 disabled
> [ 0.002913] 4 disabled
> [ 0.002913] 5 disabled
> [ 0.002914] 6 disabled
> [ 0.002915] 7 disabled
> [ 0.002915] 8 disabled
> [ 0.002916] 9 disabled
> [ 0.003467] x86/PAT: Configuration [0-7]: WB WC UC- UC WB WP UC- WT 
> [ 0.003816] last_pfn = 0x9faff max_arch_pfn = 0x400000000
> [ 0.011070] esrt: Reserving ESRT space from 0x00000000948c0e98 to 0x00000000948c0ed0.
> [ 0.011090] Using GB pages for direct mapping
> [ 0.011094] BRK [0x4b201000, 0x4b201fff] PGTABLE
> [ 0.011096] BRK [0x4b202000, 0x4b202fff] PGTABLE
> [ 0.011098] BRK [0x4b203000, 0x4b203fff] PGTABLE
> [ 0.011165] BRK [0x4b204000, 0x4b204fff] PGTABLE
> [ 0.011590] BRK [0x4b205000, 0x4b205fff] PGTABLE
> [ 0.011734] BRK [0x4b206000, 0x4b206fff] PGTABLE
> [ 0.011877] RAMDISK: [mem 0x30970000-0x344affff]
> [ 0.011886] ACPI: Early table checksum verification disabled
> [ 0.011890] ACPI: RSDP 0x00000000964FD014 000024 (v02 LENOVO)
> [ 0.011896] ACPI: XSDT 0x00000000964FC0E8 00005C (v01 LENOVO TC-M2KKT 000011F0 00010013)
> [ 0.011904] ACPI: FACP 0x00000000964FB000 000114 (v06 LENOVO TC-M2KKT 000011F0 00010013)
> [ 0.011911] ACPI: DSDT 0x00000000964F0000 007A42 (v02 LENOVO TC-M2KKT 000011F0 INTL 00010013)
> [ 0.011916] ACPI: FACS 0x00000000963CB000 000040
> [ 0.011920] ACPI: UEFI 0x00000000964E7000 000042 (v01 LENOVO TC-M2KKT 000011F0 00010013)
> [ 0.011925] ACPI: HPET 0x00000000964FA000 000038 (v01 LENOVO TC-M2KKT 000011F0 00010013)
> [ 0.011930] ACPI: APIC 0x00000000964F9000 0000B2 (v03 LENOVO TC-M2KKT 000011F0 00010013)
> [ 0.011934] ACPI: MCFG 0x00000000964F8000 00003C (v01 LENOVO TC-M2KKT 000011F0 00010013)
> [ 0.011939] ACPI: FPDT 0x00000000964EF000 000044 (v01 LENOVO TC-M2KKT 000011F0 00010013)
> [ 0.011943] ACPI: BGRT 0x00000000964EE000 000038 (v01 LENOVO TC-M2KKT 000011F0 00010013)
> [ 0.011954] ACPI: Local APIC address 0xfee00000
> [ 0.012063] No NUMA configuration found
> [ 0.012065] Faking a node at [mem 0x0000000000000000-0x000000023fffffff]
> [ 0.012071] NODE_DATA(0) allocated [mem 0x23fff9000-0x23fffdfff]
> [ 0.012113] Zone ranges:
> [ 0.012115] DMA [mem 0x0000000000001000-0x0000000000ffffff]
> [ 0.012118] DMA32 [mem 0x0000000001000000-0x00000000ffffffff]
> [ 0.012120] Normal [mem 0x0000000100000000-0x000000023fffffff]
> [ 0.012122] Device empty
> [ 0.012124] Movable zone start for each node
> [ 0.012125] Early memory node ranges
> [ 0.012127] node 0: [mem 0x0000000000001000-0x000000000009dfff]
> [ 0.012128] node 0: [mem 0x0000000000100000-0x0000000096112fff]
> [ 0.012130] node 0: [mem 0x00000000964fe000-0x000000009fafefff]
> [ 0.012131] node 0: [mem 0x0000000100000000-0x000000023fffffff]
> [ 0.012137] Reserved but unavailable: 99 pages
> [ 0.012139] Initmem setup node 0 [mem 0x0000000000001000-0x000000023fffffff]
> [ 0.012142] On node 0 totalpages: 1963697
> [ 0.012143] DMA zone: 64 pages used for memmap
> [ 0.012144] DMA zone: 56 pages reserved
> [ 0.012145] DMA zone: 3997 pages, LIFO batch:0
> [ 0.012303] DMA32 zone: 10141 pages used for memmap
> [ 0.012304] DMA32 zone: 648980 pages, LIFO batch:63
> [ 0.039986] Normal zone: 20480 pages used for memmap
> [ 0.039989] Normal zone: 1310720 pages, LIFO batch:63
> [ 0.090242] ACPI: PM-Timer IO Port: 0x808
> [ 0.090248] ACPI: Local APIC address 0xfee00000
> [ 0.090256] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> [ 0.090268] IOAPIC[0]: apic_id 9, version 3, address 0xfec00000, GSI 0-23
> [ 0.090275] IOAPIC[1]: apic_id 10, version 3, address 0xfecc0000, GSI 24-47
> [ 0.090278] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [ 0.090281] ACPI: INT_SRC_OVR (bus 0 bus_irq 7 global_irq 7 dfl dfl)
> [ 0.090283] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [ 0.090285] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 dfl dfl)
> [ 0.090287] ACPI: IRQ0 used by override.
> [ 0.090288] ACPI: IRQ7 used by override.
> [ 0.090289] ACPI: IRQ9 used by override.
> [ 0.090290] ACPI: IRQ11 used by override.
> [ 0.090292] Using ACPI (MADT) for SMP configuration information
> [ 0.090294] ACPI: HPET id: 0x1d178201 base: 0xfeb40000
> [ 0.090309] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> [ 0.090338] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [ 0.090341] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
> [ 0.090343] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
> [ 0.090346] PM: Registered nosave memory: [mem 0x96113000-0x96172fff]
> [ 0.090347] PM: Registered nosave memory: [mem 0x96173000-0x96379fff]
> [ 0.090348] PM: Registered nosave memory: [mem 0x9637a000-0x964ecfff]
> [ 0.090350] PM: Registered nosave memory: [mem 0x964ed000-0x964fdfff]
> [ 0.090353] PM: Registered nosave memory: [mem 0x9faff000-0x9fffffff]
> [ 0.090354] PM: Registered nosave memory: [mem 0xa0000000-0xdfffffff]
> [ 0.090355] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
> [ 0.090357] PM: Registered nosave memory: [mem 0xf0000000-0xfe01ffff]
> [ 0.090358] PM: Registered nosave memory: [mem 0xfe020000-0xfe020fff]
> [ 0.090360] PM: Registered nosave memory: [mem 0xfe021000-0xfeafffff]
> [ 0.090361] PM: Registered nosave memory: [mem 0xfeb00000-0xfeb7ffff]
> [ 0.090362] PM: Registered nosave memory: [mem 0xfeb80000-0xfebfffff]
> [ 0.090364] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
> [ 0.090365] PM: Registered nosave memory: [mem 0xfec01000-0xfecbffff]
> [ 0.090366] PM: Registered nosave memory: [mem 0xfecc0000-0xfecc0fff]
> [ 0.090368] PM: Registered nosave memory: [mem 0xfecc1000-0xfeefffff]
> [ 0.090369] PM: Registered nosave memory: [mem 0xfef00000-0xfeffffff]
> [ 0.090371] PM: Registered nosave memory: [mem 0xff000000-0xff7fffff]
> [ 0.090372] PM: Registered nosave memory: [mem 0xff800000-0xffffffff]
> [ 0.090375] [mem 0xa0000000-0xdfffffff] available for PCI devices
> [ 0.090377] Booting paravirtualized kernel on bare hardware
> [ 0.090381] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [ 0.257396] random: get_random_bytes called from start_kernel+0x93/0x52c with crng_init=0
> [ 0.257406] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:4 nr_node_ids:1
> [ 0.257780] percpu: Embedded 45 pages/cpu s144408 r8192 d31720 u524288
> [ 0.257791] pcpu-alloc: s144408 r8192 d31720 u524288 alloc=1*2097152
> [ 0.257792] pcpu-alloc: [0] 0 1 2 3 
> [ 0.257824] Built 1 zonelists, mobility grouping on. Total pages: 1932956
> [ 0.257826] Policy zone: Normal
> [ 0.257828] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.19.0-6-amd64 root=UUID=e5a40c4f-d88e-4a4d-9414-a27892a31be7 ro splash console=ttyS0,115200n8 loglevel=7 DEEPIN_GFXMODE=0,1920x1080,1600x1200,1280x1024,1024x768
> [ 0.266170] Calgary: detecting Calgary via BIOS EBDA area
> [ 0.266173] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
> [ 0.299905] Memory: 7374188K/7854788K available (10252K kernel code, 1261K rwdata, 3368K rodata, 1592K init, 2184K bss, 480600K reserved, 0K cma-reserved)
> [ 0.300043] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [ 0.300052] ftrace: allocating 32773 entries in 129 pages
> [ 0.318337] rcu: Hierarchical RCU implementation.
> [ 0.318341] rcu: RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=4.
> [ 0.318343] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [ 0.324002] NR_IRQS: 33024, nr_irqs: 864, preallocated irqs: 16
> [ 0.324264] Console: colour dummy device 80x25
> [ 1.114327] console [ttyS0] enabled
> [ 1.117834] ACPI: Core revision 20180810
> [ 1.121929] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
> [ 1.131045] hpet clockevent registered
> [ 1.131050] APIC: Switch to symmetric I/O mode setup
> [ 1.136630] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [ 1.159050] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x25675b7be68, max_idle_ns: 440795294601 ns
> [ 1.169559] Calibrating delay loop (skipped), value calculated using timer frequency.. 5189.76 BogoMIPS (lpj=10379536)
> [ 1.173550] pid_max: default: 32768 minimum: 301
> [ 1.177920] Security Framework initialized
> [ 1.181550] Yama: disabled by default; enable with sysctl kernel.yama.*
> [ 1.185570] AppArmor: AppArmor initialized
> [ 1.189550] LSM initialized: elfverify
> [ 1.195213] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> [ 1.198364] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> [ 1.201605] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
> [ 1.205577] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
> [ 1.213743] With Zhaoxin Shanghai CPU patch V2.0.0
> [ 1.217552] Got Zhaoxin CPU topology from cpuid B leaf, 4 leaf patch V1.0.0
> [ 1.221551] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
> [ 1.225558] Zhaoxin MCE driver patch V1.0.2
> [ 1.229564] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> [ 1.233550] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> [ 1.237550] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [ 1.241550] Spectre V2 : Mitigation: Full generic retpoline
> [ 1.245549] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [ 1.249549] Spectre V2 : Enabling Restricted Speculation for firmware calls
> [ 1.253558] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [ 1.257550] Speculative Store Bypass: Vulnerable
> [ 1.261572] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
> [ 1.274261] Freeing SMP alternatives memory: 24K
> [ 1.294717] TSC deadline timer enabled
> [ 1.294720] smpboot: CPU0: Centaur ZHAOXIN KaiXian KX-6640A@2.6GHz (family: 0x7, model: 0x3b, stepping: 0x0)
> [ 1.297714] Performance Events: no PMU driver, software events only.
> [ 1.301598] rcu: Hierarchical SRCU implementation.
> [ 1.305985] random: crng done (trusting CPU's manufacturer)
> [ 1.309579] NMI watchdog: Perf NMI watchdog permanently disabled
> [ 1.313640] smp: Bringing up secondary CPUs ...
> [ 1.317685] x86: Booting SMP configuration:
> [ 1.321553] .... node #0, CPUs: #1
> [ 0.821311] With Zhaoxin Shanghai CPU patch V2.0.0
> [ 0.821311] Got Zhaoxin CPU topology from cpuid B leaf, 4 leaf patch V1.0.0
> [ 0.821311] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
> [ 1.356639] #2
> [ 0.821311] With Zhaoxin Shanghai CPU patch V2.0.0
> [ 0.821311] Got Zhaoxin CPU topology from cpuid B leaf, 4 leaf patch V1.0.0
> [ 0.821311] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
> [ 1.389706] #3
> [ 0.821311] With Zhaoxin Shanghai CPU patch V2.0.0
> [ 0.821311] Got Zhaoxin CPU topology from cpuid B leaf, 4 leaf patch V1.0.0
> [ 0.821311] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
> [ 1.422776] smp: Brought up 1 node, 4 CPUs
> [ 1.425552] smpboot: Max logical packages: 1
> [ 1.429551] smpboot: Total of 4 processors activated (20759.07 BogoMIPS)
> [ 1.434479] devtmpfs: initialized
> [ 1.437622] x86/mm: Memory block size: 128MB
> [ 1.442534] PM: Registering ACPI NVS region [mem 0x9637a000-0x964ecfff] (1519616 bytes)
> [ 1.445646] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [ 1.449563] futex hash table entries: 1024 (order: 4, 65536 bytes)
> [ 1.453613] pinctrl core: initialized pinctrl subsystem
> [ 1.459077] NET: Registered protocol family 16
> [ 1.461674] audit: initializing netlink subsys (disabled)
> [ 1.465569] audit: type=2000 audit(1594791330.324:1): state=initialized audit_enabled=0 res=1
> [ 1.473552] cpuidle: using governor ladder
> [ 1.477563] cpuidle: using governor menu
> [ 1.481601] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [ 1.485551] ACPI: bus type PCI registered
> [ 1.489551] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [ 1.493631] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
> [ 1.497562] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
> [ 1.501565] PCI: Using configuration type 1 for base access
> [ 1.506655] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [ 1.513552] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [ 1.517681] ACPI: Added _OSI(Module Device)
> [ 1.521551] ACPI: Added _OSI(Processor Device)
> [ 1.525551] ACPI: Added _OSI(3.0 _SCP Extensions)
> [ 1.533550] ACPI: Added _OSI(Processor Aggregator Device)
> [ 1.537550] ACPI: Added _OSI(Linux-Dell-Video)
> [ 1.541550] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [ 1.549888] ACPI: 1 ACPI AML tables successfully acquired and loaded
> [ 1.559480] ACPI: Interpreter enabled
> [ 1.561569] ACPI: (supports S0 S3 S4 S5)
> [ 1.565486] ACPI: Using IOAPIC for interrupt routing
> [ 1.573581] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [ 1.583680] ACPI: Power Resource [PWR0] (off)
> [ 1.592261] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [ 1.597556] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [ 1.605723] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER LTR]
> [ 1.613711] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> [ 1.621551] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> [ 1.629882] PCI host bridge to bus 0000:00
> [ 1.633553] pci_bus 0000:00: root bus resource [io 0x0000-0x03af window]
> [ 1.641552] pci_bus 0000:00: root bus resource [io 0x03e0-0x0cf7 window]
> [ 1.649551] pci_bus 0000:00: root bus resource [io 0x0d00-0xffff window]
> [ 1.653551] pci_bus 0000:00: root bus resource [io 0x03b0-0x03df window]
> [ 1.661551] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [ 1.669551] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
> [ 1.677551] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xfdffffff window]
> [ 1.685551] pci_bus 0000:00: root bus resource [bus 00-ff]
> [ 1.689563] pci 0000:00:00.0: [1d17:1003] type 00 class 0x060000
> [ 1.689634] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
> [ 1.689737] pci 0000:00:00.1: [1d17:31b0] type 00 class 0x060000
> [ 1.689868] pci 0000:00:00.2: [1d17:31b1] type 00 class 0x060000
> [ 1.689997] pci 0000:00:00.3: [1d17:31b2] type 00 class 0x060000
> [ 1.690132] pci 0000:00:00.4: [1d17:31b3] type 00 class 0x060000
> [ 1.690266] pci 0000:00:00.5: [1d17:31b4] type 00 class 0x060000
> [ 1.690333] pci 0000:00:00.5: PME# supported from D0 D3hot D3cold
> [ 1.690435] pci 0000:00:00.6: [1d17:31b5] type 00 class 0x060000
> [ 1.690566] pci 0000:00:01.0: [1d17:3a04] type 00 class 0x030000
> [ 1.690578] pci 0000:00:01.0: reg 0x10: [mem 0xc0400000-0xc047ffff]
> [ 1.690585] pci 0000:00:01.0: reg 0x14: [mem 0xa0000000-0xbfffffff 64bit pref]
> [ 1.690609] pci 0000:00:01.0: BAR 1: assigned to efifb
> [ 1.697566] pci 0000:00:01.0: supports D1 D2
> [ 1.697652] pci 0000:00:01.1: [1d17:9144] type 00 class 0x040300
> [ 1.697663] pci 0000:00:01.1: reg 0x10: [mem 0xc0484000-0xc0487fff]
> [ 1.697700] pci 0000:00:01.1: supports D1 D2
> [ 1.697791] pci 0000:00:03.0: [1d17:0717] type 01 class 0x060400
> [ 1.697852] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
> [ 1.697964] pci 0000:00:03.1: [1d17:0718] type 01 class 0x060400
> [ 1.698024] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
> [ 1.698135] pci 0000:00:03.2: [1d17:0719] type 01 class 0x060400
> [ 1.698195] pci 0000:00:03.2: PME# supported from D0 D3hot D3cold
> [ 1.698314] pci 0000:00:03.3: [1d17:071a] type 01 class 0x060400
> [ 1.698374] pci 0000:00:03.3: PME# supported from D0 D3hot D3cold
> [ 1.698488] pci 0000:00:04.0: [1d17:071b] type 01 class 0x060400
> [ 1.698548] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
> [ 1.698658] pci 0000:00:04.1: [1d17:071c] type 01 class 0x060400
> [ 1.698718] pci 0000:00:04.1: PME# supported from D0 D3hot D3cold
> [ 1.698835] pci 0000:00:05.0: [1d17:071d] type 01 class 0x060400
> [ 1.698894] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
> [ 1.699005] pci 0000:00:05.1: [1d17:071e] type 01 class 0x060400
> [ 1.699064] pci 0000:00:05.1: PME# supported from D0 D3hot D3cold
> [ 1.699191] pci 0000:00:0e.0: [1d17:3038] type 00 class 0x0c0300
> [ 1.699229] pci 0000:00:0e.0: reg 0x20: [io 0xf060-0xf07f]
> [ 1.699267] pci 0000:00:0e.0: supports D1 D2
> [ 1.699269] pci 0000:00:0e.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.699374] pci 0000:00:0e.7: [1d17:3104] type 00 class 0x0c0320
> [ 1.699391] pci 0000:00:0e.7: reg 0x10: [mem 0xc048c000-0xc048c0ff]
> [ 1.699454] pci 0000:00:0e.7: supports D1 D2
> [ 1.699456] pci 0000:00:0e.7: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.699555] pci 0000:00:0f.0: [1d17:9083] type 00 class 0x010601
> [ 1.699578] pci 0000:00:0f.0: reg 0x18: [mem 0xc048d000-0xc048d03f]
> [ 1.699584] pci 0000:00:0f.0: reg 0x1c: [mem 0xc048e000-0xc048e00f]
> [ 1.699590] pci 0000:00:0f.0: reg 0x20: [io 0xf040-0xf05f]
> [ 1.699596] pci 0000:00:0f.0: reg 0x24: [mem 0xc0488000-0xc0489fff]
> [ 1.699634] pci 0000:00:0f.0: PME# supported from D3hot
> [ 1.699748] pci 0000:00:10.0: [1d17:3038] type 00 class 0x0c0300
> [ 1.699786] pci 0000:00:10.0: reg 0x20: [io 0xf020-0xf03f]
> [ 1.699824] pci 0000:00:10.0: supports D1 D2
> [ 1.699826] pci 0000:00:10.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.699922] pci 0000:00:10.1: [1d17:3038] type 00 class 0x0c0300
> [ 1.699960] pci 0000:00:10.1: reg 0x20: [io 0xf000-0xf01f]
> [ 1.699998] pci 0000:00:10.1: supports D1 D2
> [ 1.699999] pci 0000:00:10.1: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.700104] pci 0000:00:10.7: [1d17:3104] type 00 class 0x0c0320
> [ 1.700120] pci 0000:00:10.7: reg 0x10: [mem 0xc048b000-0xc048b0ff]
> [ 1.700184] pci 0000:00:10.7: supports D1 D2
> [ 1.700186] pci 0000:00:10.7: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.700283] pci 0000:00:11.0: [1d17:1001] type 00 class 0x060100
> [ 1.700447] pci 0000:00:11.7: [1d17:31b7] type 00 class 0x060000
> [ 1.700563] pci 0000:00:12.0: [1d17:9204] type 00 class 0x0c0330
> [ 1.700579] pci 0000:00:12.0: reg 0x10: [mem 0xc048a000-0xc048afff 64bit]
> [ 1.700628] pci 0000:00:12.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.700726] pci 0000:00:14.0: [1d17:3288] type 00 class 0x040300
> [ 1.700742] pci 0000:00:14.0: reg 0x10: [mem 0xc0480000-0xc0483fff 64bit]
> [ 1.700797] pci 0000:00:14.0: PME# supported from D0 D3hot D3cold
> [ 1.700958] pci 0000:01:00.0: [1b21:1142] type 00 class 0x0c0330
> [ 1.700986] pci 0000:01:00.0: reg 0x10: [mem 0xc0300000-0xc0307fff 64bit]
> [ 1.701101] pci 0000:01:00.0: PME# supported from D3hot D3cold
> [ 1.701189] pci 0000:00:03.0: PCI bridge to [bus 01]
> [ 1.705555] pci 0000:00:03.0: bridge window [mem 0xc0300000-0xc03fffff]
> [ 1.705606] pci 0000:00:03.1: PCI bridge to [bus 02]
> [ 1.709600] pci 0000:00:03.2: PCI bridge to [bus 03]
> [ 1.713601] pci 0000:00:03.3: PCI bridge to [bus 04]
> [ 1.721599] pci 0000:00:04.0: PCI bridge to [bus 05]
> [ 1.725613] pci 0000:06:00.0: [144d:a808] type 00 class 0x010802
> [ 1.725639] pci 0000:06:00.0: reg 0x10: [mem 0xc0200000-0xc0203fff 64bit]
> [ 1.725830] pci 0000:00:04.1: PCI bridge to [bus 06]
> [ 1.729554] pci 0000:00:04.1: bridge window [mem 0xc0200000-0xc02fffff]
> [ 1.729618] pci 0000:07:00.0: [10ec:8168] type 00 class 0x020000
> [ 1.729645] pci 0000:07:00.0: reg 0x10: [io 0xe000-0xe0ff]
> [ 1.729669] pci 0000:07:00.0: reg 0x18: [mem 0xc0100000-0xc0100fff 64bit]
> [ 1.729685] pci 0000:07:00.0: reg 0x20: [mem 0xc0000000-0xc0003fff 64bit pref]
> [ 1.729775] pci 0000:07:00.0: supports D1 D2
> [ 1.729777] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [ 1.729889] pci 0000:00:05.0: PCI bridge to [bus 07]
> [ 1.733553] pci 0000:00:05.0: bridge window [io 0xe000-0xefff]
> [ 1.733556] pci 0000:00:05.0: bridge window [mem 0xc0100000-0xc01fffff]
> [ 1.733560] pci 0000:00:05.0: bridge window [mem 0xc0000000-0xc00fffff 64bit pref]
> [ 1.733607] pci 0000:00:05.1: PCI bridge to [bus 08]
> [ 1.742127] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> [ 1.749602] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> [ 1.753600] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> [ 1.761599] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 10 11 12 14 15)
> [ 1.769600] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> [ 1.777622] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> [ 1.785605] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> [ 1.793604] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> [ 1.801694] pci 0000:00:01.0: vgaarb: setting as boot VGA device
> [ 1.805547] pci 0000:00:01.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [ 1.817558] pci 0000:00:01.0: vgaarb: bridge control possible
> [ 1.821550] vgaarb: loaded
> [ 1.824328] pps_core: LinuxPPS API ver. 1 registered
> [ 1.829551] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti 
> [ 1.837554] PTP clock support registered
> [ 1.841486] EDAC MC: Ver: 3.0.0
> [ 1.845647] Registered efivars operations
> [ 1.853619] PCI: Using ACPI for IRQ routing
> [ 1.862457] PCI: pci_cache_line_size set to 64 bytes
> [ 1.862518] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
> [ 1.862520] e820: reserve RAM buffer [mem 0x96113000-0x97ffffff]
> [ 1.862521] e820: reserve RAM buffer [mem 0x9faff000-0x9fffffff]
> [ 1.862644] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
> [ 1.869555] hpet0: at MMIO 0xfeb40000, IRQs 2, 8, 0
> [ 1.873551] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
> [ 1.883560] clocksource: Switched to clocksource tsc-early
> [ 1.901788] VFS: Disk quotas dquot_6.6.0
> [ 1.905734] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [ 1.912754] AppArmor: AppArmor Filesystem Enabled
> [ 1.917480] pnp: PnP ACPI init
> [ 1.920704] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
> [ 1.927314] system 00:00: [mem 0xfee00000-0xfeefffff] has been reserved
> [ 1.933917] system 00:00: [mem 0xfecc0000-0xfecc0fff] could not be reserved
> [ 1.940865] system 00:00: [mem 0xfeb14000-0xfeb17fff] has been reserved
> [ 1.947466] system 00:00: [mem 0xfeb11000-0xfeb12fff] has been reserved
> [ 1.954068] system 00:00: [mem 0xfe020000-0xfe020fff] has been reserved
> [ 1.960675] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
> [ 1.960853] system 00:01: [mem 0xfeb41000-0xfeb41fff] has been reserved
> [ 1.967460] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
> [ 1.967509] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
> [ 1.967810] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
> [ 1.967896] system 00:04: [io 0x0295-0x0296] has been reserved
> [ 1.973810] system 00:04: [io 0x04d0-0x04d1] has been reserved
> [ 1.979733] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
> [ 1.979874] system 00:05: [io 0x0800-0x08ff window] has been reserved
> [ 1.986392] system 00:05: [io 0x0400-0x041f] has been reserved
> [ 1.992309] system 00:05: [mem 0xfec00000-0xfec00fff] could not be reserved
> [ 1.999257] system 00:05: [mem 0xfeb32000-0xfeb321ff] has been reserved
> [ 2.005862] system 00:05: [mem 0xff800000-0xffffffff] has been reserved
> [ 2.012467] system 00:05: Plug and Play ACPI device, IDs PNP0c01 (active)
> [ 2.012607] pnp: PnP ACPI: found 6 devices
> [ 2.023355] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [ 2.032253] pci 0000:00:03.0: PCI bridge to [bus 01]
> [ 2.037215] pci 0000:00:03.0: bridge window [mem 0xc0300000-0xc03fffff]
> [ 2.044000] pci 0000:00:03.1: PCI bridge to [bus 02]
> [ 2.048970] pci 0000:00:03.2: PCI bridge to [bus 03]
> [ 2.053935] pci 0000:00:03.3: PCI bridge to [bus 04]
> [ 2.058901] pci 0000:00:04.0: PCI bridge to [bus 05]
> [ 2.063870] pci 0000:00:04.1: PCI bridge to [bus 06]
> [ 2.068832] pci 0000:00:04.1: bridge window [mem 0xc0200000-0xc02fffff]
> [ 2.075611] pci 0000:00:05.0: PCI bridge to [bus 07]
> [ 2.080575] pci 0000:00:05.0: bridge window [io 0xe000-0xefff]
> [ 2.086661] pci 0000:00:05.0: bridge window [mem 0xc0100000-0xc01fffff]
> [ 2.093442] pci 0000:00:05.0: bridge window [mem 0xc0000000-0xc00fffff 64bit pref]
> [ 2.101171] pci 0000:00:05.1: PCI bridge to [bus 08]
> [ 2.106138] pci_bus 0000:00: resource 4 [io 0x0000-0x03af window]
> [ 2.106140] pci_bus 0000:00: resource 5 [io 0x03e0-0x0cf7 window]
> [ 2.106142] pci_bus 0000:00: resource 6 [io 0x0d00-0xffff window]
> [ 2.106143] pci_bus 0000:00: resource 7 [io 0x03b0-0x03df window]
> [ 2.106145] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
> [ 2.106147] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
> [ 2.106148] pci_bus 0000:00: resource 10 [mem 0xa0000000-0xfdffffff window]
> [ 2.106150] pci_bus 0000:01: resource 1 [mem 0xc0300000-0xc03fffff]
> [ 2.106153] pci_bus 0000:06: resource 1 [mem 0xc0200000-0xc02fffff]
> [ 2.106154] pci_bus 0000:07: resource 0 [io 0xe000-0xefff]
> [ 2.106156] pci_bus 0000:07: resource 1 [mem 0xc0100000-0xc01fffff]
> [ 2.106157] pci_bus 0000:07: resource 2 [mem 0xc0000000-0xc00fffff 64bit pref]
> [ 2.106243] NET: Registered protocol family 2
> [ 2.110800] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes)
> [ 2.118663] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
> [ 2.126047] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> [ 2.132930] TCP: Hash tables configured (established 65536 bind 65536)
> [ 2.139488] UDP hash table entries: 4096 (order: 5, 131072 bytes)
> [ 2.145609] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
> [ 2.152205] NET: Registered protocol family 1
> [ 2.156566] NET: Registered protocol family 44
> [ 2.161033] pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [ 2.170493] PCI: CLS 64 bytes, default 64
> [ 2.170548] Unpacking initramfs...
> [ 3.356803] Freeing initrd memory: 60672K
> [ 3.360859] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [ 3.367293] software IO TLB: mapped [mem 0x8ec18000-0x92c18000] (64MB)
> [ 3.374625] Initialise system trusted keyrings
> [ 3.379082] Key type blacklist registered
> [ 3.383155] workingset: timestamp_bits=40 max_order=21 bucket_order=0
> [ 3.391294] zbud: loaded
> [ 3.730196] Key type asymmetric registered
> [ 3.734294] Asymmetric key parser 'x509' registered
> [ 3.739175] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
> [ 3.746601] io scheduler noop registered
> [ 3.750529] io scheduler deadline registered
> [ 3.754838] io scheduler cfq registered (default)
> [ 3.759543] io scheduler mq-deadline registered
> [ 3.765538] pcieport 0000:00:03.0: Signaling PME with IRQ 25
> [ 3.771218] pcieport 0000:00:03.1: Signaling PME with IRQ 27
> [ 3.776900] pcieport 0000:00:03.2: Signaling PME with IRQ 29
> [ 3.782584] pcieport 0000:00:03.3: Signaling PME with IRQ 31
> [ 3.788271] pcieport 0000:00:04.0: Signaling PME with IRQ 33
> [ 3.793954] pcieport 0000:00:04.1: Signaling PME with IRQ 35
> [ 3.799636] pcieport 0000:00:05.0: Signaling PME with IRQ 37
> [ 3.805308] pcieport 0000:00:05.1: Signaling PME with IRQ 39
> [ 3.811004] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [ 3.817712] efifb: probing for efifb
> [ 3.821299] efifb: framebuffer at 0xa0000000, using 8128k, total 8128k
> [ 3.827821] efifb: mode is 1920x1080x32, linelength=7680, pages=1
> [ 3.833902] efifb: scrolling: redraw
> [ 3.837475] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [ 3.850551] Console: switching to colour frame buffer device 240x67
> [ 3.864165] fb0: EFI VGA frame buffer device
> [ 3.869290] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [ 3.896293] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [ 3.923799] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> [ 3.931917] Linux agpgart interface v0.103
> [ 3.936109] AMD IOMMUv2 driver by Joerg Roedel 
> [ 3.942108] AMD IOMMUv2 functionality not available on this system
> [ 3.948607] WangXun Gigabit PCI Express Network Driver - version 1.0.2
> [ 3.955123] Copyright (c) 2018 -2019 Beijing WangXun Technology Co., Ltd
> [ 3.961883] WangXun 10 Gigabit PCI Express Network Driver - version 1.1.10
> [ 3.968753] Copyright (c) 2015 -2017 Beijing WangXun Technology Co., Ltd
> [ 3.975520] i8042: PNP: No PS/2 controller found.
> [ 3.980227] i8042: Probing ports directly.
> [ 4.010198] serio: i8042 KBD port at 0x60,0x64 irq 1
> [ 4.015266] mousedev: PS/2 mouse device common for all mice
> [ 4.020881] rtc_cmos 00:02: RTC can wake from S4
> [ 4.025705] rtc_cmos 00:02: registered as rtc0
> [ 4.030168] rtc_cmos 00:02: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
> [ 4.037777] ledtrig-cpu: registered to indicate activity on CPUs
> [ 4.044279] NET: Registered protocol family 10
> [ 4.057428] Segment Routing with IPv6
> [ 4.061124] mip6: Mobile IPv6
> [ 4.064097] NET: Registered protocol family 17
> [ 4.068583] mpls_gso: MPLS GSO support
> [ 4.072607] mce: Using 18 MCE banks
> [ 4.076127] sched_clock: Marking stable (3258784304, 817311072)->(4368614969, -292519593)
> [ 4.084498] registered taskstats version 1
> [ 4.088595] Loading compiled-in X.509 certificates
> [ 4.170505] Loaded X.509 cert 'Debian Secure Boot CA: 6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
> [ 4.179206] Loaded X.509 cert 'Debian Secure Boot Signer: 00a7468def'
> [ 4.185856] Loaded UEFI:db cert '统信软件技术有限公司: ae591c1c82b07dcaeabf404ca0dc5dd0fc54e9e9' linked to secondary sys keyring
> [ 4.198292] Loaded UEFI:db cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53' linked to secondary sys keyring
> [ 4.211332] Loaded UEFI:db cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4' linked to secondary sys keyring
> [ 4.224214] zswap: loaded using pool lzo/zbud
> [ 4.228638] AppArmor: AppArmor sha1 policy hashing enabled
> [ 4.234649] rtc_cmos 00:02: setting system clock to 2020-07-15 05:35:35 UTC (1594791335)
> [ 4.768309] Freeing unused kernel image memory: 1592K
> [ 4.773618] tsc: Refined TSC clocksource calibration: 2594.820 MHz
> [ 4.780137] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x25671eaff82, max_idle_ns: 440795239391 ns
> [ 4.790657] clocksource: Switched to clocksource tsc
> [ 4.797564] Write protecting the kernel read-only data: 16384k
> [ 4.805793] Freeing unused kernel image memory: 2028K
> [ 4.811332] Freeing unused kernel image memory: 728K
> [ 4.828663] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [ 4.835456] Run /init as init process
> [ 4.839515] [hook_mmap_file] command: init, device(2), mount(0), elf enabled: 1
> [ 4.847231] [hook_mmap_file] command: init, device(2), mount(0), elf enabled: 1
> [ 4.855051] [hook_mmap_file] command: init, device(2), mount(0), elf enabled: 1
> [ 4.862789] [hook_mmap_file] command: init, device(2), mount(0), elf enabled: 1
> [ 4.953349] button: module verification failed: signature and/or required key missing - tainting kernel
> [ 4.963676] ACPI: Video Device [EUMA] (multi-head: yes rom: no post: no)
> [ 4.971124] acpi device:17: registered as cooling_device4
> [ 4.971239] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
> [ 4.976847] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input2
> [ 4.985767] ACPI: Power Button [PWRB]
> [ 5.006675] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
> [ 5.014492] ACPI: Power Button [PWRF]
> [ 5.020660] SCSI subsystem initialized
> [ 5.024770] r8169 0000:07:00.0: can't disable ASPM; OS doesn't have ASPM control
> [ 5.024947] nvme nvme0: pci function 0000:06:00.0
> [ 5.038839] ACPI: bus type USB registered
> [ 5.043135] cryptd: max_cpu_qlen set to 1000
> [ 5.043353] usbcore: registered new interface driver usbfs
> [ 5.048452] libata version 3.00 loaded.
> [ 5.052292] libphy: r8169: probed
> [ 5.052604] r8169 0000:07:00.0 eth0: RTL8168g/8111g, 1c:83:41:27:53:c2, XID 4c000800, IRQ 43
> [ 5.052606] r8169 0000:07:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
> [ 5.053596] usbcore: registered new interface driver hub
> [ 5.080421] usbcore: registered new device driver usb
> [ 5.081717] r8169 0000:07:00.0 enp7s0: renamed from eth0
> [ 5.092587] AVX version of gcm_enc/dec engaged.
> [ 5.097345] AES CTR mode by8 optimization enabled
> [ 5.102790] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [ 5.111025] ehci-pci: EHCI PCI platform driver
> [ 5.111036] uhci_hcd: USB Universal Host Controller Interface driver
> [ 5.122633] ehci-pci 0000:00:0e.7: EHCI Host Controller
> [ 5.128149] ehci-pci 0000:00:0e.7: new USB bus registered, assigned bus number 1
> [ 5.128261] ahci 0000:00:0f.0: version 3.0
> [ 5.135923] ehci-pci 0000:00:0e.7: debug port 1
> [ 5.136174] ahci 0000:00:0f.0: SSS flag set, parallel bus scan disabled
> [ 5.140756] ehci-pci 0000:00:0e.7: irq 20, io mem 0xc048c000
> [ 5.154673] padlock_aes: Using PadLock ACE for AES algorithm.
> [ 5.157723] ahci 0000:00:0f.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
> [ 5.169248] ahci 0000:00:0f.0: flags: 64bit ncq sntf ilck stag led clo pio ccc ems sxs apst boh 
> [ 5.178481] ahci 0000:00:0f.0: both AHCI_HFLAG_MULTI_MSI flag set and custom irq handler implemented
> [ 5.181560] ehci-pci 0000:00:0e.7: USB 2.0 started, EHCI 1.00
> [ 5.194176] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
> [ 5.202892] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 5.210470] usb usb1: Product: EHCI Host Controller
> [ 5.215592] usb usb1: Manufacturer: Linux 4.19.0-6-amd64 ehci_hcd
> [ 5.221979] usb usb1: SerialNumber: 0000:00:0e.7
> [ 5.226985] hub 1-0:1.0: USB hub found
> [ 5.230936] hub 1-0:1.0: 2 ports detected
> [ 5.235286] xhci_hcd 0000:00:12.0: xHCI Host Controller
> [ 5.235288] uhci_hcd 0000:00:0e.0: UHCI Host Controller
> [ 5.240805] xhci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 2
> [ 5.246299] uhci_hcd 0000:00:0e.0: new USB bus registered, assigned bus number 3
> [ 5.257595] scsi host0: ahci
> [ 5.258205] nvme nvme0: Shutdown timeout set to 8 seconds
> [ 5.261823] uhci_hcd 0000:00:0e.0: detected 2 ports
> [ 5.265179] scsi host1: ahci
> [ 5.270440] uhci_hcd 0000:00:0e.0: Adjust the UHCI Controllers bit value patch V1.0.0
> [ 5.270471] uhci_hcd 0000:00:0e.0: irq 23, io base 0x0000f060
> [ 5.275662] ata1: SATA max UDMA/133 abar m8192@0xc0488000 port 0xc0488100 irq 44
> [ 5.278658] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
> [ 5.286846] ata2: SATA max UDMA/133 abar m8192@0xc0488000 port 0xc0488180 irq 45
> [ 5.292900] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 5.292902] usb usb3: Product: UHCI Host Controller
> [ 5.305694] nvme0n1: p1 p2 p3
> [ 5.309359] usb usb3: Manufacturer: Linux 4.19.0-6-amd64 uhci_hcd
> [ 5.339385] usb usb3: SerialNumber: 0000:00:0e.0
> [ 5.344348] hub 3-0:1.0: USB hub found
> [ 5.348291] hub 3-0:1.0: 2 ports detected
> [ 5.374428] xhci_hcd 0000:00:12.0: hcc params 0x00205fe3 hci version 0x110 quirks 0x0000000000000010
> [ 5.384161] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
> [ 5.392818] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 5.400412] usb usb2: Product: xHCI Host Controller
> [ 5.405560] usb usb2: Manufacturer: Linux 4.19.0-6-amd64 xhci-hcd
> [ 5.411964] usb usb2: SerialNumber: 0000:00:12.0
> [ 5.416962] hub 2-0:1.0: USB hub found
> [ 5.420913] hub 2-0:1.0: 2 ports detected
> [ 5.425289] xhci_hcd 0000:00:12.0: xHCI Host Controller
> [ 5.425299] ehci-pci 0000:00:10.7: EHCI Host Controller
> [ 5.430797] xhci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 4
> [ 5.436294] ehci-pci 0000:00:10.7: new USB bus registered, assigned bus number 5
> [ 5.444025] With Zhaoxin xHCI root hub speed patch V1.0.0.
> [ 5.444027] xhci_hcd 0000:00:12.0: Host supports USB 3.1 SuperSpeed
> [ 5.444047] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
> [ 5.451857] ehci-pci 0000:00:10.7: debug port 1
> [ 5.457631] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
> [ 5.464206] ehci-pci 0000:00:10.7: irq 21, io mem 0xc048b000
> [ 5.472616] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 5.472618] usb usb4: Product: xHCI Host Controller
> [ 5.472620] usb usb4: Manufacturer: Linux 4.19.0-6-amd64 xhci-hcd
> [ 5.511108] usb usb4: SerialNumber: 0000:00:12.0
> [ 5.516052] hub 4-0:1.0: USB hub found
> [ 5.520015] hub 4-0:1.0: 2 ports detected
> [ 5.615730] ata1: SATA link down (SStatus 0 SControl 300)
> [ 5.935727] ata2: SATA link down (SStatus 0 SControl 300)
> [ 6.217565] ehci-pci 0000:00:10.7: USB 2.0 started, EHCI 1.00
> [ 6.223659] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
> [ 6.232311] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 6.239865] usb usb5: Product: EHCI Host Controller
> [ 6.244970] usb usb5: Manufacturer: Linux 4.19.0-6-amd64 ehci_hcd
> [ 6.251347] usb usb5: SerialNumber: 0000:00:10.7
> [ 6.256333] hub 5-0:1.0: USB hub found
> [ 6.260262] hub 5-0:1.0: 4 ports detected
> [ 6.264675] uhci_hcd 0000:00:10.0: UHCI Host Controller
> [ 6.264678] xhci_hcd 0000:01:00.0: xHCI Host Controller
> [ 6.270197] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 6
> [ 6.275701] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 7
> [ 6.283472] uhci_hcd 0000:00:10.0: detected 2 ports
> [ 6.296300] uhci_hcd 0000:00:10.0: Adjust the UHCI Controllers bit value patch V1.0.0
> [ 6.304553] uhci_hcd 0000:00:10.0: irq 20, io base 0x0000f020
> [ 6.310658] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
> [ 6.319326] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 6.326885] usb usb6: Product: UHCI Host Controller
> [ 6.331982] usb usb6: Manufacturer: Linux 4.19.0-6-amd64 uhci_hcd
> [ 6.338393] usb usb6: SerialNumber: 0000:00:10.0
> [ 6.343339] hub 6-0:1.0: USB hub found
> [ 6.347240] hub 6-0:1.0: 2 ports detected
> [ 6.349563] usb 3-1: new low-speed USB device number 2 using uhci_hcd
> [ 6.351732] uhci_hcd 0000:00:10.1: UHCI Host Controller
> [ 6.351822] xhci_hcd 0000:01:00.0: hcc params 0x0200e081 hci version 0x100 quirks 0x0000000010000410
> [ 6.352133] usb usb7: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
> [ 6.352135] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 6.352136] usb usb7: Product: xHCI Host Controller
> [ 6.352138] usb usb7: Manufacturer: Linux 4.19.0-6-amd64 xhci-hcd
> [ 6.352139] usb usb7: SerialNumber: 0000:01:00.0
> [ 6.352265] hub 7-0:1.0: USB hub found
> [ 6.352276] hub 7-0:1.0: 2 ports detected
> [ 6.352426] xhci_hcd 0000:01:00.0: xHCI Host Controller
> [ 6.352430] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 8
> [ 6.352435] xhci_hcd 0000:01:00.0: Host supports USB 3.0 Enhanced SuperSpeed
> [ 6.352488] usb usb8: We don't know the algorithms for LPM for this host, disabling LPM.
> [ 6.352531] usb usb8: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
> [ 6.352532] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 6.352534] usb usb8: Product: xHCI Host Controller
> [ 6.352535] usb usb8: Manufacturer: Linux 4.19.0-6-amd64 xhci-hcd
> [ 6.352537] usb usb8: SerialNumber: 0000:01:00.0
> [ 6.352652] hub 8-0:1.0: USB hub found
> [ 6.352662] hub 8-0:1.0: 2 ports detected
> [ 6.484110] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 9
> [ 6.491908] uhci_hcd 0000:00:10.1: detected 2 ports
> [ 6.497041] uhci_hcd 0000:00:10.1: Adjust the UHCI Controllers bit value patch V1.0.0
> [ 6.505297] uhci_hcd 0000:00:10.1: irq 22, io base 0x0000f000
> [ 6.511422] usb usb9: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
> [ 6.520127] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [ 6.527686] usb usb9: Product: UHCI Host Controller
> [ 6.532831] usb usb9: Manufacturer: Linux 4.19.0-6-amd64 uhci_hcd
> [ 6.539238] usb usb9: SerialNumber: 0000:00:10.1
> [ 6.544217] hub 9-0:1.0: USB hub found
> [ 6.548188] hub 9-0:1.0: 2 ports detected
> [ 6.564629] usb 3-1: New USB device found, idVendor=17ef, idProduct=608d, bcdDevice= 1.00
> [ 6.573238] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [ 6.580728] usb 3-1: Product: lenovo USB Optical Mouse
> [ 6.586151] usb 3-1: Manufacturer: PixArt
> [ 6.597586] usb 5-3: new high-speed USB device number 2 using ehci-pci
> [ 6.605809] hidraw: raw HID events driver (C) Jiri Kosina
> [ 6.623898] usbcore: registered new interface driver usbhid
> [ 6.629762] usbhid: USB HID core driver
> [ 6.635128] input: PixArt lenovo USB Optical Mouse as /devices/pci0000:00/0000:00:0e.0/usb3/3-1/3-1:1.0/0003:17EF:608D.0001/input/input4
> [ 6.648121] hid-generic 0003:17EF:608D.0001: input,hidraw0: USB HID v1.11 Mouse [PixArt lenovo USB Optical Mouse] on usb-0000:00:0e.0-1/input0
> [ 6.693570] usb 7-1: new high-speed USB device number 2 using xhci_hcd
> [ 6.753564] raid6: sse2x1 gen() 2602 MB/s
> [ 6.767178] usb 5-3: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice=60.60
> [ 6.775757] usb 5-3: New USB device strings: Mfr=0, Product=1, SerialNumber=0
> [ 6.783240] usb 5-3: Product: USB2.0 Hub
> [ 6.787718] hub 5-3:1.0: USB hub found
> [ 6.791930] hub 5-3:1.0: 4 ports detected
> [ 6.825562] raid6: sse2x1 xor() 2711 MB/s
> [ 6.875601] usb 7-1: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.36
> [ 6.884204] usb 7-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [ 6.891731] usb 7-1: Product: 4-Port USB 2.0 Hub
> [ 6.896568] usb 7-1: Manufacturer: Generic
> [ 6.897567] raid6: sse2x2 gen() 3321 MB/s
> [ 6.904497] hub 7-1:1.0: USB hub found
> [ 6.910383] hub 7-1:1.0: 4 ports detected
> [ 6.969557] raid6: sse2x2 xor() 3026 MB/s
> [ 6.998392] usb 8-1: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
> [ 7.041552] raid6: sse2x4 gen() 4034 MB/s
> [ 7.042803] usb 8-1: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 1.36
> [ 7.054644] usb 8-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [ 7.062105] usb 8-1: Product: 4-Port USB 3.0 Hub
> [ 7.066943] usb 8-1: Manufacturer: Generic
> [ 7.079563] hub 8-1:1.0: USB hub found
> [ 7.085311] hub 8-1:1.0: 4 ports detected
> [ 7.089560] usb 5-3.1: new low-speed USB device number 3 using ehci-pci
> [ 7.113555] raid6: sse2x4 xor() 4521 MB/s
> [ 7.118049] raid6: using algorithm sse2x4 gen() 4034 MB/s
> [ 7.123689] raid6: .... xor() 4521 MB/s, rmw enabled
> [ 7.128921] raid6: using ssse3x2 recovery algorithm
> [ 7.134407] xor: automatically using best checksumming function avx 
> [ 7.142090] async_tx: api initialized (async)
> [ 7.205062] Btrfs loaded, crc32c=crc32c-intel
> [ 7.209561] usb 7-1.1: new full-speed USB device number 3 using xhci_hcd
> [ 7.216991] usb 5-3.1: New USB device found, idVendor=17ef, idProduct=6099, bcdDevice= 1.14
> [ 7.225800] usb 5-3.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [ 7.233460] usb 5-3.1: Product: Lenovo Traditional USB Keyboard
> [ 7.239667] usb 5-3.1: Manufacturer: LiteOn
> [ 7.249150] input: LiteOn Lenovo Traditional USB Keyboard as /devices/pci0000:00/0000:00:10.7/usb5/5-3/5-3.1/5-3.1:1.0/0003:17EF:6099.0002/input/input5
> [ 7.321707] hid-generic 0003:17EF:6099.0002: input,hidraw1: USB HID v1.11 Keyboard [LiteOn Lenovo Traditional USB Keyboard] on usb-0000:00:10.7-3.1/input0
> [ 7.340731] input: LiteOn Lenovo Traditional USB Keyboard System Control as /devices/pci0000:00/0000:00:10.7/usb5/5-3/5-3.1/5-3.1:1.1/0003:17EF:6099.0003/input/input6
> [ 7.413599] input: LiteOn Lenovo Traditional USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:10.7/usb5/5-3/5-3.1/5-3.1:1.1/0003:17EF:6099.0003/input/input7
> [ 7.429446] hid-generic 0003:17EF:6099.0003: input,hidraw2: USB HID v1.11 Device [LiteOn Lenovo Traditional USB Keyboard] on usb-0000:00:10.7-3.1/input1
> [ 7.466443] PM: Image not found (code -22)
> [ 7.520827] EXT4-fs (nvme0n1p2): mounting ext3 file system using the ext4 subsystem
> [ 7.530204] EXT4-fs (nvme0n1p2): mounted filesystem with ordered data mode. Opts: (null)
> [ 7.618747] partition count: 1, comm[1]: init, path: /usr/lib/systemd/systemd, cmdline: (null)
> [ 7.630282] [hook_mmap_file] command: init, device(2), mount(2), elf enabled: 0
> [ 7.666653] usb 7-1.1: New USB device found, idVendor=17ef, idProduct=a012, bcdDevice= 0.55
> [ 7.675450] usb 7-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 7.683140] usb 7-1.1: Product: Thinkcentre TIO24Gen3 for USB-audio
> [ 7.689752] usb 7-1.1: Manufacturer: Lenovo
> [ 7.689756] systemd[1]: RTC configured in localtime, applying delta of 480 minutes to system time.
> [ 7.694173] usb 7-1.1: SerialNumber: 000000000000
> [ 7.714878] systemd[1]: Inserted module 'autofs4'
> [ 7.747446] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> [ 7.769967] systemd[1]: Detected architecture x86-64.
> [ 7.778034] systemd[1]: Set hostname to .
> [ 7.852260] input: Lenovo Thinkcentre TIO24Gen3 for USB-audio Consumer Control as /devices/pci0000:00/0000:00:03.0/0000:01:00.0/usb7/7-1/7-1.1/7-1.1:1.3/0003:17EF:A012.0004/input/input8
> [ 7.886203] systemd[1]: /lib/systemd/system/smbd.service:9: PIDFile= references path below legacy directory /var/run/, updating /var/run/samba/smbd.pid → /run/samba/smbd.pid; please update the unit file accordingly.
> [ 7.909171] systemd[1]: /lib/systemd/system/nmbd.service:9: PIDFile= references path below legacy directory /var/run/, updating /var/run/samba/nmbd.pid → /run/samba/nmbd.pid; please update the unit file accordingly.
> [ 7.929599] input: Lenovo Thinkcentre TIO24Gen3 for USB-audio as /devices/pci0000:00/0000:00:03.0/0000:01:00.0/usb7/7-1/7-1.1/7-1.1:1.3/0003:17EF:A012.0004/input/input9
> [ 7.941458] systemd[1]: Configuration file /lib/systemd/system/deepin-elf-verify.service is marked executable. Please remove executable permission bits. Proceeding anyway.
> [ 7.945524] hid-generic 0003:17EF:A012.0004: input,hiddev0,hidraw3: USB HID v1.00 Device [Lenovo Thinkcentre TIO24Gen3 for USB-audio] on usb-0000:01:00.0-1.1/input3
> [ 7.974125] systemd[1]: Listening on Journal Socket (/dev/log).
> [ 7.984218] systemd[1]: Created slice system-getty.slice.
> [ 7.990483] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
> [ 8.001559] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> [ 8.036569] vfs_monitor: loading out-of-tree module taints kernel.
> [ 8.043640] EXT4-fs (nvme0n1p2): re-mounted. Opts: (null)
> [ 8.052295] mp: /, major: 3, minor: 2
> [ 8.057323] partition count: 1, comm[344]: systemd-modules, path: /usr/lib/systemd/systemd-modules-load, cmdline: /lib/systemd/systemd-modules-load
> [ 8.073569] usb 7-1.2: new high-speed USB device number 4 using xhci_hcd
> [ 8.189079] register_kretprobes 10 ok
> [ 8.220760] usb 7-1.2: New USB device found, idVendor=2ef4, idProduct=4255, bcdDevice= 0.13
> [ 8.230702] usb 7-1.2: New USB device strings: Mfr=3, Product=1, SerialNumber=2
> [ 8.239760] usb 7-1.2: Product: FULL HD 1080P Webcam
> [ 8.239762] usb 7-1.2: Manufacturer: Generic
> [ 8.252243] usb 7-1.2: SerialNumber: 200901010001
> [ 8.268930] systemd-journald[348]: Received request to flush runtime journal from PID 1
> [ 8.278896] systemd-journald[348]: File /var/log/journal/656f5626c57c49ff9e927c0dde45e254/system.journal corrupted or uncleanly shut down, renaming and replacing.
> [ 8.720714] acpi_cpufreq: acpi_cpufreq: failed to register hotplug callbacks
> [ 8.745970] ACPI: AC Adapter [ACDP] (on-line)
> [ 8.832099] zx_core: module license 'Zhaoxin' taints kernel.
> [ 8.838085] Disabling lock debugging due to kernel taint
> [ 8.858296] input: PC Speaker as /devices/platform/pcspkr/input/input10
> [ 8.894687] EFI Variables Facility v0.08 2004-May-17
> [ 8.941768] pstore: Using compression: deflate
> [ 8.950628] HDAC: Support Zhaoxin HDAC ID patch V1.0.0
> [ 8.956493] HDAC: Zhaoxin GFX HDAC patch V2.0.1
> [ 8.958245] Adding 8388604k swap on /dev/nvme0n1p3. Priority:-2 extents:1 across:8388604k SSFS
> [ 8.987405] pstore: Registered efi as persistent store backend
> [ 9.056910] zx info: Shanghai Zhaoxin Semiconductor Co., Ltd.
> [ 9.062972] zx info: Version: 21.00.16 Build on: 02/25/2020
> [ 9.085591] snd_hda_intel 0000:00:01.1: enabling device (0000 -> 0002)
> [ 9.106377] partition /boot/efi [3, 1] added, comm[552]: mount
> [ 9.117761] snd_hda_intel 0000:00:01.1: Disabling MSI
> [ 9.121657] zx info: bus_command: 0x7.
> [ 9.123078] snd_hda_intel 0000:00:01.1: Using LPIB position fix
> [ 9.164993] zx info: *******revision id:0
> [ 9.201183] snd_hda_intel 0000:00:01.1: zx_hda can't get pci_dev 
> [ 9.207647] HDAC: Support Zhaoxin HDAC ID patch V1.0.0
> [ 9.213089] HDAC: Zhaoxin GFX HDAC patch V2.0.1
> [ 9.219024] snd_hda_intel 0000:00:01.1: chipset global capabilities = 0x2001
> [ 9.219034] snd_hda_intel 0000:00:01.1: Clearing TCSEL
> [ 9.219560] zx info: EFI VGA detected, conflicted with zxfb, remove EFI VGA.
> [ 9.222952] snd_hda_intel 0000:00:01.1: CORB reset timeout#1, CORBRP = 0
> [ 9.237727] snd_hda_intel 0000:00:01.1: codec #1 probed OK
> [ 9.237867] snd_hda_intel 0000:00:01.1: codec #2 probed OK
> [ 9.237869] snd_hda_intel 0000:00:01.1: snd_hda_codec_device_init: entry
> [ 9.238910] snd_hda_intel 0000:00:01.1: snd_hda_codec_device_new: entry
> [ 9.239706] snd_hda_intel 0000:00:01.1: snd_hda_codec_device_init: entry
> [ 9.240720] snd_hda_intel 0000:00:01.1: snd_hda_codec_device_new: entry
> [ 9.266095] Console: switching to colour dummy device 80x25
> [ 9.281913] zx 0000:00:01.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=io+mem
> [ 9.291536] zx info: zx->freezable_patch : 0x2.
> [ 9.296321] zx info: query dma mask: ffffffffff
> [ 9.323382] RNG detected
> [ 9.329337] snd_hda_codec_hdmi hdaudioC0D1: zx_hda patch version 002 
> [ 9.338783] snd_hda_codec_hdmi hdaudioC0D1: HDMI status: Codec=1 Pin=3 Presence_Detect=0 ELD_Valid=0
> [ 9.339260] snd_hda_codec_hdmi hdaudioC0D2: zx_hda patch version 002 
> [ 9.350378] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=0 ELD_Valid=0
> [ 9.350564] snd_hda_intel 0000:00:14.0: chipset global capabilities = 0x4401
> [ 9.350581] snd_hda_intel 0000:00:14.0: Clearing TCSEL
> [ 9.351459] input: HDA Zhaoxin GFX HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/sound/card0/input11
> [ 9.364773] snd_hda_intel 0000:00:14.0: codec #0 probed OK
> [ 9.364776] snd_hda_intel 0000:00:14.0: snd_hda_codec_device_init: entry
> [ 9.365120] snd_hda_intel 0000:00:14.0: snd_hda_codec_device_new: entry
> [ 9.368202] input: HDA Zhaoxin GFX HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.1/sound/card0/input12
> [ 9.392983] zx info: bus_command: 0x7.
> [ 9.508649] cputemp cputemp.0: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> [ 9.519313] zx info: *******revision id:0
> [ 9.529439] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 9.529443] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 9.530811] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC233: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> [ 9.542366] snd_hda_codec_realtek hdaudioC1D0: speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [ 9.542369] snd_hda_codec_realtek hdaudioC1D0: hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
> [ 9.542370] snd_hda_codec_realtek hdaudioC1D0: mono: mono_out=0x0
> [ 9.542372] snd_hda_codec_realtek hdaudioC1D0: inputs:
> [ 9.545761] cputemp cputemp.1: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> [ 9.549566] snd_hda_codec_realtek hdaudioC1D0: Mic=0x1a
> [ 9.549568] snd_hda_codec_realtek hdaudioC1D0: Front Mic=0x19
> [ 9.549570] snd_hda_codec_realtek hdaudioC1D0: realtek: Enable default setup for auto mode as fallback
> [ 9.550415] snd_hda_codec_realtek hdaudioC1D0: ==> lo_type=2, wired=1, mio=1, badness=0x0
> [ 9.550418] snd_hda_codec_realtek hdaudioC1D0: multi_outs = 21/0/0/0 : 3/0/0/0 (type HP)
> [ 9.550421] snd_hda_codec_realtek hdaudioC1D0: out path: depth=3 '03:0d:21'
> [ 9.550423] snd_hda_codec_realtek hdaudioC1D0: spk_outs = 14/0/0/0 : 2/0/0/0
> [ 9.550425] snd_hda_codec_realtek hdaudioC1D0: spk path: depth=3 '02:0c:14'
> [ 9.550427] snd_hda_codec_realtek hdaudioC1D0: ==> Best config: lo_type=2, wired=1, mio=1
> [ 9.550429] snd_hda_codec_realtek hdaudioC1D0: multi_outs = 21/0/0/0 : 3/0/0/0 (type HP)
> [ 9.550431] snd_hda_codec_realtek hdaudioC1D0: out path: depth=3 '03:0d:21'
> [ 9.550433] snd_hda_codec_realtek hdaudioC1D0: spk_outs = 14/0/0/0 : 2/0/0/0
> [ 9.550435] snd_hda_codec_realtek hdaudioC1D0: spk path: depth=3 '02:0c:14'
> [ 9.550543] snd_hda_codec_realtek hdaudioC1D0: loopback path: depth=2 '1a:0b'
> [ 9.550830] snd_hda_codec_realtek hdaudioC1D0: input path: depth=3 '1a:23:08'
> [ 9.551122] snd_hda_codec_realtek hdaudioC1D0: input path: depth=3 '1a:22:09'
> [ 9.551167] snd_hda_codec_realtek hdaudioC1D0: loopback path: depth=2 '19:0b'
> [ 9.551170] snd_hda_codec_realtek hdaudioC1D0: input path: depth=3 '19:23:08'
> [ 9.551172] snd_hda_codec_realtek hdaudioC1D0: input path: depth=3 '19:22:09'
> [ 9.551175] snd_hda_codec_realtek hdaudioC1D0: Enable HP auto-muting on NID 0x21
> [ 9.551187] snd_hda_codec_realtek hdaudioC1D0: Enable auto-mic switch on NID 0x1a/0x19/0x0
> [ 9.551880] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 9.551885] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 9.594279] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 9.606060] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 9.610638] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 9.610641] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 9.611153] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:14.0/sound/card1/input13
> [ 9.618788] cputemp cputemp.2: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> [ 9.638103] input: HDA Zhaoxin Mic as /devices/pci0000:00/0000:00:14.0/sound/card1/input14
> [ 9.664655] input: HDA Zhaoxin Front Mic as /devices/pci0000:00/0000:00:14.0/sound/card1/input15
> [ 9.665708] cputemp cputemp.3: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> [ 9.673980] zx info: video memory size: 512M.
> [ 9.673983] zx info: pwm_level.EnablePowerGating.
> [ 9.693672] input: HDA Zhaoxin Front Headphone as /devices/pci0000:00/0000:00:14.0/sound/card1/input16
> [ 9.729775] padlock_sha: Using PadLock ACE for SHA1/SHA256 algorithms.
> [ 9.870701] [DISP] General Info: 
> CBIOS:cbGetSysBiosInfo:pcbe->SysBiosInfo.BootUpDev = 0x0!
> [ 9.881045] [DISP] General Info: cbUpdateShadowInfo_chx: FBSize = 512M DRAMMode = 1 bSnoopOnly = 0
> 
> [ 10.030911] [DISP] General Info: vcp_init_data size = 256
> [ 10.047856] [DISP] General Info: pRomBase addr = 81f03000
> [ 10.062700] IPv6: ADDRCONF(NETDEV_UP): enp7s0: link is not ready
> [ 10.071681] r8169 0000:07:00.0: firmware: direct-loading firmware rtl_nic/rtl8168g-2.fw
> [ 10.080772] Generic PHY r8169-700:00: attached PHY driver [Generic PHY] (mii_bus:phy_addr=r8169-700:00, irq=IGNORE)
> [ 10.169847] [DISP] General Error: cb_GetRegistryParameters is CBIOS_NULL!
> [ 10.191612] media: Linux media interface: v0.10
> [ 10.212458] [DISP] General Error: cb_GetRegistryParameters is CBIOS_NULL!
> [ 10.229635] IPv6: ADDRCONF(NETDEV_UP): enp7s0: link is not ready
> [ 10.292454] videodev: Linux video capture interface: v2.00
> [ 10.353625] zx info: disp cbios_init_hw finished.
> [ 10.358581] zx info: bios supported device: 0x18001
> [ 10.363740] zx info: low_top_address : 0xa0000000
> [ 10.368696] zx info: snoop only: 0
> [ 10.372291] zx info: ta_enable (iov enable): 0
> [ 10.416483] uvcvideo: Found UVC 1.00 device FULL HD 1080P Webcam (2ef4:4255)
> [ 10.438096] uvcvideo 7-1.2:1.0: Entity type for entity Extension 4 was not initialized!
> [ 10.445626] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [ 10.453446] [drm] Driver supports precise vblank timestamp query.
> [ 10.453996] uvcvideo 7-1.2:1.0: Entity type for entity Processing 2 was not initialized!
> [ 10.468370] uvcvideo 7-1.2:1.0: Entity type for entity Camera 1 was not initialized!
> [ 10.477193] usbcore: registered new interface driver snd-usb-audio
> [ 10.480195] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 10.483714] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 10.501199] input: FULL HD 1080P Webcam: FULL HD 1 as /devices/pci0000:00/0000:00:03.0/0000:01:00.0/usb7/7-1/7-1.2/7-1.2:1.0/input/input17
> [ 10.533945] usbcore: registered new interface driver uvcvideo
> [ 10.539988] USB Video Class driver (1.1.1)
> [ 10.578963] [DISP] DP Info: cbDPMonitor_Detect: DP device(0x8000) is not connected!
> [ 10.704198] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: HDMI device on dual mode DP port!
> [ 10.713784] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: DP monitor supported bpc = 8
> [ 10.750909] [DISP] General Info: codec#1 interrupt!
> [ 10.757993] fbcon: zxfb (fb0) is primary device
> [ 10.758036] zx info: To set par on drm fb.
> [ 10.760150] zx info: KMS set mode to path(iga_index-->active_device): 1-->0x10000.
> [ 10.760153] [DISP] General Info: SourceMode: 1920 x 1080!
> [ 10.760154] [DISP] General Info: DestMode: 1920 x 1080 @ 6000!
> [ 10.760155] [DISP] General Info: ScalerMode: 1920 x 1080!
> [ 10.760156] [DISP] General Info: Interlace=0, Signal=1, AsRatio=0, Bpc=8!
> [ 10.760161] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 10.762512] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 10.762514] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 10.762541] zx info: CRTC atomic enable: to turn on vblank and screen of crtc: 1
> [ 10.762547] zx info: To turn on power of device: 0x10000.
> [ 10.798498] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 10.802602] [DISP] DP Info: cbDPPort_OnOff: status = On.
> [ 10.802784] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 10.805679] snd_hda_codec_hdmi hdaudioC0D1: HDMI status: Codec=1 Pin=3 Presence_Detect=0 ELD_Valid=0
> [ 10.805698] [DISP] General Info: codec#1 interrupt!
> [ 10.806162] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=1
> [ 10.811179] snd_hda_codec_hdmi hdaudioC0D2: HDMI: detected monitor TIO24Gen3 at connection type HDMI
> [ 10.811182] snd_hda_codec_hdmi hdaudioC0D2: HDMI: available speakers: FL/FR
> [ 10.811186] snd_hda_codec_hdmi hdaudioC0D2: HDMI: supports coding type LPCM: channels = 2, rates = 32000 44100 48000, bits = 16 20 24
> [ 10.811208] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=0
> [ 10.811212] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 10.811344] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=1
> [ 10.811984] Console: switching to colour frame buffer device 240x67
> [ 10.816446] snd_hda_codec_hdmi hdaudioC0D2: HDMI: detected monitor TIO24Gen3 at connection type HDMI
> [ 10.816448] snd_hda_codec_hdmi hdaudioC0D2: HDMI: available speakers: FL/FR
> [ 10.816452] snd_hda_codec_hdmi hdaudioC0D2: HDMI: supports coding type LPCM: channels = 2, rates = 32000 44100 48000, bits = 16 20 24
> [ 10.967886] zx 0000:00:01.0: fb0: zxfb frame buffer device
> [ 11.009679] zx info: zx can used system memory size: 7644384k. set zx max used size as: 7316704k.
> [ 11.029595] zx info: segment[1]: range: [ 0M -> 511M), size: 511M, start reserved: 8128k
> [ 11.038864] zx info: segment[2]: range: [ 512M -> 2048M), size: 1536M, start reserved: 0k
> [ 11.050724] zx info: segment[3]: range: [2048M -> 2560M), size: 512M, start reserved: 0k
> [ 11.063648] zx info: vesa_tempbuffer_enable: temp allocation 1920*1080*4
> [ 11.072882] zx info: flush_fifo_buffer: gpu_virt_addr=7fc00000, kmd_virt_addr=000000002e76035a
> [ 11.081996] zx info: reg_Mxu_Ctl2,Sys_Vid_Boundary:0x1f, Cam_Sys_Boundary:0x9f.
> [ 11.089649] zx info: reg_Mxu_Ctl2,Virtual_Boundary:0x9f, Snoop_Boundary:0x7f.
> [ 11.097180] zx info: set reg_Mxu_Timeout2 mmio0x490AC = 0x3.
> [ 11.105635] zx info: create fence buffer total num 8704 
> [ 11.111251] zx info: fence buffer segment_id:2, gpu_virt_addr:20000000
> [ 11.119306] zx info: schedule_serialize[0] = 1
> [ 11.129007] zx info: engine0 reserved_memory segment_id:2 gpu_virt_addr:6f9c0000
> [ 11.157659] zx info: schedule_serialize[1] = 0
> [ 11.182226] zx info: engine1 reserved_memory segment_id:2 gpu_virt_addr:6f880000
> [ 11.191531] zx info: schedule_serialize[4] = 0
> [ 11.201578] zx info: engine4 reserved_memory segment_id:2 gpu_virt_addr:6f740000
> [ 11.209145] usb 7-1.1: 2:1: cannot get freq at ep 0x1
> [ 11.212240] zx info: PwmSupportFlags(hw_caps.pwm_auto) : 0x1.
> [ 11.226573] zx info: schedule_serialize[5] = 1
> [ 11.240106] zx info: engine5 reserved_memory segment_id:2 gpu_virt_addr:6f600000
> [ 11.269728] zx info: adapter->ctl_flags.worker_thread_enable 1
> [ 11.275902] zx info: hw caps: secure:0, snoop:1, 64K_page:0, Paging:1, LCS:0, PG_swizzle:0.
> [ 11.284718] zx info: Ctrl: Recovery:1, WK-thread:1, Hang-Dump:0, Debug-Secure:0, OneShot:0, RunOnQT:0, HotPlug-Polling:1, PwmMode:2, RebootPatch:0, NonsnoopEnable:1, Force3DBlt:1
> [ 11.305958] input: Elite Remote Control Driver as /devices/virtual/input/input18
> [ 11.318237] zx info: zx = 000000004f3d07f1, zx->pdev = 00000000f5d77e27, dev = 00000000a2595505, dev->primary = 0000000032e29343
> [ 11.333003] [drm] Initialized zx 33.0.22 02/25/2020 for 0000:00:01.0 on minor 0
> [ 11.474957] [DISP] DP Info: cbDPMonitor_Detect: DP device(0x8000) is not connected!
> [ 11.562685] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: HDMI device on dual mode DP port!
> [ 11.572324] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: DP monitor supported bpc = 8
> [ 11.686949] [DISP] DP Info: cbDPMonitor_Detect: DP device(0x8000) is not connected!
> [ 11.772846] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: HDMI device on dual mode DP port!
> [ 11.782486] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: DP monitor supported bpc = 8
> [ 12.292288] zx info: Gamma of crtc-1 changed, to load gamma table.
> [ 12.654022] r8169 0000:07:00.0 enp7s0: Link is Up - 1Gbps/Full - flow control off
> [ 12.661899] IPv6: ADDRCONF(NETDEV_CHANGE): enp7s0: link becomes ready
> [ 12.730992] [DISP] DP Info: cbDPMonitor_Detect: DP device(0x8000) is not connected!
> [ 12.819478] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: HDMI device on dual mode DP port!
> [ 12.829114] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: DP monitor supported bpc = 8
> [ 12.978964] [DISP] DP Info: cbDPMonitor_Detect: DP device(0x8000) is not connected!
> [ 13.064136] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: HDMI device on dual mode DP port!
> [ 13.073735] [DISP] DP Info: cbDPMonitor_GetMonitorParamsFromEdid: DP monitor supported bpc = 8
> [ 14.843562] fuse init (API version 7.27)
> [ 184.935894] PM: suspend entry (deep)
> [ 184.939696] PM: Syncing filesystems ... done.
> [ 184.956593] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [ 184.965772] OOM killer disabled.
> [ 184.969198] Freezing remaining freezable tasks ... 
> [ 184.969276] zx info: sleep render thread 0.
> [ 184.969299] zx info: sleep render thread 5.
> [ 184.969300] zx info: sleep render thread 4.
> [ 184.969301] zx info: sleep render thread 1.
> [ 184.992506] (elapsed 0.023 seconds) done.
> [ 184.996676] Suspending console(s) (use no_console_suspend to debug)
> [ 185.003988] serial 00:03: disabled
> [ 185.004994] zx info: pci device(vendor:0x1D17, device:0x3A04) pm suspend
> [ 185.004995] zx info: zx driver suspending, pm event = 2.
> [ 185.005215] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 185.005352] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=0
> [ 185.005357] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 185.005498] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=0
> [ 185.006210] zx info: To turn off power of device: 0x10000.
> [ 185.015110] [DISP] DP Info: cbDPPort_OnOff: status = Off.
> [ 185.015112] zx info: CRTC atomic disable: to turn off vblank and screen of crtc: 1
> [ 185.029457] zx info: drm suspend: save display status finished.
> [ 185.063825] zx info: drm suspend: save drmfb status finished.
> [ 185.063827] zx info: drm suspend: disable irq finished.
> [ 185.063865] zx info: drm suspend: deinit and uninstall irq finished.
> [ 186.148614] ACPI: Preparing to enter system sleep state S3
> [ 186.148956] PM: Saving platform NVS memory
> [ 186.148976] Disabling non-boot CPUs ...
> [ 186.165826] smpboot: CPU 1 is now offline
> [ 186.181851] smpboot: CPU 2 is now offline
> [ 186.197936] smpboot: CPU 3 is now offline
> [ 186.200822] ACPI: Low-level resume complete
> [ 186.200854] PM: Restoring platform NVS memory
> [ 186.201321] Enabling non-boot CPUs ...
> [ 186.201364] x86: Booting SMP configuration:
> [ 186.201365] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [ 186.212306] With Zhaoxin Shanghai CPU patch V2.0.0
> [ 186.212310] Got Zhaoxin CPU topology from cpuid B leaf, 4 leaf patch V1.0.0
> [ 186.212312] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
> [ 186.212505] cache: parent cpu1 should not be sleeping
> [ 186.212728] platform cputemp.1: parent platform should not be sleeping
> [ 186.212852] CPU1 is up
> [ 186.212881] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [ 186.223820] With Zhaoxin Shanghai CPU patch V2.0.0
> [ 186.223824] Got Zhaoxin CPU topology from cpuid B leaf, 4 leaf patch V1.0.0
> [ 186.223826] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
> [ 186.224006] cache: parent cpu2 should not be sleeping
> [ 186.224237] platform cputemp.2: parent platform should not be sleeping
> [ 186.224387] CPU2 is up
> [ 186.224417] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [ 186.235356] With Zhaoxin Shanghai CPU patch V2.0.0
> [ 186.235360] Got Zhaoxin CPU topology from cpuid B leaf, 4 leaf patch V1.0.0
> [ 186.235362] x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature
> [ 186.235543] cache: parent cpu3 should not be sleeping
> [ 186.235772] platform cputemp.3: parent platform should not be sleeping
> [ 186.235945] CPU3 is up
> [ 186.236889] ACPI: Waking up from system sleep state S3
> [ 186.277983] zx info: pci device(vendor:0x1D17, device:0x3A04) pm resume
> [ 186.277984] zx info: zx driver resume back.
> [ 186.277999] snd_hda_intel 0000:00:01.1: Clearing TCSEL
> [ 186.278048] usb usb3: root hub lost power or was reset
> [ 186.278160] snd_hda_intel 0000:00:14.0: Clearing TCSEL
> [ 186.278435] usb usb6: root hub lost power or was reset
> [ 186.278484] usb usb9: root hub lost power or was reset
> [ 186.278904] serial 00:03: activated
> [ 186.279038] usb usb7: root hub lost power or was reset
> [ 186.279039] usb usb8: root hub lost power or was reset
> [ 186.283711] snd_hda_intel 0000:00:01.1: CORB reset timeout#1, CORBRP = 0
> [ 186.284528] snd_hda_codec_hdmi hdaudioC0D1: HDMI status: Codec=1 Pin=3 Presence_Detect=0 ELD_Valid=0
> [ 186.284672] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=0 ELD_Valid=0
> [ 186.290942] zx info: disp cbios_init_hw finished.
> [ 186.290943] zx info: drm resume: enable and post chip finished.
> [ 186.290990] zx info: drm resume: re-init and install irq finished.
> [ 186.290992] zx info: drm resume: re-enable irq finished.
> [ 186.293396] zx info: drm resume: restore drmfb status finished.
> [ 186.293399] zx info: pm_restore_state enter, cur time 185464(ms)
> [ 186.293400] zx info: glb_init_chip_interface finish, cur time 185464(ms)
> [ 186.294197] zx info: vidmm_restore finish, cur time 185465(ms)
> [ 186.297395] zx info: after reset......
> [ 186.297397] zx info: current engine staus is 0x0 
> [ 186.297399] zx info: current power mgr staus0 is 0xff00fdfd 
> [ 186.297400] zx info: current power mgr staus1 is 0xffffc01f 
> [ 186.297400] zx info: done......
> [ 186.297403] zx info: reg_Mxu_Ctl2,Sys_Vid_Boundary:0x1f, Cam_Sys_Boundary:0x9f.
> [ 186.297404] zx info: reg_Mxu_Ctl2,Virtual_Boundary:0x9f, Snoop_Boundary:0x7f.
> [ 186.297405] zx info: set reg_Mxu_Timeout2 mmio0x490AC = 0x3.
> [ 186.325275] zx info: after engine0(caps=ff, engine_index=0) restore ...
> [ 186.325276] zx info: current engine staus is 0x0 
> [ 186.325278] zx info: current power mgr staus0 is 0xff00fdfd 
> [ 186.325279] zx info: current power mgr staus1 is 0xffffc01f 
> [ 186.353284] zx info: after engine1(caps=40000100, engine_index=1) restore ...
> [ 186.353286] zx info: current engine staus is 0x0 
> [ 186.353287] zx info: current power mgr staus0 is 0xff00fdfd 
> [ 186.353288] zx info: current power mgr staus1 is 0xffffc01f 
> [ 186.353290] zx info: PwmSupportFlags(hw_caps.pwm_auto) : 0x1.
> [ 186.381285] zx info: after engine4(caps=40000100, engine_index=4) restore ...
> [ 186.381286] zx info: current engine staus is 0x0 
> [ 186.381287] zx info: current power mgr staus0 is 0xff0000 
> [ 186.381288] zx info: current power mgr staus1 is 0x3fe0 
> [ 186.387345] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 186.387347] snd_hda_codec_realtek hdaudioC1D0: ALC233: Apply fix-func for (null)
> [ 186.409286] zx info: after engine5(caps=40000400, engine_index=5) restore ...
> [ 186.409288] zx info: current engine staus is 0x0 
> [ 186.409289] zx info: current power mgr staus0 is 0xff0000 
> [ 186.409290] zx info: current power mgr staus1 is 0x3fe0 
> [ 186.409292] zx info: vidsch_restore finish, cur time 185580(ms)
> [ 186.414256] zx info: cm_restore finish, cur time 185585(ms)
> [ 186.414644] zx info: KMS set mode to path(iga_index-->active_device): 1-->0x10000.
> [ 186.414646] [DISP] General Info: SourceMode: 1920 x 1080!
> [ 186.414647] [DISP] General Info: DestMode: 1920 x 1080 @ 6000!
> [ 186.414648] [DISP] General Info: ScalerMode: 1920 x 1080!
> [ 186.414650] [DISP] General Info: Interlace=0, Signal=1, AsRatio=0, Bpc=8!
> [ 186.414655] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 186.415025] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 186.415026] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 186.415028] zx info: Gamma of crtc-0 changed, to load gamma table.
> [ 186.417604] zx info: Gamma of crtc-1 changed, to load gamma table.
> [ 186.431106] zx info: Gamma of crtc-2 changed, to load gamma table.
> [ 186.442986] zx info: CRTC atomic enable: to turn on vblank and screen of crtc: 1
> [ 186.442993] zx info: To turn on power of device: 0x10000.
> [ 186.445828] nvme nvme0: Shutdown timeout set to 8 seconds
> [ 186.484013] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 186.488105] [DISP] DP Info: cbDPPort_OnOff: status = On.
> [ 186.488270] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 186.488407] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=1
> [ 186.492570] snd_hda_codec_hdmi hdaudioC0D2: HDMI: detected monitor TIO24Gen3 at connection type HDMI
> [ 186.492572] snd_hda_codec_hdmi hdaudioC0D2: HDMI: available speakers: FL/FR
> [ 186.492576] snd_hda_codec_hdmi hdaudioC0D2: HDMI: supports coding type LPCM: channels = 2, rates = 32000 44100 48000, bits = 16 20 24
> [ 186.492584] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 186.492715] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=1
> [ 186.496878] snd_hda_codec_hdmi hdaudioC0D2: HDMI: detected monitor TIO24Gen3 at connection type HDMI
> [ 186.496879] snd_hda_codec_hdmi hdaudioC0D2: HDMI: available speakers: FL/FR
> [ 186.496882] snd_hda_codec_hdmi hdaudioC0D2: HDMI: supports coding type LPCM: channels = 2, rates = 32000 44100 48000, bits = 16 20 24
> [ 186.497769] zx info: drm resume: restore display status finished.
> [ 186.659468] ata2: SATA link down (SStatus 0 SControl 300)
> [ 186.659479] ata1: SATA link down (SStatus 0 SControl 300)
> [ 186.682346] usb 8-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
> [ 186.769319] usb 3-1: reset low-speed USB device number 2 using uhci_hcd
> [ 186.905468] usb 7-1: reset high-speed USB device number 2 using xhci_hcd
> [ 187.429488] usb 7-1.2: reset high-speed USB device number 4 using xhci_hcd
> [ 187.521517] r8169 0000:07:00.0 enp7s0: Link is Down
> [ 188.465552] usb 7-1.1: reset full-speed USB device number 3 using xhci_hcd
> [ 188.837241] r8169 0000:07:00.0 enp7s0: Link is Up - 1Gbps/Full - flow control off
> [ 188.906923] cputemp cputemp.1: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> [ 188.906986] cputemp cputemp.2: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> [ 188.907026] cputemp cputemp.3: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> [ 189.607293] OOM killer enabled.
> [ 189.610561] Restarting tasks ... done.
> [ 189.615927] video LNXVIDEO:00: Restoring backlight state
> [ 189.621629] PM: suspend exit
> [ 613.232360] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 613.232505] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=0
> [ 613.232522] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 613.232670] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=0
> [ 613.233355] zx info: To turn off power of device: 0x10000.
> [ 613.251157] [DISP] DP Info: cbDPPort_OnOff: status = Off.
> [ 613.256988] zx info: CRTC atomic disable: to turn off vblank and screen of crtc: 1
> [ 626.974091] usb 7-1.1: USB disconnect, device number 3
> [ 1507.175663] usb 3-1: USB disconnect, device number 2
> [ 1772.084047] zx info: Gamma of crtc-1 changed, to load gamma table.
> [ 1772.099136] zx info: KMS set mode to path(iga_index-->active_device): 1-->0x10000.
> [ 1772.107175] [DISP] General Info: SourceMode: 1920 x 1080!
> [ 1772.112964] [DISP] General Info: DestMode: 1920 x 1080 @ 6000!
> [ 1772.119387] [DISP] General Info: ScalerMode: 1920 x 1080!
> [ 1772.125195] [DISP] General Info: Interlace=0, Signal=1, AsRatio=0, Bpc=8!
> [ 1772.132450] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 1772.140295] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 1772.147703] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 1772.155067] zx info: CRTC atomic enable: to turn on vblank and screen of crtc: 1
> [ 1772.162862] zx info: To turn on power of device: 0x10000.
> [ 1772.209352] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 1772.220962] [DISP] DP Info: cbDPPort_OnOff: status = On.
> [ 1772.226851] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 1772.227002] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=1
> [ 1772.231227] snd_hda_codec_hdmi hdaudioC0D2: HDMI: detected monitor TIO24Gen3 at connection type HDMI
> [ 1772.231231] snd_hda_codec_hdmi hdaudioC0D2: HDMI: available speakers: FL/FR
> [ 1772.231236] snd_hda_codec_hdmi hdaudioC0D2: HDMI: supports coding type LPCM: channels = 2, rates = 32000 44100 48000, bits = 16 20 24
> [ 1772.231249] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 1772.231393] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=1
> [ 1772.235598] snd_hda_codec_hdmi hdaudioC0D2: HDMI: detected monitor TIO24Gen3 at connection type HDMI
> [ 1772.235600] snd_hda_codec_hdmi hdaudioC0D2: HDMI: available speakers: FL/FR
> [ 1772.235605] snd_hda_codec_hdmi hdaudioC0D2: HDMI: supports coding type LPCM: channels = 2, rates = 32000 44100 48000, bits = 16 20 24
> [ 1774.486691] usb 7-1.1: new full-speed USB device number 5 using xhci_hcd
> [ 1774.947742] usb 7-1.1: New USB device found, idVendor=17ef, idProduct=a012, bcdDevice= 0.55
> [ 1774.956588] usb 7-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 1774.964339] usb 7-1.1: Product: Thinkcentre TIO24Gen3 for USB-audio
> [ 1774.970999] usb 7-1.1: Manufacturer: Lenovo
> [ 1774.975447] usb 7-1.1: SerialNumber: 000000000000
> [ 1775.048590] usb 7-1.1: 2:1: cannot get freq at ep 0x1
> [ 1775.245065] input: Lenovo Thinkcentre TIO24Gen3 for USB-audio Consumer Control as /devices/pci0000:00/0000:00:03.0/0000:01:00.0/usb7/7-1/7-1.1/7-1.1:1.3/0003:17EF:A012.0005/input/input20
> [ 1775.318916] input: Lenovo Thinkcentre TIO24Gen3 for USB-audio as /devices/pci0000:00/0000:00:03.0/0000:01:00.0/usb7/7-1/7-1.1/7-1.1:1.3/0003:17EF:A012.0005/input/input21
> [ 1775.335228] hid-generic 0003:17EF:A012.0005: input,hiddev0,hidraw0: USB HID v1.00 Device [Lenovo Thinkcentre TIO24Gen3 for USB-audio] on usb-0000:01:00.0-1.1/input3
> [ 2372.291028] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 2372.291176] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=0
> [ 2372.291192] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 2372.291341] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=0
> [ 2372.292023] zx info: To turn off power of device: 0x10000.
> [ 2372.309834] [DISP] DP Info: cbDPPort_OnOff: status = Off.
> [ 2372.315606] zx info: CRTC atomic disable: to turn off vblank and screen of crtc: 1
> [ 2386.433403] usb 7-1.1: USB disconnect, device number 5
> [ 2388.929193] zx info: Gamma of crtc-1 changed, to load gamma table.
> [ 2388.940590] zx info: KMS set mode to path(iga_index-->active_device): 1-->0x10000.
> [ 2388.948532] [DISP] General Info: SourceMode: 1920 x 1080!
> [ 2388.954291] [DISP] General Info: DestMode: 1920 x 1080 @ 6000!
> [ 2388.960683] [DISP] General Info: ScalerMode: 1920 x 1080!
> [ 2388.966430] [DISP] General Info: Interlace=0, Signal=1, AsRatio=0, Bpc=8!
> [ 2388.973616] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 2388.981443] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 2388.988849] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 2388.996281] zx info: CRTC atomic enable: to turn on vblank and screen of crtc: 1
> [ 2389.004082] zx info: To turn on power of device: 0x10000.
> [ 2389.050529] [DISP] General Info: Device 0x10000 does not involve module: 4.
> [ 2389.062123] [DISP] DP Info: cbDPPort_OnOff: status = On.
> [ 2389.067996] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 2389.068151] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=1
> [ 2389.072376] snd_hda_codec_hdmi hdaudioC0D2: HDMI: detected monitor TIO24Gen3 at connection type HDMI
> [ 2389.072380] snd_hda_codec_hdmi hdaudioC0D2: HDMI: available speakers: FL/FR
> [ 2389.072385] snd_hda_codec_hdmi hdaudioC0D2: HDMI: supports coding type LPCM: channels = 2, rates = 32000 44100 48000, bits = 16 20 24
> [ 2389.072398] snd_hda_codec_hdmi hdaudioC0D2: HDMI hot plug event: Codec=2 Pin=3 Device=0 Inactive=0 Presence_Detect=1 ELD_Valid=1
> [ 2389.072542] snd_hda_codec_hdmi hdaudioC0D2: HDMI status: Codec=2 Pin=3 Presence_Detect=1 ELD_Valid=1
> [ 2389.076747] snd_hda_codec_hdmi hdaudioC0D2: HDMI: detected monitor TIO24Gen3 at connection type HDMI
> [ 2389.076749] snd_hda_codec_hdmi hdaudioC0D2: HDMI: available speakers: FL/FR
> [ 2389.076754] snd_hda_codec_hdmi hdaudioC0D2: HDMI: supports coding type LPCM: channels = 2, rates = 32000 44100 48000, bits = 16 20 24
> [ 2391.194024] usb 7-1.1: new full-speed USB device number 6 using xhci_hcd
> [ 2391.654955] usb 7-1.1: New USB device found, idVendor=17ef, idProduct=a012, bcdDevice= 0.55
> [ 2391.663816] usb 7-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 2391.671576] usb 7-1.1: Product: Thinkcentre TIO24Gen3 for USB-audio
> [ 2391.678203] usb 7-1.1: Manufacturer: Lenovo
> [ 2391.682641] usb 7-1.1: SerialNumber: 000000000000
> [ 2391.755303] usb 7-1.1: 2:1: cannot get freq at ep 0x1
> [ 2391.951105] input: Lenovo Thinkcentre TIO24Gen3 for USB-audio Consumer Control as /devices/pci0000:00/0000:00:03.0/0000:01:00.0/usb7/7-1/7-1.1/7-1.1:1.3/0003:17EF:A012.0006/input/input22
> [ 2392.026190] input: Lenovo Thinkcentre TIO24Gen3 for USB-audio as /devices/pci0000:00/0000:00:03.0/0000:01:00.0/usb7/7-1/7-1.1/7-1.1:1.3/0003:17EF:A012.0006/input/input23
> [ 2392.042413] hid-generic 0003:17EF:A012.0006: input,hiddev0,hidraw0: USB HID v1.00 Device [Lenovo Thinkcentre TIO24Gen3 for USB-audio] on usb-0000:01:00.0-1.1/input3
> 
> 
> 统信软件技术有限公司
> 
> UnionTech Software Technology Co., Ltd. 　
> 
> 官网：www.uniontech.com　　
> 
> 
> 
> 此电子邮件消息仅供预期收件人使用，其中可能包含保密或特权使用信息。如果您不是预期收件人，请勿使用、传播、分发或复制此电子邮件或信赖此邮件采取任何行动。如果您误收了此邮件，请立即回复邮件通知统信软件技术有限公司发件人，并删除误收电子邮件及其相关附件。感谢配合！
> 
> This email message is intended only for the use of the individual or entity who/which is the intended recipient and may contain information that is privileged or confidential. If you are not the intended recipient, you are hereby notified that any use, dissemination, distribution or copying of, or taking any action in reliance on, this e-mail is strictly prohibited. If you have received this email in error, please notify UnionTech Software Technology  immediately by replying to this e-mail and immediately delete and discard all copies of the e-mail and the attachment thereto (if any). Thank you.
> 
> 
> 
> 
> ----- Original Message -----
> From:Kai-Heng Feng <kai.heng.feng@canonical.com> 
> To: penghao <penghao@uniontech.com>  
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org> johan <johan@kernel.org> jonathan <jonathan@jdcox.net> tomasz <tomasz@meresinski.eu> Hans de Goede <hdegoede@redhat.com> dlaz <dlaz@chromium.org> richard.o.dodd <richard.o.dodd@gmail.com> kerneldev <kerneldev@karsmulder.nl> linux-usb <linux-usb@vger.kernel.org> linux-kernel <linux-kernel@vger.kernel.org>  
> Sent: 2020-11-18 21:08
> Subject: Re:Re: [PATCH] USB: quirks: Add USB_QUIRK_DISCONNECT_SUSPEND quirk forLenovo A630Z TIO built-in usb-audio card
> 
> Hi penghao,
> 
> > On Nov 18, 2020, at 20:30, penghao <penghao@uniontech.com> wrote:
> > 
> > Add a USB_QUIRK_DISCONNECT_SUSPEND quirk for the Lenovo TIO built-in
> > usb-audio. when A630Z going into S3,the system immediately wakeup 7-8
> > seconds later by usb-audio disconnect interrupt to avoids the issue.
> > eg dmesg:
> > ....
> > [ 626.974091 ] usb 7-1.1: USB disconnect, device number 3
> > ....
> > ....
> > [ 1774.486691] usb 7-1.1: new full-speed USB device number 5 using xhci_hcd
> > [ 1774.947742] usb 7-1.1: New USB device found, idVendor=17ef, idProduct=a012, bcdDevice= 0.55
> > [ 1774.956588] usb 7-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> > [ 1774.964339] usb 7-1.1: Product: Thinkcentre TIO24Gen3 for USB-audio
> > [ 1774.970999] usb 7-1.1: Manufacturer: Lenovo
> > [ 1774.975447] usb 7-1.1: SerialNumber: 000000000000
> > [ 1775.048590] usb 7-1.1: 2:1: cannot get freq at ep 0x1
> 
> Can you please attach full dmesg with dynamic debug enabled when the issue happens?
> 
> We may need to poll for U3 in xhci_bus_suspend().
> 
> Kai-Heng
> 
> > .......
> > Seeking a better fix, we've tried a lot of things, including:
> > - Check that the device's power/wakeup is disabled
> > - Check that remote wakeup is off at the USB level
> > - All the quirks in drivers/usb/core/quirks.c
> > e.g. USB_QUIRK_RESET_RESUME,
> > USB_QUIRK_RESET,
> > USB_QUIRK_IGNORE_REMOTE_WAKEUP,
> > USB_QUIRK_NO_LPM.
> > 
> > but none of that makes any difference.
> > 
> > There are no errors in the logs showing any suspend/resume-related issues.
> > When the system wakes up due to the modem, log-wise it appears to be a
> > normal resume.
> > 
> > Introduce a quirk to disable the port during suspend when the modem is
> > detected.
> > 
> > Changes since v5
> > - Add dmesg for this issue
> > 
> > Changes since v4
> > - Fixed add a blank line
> > 
> > Changes since v3
> > - Fixed spelling error on appropriate
> > 
> > Changes since v2
> > - Add Changes commit format
> > 
> > Changes since v1
> > - Change subject form "ALSA" to "USB:"
> > - Adjust to appropriate line
> > 
> > Signed-off-by: penghao <penghao@uniontech.com>
> > ---
> > drivers/usb/core/quirks.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> > index 7c1198f80c23..26b852ae0d85 100644
> > --- a/drivers/usb/core/quirks.c
> > +++ b/drivers/usb/core/quirks.c
> > @@ -410,6 +410,10 @@ static const struct usb_device_id usb_quirk_list[] = {
> > { USB_DEVICE(0x1532, 0x0116), .driver_info =
> > USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
> > 
> > + /* Lenovo ThinkCenter A630Z TI024Gen3 usb-audio */
> > + { USB_DEVICE(0x17ef, 0xa012), .driver_info =
> > + USB_QUIRK_DISCONNECT_SUSPEND },
> > +
> > /* BUILDWIN Photo Frame */
> > { USB_DEVICE(0x1908, 0x1315), .driver_info =
> > USB_QUIRK_HONOR_BNUMINTERFACES },
> > -- 
> > 2.11.0
> > 
> > 
> > 
> 
> 
> 

