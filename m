Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6E82FA51F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392972AbhARPtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393475AbhARPoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:44:19 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756E1C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:43:38 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id 143so18948383qke.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1x8E7WfdErPAbKy1BFbku07lHIPyohPRTCtibqcgG4=;
        b=TSD9VwJvNm4pTJtIJ1TCDDTyXLZ0PN9F9Ped+Rz4AIbVARVCMm5xwhEESEdDW9bBJ3
         l6qFs7ZwU6KjF6Vw8wI1lDLR/Ret6DnsTZv+XqNcoKT2RKh4OB9TPqV/bu/kE0gBADr8
         l5kaE4/75RkZhxmqW/kJT5x62L6FknzkqKPrG6ZMZHv8BKRjahY0t7Uj/QbMCbwAyiz6
         l6YiAqv7d8b9oEbLYomQvhh2oKyK0LQfw1MNyJYVDZ8ZVBTCayzDuCVEwCVvnsjTlt28
         HYF6I0V2Bu9zOu1MvFdhM3WwQLfmEu6/kcBlpx4Ioxw7gUM/jGf2U3I02noJh+TPhNd0
         mNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1x8E7WfdErPAbKy1BFbku07lHIPyohPRTCtibqcgG4=;
        b=Simx/8pTUwXPipXh/qQpOMBlTTQx0csrBs6fnQh58Iwkt6GfuU/nrWPTc5GS7+k/E6
         8zNu29cOv/cL4RC1/f6EQioQkD3sEv1Max3eUaqowBOvYC9RPpU5wKbMLL31mGde014Q
         0kgLqw70CuzzTjzCKFSu4MMYoxH9OB6S0fheSUS8xLdD1cAqjrStclFilfqgQ6s0GvNT
         9G3Qm2WBFCSetY2U9Goac4eL5JlDf4itIZmnWhAuikMtAlVe8VdaAoRMCsGp2AIeLDve
         kk6lK++DEuhnihRvY40IWCOJmRAC63HtZXTiN8FQ5SIaSFFtSAuToRafYbcK7hIkB+xE
         Ue3A==
X-Gm-Message-State: AOAM533Cl2YBvpnpIiVE5Ior+1kTwXfkWuzW+kcRKqLdwmZff59AsCNd
        U70qyHeqIUgKW4qYLRzgQNlBfxgdxoqhTFD59DEalg==
X-Google-Smtp-Source: ABdhPJwcavjps3Nu02zU4+fUj4GuJcLFzD9IqfQd+6mvSnUyKLtLGGQ6vfx4I6bacfriiuYU5Pz3RVP1qgMJAr39L00=
X-Received: by 2002:a05:620a:713:: with SMTP id 19mr191525qkc.424.1610984617227;
 Mon, 18 Jan 2021 07:43:37 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+bDqMiC+ou5ghb=XB3Oyjw3p-GTDvNw4NkkQqQthw1yuQ@mail.gmail.com>
 <mhng-02b88d43-ede8-48f9-82f1-c84201acb7a8@palmerdabbelt-glaptop>
 <CACT4Y+aN3LvgaBc_zmW=t=D7ChU-jrWYnjt5sZ2GEDQhg_BC9A@mail.gmail.com>
 <CACT4Y+aC19DaNOm87EO3cER2=MEmO9pmtUxzVmRtg9YhZKuMVA@mail.gmail.com>
 <20210118145310.crnqnh6kax5jqicj@distanz.ch> <CACT4Y+bFV6m1LCYb1nO7ioKJK99916D76sJ+H-LgBjWx6biF5w@mail.gmail.com>
In-Reply-To: <CACT4Y+bFV6m1LCYb1nO7ioKJK99916D76sJ+H-LgBjWx6biF5w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 18 Jan 2021 16:43:25 +0100
Message-ID: <CACT4Y+bmDKNnykeTP9yKjje3XZjbXY3De+_e3fMFOMoe0dnARw@mail.gmail.com>
Subject: Re: riscv+KASAN does not boot
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, nylon7@andestech.com,
        Bjorn Topel <bjorn.topel@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 4:05 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Jan 18, 2021 at 3:53 PM Tobias Klauser <tklauser@distanz.ch> wrote:
> > > > On Thu, Jan 14, 2021 at 5:57 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
> > > > >
> > > > > On Fri, 25 Dec 2020 09:13:23 PST (-0800), dvyukov@google.com wrote:
> > > > > > On Fri, Dec 25, 2020 at 5:58 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> > > > > >>
> > > > > >> On Dez 25 2020, Dmitry Vyukov wrote:
> > > > > >>
> > > > > >> > qemu-system-riscv64 \
> > > > > >> > -machine virt -bios default -smp 1 -m 2G \
> > > > > >> > -device virtio-blk-device,drive=hd0 \
> > > > > >> > -drive file=buildroot-riscv64.ext4,if=none,format=raw,id=hd0 \
> > > > > >> > -kernel arch/riscv/boot/Image \
> > > > > >> > -nographic \
> > > > > >> > -device virtio-rng-device,rng=rng0 -object
> > > > > >> > rng-random,filename=/dev/urandom,id=rng0 \
> > > > > >> > -netdev user,id=net0,host=10.0.2.10,hostfwd=tcp::10022-:22 -device
> > > > > >> > virtio-net-device,netdev=net0 \
> > > > > >> > -append "root=/dev/vda earlyprintk=serial console=ttyS0 oops=panic
> > > > > >> > panic_on_warn=1 panic=86400"
> > > > > >>
> > > > > >> Do you get more output with earlycon=sbi?
> > > > > >
> > > > > > Hi Andreas,
> > > > > >
> > > > > > For defconfig+kvm_guest.config+ scripts/config -e KASAN -e
> > > > > > KASAN_INLINE it actually gave me more output:
> > > > > >
> > > > > >
> > > > > > OpenSBI v0.7
> > > > > >    ____                    _____ ____ _____
> > > > > >   / __ \                  / ____|  _ \_   _|
> > > > > >  | |  | |_ __   ___ _ __ | (___ | |_) || |
> > > > > >  | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
> > > > > >  | |__| | |_) |  __/ | | |____) | |_) || |_
> > > > > >   \____/| .__/ \___|_| |_|_____/|____/_____|
> > > > > >         | |
> > > > > >         |_|
> > > > > >
> > > > > > Platform Name          : QEMU Virt Machine
> > > > > > Platform HART Features : RV64ACDFIMSU
> > > > > > Current Hart           : 0
> > > > > > Firmware Base          : 0x80000000
> > > > > > Firmware Size          : 132 KB
> > > > > > Runtime SBI Version    : 0.2
> > > > > >
> > > > > > MIDELEG : 0x0000000000000222
> > > > > > MEDELEG : 0x000000000000b109
> > > > > > PMP0    : 0x0000000080000000-0x000000008003ffff (A)
> > > > > > PMP1    : 0x0000000000000000-0xffffffffffffffff (A,R,W,X)
> > > > > > [    0.000000] Linux version 5.10.0-01370-g71c5f03154ac
> > > > > > (dvyukov@dvyukov-desk.muc.corp.google.com) (riscv64-linux-gnu-gcc
> > > > > > (Debian 10.2.0-9) 10.2.0, GNU ld (GNU Binutils for Debian) 2.35.1) #17
> > > > > > SMP Fri Dec 25 18:10:12 CET 2020
> > > > > > [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
> > > > > > [    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
> > > > > > [    0.000000] printk: bootconsole [sbi0] enabled
> > > > > > [    0.000000] efi: UEFI not found.
> > > > > > [    0.000000] Zone ranges:
> > > > > > [    0.000000]   DMA32    [mem 0x0000000080200000-0x00000000ffffffff]
> > > > > > [    0.000000]   Normal   empty
> > > > > > [    0.000000] Movable zone start for each node
> > > > > > [    0.000000] Early memory node ranges
> > > > > > [    0.000000]   node   0: [mem 0x0000000080200000-0x00000000ffffffff]
> > > > > > [    0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x00000000ffffffff]
> > > > > > [    0.000000] SBI specification v0.2 detected
> > > > > > [    0.000000] SBI implementation ID=0x1 Version=0x7
> > > > > > [    0.000000] SBI v0.2 TIME extension detected
> > > > > > [    0.000000] SBI v0.2 IPI extension detected
> > > > > > [    0.000000] SBI v0.2 RFENCE extension detected
> > > > > > [    0.000000] software IO TLB: mapped [mem
> > > > > > 0x00000000fa3f9000-0x00000000fe3f9000] (64MB)
> > > > > > [    0.000000] Unable to handle kernel paging request at virtual
> > > > > > address dfffffc810040000
> > > > > > [    0.000000] Oops [#1]
> > > > > > [    0.000000] Modules linked in:
> > > > > > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> > > > > > 5.10.0-01370-g71c5f03154ac #17
> > > > > > [    0.000000] epc: ffffffe00042e3e4 ra : ffffffe000c0462c sp : ffffffe001603ea0
> > > > > > [    0.000000]  gp : ffffffe0016e3c60 tp : ffffffe00160cd40 t0 :
> > > > > > dfffffc810040000
> > > > > > [    0.000000]  t1 : ffffffe000e0a838 t2 : 0000000000000000 s0 :
> > > > > > ffffffe001603f50
> > > > > > [    0.000000]  s1 : ffffffe0016e50a8 a0 : dfffffc810040000 a1 :
> > > > > > 0000000000000000
> > > > > > [    0.000000]  a2 : 000000000ffc0000 a3 : dfffffc820000000 a4 :
> > > > > > 0000000000000000
> > > > > > [    0.000000]  a5 : 000000003e8c6001 a6 : ffffffe000e0a820 a7 :
> > > > > > 0000000000000900
> > > > > > [    0.000000]  s2 : dfffffc820000000 s3 : dfffffc800000000 s4 :
> > > > > > 0000000000000001
> > > > > > [    0.000000]  s5 : ffffffe0016e5108 s6 : fffffffffffff000 s7 :
> > > > > > dfffffc810040000
> > > > > > [    0.000000]  s8 : 0000000000000080 s9 : ffffffffffffffff s10:
> > > > > > ffffffe07a119000
> > > > > > [    0.000000]  s11: 000000000000ffc0 t3 : ffffffe0016eb908 t4 :
> > > > > > 0000000000000001
> > > > > > [    0.000000]  t5 : ffffffc4001c150a t6 : ffffffe001603be8
> > > > > > [    0.000000] status: 0000000000000100 badaddr: dfffffc810040000
> > > > > > cause: 000000000000000f
> > > > > > [    0.000000] random: get_random_bytes called from
> > > > > > oops_exit+0x30/0x58 with crng_init=0
> > > > > > [    0.000000] ---[ end trace 0000000000000000 ]---
> > > > > > [    0.000000] Kernel panic - not syncing: Fatal exception
> > > > > > [    0.000000] ---[ end Kernel panic - not syncing: Fatal exception ]---
> > > > > >
> > > > > >
> > > > > > But I first tried with a the kernel image I had in the dir, I think it
> > > > > > was this config (no KASAN):
> > > > > > https://gist.githubusercontent.com/dvyukov/b2b62beccf80493781ab03b41430e616/raw/62e673cff08a8a41656d2871b8a37f74b00f509f/gistfile1.txt
> > > > > >
> > > > > > and earlycon=sbi did not change anything (no output after OpenSBI).
> > > > > > So potentially there are 2 different problems.
> > > > >
> > > > > Thanks for reporting this.  Looks like I'd forgotten to add a kasan config to
> > > > > my tests.  There's one in there now, and it's passing as of the fix that Nylon
> > > > > posted.
> > > >
> > > > I can boot the KASAN kernel now on riscv/fixes.
> > > >
> > > > Next problem: I've got only to:
> > > >
> > > > [   90.498967][    T1] Run /sbin/init as init process
> > > > [   91.164353][ T4022] init[4022]: unhandled signal 11 code 0x1 at
> > > > 0x0000000000000bb0 in busybox[10000+d7000]
> > > > [   91.179640][ T4022] CPU: 1 PID: 4022 Comm: init Not tainted
> > > > 5.11.0-rc2-00012-g0983834a8393 #19
> > > > [   91.180853][ T4022] epc: 0000000000000bb0 ra : 0000003fccab09d0 sp
> > > > : 0000003fffa8c7b0
> > > > [   91.181861][ T4022]  gp : 00000000000e8d70 tp : 0000003fccaaf820 t0
> > > > : 000000000000001e
> > > > [   91.182810][ T4022]  t1 : 0000003fccab0bfc t2 : 000000000000000a s0
> > > > : 0000003fffa8c850
> > > > [   91.183749][ T4022]  s1 : 0000003fccab1070 a0 : 0000003fccab1070 a1
> > > > : 0000003fffa8c8c8
> > > > [   91.184689][ T4022]  a2 : 0000000000000001 a3 : 0000000000000020 a4
> > > > : 0000000000000000
> > > > [   91.185620][ T4022]  a5 : 0000000000000000 a6 : 0000003fcc9c4260 a7
> > > > : fffffffffffffffe
> > > > [   91.186566][ T4022]  s2 : 0000000000000000 s3 : 0000003fffa8c8c8 s4
> > > > : 0000003fccab1000
> > > > [   91.187500][ T4022]  s5 : 0000003fccab1078 s6 : 0000003fffa8c8d0 s7
> > > > : 0000000000000010
> > > > [   91.189672][ T4022]  s8 : 0000000000000016 s9 : 0000000000000000
> > > > s10: 0000003fffa8c8c8
> > > > [   91.190637][ T4022]  s11: 0000000000000000 t3 : 0000000000000bb0 t4
> > > > : 0000000000000000
> > > > [   91.191568][ T4022]  t5 : 0000003fffa8c360 t6 : 0000000000000000
> > > > [   91.192389][ T4022] status: 8000000000004020 badaddr:
> > > > 0000000000000bb0 cause: 000000000000000c
> > > > [   91.201573][    T1] Kernel panic - not syncing: Attempted to kill
> > > > init! exitcode=0x0000000b
> > > > [   91.202906][    T1] CPU: 0 PID: 1 Comm: init Not tainted
> > > > 5.11.0-rc2-00012-g0983834a8393 #19
> > > > [   91.204139][    T1] Call Trace:
> > > > [   91.204849][    T1] [<ffffffe0000095c0>] walk_stackframe+0x0/0x1d0
> > > > [   91.206124][    T1] [<ffffffe00458b2d8>] show_stack+0x3a/0x46
> > > > [   91.207240][    T1] [<ffffffe0045a5b72>] dump_stack+0x11c/0x180
> > > > [   91.208732][    T1] [<ffffffe00458b6a0>] panic+0x20a/0x5cc
> > > > [   91.209890][    T1] [<ffffffe00002eea4>] do_exit+0x1846/0x1874
> > > > [   91.211052][    T1] [<ffffffe00002efdc>] do_group_exit+0xa0/0x192
> > > > [   91.212224][    T1] [<ffffffe000047d30>] get_signal+0x2d6/0x13dc
> > > > [   91.213390][    T1] [<ffffffe000007eb0>] do_notify_resume+0xa8/0x912
> > > > [   91.214567][    T1] [<ffffffe00000559c>] ret_from_exception+0x0/0x14
> > > >
> > > > The image is buildroot on 2020.11.x built with this script:
> > > > https://gist.githubusercontent.com/dvyukov/1a9a01ca2189e35175a021820c95b04d/raw/5c01d755e83f4eab0d56aa7dc84af3b2d5e80423/gistfile1.txt
> > > >
> > > > Readelf for init shows the following (is it that [10000+d7000] address
> > > > is not .text at all?):
> > > >
> > > > $ riscv64-linux-gnu-readelf --sections image/bin/busybox
> > > > There are 27 section headers, starting at offset 0xd7f20:
> > > >
> > > > Section Headers:
> > > >   [Nr] Name              Type             Address           Offset
> > > >        Size              EntSize          Flags  Link  Info  Align
> > > >   [ 0]                   NULL             0000000000000000  00000000
> > > >        0000000000000000  0000000000000000           0     0     0
> > > >   [ 1] .interp           PROGBITS         0000000000010238  00000238
> > > >        0000000000000021  0000000000000000   A       0     0     1
> > > >   [ 2] .note.ABI-tag     NOTE             000000000001025c  0000025c
> > > >        0000000000000020  0000000000000000   A       0     0     4
> > > >   [ 3] .hash             HASH             0000000000010280  00000280
> > > >        00000000000009cc  0000000000000004   A       5     0     8
> > > >   [ 4] .gnu.hash         GNU_HASH         0000000000010c50  00000c50
> > > >        0000000000000ac8  0000000000000000   A       5     0     8
> > > >   [ 5] .dynsym           DYNSYM           0000000000011718  00001718
> > > >        00000000000021f0  0000000000000018   A       6     1     8
> > > >   [ 6] .dynstr           STRTAB           0000000000013908  00003908
> > > >        0000000000000c66  0000000000000000   A       0     0     1
> > > >   [ 7] .gnu.version      VERSYM           000000000001456e  0000456e
> > > >        00000000000002d4  0000000000000002   A       5     0     2
> > > >   [ 8] .gnu.version_r    VERNEED          0000000000014848  00004848
> > > >        0000000000000050  0000000000000000   A       6     2     8
> > > >   [ 9] .rela.dyn         RELA             0000000000014898  00004898
> > > >        00000000000000c0  0000000000000018   A       5     0     8
> > > >   [10] .rela.plt         RELA             0000000000014958  00004958
> > > >        00000000000020a0  0000000000000018  AI       5    22     8
> > > >   [11] .plt              PROGBITS         0000000000016a00  00006a00
> > > >        00000000000015e0  0000000000000010  AX       0     0     16
> > > >   [12] .text             PROGBITS         0000000000017fe0  00007fe0
> > > >        00000000000a3668  0000000000000000  AX       0     0     4
> > > >   [13] .rodata           PROGBITS         00000000000bb648  000ab648
> > > >        000000000002b076  0000000000000000   A       0     0     8
> > > >   [14] .sdata2           PROGBITS         00000000000e66c0  000d66c0
> > > >        0000000000000163  0000000000000000   A       0     0     8
> > > >   [15] .eh_frame_hdr     PROGBITS         00000000000e6824  000d6824
> > > >        0000000000000014  0000000000000000   A       0     0     4
> > > >   [16] .eh_frame         PROGBITS         00000000000e6838  000d6838
> > > >        000000000000002c  0000000000000000   A       0     0     8
> > > >   [17] .preinit_array    PREINIT_ARRAY    00000000000e7df8  000d6df8
> > > >        0000000000000008  0000000000000008  WA       0     0     1
> > > >   [18] .init_array       INIT_ARRAY       00000000000e7e00  000d6e00
> > > >        0000000000000008  0000000000000008  WA       0     0     8
> > > >   [19] .fini_array       FINI_ARRAY       00000000000e7e08  000d6e08
> > > >        0000000000000008  0000000000000008  WA       0     0     8
> > > >   [20] .dynamic          DYNAMIC          00000000000e7e10  000d6e10
> > > >        00000000000001f0  0000000000000010  WA       6     0     8
> > > >   [21] .data             PROGBITS         00000000000e8000  000d7000
> > > >        0000000000000240  0000000000000000  WA       0     0     8
> > > >   [22] .got              PROGBITS         00000000000e8240  000d7240
> > > >        0000000000000af8  0000000000000008  WA       0     0     8
> > > >   [23] .sdata            PROGBITS         00000000000e8d38  000d7d38
> > > >        0000000000000101  0000000000000000  WA       0     0     8
> > > >   [24] .sbss             NOBITS           00000000000e8e40  000d7e39
> > > >        000000000000017f  0000000000000000  WA       0     0     8
> > > >   [25] .bss              NOBITS           00000000000e8fc0  000d7e39
> > > >        00000000000005b0  0000000000000000  WA       0     0     8
> > > >   [26] .shstrtab         STRTAB           0000000000000000  000d7e39
> > > >        00000000000000e6  0000000000000000           0     0     1
> > > >
> > > >
> > > > Before I spent more time on this, am I doing anything obviously wrong?
> > > > Is it a known issue? Are there any fresh working recipes?
> > >
> > > Humm.. I tried to use 2020.05 which Tobias used here:
> > > https://github.com/google/syzkaller/blob/master/docs/linux/setup_linux-host_qemu-vm_riscv64-kernel.md#image
> > > But there is no make qemu_riscv64_virt_defconfig target... though I
> > > remember I tested these instructions at the time...
> >
> > Weird. `make qemu_riscv64_virt_defconfig` works here on buildroot
> > 202.05, 2020.11.1 and on latest master.
> >
> > Do you see these in your configs/ directory?
> >
> > $ ls -l configs/qemu_riscv*
> > -rw-rw-r-- 1 tklauser tklauser 673 Jan 18 15:51 configs/qemu_riscv32_virt_defconfig
> > -rw-rw-r-- 1 tklauser tklauser 682 Jan 18 15:51 configs/qemu_riscv64_virt_defconfig
>
> Oh, turned out I previously checked out 2011.05 somehow...
> Yes, 2020.05 has qemu_riscv64_virt_defconfig and I am building it now.
> 2020.11 has the config, but init crashes (see above).


2020.05 is a bit better, but still failed in several ways.
First, a number of user-space services including sshd still crashed.
Second, kernel also crashed a bit later.
And 2020.11 seems to regress even more.
It's with the same kernel from the previous email (I did not rebuilt it).


2020.05 buildroot:
[   90.381218][    T1] devtmpfs: mounted
[   90.534531][    T1] Freeing unused kernel memory: 2328K
[   90.537085][    T1] Run /sbin/init as init process
[   91.754610][ T4022] EXT4-fs (vda): re-mounted. Opts: (null). Quota
mode: none.
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   99.413418][ T4051] udevd[4051]:
starting version 3.2.9
[  100.480500][ T4052] udevd[4052]: starting eudev-3.2.9
[  101.904876][ T4052] udevd[4052]: unhandled signal 11 code 0x1 at
0x0000000000000bb0 in udevd[10000+35000]
[  101.911401][ T4052] CPU: 1 PID: 4052 Comm: udevd Not tainted
5.11.0-rc2-00012-g0983834a8393 #19
[  101.913136][ T4052] epc: 0000000000000bb0 ra : 0000003ff5921872 sp
: 0000003fffb0c3a0
[  101.914593][ T4052]  gp : 000000000004f908 tp : 0000003ff552b720 t0
: 0000003ff5943160
[  101.915740][ T4052]  t1 : 0000003ff5921bec t2 : 000000000004f450 s0
: 0000003fffb0c440
[  101.916872][ T4052]  s1 : 0000003ff5922000 a0 : 0000003ff5922000 a1
: 0000003fffb0c460
[  101.949318][ T4052]  a2 : 0000000000000001 a3 : 0000000000000002 a4
: 0000000000000002
[  101.950529][ T4052]  a5 : 000000000000000f a6 : 0000000000000007 a7
: 0000000000000016
[  101.951653][ T4052]  s2 : 0000000000000001 s3 : 0000003fffb0c460 s4
: 0000003ff5922030
[  101.952771][ T4052]  s5 : 0000003ff5922010 s6 : 0000000000000000 s7
: 0000000000000000
[  101.953878][ T4052]  s8 : 0000003ff5922004 s9 : 0000003ff5922010
s10: 0000003ff5922008
[  101.955016][ T4052]  s11: 0000003ff5922038 t3 : 0000000000000bb0 t4
: 0000000000000002
[  101.956122][ T4052]  t5 : 0000000000000002 t6 : 0000000000003d40
[  101.957072][ T4052] status: 8000000000004020 badaddr:
0000000000000bb0 cause: 000000000000000c
[  154.349233][ T4055] udevadm[4055]: unhandled signal 11 code 0x1 at
0x0000000000000bb0 in udevadm[10000+38000]
[  154.351201][ T4055] CPU: 0 PID: 4055 Comm: udevadm Not tainted
5.11.0-rc2-00012-g0983834a8393 #19
[  154.352227][ T4055] epc: 0000000000000bb0 ra : 0000003ff2cd3872 sp
: 0000003fffe26a50
[  154.353136][ T4055]  gp : 0000000000052808 tp : 0000003ff28dd720 t0
: 0000003ff2cf5160
[  154.354047][ T4055]  t1 : 0000003ff2cd3bec t2 : 0000000000052570 s0
: 0000003fffe26af0
[  154.354957][ T4055]  s1 : 0000003ff2cd4000 a0 : 0000003ff2cd4000 a1
: 0000003fffe26b10
[  154.355860][ T4055]  a2 : 000000000003d790 a3 : 0000000000000002 a4
: 0000000000000002
[  154.356739][ T4055]  a5 : 000000000000000f a6 : ffffffffffffffff a7
: 0000000000000000
[  154.366998][ T4055]  s2 : 0000000000000001 s3 : 0000003fffe26b10 s4
: 0000003ff2cd4030
[  154.372223][ T4055]  s5 : 0000003ff2cd4010 s6 : 0000000000000068 s7
: 000000000003d000
[  154.373192][ T4055]  s8 : 0000003ff2cd4004 s9 : 0000003ff2cd4010
s10: 0000003ff2cd4008
[  154.374114][ T4055]  s11: 0000003ff2cd4038 t3 : 0000000000000bb0 t4
: 0000000000000002
[  154.375023][ T4055]  t5 : 0000000000000002 t6 : 0000000000003d40
[  154.375793][ T4055] status: 0000000000004020 badaddr:
0000000000000bb0 cause: 000000000000000c
Segmentation fault
udevadm settle failed
done
Saving random seed: OK
Starting network: [  160.769276][ T4073] 8021q: adding VLAN 0 to HW
filter on device eth0
udhcpc: started, v1.31.1
[  161.642968][ T4074] udhcpc[4074]: unhandled signal 11 code 0x1 at
0x0000000000000bb0 in busybox[10000+d6000]
[  161.645275][ T4074] CPU: 0 PID: 4074 Comm: udhcpc Not tainted
5.11.0-rc2-00012-g0983834a8393 #19
[  161.646515][ T4074] epc: 0000000000000bb0 ra : 0000003fd4d43872 sp
: 0000003fffedf5c0
[  161.661669][ T4074]  gp : 00000000000e7c90 tp : 0000003fd4d42820 t0
: 0000003fd4d65160
[  161.662875][ T4074]  t1 : 0000003fd4d43bec t2 : 00000000000e7960 s0
: 0000003fffedf660
[  161.663979][ T4074]  s1 : 0000003fd4d44000 a0 : 0000003fd4d44000 a1
: 0000003fffedf690
[  161.665110][ T4074]  a2 : 0000000000000019 a3 : 0000000000000002 a4
: 0000000000000002
[  161.666351][ T4074]  a5 : 000000000000000f a6 : fefefefefefefeff a7
: 0000000000000040
[  161.668642][ T4074]  s2 : 0000000000000001 s3 : 0000003fffedf690 s4
: 0000003fd4d44030
[  161.669785][ T4074]  s5 : 0000003fd4d44010 s6 : 00000000149d82c3 s7
: 00000000000000fe
[  161.670921][ T4074]  s8 : 0000003fd4d44004 s9 : 0000003fd4d44010
s10: 0000003fd4d44008
[  161.672150][ T4074]  s11: 0000003fd4d44038 t3 : 0000000000000bb0 t4
: 0000000000000002
[  161.673355][ T4074]  t5 : 0000000000000002 t6 : 0000000000003d40
[  161.674303][ T4074] status: 8000000000004020 badaddr:
0000000000000bb0 cause: 000000000000000c
FAIL
Starting dhcpcd...
[  162.771471][ T4077] dhcpcd[4077]: unhandled signal 11 code 0x1 at
0x0000000000000bb0 in dhcpcd[10000+39000]
[  162.773414][ T4077] CPU: 0 PID: 4077 Comm: dhcpcd Not tainted
5.11.0-rc2-00012-g0983834a8393 #19
[  162.774462][ T4077] epc: 0000000000000bb0 ra : 0000003fe6d12872 sp
: 0000003fff8527e0
[  162.775366][ T4077]  gp : 000000000004adb8 tp : 0000003fe6d11250 t0
: 0000003fe6d34160
[  162.776274][ T4077]  t1 : 0000003fe6d12bec t2 : 0000000000049a00 s0
: 0000003fff852880
[  162.777167][ T4077]  s1 : 0000003fe6d13000 a0 : 0000003fe6d13000 a1
: 0000003fff8528a0
[  162.779363][ T4077]  a2 : 0000000000000004 a3 : 0000000000000002 a4
: 0000000000000002
[  162.780279][ T4077]  a5 : 000000000000000f a6 : 7efefefefefefeff a7
: fffffffffffff000
[  162.781194][ T4077]  s2 : 0000000000000001 s3 : 0000003fff8528a0 s4
: 0000003fe6d13030
[  162.782106][ T4077]  s5 : 0000003fe6d13010 s6 : 0000000000000000 s7
: 0000000000000000
[  162.783015][ T4077]  s8 : 0000003fe6d13004 s9 : 0000003fe6d13010
s10: 0000003fe6d13008
[  162.783940][ T4077]  s11: 0000003fe6d13038 t3 : 0000000000000bb0 t4
: 0000000000000002
[  162.784853][ T4077]  t5 : 0000000000000002 t6 : 0000000000003d40
[  162.785618][ T4077] status: 8000000000006020 badaddr:
0000000000000bb0 cause: 000000000000000c
Segmentation fault
[  164.074891][ T4079] ssh-keygen[4079]: unhandled signal 11 code 0x1
at 0x0000000000000bb0 in ssh-keygen[2ac3c68000+63000]
[  164.076916][ T4079] CPU: 1 PID: 4079 Comm: ssh-keygen Not tainted
5.11.0-rc2-00012-g0983834a8393 #19
[  164.096635][ T4079] epc: 0000000000000bb0 ra : 0000003ff6899872 sp
: 0000003fffed1330
[  164.099233][ T4079]  gp : 0000002ac3ccd448 tp : 0000003ff6435cd0 t0
: 0000003ff6897000
[  164.100457][ T4079]  t1 : 0000003ff6899bec t2 : 0000003ff6891940 s0
: 0000003fffed13d0
[  164.101578][ T4079]  s1 : 0000003ff689a000 a0 : 0000003ff689a000 a1
: 0000003fffed13f8
[  164.102914][ T4079]  a2 : 0000000000000000 a3 : 0000000000000001 a4
: 0000000000000001
[  164.104058][ T4079]  a5 : 000000000000000f a6 : 0000000000000000 a7
: 00000000000000ac
[  164.105150][ T4079]  s2 : 0000000000000000 s3 : 0000003fffed13f8 s4
: 0000003ff689a020
[  164.106241][ T4079]  s5 : 0000003ff689a000 s6 : 0000003fd1861830 s7
: ffffffffffffffff
[  164.113694][ T4079]  s8 : 0000003ff689a004 s9 : 0000003ff689a010
s10: 0000003ff689a008
[  164.114869][ T4079]  s11: 0000003ff689a028 t3 : 0000000000000bb0 t4
: 0000000000000002
[  164.115972][ T4079]  t5 : 0000000000000002 t6 : 0000000000003d40
[  164.128360][ T4079] status: 8000000000004020 badaddr:
0000000000000bb0 cause: 000000000000000c
Segmentation fault
Starting sshd: [  164.872315][ T4080] sshd[4080]: unhandled signal 11
code 0x1 at 0x0000000000000bb0 in sshd[2ac7ea7000+a4000]
[  164.874297][ T4080] CPU: 1 PID: 4080 Comm: sshd Not tainted
5.11.0-rc2-00012-g0983834a8393 #19
[  164.875331][ T4080] epc: 0000000000000bb0 ra : 0000003ff2222872 sp
: 0000003fffbea300
[  164.876230][ T4080]  gp : 0000002ac7f4f9d0 tp : 0000003ff1dbecd0 t0
: 0000003ff2220000
[  164.877146][ T4080]  t1 : 0000003ff2222bec t2 : 0000003ff221a940 s0
: 0000003fffbea3a0
[  164.892174][ T4080]  s1 : 0000003ff2223000 a0 : 0000003ff2223000 a1
: 0000003fffbea3c8
[  164.893137][ T4080]  a2 : 0000000000000000 a3 : 0000000000000001 a4
: 0000000000000001
[  164.894065][ T4080]  a5 : 000000000000000f a6 : 0000000000000000 a7
: 00000000000000ac
[  164.895013][ T4080]  s2 : 0000000000000000 s3 : 0000003fffbea3c8 s4
: 0000003ff2223020
[  164.895947][ T4080]  s5 : 0000003ff2223000 s6 : 0000003fd1861830 s7
: ffffffffffffffff
[  164.896881][ T4080]  s8 : 0000003ff2223004 s9 : 0000003ff2223010
s10: 0000003ff2223008
[  164.905684][ T4080]  s11: 0000003ff2223028 t3 : 0000000000000bb0 t4
: 0000000000000002
[  164.906679][ T4080]  t5 : 0000000000000002 t6 : 0000000000003d40
[  164.908565][ T4080] status: 8000000000004020 badaddr:
0000000000000bb0 cause: 000000000000000c
Segmentation fault
OK
syzkaller
syzkaller login: [  167.973016][ T4082] ------------[ cut here ]------------
[  167.975887][ T4082] virt_to_phys used for non-linear address:
0000000059ffc026 (0xffffffd0158d105e)
[  167.979939][ T4082] WARNING: CPU: 0 PID: 4082 at
arch/riscv/mm/physaddr.c:16 __virt_to_phys+0x74/0x78
[  167.988658][ T4082] Modules linked in:
[  167.989781][ T4082] CPU: 0 PID: 4082 Comm: getty Not tainted
5.11.0-rc2-00012-g0983834a8393 #19
[  167.991063][ T4082] epc: ffffffe000011164 ra : ffffffe000011164 sp
: ffffffe01354fb10
[  167.992243][ T4082]  gp : ffffffe006234420 tp : ffffffe009c8ad80 t0
: ffffffe006cafb67
[  167.993384][ T4082]  t1 : 0000000000000001 t2 : 0000000000000000 s0
: ffffffe01354fb40
[  167.994531][ T4082]  s1 : fffffff0158d105e a0 : 000000000000004f a1
: 00000000000f0000
[  167.995690][ T4082]  a2 : 0000000000000002 a3 : ffffffe0000d1a30 a4
: 763e2d90a60ec500
[  167.996803][ T4082]  a5 : 763e2d90a60ec500 a6 : 0000000000f00000 a7
: ffffffe00009481c
[  167.999690][ T4082]  s2 : ffffffd0158d105e s3 : 0000001fffffffff s4
: 0000000000000001
[  168.000898][ T4082]  s5 : ffffffd0158d105f s6 : ffffffd0158d3260 s7
: 0000003fff81eac8
[  168.002093][ T4082]  s8 : ffffffd0158d105e s9 : 0000000000000001
s10: 0000000000000000
[  168.003226][ T4082]  s11: 0000000000000000 t3 : 763e2d90a60ec500 t4
: ffffffc4026a9efd
[  168.004361][ T4082]  t5 : ffffffc4026a9eff t6 : ffffffe01354f7f8
[  168.005328][ T4082] status: 0000000000000120 badaddr:
0000000000000000 cause: 0000000000000003
[  168.006756][ T4082] Kernel panic - not syncing: panic_on_warn set ...
[  168.008056][ T4082] CPU: 0 PID: 4082 Comm: getty Not tainted
5.11.0-rc2-00012-g0983834a8393 #19
[  168.009301][ T4082] Call Trace:
[  168.009969][ T4082] [<ffffffe0000095c0>] walk_stackframe+0x0/0x1d0
[  168.011166][ T4082] [<ffffffe00458b2d8>] show_stack+0x3a/0x46
[  168.012215][ T4082] [<ffffffe0045a5b72>] dump_stack+0x11c/0x180
[  168.013262][ T4082] [<ffffffe00458b6a0>] panic+0x20a/0x5cc
[  168.014264][ T4082] [<ffffffe000024210>] __warn+0x110/0x20a
[  168.015285][ T4082] [<ffffffe001759424>] report_bug+0x156/0x200
[  168.016324][ T4082] [<ffffffe0000093f6>] do_trap_break+0xa6/0x152
[  168.017431][ T4082] [<ffffffe00000559c>] ret_from_exception+0x0/0x14
[  168.018560][ T4082] [<ffffffe0018c97bc>] n_tty_read+0x908/0x115a
[  168.020124][ T4082] SMP: stopping secondary CPUs
[  168.022087][ T4082] Rebooting in 86400 seconds..
