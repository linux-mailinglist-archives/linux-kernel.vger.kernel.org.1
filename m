Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E363009D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbhAVRa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:30:29 -0500
Received: from foss.arm.com ([217.140.110.172]:54630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729258AbhAVP5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:57:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B13911D4;
        Fri, 22 Jan 2021 07:56:56 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EDC43F719;
        Fri, 22 Jan 2021 07:56:54 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH v4 0/3] kasan: Fix metadata detection for KASAN_HW_TAGS
Date:   Fri, 22 Jan 2021 15:56:39 +0000
Message-Id: <20210122155642.23187-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of KASAN_HW_TAGS, kasan_report() currently assumes
that every location in memory has valid metadata associated. This is due
to the fact that addr_has_metadata() returns always true.

As a consequence of this, an invalid address (e.g. NULL pointer address)
passed to kasan_report() when KASAN_HW_TAGS is enabled, leads to a
kernel panic.

Example below, based on arm64:

 ==================================================================
 BUG: KASAN: invalid-access in 0x0
 Read at addr 0000000000000000 by task swapper/0/1
 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
 Mem abort info:
   ESR = 0x96000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
 Data abort info:
   ISV = 0, ISS = 0x00000004
   CM = 0, WnR = 0

...

 Call trace:
  mte_get_mem_tag+0x24/0x40
  kasan_report+0x1a4/0x410
  alsa_sound_last_init+0x8c/0xa4
  do_one_initcall+0x50/0x1b0
  kernel_init_freeable+0x1d4/0x23c
  kernel_init+0x14/0x118
  ret_from_fork+0x10/0x34
 Code: d65f03c0 9000f021 f9428021 b6cfff61 (d9600000)
 ---[ end trace 377c8bb45bdd3a1a ]---
 hrtimer: interrupt took 48694256 ns
 note: swapper/0[1] exited with preempt_count 1
 Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
 SMP: stopping secondary CPUs
 Kernel Offset: 0x35abaf140000 from 0xffff800010000000
 PHYS_OFFSET: 0x40000000
 CPU features: 0x0a7e0152,61c0a030
 Memory Limit: none
 ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

This series fixes the behavior of addr_has_metadata() that now returns
true only when the address is valid.

Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (3):
  arm64: Improve kernel address detection of __is_lm_address()
  kasan: Add explicit preconditions to kasan_report()
  kasan: Make addr_has_metadata() return true for valid addresses

 arch/arm64/include/asm/memory.h | 6 ++++--
 include/linux/kasan.h           | 7 +++++++
 mm/kasan/kasan.h                | 2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.30.0

