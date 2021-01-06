Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFA92EB729
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbhAFAy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:54:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:54914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbhAFAy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:54:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3216522EBD;
        Wed,  6 Jan 2021 00:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894450;
        bh=ugkQbUMpwoVHnz6kyr5XkzfxzaPoBJVpqNIOhWXv3x0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iSFTdJHmo8TnUVo4VgzLUBtCvGhyKVjjE8zbu2jZj8GzG6ZJ15UYjnQCwUprNbb5N
         HYrWmdtTQVHCFIMZBfN1l200cZGZpYFCdmqkdtgHyLhqA8PtM053Y3GbcN5gREQM3v
         EkIBO1cQ9iaYg6V43U+5QaTtE+ZbM+syzTHGmERLIdg6b1MAfK9oBVd6UCfGq3CN5Q
         LwEHOECKEwTLHEBQtJ/93ctA2opOI0LOe+GPLmJnseTE+NPq8LeGY+45Onpy3lJiHz
         +0o92SRACpGhqoBjH3pEEwDbW078A0n9yASQBzDgmjx8jq1aS2mJ8+WOIi5+/hLGhI
         pZ/NqTXrV2zeQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 6/8] doc: Remove obsolete rcutree.rcu_idle_lazy_gp_delay boot parameter
Date:   Tue,  5 Jan 2021 16:54:05 -0800
Message-Id: <20210106005407.12295-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106005334.GA12159@paulmck-ThinkPad-P72>
References: <20210106005334.GA12159@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit removes documentation for the rcutree.rcu_idle_lazy_gp_delay
kernel boot parameter given that this parameter no longer exists.

Fixes: 77a40f97030b ("rcu: Remove kfree_rcu() special casing and lazy-callback handling")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c722ec1..b5baa8a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4179,12 +4179,6 @@
 			Set wakeup interval for idle CPUs that have
 			RCU callbacks (RCU_FAST_NO_HZ=y).
 
-	rcutree.rcu_idle_lazy_gp_delay= [KNL]
-			Set wakeup interval for idle CPUs that have
-			only "lazy" RCU callbacks (RCU_FAST_NO_HZ=y).
-			Lazy RCU callbacks are those which RCU can
-			prove do nothing more than free memory.
-
 	rcutree.rcu_kick_kthreads= [KNL]
 			Cause the grace-period kthread to get an extra
 			wake_up() if it sleeps three times longer than
-- 
2.9.5

