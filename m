Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8602045E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbgFWAix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731416AbgFWAh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:56 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE5C820C09;
        Tue, 23 Jun 2020 00:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872676;
        bh=JjiUY0w10Rh3FTkAOTcU53st0DLmM/ZIl0uVn9RD0L4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=00esUJAZ81+pnnKqAgvq71I6tLEdPde0JTd1UlDd0D55qJ6eqDuGe1ah9eaTSD9y1
         HR0imkq2SdZwHYqJ8KH4OsJ4aT2Kp2EfD2kZEyhyH2Eqc3LICFBs7DAEweDJ12qesL
         hPDEqPrDDYXqAWk+AbJn81ksS22YndeWDGfBTowU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Jules Irenge <jbi.octave@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/23] rcu/rcutorture: Replace 0 with false
Date:   Mon, 22 Jun 2020 17:37:39 -0700
Message-Id: <20200623003752.26872-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jules Irenge <jbi.octave@gmail.com>

Coccinelle reports a warning

WARNING: Assignment of 0/1 to bool variable

The root cause is that the variable lastphase is a bool, but is
initialised with integer 0.  This commit therefore replaces the 0 with
a false.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5911207..37455a1 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2185,7 +2185,7 @@ static void rcu_torture_barrier1cb(void *rcu_void)
 static int rcu_torture_barrier_cbs(void *arg)
 {
 	long myid = (long)arg;
-	bool lastphase = 0;
+	bool lastphase = false;
 	bool newphase;
 	struct rcu_head rcu;
 
-- 
2.9.5

