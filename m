Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9C42FA3B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405337AbhAROya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:54:30 -0500
Received: from sym2.noone.org ([178.63.92.236]:58158 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405311AbhAROx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:53:56 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4DKFCB5x05zvjfm; Mon, 18 Jan 2021 15:53:10 +0100 (CET)
Date:   Mon, 18 Jan 2021 15:53:10 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, nylon7@andestech.com,
        Bjorn Topel <bjorn.topel@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: riscv+KASAN does not boot
Message-ID: <20210118145310.crnqnh6kax5jqicj@distanz.ch>
References: <CACT4Y+bDqMiC+ou5ghb=XB3Oyjw3p-GTDvNw4NkkQqQthw1yuQ@mail.gmail.com>
 <mhng-02b88d43-ede8-48f9-82f1-c84201acb7a8@palmerdabbelt-glaptop>
 <CACT4Y+aN3LvgaBc_zmW=t=D7ChU-jrWYnjt5sZ2GEDQhg_BC9A@mail.gmail.com>
 <CACT4Y+aC19DaNOm87EO3cER2=MEmO9pmtUxzVmRtg9YhZKuMVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aC19DaNOm87EO3cER2=MEmO9pmtUxzVmRtg9YhZKuMVA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-14 at 11:24:07 +0100, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Thu, Jan 14, 2021 at 10:23 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, Jan 14, 2021 at 5:57 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
> > >
> > > On Fri, 25 Dec 2020 09:13:23 PST (-0800), dvyukov@google.com wrote:
> > > > On Fri, Dec 25, 2020 at 5:58 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> > > >>
> > > >> On Dez 25 2020, Dmitry Vyukov wrote:
> > > >>
> > > >> > qemu-system-riscv64 \
> > > >> > -machine virt -bios default -smp 1 -m 2G \
> > > >> > -device virtio-blk-device,drive=hd0 \
> > > >> > -drive file=buildroot-riscv64.ext4,if=none,format=raw,id=hd0 \
> > > >> > -kernel arch/riscv/boot/Image \
> > > >> > -nographic \
> > > >> > -device virtio-rng-device,rng=rng0 -object
> > > >> > rng-random,filename=/dev/urandom,id=rng0 \
> > > >> > -netdev user,id=net0,host=10.0.2.10,hostfwd=tcp::10022-:22 -device
> > > >> > virtio-net-device,netdev=net0 \
> > > >> > -append "root=/dev/vda earlyprintk=serial console=ttyS0 oops=panic
> > > >> > panic_on_warn=1 panic=86400"
> > > >>
> > > >> Do you get more output with earlycon=sbi?
> > > >
> > > > Hi Andreas,
> > > >
> > > > For defconfig+kvm_guest.config+ scripts/config -e KASAN -e
> > > > KASAN_INLINE it actually gave me more output:
> > > >
> > > >
> > > > OpenSBI v0.7
> > > >    ____                    _____ ____ _____
> > > >   / __ \                  / ____|  _ \_   _|
> > > >  | |  | |_ __   ___ _ __ | (___ | |_) || |
> > > >  | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
> > > >  | |__| | |_) |  __/ | | |____) | |_) || |_
> > > >   \____/| .__/ \___|_| |_|_____/|____/_____|
> > > >         | |
> > > >         |_|
> > > >
> > > > Platform Name          : QEMU Virt Machine
> > > > Platform HART Features : RV64ACDFIMSU
> > > > Current Hart           : 0
> > > > Firmware Base          : 0x80000000
> > > > Firmware Size          : 132 KB
> > > > Runtime SBI Version    : 0.2
> > > >
> > > > MIDELEG : 0x0000000000000222
> > > > MEDELEG : 0x000000000000b109
> > > > PMP0    : 0x0000000080000000-0x000000008003ffff (A)
> > > > PMP1    : 0x0000000000000000-0xffffffffffffffff (A,R,W,X)
> > > > [    0.000000] Linux version 5.10.0-01370-g71c5f03154ac
> > > > (dvyukov@dvyukov-desk.muc.corp.google.com) (riscv64-linux-gnu-gcc
> > > > (Debian 10.2.0-9) 10.2.0, GNU ld (GNU Binutils for Debian) 2.35.1) #17
> > > > SMP Fri Dec 25 18:10:12 CET 2020
> > > > [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
> > > > [    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
> > > > [    0.000000] printk: bootconsole [sbi0] enabled
> > > > [    0.000000] efi: UEFI not found.
> > > > [    0.000000] Zone ranges:
> > > > [    0.000000]   DMA32    [mem 0x0000000080200000-0x00000000ffffffff]
> > > > [    0.000000]   Normal   empty
> > > > [    0.000000] Movable zone start for each node
> > > > [    0.000000] Early memory node ranges
> > > > [    0.000000]   node   0: [mem 0x0000000080200000-0x00000000ffffffff]
> > > > [    0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x00000000ffffffff]
> > > > [    0.000000] SBI specification v0.2 detected
> > > > [    0.000000] SBI implementation ID=0x1 Version=0x7
> > > > [    0.000000] SBI v0.2 TIME extension detected
> > > > [    0.000000] SBI v0.2 IPI extension detected
> > > > [    0.000000] SBI v0.2 RFENCE extension detected
> > > > [    0.000000] software IO TLB: mapped [mem
> > > > 0x00000000fa3f9000-0x00000000fe3f9000] (64MB)
> > > > [    0.000000] Unable to handle kernel paging request at virtual
> > > > address dfffffc810040000
> > > > [    0.000000] Oops [#1]
> > > > [    0.000000] Modules linked in:
> > > > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> > > > 5.10.0-01370-g71c5f03154ac #17
> > > > [    0.000000] epc: ffffffe00042e3e4 ra : ffffffe000c0462c sp : ffffffe001603ea0
> > > > [    0.000000]  gp : ffffffe0016e3c60 tp : ffffffe00160cd40 t0 :
> > > > dfffffc810040000
> > > > [    0.000000]  t1 : ffffffe000e0a838 t2 : 0000000000000000 s0 :
> > > > ffffffe001603f50
> > > > [    0.000000]  s1 : ffffffe0016e50a8 a0 : dfffffc810040000 a1 :
> > > > 0000000000000000
> > > > [    0.000000]  a2 : 000000000ffc0000 a3 : dfffffc820000000 a4 :
> > > > 0000000000000000
> > > > [    0.000000]  a5 : 000000003e8c6001 a6 : ffffffe000e0a820 a7 :
> > > > 0000000000000900
> > > > [    0.000000]  s2 : dfffffc820000000 s3 : dfffffc800000000 s4 :
> > > > 0000000000000001
> > > > [    0.000000]  s5 : ffffffe0016e5108 s6 : fffffffffffff000 s7 :
> > > > dfffffc810040000
> > > > [    0.000000]  s8 : 0000000000000080 s9 : ffffffffffffffff s10:
> > > > ffffffe07a119000
> > > > [    0.000000]  s11: 000000000000ffc0 t3 : ffffffe0016eb908 t4 :
> > > > 0000000000000001
> > > > [    0.000000]  t5 : ffffffc4001c150a t6 : ffffffe001603be8
> > > > [    0.000000] status: 0000000000000100 badaddr: dfffffc810040000
> > > > cause: 000000000000000f
> > > > [    0.000000] random: get_random_bytes called from
> > > > oops_exit+0x30/0x58 with crng_init=0
> > > > [    0.000000] ---[ end trace 0000000000000000 ]---
> > > > [    0.000000] Kernel panic - not syncing: Fatal exception
> > > > [    0.000000] ---[ end Kernel panic - not syncing: Fatal exception ]---
> > > >
> > > >
> > > > But I first tried with a the kernel image I had in the dir, I think it
> > > > was this config (no KASAN):
> > > > https://gist.githubusercontent.com/dvyukov/b2b62beccf80493781ab03b41430e616/raw/62e673cff08a8a41656d2871b8a37f74b00f509f/gistfile1.txt
> > > >
> > > > and earlycon=sbi did not change anything (no output after OpenSBI).
> > > > So potentially there are 2 different problems.
> > >
> > > Thanks for reporting this.  Looks like I'd forgotten to add a kasan config to
> > > my tests.  There's one in there now, and it's passing as of the fix that Nylon
> > > posted.
> >
> > I can boot the KASAN kernel now on riscv/fixes.
> >
> > Next problem: I've got only to:
> >
> > [   90.498967][    T1] Run /sbin/init as init process
> > [   91.164353][ T4022] init[4022]: unhandled signal 11 code 0x1 at
> > 0x0000000000000bb0 in busybox[10000+d7000]
> > [   91.179640][ T4022] CPU: 1 PID: 4022 Comm: init Not tainted
> > 5.11.0-rc2-00012-g0983834a8393 #19
> > [   91.180853][ T4022] epc: 0000000000000bb0 ra : 0000003fccab09d0 sp
> > : 0000003fffa8c7b0
> > [   91.181861][ T4022]  gp : 00000000000e8d70 tp : 0000003fccaaf820 t0
> > : 000000000000001e
> > [   91.182810][ T4022]  t1 : 0000003fccab0bfc t2 : 000000000000000a s0
> > : 0000003fffa8c850
> > [   91.183749][ T4022]  s1 : 0000003fccab1070 a0 : 0000003fccab1070 a1
> > : 0000003fffa8c8c8
> > [   91.184689][ T4022]  a2 : 0000000000000001 a3 : 0000000000000020 a4
> > : 0000000000000000
> > [   91.185620][ T4022]  a5 : 0000000000000000 a6 : 0000003fcc9c4260 a7
> > : fffffffffffffffe
> > [   91.186566][ T4022]  s2 : 0000000000000000 s3 : 0000003fffa8c8c8 s4
> > : 0000003fccab1000
> > [   91.187500][ T4022]  s5 : 0000003fccab1078 s6 : 0000003fffa8c8d0 s7
> > : 0000000000000010
> > [   91.189672][ T4022]  s8 : 0000000000000016 s9 : 0000000000000000
> > s10: 0000003fffa8c8c8
> > [   91.190637][ T4022]  s11: 0000000000000000 t3 : 0000000000000bb0 t4
> > : 0000000000000000
> > [   91.191568][ T4022]  t5 : 0000003fffa8c360 t6 : 0000000000000000
> > [   91.192389][ T4022] status: 8000000000004020 badaddr:
> > 0000000000000bb0 cause: 000000000000000c
> > [   91.201573][    T1] Kernel panic - not syncing: Attempted to kill
> > init! exitcode=0x0000000b
> > [   91.202906][    T1] CPU: 0 PID: 1 Comm: init Not tainted
> > 5.11.0-rc2-00012-g0983834a8393 #19
> > [   91.204139][    T1] Call Trace:
> > [   91.204849][    T1] [<ffffffe0000095c0>] walk_stackframe+0x0/0x1d0
> > [   91.206124][    T1] [<ffffffe00458b2d8>] show_stack+0x3a/0x46
> > [   91.207240][    T1] [<ffffffe0045a5b72>] dump_stack+0x11c/0x180
> > [   91.208732][    T1] [<ffffffe00458b6a0>] panic+0x20a/0x5cc
> > [   91.209890][    T1] [<ffffffe00002eea4>] do_exit+0x1846/0x1874
> > [   91.211052][    T1] [<ffffffe00002efdc>] do_group_exit+0xa0/0x192
> > [   91.212224][    T1] [<ffffffe000047d30>] get_signal+0x2d6/0x13dc
> > [   91.213390][    T1] [<ffffffe000007eb0>] do_notify_resume+0xa8/0x912
> > [   91.214567][    T1] [<ffffffe00000559c>] ret_from_exception+0x0/0x14
> >
> > The image is buildroot on 2020.11.x built with this script:
> > https://gist.githubusercontent.com/dvyukov/1a9a01ca2189e35175a021820c95b04d/raw/5c01d755e83f4eab0d56aa7dc84af3b2d5e80423/gistfile1.txt
> >
> > Readelf for init shows the following (is it that [10000+d7000] address
> > is not .text at all?):
> >
> > $ riscv64-linux-gnu-readelf --sections image/bin/busybox
> > There are 27 section headers, starting at offset 0xd7f20:
> >
> > Section Headers:
> >   [Nr] Name              Type             Address           Offset
> >        Size              EntSize          Flags  Link  Info  Align
> >   [ 0]                   NULL             0000000000000000  00000000
> >        0000000000000000  0000000000000000           0     0     0
> >   [ 1] .interp           PROGBITS         0000000000010238  00000238
> >        0000000000000021  0000000000000000   A       0     0     1
> >   [ 2] .note.ABI-tag     NOTE             000000000001025c  0000025c
> >        0000000000000020  0000000000000000   A       0     0     4
> >   [ 3] .hash             HASH             0000000000010280  00000280
> >        00000000000009cc  0000000000000004   A       5     0     8
> >   [ 4] .gnu.hash         GNU_HASH         0000000000010c50  00000c50
> >        0000000000000ac8  0000000000000000   A       5     0     8
> >   [ 5] .dynsym           DYNSYM           0000000000011718  00001718
> >        00000000000021f0  0000000000000018   A       6     1     8
> >   [ 6] .dynstr           STRTAB           0000000000013908  00003908
> >        0000000000000c66  0000000000000000   A       0     0     1
> >   [ 7] .gnu.version      VERSYM           000000000001456e  0000456e
> >        00000000000002d4  0000000000000002   A       5     0     2
> >   [ 8] .gnu.version_r    VERNEED          0000000000014848  00004848
> >        0000000000000050  0000000000000000   A       6     2     8
> >   [ 9] .rela.dyn         RELA             0000000000014898  00004898
> >        00000000000000c0  0000000000000018   A       5     0     8
> >   [10] .rela.plt         RELA             0000000000014958  00004958
> >        00000000000020a0  0000000000000018  AI       5    22     8
> >   [11] .plt              PROGBITS         0000000000016a00  00006a00
> >        00000000000015e0  0000000000000010  AX       0     0     16
> >   [12] .text             PROGBITS         0000000000017fe0  00007fe0
> >        00000000000a3668  0000000000000000  AX       0     0     4
> >   [13] .rodata           PROGBITS         00000000000bb648  000ab648
> >        000000000002b076  0000000000000000   A       0     0     8
> >   [14] .sdata2           PROGBITS         00000000000e66c0  000d66c0
> >        0000000000000163  0000000000000000   A       0     0     8
> >   [15] .eh_frame_hdr     PROGBITS         00000000000e6824  000d6824
> >        0000000000000014  0000000000000000   A       0     0     4
> >   [16] .eh_frame         PROGBITS         00000000000e6838  000d6838
> >        000000000000002c  0000000000000000   A       0     0     8
> >   [17] .preinit_array    PREINIT_ARRAY    00000000000e7df8  000d6df8
> >        0000000000000008  0000000000000008  WA       0     0     1
> >   [18] .init_array       INIT_ARRAY       00000000000e7e00  000d6e00
> >        0000000000000008  0000000000000008  WA       0     0     8
> >   [19] .fini_array       FINI_ARRAY       00000000000e7e08  000d6e08
> >        0000000000000008  0000000000000008  WA       0     0     8
> >   [20] .dynamic          DYNAMIC          00000000000e7e10  000d6e10
> >        00000000000001f0  0000000000000010  WA       6     0     8
> >   [21] .data             PROGBITS         00000000000e8000  000d7000
> >        0000000000000240  0000000000000000  WA       0     0     8
> >   [22] .got              PROGBITS         00000000000e8240  000d7240
> >        0000000000000af8  0000000000000008  WA       0     0     8
> >   [23] .sdata            PROGBITS         00000000000e8d38  000d7d38
> >        0000000000000101  0000000000000000  WA       0     0     8
> >   [24] .sbss             NOBITS           00000000000e8e40  000d7e39
> >        000000000000017f  0000000000000000  WA       0     0     8
> >   [25] .bss              NOBITS           00000000000e8fc0  000d7e39
> >        00000000000005b0  0000000000000000  WA       0     0     8
> >   [26] .shstrtab         STRTAB           0000000000000000  000d7e39
> >        00000000000000e6  0000000000000000           0     0     1
> >
> >
> > Before I spent more time on this, am I doing anything obviously wrong?
> > Is it a known issue? Are there any fresh working recipes?
> 
> Humm.. I tried to use 2020.05 which Tobias used here:
> https://github.com/google/syzkaller/blob/master/docs/linux/setup_linux-host_qemu-vm_riscv64-kernel.md#image
> But there is no make qemu_riscv64_virt_defconfig target... though I
> remember I tested these instructions at the time...

Weird. `make qemu_riscv64_virt_defconfig` works here on buildroot
202.05, 2020.11.1 and on latest master.

Do you see these in your configs/ directory?

$ ls -l configs/qemu_riscv*
-rw-rw-r-- 1 tklauser tklauser 673 Jan 18 15:51 configs/qemu_riscv32_virt_defconfig
-rw-rw-r-- 1 tklauser tklauser 682 Jan 18 15:51 configs/qemu_riscv64_virt_defconfig
