Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B541AAF33
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416385AbgDORLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410725AbgDORLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:11:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D43221D94;
        Wed, 15 Apr 2020 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970661;
        bh=0Ap4gVR11GozJBhoxSUSEWm77eFrY/PRYCBpDri2wcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9HPSGIEQ3dlaLV0kJgl9zhCUB6qfYvAsCl2d9jBgix/uM56/Jk3kqJseL/O3gWSA
         efIbIf3R4mIvdajNRzyoFT9kOFdWYvfycgIId3A8ICV0HZaea7+e4p3f6EUanauim3
         RviqLISy4LOAd+RD4JRghs7vNz16uhWfkguba99E=
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
Subject: [PATCH tip/core/rcu 16/19] rcu: Replace 1 by true
Date:   Wed, 15 Apr 2020 10:10:51 -0700
Message-Id: <20200415171054.9013-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jules Irenge <jbi.octave@gmail.com>

Coccinelle reports a warning at use_softirq declaration

WARNING: Assignment of 0/1 to bool variable

The root cause is
use_softirq a variable of bool type is initialised with the integer 1
Replacing 1 with value true solve the issue.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 09ccc29..97c0b47 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -113,7 +113,7 @@ static struct rcu_state rcu_state = {
 static bool dump_tree;
 module_param(dump_tree, bool, 0444);
 /* By default, use RCU_SOFTIRQ instead of rcuc kthreads. */
-static bool use_softirq = 1;
+static bool use_softirq = true;
 module_param(use_softirq, bool, 0444);
 /* Control rcu_node-tree auto-balancing at boot time. */
 static bool rcu_fanout_exact;
-- 
2.9.5

