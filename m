Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252772CBC2F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 12:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgLBL62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 06:58:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbgLBL61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 06:58:27 -0500
From:   Frederic Weisbecker <frederic@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 0/5] irq: Reorder time handling against HARDIRQ_OFFSET on IRQ entry v3
Date:   Wed,  2 Dec 2020 12:57:27 +0100
Message-Id: <20201202115732.27827-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Slightly different design this time. As per Peter and Thomas reviews and
suggestions, use the following layout:

  account_softirq_enter() -> irqtime_account_irq(curr, SOFTIRQ_OFFSET);
  account_softirq_exit()  -> irqtime_account_irq(curr, 0);
  account_hardirq_enter() -> irqtime_account_irq(curr, HARDIRQ_OFFSET);
  account_hardirq_exit()  -> irqtime_account_irq(curr, 0);

So now the preempt count offset is substracted in the cputime dispatch
function and the resulting code is better consolidated.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	irq/core-v3

HEAD: 24a2d6c76759bd4496cbdcd365012c821a984eec

Thanks,
	Frederic
---

Frederic Weisbecker (5):
      sched/cputime: Remove symbol exports from IRQ time accounting
      s390/vtime: Use the generic IRQ entry accounting
      sched/vtime: Consolidate IRQ time accounting
      irqtime: Move irqtime entry accounting after irq offset incrementation
      irq: Call tick_irq_enter() inside HARDIRQ_OFFSET


 arch/Kconfig                  |  7 +++++-
 arch/ia64/kernel/time.c       | 20 ++++++++++++----
 arch/powerpc/kernel/time.c    | 56 ++++++++++++++++++++++++++++++-------------
 arch/s390/Kconfig             |  1 +
 arch/s390/include/asm/vtime.h |  1 -
 arch/s390/kernel/vtime.c      | 51 +++++++++++++++++++++++++--------------
 include/linux/hardirq.h       |  4 ++--
 include/linux/vtime.h         | 42 +++++++++++++++++++-------------
 kernel/sched/cputime.c        | 36 +++++++++++++---------------
 kernel/softirq.c              | 20 +++++++---------
 10 files changed, 148 insertions(+), 90 deletions(-)
