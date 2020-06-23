Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128FB204527
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbgFWAV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:21:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731479AbgFWAVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43C1A2082F;
        Tue, 23 Jun 2020 00:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871710;
        bh=l/5OxXTJUaadxs5ujpcQB3Tr8YHob3UxwmULMGrr83k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xPTGQVb6yr3I+9W7K0uCD4WJah4Bz7UQCd6b4XB2tTZe0Pa4+uOH7ONbQnqSszbxj
         RGM1XukcgVomK/xwfm94OXelj96gGk/QpAUv/xox5sgLvc5U9E/NE8Q6OItso9ff4m
         j6Dx+i4AJEqrwtoBdHuxymjEjt6k53r03jPTamAY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/26] rcu: Add comment documenting rcu_callback_map's purpose
Date:   Mon, 22 Jun 2020 17:21:26 -0700
Message-Id: <20200623002147.25750-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_callback_map lockdep_map structure was added back in 2013, but
its purpose has become obscure.  This commit therefore documments that the
purpose of rcu_callback map is, in the words of commit 24ef659a857 ("rcu:
Provide better diagnostics for blocking in RCU callback functions"),
to help lockdep to tie an "inappropriate voluntary context switch back
to the fact that the function is being invoked from within a callback."

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index f5a82e1..ca17b77 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -279,6 +279,7 @@ struct lockdep_map rcu_sched_lock_map = {
 };
 EXPORT_SYMBOL_GPL(rcu_sched_lock_map);
 
+// Tell lockdep when RCU callbacks are being invoked.
 static struct lock_class_key rcu_callback_key;
 struct lockdep_map rcu_callback_map =
 	STATIC_LOCKDEP_MAP_INIT("rcu_callback", &rcu_callback_key);
-- 
2.9.5

