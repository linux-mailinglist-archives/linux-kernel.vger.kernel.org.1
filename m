Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8971220456C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbgFWAby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731664AbgFWAaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E3320842;
        Tue, 23 Jun 2020 00:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872217;
        bh=NikS6kZnJMgfWoKPGbJkJ7wcM3dKwmIyQMIP+gNRW3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lW18rELvBcG5P/gw3h4KtzvoPbD183FWVQs9E6efVbxIDvE9l+S7xhnUKbuliGY5i
         TSgsMnWdY0w9y10FjmcGAZah6cMEwkFz2xy7qmJDe5WAcVeadFkMevkZlLVJnmU/8i
         NOI2UhRvfdU6mrNB8rHX80mUtOmrpegsIgXSbWAs=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/30] refperf: Make functions static
Date:   Mon, 22 Jun 2020 17:29:55 -0700
Message-Id: <20200623003013.26252-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Because the reset_readers() and process_durations() functions are used
only within kernel/rcu/refperf.c, this commit makes them static.

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index fc940e3..0a900f3 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -283,7 +283,7 @@ ref_perf_reader(void *arg)
 	return 0;
 }
 
-void reset_readers(void)
+static void reset_readers(void)
 {
 	int i;
 	struct reader_task *rt;
@@ -296,7 +296,7 @@ void reset_readers(void)
 }
 
 // Print the results of each reader and return the sum of all their durations.
-u64 process_durations(int n)
+static u64 process_durations(int n)
 {
 	int i;
 	struct reader_task *rt;
-- 
2.9.5

