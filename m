Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C88E2FF0BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388136AbhAUQn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:43:58 -0500
Received: from foss.arm.com ([217.140.110.172]:41048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731579AbhAUQkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:40:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCB0711D4;
        Thu, 21 Jan 2021 08:39:52 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C0BD3F68F;
        Thu, 21 Jan 2021 08:39:51 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v5 0/6] arm64: ARMv8.5-A: MTE: Add async mode support
Date:   Thu, 21 Jan 2021 16:39:37 +0000
Message-Id: <20210121163943.9889-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements the asynchronous mode support for ARMv8.5-A
Memory Tagging Extension (MTE), which is a debugging feature that allows
to detect with the help of the architecture the C and C++ programmatic
memory errors like buffer overflow, use-after-free, use-after-return, etc.

MTE is built on top of the AArch64 v8.0 virtual address tagging TBI
(Top Byte Ignore) feature and allows a task to set a 4 bit tag on any
subset of its address space that is multiple of a 16 bytes granule. MTE
is based on a lock-key mechanism where the lock is the tag associated to
the physical memory and the key is the tag associated to the virtual
address.
When MTE is enabled and tags are set for ranges of address space of a task,
the PE will compare the tag related to the physical memory with the tag
related to the virtual address (tag check operation). Access to the memory
is granted only if the two tags match. In case of mismatch the PE will raise
an exception.

The exception can be handled synchronously or asynchronously. When the
asynchronous mode is enabled:
  - Upon fault the PE updates the TFSR_EL1 register.
  - The kernel detects the change during one of the following:
    - Context switching
    - Return to user/EL0
    - Kernel entry from EL1
    - Kernel exit to EL1
  - If the register has been updated by the PE the kernel clears it and
    reports the error.

The series is based on linux-next/akpm.

To simplify the testing a tree with the new patches on top has been made
available at [1].

[1] https://git.gitlab.arm.com/linux-arm/linux-vf.git mte/v10.async.akpm

Changes:
--------
v5:
  - Rebase the series on linux-next/akpm.
  - Forbid execution for KASAN KUNIT tests when async
    mode is enabled.
  - Dropped patch to inline mte_assign_mem_tag_range().
  - Address review comments.
v4:
  - Added support for kasan.mode (sync/async) kernel
    command line parameter.
  - Addressed review comments.
v3:
  - Exposed kasan_hw_tags_mode to convert the internal
    KASAN represenetation.
  - Added dsb() for kernel exit paths in arm64.
  - Addressed review comments.
v2:
  - Fixed a compilation issue reported by krobot.
  - General cleanup.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Evgenii Stepanov <eugenis@google.com>
Cc: Branislav Rankov <Branislav.Rankov@arm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (6):
  arm64: mte: Add asynchronous mode support
  kasan: Add KASAN mode kernel parameter
  kasan: Add report for async mode
  arm64: mte: Enable async tag check fault
  arm64: mte: Expose execution mode
  kasan: Forbid kunit tests when async mode is enabled

 Documentation/dev-tools/kasan.rst  |  7 +++
 arch/arm64/include/asm/memory.h    |  4 +-
 arch/arm64/include/asm/mte-kasan.h | 15 ++++++-
 arch/arm64/include/asm/mte.h       | 32 ++++++++++++++
 arch/arm64/kernel/entry-common.c   |  6 +++
 arch/arm64/kernel/mte.c            | 68 +++++++++++++++++++++++++++++-
 include/linux/kasan.h              |  2 +
 lib/test_kasan.c                   |  7 ++-
 mm/kasan/hw_tags.c                 | 27 +++++++++++-
 mm/kasan/kasan.h                   |  8 +++-
 mm/kasan/report.c                  | 11 +++++
 11 files changed, 178 insertions(+), 9 deletions(-)

-- 
2.30.0

