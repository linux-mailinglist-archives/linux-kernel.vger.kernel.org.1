Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA312A80C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbgKEOWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:22:51 -0500
Received: from mout.web.de ([212.227.15.14]:60659 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbgKEOWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1604586157;
        bh=rnIIBiT2XH2YOzaU1KV99Ptnbpj1nC9fup2j0vj6xmk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ua5LObhHFNUTDlB3WE79us+Y58NxiECpictb80v12CDzQeLVX1jlkuEg8j3EkaJVG
         zx/6DkrvdrnBRDqMnZSl7CiaYHIbyyp2pFmrOmI4CN4GZv4af0g/s66SdMUFe52AZS
         zweytWQt45WnHTsPonwjkXA0uwq1tFXA9HbOgv5c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [10.0.0.110] ([193.36.117.236]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N62ua-1kH8450XYu-016Fdr; Thu, 05
 Nov 2020 15:22:37 +0100
Subject: Re: [Regression]: Commit 74d905d2 breaks the touchpad and touchscreen
 of Google Chromebook "samus"
To:     "Wang, Jiada" <jiada_wang@mentor.com>,
        Nick Dyer <nick.dyer@itdev.co.uk>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "George G. Davis" <george_davis@mentor.com>,
        linux-kernel@vger.kernel.org
References: <735253bd-5500-2b8d-c98d-99bddb0617ce@web.de>
 <beae40be-4e84-ceea-ee00-351b18b26e06@mentor.com>
From:   Andre Muller <andre.muller@web.de>
Message-ID: <69305cdf-1ba7-a51a-302c-9b1b83e788aa@web.de>
Date:   Thu, 5 Nov 2020 15:23:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <beae40be-4e84-ceea-ee00-351b18b26e06@mentor.com>
Content-Type: multipart/mixed;
 boundary="------------10A0FECCE13E1E1118BE4ECD"
Content-Language: en-US
X-Provags-ID: V03:K1:ZMo3Fv6G9ssCQOEcRP3x7nMoF2S/Tc7VXWEdNODjn2m+ppxzZ12
 Rk6dujQviJFQy2Jk3suGcTn6h5Xyh82U6l/LRu5BSwzXxLCOZIX/ot88egDeX0SR8dx0TGV
 i5FRJr3v3faz1iweVmwri/nas79faAMId3soN2FWjGO2JE2+PWMwv6IQSscTJenuNUNuN1u
 ke6S4rOHxb9U/zX+tjD4w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eH8q4aqd4fQ=:WjJtz/ZmAcYIBSeMWxqCOD
 NnzYHI2SkV8r1nmvX8XaqEVbzLp0YrIZ25Zu9Xnf5kTUYBlx48ENj/SkXrNHiwidaYPYp5Ssp
 NRknB6qr+DTgbJPsyEDaHpGAFHN92mGTn9BqcC/H26pbwswOpD2PSoWUsUR926XM6rez/gaz/
 a425udvoOaegQgvbLt0uRHB9jjepG3kSxDBeWGHylrxFO05hdInKdhaUAR2g9pNdw6zKbCXX2
 0oZwK73DZ7QCuVMgLCy5tYDMHLLjm5gizO8+WAXvqDwjYrNG+Jkap+TWyb9JQedFQ5igFGkW3
 mCZVPn0UuOju0LN9CAM9C3EKoMvX6yzlZw2ltwh1DRV//zF50u9ZKpstWCcFTZmU60TZ2j7hh
 820cQ/6aGKVMlId4awPsqRu6u8zrTx9Z2puvitJLZFPblajIJbiBUu1sks+qQt++MuyhBgfp9
 Gxf7psPrcghddTlfC4aNuLd0Ca/Qkcf5+S8F/DHfRzYAxfdGTWvk1KV3yej2cnmW0MndvOHbs
 2lhphErvApDNhsUydI78mqlXKCWfPfqKVob86Gz0tMDJzsYAIYVH3CSHhXap94Xkyy5UZvREv
 UHVkOxASxuxSY+Tqkn8Vwrl4cnjnCTcI3l5PV5J5jBhpBbNJbsqsEr/cL3ivWJBXL7mz01cyn
 /FIlaCzSw750181zw96mpXEJogSlQRscxPF4DG7I259ZMLMCtU9JPYYfV3JcivxFDEdoWNEoK
 3hqHOxjmhEIYed8GnpT4GIfU2TTG8qygZ3nIepvpXjQgFupCkV5DY0uE0+MF8/BpTT0dCFonF
 ZuLs7PkMeCaexbpj3IEz7PcZPGwJYDYrNY5GGdyYjaUP5mJEeS0mxeUy/zt0X3KSLXysUogdn
 KeRkyXqqT/94yRtElYuw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------10A0FECCE13E1E1118BE4ECD
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

On 05/11/2020 14.25, Wang, Jiada wrote:
> Hi Andre
>
> Thanks for your report,
> could you also please post the log when with this commit reverted?
>
> Thanks,
> Jiada

Shure!
The full dmesg with the revert is attached.

The atmel_mxt bits are:

[    0.195879] atmel_mxt_ts i2c-ATML0000:01: Family: 164 Variant: 17 Firmw=
are V1.0.AA Objects: 32
[    0.211712] atmel_mxt_ts i2c-ATML0000:01: Direct firmware load for maxt=
ouch.cfg failed with error -2
[    0.212986] atmel_mxt_ts i2c-ATML0000:01: Touchscreen size X960Y540
[    0.213025] input: Atmel maXTouch Touchpad as /devices/pci0000:00/INT34=
32:00/i2c-0/i2c-ATML0000:01/input/input4
[    0.219208] atmel_mxt_ts i2c-ATML0001:01: Family: 164 Variant: 13 Firmw=
are V1.0.AA Objects: 41
[    0.238825] atmel_mxt_ts i2c-ATML0001:01: Direct firmware load for maxt=
ouch.cfg failed with error -2
[    0.238949] intel_rapl_common: Found RAPL domain package
[    0.238955] intel_rapl_common: Found RAPL domain core
[    0.238961] intel_rapl_common: Found RAPL domain uncore
[    0.238966] intel_rapl_common: Found RAPL domain dram
[    0.240121] atmel_mxt_ts i2c-ATML0001:01: Touchscreen size X2559Y1699
[    0.240157] input: Atmel maXTouch Touchscreen as /devices/pci0000:00/IN=
T3433:00/i2c-1/i2c-ATML0001:01/input/input5

Regards,
Andre

>
> On 2020/11/04 17:13, Andre wrote:
>> Hi,
>>
>> commit 74d905d2: Input: atmel_mxt_ts - only read messages in
>> mxt_acquire_irq() when necessary
>>
>> breaks the touchpad and touchscreen of the 2015 Chromebook Pixel "Samus=
".
>>
>> Reverting the commit from the current git tree gets them to work again.
>>
>> I am not at all shure what info to include, but I will happily provide
>> it on request.
>>
>> The dmesgs of a boot with commit 74d905d2 show "Enabling RETRIGEN
>> workaround", but otherwise looks the same as a boot without.
>>
>> Here is the relevant bit (with 74d905d2):
>>
>> atmel_mxt_ts i2c-ATML0000:01: Family: 164 Variant: 17 Firmware V1.0.AA
>> Objects: 32
>> atmel_mxt_ts i2c-ATML0000:01: Enabling RETRIGEN workaround
>> atmel_mxt_ts i2c-ATML0000:01: Direct firmware load for maxtouch.cfg
>> failed with error -2
>> atmel_mxt_ts i2c-ATML0000:01: Touchscreen size X960Y540
>> input: Atmel maXTouch Touchpad as
>> /devices/pci0000:00/INT3432:00/i2c-0/i2c-ATML0000:01/input/input4
>> atmel_mxt_ts i2c-ATML0001:01: Family: 164 Variant: 13 Firmware V1.0.AA
>> Objects: 41
>> atmel_mxt_ts i2c-ATML0001:01: Enabling RETRIGEN workaround
>> atmel_mxt_ts i2c-ATML0001:01: Direct firmware load for maxtouch.cfg
>> failed with error -2
>>
>> Thank you,
>> Andre M=FCller


--------------10A0FECCE13E1E1118BE4ECD
Content-Type: text/plain; charset=UTF-8;
 name="dmesg-5.10_without_74d905d2d"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="dmesg-5.10_without_74d905d2d"

[    0.000000] microcode: microcode updated early to revision 0x2f, date =
=3D 2019-11-12
[    0.000000] Linux version 5.10.0-rc2+ (andre@monty) (gcc (Gentoo 9.3.0-=
r1 p3) 9.3.0, GNU ld (Gentoo 2.34 p6) 2.34.0) #3 SMP Thu Nov 5 15:01:08 CE=
T 2020
[    0.000000] Command line: BOOT_IMAGE=3Dnew root=3D802
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating poin=
t registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 b=
ytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usab=
le
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ce27fff] usab=
le
[    0.000000] BIOS-e820: [mem 0x000000007ce28000-0x000000007fffffff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f3ffffff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed19fff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed84fff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027effffff] usab=
le
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: GOOGLE Samus, BIOS  04/02/2015
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2194.753 MHz processor
[    0.000288] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> res=
erved
[    0.000291] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000295] last_pfn =3D 0x27f000 max_arch_pfn =3D 0x400000000
[    0.000299] MTRR default type: uncachable
[    0.000300] MTRR fixed ranges enabled:
[    0.000302]   00000-9FFFF write-back
[    0.000302]   A0000-BFFFF uncachable
[    0.000303]   C0000-FFFFF write-back
[    0.000304] MTRR variable ranges enabled:
[    0.000305]   0 base 0000000000 mask 7F80000000 write-back
[    0.000307]   1 base 007D800000 mask 7FFF800000 uncachable
[    0.000307]   2 base 007E000000 mask 7FFE000000 uncachable
[    0.000308]   3 base 00D0000000 mask 7FF0000000 write-combining
[    0.000309]   4 base 00FF800000 mask 7FFF800000 uncachable
[    0.000310]   5 base 0100000000 mask 7F00000000 write-back
[    0.000311]   6 base 0200000000 mask 7F80000000 write-back
[    0.000312]   7 base 027F000000 mask 7FFF000000 uncachable
[    0.000313]   8 disabled
[    0.000313]   9 disabled
[    0.000657] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- W=
T
[    0.001138] last_pfn =3D 0x7ce28 max_arch_pfn =3D 0x400000000
[    0.001148] Using GB pages for direct mapping
[    0.001306] ACPI: Early table checksum verification disabled
[    0.001309] ACPI: RSDP 0x00000000000F7B40 000024 (v02 CORE  )
[    0.001312] ACPI: XSDT 0x000000007CF440E0 00004C (v01 CORE   COREBOOT 0=
0000000 CORE 00000000)
[    0.001318] ACPI: FACP 0x000000007CF48970 0000F4 (v05 CORE   COREBOOT 0=
0000000 CORE 00000001)
[    0.001322] ACPI: DSDT 0x000000007CF44250 004720 (v02 COREv4 COREBOOT 2=
0110725 INTL 20130117)
[    0.001326] ACPI: FACS 0x000000007CF44210 000040
[    0.001328] ACPI: FACS 0x000000007CF44210 000040
[    0.001331] ACPI: HPET 0x000000007CF48A70 000038 (v01 CORE   COREBOOT 0=
0000000 CORE 00000000)
[    0.001334] ACPI: APIC 0x000000007CF48AB0 00006C (v01 CORE   COREBOOT 0=
0000000 CORE 00000000)
[    0.001337] ACPI: MCFG 0x000000007CF48B20 00003C (v01 CORE   COREBOOT 0=
0000000 CORE 00000000)
[    0.001340] ACPI: SSDT 0x000000007CF49BC0 000FF8 (v02 CORE   COREBOOT 0=
000002A CORE 0000002A)
[    0.001346] ACPI: Local APIC address 0xfee00000
[    0.001381] No NUMA configuration found
[    0.001383] Faking a node at [mem 0x0000000000000000-0x000000027effffff=
]
[    0.001385] NODE_DATA(0) allocated [mem 0x27effe000-0x27effffff]
[    0.001397] Zone ranges:
[    0.001398]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.001399]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.001401]   Normal   [mem 0x0000000100000000-0x000000027effffff]
[    0.001402] Movable zone start for each node
[    0.001403] Early memory node ranges
[    0.001404]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.001405]   node   0: [mem 0x0000000000100000-0x000000007ce27fff]
[    0.001406]   node   0: [mem 0x0000000100000000-0x000000027effffff]
[    0.001531] Zeroed struct page in unavailable ranges: 16954 pages
[    0.001533] Initmem setup node 0 [mem 0x0000000000001000-0x000000027eff=
ffff]
[    0.001534] On node 0 totalpages: 2080198
[    0.001535]   DMA zone: 64 pages used for memmap
[    0.001536]   DMA zone: 21 pages reserved
[    0.001537]   DMA zone: 3998 pages, LIFO batch:0
[    0.001562]   DMA32 zone: 7929 pages used for memmap
[    0.001562]   DMA32 zone: 507432 pages, LIFO batch:63
[    0.005222]   Normal zone: 24512 pages used for memmap
[    0.005224]   Normal zone: 1568768 pages, LIFO batch:63
[    0.016716] Reserving Intel graphics memory at [mem 0x7e000000-0x7fffff=
ff]
[    0.016923] ACPI: PM-Timer IO Port: 0x1008
[    0.016926] ACPI: Local APIC address 0xfee00000
[    0.016941] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0=
-39
[    0.016943] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.016945] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.016946] ACPI: IRQ0 used by override.
[    0.016947] ACPI: IRQ9 used by override.
[    0.016949] Using ACPI (MADT) for SMP configuration information
[    0.016950] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.016953] TSC deadline timer available
[    0.016955] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.016964] [mem 0x80000000-0xefffffff] available for PCI devices
[    0.016967] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.021039] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_n=
ode_ids:1
[    0.021259] percpu: Embedded 41 pages/cpu s138840 r0 d29096 u524288
[    0.021264] pcpu-alloc: s138840 r0 d29096 u524288 alloc=3D1*2097152
[    0.021265] pcpu-alloc: [0] 0 1 2 3
[    0.021277] Built 1 zonelists, mobility grouping on.  Total pages: 2047=
672
[    0.021279] Policy zone: Normal
[    0.021280] Kernel command line: root=3D/dev/sda2 rfkill.default_state=
=3D0 mitigations=3Dauto,nosmt
[    0.021926] Dentry cache hash table entries: 1048576 (order: 11, 838860=
8 bytes, linear)
[    0.022234] Inode-cache hash table entries: 524288 (order: 10, 4194304 =
bytes, linear)
[    0.022268] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.047558] Memory: 8083776K/8320792K available (12290K kernel code, 14=
98K rwdata, 3328K rodata, 916K init, 2340K bss, 236756K reserved, 0K cma-r=
eserved)
[    0.047594] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, =
Nodes=3D1
[    0.047599] Kernel/User page tables isolation: enabled
[    0.047648] rcu: Hierarchical RCU implementation.
[    0.047649] rcu: 	RCU event tracing is enabled.
[    0.047650] rcu: RCU calculated value of scheduler-enlistment delay is =
30 jiffies.
[    0.047661] NR_IRQS: 4352, nr_irqs: 728, preallocated irqs: 16
[    0.047934] random: get_random_bytes called from start_kernel+0x2d4/0x4=
25 with crng_init=3D0
[    0.048235] Console: colour dummy device 320x106
[    0.048317] printk: console [tty0] enabled
[    0.048330] ACPI: Core revision 20200925
[    0.048386] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff,=
 max_idle_ns: 133484882848 ns
[    0.048399] APIC: Switch to symmetric I/O mode setup
[    0.048960] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=
=3D-1
[    0.065071] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles=
: 0x1fa2d61a7b1, max_idle_ns: 440795235980 ns
[    0.065076] Calibrating delay loop (skipped), value calculated using ti=
mer frequency.. 4391.40 BogoMIPS (lpj=3D7315843)
[    0.065080] pid_max: default: 32768 minimum: 301
[    0.065094] LSM: Security Framework initializing
[    0.065120] Mount-cache hash table entries: 16384 (order: 5, 131072 byt=
es, linear)
[    0.065138] Mountpoint-cache hash table entries: 16384 (order: 5, 13107=
2 bytes, linear)
[    0.065317] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.065330] process: using mwait in idle threads
[    0.065333] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.065335] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.065339] Spectre V1 : Mitigation: usercopy/swapgs barriers and __use=
r pointer sanitization
[    0.065341] Spectre V2 : Mitigation: Full generic retpoline
[    0.065342] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RS=
B on context switch
[    0.065344] Spectre V2 : Enabling Restricted Speculation for firmware c=
alls
[    0.065346] Spectre V2 : mitigation: Enabling conditional Indirect Bran=
ch Prediction Barrier
[    0.065348] Spectre V2 : User space: Mitigation: STIBP via seccomp and =
prctl
[    0.065350] Speculative Store Bypass: Mitigation: Speculative Store Byp=
ass disabled via prctl and seccomp
[    0.065352] SMT: disabled
[    0.065359] SMT: disabled
[    0.065365] SRBDS: Mitigation: Microcode
[    0.065370] MDS: Mitigation: Clear CPU buffers
[    0.065511] Freeing SMP alternatives memory: 36K
[    0.067725] smpboot: CPU0: Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz (fa=
mily: 0x6, model: 0x3d, stepping: 0x4)
[    0.067797] Performance Events: PEBS fmt2+, Broadwell events, 16-deep L=
BR, full-width counters, Intel PMU driver.
[    0.067822] ... version:                3
[    0.067827] ... bit width:              48
[    0.067831] ... generic registers:      4
[    0.067835] ... value mask:             0000ffffffffffff
[    0.067840] ... max period:             00007fffffffffff
[    0.067844] ... fixed-purpose events:   3
[    0.067848] ... event mask:             000000070000000f
[    0.067936] rcu: Hierarchical SRCU implementation.
[    0.067997] smp: Bringing up secondary CPUs ...
[    0.068054] x86: Booting SMP configuration:
[    0.068059] .... node  #0, CPUs:      #1 #2 #3
[    0.069971] smp: Brought up 1 node, 2 CPUs
[    0.069971] smpboot: Max logical packages: 2
[    0.069971] smpboot: Total of 2 processors activated (8782.80 BogoMIPS)
[    0.069971] devtmpfs: initialized
[    0.069971] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffff=
ff, max_idle_ns: 6370867519511994 ns
[    0.069971] futex hash table entries: 1024 (order: 4, 65536 bytes, line=
ar)
[    0.069971] pinctrl core: initialized pinctrl subsystem
[    0.069971] pinctrl core: failed to create debugfs directory
[    0.069971] NET: Registered protocol family 16
[    0.069971] thermal_sys: Registered thermal governor 'step_wise'
[    0.069971] thermal_sys: Registered thermal governor 'user_space'
[    0.069971] cpuidle: using governor teo
[    0.069971] ACPI: bus type PCI registered
[    0.069971] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xf000000=
0-0xffffffff] (base 0xf0000000)
[    0.069971] PCI: MMCONFIG at [mem 0xf0000000-0xffffffff] reserved in E8=
20
[    0.069971] PCI: MMCONFIG for 0000 [bus00-3f] at [mem 0xf0000000-0xf3ff=
ffff] (base 0xf0000000) (size reduced!)
[    0.069971] PCI: Using configuration type 1 for base access
[    0.072793] HugeTLB registered 2.00 MiB page size, pre-allocated 0 page=
s
[    0.072793] raid6: skip pq benchmark and using algorithm avx2x4
[    0.072793] raid6: using avx2x2 recovery algorithm
[    0.072793] ACPI: Added _OSI(Module Device)
[    0.072793] ACPI: Added _OSI(Processor Device)
[    0.072793] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.072793] ACPI: Added _OSI(Processor Aggregator Device)
[    0.072793] ACPI: Added _OSI(Linux-Dell-Video)
[    0.072793] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.072793] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.073175] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.075897] ACPI: EC: EC started
[    0.075903] ACPI: EC: interrupt blocked
[    0.075966] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.075971] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle tra=
nsactions
[    0.075976] ACPI: Interpreter enabled
[    0.075992] ACPI: (supports S0 S1 S2 S3 S5)
[    0.075996] ACPI: Using IOAPIC for interrupt routing
[    0.076013] PCI: Using host bridge windows from ACPI; if necessary, use=
 "pci=3Dnocrs" and report a bug
[    0.079257] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.079267] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Clo=
ckPM Segments MSI HPX-Type3]
[    0.079298] acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability =
LTR]
[    0.079308] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 =
[bus 00-3f] only partially covers this bridge
[    0.079349] acpi PNP0A08:00: ignoring host bridge window [mem 0x000c400=
0-0x000c7fff window] (conflicts with Video ROM [mem 0x000c0000-0x000c6dff]=
)
[    0.079372] PCI host bridge to bus 0000:00
[    0.079377] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 windo=
w]
[    0.079382] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff windo=
w]
[    0.079387] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bff=
ff window]
[    0.079392] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3f=
ff window]
[    0.079397] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbf=
ff window]
[    0.079402] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cff=
ff window]
[    0.079407] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3f=
ff window]
[    0.079412] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7f=
ff window]
[    0.079417] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbf=
ff window]
[    0.079422] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dff=
ff window]
[    0.079427] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3f=
ff window]
[    0.079432] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7f=
ff window]
[    0.079437] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebf=
ff window]
[    0.079442] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000eff=
ff window]
[    0.079447] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fff=
ff window]
[    0.079452] pci_bus 0000:00: root bus resource [mem 0x80000001-0xfebfff=
ff window]
[    0.079457] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44f=
ff window]
[    0.079462] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.079477] pci 0000:00:00.0: [8086:1604] type 00 class 0x060000
[    0.079570] pci 0000:00:02.0: [8086:1616] type 00 class 0x030000
[    0.079583] pci 0000:00:02.0: reg 0x10: [mem 0xe0000000-0xe0ffffff 64bi=
t]
[    0.079592] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff 64bi=
t pref]
[    0.079600] pci 0000:00:02.0: reg 0x20: [io  0x1800-0x183f]
[    0.079614] pci 0000:00:02.0: DMAR: Disabling IOMMU for graphics on thi=
s chipset
[    0.079675] pci 0000:00:03.0: [8086:160c] type 00 class 0x040300
[    0.079687] pci 0000:00:03.0: reg 0x10: [mem 0xe1218000-0xe121bfff 64bi=
t]
[    0.079783] pci 0000:00:14.0: [8086:9cb1] type 00 class 0x0c0330
[    0.079803] pci 0000:00:14.0: reg 0x10: [mem 0xe1200000-0xe120ffff 64bi=
t]
[    0.079860] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.079947] pci 0000:00:1c.0: [8086:9c94] type 01 class 0x060400
[    0.080035] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.080132] pci 0000:00:1f.0: [8086:9cc3] type 00 class 0x060100
[    0.080305] pci 0000:00:1f.2: [8086:9c83] type 00 class 0x010601
[    0.080321] pci 0000:00:1f.2: reg 0x10: [io  0x1860-0x1867]
[    0.080332] pci 0000:00:1f.2: reg 0x14: [io  0x1870-0x1873]
[    0.080343] pci 0000:00:1f.2: reg 0x18: [io  0x1868-0x186f]
[    0.080354] pci 0000:00:1f.2: reg 0x1c: [io  0x1874-0x1877]
[    0.080365] pci 0000:00:1f.2: reg 0x20: [io  0x1840-0x185f]
[    0.080377] pci 0000:00:1f.2: reg 0x24: [mem 0xe1210000-0xe1217fff]
[    0.080411] pci 0000:00:1f.2: PME# supported from D3hot
[    0.080493] pci 0000:00:1f.6: [8086:9ca4] type 00 class 0x118000
[    0.080525] pci 0000:00:1f.6: reg 0x10: [mem 0xe1225000-0xe1225fff 64bi=
t]
[    0.080886] pci 0000:01:00.0: [8086:08b1] type 00 class 0x028000
[    0.080979] pci 0000:01:00.0: reg 0x10: [mem 0xe1100000-0xe1101fff 64bi=
t]
[    0.081283] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.081812] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.081823] pci 0000:00:1c.0:   bridge window [mem 0xe1100000-0xe11ffff=
f]
[    0.082131] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 =
15) *11, disabled.
[    0.082182] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 =
15) *10, disabled.
[    0.082228] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 =
15) *11, disabled.
[    0.082274] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14=
 15), disabled.
[    0.082320] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 =
15) *0, disabled.
[    0.082365] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 =
15) *0, disabled.
[    0.082411] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 =
15) *0, disabled.
[    0.082462] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 =
15) *0, disabled.
[    0.083234] ACPI: EC: interrupt unblocked
[    0.083240] ACPI: EC: event unblocked
[    0.083250] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.083255] ACPI: EC: GPE=3D0x24
[    0.083260] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization com=
plete
[    0.083265] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions=
 and events
[    0.083321] iommu: Default domain type: Translated
[    0.083321] SCSI subsystem initialized
[    0.083321] libata version 3.00 loaded.
[    0.098495] pxa2xx-spi INT3430:00: no DMA channels available, using PIO
[    0.098835] ACPI: bus type USB registered
[    0.098855] usbcore: registered new interface driver usbfs
[    0.098864] usbcore: registered new interface driver hub
[    0.098878] usbcore: registered new device driver usb
[    0.132780] pps_core: LinuxPPS API ver. 1 registered
[    0.132787] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo=
 Giometti <giometti@linux.it>
[    0.132794] PTP clock support registered
[    0.132806] EDAC MC: Ver: 3.0.0
[    0.132995] Advanced Linux Sound Architecture Driver Initialized.
[    0.132995] PCI: Using ACPI for IRQ routing
[    0.136248] PCI: pci_cache_line_size set to 64 bytes
[    0.136563] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.136564] e820: reserve RAM buffer [mem 0x7ce28000-0x7fffffff]
[    0.136565] e820: reserve RAM buffer [mem 0x27f000000-0x27fffffff]
[    0.136601] clocksource: Switched to clocksource tsc-early
[    0.136661] pnp: PnP ACPI init
[    0.136714] system 00:00: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.136721] system 00:00: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.136727] system 00:00: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.136732] system 00:00: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.136738] system 00:00: [mem 0xf0000000-0xf3ffffff] has been reserved
[    0.136743] system 00:00: [mem 0xfed80000-0xfed83fff] has been reserved
[    0.136749] system 00:00: [mem 0xfed84000-0xfed84fff] has been reserved
[    0.136758] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (activ=
e)
[    0.136856] system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.136864] system 00:01: Plug and Play ACPI device, IDs PNP0103 PNP0c0=
1 (active)
[    0.136894] system 00:02: [io  0x1000-0x10fe] has been reserved
[    0.136902] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (activ=
e)
[    0.136916] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.137043] system 00:04: [io  0x0900-0x09fe] has been reserved
[    0.137051] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (activ=
e)
[    0.137077] system 00:05: [io  0x0200] has been reserved
[    0.137083] system 00:05: [io  0x0204] has been reserved
[    0.137088] system 00:05: [io  0x0800-0x087f] has been reserved
[    0.137093] system 00:05: [io  0x0880-0x08ff] has been reserved
[    0.137101] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (activ=
e)
[    0.137120] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.137138] pnp 00:07: Plug and Play ACPI device, IDs PNP0303 PNP030b (=
active)
[    0.137220] pnp 00:08: Plug and Play ACPI device, IDs PNP0c31 (active)
[    0.137317] system 00:09: [mem 0xe121e000-0xe121efff] has been reserved
[    0.137331] system 00:09: [mem 0xe1220000-0xe1220fff] has been reserved
[    0.137336] system 00:09: [mem 0xe1222000-0xe1222fff] has been reserved
[    0.137341] system 00:09: [mem 0xe1224000-0xe1224fff] has been reserved
[    0.137348] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (activ=
e)
[    0.137442] pnp: PnP ACPI: found 10 devices
[    0.140221] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, =
max_idle_ns: 2085701024 ns
[    0.140221] NET: Registered protocol family 2
[    0.140221] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4=
, 65536 bytes, linear)
[    0.140221] TCP established hash table entries: 65536 (order: 7, 524288=
 bytes, linear)
[    0.140221] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes=
, linear)
[    0.140221] TCP: Hash tables configured (established 65536 bind 65536)
[    0.140221] UDP hash table entries: 4096 (order: 5, 131072 bytes, linea=
r)
[    0.140221] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, =
linear)
[    0.141749] NET: Registered protocol family 1
[    0.141763] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.141778] pci 0000:00:1c.0:   bridge window [mem 0xe1100000-0xe11ffff=
f]
[    0.141791] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.141796] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.141801] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff wind=
ow]
[    0.141806] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff wind=
ow]
[    0.141811] pci_bus 0000:00: resource 8 [mem 0x000c8000-0x000cbfff wind=
ow]
[    0.141816] pci_bus 0000:00: resource 9 [mem 0x000cc000-0x000cffff wind=
ow]
[    0.141821] pci_bus 0000:00: resource 10 [mem 0x000d0000-0x000d3fff win=
dow]
[    0.141826] pci_bus 0000:00: resource 11 [mem 0x000d4000-0x000d7fff win=
dow]
[    0.141831] pci_bus 0000:00: resource 12 [mem 0x000d8000-0x000dbfff win=
dow]
[    0.141836] pci_bus 0000:00: resource 13 [mem 0x000dc000-0x000dffff win=
dow]
[    0.141841] pci_bus 0000:00: resource 14 [mem 0x000e0000-0x000e3fff win=
dow]
[    0.141846] pci_bus 0000:00: resource 15 [mem 0x000e4000-0x000e7fff win=
dow]
[    0.141851] pci_bus 0000:00: resource 16 [mem 0x000e8000-0x000ebfff win=
dow]
[    0.141856] pci_bus 0000:00: resource 17 [mem 0x000ec000-0x000effff win=
dow]
[    0.141860] pci_bus 0000:00: resource 18 [mem 0x000f0000-0x000fffff win=
dow]
[    0.141865] pci_bus 0000:00: resource 19 [mem 0x80000001-0xfebfffff win=
dow]
[    0.141870] pci_bus 0000:00: resource 20 [mem 0xfed40000-0xfed44fff win=
dow]
[    0.141875] pci_bus 0000:01: resource 1 [mem 0xe1100000-0xe11fffff]
[    0.141924] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x=
000c0000-0x000dffff]
[    0.142252] PCI: CLS 64 bytes, default 64
[    0.142267] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.142272] software IO TLB: mapped [mem 0x0000000078e28000-0x000000007=
ce28000] (64MB)
[    0.142308] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 65536=
0 ms ovfl timer
[    0.142313] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    0.142317] RAPL PMU: hw unit of domain package 2^-14 Joules
[    0.142322] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    0.142326] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    0.142753] Initialise system trusted keyrings
[    0.142780] workingset: timestamp_bits=3D45 max_order=3D21 bucket_order=
=3D0
[    0.154573] xor: automatically using best checksumming function   avx
[    0.154579] Key type asymmetric registered
[    0.154584] Asymmetric key parser 'x509' registered
[    0.154593] Block layer SCSI generic (bsg) driver version 0.4 loaded (m=
ajor 249)
[    0.154598] io scheduler mq-deadline registered
[    0.154603] io scheduler kyber registered
[    0.154797] pcieport 0000:00:1c.0: PME: Signaling with IRQ 40
[    0.154875] intel_idle: MWAIT substates: 0x11142120
[    0.154876] intel_idle: v0.5.1 model 0x3D
[    0.154994] intel_idle: Local APIC timer is reliable in all C-states
[    0.155092] ACPI: AC Adapter [AC] (off-line)
[    0.155158] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C=
0D:00/input/input0
[    0.155187] ACPI: Lid Switch [LID0]
[    0.155213] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP=
0C0C:00/input/input1
[    0.155230] ACPI: Power Button [PWRB]
[    0.155253] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inp=
ut/input2
[    0.155275] ACPI: Power Button [PWRF]
[    0.155886] thermal LNXTHERM:00: registered as thermal_zone0
[    0.155891] ACPI: Thermal Zone [THRM] (42 C)
[    0.156300] battery: ACPI: Battery Slot [BAT0] (battery present)
[    0.156334] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.156544] Non-volatile memory driver v1.3
[    0.156582] Linux agpgart interface v0.103
[    0.156992] resource sanity check: requesting [mem 0x000c0000-0x000dfff=
f], which spans more than PCI Bus 0000:00 [mem 0x000c0000-0x000c3fff windo=
w]
[    0.157015] caller pci_map_rom+0x65/0x180 mapping multiple BARs
[    0.157021] i915 0000:00:02.0: Invalid PCI ROM data signature: expectin=
g 0x52494350, got 0xe937aa55
[    0.157040] i915 0000:00:02.0: [drm] Failed to find VBIOS tables (VBT)
[    0.171216] [drm] Initialized i915 1.6.0 20200917 for 0000:00:02.0 on m=
inor 0
[    0.172163] loop: module loaded
[    0.172279] ahci 0000:00:1f.2: version 3.0
[    0.172418] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    0.185090] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0=
x1 impl SATA mode
[    0.185097] ahci 0000:00:1f.2: flags: 64bit ncq ilck stag pm led clo on=
ly pio slum part deso sadm sds apst
[    0.185357] scsi host0: ahci
[    0.185465] scsi host1: ahci
[    0.185543] scsi host2: ahci
[    0.185732] scsi host3: ahci
[    0.185779] ata1: SATA max UDMA/133 abar m32768@0xe1210000 port 0xe1210=
100 irq 42
[    0.185785] ata2: DUMMY
[    0.185790] ata3: DUMMY
[    0.185795] ata4: DUMMY
[    0.185835] tun: Universal TUN/TAP device driver, 1.6
[    0.185898] usbcore: registered new interface driver r8152
[    0.186018] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.186028] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus=
 number 1
[    0.187090] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x=
100 quirks 0x000000000004b810
[    0.187100] xhci_hcd 0000:00:14.0: cache line size of 64 is not support=
ed
[    0.187213] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.10
[    0.187221] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[    0.187227] usb usb1: Product: xHCI Host Controller
[    0.187232] usb usb1: Manufacturer: Linux 5.10.0-rc2+ xhci-hcd
[    0.187238] usb usb1: SerialNumber: 0000:00:14.0
[    0.187336] hub 1-0:1.0: USB hub found
[    0.187353] hub 1-0:1.0: 11 ports detected
[    0.187566] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.187573] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus=
 number 2
[    0.187580] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    0.187614] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.10
[    0.187620] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[    0.187625] usb usb2: Product: xHCI Host Controller
[    0.187629] usb usb2: Manufacturer: Linux 5.10.0-rc2+ xhci-hcd
[    0.187634] usb usb2: SerialNumber: 0000:00:14.0
[    0.187698] hub 2-0:1.0: USB hub found
[    0.187711] hub 2-0:1.0: 4 ports detected
[    0.187829] usbcore: registered new interface driver usb-storage
[    0.187853] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq=
 1
[    0.187858] i8042: PNP: PS/2 appears to have AUX port disabled, if this=
 is incorrect please boot with i8042.nopnp
[    0.188463] i8042: Warning: Keylock active
[    0.188601] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.188634] mousedev: PS/2 mouse device common for all mice
[    0.188902] rtc_cmos 00:03: RTC can wake from S4
[    0.189102] rtc_cmos 00:03: registered as rtc0
[    0.189116] rtc_cmos 00:03: alarms up to one month, 242 bytes nvram, hp=
et irqs
[    0.189243] intel_pstate: Intel P-state driver initializing
[    0.189356] hid: raw HID events driver (C) Jiri Kosina
[    0.189402] usbcore: registered new interface driver usbhid
[    0.189416] usbhid: USB HID core driver
[    0.192534] input: AT Translated Set 2 keyboard as /devices/platform/i8=
042/serio0/input/input3
[    0.195462] random: fast init done
[    0.195879] atmel_mxt_ts i2c-ATML0000:01: Family: 164 Variant: 17 Firmw=
are V1.0.AA Objects: 32
[    0.211712] atmel_mxt_ts i2c-ATML0000:01: Direct firmware load for maxt=
ouch.cfg failed with error -2
[    0.212986] atmel_mxt_ts i2c-ATML0000:01: Touchscreen size X960Y540
[    0.213025] input: Atmel maXTouch Touchpad as /devices/pci0000:00/INT34=
32:00/i2c-0/i2c-ATML0000:01/input/input4
[    0.219208] atmel_mxt_ts i2c-ATML0001:01: Family: 164 Variant: 13 Firmw=
are V1.0.AA Objects: 41
[    0.238825] atmel_mxt_ts i2c-ATML0001:01: Direct firmware load for maxt=
ouch.cfg failed with error -2
[    0.238949] intel_rapl_common: Found RAPL domain package
[    0.238955] intel_rapl_common: Found RAPL domain core
[    0.238961] intel_rapl_common: Found RAPL domain uncore
[    0.238966] intel_rapl_common: Found RAPL domain dram
[    0.240121] atmel_mxt_ts i2c-ATML0001:01: Touchscreen size X2559Y1699
[    0.240157] input: Atmel maXTouch Touchscreen as /devices/pci0000:00/IN=
T3433:00/i2c-1/i2c-ATML0001:01/input/input5
[    0.248589] Initializing XFRM netlink socket
[    0.248657] NET: Registered protocol family 10
[    0.248809] Segment Routing with IPv6
[    0.248860] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.248957] NET: Registered protocol family 17
[    0.275200] microcode: sig=3D0x306d4, pf=3D0x40, revision=3D0x2f
[    0.275211] microcode: Microcode Update Driver: v2.2.
[    0.275214] IPI shorthand broadcast: enabled
[    0.275233] sched_clock: Marking stable (274499311, 575599)->(279521979=
, -4447069)
[    0.275279] registered taskstats version 1
[    0.275284] Loading compiled-in X.509 certificates
[    0.275410] Btrfs loaded, crc32c=3Dcrc32c-generic
[    0.275508] ALSA device list:
[    0.275513]   No soundcards found.
[    0.376220] fbcon: i915drmfb (fb0) is primary device
[    0.501840] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.502202] ata1.00: ATA-10: KINGSTON RBU-SUS151S332GD, S9FM02.3, max U=
DMA/133
[    0.502204] ata1.00: 62533296 sectors, multi 16: LBA48 NCQ (depth 32), =
AA
[    0.502572] ata1.00: configured for UDMA/133
[    0.515085] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    0.656068] usb 1-1: New USB device found, idVendor=3D0bda, idProduct=
=3D8152, bcdDevice=3D20.00
[    0.656070] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D3
[    0.656072] usb 1-1: Product: USB 10/100 LAN
[    0.656073] usb 1-1: Manufacturer: Realtek
[    0.656074] usb 1-1: SerialNumber: 00E04C1209BB
[    0.778617] usb 1-7: new high-speed USB device number 3 using xhci_hcd
[    0.928559] usb 1-7: New USB device found, idVendor=3D2232, idProduct=
=3D6001, bcdDevice=3D 0.02
[    0.928561] usb 1-7: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D0
[    0.928562] usb 1-7: Product: NCM-G102
[    0.928563] usb 1-7: Manufacturer: NMGAAI00010200254L00639
[    1.042219] usb 1-1: reset high-speed USB device number 2 using xhci_hc=
d
[    1.168660] tsc: Refined TSC clocksource calibration: 2194.900 MHz
[    1.168671] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1f=
a361254b6, max_idle_ns: 440795315371 ns
[    1.168697] clocksource: Switched to clocksource tsc
[    1.209791] r8152 1-1:1.0: skip request firmware
[    1.236131] r8152 1-1:1.0 eth0: v1.11.11
[    1.305115] usb 1-8: new full-speed USB device number 4 using xhci_hcd
[    1.446675] usb 1-8: New USB device found, idVendor=3D8087, idProduct=
=3D07dc, bcdDevice=3D 0.01
[    1.446680] usb 1-8: New USB device strings: Mfr=3D0, Product=3D0, Seri=
alNumber=3D0
[    1.599398] Console: switching to colour frame buffer device 320x106
[    1.703738] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    1.705578] scsi 0:0:0:0: Direct-Access     ATA      KINGSTON RBU-SUS 0=
2.3 PQ: 0 ANSI: 5
[    1.707751] sd 0:0:0:0: [sda] 62533296 512-byte logical blocks: (32.0 G=
B/29.8 GiB)
[    1.709562] sd 0:0:0:0: [sda] Write Protect is off
[    1.711391] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.711411] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA
[    1.713814]  sda: sda1 sda2
[    1.715959] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.719869] EXT4-fs (sda2): mounted filesystem with ordered data mode. =
Opts: (null)
[    1.721883] VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
[    1.724651] devtmpfs: mounted
[    1.726882] Freeing unused kernel image (initmem) memory: 916K
[    1.728764] Write protecting the kernel read-only data: 18432k
[    1.730883] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.732883] Freeing unused kernel image (rodata/data gap) memory: 768K
[    1.734762] Run /sbin/init as init process
[    1.736634]   with arguments:
[    1.736635]     /sbin/init
[    1.736636]   with environment:
[    1.736636]     HOME=3D/
[    1.736637]     TERM=3Dlinux
[    2.275005] udevd[464]: starting version 3.2.9
[    2.276581] random: udevd: uninitialized urandom read (16 bytes read)
[    2.276864] random: udevd: uninitialized urandom read (16 bytes read)
[    2.276876] random: udevd: uninitialized urandom read (16 bytes read)
[    2.282595] udevd[464]: starting eudev-3.2.9
[    2.902354] EXT4-fs (sda2): re-mounted. Opts: (null)
[    3.215512] elogind-daemon[1227]: New seat seat0.
[    3.216057] elogind-daemon[1227]: Watching system buttons on /dev/input=
/event2 (Power Button)
[    3.216111] elogind-daemon[1227]: Watching system buttons on /dev/input=
/event1 (Power Button)
[    3.216199] elogind-daemon[1227]: Watching system buttons on /dev/input=
/event0 (Lid Switch)
[    3.216259] elogind-daemon[1227]: Watching system buttons on /dev/input=
/event3 (AT Translated Set 2 keyboard)
[    3.336771] r8152 1-1:1.0 eth0: carrier on
[   10.358682] random: crng init done
[   10.358688] random: 7 urandom warning(s) missed due to ratelimiting
[   13.272451] elogind-daemon[1227]: New session c1 of user andre.

--------------10A0FECCE13E1E1118BE4ECD--
