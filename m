Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E94C271652
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 19:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgITR0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 13:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgITR0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 13:26:35 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA96C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 10:26:35 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c3so5696404plz.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 10:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=f6WUrne5G/egCmCZ7ogiV0QMC8iAaMZgFNcbf5/4Ujw=;
        b=Vmic1KSX74jNaSc9Du9HzVIcCqMbcK0h2JQ1oBsDRRZvvGPHbZQXCL44PqCO0+U/YK
         CsK06YWsjouTFRyXMbtdjZ5VB2Pn0/XHHP4lcUU51QVkffPX5/GlwDnmU/QVM86DUZgI
         hpUjCknE9sCwOEd+gDVNhimnH1W4qvjRKI+WNc0SGRrVzEFh8NIkUXSeTYDAt9ss71cw
         HFQpJ5mE+heycLVNNHAtZzJS1k58/Ent+L0SXiAMNow6AntWRuaMRuUiyD62CkMczPwx
         cNNGkkocXY5Up8IdWpXEfLRrvipsDMe06L8r0+LWBPoYvAXRQD2W7my5zAAALhXJfXVe
         U/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=f6WUrne5G/egCmCZ7ogiV0QMC8iAaMZgFNcbf5/4Ujw=;
        b=Hr1o2I9o7ZeN1tBOzTCK2b0yHULtpfXquosYfSjLqU8m8IpXDaFNHNnsC8XIDzXiwk
         UsXg6kkhoxTTZ6dk/HCFSG9osihYuW1Nbf2iGhAvOljjyHiJwVenDMjweSB9dVDNQlBn
         UM7bhTeGrXQZFn2/6kXCWzKXJAAi4RdKMrFbLgiq8PQ/a5hcubNyYm3g1oqgVywF602G
         gxWTGEoLCvvYqZgMI2mIobzcpGbGFdiDZEf+Q1c6f/figLTzuhQ5XHLJpEhvDqrbzSps
         1ZuMTLnFPYe4YgSWnTn5ZLx5iNZwizBSrUp/phwx0KKEIAUl+vYw60U/5v9baDdKqnmm
         hH6w==
X-Gm-Message-State: AOAM530m9bSoLKCIxs212LUk1xlmS5K6Gto5Wrh7GEpMJPF4SBjA+BKF
        ohjZSm5t6gIW5NI+siUrx8LzwkcmS75RqEVY
X-Google-Smtp-Source: ABdhPJwuBS0WNmzJTbC8EwiQ9YOL1Yy6M1qk6O6KGUy7jpLpiDx1uTVAqOx1Db6LwEyQB+zk1v49MA==
X-Received: by 2002:a17:902:a50b:b029:d1:e5e7:bdd2 with SMTP id s11-20020a170902a50bb02900d1e5e7bdd2mr23969524plq.50.1600622794774;
        Sun, 20 Sep 2020 10:26:34 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 131sm9652013pfy.5.2020.09.20.10.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 10:26:34 -0700 (PDT)
Date:   Sun, 20 Sep 2020 10:26:34 -0700 (PDT)
X-Google-Original-Date: Sun, 20 Sep 2020 10:26:29 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.9-rc6 (or shortly after)
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-a3f22c5c-7980-4ed9-b198-da86bf6d1162@palmerdabbelt-glaptop1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.9-rc6

for you to fetch changes up to d5be89a8d118a8e8d09cd74a921a808f17fbdd09:

  RISC-V: Resurrect the MMIO timer implementation for M-mode systems (2020-09-19 13:21:11 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.9-rc6 (or shortly after)

* A fix for a lockdep issue to avoid an asserting triggering during early boot.
  There shouldn't be any incorrect behavior as the system isn't concurrent at
  the time.
* The addition of a missing fence when installing early fixmap mappings.
* A corretion to the K210 device tree's interrupt map.
* A fix for M-mode timer handling on the K210.

I know it's a it of an odd time, so if these don't make rc6 it's not a big
deal, but I thought I'd just send it out now rather that waiting as these are
ready to go.

----------------------------------------------------------------
Damien Le Moal (1):
      riscv: Fix Kendryte K210 device tree

Greentime Hu (1):
      riscv: Add sfence.vma after early page table changes

Palmer Dabbelt (2):
      RISC-V: Take text_mutex in ftrace_init_nop()
      RISC-V: Resurrect the MMIO timer implementation for M-mode systems

 arch/riscv/Kconfig                     |  1 +
 arch/riscv/boot/dts/kendryte/k210.dtsi |  6 ++++--
 arch/riscv/include/asm/clint.h         | 26 ++++++++++++++++++++++++++
 arch/riscv/include/asm/ftrace.h        |  7 +++++++
 arch/riscv/include/asm/timex.h         | 27 +++++++++++++++++++++++++++
 arch/riscv/kernel/ftrace.c             | 19 +++++++++++++++++++
 arch/riscv/mm/init.c                   |  7 +++----
 drivers/clocksource/timer-clint.c      | 17 +++++++++++++++++
 8 files changed, 104 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/include/asm/clint.h
