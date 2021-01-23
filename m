Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6129E3014D8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 12:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbhAWLIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 06:08:50 -0500
Received: from audible.transient.net ([24.143.126.66]:37092 "HELO
        audible.transient.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726379AbhAWLIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 06:08:46 -0500
Received: (qmail 9227 invoked from network); 23 Jan 2021 11:08:02 -0000
Received: from cucamonga.audible.transient.net (192.168.2.5)
  by canarsie.audible.transient.net with QMQP; 23 Jan 2021 11:08:02 -0000
Received: (nullmailer pid 3192 invoked by uid 1000);
        Sat, 23 Jan 2021 11:08:02 -0000
Date:   Sat, 23 Jan 2021 11:08:02 +0000
From:   Jamie Heilman <jamie@audible.transient.net>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: bisected regression in v5.11-rc1 snd-usb-audio
Message-ID: <YAwDkhRVkrEna8pV@audible.transient.net>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
        linux-kernel@vger.kernel.org
References: <YAqIJHzE3UG51G/U@audible.transient.net>
 <s5hzh118ioz.wl-tiwai@suse.de>
 <YAqjBLt3eLG5GY/4@audible.transient.net>
 <s5him7p89oe.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pqQlAcXbYQGFe/DY"
Content-Disposition: inline
In-Reply-To: <s5him7p89oe.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pqQlAcXbYQGFe/DY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Takashi Iwai wrote:
> On Fri, 22 Jan 2021 11:03:48 +0100,
> Jamie Heilman wrote:
> > 
> > Takashi Iwai wrote:
> > > You seem hitting a firmware bug, and it doesn't look like the only
> > > case.  Interestingly, the backport of 5.11 USB-audio stuff on 5.3
> > > kernel on openSUSE Leap 15.2 caused a similar bug on Steinberg device,
> > > while it worked with 5.11-rc.  So I thought this specific with the
> > > older kernel (in USB core changes or such), but my guess seems wrong,
> > > and the bug looks remaining in 5.11 for some cases.
> > > 
> > > Below is the fix patch.  Please give it a try.
> > > 
> > > 
> > > thanks,
> > > 
> > > Takashi
> > > 
> > > -- 8< --
> > > From: Takashi Iwai <tiwai@suse.de>
> > > Subject: [PATCH] ALSA: usb-audio: workaround for iface reset issue
> > > 
> > > The recently introduced sample rate validation code seems causing a
> > > problem on some devices; namely, after performing this, the bus gets
> > > screwed and it influences even on other USB devices.
> > > As a quick workaround, perform it only for the necessary devices;
> > > currently MOTU devices are known to need the valid altset checks, so
> > > filter out other devices.
> > > 
> > > Fixes: 93db51d06b32 ("ALSA: usb-audio: Check valid altsetting at parsing rates for UAC2/3")
> > > Reported-by: Jamie Heilman <jamie@audible.transient.net>
> > > BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1178203
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > >  sound/usb/format.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/sound/usb/format.c b/sound/usb/format.c
> > > index 9ebc5d202c87..e6ff317a6785 100644
> > > --- a/sound/usb/format.c
> > > +++ b/sound/usb/format.c
> > > @@ -466,6 +466,17 @@ static int validate_sample_rate_table_v2v3(struct snd_usb_audio *chip,
> > >  	unsigned int nr_rates;
> > >  	int i, err;
> > >  
> > > +	/* performing the rate verification may lead to unexpected USB bus
> > > +	 * behavior afterwards by some unknown reason.  Do this only for the
> > > +	 * known devices.
> > > +	 */
> > > +	switch (USB_ID_VENDOR(chip->usb_id)) {
> > > +	case 0x07fd: /* MOTU */
> > > +		break;
> > > +	default:
> > > +		return 0; /* don't perform the validation as default */
> > > +	}
> > > +
> > >  	table = kcalloc(fp->nr_rates, sizeof(*table), GFP_KERNEL);
> > >  	if (!table)
> > >  		return -ENOMEM;
> > 
> > Well, with this patch, while I can get it to seemingly initialize
> > without errors by replugging, I can't actually get it to work.  Jack
> > says:
> > 
> > Starting jack server...
> > JACK server starting in realtime mode with priority 10
> > self-connect-mode is "Don't restrict self connect requests"
> > Acquired audio card Audio1
> > creating alsa driver ... hw:CARD=hiFace2,DEV=0|-|1024|3|96000|0|0|nomon|swmeter|-|32bit
> > ERROR: ALSA: Cannot open PCM device alsa_pcm for playback. Falling back to capture-only mode
> > Released audio card Audio1
> > ERROR: Cannot initialize driver
> > ERROR: JackServer::Open failed with -1
> > ERROR: Failed to open server
> 
> Which kernel did you test?  There have been a few more USB-audio fixes
> that landed to Linus tree yesterday, so you'd need to test with it (in
> addition to the previous patch).

Sorry, thought that'd be clear from the alsa-info output, but yes, the
tip of Linus's tree at the time: 5.11.0-rc4-00164-g83d09ad4b950

> > here's what aplay does when it tries:
> > 
> > aplay: main:830: audio open error: Invalid argument
> > 
> > strace of that says:
> > openat(AT_FDCWD, "/dev/snd/pcmC1D0p", O_RDWR|O_NONBLOCK|O_CLOEXEC) = -1 EINVAL (Invalid argument)
> 
> Hm, it's weird that open returns -EINVAL, not the later ioctl...
> 
> > I dug up a different USB sound device (bithead) and plugged it in, it
> > still works just fine with the same commands.
> > 
> > The only difference I see in the alsa-info output is that
> > 
> >         control.7 {
> >                 iface CARD
> >                 name 'Keep Interface'
> >                 value false
> >                 comment {
> >                         access 'read write'
> >                         type BOOLEAN
> >                         count 1
> >                 }
> >         }
> > 
> > has gone missing.
> 
> This is an intended change and should be irrelevant.

Groovy.

> If the problem is still seen with the very latest Linus tree and the
> previous patch, please enable the dyndbg, e.g. pass dydbg=+p option to
> snd-usb-audio module, i.e. reload like
>    modprobe snd-usb-audio dydbg=+p
> or boot with
>    snd_usb_audio.dyndbg=+p
> boot option, retest, and give the kernel messages.

OK, updated to 5.11.0-rc4-00202-gfe75a21824e7, repatched & rebuilt with:
CONFIG_SND_DEBUG=y
CONFIG_SND_CTL_VALIDATION=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y

and added dyndbg=+p to my snd-usb-audio options, dmesg after an
attempted aplay execution is attached.  For grins I built a 5.10.9
kernel with the same config to compare ... the difference between
5.10.9 and 5.11.0-rc4-00202-gfe75a21824e7 debug output is basically:


+usb 1-1.1.2: 1:1: found sync_ep=0x81, iface=1, alt=1, implicit_fb=0
 usb 1-1.1.2: 1:1: add audio endpoint 0x1
+usb 1-1.1.2: Creating new data endpoint #1
+usb 1-1.1.2: Creating new sync endpoint #81
+usb 1-1.1.2: 1:1 Set sample rate 192000, clock 40
 usb 1-1.1.2: [10] FU [M2Tech Audio 2.0 Output Playback Switch] ch = 2, val = 0/1/1
 usb 1-1.1.2: [10] FU [M2Tech Audio 2.0 Output Playback Switch] ch = 1, val = 0/1/1
 usb 1-1.1.2: RANGE setting not yet supported
 usb 1-1.1.2: [10] FU [M2Tech Audio 2.0 Output Playback Volume] ch = 2, val = -32512/0/256
 usb 1-1.1.2: RANGE setting not yet supported
 usb 1-1.1.2: [10] FU [M2Tech Audio 2.0 Output Playback Volume] ch = 1, val = -32512/0/256

...and then on 5.10.9 once I start up jackd ...

-usb 1-1.1.2: setting usb interface 1:1
-usb 1-1.1.2: Creating new playback data endpoint #1
-usb 1-1.1.2: Creating new capture sync endpoint #81
-usb 1-1.1.2: Setting params for ep #1 (type 0, 12 urbs), ret=0
-usb 1-1.1.2: Setting params for ep #81 (type 1, 4 urbs), ret=0
-usb 1-1.1.2: Starting data EP @00000000d63f36f3
-usb 1-1.1.2: Starting sync EP @00000000e9f3024b

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/

--pqQlAcXbYQGFe/DY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="v5.11.0-rc4-00202-gfe75a21824e7-dirty-dmesg.txt"

[    0.000000] Linux version 5.11.0-rc4-00202-gfe75a21824e7-dirty (jamie@cucamonga) (gcc (Debian 10.2.1-3) 10.2.1 20201224, GNU ld (GNU Binutils for Debian) 2.35.1) #1 SMP PREEMPT Sat Jan 23 07:06:19 UTC 2021
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc4-00202-gfe75a21824e7-dirty root=/dev/mapper/S-root ro rng-core.default_quality=512
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Enabled xstate features 0x3, context size is 576 bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ebff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bfe01bff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bfe01c00-0x00000000bfe53bff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bfe53c00-0x00000000bfe55bff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bfe55c00-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fed003ff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed9ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000feefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffb00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023bffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.5 present.
[    0.000000] DMI: Dell Inc. Precision WorkStation T3400  /0TP412, BIOS A14 04/30/2012
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2992.276 MHz processor
[    0.000780] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000783] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000788] last_pfn = 0x23c000 max_arch_pfn = 0x400000000
[    0.000792] MTRR default type: uncachable
[    0.000794] MTRR fixed ranges enabled:
[    0.000796]   00000-9FFFF write-back
[    0.000797]   A0000-BFFFF uncachable
[    0.000799]   C0000-D3FFF write-protect
[    0.000800]   D4000-EFFFF uncachable
[    0.000801]   F0000-FFFFF write-protect
[    0.000803] MTRR variable ranges enabled:
[    0.000804]   0 base 000000000 mask 000000000 write-back
[    0.000806]   1 base 0BFF00000 mask FFFF00000 uncachable
[    0.000808]   2 base 0C0000000 mask FC0000000 uncachable
[    0.000810]   3 disabled
[    0.000810]   4 disabled
[    0.000811]   5 disabled
[    0.000812]   6 disabled
[    0.002183] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.002741] e820: update [mem 0xbff00000-0xffffffff] usable ==> reserved
[    0.002750] last_pfn = 0xbfe01 max_arch_pfn = 0x400000000
[    0.002766] check: Scanning 1 areas for low memory corruption
[    0.003200] RAMDISK: [mem 0x3718b000-0x378bcfff]
[    0.003208] ACPI: Early table checksum verification disabled
[    0.003212] ACPI: RSDP 0x00000000000FEBF0 000024 (v02 DELL  )
[    0.003217] ACPI: XSDT 0x00000000000FCEAA 000084 (v01 DELL   B9K      00000015 ASL  00000061)
[    0.003224] ACPI: FACP 0x00000000000FCFD2 0000F4 (v03 DELL   B9K      00000015 ASL  00000061)
[    0.003229] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe0Block: 128/64 (20201113/tbfadt-564)
[    0.003341] ACPI: DSDT 0x00000000FFF5D83F 003794 (v01 DELL   dt_ex    00001000 INTL 20050624)
[    0.003349] ACPI: FACS 0x00000000BFE01C00 000040
[    0.003352] ACPI: FACS 0x00000000BFE01C00 000040
[    0.003418] ACPI: SSDT 0x00000000FFF610F4 0000AC (v01 DELL   st_ex    00001000 INTL 20050624)
[    0.003422] ACPI: APIC 0x00000000000FD0C6 000092 (v01 DELL   B9K      00000015 ASL  00000061)
[    0.003426] ACPI: BOOT 0x00000000000FD158 000028 (v01 DELL   B9K      00000015 ASL  00000061)
[    0.003430] ACPI: ASF! 0x00000000000FD180 000096 (v32 DELL   B9K      00000015 ASL  00000061)
[    0.003434] ACPI: MCFG 0x00000000000FD216 00003E (v01 DELL   B9K      00000015 ASL  00000061)
[    0.003438] ACPI: HPET 0x00000000000FD254 000038 (v01 DELL   B9K      00000015 ASL  00000061)
[    0.003442] ACPI: TCPA 0x00000000000FD4B0 000032 (v01 DELL   B9K      00000015 ASL  00000061)
[    0.003446] ACPI: SLIC 0x00000000000FD28C 000176 (v01 DELL   B9K      00000015 ASL  00000061)
[    0.003450] ACPI: SSDT 0x00000000BFE01C40 0001F9 (v01 DpgPmm Cpu0Ist  00000011 INTL 20050624)
[    0.003454] ACPI: SSDT 0x00000000BFE02049 0001F9 (v01 DpgPmm Cpu1Ist  00000011 INTL 20050624)
[    0.003458] ACPI: SSDT 0x00000000BFE02452 000140 (v01 DpgPmm CpuPm    00000010 INTL 20050624)
[    0.003729] ACPI: Local APIC address 0xfee00000
[    0.003749] Zone ranges:
[    0.003750]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.003753]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.003755]   Normal   [mem 0x0000000100000000-0x000000023bffffff]
[    0.003757] Movable zone start for each node
[    0.003758] Early memory node ranges
[    0.003758]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.003760]   node   0: [mem 0x0000000000100000-0x00000000bfe00fff]
[    0.003762]   node   0: [mem 0x0000000100000000-0x000000023bffffff]
[    0.003973] Zeroed struct page in unavailable ranges: 16994 pages
[    0.003974] Initmem setup node 0 [mem 0x0000000000001000-0x000000023bffffff]
[    0.003976] On node 0 totalpages: 2080158
[    0.003978]   DMA zone: 64 pages used for memmap
[    0.003979]   DMA zone: 21 pages reserved
[    0.003980]   DMA zone: 3997 pages, LIFO batch:0
[    0.004026]   DMA32 zone: 12217 pages used for memmap
[    0.004028]   DMA32 zone: 781825 pages, LIFO batch:63
[    0.021226]   Normal zone: 20224 pages used for memmap
[    0.021229]   Normal zone: 1294336 pages, LIFO batch:63
[    0.051487] ACPI: PM-Timer IO Port: 0x808
[    0.051491] ACPI: Local APIC address 0xfee00000
[    0.051498] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
[    0.051510] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.051513] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.051515] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.051518] ACPI: IRQ0 used by override.
[    0.051519] ACPI: IRQ9 used by override.
[    0.051521] Using ACPI (MADT) for SMP configuration information
[    0.051522] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.051529] smpboot: 8 Processors exceeds NR_CPUS limit of 2
[    0.051530] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.051544] [mem 0xc0000000-0xdfffffff] available for PCI devices
[    0.051549] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.056412] setup_percpu: NR_CPUS:2 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.056993] percpu: Embedded 44 pages/cpu s139416 r8192 d32616 u1048576
[    0.056998] pcpu-alloc: s139416 r8192 d32616 u1048576 alloc=1*2097152
[    0.057001] pcpu-alloc: [0] 0 1 
[    0.057019] Built 1 zonelists, mobility grouping on.  Total pages: 2047632
[    0.057022] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc4-00202-gfe75a21824e7-dirty root=/dev/mapper/S-root ro rng-core.default_quality=512
[    0.058938] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.059966] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.060011] mem auto-init: stack:byref_all(zero), heap alloc:on, heap free:on
[    0.060014] mem auto-init: clearing system memory may take some time...
[    3.174905] Memory: 8080664K/8320632K available (10242K kernel code, 1025K rwdata, 2444K rodata, 876K init, 1408K bss, 239712K reserved, 0K cma-reserved)
[    3.174951] random: get_random_u64 called from cache_random_seq_create+0x95/0x180 with crng_init=0
[    3.175024] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    3.175032] random: get_random_u32 called from allocate_slab+0x13b/0x3c0 with crng_init=0
[    3.175042] Kernel/User page tables isolation: enabled
[    3.175101] rcu: Preemptible hierarchical RCU implementation.
[    3.175104] 	Trampoline variant of Tasks RCU enabled.
[    3.175105] 	Tracing variant of Tasks RCU enabled.
[    3.175106] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    3.175116] NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
[    3.175325] random: get_random_bytes called from start_kernel+0x38a/0x521 with crng_init=0
[    3.177504] Console: colour VGA+ 80x25
[    3.182146] printk: console [tty0] enabled
[    3.182202] ACPI: Core revision 20201113
[    3.242227] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    3.242302] APIC: Switch to symmetric I/O mode setup
[    3.242706] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    3.247301] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2b21c4e23d0, max_idle_ns: 440795283298 ns
[    3.247370] Calibrating delay loop (skipped), value calculated using timer frequency.. 5984.55 BogoMIPS (lpj=2992276)
[    3.247435] pid_max: default: 32768 minimum: 301
[    3.247509] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    3.247564] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    3.247833] mce: CPU0: Thermal monitoring enabled (TM2)
[    3.247886] process: using mwait in idle threads
[    3.247939] Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
[    3.247990] Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32, 1GB 0
[    3.248044] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    3.248107] Spectre V2 : Mitigation: Full generic retpoline
[    3.248158] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    3.248211] Speculative Store Bypass: Vulnerable
[    3.248264] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    3.248446] Freeing SMP alternatives memory: 24K
[    3.350876] smpboot: CPU0: Intel(R) Core(TM)2 Duo CPU     E8400  @ 3.00GHz (family: 0x6, model: 0x17, stepping: 0xa)
[    3.351046] Performance Events: PEBS fmt0+, Core2 events, 4-deep LBR, Intel PMU driver.
[    3.351108] ... version:                2
[    3.351158] ... bit width:              40
[    3.351208] ... generic registers:      2
[    3.351257] ... value mask:             000000ffffffffff
[    3.351308] ... max period:             000000007fffffff
[    3.351358] ... fixed-purpose events:   3
[    3.351366] ... event mask:             0000000700000003
[    3.351366] rcu: Hierarchical SRCU implementation.
[    3.351366] smp: Bringing up secondary CPUs ...
[    3.351366] x86: Booting SMP configuration:
[    3.351368] .... node  #0, CPUs:      #1
[    3.352396] smp: Brought up 1 node, 2 CPUs
[    3.353424] smpboot: Max logical packages: 4
[    3.353475] smpboot: Total of 2 processors activated (11969.10 BogoMIPS)
[    3.354571] devtmpfs: initialized
[    3.355412] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    3.355481] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    3.355623] NET: Registered protocol family 16
[    3.355838] thermal_sys: Registered thermal governor 'step_wise'
[    3.355900] cpuidle: using governor teo
[    3.356017] Simple Boot Flag at 0x7a set to 0x1
[    3.356075] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    3.356129] ACPI: bus type PCI registered
[    3.356222] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    3.356288] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    3.356346] pmd_set_huge: Cannot satisfy [mem 0xe0000000-0xe0200000] with a huge-page mapping due to MTRR override.
[    3.356530] PCI: Using configuration type 1 for base access
[    3.708450] ACPI: Added _OSI(Module Device)
[    3.708495] ACPI: Added _OSI(Processor Device)
[    3.708545] ACPI: Added _OSI(3.0 _SCP Extensions)
[    3.708595] ACPI: Added _OSI(Processor Aggregator Device)
[    3.708646] ACPI: Added _OSI(Linux-Dell-Video)
[    3.708697] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    3.708748] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    3.752402] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    3.760559] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    3.793700] ACPI: Interpreter enabled
[    3.793753] ACPI: (supports S0 S5)
[    3.793801] ACPI: Using IOAPIC for interrupt routing
[    3.793960] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    3.794472] ACPI: Enabled 12 GPEs in block 00 to 3F
[    3.950312] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    3.950372] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    3.959724] PCI host bridge to bus 0000:00
[    3.959774] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    3.959826] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    3.959878] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    3.959931] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000effff window]
[    3.959983] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fffff window]
[    3.960368] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfec00000 window]
[    3.960421] pci_bus 0000:00: root bus resource [mem 0xbff00000-0xdfffffff window]
[    3.960473] pci_bus 0000:00: root bus resource [mem 0xff980800-0xff980bff window]
[    3.960525] pci_bus 0000:00: root bus resource [mem 0xff97c000-0xff97ffff window]
[    3.960577] pci_bus 0000:00: root bus resource [mem 0xfed20000-0xfed9ffff window]
[    3.960629] pci_bus 0000:00: root bus resource [bus 00-ff]
[    3.960691] pci 0000:00:00.0: [8086:29e0] type 00 class 0x060000
[    3.961371] pci 0000:00:01.0: [8086:29e1] type 01 class 0x060400
[    3.961371] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    3.961393] pci 0000:00:06.0: [8086:29e9] type 01 class 0x060400
[    3.961393] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    3.962369] pci 0000:00:1a.0: [8086:2937] type 00 class 0x0c0300
[    3.962369] pci 0000:00:1a.0: reg 0x20: [io  0xff20-0xff3f]
[    3.962393] pci 0000:00:1a.1: [8086:2938] type 00 class 0x0c0300
[    3.962393] pci 0000:00:1a.1: reg 0x20: [io  0xff00-0xff1f]
[    3.963370] pci 0000:00:1a.2: [8086:2939] type 00 class 0x0c0300
[    3.963370] pci 0000:00:1a.2: reg 0x20: [io  0xecc0-0xecdf]
[    3.963393] pci 0000:00:1a.7: [8086:293c] type 00 class 0x0c0320
[    3.963393] pci 0000:00:1a.7: reg 0x10: [mem 0xfdffbc00-0xfdffbfff]
[    3.963393] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    3.964367] pci 0000:00:1b.0: [8086:293e] type 00 class 0x040300
[    3.964367] pci 0000:00:1b.0: reg 0x10: [mem 0xfdffc000-0xfdffffff 64bit]
[    3.964367] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    3.964393] pci 0000:00:1c.0: [8086:2940] type 01 class 0x060400
[    3.964423] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    3.965375] pci 0000:00:1c.5: [8086:294a] type 01 class 0x060400
[    3.965375] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    3.965392] pci 0000:00:1d.0: [8086:2934] type 00 class 0x0c0300
[    3.965400] pci 0000:00:1d.0: reg 0x20: [io  0xff80-0xff9f]
[    3.966368] pci 0000:00:1d.1: [8086:2935] type 00 class 0x0c0300
[    3.966368] pci 0000:00:1d.1: reg 0x20: [io  0xff60-0xff7f]
[    3.966392] pci 0000:00:1d.2: [8086:2936] type 00 class 0x0c0300
[    3.966399] pci 0000:00:1d.2: reg 0x20: [io  0xff40-0xff5f]
[    3.967369] pci 0000:00:1d.7: [8086:293a] type 00 class 0x0c0320
[    3.967369] pci 0000:00:1d.7: reg 0x10: [mem 0xff980800-0xff980bff]
[    3.967369] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    3.967417] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    3.968373] pci 0000:00:1f.0: [8086:2916] type 00 class 0x060100
[    3.968373] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by ICH6 ACPI/GPIO/TCO
[    3.968373] pci 0000:00:1f.0: quirk: [io  0x0880-0x08bf] claimed by ICH6 GPIO
[    3.968373] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0c00 (mask 007f)
[    3.968373] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 00e0 (mask 0007)
[    3.969369] pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601
[    3.969369] pci 0000:00:1f.2: reg 0x10: [io  0xfe00-0xfe07]
[    3.969369] pci 0000:00:1f.2: reg 0x14: [io  0xfe10-0xfe13]
[    3.969369] pci 0000:00:1f.2: reg 0x18: [io  0xfe20-0xfe27]
[    3.969369] pci 0000:00:1f.2: reg 0x1c: [io  0xfe30-0xfe33]
[    3.969369] pci 0000:00:1f.2: reg 0x20: [io  0xfec0-0xfedf]
[    3.969369] pci 0000:00:1f.2: reg 0x24: [mem 0xff970000-0xff9707ff]
[    3.969369] pci 0000:00:1f.2: PME# supported from D3hot
[    3.969392] pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500
[    3.969392] pci 0000:00:1f.3: reg 0x10: [mem 0xfdffbb00-0xfdffbbff 64bit]
[    3.969446] pci 0000:00:1f.3: reg 0x20: [io  0xece0-0xecff]
[    3.970389] pci 0000:01:00.0: [10de:042f] type 00 class 0x030000
[    3.970389] pci 0000:01:00.0: reg 0x10: [mem 0xfc000000-0xfcffffff]
[    3.970389] pci 0000:01:00.0: reg 0x14: [mem 0xd0000000-0xdfffffff 64bit pref]
[    3.970389] pci 0000:01:00.0: reg 0x1c: [mem 0xfa000000-0xfbffffff 64bit]
[    3.970389] pci 0000:01:00.0: reg 0x24: [io  0xdc80-0xdcff]
[    3.970389] pci 0000:01:00.0: reg 0x30: [mem 0xfde00000-0xfde1ffff pref]
[    3.970418] pci 0000:00:01.0: PCI bridge to [bus 01]
[    3.970418] pci 0000:00:01.0:   bridge window [io  0xd000-0xdfff]
[    3.970420] pci 0000:00:01.0:   bridge window [mem 0xfa000000-0xfdefffff]
[    3.970473] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    3.971371] pci 0000:00:06.0: PCI bridge to [bus 02]
[    3.971392] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    3.971392] pci 0000:00:1c.0:   bridge window [mem 0xf9f00000-0xf9ffffff]
[    3.971392] pci 0000:04:00.0: [14e4:167a] type 00 class 0x020000
[    3.971392] pci 0000:04:00.0: reg 0x10: [mem 0xf9ef0000-0xf9efffff 64bit]
[    3.971392] pci 0000:04:00.0: PME# supported from D3hot D3cold
[    3.971392] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    3.971392] pci 0000:00:1c.5:   bridge window [mem 0xf9e00000-0xf9efffff]
[    3.971392] pci_bus 0000:05: extended config space not accessible
[    3.971392] pci 0000:00:1e.0: PCI bridge to [bus 05] (subtractive decode)
[    3.971448] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    3.971509] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    3.971570] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    3.971632] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000effff window] (subtractive decode)
[    3.971693] pci 0000:00:1e.0:   bridge window [mem 0x000f0000-0x000fffff window] (subtractive decode)
[    3.971755] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xfec00000 window] (subtractive decode)
[    3.971816] pci 0000:00:1e.0:   bridge window [mem 0xbff00000-0xdfffffff window] (subtractive decode)
[    3.971878] pci 0000:00:1e.0:   bridge window [mem 0xff980800-0xff980bff window] (subtractive decode)
[    3.971939] pci 0000:00:1e.0:   bridge window [mem 0xff97c000-0xff97ffff window] (subtractive decode)
[    3.972001] pci 0000:00:1e.0:   bridge window [mem 0xfed20000-0xfed9ffff window] (subtractive decode)
[    3.972076] pci_bus 0000:00: on NUMA node 0
[    4.002773] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
[    4.003718] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
[    4.004656] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 9 10 11 12 15)
[    4.005621] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
[    4.006565] ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 9 10 11 12 15)
[    4.007529] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
[    4.008469] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 15)
[    4.009413] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 15)
[    4.010508] iommu: Default domain type: Translated 
[    4.010573] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    4.010573] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    4.010573] pci 0000:01:00.0: vgaarb: bridge control possible
[    4.010573] vgaarb: loaded
[    4.010663] SCSI subsystem initialized
[    4.010725] libata version 3.00 loaded.
[    4.010747] ACPI: bus type USB registered
[    4.011389] usbcore: registered new interface driver usbfs
[    4.011448] usbcore: registered new interface driver hub
[    4.011506] usbcore: registered new device driver usb
[    4.011582] EDAC MC: Ver: 3.0.0
[    4.011738] PCI: Using ACPI for IRQ routing
[    4.015821] PCI: pci_cache_line_size set to 64 bytes
[    4.015841] pci 0000:00:1f.2: can't claim BAR 5 [mem 0xff970000-0xff9707ff]: no compatible bridge window
[    4.015921] Expanded resource Reserved due to conflict with PCI Bus 0000:00
[    4.015973] Expanded resource Reserved due to conflict with PCI Bus 0000:00
[    4.016024] e820: reserve RAM buffer [mem 0x0009ec00-0x0009ffff]
[    4.016026] e820: reserve RAM buffer [mem 0xbfe01c00-0xbfffffff]
[    4.016474] hpet: 4 channels of 0 reserved for per-cpu timers
[    4.016526] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    4.016580] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    4.018383] clocksource: Switched to clocksource tsc-early
[    4.018498] pnp: PnP ACPI init
[    4.021771] pnp 00:00: disabling [io  0x0800-0x085f] because it overlaps 0000:00:1f.0 BAR 7 [io  0x0800-0x087f]
[    4.021836] pnp 00:00: disabling [io  0x0860-0x08ff] because it overlaps 0000:00:1f.0 BAR 7 [io  0x0800-0x087f]
[    4.021919] system 00:00: [io  0x0c00-0x0c7f] has been reserved
[    4.021976] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    4.022203] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    4.028755] pnp 00:02: [dma 2]
[    4.029237] pnp 00:02: Plug and Play ACPI device, IDs PNP0700 (active)
[    4.035109] pnp 00:03: Plug and Play ACPI device, IDs PNP0f13 (active)
[    4.042655] pnp 00:04: [dma 0 disabled]
[    4.043835] pnp 00:04: Plug and Play ACPI device, IDs PNP0401 (active)
[    4.049146] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    4.053989] pnp 00:06: Plug and Play ACPI device, IDs SMO1200 PNP0c31 (active)
[    4.063249] pnp: PnP ACPI: found 7 devices
[    4.069895] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    4.069987] NET: Registered protocol family 2
[    4.070152] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    4.070231] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    4.070452] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    4.070812] TCP: Hash tables configured (established 65536 bind 65536)
[    4.070876] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    4.070961] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    4.071068] NET: Registered protocol family 1
[    4.071129] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 03] add_size 1000
[    4.071184] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 100000
[    4.071250] pci 0000:00:1c.5: bridge window [io  0x1000-0x0fff] to [bus 04] add_size 1000
[    4.071303] pci 0000:00:1c.5: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 04] add_size 200000 add_align 100000
[    4.071379] pci 0000:00:1c.0: BAR 9: assigned [mem 0xf0000000-0xf01fffff 64bit pref]
[    4.071441] pci 0000:00:1c.5: BAR 9: assigned [mem 0xf0200000-0xf03fffff 64bit pref]
[    4.071495] pci 0000:00:1c.0: BAR 7: assigned [io  0x1000-0x1fff]
[    4.071548] pci 0000:00:1c.5: BAR 7: assigned [io  0x2000-0x2fff]
[    4.071601] pci 0000:00:1f.2: BAR 5: assigned [mem 0xf0400000-0xf04007ff]
[    4.071657] pci 0000:00:01.0: PCI bridge to [bus 01]
[    4.071708] pci 0000:00:01.0:   bridge window [io  0xd000-0xdfff]
[    4.071760] pci 0000:00:01.0:   bridge window [mem 0xfa000000-0xfdefffff]
[    4.071812] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    4.071866] pci 0000:00:06.0: PCI bridge to [bus 02]
[    4.071919] pci 0000:00:1c.0: PCI bridge to [bus 03]
[    4.071969] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
[    4.072022] pci 0000:00:1c.0:   bridge window [mem 0xf9f00000-0xf9ffffff]
[    4.072075] pci 0000:00:1c.0:   bridge window [mem 0xf0000000-0xf01fffff 64bit pref]
[    4.072131] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    4.072181] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
[    4.072234] pci 0000:00:1c.5:   bridge window [mem 0xf9e00000-0xf9efffff]
[    4.072287] pci 0000:00:1c.5:   bridge window [mem 0xf0200000-0xf03fffff 64bit pref]
[    4.072342] pci 0000:00:1e.0: PCI bridge to [bus 05]
[    4.072399] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    4.072452] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    4.072503] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    4.072555] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000effff window]
[    4.072607] pci_bus 0000:00: resource 8 [mem 0x000f0000-0x000fffff window]
[    4.072658] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfec00000 window]
[    4.072710] pci_bus 0000:00: resource 10 [mem 0xbff00000-0xdfffffff window]
[    4.072762] pci_bus 0000:00: resource 11 [mem 0xff980800-0xff980bff window]
[    4.072814] pci_bus 0000:00: resource 12 [mem 0xff97c000-0xff97ffff window]
[    4.072865] pci_bus 0000:00: resource 13 [mem 0xfed20000-0xfed9ffff window]
[    4.072917] pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
[    4.072968] pci_bus 0000:01: resource 1 [mem 0xfa000000-0xfdefffff]
[    4.073019] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
[    4.073071] pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
[    4.073122] pci_bus 0000:03: resource 1 [mem 0xf9f00000-0xf9ffffff]
[    4.073860] pci_bus 0000:03: resource 2 [mem 0xf0000000-0xf01fffff 64bit pref]
[    4.073912] pci_bus 0000:04: resource 0 [io  0x2000-0x2fff]
[    4.073962] pci_bus 0000:04: resource 1 [mem 0xf9e00000-0xf9efffff]
[    4.074013] pci_bus 0000:04: resource 2 [mem 0xf0200000-0xf03fffff 64bit pref]
[    4.074066] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7 window]
[    4.074117] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff window]
[    4.074168] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff window]
[    4.074219] pci_bus 0000:05: resource 7 [mem 0x000c0000-0x000effff window]
[    4.074271] pci_bus 0000:05: resource 8 [mem 0x000f0000-0x000fffff window]
[    4.074323] pci_bus 0000:05: resource 9 [mem 0xf0000000-0xfec00000 window]
[    4.074375] pci_bus 0000:05: resource 10 [mem 0xbff00000-0xdfffffff window]
[    4.074427] pci_bus 0000:05: resource 11 [mem 0xff980800-0xff980bff window]
[    4.074479] pci_bus 0000:05: resource 12 [mem 0xff97c000-0xff97ffff window]
[    4.074531] pci_bus 0000:05: resource 13 [mem 0xfed20000-0xfed9ffff window]
[    4.079518] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    4.079575] PCI: CLS 64 bytes, default 64
[    4.079661] Trying to unpack rootfs image as initramfs...
[    4.779686] Freeing initrd memory: 7368K
[    4.779748] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    4.779799] software IO TLB: mapped [mem 0x00000000bbe01000-0x00000000bfe01000] (64MB)
[    4.779976] _warn_unseeded_randomness: 33 callbacks suppressed
[    4.779979] random: get_random_u64 called from copy_process+0x2ac/0x1940 with crng_init=0
[    4.780261] check: Scanning for low memory corruption every 60 seconds
[    4.781125] Initialise system trusted keyrings
[    4.781178] random: get_random_bytes called from key_alloc+0x24d/0x4a0 with crng_init=0
[    4.781260] workingset: timestamp_bits=62 max_order=21 bucket_order=0
[    4.782561] random: get_random_u64 called from cache_random_seq_create+0x95/0x180 with crng_init=0
[    4.782653] Key type asymmetric registered
[    4.782762] Asymmetric key parser 'x509' registered
[    4.782819] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    4.782898] io scheduler mq-deadline registered
[    4.782948] io scheduler kyber registered
[    4.783033] io scheduler bfq registered
[    4.784743] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    4.784799] ACPI: Power Button [VBTN]
[    4.784902] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    4.784955] ACPI: Power Button [PWRF]
[    4.785228] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    4.785335] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    4.785873] Non-volatile memory driver v1.3
[    4.795024] tpm_tis 00:06: 1.2 TPM (device-id 0x4A10, rev-id 78)
[    4.885046] nouveau 0000:01:00.0: vgaarb: deactivate vga console
[    4.885760] Console: switching to colour dummy device 80x25
[    4.886020] nouveau 0000:01:00.0: NVIDIA G86 (086f00a2)
[    4.905104] random: fast init done
[    4.926085] random: crng init done
[    4.926087] random: 5 get_random_xx warning(s) missed due to ratelimiting
[    4.989156] nouveau 0000:01:00.0: bios: version 60.86.6c.00.21
[    5.009988] nouveau 0000:01:00.0: bios: M0203T not found
[    5.009992] nouveau 0000:01:00.0: bios: M0203E not matched!
[    5.009995] nouveau 0000:01:00.0: fb: 256 MiB DDR2
[    5.487079] [TTM] Zone  kernel: Available graphics memory: 4044156 KiB
[    5.487083] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[    5.487098] nouveau 0000:01:00.0: DRM: VRAM: 256 MiB
[    5.487102] nouveau 0000:01:00.0: DRM: GART: 1048576 MiB
[    5.487107] nouveau 0000:01:00.0: DRM: TMDS table version 2.0
[    5.487110] nouveau 0000:01:00.0: DRM: DCB version 4.0
[    5.487114] nouveau 0000:01:00.0: DRM: DCB outp 00: 02011300 00000028
[    5.487118] nouveau 0000:01:00.0: DRM: DCB outp 01: 01011302 00000010
[    5.487121] nouveau 0000:01:00.0: DRM: DCB outp 02: 01000310 00000028
[    5.487124] nouveau 0000:01:00.0: DRM: DCB outp 03: 02000312 00000010
[    5.487127] nouveau 0000:01:00.0: DRM: DCB conn 00: 2030
[    5.487130] nouveau 0000:01:00.0: DRM: DCB conn 01: 1130
[    5.488886] nouveau 0000:01:00.0: DRM: MM: using CRYPT for buffer copies
[    5.530492] nouveau 0000:01:00.0: DRM: allocated 1920x1200 fb: 0x50000, bo 0000000090c945b1
[    5.532415] fbcon: nouveaudrmfb (fb0) is primary device
[    5.651740] Console: switching to colour frame buffer device 240x75
[    5.654897] nouveau 0000:01:00.0: [drm] fb0: nouveaudrmfb frame buffer device
[    5.655082] [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 0
[    5.655161] parport_pc 00:04: reported by Plug and Play ACPI
[    5.655224] parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,EPP,ECP]
[    5.745779] ACPI Warning: SystemIO range 0x0000000000000828-0x000000000000082F conflicts with OpRegion 0x0000000000000828-0x000000000000082D (\GLBC) (20201113/utaddress-204)
[    5.745794] ACPI Warning: SystemIO range 0x0000000000000828-0x000000000000082F conflicts with OpRegion 0x000000000000082A-0x000000000000082A (\SACT) (20201113/utaddress-204)
[    5.745805] ACPI Warning: SystemIO range 0x0000000000000828-0x000000000000082F conflicts with OpRegion 0x0000000000000828-0x0000000000000828 (\SSTS) (20201113/utaddress-204)
[    5.745816] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    5.745845] lpc_ich: Resource conflict(s) found affecting gpio_ich
[    5.745912] ahci 0000:00:1f.2: version 3.0
[    5.746308] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
[    5.746318] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ccc ems 
[    5.761903] scsi host0: ahci
[    5.762016] scsi host1: ahci
[    5.762103] scsi host2: ahci
[    5.762196] scsi host3: ahci
[    5.762287] scsi host4: ahci
[    5.762386] scsi host5: ahci
[    5.762434] ata1: SATA max UDMA/133 abar m2048@0xf0400000 port 0xf0400100 irq 29
[    5.762442] ata2: SATA max UDMA/133 abar m2048@0xf0400000 port 0xf0400180 irq 29
[    5.762448] ata3: SATA max UDMA/133 abar m2048@0xf0400000 port 0xf0400200 irq 29
[    5.762453] ata4: SATA max UDMA/133 abar m2048@0xf0400000 port 0xf0400280 irq 29
[    5.762459] ata5: SATA max UDMA/133 abar m2048@0xf0400000 port 0xf0400300 irq 29
[    5.762465] ata6: SATA max UDMA/133 abar m2048@0xf0400000 port 0xf0400380 irq 29
[    5.762506] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.762515] ehci-pci: EHCI PCI platform driver
[    5.762858] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    5.762868] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    5.762883] ehci-pci 0000:00:1a.7: debug port 1
[    5.766810] ehci-pci 0000:00:1a.7: irq 22, io mem 0xfdffbc00
[    5.773375] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    5.773452] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.11
[    5.773464] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.773473] usb usb1: Product: EHCI Host Controller
[    5.773479] usb usb1: Manufacturer: Linux 5.11.0-rc4-00202-gfe75a21824e7-dirty ehci_hcd
[    5.773490] usb usb1: SerialNumber: 0000:00:1a.7
[    5.773590] hub 1-0:1.0: USB hub found
[    5.773601] hub 1-0:1.0: 6 ports detected
[    5.774059] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    5.774070] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    5.774083] ehci-pci 0000:00:1d.7: debug port 1
[    5.777977] ehci-pci 0000:00:1d.7: irq 23, io mem 0xff980800
[    5.784375] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    5.784423] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.11
[    5.784435] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.784443] usb usb2: Product: EHCI Host Controller
[    5.784450] usb usb2: Manufacturer: Linux 5.11.0-rc4-00202-gfe75a21824e7-dirty ehci_hcd
[    5.784458] usb usb2: SerialNumber: 0000:00:1d.7
[    5.784556] hub 2-0:1.0: USB hub found
[    5.784565] hub 2-0:1.0: 6 ports detected
[    5.784951] uhci_hcd: USB Universal Host Controller Interface driver
[    5.785506] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    5.785750] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    5.786032] uhci_hcd 0000:00:1a.0: detected 2 ports
[    5.786595] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000ff20
[    5.787150] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.11
[    5.787654] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.788194] usb usb3: Product: UHCI Host Controller
[    5.788749] usb usb3: Manufacturer: Linux 5.11.0-rc4-00202-gfe75a21824e7-dirty uhci_hcd
[    5.789307] usb usb3: SerialNumber: 0000:00:1a.0
[    5.789940] hub 3-0:1.0: USB hub found
[    5.790435] hub 3-0:1.0: 2 ports detected
[    5.791369] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    5.791614] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    5.792117] uhci_hcd 0000:00:1a.1: detected 2 ports
[    5.792699] uhci_hcd 0000:00:1a.1: irq 17, io base 0x0000ff00
[    5.793284] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.11
[    5.793832] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.794422] usb usb4: Product: UHCI Host Controller
[    5.795013] usb usb4: Manufacturer: Linux 5.11.0-rc4-00202-gfe75a21824e7-dirty uhci_hcd
[    5.795620] usb usb4: SerialNumber: 0000:00:1a.1
[    5.796301] hub 4-0:1.0: USB hub found
[    5.796846] hub 4-0:1.0: 2 ports detected
[    5.797829] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    5.798078] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    5.798655] uhci_hcd 0000:00:1a.2: detected 2 ports
[    5.799260] uhci_hcd 0000:00:1a.2: irq 22, io base 0x0000ecc0
[    5.799875] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.11
[    5.800444] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.801028] usb usb5: Product: UHCI Host Controller
[    5.801595] usb usb5: Manufacturer: Linux 5.11.0-rc4-00202-gfe75a21824e7-dirty uhci_hcd
[    5.802174] usb usb5: SerialNumber: 0000:00:1a.2
[    5.802834] hub 5-0:1.0: USB hub found
[    5.803337] hub 5-0:1.0: 2 ports detected
[    5.804271] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    5.804509] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    5.804983] uhci_hcd 0000:00:1d.0: detected 2 ports
[    5.805533] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000ff80
[    5.806102] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.11
[    5.806633] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.807197] usb usb6: Product: UHCI Host Controller
[    5.807776] usb usb6: Manufacturer: Linux 5.11.0-rc4-00202-gfe75a21824e7-dirty uhci_hcd
[    5.808364] usb usb6: SerialNumber: 0000:00:1d.0
[    5.809023] hub 6-0:1.0: USB hub found
[    5.809548] hub 6-0:1.0: 2 ports detected
[    5.810517] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    5.810763] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    5.811342] uhci_hcd 0000:00:1d.1: detected 2 ports
[    5.811972] uhci_hcd 0000:00:1d.1: irq 17, io base 0x0000ff60
[    5.812601] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.11
[    5.813184] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.813806] usb usb7: Product: UHCI Host Controller
[    5.814418] usb usb7: Manufacturer: Linux 5.11.0-rc4-00202-gfe75a21824e7-dirty uhci_hcd
[    5.815041] usb usb7: SerialNumber: 0000:00:1d.1
[    5.815739] hub 7-0:1.0: USB hub found
[    5.816298] hub 7-0:1.0: 2 ports detected
[    5.817312] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    5.817562] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    5.818151] uhci_hcd 0000:00:1d.2: detected 2 ports
[    5.818784] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ff40
[    5.819408] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.11
[    5.819986] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.820608] usb usb8: Product: UHCI Host Controller
[    5.821226] usb usb8: Manufacturer: Linux 5.11.0-rc4-00202-gfe75a21824e7-dirty uhci_hcd
[    5.821854] usb usb8: SerialNumber: 0000:00:1d.2
[    5.822552] hub 8-0:1.0: USB hub found
[    5.823108] hub 8-0:1.0: 2 ports detected
[    5.823870] i8042: PNP: PS/2 Controller [PNP0f13:MOU] at 0x60,0x64 irq 12
[    5.824358] i8042: PNP: PS/2 controller doesn't have KBD irq; using default 1
[    5.827717] serio: i8042 KBD port at 0x60,0x64 irq 1
[    5.827995] serio: i8042 AUX port at 0x60,0x64 irq 12
[    5.828318] mousedev: PS/2 mouse device common for all mice
[    5.828915] rtc_cmos 00:01: RTC can wake from S4
[    5.829639] rtc_cmos 00:01: registered as rtc0
[    5.830122] rtc_cmos 00:01: setting system clock to 2021-01-23T09:02:00 UTC (1611392520)
[    5.830740] rtc_cmos 00:01: alarms up to one day, 242 bytes nvram, hpet irqs
[    5.831689] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    5.835756] tsc: Refined TSC clocksource calibration: 2992.481 MHz
[    5.836015] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2b228661c25, max_idle_ns: 440795245102 ns
[    5.836334] clocksource: Switched to clocksource tsc
[    5.913182] i2c i2c-3: 4/4 memory slots populated (from DMI)
[    5.913746] i2c i2c-3: Successfully instantiated SPD at 0x50
[    5.914345] i2c i2c-3: Successfully instantiated SPD at 0x51
[    5.914943] i2c i2c-3: Successfully instantiated SPD at 0x52
[    5.915530] i2c i2c-3: Successfully instantiated SPD at 0x53
[    5.915942] iTCO_wdt iTCO_wdt.0.auto: Found a ICH9R TCO device (Version=2, TCOBASE=0x0860)
[    5.916275] iTCO_wdt iTCO_wdt.0.auto: initialized. heartbeat=30 sec (nowayout=0)
[    5.916982] EDAC MC0: Giving out device to module x38_edac controller x38: DEV 0000:00:00.0 (POLLED)
[    5.917491] hid: raw HID events driver (C) Jiri Kosina
[    5.918105] usbcore: registered new interface driver usbhid
[    5.918721] usbhid: USB HID core driver
[    5.919410] Key type dns_resolver registered
[    5.920099] microcode: sig=0x1067a, pf=0x1, revision=0xa0b
[    5.920602] microcode: Microcode Update Driver: v2.2.
[    5.920604] IPI shorthand broadcast: enabled
[    5.921829] sched_clock: Marking stable (5854751353, 67068459)->(5925098956, -3279144)
[    5.922497] registered taskstats version 1
[    5.923074] Loading compiled-in X.509 certificates
[    5.927580] Loaded X.509 cert 'Build time autogenerated kernel key: 6b03a1065de4fe7a58e236e632955d25126249fb'
[    5.928210] RAS: Correctable Errors collector initialized.
[    6.076379] ata6: SATA link down (SStatus 4 SControl 300)
[    6.076707] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.076995] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.077636] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.078258] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.078881] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    6.079593] ata4.00: ATA-9: WDC WD20NPVX-00EA4T0, 01.01A01, max UDMA/133
[    6.080087] ata4.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 32), AA
[    6.080717] ata5.00: ATA-9: WDC WD20NPVX-00EA4T0, 01.01A01, max UDMA/133
[    6.081328] ata5.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 32), AA
[    6.081953] ata2.00: ATA-8: WDC WD10EADS-00L5B1, 01.01A01, max UDMA/133
[    6.082574] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32), AA
[    6.083203] ata1.00: ATA-8: WDC WD10EADS-00L5B1, 01.01A01, max UDMA/133
[    6.083828] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32), AA
[    6.084958] ata2.00: configured for UDMA/133
[    6.085292] ata5.00: configured for UDMA/133
[    6.085686] ata4.00: configured for UDMA/133
[    6.086336] ata1.00: configured for UDMA/133
[    6.086956] scsi 0:0:0:0: Direct-Access     ATA      WDC WD10EADS-00L 1A01 PQ: 0 ANSI: 5
[    6.087658] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    6.087681] scsi 1:0:0:0: Direct-Access     ATA      WDC WD10EADS-00L 1A01 PQ: 0 ANSI: 5
[    6.088100] sd 0:0:0:0: [sda] Write Protect is off
[    6.088873] sd 1:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    6.089322] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.089980] ata3.00: ATAPI: PBDS CD-RW/DVD-ROM DH-48C2S, ND12, max UDMA/100
[    6.089982] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.091201] sd 1:0:0:0: [sdb] Write Protect is off
[    6.091831] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    6.091865] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.093373] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    6.101856] ata3.00: configured for UDMA/100
[    6.105212] scsi 2:0:0:0: CD-ROM            PBDS     CDRWDVD DH-48C2S ND12 PQ: 0 ANSI: 5
[    6.113705]  sda: sda1 sda2
[    6.114287] sd 0:0:0:0: [sda] Attached SCSI disk
[    6.124156] scsi 3:0:0:0: Direct-Access     ATA      WDC WD20NPVX-00E 1A01 PQ: 0 ANSI: 5
[    6.124584] sd 3:0:0:0: [sdc] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    6.124600] scsi 4:0:0:0: Direct-Access     ATA      WDC WD20NPVX-00E 1A01 PQ: 0 ANSI: 5
[    6.124851] sd 3:0:0:0: [sdc] 4096-byte physical blocks
[    6.125663] sd 4:0:0:0: [sdd] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    6.126132] sd 3:0:0:0: [sdc] Write Protect is off
[    6.126778] sd 4:0:0:0: [sdd] 4096-byte physical blocks
[    6.127427] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    6.128081] sd 4:0:0:0: [sdd] Write Protect is off
[    6.128088] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.128690] sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    6.129381] sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.221734] usb 1-1: New USB device found, idVendor=0424, idProduct=2502, bcdDevice= 0.01
[    6.222078] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    6.222501] hub 1-1:1.0: USB hub found
[    6.223108] hub 1-1:1.0: 2 ports detected
[    6.300373] usb 8-2: new full-speed USB device number 2 using uhci_hcd
[    6.475831] sd 4:0:0:0: [sdd] Attached SCSI disk
[    6.477217] sd 3:0:0:0: [sdc] Attached SCSI disk
[    6.488509] usb 8-2: New USB device found, idVendor=0b33, idProduct=08a1, bcdDevice= 3.00
[    6.488805] usb 8-2: New USB device strings: Mfr=1, Product=4, SerialNumber=3
[    6.489181] usb 8-2: Product: Contour Mouse
[    6.489840] usb 8-2: Manufacturer: Contour Design
[    6.490447] usb 8-2: SerialNumber: V3.0
[    6.500835] input: Contour Design Contour Mouse as /devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.0/0003:0B33:08A1.0001/input/input4
[    6.501168] hid-generic 0003:0B33:08A1.0001: input,hidraw0: USB HID v1.11 Mouse [Contour Design Contour Mouse] on usb-0000:00:1d.2-2/input0
[    6.524374] usb 3-2: new full-speed USB device number 2 using uhci_hcd
[    6.606469]  sdb: sdb1 sdb2
[    6.607062] sd 1:0:0:0: [sdb] Attached SCSI disk
[    6.607670] Freeing unused kernel image (initmem) memory: 876K
[    6.620375] Write protecting the kernel read-only data: 16384k
[    6.621461] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    6.622311] Freeing unused kernel image (rodata/data gap) memory: 1652K
[    6.671115] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    6.671414] x86/mm: Checking user space page tables
[    6.698400] usb 3-2: New USB device found, idVendor=05f3, idProduct=0081, bcdDevice= 3.20
[    6.698696] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    6.699131] usb 3-2: Product: Kinesis Keyboard Hub
[    6.699819] usb 3-2: Manufacturer: PI Engineering
[    6.703406] hub 3-2:1.0: USB hub found
[    6.705388] hub 3-2:1.0: 4 ports detected
[    6.715715] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    6.716009] Run /init as init process
[    6.716406]   with arguments:
[    6.716408]     /init
[    6.716409]   with environment:
[    6.716410]     HOME=/
[    6.716411]     TERM=linux
[    6.716412]     BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc4-00202-gfe75a21824e7-dirty
[    6.856050] md/raid1:md0: active with 2 out of 2 mirrors
[    6.856372] md0: detected capacity change from 1953524896 to 0
[    6.857940]  md0: p1 p2
[    7.000377] usb 3-2.2: new full-speed USB device number 3 using uhci_hcd
[    7.045658] device-mapper: uevent: version 1.0.3
[    7.046032] device-mapper: ioctl: 4.43.0-ioctl (2020-10-01) initialised: dm-devel@redhat.com
[    7.047328] dm-0: detected capacity change from 16777216 to 0
[    7.047996] dm-1: detected capacity change from 209715200 to 0
[    7.050052] dm-2: detected capacity change from 209715200 to 0
[    7.051418] dm-3: detected capacity change from 20971520 to 0
[    7.057122] dm-4: detected capacity change from 14680064 to 0
[    7.057892] dm-5: detected capacity change from 230686720 to 0
[    7.060097] dm-6: detected capacity change from 12582912 to 0
[    7.062073] dm-7: detected capacity change from 104857600 to 0
[    7.063415] dm-8: detected capacity change from 104857600 to 0
[    7.116394] usb 3-2.2: New USB device found, idVendor=05f3, idProduct=0007, bcdDevice= 3.20
[    7.116751] usb 3-2.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    7.124782] input: HID 05f3:0007 as /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2.2/3-2.2:1.0/0003:05F3:0007.0002/input/input6
[    7.177417] hid-generic 0003:05F3:0007.0002: input,hidraw1: USB HID v1.00 Keyboard [HID 05f3:0007] on usb-0000:00:1a.0-2.2/input0
[    7.182201] input: HID 05f3:0007 System Control as /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2.2/3-2.2:1.1/0003:05F3:0007.0003/input/input7
[    7.190376] usb 1-1.1: new high-speed USB device number 4 using ehci-pci
[    7.234453] input: HID 05f3:0007 Consumer Control as /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2.2/3-2.2:1.1/0003:05F3:0007.0003/input/input8
[    7.234787] hid-generic 0003:05F3:0007.0003: input,hidraw2: USB HID v1.00 Device [HID 05f3:0007] on usb-0000:00:1a.0-2.2/input1
[    7.281737] usb 1-1.1: New USB device found, idVendor=0424, idProduct=2504, bcdDevice= 0.01
[    7.282095] usb 1-1.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    7.282761] hub 1-1.1:1.0: USB hub found
[    7.283358] hub 1-1.1:1.0: 4 ports detected
[    7.352916] input: PS2++ Logitech Mouse as /devices/platform/i8042/serio1/input/input5
[    7.364376] usb 1-1.2: new high-speed USB device number 5 using ehci-pci
[    7.531110] usb 1-1.2: New USB device found, idVendor=0424, idProduct=223a, bcdDevice= 3.60
[    7.531463] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    7.531897] usb 1-1.2: Product: USB2223
[    7.532614] usb 1-1.2: Manufacturer: SMSC
[    7.533323] usb 1-1.2: SerialNumber: 000223223223
[    7.566376] usb 1-1.1.2: new high-speed USB device number 6 using ehci-pci
[    7.657484] usb 1-1.1.2: New USB device found, idVendor=249c, idProduct=930b, bcdDevice= 2.13
[    7.657824] usb 1-1.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    7.658229] usb 1-1.1.2: Product: M2Tech USB Audio 2.0
[    7.658937] usb 1-1.1.2: Manufacturer: M2Tech 
[    7.659638] usb 1-1.1.2: SerialNumber: 0000
[    8.685512] SGI XFS with ACLs, security attributes, realtime, no debug enabled
[    8.956033] XFS (dm-0): Deprecated V4 format (crc=0) will not be supported after September 2030.
[    8.956505] XFS (dm-0): Mounting V4 Filesystem
[    9.164449] XFS (dm-0): Ending clean mount
[   11.197457] Floppy drive(s): fd0 is 1.44M
[   11.211551] FDC 0 is a post-1991 82077
[   11.260152] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   11.260482] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   11.261068] scsi 2:0:0:0: Attached scsi generic sg2 type 5
[   11.262307] sd 3:0:0:0: Attached scsi generic sg3 type 0
[   11.262622] sd 4:0:0:0: Attached scsi generic sg4 type 0
[   11.387901] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.4)
[   11.407000] sr 2:0:0:0: [sr0] scsi3-mmc drive: 0x/48x writer cd/rw xa/form2 cdda tray
[   11.407389] cdrom: Uniform CD-ROM driver Revision: 3.20
[   11.422124] tg3 0000:04:00.0 eth0: Tigon3 [partno(BCM95754) rev b002] (PCI Express) MAC address 00:24:e8:2e:01:56
[   11.422427] tg3 0000:04:00.0 eth0: attached PHY is 5787 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[   11.422902] tg3 0000:04:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   11.423628] tg3 0000:04:00.0 eth0: dma_rwctrl[76180000] dma_mask[64-bit]
[   11.426611] sr 2:0:0:0: Attached scsi CD-ROM sr0
[   11.945362] usb-storage 1-1.2:1.0: USB Mass Storage device detected
[   11.945750] scsi host6: usb-storage 1-1.2:1.0
[   11.946229] usbcore: registered new interface driver usb-storage
[   12.023206] snd_hda_codec_analog hdaudioC0D0: autoconfig for AD1984: line_outs=1 (0x12/0x0/0x0/0x0/0x0) type:line
[   12.023528] snd_hda_codec_analog hdaudioC0D0:    speaker_outs=1 (0x13/0x0/0x0/0x0/0x0)
[   12.024038] snd_hda_codec_analog hdaudioC0D0:    hp_outs=1 (0x11/0x0/0x0/0x0/0x0)
[   12.024804] snd_hda_codec_analog hdaudioC0D0:    mono: mono_out=0x0
[   12.025507] snd_hda_codec_analog hdaudioC0D0:    inputs:
[   12.026231] snd_hda_codec_analog hdaudioC0D0:      Mic=0x14
[   12.026970] snd_hda_codec_analog hdaudioC0D0:      Line=0x15
[   12.036134] input: HDA Intel Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[   12.036487] input: HDA Intel Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[   12.037009] input: HDA Intel Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[   12.037781] input: HDA Intel Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[   12.081987] usb 1-1.1.2: 1:1: found sync_ep=0x81, iface=1, alt=1, implicit_fb=0
[   12.081994] usb 1-1.1.2: 1:1: add audio endpoint 0x1
[   12.082006] usb 1-1.1.2: Creating new data endpoint #1
[   12.082010] usb 1-1.1.2: Creating new sync endpoint #81
[   12.082111] usb 1-1.1.2: 1:1 Set sample rate 192000, clock 40
[   12.083112] usb 1-1.1.2: [10] FU [M2Tech Audio 2.0 Output Playback Switch] ch = 2, val = 0/1/1
[   12.083237] usb 1-1.1.2: [10] FU [M2Tech Audio 2.0 Output Playback Switch] ch = 1, val = 0/1/1
[   12.083734] usb 1-1.1.2: RANGE setting not yet supported
[   12.084360] usb 1-1.1.2: [10] FU [M2Tech Audio 2.0 Output Playback Volume] ch = 2, val = -32512/0/256
[   12.084859] usb 1-1.1.2: RANGE setting not yet supported
[   12.085484] usb 1-1.1.2: [10] FU [M2Tech Audio 2.0 Output Playback Volume] ch = 1, val = -32512/0/256
[   12.085754] usbcore: registered new interface driver snd-usb-audio
[   13.011631] scsi 6:0:0:0: Direct-Access     SMSC     223 U HS-CF      3.60 PQ: 0 ANSI: 0
[   13.015247] scsi 6:0:0:1: Direct-Access     SMSC     223 U HS-MS      3.60 PQ: 0 ANSI: 0
[   13.018873] scsi 6:0:0:2: Direct-Access     SMSC     223 U HS-SM      3.60 PQ: 0 ANSI: 0
[   13.022000] scsi 6:0:0:3: Direct-Access     SMSC     223 U HS-SD/MMC  3.60 PQ: 0 ANSI: 0
[   13.022510] sd 6:0:0:0: Attached scsi generic sg5 type 0
[   13.022908] sd 6:0:0:1: Attached scsi generic sg6 type 0
[   13.023611] sd 6:0:0:2: Attached scsi generic sg7 type 0
[   13.024265] sd 6:0:0:3: Attached scsi generic sg8 type 0
[   13.036247] sd 6:0:0:0: [sde] Attached SCSI removable disk
[   13.047244] sd 6:0:0:1: [sdf] Attached SCSI removable disk
[   13.115994] sd 6:0:0:2: [sdg] Attached SCSI removable disk
[   13.128994] sd 6:0:0:3: [sdh] Attached SCSI removable disk
[   13.605464] xfs filesystem being remounted at / supports timestamps until 2038 (0x7fffffff)
[   14.328955] tun: Universal TUN/TAP device driver, 1.6
[   14.707141] dm-9: detected capacity change from 16776352 to 0
[   15.223952] XFS (dm-1): Mounting V4 Filesystem
[   15.362310] XFS (dm-1): Ending clean mount
[   15.362713] xfs filesystem being mounted at /var supports timestamps until 2038 (0x7fffffff)
[   15.381857] XFS (sdc): Mounting V5 Filesystem
[   15.615617] XFS (sdc): Ending clean mount
[   15.659101] xfs filesystem being mounted at /media/music supports timestamps until 2038 (0x7fffffff)
[   15.763372] Adding 8388172k swap on /dev/mapper/swap.  Priority:-2 extents:1 across:8388172k 
[   16.481454] br0: port 1(eth0) entered blocking state
[   16.481743] br0: port 1(eth0) entered disabled state
[   16.482101] device eth0 entered promiscuous mode
[   16.958416] RPC: Registered named UNIX socket transport module.
[   16.958708] RPC: Registered udp transport module.
[   16.959024] RPC: Registered tcp transport module.
[   16.959656] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   16.995444] FS-Cache: Loaded
[   17.043421] FS-Cache: Netfs 'nfs' registered for caching
[   17.099679] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   19.661561] tg3 0000:04:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   19.663045] tg3 0000:04:00.0 eth0: Flow control is on for TX and on for RX
[   19.664347] br0: port 1(eth0) entered blocking state
[   19.665613] br0: port 1(eth0) entered forwarding state
[   20.761346] NFSD: Using UMH upcall client tracking operations.
[   20.761351] NFSD: starting 90-second grace period (net f0000098)
[   31.115498] NFS: Registering the id_resolver key type
[   31.115509] Key type id_resolver registered
[   31.115511] Key type id_legacy registered
[  108.941516] ------------[ cut here ]------------
[  108.941521] WARNING: CPU: 0 PID: 2776 at sound/core/pcm_lib.c:1148 snd_pcm_hw_rule_add+0xd3/0x160 [snd_pcm]
[  108.941535] Modules linked in: nfsv4 cpufreq_userspace cpufreq_powersave cpufreq_ondemand cpufreq_conservative fan autofs4 nfsd auth_rpcgss nfs lockd grace nfs_ssc fscache sunrpc bridge stp llc nhpoly1305_sse2 nhpoly1305 aes_generic libaes chacha_generic chacha_x86_64 libchacha adiantum libpoly1305 vhost_net tun vhost vhost_iotlb tap dm_crypt snd_usb_audio snd_usbmidi_lib snd_hda_codec_analog snd_rawmidi usb_storage snd_hda_codec_generic snd_seq_device kvm_intel kvm irqbypass snd_hda_intel snd_intel_dspcfg snd_hda_codec tg3 snd_hwdep dcdbas sr_mod snd_hda_core snd_pcm cdrom snd_timer snd soundcore sg floppy evdev xfs dm_mod raid1 md_mod psmouse
[  108.941608] CPU: 0 PID: 2776 Comm: aplay Not tainted 5.11.0-rc4-00202-gfe75a21824e7-dirty #1
[  108.941612] Hardware name: Dell Inc. Precision WorkStation T3400  /0TP412, BIOS A14 04/30/2012
[  108.941615] RIP: 0010:snd_pcm_hw_rule_add+0xd3/0x160 [snd_pcm]
[  108.941623] Code: 83 c1 08 4c 01 c2 48 39 c6 8b 12 74 1d 89 10 48 83 c0 04 85 d2 78 39 83 f9 2f 76 e2 48 89 fa 48 83 c7 08 48 39 c6 8b 12 75 e3 <0f> 0b b8 ea ff ff ff 48 8b 5c 24 28 65 48 2b 1c 25 28 00 00 00 75
[  108.941627] RSP: 0018:ffffc900010a3ad8 EFLAGS: 00010246
[  108.941631] RAX: ffff888101c51b38 RBX: ffff88810edda000 RCX: 0000000000000030
[  108.941634] RDX: 00000000ffffffff RSI: ffff888101c51b38 RDI: ffffc900010a3b90
[  108.941637] RBP: ffffc900010a3b60 R08: ffffc900010a3b08 R09: 000000000000000b
[  108.941639] R10: 0000000000000100 R11: 0000000000000000 R12: 000000000000000b
[  108.941642] R13: 000000000000000b R14: 0000000000000000 R15: ffffffffa035b2e0
[  108.941644] FS:  00007ffbf1b46440(0000) GS:ffff888233c00000(0000) knlGS:0000000000000000
[  108.941648] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  108.941651] CR2: 00007ffbf1ebd2d0 CR3: 000000010efe0000 CR4: 00000000000406f0
[  108.941654] Call Trace:
[  108.941658]  ? krealloc+0x75/0xb0
[  108.941664]  ? snd_pcm_post_reset+0x40/0x40 [snd_pcm]
[  108.941670]  ? snd_pcm_hw_rule_add+0x128/0x160 [snd_pcm]
[  108.941678]  snd_usb_pcm_open+0x216/0x3b0 [snd_usb_audio]
[  108.941690]  snd_pcm_open_substream+0x546/0x8d0 [snd_pcm]
[  108.941698]  snd_pcm_open+0x121/0x270 [snd_pcm]
[  108.941704]  ? wake_up_q+0xa0/0xa0
[  108.941710]  snd_pcm_playback_open+0x38/0x60 [snd_pcm]
[  108.941717]  chrdev_open+0xc5/0x240
[  108.941722]  ? cdev_device_add+0x80/0x80
[  108.941725]  do_dentry_open+0x139/0x370
[  108.941730]  path_openat+0xaad/0xdd0
[  108.941735]  do_filp_open+0x9c/0x140
[  108.941739]  do_sys_openat2+0xac/0x160
[  108.941742]  __x64_sys_openat+0x51/0x90
[  108.941746]  do_syscall_64+0x33/0x40
[  108.941751]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  108.941755] RIP: 0033:0x7ffbf1d7fbe7
[  108.941759] Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85 c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
[  108.941762] RSP: 002b:00007ffe8430b930 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[  108.941766] RAX: ffffffffffffffda RBX: 0000000000080802 RCX: 00007ffbf1d7fbe7
[  108.941769] RDX: 0000000000080802 RSI: 00007ffe8430baf0 RDI: 00000000ffffff9c
[  108.941771] RBP: 00007ffe8430baf0 R08: 0000000000000000 R09: 0000000000000011
[  108.941774] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080802
[  108.941776] R13: 0000000000000004 R14: 0000000000000001 R15: 00007ffe8430baf0
[  108.941780] ---[ end trace 34e71a1f81a1c00a ]---

--pqQlAcXbYQGFe/DY--
