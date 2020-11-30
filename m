Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E782C8BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgK3RvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:51:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgK3RvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:51:20 -0500
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 001962074A;
        Mon, 30 Nov 2020 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606758640;
        bh=PtvDTo7tVMct9zxtqKWYldLx76hz9d7Z8Jj3vHXV5sc=;
        h=From:To:Cc:Subject:Date:From;
        b=ibwt3G1jDq56t3e8ImHKCv1F22rOJADBnOE+Dq/izBqIrEjbI7G/cVXfhr7qX09Jy
         jwedALc+Ty4bJqyuX7EMRHkS7Cr78ldqVF6LpDh666IFZ+nM6Ubetka0+2Knoap8CJ
         pv1Ml9iG0rf+ZPaPTVsDxFkZhFCHQYb9Kly/1qAI=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/3] membarrier fixes
Date:   Mon, 30 Nov 2020 09:50:32 -0800
Message-Id: <cover.1606758530.git.luto@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all-

x86's sync_core_before_usermode() was bogus.  Without the other
patches applied, it would never be called in a problematic context,
but that's about to change.  In any event, sync_core_before_usermode()
should be correct.

The second patch fixes a minor issue, but it also makes the third patch
nicer.

The third patch is the biggie.  The old code looped over all CPUs
without disabling migration, and it skipped the current CPU.  There
were comments about how the scheduler's barriers made this okay.  This
may well be true, but it was a mess, and it's considerably simpler to
treat the current CPU just like all other CPUs.

The messy skip-the-current-CPU code masked what seems to be a couple
of much bigger issues: if the membarrier() syscall ran all the way
through _without_ being preempted, it completely failed to operate on
the calling thread.  The smp_mb() calls sprinkled through the function
would mask this problem for the normal barrier mode, but they wouldn't
help for the core-serializing mode or rseq_preempt mode.  In other
words, modifying some code, calling
membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE, 0), and running
that modified code was not actually safe.  This seems to rather defeat
the purpose.

Some or all of this might be -stable material.

The global_expedited code looks similarly nasty.  Any volunteers to
clean it up?

Andy Lutomirski (3):
  x86/membarrier: Get rid of a dubious optimization
  membarrier: Add an actual barrier before rseq_preempt()
  membarrier: Propagate SYNC_CORE and RSEQ actions more carefully

 arch/x86/include/asm/sync_core.h |   9 +--
 arch/x86/mm/tlb.c                |   6 +-
 kernel/sched/membarrier.c        | 102 ++++++++++++++++++++++---------
 3 files changed, 83 insertions(+), 34 deletions(-)

-- 
2.28.0

