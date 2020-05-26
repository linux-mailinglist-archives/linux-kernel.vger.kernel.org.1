Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340E51CD113
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 06:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgEKEx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 00:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgEKEx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 00:53:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF2CD20820;
        Mon, 11 May 2020 04:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589172807;
        bh=uAtERo6VQF9XSmlySDnOOTtodkoqWWGfP4aqy6ImfPk=;
        h=From:To:Cc:Subject:Date:From;
        b=bx6cskL0Iw2UkBCirdICU4JIrRpSkTFMA0CNuRCIxrXXae9H83wJuZRD4Z4qIvJmw
         zEO8vkZ9u2zC8PIpeIBRV55Xy9B4Hj/VITxnuVIA8tt7/u5cTS+Deuvq6CEWBr/o+/
         DUIw7gjgrsJ2kYqh/ZxTtA4ETawmE1LAfAhazYpA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v12 00/18] Enable FSGSBASE instructions
Date:   Mon, 11 May 2020 00:52:53 -0400
Message-Id: <20200511045311.4785-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benefits:
Currently a user process that wishes to read or write the FS/GS base must
make a system call. But recent X86 processors have added new instructions
for use in 64-bit mode that allow direct access to the FS and GS segment
base addresses.  The operating system controls whether applications can
use these instructions with a %cr4 control bit.

In addition to benefits to applications, performance improvements to the
OS context switch code are possible by making use of these instructions. A
third party reported out promising performance numbers out of their
initial benchmarking of the previous version of this patch series [9].

Enablement check:
The kernel provides information about the enabled state of FSGSBASE to
applications using the ELF_AUX vector. If the HWCAP2_FSGSBASE bit is set in
the AUX vector, the kernel has FSGSBASE instructions enabled and
applications can use them.

Kernel changes:
Major changes made in the kernel are in context switch, paranoid path, and
ptrace. In a context switch, a task's FS/GS base will be secured regardless
of its selector. In the paranoid path, GS base is unconditionally
overwritten to the kernel GS base on entry and the original GS base is
restored on exit. Ptrace includes divergence of FS/GS index and base
values.

Security:
For mitigating the Spectre v1 SWAPGS issue, LFENCE instructions were added
on most kernel entries. Those patches are dependent on previous behaviors
that users couldn't load a kernel address into the GS base. These patches
change that assumption since the user can load any address into GS base.
The changes to the kernel entry path in this patch series take account of
the SWAPGS issue.

Changes from v11:

 - Rebase to v5.7-rc5, fix 32bit compilation error.


Andi Kleen (2):
  x86/fsgsbase/64: Add intrinsics for FSGSBASE instructions
  x86/elf: Enumerate kernel FSGSBASE capability in AT_HWCAP2

Andy Lutomirski (4):
  x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
  x86/entry/64: Clean up paranoid exit
  x86/fsgsbase/64: Use FSGSBASE in switch_to() if available
  x86/fsgsbase/64: Enable FSGSBASE on 64bit by default and add a chicken
    bit

Chang S. Bae (9):
  x86/ptrace: Prevent ptrace from clearing the FS/GS selector
  selftests/x86/fsgsbase: Test GS selector on ptracer-induced GS base
    write
  x86/entry/64: Switch CR3 before SWAPGS in paranoid entry
  x86/entry/64: Introduce the FIND_PERCPU_BASE macro
  x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit
  x86/entry/64: Document GSBASE handling in the paranoid path
  x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions
  x86/fsgsbase/64: Use FSGSBASE instructions on thread copy and ptrace
  selftests/x86/fsgsbase: Test ptracer-induced GS base write with
    FSGSBASE

Sasha Levin (1):
  x86/fsgsbase/64: move save_fsgs to header file

Thomas Gleixner (1):
  Documentation/x86/64: Add documentation for GS/FS addressing mode

Tony Luck (1):
  x86/speculation/swapgs: Check FSGSBASE in enabling SWAPGS mitigation

 .../admin-guide/kernel-parameters.txt         |   2 +
 Documentation/x86/entry_64.rst                |   9 +
 Documentation/x86/x86_64/fsgs.rst             | 199 ++++++++++++++++++
 Documentation/x86/x86_64/index.rst            |   1 +
 arch/x86/entry/calling.h                      |  40 ++++
 arch/x86/entry/entry_64.S                     | 131 +++++++++---
 arch/x86/include/asm/fsgsbase.h               |  45 +++-
 arch/x86/include/asm/inst.h                   |  15 ++
 arch/x86/include/uapi/asm/hwcap2.h            |   3 +
 arch/x86/kernel/cpu/bugs.c                    |   6 +-
 arch/x86/kernel/cpu/common.c                  |  22 ++
 arch/x86/kernel/process.c                     |   9 +-
 arch/x86/kernel/process.h                     |  72 +++++++
 arch/x86/kernel/process_64.c                  | 142 +++++++------
 arch/x86/kernel/ptrace.c                      |  17 +-
 tools/testing/selftests/x86/fsgsbase.c        |  24 ++-
 16 files changed, 608 insertions(+), 129 deletions(-)
 create mode 100644 Documentation/x86/x86_64/fsgs.rst

-- 
2.20.1

