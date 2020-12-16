Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E422DC8B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 23:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgLPWFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 17:05:16 -0500
Received: from foss.arm.com ([217.140.110.172]:50108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730068AbgLPWFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 17:05:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E71A730E;
        Wed, 16 Dec 2020 14:04:29 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.25.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E0F83F718;
        Wed, 16 Dec 2020 14:04:27 -0800 (PST)
Date:   Wed, 16 Dec 2020 22:04:22 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        pr-tracker-bot@kernel.org, catalin.marinas@arm.com, will@kernel.org
Subject: [PATCH] arm64: make _TIF_WORK_MASK bits contiguous (was: Re: [GIT
 PULL] TIF_NOTIFY_SIGNAL for all archs)
Message-ID: <20201216220422.GA19075@C02TD0UTHF1T.local>
References: <701d4747-bbbb-dbb4-d828-63d096fcc22a@kernel.dk>
 <160815345901.27795.2544235487408028611.pr-tracker-bot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160815345901.27795.2544235487408028611.pr-tracker-bot@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, Dec 16, 2020 at 09:17:39PM +0000, pr-tracker-bot@kernel.org wrote:
> > git://git.kernel.dk/linux-block.git tags/tif-task_work.arch-2020-12-14
> 
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/005b2a9dc819a1265a8c765595f8f6d88d6173d9

Unfortunately the merge resolution broke the build for arm64 -- could
you please apply the fixup below? IIUC that matches what we did in
linux-next, and builds fine locally.

Thanks,
Mark.

---->8----
From da1826cc5132bb9d46aebdb47fa033f94825a697 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 16 Dec 2020 21:32:48 +0000
Subject: [PATCH] arm64: make _TIF_WORK_MASK bits contiguous

We need the bits of _TIF_WORK_MASK to be contiguous in order to to use
this as an immediate argument to an AND instruction in entry.S.

We happened to change these bits in commits:

  b5a5a01d8e9a44ec ("arm64: uaccess: remove addr_limit_user_check()")
  192caabd4dd92c98 ("arm64: add support for TIF_NOTIFY_SIGNAL")

... which each worked in isolation, but the merge resolution in commit:

  005b2a9dc819a126 ("Merge tag 'tif-task_work.arch-2020-12-14' of git://git.kernel.dk/linux-block")

... happened to make the bits non-contiguous.

Fix this by moving TIF_NOTIFY_SIGNAL to be bit 6, which is contiguous
with the rest of _TIF_WORK_MASK.

Otherwise, we'll get a build-time failure as below:

| arch/arm64/kernel/entry.S: Assembler messages:
| arch/arm64/kernel/entry.S:733: Error: immediate out of range at operand 3 -- `and x2,x19,#((1<<1)|(1<<0)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<7))'
| scripts/Makefile.build:360: recipe for target 'arch/arm64/kernel/entry.o' failed
| make[2]: *** [arch/arm64/kernel/entry.o] Error 1
| scripts/Makefile.build:496: recipe for target 'arch/arm64/kernel' failed
| make[1]: *** [arch/arm64/kernel] Error 2
| Makefile:1805: recipe for target 'arch/arm64' failed
| make: *** [arch/arm64] Error 2

Fixes: 005b2a9dc819a126 ("Merge tag 'tif-task_work.arch-2020-12-14' of git://git.kernel.dk/linux-block")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/thread_info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index b24056a0b02b..9f4e3b266f21 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -64,7 +64,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
 #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
 #define TIF_MTE_ASYNC_FAULT	5	/* MTE Asynchronous Tag Check Fault */
-#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
+#define TIF_NOTIFY_SIGNAL	6	/* signal notifications exist */
 #define TIF_SYSCALL_TRACE	8	/* syscall trace active */
 #define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
 #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
-- 
2.11.0

