Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAE92F8E7B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbhAPRzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbhAPRzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:55:32 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8709DC061573
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 09:54:52 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id q4so6348629plr.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 09:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=Y8HqPepn9WlqKtTg6LT12iZGQnoJuCc7icVZrw7iHr8=;
        b=WSvbX8ccuLP8EsMehmK8NRenisQwSFaYZUBIi1ewXTfcle1BO/5NSVrFbbkhxsnfxL
         OFaqH2Vnj0eCafQ7wOutosTUKaBiE/YznxLkMJI2IYjVIZtuF5KnDXDwl7PziTKR+xhD
         t+bgbydGss6TGZ8k05L7nYe+625+uhmTeScWEhJFK4546M+j0oKqGB9GS+gda/Dpf7Yi
         r2jaO734wIbEy4vOl5gwRq1aJ4zEz1wi++QEF3Z4wqgWZILLLEcy5LW02WrhGdHFzTJP
         LHfne6bwL4NFjLW0V5TcT8Fp9NGEqFF5c96x4/RmgK325tbNoBzUozJ05H90sRhTL/AO
         oRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=Y8HqPepn9WlqKtTg6LT12iZGQnoJuCc7icVZrw7iHr8=;
        b=MrrgE11f+8B1LkmeiWfgIcEPFkTD8XhG2aJ9HyS/5p1VtFtW/k+yDgXMCzrEE4vx3N
         KrvLrR6mzdhZBwaavFCODDcfo82swszhaikwkYalAczjz2QchcZr3fegZBeMrGuJ5wCb
         Vk0W1pOVNM8irHFslsq99bOJbNzPZm7IdsW/CUVT3McQ0frUvUaTk/KWEH9/RABu1F7G
         imZnbBrVsqT1HnLfElYTrcwTqWESjCCYQ3ha8h8jFjYIfMzOPS5eHR4YjAs1n3qFQyOD
         WCa/D2Nmgjq1CmNdJ1+WqQvVVbLH3PIQJRz7OmC5O1jopKTKlOM363wggnoxKv4ecmDZ
         AC4w==
X-Gm-Message-State: AOAM531jiJJpSdJlpin72n6HL14NrA8Lvbm853t55KWseuXx5TseibyK
        HmOL6hAE+/q8eq0yCoRPliuhDgrizHbQ3w==
X-Google-Smtp-Source: ABdhPJyTTvoEexuZjgEW4hG5HxSuQRlEdnpgW3WAcvUTA5kjDTBX8iycczPrxIekPnRwntn7HLVPMA==
X-Received: by 2002:a17:902:eb03:b029:db:c0d6:5845 with SMTP id l3-20020a170902eb03b02900dbc0d65845mr18267527plb.76.1610819691941;
        Sat, 16 Jan 2021 09:54:51 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j6sm6816080pjd.33.2021.01.16.09.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 09:54:51 -0800 (PST)
Date:   Sat, 16 Jan 2021 09:54:51 -0800 (PST)
X-Google-Original-Date: Sat, 16 Jan 2021 09:54:46 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 5.11-rc4
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-6a7bf03f-5e44-4fa0-a205-0fba77454f24@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.11-rc4

for you to fetch changes up to e557793799c5a8406afb08aa170509619f7eac36:

  RISC-V: Fix maximum allowed phsyical memory for RV32 (2021-01-15 21:35:48 -0800)

----------------------------------------------------------------
RISC-V Fixes for 5.11-rc4

There are a few more fixes than a normal rc4, largely due to the bubble
introduced by the holiday break:

* A fix to return -ENOSYS for syscall number -1, which previously
  returned an uninitialized value.
* A fix to time_init() to ensure of_clk_init() has been called, without
  which clock drivers may not be initialized.
* A fix to the sifive,uart0 driver to properly display the baud rate.  A
  fix to initialize MPIE that allows interrupts to be processed during
  system calls.
* A fix to avoid erronously begin tracing IRQs when interrupts are
  disabled, which at least triggers suprious lockdep failures.
* A workaround for a warning related to calling smp_processor_id() while
  preemptible.  The warning itself is suprious on currently availiable
  systems.
* A fix to properly include the generic time VDSO calls.  A fix to our
  kasan address mapping.  A fix to the HiFive Unleashed device tree,
  which allows the Ethernet PHY to be properly initialized by Linux (as
  opposed to relying on the bootloader).
* A defconfig update to include SiFive's GPIO driver, which is present
  on the HiFive Unleashed and necessary to initialize the PHY.
* A fix to avoid allocating memory while initializing reserved memory.
* A fix to avoid allocating the last 4K of memory, as pointers there
  alias with syscall errors.

There are also two cleanups that should have no functional effect but do
fix build warnings:

* A cleanup to drop a duplicated definition of PAGE_KERNEL_EXEC.
* A cleanup to properly declare the asm register SP shim.
* A cleanup to the rv32 memory size Kconfig entry, to reflect the actual
  size of memory availiable.

----------------------------------------------------------------
Andreas Schwab (1):
      riscv: return -ENOSYS for syscall -1

Atish Patra (4):
      riscv: Trace irq on only interrupt is enabled
      RISC-V: Do not allocate memblock while iterating reserved memblocks
      RISC-V: Set current memblock limit
      RISC-V: Fix maximum allowed phsyical memory for RV32

Damien Le Moal (3):
      riscv: Fix kernel time_init()
      riscv: Fix sifive serial driver
      riscv: Enable interrupts during syscalls with M-Mode

Guo Ren (1):
      riscv: Fixup CONFIG_GENERIC_TIME_VSYSCALL

Kefeng Wang (3):
      riscv: Drop a duplicated PAGE_KERNEL_EXEC
      riscv: cacheinfo: Fix using smp_processor_id() in preemptible
      riscv: stacktrace: Move register keyword to beginning of declaration

Nick Hu (1):
      riscv: Fix KASAN memory mapping.

Sagar Shrikant Kadam (3):
      dts: phy: fix missing mdio device and probe failure of vsc8541-01 device
      dts: phy: add GPIO number and active state used for phy reset
      riscv: defconfig: enable gpio support for HiFive Unleashed

 arch/riscv/Kconfig                                 |  6 ++++--
 .../riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  2 ++
 arch/riscv/configs/defconfig                       |  2 ++
 arch/riscv/include/asm/pgtable.h                   |  1 -
 arch/riscv/include/asm/vdso.h                      |  2 +-
 arch/riscv/kernel/cacheinfo.c                      | 11 +++++++++-
 arch/riscv/kernel/entry.S                          | 24 ++++++++++++----------
 arch/riscv/kernel/setup.c                          | 24 ++++++++++++----------
 arch/riscv/kernel/stacktrace.c                     |  5 ++---
 arch/riscv/kernel/time.c                           |  3 +++
 arch/riscv/kernel/vdso.c                           |  2 +-
 arch/riscv/mm/init.c                               | 16 +++++++++++++--
 arch/riscv/mm/kasan_init.c                         |  4 ++--
 drivers/tty/serial/sifive.c                        |  1 +
 14 files changed, 68 insertions(+), 35 deletions(-)
