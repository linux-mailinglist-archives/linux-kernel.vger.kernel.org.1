Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396022A8AAC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbgKEXY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:24:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732444AbgKEXY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:24:57 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8499321556;
        Thu,  5 Nov 2020 23:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604618696;
        bh=xZ9L/apW0pUh2TqsfHceNlDA6KM+emgVem8vXOqPGL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eTW66/eM2gzmcAQ+MjsaIgqeehJonNr0M8oL2ab/xrljKqIShsdPyIiqTi1GEwtz+
         Rx7icO0NRSWnL+KAncKu0MA2F/CkprRI7dWjJ47akUi0yikmqtdDMvykb8zC6k1XzL
         DFqFVuZ5uP8YmeKEzzbAF6+wdqY6HvFub2u6NGWg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Jakub Kicinski <kuba@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/7] net: Un-hide lockdep_sock_is_held() for !LOCKDEP
Date:   Thu,  5 Nov 2020 15:24:50 -0800
Message-Id: <20201105232454.19919-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105232345.GA19179@paulmck-ThinkPad-P72>
References: <20201105232345.GA19179@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

Currently, variables used only within lockdep expressions are flagged
as unused, requiring that these variables' declarations be decorated
with either #ifdef or __maybe_unused.  This results in ugly code.
This commit therefore causes the lockdep_sock_is_held() function to be
visible even when lockdep is not enabled, thus removing the need for
these decorations.  This approach further relies on dead-code elimination
to remove any references to functions or variables that are not available
in non-lockdep kernels.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/net/sock.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index a5c6ae7..198d548 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1566,13 +1566,11 @@ do {									\
 	lockdep_init_map(&(sk)->sk_lock.dep_map, (name), (key), 0);	\
 } while (0)
 
-#ifdef CONFIG_LOCKDEP
 static inline bool lockdep_sock_is_held(const struct sock *sk)
 {
 	return lockdep_is_held(&sk->sk_lock) ||
 	       lockdep_is_held(&sk->sk_lock.slock);
 }
-#endif
 
 void lock_sock_nested(struct sock *sk, int subclass);
 
-- 
2.9.5

