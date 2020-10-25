Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE1F2984C3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 23:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420249AbgJYWks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 18:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732175AbgJYWkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 18:40:47 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D674C061755
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 15:40:47 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 77so9466440lfl.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 15:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=th2wyk0mVmRdncckKMr09Vovni8XBT6U/AHieFQ+zOk=;
        b=bxPBDnoQJ/72ucIsUdHbOZq5asxLpO81lrRGP310UX0OD3xZStPU6ius5Z4swxDrHL
         TEr7m2VszfEyV3BaRqSbREUQ96WBxKs94fyUB+fpvSx6nMR13g50sAbWZRCb/mzAtG6R
         6x0MRZDdQ0JLi6M77cIO6ArepT4cQMcLardV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=th2wyk0mVmRdncckKMr09Vovni8XBT6U/AHieFQ+zOk=;
        b=i5A8K5l1czQRNqa2HFIENyZVKMmCh3Yu6iMeVsJq8Wk3RjAnPfkzv/Bf/pI1iCeiM7
         AWKur3UFGW44yhutV6qQYJbDnK+eWUa4utogUfhavHPaMWhiFqxet9apMHeBvwVpsP5N
         21IeEdMv6oN8BWNGv/MZd7HzmcqLszIGFiBJJNEPAMfCMFFJPEwv1hlmu7uRBQl8L8JT
         qkW8KyJaOdV0xiHzA1udAHiqJ5tAszLpfKC9xvfEq41lnu2lKwlMXHbnlc391AWYnGAS
         +XEa+nUjD6vquRIb5SvOkCBkKsiDrNeffNzG/sEwMa+8zjWCw/IEWxuYUitZC2PGfpZi
         jXig==
X-Gm-Message-State: AOAM533tKMN6/nN7yE1TYCjcM1PdFU9zD8iNK8szMvRTci1aGn2zJQ17
        6/kY0dBXu0ov9pGfRDL0Dk0G0daDiRSWtQ==
X-Google-Smtp-Source: ABdhPJydkqAB8Ml3J5Y7VZm1r7b6vHnxYyn/tv3n26nFw03UZ+rTTHItSBQUBt7PgsaFj4lgEFxB6g==
X-Received: by 2002:ac2:58f6:: with SMTP id v22mr4398950lfo.431.1603665645425;
        Sun, 25 Oct 2020 15:40:45 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 26sm939227ljg.30.2020.10.25.15.40.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2020 15:40:44 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id a7so9427857lfk.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 15:40:44 -0700 (PDT)
X-Received: by 2002:a19:c703:: with SMTP id x3mr3707047lff.105.1603665644004;
 Sun, 25 Oct 2020 15:40:44 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Oct 2020 15:40:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whcRFYSm0jj3Xh3xCyBaxCHA1ZMNO0h_gZso_WZFDUtiQ@mail.gmail.com>
Message-ID: <CAHk-=whcRFYSm0jj3Xh3xCyBaxCHA1ZMNO0h_gZso_WZFDUtiQ@mail.gmail.com>
Subject: Linux 5.10-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two weeks have passed, and the merge window is over. I've tagged and
pushed out 5.10-rc1, and everything looks fairly normal.

This looks to be a bigger release than I expected, and while the merge
window is smaller than the one for 5.8 was, it's not a *lot* smaller.
And 5.8 was our biggest release ever.

I'm not entirely sure whether this is just a general upward trend (we
did seem to plateau for a while there), or just a fluke, or perhaps
due to 5.9 dragging out an extra week. We will see, I guess.

That said, things seem to have gone fairly smoothly. I don't see any
huge red flags, and the merge window didn't cause any unusual issues
for me. Famous last words..

The most interesting - to me - change here is Christoph's setf_fs()
removal (it got merged through Al Viro, as you can see in my mergelog
below).  It's not a _huge_ change, but it's interesting because the
whole model of set_fs() to specify whether a userspace copy actually
goes to user space or kernel space goes back to pretty much the
original release of Linux, and while the name is entirely historic (it
hasn't used the %fs segment register in a long time), the concept has
remained. Until now.

We still do have "set_fs()" around, and not every architecture has
been converted to the new world order, but x86, powerpc, s390 and
RISC-V have had the address space overrides removed, and all the core
work is done. Other architectures will hopefully get converted away
from that very historic model too, but it might take a while to get
rid of it all.

Anyway, to most people that all shouldn't matter at all, and it's
mainly a small historical footnote that 5.10 no longer relies on the
whole set_fs() model. Most of the actual changes are - as usual -
driver updates, but there are changes all over. I think the merge log
below gives some kind of flavor of what's been going on on a high
level, but if you're interested in the details go look at the git
tree. As mentioned, it's a big merge window, with  almost 14k commits
(*) by closer to 1700 people.

Please go test,

                  Linus

(*) closer to 15k commits if you count merges.

---

Al Viro (6):
    copy_and_csum cleanups
    compat iovec cleanups
    compat quotactl cleanups
    compat mount cleanups
    initial set_fs() removal
    misc vfs updates

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (1):
    RTC updates

Andreas Gruenbacher (1):
    gfs2 updates

Andrew Morton (3):
    misc updates
    more updates
    yet more updates

Anna Schumaker (1):
    NFS client updates

Arnaldo Carvalho de Melo (1):
    perf tools updates

Benson Leung (1):
    chrome platform updates

Bjorn Andersson (2):
    remoteproc updates
    rpmsg updates

Bjorn Helgaas (1):
    PCI updates

Boris Brezillon (1):
    i3c updates

Borislav Petkov (14):
    EDAC updates
    RAS updates
    x86 cpu updates
    x86 platform updates
    x86 PASID updates
    x86 fsgsbase updates
    x86 fpu updates
    x86 cleanups
    x86 cache resource control updates
    x86 fix
    x86 fixes
    x86 asm updates
    x86 SEV-ES support
    x86 SEV-ES fixes

Bruce Fields (1):
    nfsd updates

Casey Schaufler (1):
    smack updates

Christian Brauner (2):
    kernel_clone() updates
    pidfd updates

Christoph Hellwig (3):
    dma-mapping updates
    configfs updates
    dma-mapping fixes

Corey Minyard (1):
    IPMI updates

Damien Le Moal (1):
    zonefs updates

Daniel Lezcano (1):
    thermal updates

Daniel Thompson (1):
    kgdb updates

Darrick Wong (5):
    iomap updates
    xfs updates
    more xfs updates
    clone/dedupe/remap code refactoring
    xfs fixes

Dave Airlie (3):
    drm updates
    drm fixes
    more drm fixes

David Howells (1):
    afs updates

David Sterba (1):
    btrfs updates

David Teigland (1):
    dlm updates

Dmitry Torokhov (1):
    input updates

Dominique Martinet (1):
    9p updates

Eric Biggers (1):
    fscrypt updates

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (6):
    tty/serial updates
    driver core updates
    SPDX updates
    staging / IIO driver updates
    USB/PHY/Thunderbolt driver updates
    char/misc driver updates

Greg Ungerer (1):
    m68knommu updates

Guenter Roeck (1):
    hwmon updates

Hans de Goede (1):
    x86 platform driver updates

Helge Deller (2):
    parisc updates
    more parisc updates

Herbert Xu (1):
    crypto updates

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (14):
    scheduler updates
    locking updates
    EFI changes
    orphan section checking
    static call support
    performance events updates
    perf/kprobes updates
    x86 kaslr updates
    x86 mm updates
    x86 build update
    x86 paravirt cleanup
    x86 Hyper-V update
    objtool updates
    RCU changes

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (2):
    networking updates
    networking fixes

James Bottomley (2):
    SCSI updates
    more SCSI updates

Jan Kara (2):
    UDF, reiserfs, ext2, quota fixes
    direct-io fix

Jarkko Sakkinen (1):
    tpm updates

Jason Gunthorpe (1):
    rdma updates

Jassi Brar (1):
    mailbox updates

Jean Delvare (1):
    dmi update

Jeff Layton (1):
    file locking fix

Jens Axboe (9):
    block updates
    io_uring updates
    libata updates
    block driver updates
    io_uring updates
    arch task_work cleanups
    libata fixes
    io_uring fixes
    block fixes

Jessica Yu (1):
    modules updates

Jiri Kosina (3):
    livepatching update
    HID updates
    trivial updates

Joerg Roedel (2):
    iommu updates
    iommu fix

Jon Mason (1):
    NTB fixes

Jonathan Corbet (2):
    documentation updates
    documentation fixes

Juergen Gross (3):
    xen updates
    more xen updates
    more xen updates

Julia Lawall (1):
    coccinelle updates

Kees Cook (2):
    seccomp updates
    overflow update

Konrad Rzeszutek Wilk (1):
    swiotlb updates

Lee Jones (2):
    MFD updates
    backlight updates

Linus Walleij (2):
    GPIO updates
    pin control updates

Mark Brown (3):
    regmap updates
    regulator updates
    spi updates

Masahiro Yamada (2):
    Kbuild updates
    Kconfig updates

Matthew Wilcox (1):
    XArray updates

Mauro Carvalho Chehab (2):
    media updates
    documentation updates

Micah Morton (1):
    SafeSetID updates

Michael Ellerman (2):
    powerpc updates
    powerpc fixes

Michael Tsirkin (1):
    virtio updates

Michal Simek (1):
    Microblaze build warning fix

Mike Snitzer (1):
    device mapper updates

Miklos Szeredi (2):
    overlayfs updates
    fuse updates

Mimi Zohar (1):
    integrity updates

Namjae Jeon (1):
    exfat updates

Olof Johansson (5):
    ARM SoC fixes
    ARM SoC platform updates
    ARM SoC-related driver updates
    ARM Devicetree updates
    ARM SoC defconfig updates

Palmer Dabbelt (2):
    RISC-V updates
    more RISC-V updates

Paolo Bonzini (2):
    KVM updates
    KVM fixes

Paul Moore (2):
    audit updates
    selinux updates

Pavel Machek (1):
    LED updates

Petr Mladek (2):
    printk updates
    printk fix

Rafael Wysocki (5):
    power management updates
    ACPI updates
    PNP updates
    more power management updates
    more ACPI updates

Richard Weinberger (4):
    MTD updates
    ubifs updates
    more ubi and ubifs updates
    UML updates

Rob Herring (1):
    devicetree updates

Russell King (1):
    ARM updates

Sebastian Reichel (1):
    power supply and reset updates

Shuah Khan (4):
    kselftest updates
    kselftest updates
    Kunit updates
    more Kunit updates

Stephen Boyd (1):
    clk updates

Steve French (2):
    cifs updates
    more cifs updates

Steven Rostedt (3):
    tracing updates
    tracing fix
    tracing ring-buffer fix

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (1):
    ext4 updates

Tejun Heo (1):
    cgroup updates

Tetsuo HandaL
 (1):
    tomoyo fix

Thierry Reding (1):
    pwm updates

Thomas Bogendoerfer (1):
    MIPS updates

Thomas Gleixner (9):
    debugobjects updates
    timekeeping updates
    irq updates
    x86 irq updates
    x86 entry code updates
    locking fix
    perf fix
    scheduler fixes
    timer fixes

Tony Luck (1):
    ia64 updates

Ulf Hansson (1):
    MMC updates

Vasily Gorbik (1):
    s390 updates

Vineet Gupta (2):
    ARC updates
    ARC fix

Vinod Koul (1):
    dmaengine updates

Wei Liu (2):
    Hyper-V updates
    another Hyper-V update

Will Deacon (2):
    arm64 updates
    more arm64 updates

Willy Tarreau (1):
    random32 updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (2):
    i2c updates
    i2c fix
