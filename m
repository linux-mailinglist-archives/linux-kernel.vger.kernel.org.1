Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDE02B1AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKMMPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:15:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgKMMO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:14:29 -0500
Received: from localhost.localdomain (unknown [176.167.84.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDECD22253;
        Fri, 13 Nov 2020 12:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605269669;
        bh=EBZKzn6LedivSXXa85Fk1rGqa5mznqFaqXufTWQn4xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hUqT2vN3Z2N88B3kcxZq5lSakDcReCcCC0zXErlvBG9nUdTXRuqIitHHuXrVvZsSP
         gzPQJ04EBNzv1cdwPkH+gPPgAflkGVWP9RZxkRaylwB6DJczRSnYI9V66TlcaBj/Qv
         82vYhFshE4/X99ZTGZCRbhfd1ayUeiYNny/Z1jt8=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: [PATCH 15/19] rcutorture: Remove weak nocb declarations
Date:   Fri, 13 Nov 2020 13:13:30 +0100
Message-Id: <20201113121334.166723-16-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113121334.166723-1-frederic@kernel.org>
References: <20201113121334.166723-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

("rcutorture: Test runtime toggling of CPUs' callback offloading") should
be moved on top of this pile and include this fixup.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 022a86722518..8358c7b7d491 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1580,9 +1580,6 @@ rcu_torture_reader(void *arg)
 	return 0;
 }
 
-void __weak rcu_nocb_cpu_offload(int cpu) {}
-void __weak rcu_nocb_cpu_deoffload(int cpu) {}
-
 /*
  * Randomly Toggle CPUs' callback-offload state.  This uses hrtimers to
  * increase race probabilities and fuzzes the interval between toggling.
-- 
2.25.1

