Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425FD2E2BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 16:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgLYO4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 09:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgLYO4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 09:56:51 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790E6C061573
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 06:56:01 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id 22so4083123qkf.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 06:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7AlEcFriJoeYzWuqNZSt+YwH22DlPDSRTWH0OUhugF4=;
        b=iXdeLLKWI2a2tzHtP6QFBSAaYojgLd9qzejmUIDJaNWNwMgMXPp1n5dxni2oWYx8pF
         BJN7Rk6603DwyUwjiEpo+Z27P6Q2qSIWwsLc9wTTImAeuU0lKrV4bnOvKpRqsS46l29n
         XG/wIMGlR5yO1ZNLMXrlCfChFWj1LtLLYHLX5/Xg3kt3BFEwUbOkE2Elh7/EOgvvngAe
         6vjnSONKhecC/DWbx3tr4QrhbJ+PMZpFdstIUvqWUXg/+Es4sS6K3+nT2gthlZuGl/SN
         j01qHekn01kHve5HfMN9W/H1pMVjByQw40PU1PgOVXgg29ghNKBWmuLn/14HRfW2KvMU
         9l4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7AlEcFriJoeYzWuqNZSt+YwH22DlPDSRTWH0OUhugF4=;
        b=s1Lj0VlasR1xoKMiyiEPK+2rrkTinCogJtpS9ww6mC5rY3qAr7Xe//v7nRPUGZxTIs
         2VyZ/k4yx9hvd5Fw8VkEJdyn8HTWlGBE6Jq+VPkifegwJUkMDsWt5mlT1GCgL7itOFku
         FVjWiSw8skLovQeHJppLIVw4/CrtHhvSj92iM1q+tgfWWq19wjDgum/2DIEjzld1wdCv
         A5YrzYVny7DjWcrh3T86FVdnXKsZt4E3YdMXVDJDCDP7k2ioyv/iGCE3NuhaeoVMnc1E
         ScD5DIgA9EdNhAgLkk5YveIHgU+6rIXS8Rzt7OZx4gIVDlejwd6TZDAbD/MDpeuAkfdT
         88Lw==
X-Gm-Message-State: AOAM530QRLtgWesfxtQ8UHctkA36DFZAIfDennMrvwbBmbKO2X+bp8Wo
        CMG1xrC6IbB+aV9asWhBPzeHijdAXRXlaIVvi8Vm8A==
X-Google-Smtp-Source: ABdhPJwx/z89Ckw2LTXrhcFRg0wHRcqaZgoQhNhab+S61GnPyHv3wwkR4bwJShF3YjcV/1d+NwxYvDa25/sIQZMfjhk=
X-Received: by 2002:a37:9a97:: with SMTP id c145mr34583489qke.350.1608908160008;
 Fri, 25 Dec 2020 06:56:00 -0800 (PST)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 25 Dec 2020 15:55:48 +0100
Message-ID: <CACT4Y+bpkSYTL_UwNoKVd0PDFF_xrNN6=y_S_v8W3YRaAcMm2g@mail.gmail.com>
Subject: riscv+KASAN does not boot
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, nylon7@andestech.com
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        syzkaller <syzkaller@googlegroups.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am considering setting up a syzbot instance for riscv arch (using
qemu emulation) and testing kernel config/image/etc. I can boot
defconfig+kvmconfig riscv kernel, but so far I can't get a booting
CONFIG_KASAN+CONFIG+KCOV kernel.

But first of all I would like to ask if the riscv port is stable
enough at this point and if there is interest in continuous fuzzing
and receiving bugs? If there is no interest, then the rest is not
worth spending time on.
Second, what git tree/branch should be used for testing (to find bugs
sooner and get fixes faster)?
Currently it seems that riscv/fixes is the most up-to-date branch with
most fixes, is it the right one?

Re non-booting kernel problem. If I do:
defconfig+kvm_guest.config+ scripts/config -e KASAN -e KASAN_INLINE
I only see OpenSBI banner and then nothing happens (qemu consumes 100% CPU).
I've tried on v5.10, current upstream head (71c5f03154ac) and
riscv/fixes (20620d72c31e). The result is the same.

I see this recent patch from Nylon:
https://lore.kernel.org/linux-riscv/1606727599-8598-1-git-send-email-nylon7@andestech.com/
which suggests that KASAN is working for Nylon.

I am using qemu 5.1.0 as:

qemu-system-riscv64 \
-machine virt -bios default -smp 1 -m 2G \
-device virtio-blk-device,drive=hd0 \
-drive file=buildroot-riscv64.ext4,if=none,format=raw,id=hd0 \
-kernel arch/riscv/boot/Image \
-nographic \
-device virtio-rng-device,rng=rng0 -object
rng-random,filename=/dev/urandom,id=rng0 \
-netdev user,id=net0,host=10.0.2.10,hostfwd=tcp::10022-:22 -device
virtio-net-device,netdev=net0 \
-append "root=/dev/vda earlyprintk=serial console=ttyS0 oops=panic
panic_on_warn=1 panic=86400"


I've also tried this config (slightly larger than defconfig, but does
NOT include KASAN nor KCOV):
https://gist.githubusercontent.com/dvyukov/b2b62beccf80493781ab03b41430e616/raw/62e673cff08a8a41656d2871b8a37f74b00f509f/gistfile1.txt
and this is the ultimate large config that I would like to use:
https://gist.githubusercontent.com/dvyukov/2b4e621d5252dbc5a2f28802b8d71d95/raw/3ef2b8d8eda60d3acfc4bf7916ffb9e77671ed76/gistfile1.txt

Both of them hang after the OpenSBI banner in the same way.

Is it a known issue? Am I doing something wrong?

TIA
