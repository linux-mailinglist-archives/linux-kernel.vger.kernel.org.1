Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF762CF3F4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 19:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbgLDSWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 13:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgLDSWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:22:39 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF983C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 10:21:52 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b73so6775674edf.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 10:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZRVh9nEjQvUMIF508xcL3n/raN8xu3HvHHn5B7tzkG0=;
        b=EL5y9hBpj6GRCi8l2vMDH/FJOG7I547GwjN3OeZBqD9nmmw0IxEmOsLiaNfedZBxuH
         uo9dBI345APAYZYJLOY4NQd1d0GfZzxIMQv0ZKIbg8aj4tm5Ea8h2h93Pgs1qSxhgK43
         pnL56vHL4OqCk4budJq7WliGWde5V/7JnsLAfd9CH5hxrMUpfTYppRgzIWEcKA1fArrp
         x9CwcP9mn+vU+lJGNWLh3JAQikVmuQ+WDocQOfOwmAcHpQ6aG3oZ/9MUjroSge+kQmQd
         xD6rw8KRt3YvK4AEQ/i0Q1JedpG8SBPITyje4+hhxHAaIKXdCCMTn7RHEbFI51JviXbf
         g9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZRVh9nEjQvUMIF508xcL3n/raN8xu3HvHHn5B7tzkG0=;
        b=E8Vz13jvnzanj99PTIQBdeQwkoRgFIFG3DHIOQLIa6lb4jkXgSiMwOwYc3bz4dDCEV
         4R/9JXE25y0hOPNRJABc/2R9aLrl51pbIIna+EzW82ehn54Sl7kb66AwzicdOfBrbmOK
         cQVrCctK9S9SWIoMLfg80EyLxUilS3jhYAF9+RCuwjRJdA2RhVWIEN/L9furCgVqHoT3
         pAg08cE/TG/d4PbSky1gABcbGB7xwwHN8k/X2WZYZFuUYkWentizCX6HmctR1BaHaPhn
         +iItzveWWUYXUIj0J4jTVOP94VBC+LcyI0zhJV77tjHEJBicU2KxQt2CTjR7ZXFN3uZ4
         pcVA==
X-Gm-Message-State: AOAM531exU/1HwGNzimPsiA8XK4Z6DbhFYBsVr3pDy1e30rHk7r0nNqM
        Fr0wFgqj8OAViqKSw7oJ2LnL/7nez96vAlc2KwVideXwprXjQNOc
X-Google-Smtp-Source: ABdhPJxhhWwBPD60dOctXmgKnIbCBK7ZM990qyfx3XJkIdxJ4AWmvXsllEsnGRPblHC7nDFEIFiU8tWNG27BjMCSIdo=
X-Received: by 2002:aa7:da8f:: with SMTP id q15mr8747868eds.239.1607106110881;
 Fri, 04 Dec 2020 10:21:50 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 4 Dec 2020 23:51:39 +0530
Message-ID: <CA+G9fYuJF-L+qHJ3ufqD+M2w20LgeqMC0rhqv7oZagOA7iJMDg@mail.gmail.com>
Subject: BUG: KCSAN: data-race in mutex_spin_on_owner+0xef/0x1b0
To:     open list <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, lkft-triage@lists.linaro.org,
        rcu@vger.kernel.org, kasan-dev <kasan-dev@googlegroups.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        mathias.nyman@linux.intel.com, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKFT started testing KCSAN enabled kernel from the linux next tree.
Here we have found BUG: KCSAN: data-race in mutex_spin_on_owner
and several more KCSAN BUGs.

This report is from an x86_64 machine clang-11 linux next 20201201.
Since we are running for the first time we do not call this regression.

[    4.745161] usbcore: registered new interface driver cdc_ether
[    4.751281] ==================================================================
[    4.756653] usbcore: registered new interface driver net1080
[    4.752139] BUG: KCSAN: data-race in mutex_spin_on_owner+0xef/0x1b0
[    4.752139]
[    4.752139] race at unknown origin, with read to 0xffff90a80098b034
of 4 bytes by task 252 on cpu 1:
[    4.769781] usbcore: registered new interface driver cdc_subset
[    4.752139]  mutex_spin_on_owner+0xef/0x1b0
[    4.752139]  __mutex_lock+0x69d/0x820
[    4.752139]  __mutex_lock_slowpath+0x13/0x20
[    4.781657] usbcore: registered new interface driver zaurus
[    4.752139]  mutex_lock+0x9d/0xb0
[    4.752139]  ata_eh_acquire+0x2e/0x80
[    4.752139]  ata_msleep+0x91/0xa0
[    4.792317] usbcore: registered new interface driver cdc_ncm
[    4.752139]  sata_link_debounce+0x1ad/0x2f0
[    4.752139]  sata_link_resume+0x32f/0x4a0
[    4.752139]  sata_link_hardreset+0x456/0x640
[    4.802369] usbcore: registered new interface driver r8153_ecm
[    4.752139]  ahci_do_hardreset+0x177/0x230
[    4.752139]  ahci_hardreset+0x23/0x40
[    4.752139]  ata_eh_reset+0x91e/0x1bb0
[    4.810641] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.810482]  ata_eh_recover+0x79b/0x2bd0
[    4.810482]  sata_pmp_error_handler+0x7d1/0x1340
[    4.810482]  ahci_error_handler+0x7c/0xc0
[    4.819247] ehci-pci: EHCI PCI platform driver
[    4.810482]  ata_scsi_port_error_handler+0x708/0xd30
[    4.810482]  ata_scsi_error+0x128/0x160
[    4.826321] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    4.810482]  scsi_error_handler+0x26d/0x700
[    4.810482]  kthread+0x20b/0x220
[    4.836069] ohci-pci: OHCI PCI platform driver
[    4.810482]  ret_from_fork+0x22/0x30
[    4.810482]
[    4.844397] uhci_hcd: USB Universal Host Controller Interface driver
[    4.810482] Reported by Kernel Concurrency Sanitizer on:
[    4.810482] CPU: 1 PID: 252 Comm: scsi_eh_1 Not tainted
5.10.0-rc6-next-20201201 #2
[    4.810482] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[    4.855343] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    4.810482] ==================================================================

metadata:
    git_repo: https://gitlab.com/aroxell/lkft-linux-next
    target_arch: x86
    toolchain: clang-11
    git_describe: next-20201201
    kernel_version: 5.10.0-rc6
    download_url: https://builds.tuxbuild.com/1l8eiWgGMi6W4aDobjAAlOleFVl/

full test log link,
https://lkft.validation.linaro.org/scheduler/job/2002643#L831

-- 
Linaro LKFT
https://lkft.linaro.org
