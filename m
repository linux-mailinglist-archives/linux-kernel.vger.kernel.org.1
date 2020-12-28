Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779AB2E3341
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 01:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgL1AFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 19:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgL1AFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 19:05:11 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFA9C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 16:04:30 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b26so20499697lff.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 16:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=W1L56od7BcULkuCVRz+JEa3E7kIzBp8LfemF5JoW+78=;
        b=DqN/AAV5Bpt4UwofQY2P7yN05Krzz3x0M/XjcfpdVT3FJ68e096VHKD7rjIGKMrZPU
         O92GeQwhn74vcXp+14kkSiaP9BRYgueadbIAdQfAqwXUOkrStcp3MNhWPunJraBiJ+ng
         PIEe3tuxfoEIEBxqfcFY0ynGa7DhcCyiMDFCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=W1L56od7BcULkuCVRz+JEa3E7kIzBp8LfemF5JoW+78=;
        b=phPe/DqyjKIF0sMDORkX63TwaouMK3A5RL08YGfH7YnSf9cI7d78mSBm3wwVa00oyu
         3l5C1K8XtPpcDKxeXgciuxnoAoPTuA0IZ4GlVXSkaNUdXbBBsQbZT+RwRFgsejyLSBwe
         JhJl+Jp6xuiq2gFoyJ2SSFMlorSC6WJgQ4vnWPQevveGFl1QJX54w3XCvfjHUGDr1/Z8
         1T3cAstZlGus202UYG13yKtZOTETYehiCFAU+WIL4lEuA7BCDmtdSHDUTGWS/0/DKorU
         /sicXunS88hxKKYlZVL76GYF5jXO7cuJO614/LcrZb3j1ipArcEElA7MmX91orhRwSH4
         +56Q==
X-Gm-Message-State: AOAM530wTFomFSIdcHII02u9CHqvq4UhnwB6xNAJM5xx80FSMYARxJMO
        cNUd1a7pFs9zGK6bCjva3tWLi3UMO3OY9Q==
X-Google-Smtp-Source: ABdhPJzmhCAjRw9bOia2/muMjgg9Lt52BirpEo5LInojajwF6IZakacI5n6DdKRc7ndZDxH0ztKOaQ==
X-Received: by 2002:a2e:2c09:: with SMTP id s9mr21875421ljs.20.1609113868549;
        Sun, 27 Dec 2020 16:04:28 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id q21sm5227050lfc.290.2020.12.27.16.04.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Dec 2020 16:04:27 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id o13so20550446lfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 16:04:27 -0800 (PST)
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr19720093lji.48.1609113867001;
 Sun, 27 Dec 2020 16:04:27 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Dec 2020 16:04:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg1+kf1AVzXA-RQX0zjM6t9J2Kay9xyuNqcFHWV-y5ZYw@mail.gmail.com>
Message-ID: <CAHk-=wg1+kf1AVzXA-RQX0zjM6t9J2Kay9xyuNqcFHWV-y5ZYw@mail.gmail.com>
Subject: Linux 5.11-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two weeks have passed, Christmas is over, and so is the merge window.

I want to thank all the maintainers who sent in their pull requests
early: we all wanted to get things done before the holidays really
hit, and mostly it seemed to work quite well.

In fact, it was rather nice to handle the big bulk of all the merge
window pull requests in the first three or four days of the merge
window.  I wouldn't want to do it that way every time - it would
stress me out - but as an occasional "let's get it over with so that
the second week is calm" it really wasn't bad at all.

It probably helped that 5.11 isn't going to be an LTS release and
isn't as big as 5.10 was, but it's not small either. Solidly average.

Well, it's average, unless you look at the actual diffs, and notice
another huge dump of AMD GPU descriptor header files, which completely
dwarfs all the "real" changes here. The AMD "Van Gogh" include file
additions are in fact about two thirds of the whole patch, even if it
comes from basically one single commit that just adds the register
definitions. We've had it before, I'm sure we'll see it in the future
too: header files probably generated from the hardware description for
all the possible bit masks etc get very very big.

Oh well. If you ignore that area, everything else looks normal. Driver
updates dominate, but all the usual other suspects are there: arch
updates, filesystems, networking, docs and tooling.

And while it doesn't look like a huge release, it's certainly still
big enough that what's appended below is just my "merge log". As
always, my merge logs credit only the people I pull from, which is a
much smaller set than all the people involved in actually writing the
patches. As usual we had more than 1500 actual developers, and roughly
12,500 changes merged. That's pretty much our average these days.

Please go kick the tires,

                Linus

---

Al Viro (3):
    epoll updates
    regset updates
    misc vfs updates

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (1):
    RTC updates

Andreas Gruenbacher (1):
    gfs2 updates

Andrew Morton (5):
    misc updates
    more updates
    yet more updates
    still more updates
    KASAN updates

Arnaldo Carvalho de Melo (2):
    perf tools updates
    more perf tools updates

Arnd Bergmann (8):
    asm-generic cleanups
    asm-generic mmu-context cleanup
    asm-generic cross-architecture timer cleanup
    ARM SoC updates
    ARM SoC defconfig updates
    ARM device tree updates
    ARM SoC driver updates
    ARM SoC OMAP GenPD updates

Benson Leung (1):
    chrome platform updates

Bjorn Andersson (3):
    remoteproc updates
    hwspinlock updates
    rpmsg updates

Bjorn Helgaas (2):
    PCI updates
    PCI fixes

Boris Brezillon (1):
    i3c updates

Borislav Petkov (12):
    EDAC updates
    x86 RAS updates
    x86 microcode loader update
    x86 SGC support
    x86 cpuid updates
    x86 platform updates
    misc x86 updates
    x86 mm update
    x86 cleanups
    x86 cache resource control updates
    x86 build updates
    EFI updates

Casey Schaufler (2):
    smack updates
    smack fix

Catalin Marinas (2):
    arm64 updates
    more arm64 updates

Christian Brauner (4):
    time namespace updates
    misc fixes
    close_range/openat2 updates
    close_range fix

Christoph Hellwig (2):
    configfs update
    dma-mapping updates

Chuck Lever (1):
    nfsd updates

Corey Minyard (1):
    IPMI updates

Dan Williams (1):
    libnvdimm updates

Daniel Lezcano (2):
    thermal updates
    thermal fixlet

Daniel Vetter (1):
    more drm updates

Darrick Wong (1):
    xfs updates

Dave Airlie (2):
    drm updates
    drm fixes

David Kleikamp (1):
    jfs updates

David Sterba (1):
    btrfs updates

David Teigland (1):
    dlm updates

Dmitry Torokhov (1):
    input updates

Dominik Brodowski (1):
    pcmcia updates

Dominique Martinet (1):
    9p update

Eric Biederman (3):
    signal cleanup
    execve updates
    exec-update-lock update

Eric Biggers (2):
    fscrypt updates
    fsverity updates

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (5):
    USB / Thunderbolt updates
    tty / serial updates
    driver core updates
    char / misc driver updates
    staging / IIO driver updates

Greg Ungerer (1):
    m68knommu updates

Guenter Roeck (2):
    hwmon updates
    another hwmon update

Gustavo A (1):
    fallthrough fixes

Hans de Goede (1):
    x86 platform driver updates

Heiko Carstens (2):
    s390 updates
    more s390 updates

Helge Deller (1):
    parisc updates

Herbert Xu (2):
    crypto updates
    crypto fixes

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (4):
    scheduler fix
    timer fixes
    locking fixes
    objtool fix

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (2):
    networking updates
    networking fixes

James Bottomley (1):
    SCSI updates

Jan Kara (2):
    fsnotify updates
    ext2, reiserfs, quota and writeback updates

Jason Gunthorpe (1):
    rdma updates

Jassi Brar (1):
    mailbox updates

Jeff Layton (1):
    file locking fixes

Jens Axboe (6):
    TIF_NOTIFY_SIGNAL updates
    io_uring updates
    block updates
    block driver updates
    block fixes
    io_uring fixes

Jessica Yu (1):
    modules updates

Jiri Kosina (1):
    HID updates

Jon Mason (1):
    NTB fixes

Jonathan Corbet (2):
    documentation updates
    documentation fixes

Juergen Gross (2):
    xen updates
    more xen updates

Julia Lawall (1):
    coccinelle updates

Kees Cook (3):
    gcc-plugins updates
    pstore updates
    seccomp updates

Konrad Rzeszutek Wilk (1):
    swiotlb update

Lee Jones (2):
    MFD updates
    backlight update

Linus Walleij (2):
    pin control updates
    GPIO updates

Mark Brown (3):
    regmap updates
    regulator updates
    spi updates

Masahiro Yamada (2):
    Kbuild updates
    Kconfig updates

Mauro Carvalho Chehab (1):
    media updates

Michael Ellerman (2):
    powerpc updates
    powerpc fixes

Michael Tsirkin (1):
    virtio updates

Michal Simek (1):
    microblaze updates

Miguel Ojeda (1):
    auxdisplay updates

Mike Marshall (1):
    orangefs update

Mike Rapoport (1):
    memblock updates

Mike Snitzer (2):
    MD regression reverts
    device mapper updates

Miklos Szeredi (2):
    fuse updates
    overlayfs updates

Mimi Zohar (1):
    integrity subsystem updates

Miquel Raynal (1):
    MTD updates

Namjae Jeon (1):
    exfat update

Palmer Dabbelt (2):
    RISC-V updates
    RISC-V fix

Paolo Bonzini (1):
    KVM updates

Paul Moore (2):
    audit updates
    selinux updates

Pavel Machek (1):
    LED updates

Petr Mladek (1):
    printk updates

Rafael Wysocki (4):
    power management updates
    ACPI updates
    more power management updates
    more ACPI updates

Richard Weinberger (2):
    jffs2, ubi and ubifs updates
    UML updates

Rob Herring (2):
    devicetree updates
    devicetree fixes

Russell King (1):
    ARM updates

Sebastian Reichel (2):
    HSI updates
    power supply and reset updates

Shuah Khan (3):
    Kselftest fixes
    Kselftest updates
    Kunit updates

Stafford Horne (1):
    OpenRISC updates

Stephen Boyd (1):
    clk updates

Steve French (2):
    cifs updates
    cifs fixes

Steven Rostedt (2):
    tracing updates
    ktest updates

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (1):
    ext4 updates

Tetsuo Handa (1):
    tomoyo updates

Thierry Reding (1):
    pwm updates

Thomas Bogendoerfer (1):
    MIPS updates

Thomas Gleixner (12):
    core entry/exit updates
    RCU updates
    locking updates
    perf updates
    perf/kprobes updates
    timers and timekeeping updates
    scheduler updates
    kmap updates
    x86 FPU updates
    x86 apic updates
    irq updates
    irq updates

Trond Myklebust (1):
    NFS client updates

Ulf Hansson (1):
    MMC updates

Vinod Koul (1):
    dmaengine updates

Wei Liu (1):
    Hyper-V updates

Will Deacon (1):
    IOMMU updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (1):
    i2c updates
