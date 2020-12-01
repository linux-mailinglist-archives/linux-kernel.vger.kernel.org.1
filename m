Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E61D2C93B1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgLAANQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:13:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:52438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgLAANP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:13:15 -0500
Received: from localhost.localdomain (mtl93-h04-176-174-252-224.dsl.sta.abo.bbox.fr [176.174.252.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DD5020706;
        Tue,  1 Dec 2020 00:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606781555;
        bh=WTDNX9UCJB11e/l8+PnikxY1jFMtCRxdxh/6oqB6m0c=;
        h=From:To:Cc:Subject:Date:From;
        b=hsv8rojnydEOvm9W/Z89goESJJQPZ9K8nGrxjyOAtw+r3gN7bYJAk2UvN8HhmNbzy
         fnD6PI7v3iaYXvHCCZEkI07YiRVFb2n2madzGgOiaWb7dqPYwLmu+5rEkqyJx7vlkf
         l06ZlJCki0NAWQBrv7PI6CY1nQqtyveKIwN/kpP4=
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
Subject: [PATCH 0/5] irq: Reorder time handling against HARDIRQ_OFFSET on IRQ entry v2
Date:   Tue,  1 Dec 2020 01:12:21 +0100
Message-Id: <20201201001226.65107-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this version, the EXPORT_SYMBOL_GPL() on IRQ time accounting have
been removed since no modules should be calling there.

Link to v1 for reference:
	https://lore.kernel.org/lkml/20201125021542.30237-1-frederic@kernel.org/

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	irq/core

HEAD: 2e6155a86dba7c53d080d58284ef5c65f487bef0

Frederic Weisbecker (5):
  sched/cputime: Remove symbol exports from IRQ time accounting
  sched/vtime: Consolidate IRQ time accounting
  s390/vtime: Convert to consolidated IRQ time accounting
  irqtime: Move irqtime entry accounting after irq offset incrementation
  irq: Call tick_irq_enter() inside HARDIRQ_OFFSET

 arch/ia64/kernel/time.c       | 20 +++++++---
 arch/powerpc/kernel/time.c    | 58 ++++++++++++++++++++--------
 arch/s390/include/asm/vtime.h |  1 -
 arch/s390/kernel/vtime.c      | 58 ++++++++++++++++++----------
 include/linux/hardirq.h       |  4 +-
 include/linux/vtime.h         | 18 ++++-----
 kernel/sched/cputime.c        | 73 +++++++++++++++++++++++++++--------
 kernel/softirq.c              | 16 +++-----
 8 files changed, 167 insertions(+), 81 deletions(-)

-- 
2.25.1

