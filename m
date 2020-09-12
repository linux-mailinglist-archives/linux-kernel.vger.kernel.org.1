Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F0C267870
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 09:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgILHGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 03:06:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45262 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgILHGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 03:06:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 02F1129AFA5
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     hpa@zytor.com, bp@alien8.de, rric@kernel.org, peterz@infradead.org,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 0/6] Prepare for removal of TIF_IA32 and TIF_X32
Date:   Sat, 12 Sep 2020 03:05:47 -0400
Message-Id: <20200912070553.330622-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are running out of TI flags for x86.  This patchset removes several
usages of TIF_IA32 and TIF_x32 in preparation to reclaim these flags.
After these cleanups, there is still one more user for both of them,
which I need to take a better look before removing.

Many of the ideas for this patchset came from Andy Lutomirski (Thank
you!)

These were tested by exercising these paths with x32 and ia32 binaries.

Gabriel Krisman Bertazi (6):
  x86: events: Avoid TIF_IA32 when checking 64bit mode
  x86: Simplify compat syscall userspace allocation
  x86: oprofile: Avoid TIF_IA32 when checking 64bit mode
  x86: elf: Use e_machine to choose DLINFO in compat
  x86: elf: Use e_machine to select start_thread for x32
  x86: elf: Use e_machine to select setup_additional_pages for x32

 arch/x86/entry/vdso/vma.c     | 21 ++++++++++++---------
 arch/x86/events/core.c        |  2 +-
 arch/x86/events/intel/ds.c    |  2 +-
 arch/x86/events/intel/lbr.c   |  2 +-
 arch/x86/include/asm/compat.h | 15 +++++++--------
 arch/x86/include/asm/elf.h    | 24 ++++++++++++++++++------
 arch/x86/kernel/perf_regs.c   |  2 +-
 arch/x86/kernel/process_64.c  | 11 +++++++----
 arch/x86/oprofile/backtrace.c |  2 +-
 9 files changed, 49 insertions(+), 32 deletions(-)

-- 
2.28.0

