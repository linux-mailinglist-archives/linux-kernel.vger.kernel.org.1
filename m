Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10802EB74B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 02:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbhAFBCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 20:02:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbhAFBCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:02:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0515F229EF;
        Wed,  6 Jan 2021 01:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894887;
        bh=8sZUhRn5VAPTai1bqjNuP3yhkMzMUu3vrGnDlahpHQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fLs0SvBN8Li/Z0JxNHB08CuhSfludlrsqeExaOuxDweXxe1XkcjY3mB/8OiHg16BR
         tfmj1TdF/JDKJh4Tct+6DzJyCe65FNE1AHLuFlzJEKACNTPj2//0m92qja6/oQmTze
         /wNhfYU8oTG0z//hJyGMLFKWbfKP9Ir4nReqlKJDC4wVXWTI6pt/mSKCL4x9rn5OLd
         ekFcNHaK9M1ZcYPDK8h3i8GiM9y9frHvUxwr0Mpzv4lTKYYtvbn7NkstGd9CxkWwhi
         6m86wFv8ZzwyNGnCKP6xlqtPbrH/fRjzuJoFSWJfqazFrZszgwI35XTUh0OP5PjY9D
         VBjjOO56tOA3Q==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Zqiang <qiang.zhang@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/3] rcu: Record kvfree_call_rcu() call stack for KASAN
Date:   Tue,  5 Jan 2021 17:01:23 -0800
Message-Id: <20210106010125.12802-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106010102.GA12737@paulmck-ThinkPad-P72>
References: <20210106010102.GA12737@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

This commit adds a call to kasan_record_aux_stack() in kvfree_call_rcu()
in order to record the call stack of the code that caused the object
to be freed.  Please note that this function does not update the
allocated/freed state, which is important because RCU readers might
still be referencing this object.

Acked-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 40e5e3d..2db736c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3498,6 +3498,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		goto unlock_return;
 	}
 
+	kasan_record_aux_stack(ptr);
 	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
 	if (!success) {
 		run_page_cache_worker(krcp);
-- 
2.9.5

