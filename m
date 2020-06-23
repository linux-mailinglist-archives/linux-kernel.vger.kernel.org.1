Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E3F204543
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbgFWAYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:24:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731524AbgFWAYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:24:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B8CC207F5;
        Tue, 23 Jun 2020 00:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871885;
        bh=GcBg6ntwDJyu48eVyKptdQCgIvfOwSLRJBixW2jT1j0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HRmXScL7XIZrt43O5a9qVqFMgFtDIu8WXdV8N0Z/uHHisOtJRNj7Od35shy/QND+K
         S2dQK9kIgYZWJHxyqNKO3riSdR5MKTisWSTrDlTr9U40L1UNa+EXSjb1mKCSNCtR0r
         Af2sAx5G1rlpKoGpBwpAadZm6n9GTNOOEJ/C8y+4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/5] rcu-tasks: Add #include of rcupdate_trace.h to update.c
Date:   Mon, 22 Jun 2020 17:24:41 -0700
Message-Id: <20200623002443.25954-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002423.GA25869@paulmck-ThinkPad-P72>
References: <20200623002423.GA25869@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Although this is in some strict sense unnecessary, it is good to allow
the compiler to compare the function declaration with its definition.
This commit therefore adds a #include of linux/rcupdate_trace.h to
kernel/rcu/update.c.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 84843ad..c0fea80 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -42,6 +42,7 @@
 #include <linux/kprobes.h>
 #include <linux/slab.h>
 #include <linux/irq_work.h>
+#include <linux/rcupdate_trace.h>
 
 #define CREATE_TRACE_POINTS
 
-- 
2.9.5

