Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21D426E71A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 23:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgIQVHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 17:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbgIQVHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 17:07:47 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6881A21D7B;
        Thu, 17 Sep 2020 21:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600376867;
        bh=/tExeEJ8/c6egD6eYM7a6JORIf/FIWn57CX8Gi2aybg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ij7PiVs6QNZN10LFEowyvgKPywEL8rvgsSMi3bjkqV8/WrDnxSHgbqBO2muzxipt0
         PNfcHhMxOLnH1UZyoQTJ0lMU8OAjuNY6wJ6GhQ7/4r14od6fULuBS0HmpFxRtRrNcw
         QN2wvQzJ7KZdjUF+bK/nhRbBFAGA8rmLbWVdF39Y=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        sfr@canb.auug.org.au, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/8] rcu-tasks: Mark variables static
Date:   Thu, 17 Sep 2020 14:07:38 -0700
Message-Id: <20200917210744.2995-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200917210652.GA31242@paulmck-ThinkPad-P72>
References: <20200917210652.GA31242@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The n_heavy_reader_attempts, n_heavy_reader_updates, and
n_heavy_reader_ofl_updates variables are not used outside of their
translation unit, so this commit marks them static.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 05d3e13..978508e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -745,9 +745,9 @@ static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
 
 // The number of detections of task quiescent state relying on
 // heavyweight readers executing explicit memory barriers.
-unsigned long n_heavy_reader_attempts;
-unsigned long n_heavy_reader_updates;
-unsigned long n_heavy_reader_ofl_updates;
+static unsigned long n_heavy_reader_attempts;
+static unsigned long n_heavy_reader_updates;
+static unsigned long n_heavy_reader_ofl_updates;
 
 void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
 DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
-- 
2.9.5

