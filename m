Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD9D2F5A19
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 06:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbhANE6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 23:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbhANE6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 23:58:38 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4B9C061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 20:57:53 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id q4so2306794plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 20:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=/Wcm0aKax4gR6NhFjoWEGWC9p/3MbruzBGU1vgbcM5U=;
        b=CWxZgMTgUkmzL6ZN9wUFdfY7iEwQqpLAkAK4FzUwJPy+9ljjL3PEl+BIy7e6QSuDqr
         dh3NvmBZpm+dsB5P97mmO1EtnCfLhylzycD+QeFPHrk91AAhu0+e7TF9+IAFY4XMOARL
         vES3cCK78qQqyyG3MBPSy7Zfbwx4XQVb9h2VzoOC9hf63P8R3OoTerkGu5Jl8wVWJL0q
         HmNqnfIEp0ulbXufnGQYVy0ONeGND7xS+eamL/T+hAT/Hx6XVAkyoEkuXIgcmwRAQoEd
         g/F/SeevVuRK7ETSRxCB8ilSRV1mgJQmX1QQameDgIhHr46OPRDyZNld/ggbPMHGtiSo
         prkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=/Wcm0aKax4gR6NhFjoWEGWC9p/3MbruzBGU1vgbcM5U=;
        b=bS0kKZgOBI6Qa1qaaOgkJDZhBNfLKQAdXrcikrpFprrxM/Enzkg6Jdqg9gBFd2AfgS
         GnHnwOQpx0gqsc+y/f9/Dnqs8/VWJ4TwZeDslcKYVx62Q98ZAQ48EMr21zJdG5N4PYb8
         E0zStTWnNNK4TnU8YUEE1d3b33WtJ8wZFLFM3Ix0TIBhj366g4ztafzEJZCwL0yUjkbJ
         bOyzN4wriTyVWJBNHfU55yEJqpG8QeecUFIxAbRJDHlFyM9WsrkyWGY16zeIijRu3diV
         FDR3XIa+oz+mi9vYtq6QwM4CAsf1G7OqksgM19qBuNiwmn4hC+pcgC9SdRM3Jnnp2lwi
         Nyew==
X-Gm-Message-State: AOAM532EzHMDjlqyR8NGgxgomW1ILMHaXJ+qSj9NpXMktwK65yDEIKMx
        BadLa4kXqG19qWV6A2GFxPG0/Q==
X-Google-Smtp-Source: ABdhPJw9pi7tf9C0lU2zQUe+F5homysC5VFoosacgnlOrtsZtct7tx8vnR1nqY4ctp9L5FdlwH0j1g==
X-Received: by 2002:a17:90a:e28a:: with SMTP id d10mr2969933pjz.77.1610600273082;
        Wed, 13 Jan 2021 20:57:53 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id np7sm4006977pjb.10.2021.01.13.20.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 20:57:51 -0800 (PST)
Date:   Wed, 13 Jan 2021 20:57:51 -0800 (PST)
X-Google-Original-Date: Wed, 13 Jan 2021 20:57:20 PST (-0800)
Subject:     Re: riscv+KASAN does not boot
In-Reply-To: <CACT4Y+bDqMiC+ou5ghb=XB3Oyjw3p-GTDvNw4NkkQqQthw1yuQ@mail.gmail.com>
CC:     schwab@linux-m68k.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, nylon7@andestech.com,
        Bjorn Topel <bjorn.topel@gmail.com>, tklauser@distanz.ch,
        syzkaller@googlegroups.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     dvyukov@google.com
Message-ID: <mhng-02b88d43-ede8-48f9-82f1-c84201acb7a8@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Dec 2020 09:13:23 PST (-0800), dvyukov@google.com wrote:
> On Fri, Dec 25, 2020 at 5:58 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>>
>> On Dez 25 2020, Dmitry Vyukov wrote:
>>
>> > qemu-system-riscv64 \
>> > -machine virt -bios default -smp 1 -m 2G \
>> > -device virtio-blk-device,drive=hd0 \
>> > -drive file=buildroot-riscv64.ext4,if=none,format=raw,id=hd0 \
>> > -kernel arch/riscv/boot/Image \
>> > -nographic \
>> > -device virtio-rng-device,rng=rng0 -object
>> > rng-random,filename=/dev/urandom,id=rng0 \
>> > -netdev user,id=net0,host=10.0.2.10,hostfwd=tcp::10022-:22 -device
>> > virtio-net-device,netdev=net0 \
>> > -append "root=/dev/vda earlyprintk=serial console=ttyS0 oops=panic
>> > panic_on_warn=1 panic=86400"
>>
>> Do you get more output with earlycon=sbi?
>
> Hi Andreas,
>
> For defconfig+kvm_guest.config+ scripts/config -e KASAN -e
> KASAN_INLINE it actually gave me more output:
>
>
> OpenSBI v0.7
>    ____                    _____ ____ _____
>   / __ \                  / ____|  _ \_   _|
>  | |  | |_ __   ___ _ __ | (___ | |_) || |
>  | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
>  | |__| | |_) |  __/ | | |____) | |_) || |_
>   \____/| .__/ \___|_| |_|_____/|____/_____|
>         | |
>         |_|
>
> Platform Name          : QEMU Virt Machine
> Platform HART Features : RV64ACDFIMSU
> Current Hart           : 0
> Firmware Base          : 0x80000000
> Firmware Size          : 132 KB
> Runtime SBI Version    : 0.2
>
> MIDELEG : 0x0000000000000222
> MEDELEG : 0x000000000000b109
> PMP0    : 0x0000000080000000-0x000000008003ffff (A)
> PMP1    : 0x0000000000000000-0xffffffffffffffff (A,R,W,X)
> [    0.000000] Linux version 5.10.0-01370-g71c5f03154ac
> (dvyukov@dvyukov-desk.muc.corp.google.com) (riscv64-linux-gnu-gcc
> (Debian 10.2.0-9) 10.2.0, GNU ld (GNU Binutils for Debian) 2.35.1) #17
> SMP Fri Dec 25 18:10:12 CET 2020
> [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
> [    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
> [    0.000000] printk: bootconsole [sbi0] enabled
> [    0.000000] efi: UEFI not found.
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000080200000-0x00000000ffffffff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000080200000-0x00000000ffffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x00000000ffffffff]
> [    0.000000] SBI specification v0.2 detected
> [    0.000000] SBI implementation ID=0x1 Version=0x7
> [    0.000000] SBI v0.2 TIME extension detected
> [    0.000000] SBI v0.2 IPI extension detected
> [    0.000000] SBI v0.2 RFENCE extension detected
> [    0.000000] software IO TLB: mapped [mem
> 0x00000000fa3f9000-0x00000000fe3f9000] (64MB)
> [    0.000000] Unable to handle kernel paging request at virtual
> address dfffffc810040000
> [    0.000000] Oops [#1]
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> 5.10.0-01370-g71c5f03154ac #17
> [    0.000000] epc: ffffffe00042e3e4 ra : ffffffe000c0462c sp : ffffffe001603ea0
> [    0.000000]  gp : ffffffe0016e3c60 tp : ffffffe00160cd40 t0 :
> dfffffc810040000
> [    0.000000]  t1 : ffffffe000e0a838 t2 : 0000000000000000 s0 :
> ffffffe001603f50
> [    0.000000]  s1 : ffffffe0016e50a8 a0 : dfffffc810040000 a1 :
> 0000000000000000
> [    0.000000]  a2 : 000000000ffc0000 a3 : dfffffc820000000 a4 :
> 0000000000000000
> [    0.000000]  a5 : 000000003e8c6001 a6 : ffffffe000e0a820 a7 :
> 0000000000000900
> [    0.000000]  s2 : dfffffc820000000 s3 : dfffffc800000000 s4 :
> 0000000000000001
> [    0.000000]  s5 : ffffffe0016e5108 s6 : fffffffffffff000 s7 :
> dfffffc810040000
> [    0.000000]  s8 : 0000000000000080 s9 : ffffffffffffffff s10:
> ffffffe07a119000
> [    0.000000]  s11: 000000000000ffc0 t3 : ffffffe0016eb908 t4 :
> 0000000000000001
> [    0.000000]  t5 : ffffffc4001c150a t6 : ffffffe001603be8
> [    0.000000] status: 0000000000000100 badaddr: dfffffc810040000
> cause: 000000000000000f
> [    0.000000] random: get_random_bytes called from
> oops_exit+0x30/0x58 with crng_init=0
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Fatal exception
> [    0.000000] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
>
> But I first tried with a the kernel image I had in the dir, I think it
> was this config (no KASAN):
> https://gist.githubusercontent.com/dvyukov/b2b62beccf80493781ab03b41430e616/raw/62e673cff08a8a41656d2871b8a37f74b00f509f/gistfile1.txt
>
> and earlycon=sbi did not change anything (no output after OpenSBI).
> So potentially there are 2 different problems.

Thanks for reporting this.  Looks like I'd forgotten to add a kasan config to
my tests.  There's one in there now, and it's passing as of the fix that Nylon
posted.
