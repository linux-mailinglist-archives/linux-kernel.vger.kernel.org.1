Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D662DE911
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 19:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgLRSop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 13:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLRSoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 13:44:44 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC36BC0617A7;
        Fri, 18 Dec 2020 10:44:03 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s26so7887998lfc.8;
        Fri, 18 Dec 2020 10:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6LSPXGseFdJjaxW3YvdtOcQhTKWjAIwtmDZc3IC14gU=;
        b=KiXQhtwJHjYBNa31hK6+LMEWrVlQFzsB3lFr64+g7O5eGzwHlIqXjcHH6dAFJd8VJ1
         hg61sox1lJniq3MsoiK61mxqCMe4mME8g66WVA1F/KUfTjewiPbCSy4yZf/yOLbpAW1f
         92MwMuFgcFjalqM0Ko1ExGgPi6wD5MlCsFSVx/8OjG1O1tSdJtlzBoR4vQLhoXPl5Ihh
         wPltrdTnTdEjeRLzir/ag9YRBm9Wtgn7UWHmu/uus6tPJPIr6PaMryt2cdQg8huKCYaf
         wLlOXfCjLFzFDt9Zlo7lWIVmUMFIEw+bX1P2ztx+jrtQTGo1Nhx8M8rDhSc9m2iRwKkg
         Hbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=6LSPXGseFdJjaxW3YvdtOcQhTKWjAIwtmDZc3IC14gU=;
        b=dGqZwBvdzrjxygXDC+/7j34pMHMwWn/yIBSgNuQsc4HzO7CN24oc4wuYPK4bc2EMhm
         irRw5vdHWRO71ibzGSyS2HKnp/mlx89uWWeP25fGH7KH5I76xC5w6Bzq5R+A/t0nrD14
         uJzKyOgUSejf8dK3i0KqS4cHwgL3EQ0uCkDfuNNaNn1Q0mJIHyQoHN/NgcJghAwL/E2C
         6ZNI7KCUIaXy6yZRkbwAB9ltx9BHOTHpXM1kzW1fBxZODuR7xC/FyO+lmo0HOfF52bFk
         pjH2SA0WoNDtHdfEIai5DvscLpC4boKjdBWh7n3Ld3J0qUPmrT5MEXqtcA/Ssws8bid9
         QiRA==
X-Gm-Message-State: AOAM532CpD770JlRrToZTlhfnJANBKgigDeX6e8V5E3P77Dj/LvUn5lY
        fBUJen1KSIiLwpfuM6lQvjE=
X-Google-Smtp-Source: ABdhPJyCepN0NmhiFgB+GJRpRSU3knX5RDYc8GrYZ+jJWEZ/PSHQKOvYRMJhsOTF/V9+yeaHtdNetA==
X-Received: by 2002:a05:651c:211e:: with SMTP id a30mr2540206ljq.18.1608317041724;
        Fri, 18 Dec 2020 10:44:01 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:2c04:50ad:1138:9ea2])
        by smtp.gmail.com with ESMTPSA id s7sm1116980ljp.38.2020.12.18.10.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 10:44:01 -0800 (PST)
Sender: Sam Ravnborg <sam.ravnborg@gmail.com>
From:   Sam Ravnborg <sam@ravnborg.org>
To:     David S Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        Andreas Larsson <andreas@gaisler.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Denis Efremov <efremov@linux.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org, debian-sparc@lists.debian.org,
        gentoo-sparc@l.g.o
Subject: [RFC PATCH 0/13] sparc32: sunset sun4m and sun4d
Date:   Fri, 18 Dec 2020 19:43:34 +0100
Message-Id: <20201218184347.2180772-1-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sun4m and sun4d based SPARC machines was very popular in the
90'ties and was then replaced by the more powerful sparc64
class of machines.
Today there is only Gentoo that to my best knowledge supports
sparc32 and people have moved on to more capable HW.

Cobham Gaisler have variants of the LEON processer that
runs sparc32 - and they are in production today.

With this patchset I propose to sunset sun4m and sun4d and move
focus to a more streamlined support for LEON.

One downside is that qemu supports sun4m - and we may loose
some testing possibilities when sun4m is dropped. qemu supports
LEON to some degree - I have not yet tried it out.

Andreas from Gaisler have indicated that they may be more active
upstream on sparc32 - and this will only be easier with a kernel
where the legacy stuff is dropped.

I decided to divide up the patches to make it possible to review
the set as some of the patches touches assembler and these parts
could use some extra eyes if we move forward with this.

For now it builds with the configurations I have tried.

Looking forward for feedback if sunsetting is a good idea or not.

	Sam

Sam Ravnborg (13):
      sparc32: Drop sun4m/sun4d support from head_32.S
      sparc32: Drop floppy support
      sparc32: Drop sun4m specific led driver
      sparc32: Drop auxio support
      sparc32: Drop run-time patching of ipi trap
      sparc32: Drop patching of interrupt vector
      sparc32: Drop sun4m/sun4d specific irq handling
      sparc32: Drop sun4d/sun4m smp support
      sparc32: Drop pcic support
      sparc32: Drop mbus support
      sparc32: Drop unused mmu models
      sparc32: drop check for sparc_model
      sparc32: drop use of sparc_config

Note: I dunno why git does not see floppy_64.h=>floppy.h as a rename??

 arch/sparc/Kconfig                  |  16 +-
 arch/sparc/include/asm/auxio_32.h   |  73 +---
 arch/sparc/include/asm/cpu_type.h   |  18 -
 arch/sparc/include/asm/elf_32.h     |   2 -
 arch/sparc/include/asm/floppy.h     | 786 ++++++++++++++++++++++++++++++++-
 arch/sparc/include/asm/floppy_32.h  | 393 -----------------
 arch/sparc/include/asm/floppy_64.h  | 779 ---------------------------------
 arch/sparc/include/asm/io_32.h      |   4 +-
 arch/sparc/include/asm/irq_32.h     |   1 -
 arch/sparc/include/asm/mbus.h       |  97 -----
 arch/sparc/include/asm/mxcc.h       | 138 ------
 arch/sparc/include/asm/pcic.h       | 130 ------
 arch/sparc/include/asm/pgtable_32.h |  24 -
 arch/sparc/include/asm/ross.h       | 192 --------
 arch/sparc/include/asm/swift.h      | 107 -----
 arch/sparc/include/asm/timer_32.h   |   1 +
 arch/sparc/include/asm/tsunami.h    |  65 ---
 arch/sparc/include/asm/viking.h     | 255 -----------
 arch/sparc/kernel/Makefile          |   8 +-
 arch/sparc/kernel/apc.c             |  14 -
 arch/sparc/kernel/auxio_32.c        | 140 ------
 arch/sparc/kernel/cpu.c             |   1 -
 arch/sparc/kernel/devices.c         |  10 +-
 arch/sparc/kernel/entry.S           | 354 +--------------
 arch/sparc/kernel/head_32.S         | 190 +-------
 arch/sparc/kernel/ioport.c          |   6 +-
 arch/sparc/kernel/irq.h             |  35 +-
 arch/sparc/kernel/irq_32.c          | 127 +-----
 arch/sparc/kernel/kernel.h          |  28 --
 arch/sparc/kernel/led.c             | 146 -------
 arch/sparc/kernel/leon_kernel.c     |  43 +-
 arch/sparc/kernel/leon_pmc.c        |  14 +-
 arch/sparc/kernel/leon_smp.c        |   3 -
 arch/sparc/kernel/of_device_32.c    |   4 +-
 arch/sparc/kernel/pcic.c            | 841 ------------------------------------
 arch/sparc/kernel/pmc.c             |  10 -
 arch/sparc/kernel/process_32.c      |  10 -
 arch/sparc/kernel/setup_32.c        |  80 +---
 arch/sparc/kernel/smp_32.c          | 102 +----
 arch/sparc/kernel/sun4d_irq.c       | 519 ----------------------
 arch/sparc/kernel/sun4d_smp.c       | 413 ------------------
 arch/sparc/kernel/sun4m_irq.c       | 240 ----------
 arch/sparc/kernel/sun4m_smp.c       | 273 ------------
 arch/sparc/kernel/time_32.c         | 114 +++--
 arch/sparc/kernel/ttable_32.S       |   9 +-
 arch/sparc/mm/Makefile              |   1 -
 arch/sparc/mm/hypersparc.S          | 414 ------------------
 arch/sparc/mm/io-unit.c             |   3 -
 arch/sparc/mm/iommu.c               |  49 +--
 arch/sparc/mm/mm_32.h               |   1 -
 arch/sparc/mm/srmmu.c               | 834 +----------------------------------
 arch/sparc/mm/swift.S               | 256 -----------
 arch/sparc/mm/tsunami.S             | 132 ------
 arch/sparc/mm/viking.S              | 284 ------------
 arch/sparc/prom/misc_32.c           |   2 -
 55 files changed, 905 insertions(+), 7886 deletions(-)


