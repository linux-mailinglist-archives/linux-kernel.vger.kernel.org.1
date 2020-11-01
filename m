Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1ACB2A1E3B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 14:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgKANOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 08:14:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgKANOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 08:14:40 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EBEF20870;
        Sun,  1 Nov 2020 13:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604236480;
        bh=0TxCwqvhZ/rly8WLeRqIopvHRJn6Q9BPMUln/824/mc=;
        h=From:To:Cc:Subject:Date:From;
        b=lyAvZCrNgqsRwxIdnMaywVpp/6BNrGy9TFuAw7EDcJkTthjDXKvM5sba5CsyLKtVS
         LsUVOu1YV0yjeFo4RJxZ6RRV//4JNMEh9IcRczbsDbbfJCHy6oOSyQ2qN8lJ23k9du
         jJjSuAwaq05m7DBzavHkEApYtcDjxzE5Ckzqqwos=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kZDBu-006QYT-3n; Sun, 01 Nov 2020 13:14:38 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: [PATCH 0/2] arm64: Allow the rescheduling IPI to bypass irq_enter/exit
Date:   Sun,  1 Nov 2020 13:14:28 +0000
Message-Id: <20201101131430.257038-1-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, tglx@linutronix.de, Valentin.Schneider@arm.com, peterz@infradead.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent recently reported [1] that 5.10-rc1 showed a significant
regression when running "perf bench sched pipe" on arm64, and
pinpointed it to the recent move to handling IPIs as normal
interrupts.

The culprit is the use of irq_enter/irq_exit around the handling of
the rescheduling IPI, meaning that we enter the scheduler right after
the handling of the IPI instead of deferring it to the next preemption
event. This accounts for most of the overhead introduced.

On architectures that have architected IPIs at the CPU level (x86
being the obvious one), the absence of irq_enter/exit is natural. ARM
(both 32 and 64bits) mimicked this behaviour by having some
arch-specific handling for the interrupts that are used to implement
IPIs. Moving IPIs on the normal interrupt path introduced the
regression.

This couple of patches try to acknowledge the fact that some IPIs are
"special", in the sense that they don't need to follow the standard
interrupt handling flow.

The good news is that it cures the regression on arm64, and could
be similarly beneficial to both 32bit ARM, MIPS, or any other
architecture that uses a unique IRQ to represent the scheduler IPI.

The bad news is that these patches are ugly as sin, and I really don't
like them. I specially hate that they can give driver authors the idea
that they can make random interrupts "faster".

Comments, suggestions and hate mails appreciated, as always.

	M.

[1] https://lore.kernel.org/r/CAKfTPtDjPpri5Gt6kLeFp_B_zJUZ5DYXEqtJ+0VKohU-y9bFEQ@mail.gmail.com

Marc Zyngier (2):
  genirq: Allow an interrupt to be marked as 'naked'
  arm64: Mark the recheduling IPI as naked interrupt

 arch/arm64/kernel/smp.c |  4 ++++
 include/linux/irq.h     |  4 +++-
 kernel/irq/debugfs.c    |  1 +
 kernel/irq/irqdesc.c    | 17 ++++++++++++-----
 kernel/irq/settings.h   |  7 +++++++
 5 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.28.0

