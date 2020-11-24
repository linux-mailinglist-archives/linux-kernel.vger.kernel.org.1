Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18362C292A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388560AbgKXOO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:14:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbgKXOO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:14:56 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CADBF2063A;
        Tue, 24 Nov 2020 14:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606227296;
        bh=F30Bz9YLwr55lsxo6wyzgBYBg7fy7ZlU/lXDWGUcwyo=;
        h=From:To:Cc:Subject:Date:From;
        b=MBZN3c7k1F0VLck3VV8cjLn/E4zVyVpLdryZA32f7T7PeIZX/HlUwNA1PhlYrh7Ls
         +mDLLgB9aZxqe8HsldcKb84jnvsBC5jvCk/3Vb34BKpeXuRbVJOMQ0BYS71+AUzjNO
         CtXX45y7NH4ui/QiYxJjllyQrUVhKp4nmpNCI/0k=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1khZ5p-00DGcy-Iq; Tue, 24 Nov 2020 14:14:53 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
Subject: [PATCH v2 0/6] arm/arm64: Allow the rescheduling IPI to bypass irq_enter/exit
Date:   Tue, 24 Nov 2020 14:14:43 +0000
Message-Id: <20201124141449.572446-1-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, tglx@linutronix.de, Valentin.Schneider@arm.com, peterz@infradead.org, mark.rutland@arm.com, linux@arm.linux.org.uk, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second version of my earlier series [1], which aims at
fixing (or papering over, depending on how you look at things) a
performance regression seen on arm64 for reched IPI heavy workloads
(such as "perf bench sched pipe").

As eloquently described by Thomas in his earlier replies [2], the
current situation is less than ideal on most architecture except x86,
and my conclusion is that what was broken in 5.9 wouldn't be more
broken in 5.10 with these patches (and addresses the performance
regression).

Needless to say, I intend to try and help fixing the issues Thomas
mentioned, and I believe that Mark (cc'd) already has something that
could be used as a healthy starting point (Mark, do correct me if I
misrepresented your work).

Thanks,

	M.

* From v1:
  - Added a new __irq_modify_status() helper
  - Renamed IRQ_NAKED to IRQ_RAW
  - Renamed IRQ_HIDDEN to IRQ_IPI
  - Applied the same workaround to 32bit ARM for completeness

[1] https://lore.kernel.org/r/20201101131430.257038-1-maz@kernel.org/
[2] https://lore.kernel.org/r/87lfewnmdz.fsf@nanos.tec.linutronix.de/

Marc Zyngier (6):
  genirq: Add __irq_modify_status() helper to clear/set special flags
  genirq: Allow an interrupt to be marked as 'raw'
  arm64: Mark the recheduling IPI as raw interrupt
  arm: Mark the recheduling IPI as raw interrupt
  genirq: Drop IRQ_HIDDEN from IRQF_MODIFY_MASK
  genirq: Rename IRQ_HIDDEN to IRQ_IPI

 arch/arm/Kconfig        |  1 +
 arch/arm/kernel/smp.c   |  6 +++++-
 arch/arm64/Kconfig      |  1 +
 arch/arm64/kernel/smp.c |  6 +++++-
 include/linux/irq.h     | 11 ++++++++---
 kernel/irq/Kconfig      |  3 +++
 kernel/irq/chip.c       | 12 ++++++++++--
 kernel/irq/debugfs.c    |  3 ++-
 kernel/irq/irqdesc.c    | 17 ++++++++++++-----
 kernel/irq/proc.c       |  2 +-
 kernel/irq/settings.h   | 33 +++++++++++++++++++++++++++------
 11 files changed, 75 insertions(+), 20 deletions(-)

-- 
2.28.0

