Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892C9204524
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbgFWAVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:21:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730309AbgFWAVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6759F20720;
        Tue, 23 Jun 2020 00:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871709;
        bh=JWeEvxY1czQrY61YbGMme47ATcktCscWlySH9PAuJx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TXfDUHGRwuP4kp7TtjbOR9fftgnIgYmmDwobs5wuU23smBfmfpIoi/7reD0VHi8EN
         arMdotaPsa4GT/pwxTCnKaUxrqT+JJlCg6Vji6bGiiy0Z8DScRor2pxrhbR9jeNVhH
         RRMP7xB7rcI4H5Hp4E+v0ZyKeLuxUjyIYocsDXyo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Wei Yang <richard.weiyang@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/26] rcu: Initialize and destroy rcu_synchronize only when necessary
Date:   Mon, 22 Jun 2020 17:21:22 -0700
Message-Id: <20200623002147.25750-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richard.weiyang@gmail.com>

The __wait_rcu_gp() function unconditionally initializes and cleans up
each element of rs_array[], whether used or not.  This is slightly
wasteful and rather confusing, so this commit skips both initialization
and cleanup for duplicate callback functions.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 84843ad..f5a82e1 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -390,13 +390,14 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 			might_sleep();
 			continue;
 		}
-		init_rcu_head_on_stack(&rs_array[i].head);
-		init_completion(&rs_array[i].completion);
 		for (j = 0; j < i; j++)
 			if (crcu_array[j] == crcu_array[i])
 				break;
-		if (j == i)
+		if (j == i) {
+			init_rcu_head_on_stack(&rs_array[i].head);
+			init_completion(&rs_array[i].completion);
 			(crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
+		}
 	}
 
 	/* Wait for all callbacks to be invoked. */
@@ -407,9 +408,10 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 		for (j = 0; j < i; j++)
 			if (crcu_array[j] == crcu_array[i])
 				break;
-		if (j == i)
+		if (j == i) {
 			wait_for_completion(&rs_array[i].completion);
-		destroy_rcu_head_on_stack(&rs_array[i].head);
+			destroy_rcu_head_on_stack(&rs_array[i].head);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(__wait_rcu_gp);
-- 
2.9.5

