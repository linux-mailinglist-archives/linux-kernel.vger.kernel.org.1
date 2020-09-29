Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9514127B834
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgI1Xbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:31:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbgI1XbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:31:07 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78AD623A5D;
        Mon, 28 Sep 2020 23:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601335866;
        bh=PMgsGG5FAWr0wRIFGcOtMZzn3uNlhC8t4NOrl9ZokMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MAk55kfbeWDSX5XuL4VkAPUC/KHOU+3WpG1eD9VfjSFZ4h9kK5aUbx5/LpwWl8eEP
         8YUUgbdYvOEvEW3MC8xNExtZ9wSH0baxVoTBngm9Why3R47jbdkJpFi9X36EErqO3n
         zx4yPiAFi2EUwU8fYKwJR/GYHCm5QZzds2DErgTA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, mhocko@kernel.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/15] xtensa: Cleanup PREEMPT_COUNT leftovers
Date:   Mon, 28 Sep 2020 16:30:57 -0700
Message-Id: <20200928233102.24265-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200928233041.GA23230@paulmck-ThinkPad-P72>
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/xtensa/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 703cf62..5a27dd3 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -819,7 +819,7 @@ ENTRY(debug_exception)
 	 * preemption if we have HW breakpoints to preserve DEBUGCAUSE.DBNUM
 	 * meaning.
 	 */
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_HAVE_HW_BREAKPOINT)
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
 	GET_THREAD_INFO(a2, a1)
 	l32i	a3, a2, TI_PRE_COUNT
 	addi	a3, a3, 1
-- 
2.9.5

