Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA6725803E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgHaSF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728999AbgHaSEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:04:09 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBA3521582;
        Mon, 31 Aug 2020 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897049;
        bh=g0hpcrkEi54ga7ismJwBhjJEbD+UQ5S53wU+Ac2tE0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rMgvONI7/fkvhW+bRZyl1g+3oxm9AC041NL3rZnFkkc9pawFg/XXG/Q+UvpjiMaVw
         eaL/4UQW3ht4E9RhIjszpRvvKqn4nsWyBx4Gn5zFPU3mmwazPHVrboGgEpqUaPOeNy
         gxRGK7AuIBr4F5RksmTmsU71alUJVKgj4cfDl5e8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/14] locktorture: Make function torture_percpu_rwsem_init() static
Date:   Mon, 31 Aug 2020 11:03:56 -0700
Message-Id: <20200831180406.494-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180348.GA416@paulmck-ThinkPad-P72>
References: <20200831180348.GA416@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

The sparse tool complains as follows:

kernel/locking/locktorture.c:569:6: warning:
 symbol 'torture_percpu_rwsem_init' was not declared. Should it be static?

And this function is not used outside of locktorture.c,
so this commit marks it static.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 9cfa5e8..62d215b 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -566,7 +566,7 @@ static struct lock_torture_ops rwsem_lock_ops = {
 #include <linux/percpu-rwsem.h>
 static struct percpu_rw_semaphore pcpu_rwsem;
 
-void torture_percpu_rwsem_init(void)
+static void torture_percpu_rwsem_init(void)
 {
 	BUG_ON(percpu_init_rwsem(&pcpu_rwsem));
 }
-- 
2.9.5

