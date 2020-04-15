Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064801AAF30
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410775AbgDORLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:11:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410728AbgDORLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:11:03 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54D9621D91;
        Wed, 15 Apr 2020 17:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970662;
        bh=rL1sdTIZ7lBkSO1ah125Dy4M0JqYkG/FMNf97VUr4BM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PeM4MmgUVVvlo+3JCSacIuehqy9nLyavfhctOG19/GC3JX7hRUE1akwS4VinvmRGA
         pERvBbQ41Bmfd0mO2xdyt22aVx9v3O5zxIBd2NA61TILoUhSV0NDOiizrhZQGfrCIc
         v70PO6CXbzY4ynBsLvaRMLZTwqOKQZp34Ei5xWIE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 19/19] rcu: Convert rcu_nohz_full_cpu() ULONG_CMP_LT() to time_before()
Date:   Wed, 15 Apr 2020 10:10:54 -0700
Message-Id: <20200415171054.9013-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit converts the ULONG_CMP_LT() in rcu_nohz_full_cpu() to
time_before() to reflect the fact that it is comparing a timestamp to
the jiffies counter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 5cd27c2..5771e32 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2537,7 +2537,7 @@ static bool rcu_nohz_full_cpu(void)
 #ifdef CONFIG_NO_HZ_FULL
 	if (tick_nohz_full_cpu(smp_processor_id()) &&
 	    (!rcu_gp_in_progress() ||
-	     ULONG_CMP_LT(jiffies, READ_ONCE(rcu_state.gp_start) + HZ)))
+	     time_before(jiffies, READ_ONCE(rcu_state.gp_start) + HZ)))
 		return true;
 #endif /* #ifdef CONFIG_NO_HZ_FULL */
 	return false;
-- 
2.9.5

