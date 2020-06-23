Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E862045E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbgFWAjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732024AbgFWAhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5853E20B80;
        Tue, 23 Jun 2020 00:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872675;
        bh=59g/82BSlaIY56f9P3jZTbbeHHZU54Rs4Q/8tqRRM1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v4cxGF3DvowyXFJbsJUsP7YdCgPUg03IC627MVC08/MMYV3P1oeoX6BdYO8xd3Dbk
         lCw+dvzLUiBjaYKYRTlXZkRJB960lrY9cCKKSeifp2m901RrIUOYaBJWQsg6o/KmzN
         yyF7QJdUrnNNTunFeZydG/Jj4FEAV3z5r9I5ZxDY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/23] rcutorture: NULL rcu_torture_current earlier in cleanup code
Date:   Mon, 22 Jun 2020 17:37:36 -0700
Message-Id: <20200623003752.26872-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, the rcu_torture_current variable remains non-NULL until after
all readers have stopped.  During this time, rcu_torture_stats_print()
will think that the test is still ongoing, which can result in confusing
dmesg output.  This commit therefore NULLs rcu_torture_current immediately
after the rcu_torture_writer() kthread has decided to stop, thus informing
rcu_torture_stats_print() much sooner.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2621a33..5911207 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1172,6 +1172,7 @@ rcu_torture_writer(void *arg)
 					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
 				}
 	} while (!torture_must_stop());
+	rcu_torture_current = NULL;  // Let stats task know that we are done.
 	/* Reset expediting back to unexpedited. */
 	if (expediting > 0)
 		expediting = -expediting;
@@ -2473,7 +2474,6 @@ rcu_torture_cleanup(void)
 					     reader_tasks[i]);
 		kfree(reader_tasks);
 	}
-	rcu_torture_current = NULL;
 
 	if (fakewriter_tasks) {
 		for (i = 0; i < nfakewriters; i++) {
-- 
2.9.5

