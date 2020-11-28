Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34722C768A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 00:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgK1XB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 18:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgK1XB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 18:01:28 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CECC0613D2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 15:00:48 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id k5so4430190plt.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 15:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=bYGsECF90NImwkerygnoxQ6S7S+NIVHNiaB71IEALrI=;
        b=dLnnhRRrnb2fDKTKpUfA/12JuXtrM/C1zinrFTvi2DII2tNex1zZ6Y2bII5zhyPI8v
         U99DCa11cDzk7RASpv7aqa1170YvejEcV5gbygzdDq246Z8ya62JyjMWMNVsY3US2o1d
         DE8Oy1MFisSTaH++EQC/zSg18ARRhKCtsOIS2deh2mV4W1u47JirnT+DVsakH/UXIkgH
         wy4fZaSt821xjrViOJQl4gcPqkTOwFpx8ZBPt4fExavMQxp3RTSmarT6aWt1m5GNJDGw
         gMKTfTd7eV2wPij0OEhCuAhyxGmhZyupTmi62WhAbw6izy9vGUxC7ycdq/5JRwvcZHiL
         gTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=bYGsECF90NImwkerygnoxQ6S7S+NIVHNiaB71IEALrI=;
        b=cLiAHFMB/W/UUdTYcUXhJe1bmAJqfZ6LvZSCjrrbokQ+e0b+OE5NfBDgWgSjL69xGg
         3uxL7m/R9Hn78o638wiDXZtLMMdyji5u86GElAxC1wmn5BMu8DstWYnjpMNInzbYaDyh
         15n4dxzSpGqmzvOGrF9DagVilCwMzmf4GHC9V2BuyDpwPp5fJ16P8bcKp7F4Qv77/dpV
         sshHj0neY7c0UdfNjk9oUpv/WPoiJYiA2j8e95eUup7gBbfu1e5DQgsanrzaS1gAspXf
         iVLGNjaqcJkbJhv+T4elnqgvEQ5mdxyOIqUfM5uoteFFObByVkcnNB2NfYQPMBAQn8tg
         9x7w==
X-Gm-Message-State: AOAM5315SdXBzezXoRDsL0/EXTK0mYik1r0AUuvV5/g9OvczL9zyMHur
        vbG0ty3+d8s6YmdhRkXfAaQmXUNjuFukYvJd
X-Google-Smtp-Source: ABdhPJyE/PRMJZpe9/YTUcQ9LwvZQrK/TOgHvGU7WipqPz6+HJ4UDhQxgUlWK1BXM/0c1dml/q9lLA==
X-Received: by 2002:a17:902:7b90:b029:d6:ad06:d4c0 with SMTP id w16-20020a1709027b90b02900d6ad06d4c0mr12822055pll.35.1606604447877;
        Sat, 28 Nov 2020 15:00:47 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id m3sm9666826pgh.5.2020.11.28.15.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 15:00:47 -0800 (PST)
Date:   Sat, 28 Nov 2020 15:00:47 -0800 (PST)
X-Google-Original-Date: Sat, 28 Nov 2020 15:00:45 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 5.10-rc6
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-a86b7c3c-7719-48e7-b6b3-5d7ec6b8933d@palmerdabbelt-glaptop1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 418baf2c28f3473039f2f7377760bd8f6897ae18:

  Linux 5.10-rc5 (2020-11-22 15:36:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.10-rc6

for you to fetch changes up to 30aca1bacb398dec6c1ed5eeca33f355bd7b6203:

  RISC-V: fix barrier() use in <vdso/processor.h> (2020-11-25 09:44:27 -0800)

----------------------------------------------------------------
RISC-V Fixes for 5.10-rc6

I've collected a handful of fixes over the past few weeks:

* A fix to un-break the build-id argument to the vDSO build, which is necessary
  for the LLVM linker.
* A fix to initialize the jump label subsystem, without which it (and all the
  stuff that uses it) doesn't actually function.
* A fix to include <asm/barrier.h> from <vdso/processor.h>, without which some
  drivers won't compile.

I know it's the holidays, but I had some hiccups getting this tested earlier
this week so it's just going out now.  None of these are tremendously urgent,
so if they don't make rc6 it's not a big deal.  I'll have some more fixes
coming next week either way.

----------------------------------------------------------------
Anup Patel (1):
      RISC-V: Add missing jump label initialization

Nathan Chancellor (1):
      riscv: Explicitly specify the build id style in vDSO Makefile again

Randy Dunlap (1):
      RISC-V: fix barrier() use in <vdso/processor.h>

 arch/riscv/include/asm/vdso/processor.h | 2 ++
 arch/riscv/kernel/setup.c               | 1 +
 arch/riscv/kernel/vdso/Makefile         | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)
