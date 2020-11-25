Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08402C36A4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 03:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgKYCPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 21:15:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:38062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgKYCPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:15:48 -0500
Received: from localhost.localdomain (unknown [94.238.200.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A0B32075A;
        Wed, 25 Nov 2020 02:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606270548;
        bh=K3URZ8EWQ5J0esRj2c+St3iSMo4ccLVWar922WMeUC4=;
        h=From:To:Cc:Subject:Date:From;
        b=tuzw5s5EENva+wz5up3kqkjaVshLtl7duQYJ97eDWDdvdP9JnsQQ2Ka33i4Ur3pFM
         UyX6BwQxp2WhTms8sH9gCvZRNJI0JcxjpH1FI0CcMAcdHz3QuFARhD5fVeA5frz6Xv
         w/Ou7knK2OiqyBWqw6dvSxCYPxP3vSwtKUASL7pw=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [RFC PATCH 0/4] irq: Reorder time handling against HARDIRQ_OFFSET on IRQ entry
Date:   Wed, 25 Nov 2020 03:15:38 +0100
Message-Id: <20201125021542.30237-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two issues with the current layout of tick_irq_enter() as
it's called before HARDIRQ_OFFSET is incremented:

1) It's not correctly handled by lockdep which doesn't consider it as
   hardirq context. And jiffies/timekeeping update take a few interesting
   locks.

2) Softirqs need to be explicitly disabled around it to prevent ksoftirqd
   from being spuriously woken up.

The current call dependency prevents tick_irq_enter() from being moved
after HARDIRQ_OFFSET: account_irq_enter_time() needs to be called before
HARDIRQ_OFFSET incrementation due to cputime index dispatch and it must
be called after tick_irq_enter() which updates the clocks that may be
necessary for cputime accounting.

Here is a proposal to fix this layout.

(The EXPORT_SYMBOL_GPL() in vtime will likely disappear in the next take
as they don't seem to be necessary anymore, but I'll need to check
that thoroughly).

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	irq/core

HEAD: 9502ee20aed8bb847176e1d7d83ccd0625430744


Frederic Weisbecker (4):
  sched/vtime: Consolidate IRQ time accounting
  s390/vtime: Convert to consolidated IRQ time accounting
  irqtime: Move irqtime entry accounting after irq offset incrementation
  irq: Call tick_irq_enter() inside HARDIRQ_OFFSET

 arch/ia64/kernel/time.c       | 22 +++++++---
 arch/powerpc/kernel/time.c    | 60 ++++++++++++++++++++--------
 arch/s390/include/asm/vtime.h |  1 -
 arch/s390/kernel/vtime.c      | 60 ++++++++++++++++++----------
 include/linux/hardirq.h       |  4 +-
 include/linux/vtime.h         | 18 ++++-----
 kernel/sched/cputime.c        | 75 +++++++++++++++++++++++++++--------
 kernel/softirq.c              | 16 +++-----
 8 files changed, 176 insertions(+), 80 deletions(-)

-- 
2.25.1

