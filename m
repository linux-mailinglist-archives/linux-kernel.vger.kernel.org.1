Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7152A8A63
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbgKEXFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:05:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732361AbgKEXFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:05:14 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9A0A22201;
        Thu,  5 Nov 2020 23:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617514;
        bh=iRHP2IqnmL6mnyfoNQoStn17D1f2xwzcsuBx0FmqnXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1SYM4T6TFheD4t+AwrSLoOAVK2G04PxtGHXvIJyLxWRJOc4NgVgUKj4+ePOGycR6
         subP+LFjZsEpSZrknRNb5LjzR2fpmGCumWhigMHrvmOSN0jWVPTK5271MmrierV1Sj
         RtxzZd9itIruRW/EV7qvhvIJHTfXJm+a9lURY/dY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, Hui Su <sh_def@163.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 4/4] docs/rcu: Update the call_rcu() API
Date:   Thu,  5 Nov 2020 15:05:10 -0800
Message-Id: <20201105230510.18660-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230444.GA18574@paulmck-ThinkPad-P72>
References: <20201105230444.GA18574@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Su <sh_def@163.com>

This commit updates the documented API of call_rcu() to use the
rcu_callback_t typedef instead of the open-coded function definition.

Signed-off-by: Hui Su <sh_def@163.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/whatisRCU.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index fb3ff76..1a4723f 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -497,8 +497,7 @@ long -- there might be other high-priority work to be done.
 In such cases, one uses call_rcu() rather than synchronize_rcu().
 The call_rcu() API is as follows::
 
-	void call_rcu(struct rcu_head * head,
-		      void (*func)(struct rcu_head *head));
+	void call_rcu(struct rcu_head *head, rcu_callback_t func);
 
 This function invokes func(head) after a grace period has elapsed.
 This invocation might happen from either softirq or process context,
-- 
2.9.5

