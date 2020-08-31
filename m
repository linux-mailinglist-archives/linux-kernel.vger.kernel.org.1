Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB1F258029
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgHaSDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728418AbgHaSBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:22 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CE2221532;
        Mon, 31 Aug 2020 18:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896881;
        bh=SqcLCzy/pd6sy2To5gbz8hyUj0ALD01FMFdhcisgvcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uk/QvhUuTt7wLN4MziZldXUz4KVANAnVezdI/mU72BD1tEIGfLsc1E6sUqWJ0GiKE
         9mtHejoFB1dj86UV6tFO91Ms+mcSDUn6B6dcUtOJkECoVuiAxMU7ugwb0A3GtlcN+x
         jXJ3mR5841Q45xUvATFQp3gxhwsE8qtSqlU+iQQk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/24] nocb: Clarify RCU nocb CPU error message
Date:   Mon, 31 Aug 2020 11:00:59 -0700
Message-Id: <20200831180116.32690-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

A message of the form "rcu:    !!! lDTs ." can be tracked down, but
doing so is not trivial.  This commit therefore eases this process by
adding text so that this error message now reads as follows:
"rcu:    nocb GP activity on CB-only CPU!!! lDTs ."

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 982fc5b..bbc0c07 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2417,7 +2417,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 	    !waslocked && !wastimer && !wassleep)
 		return;  /* Nothing untowards. */
 
-	pr_info("   !!! %c%c%c%c %c\n",
+	pr_info("   nocb GP activity on CB-only CPU!!! %c%c%c%c %c\n",
 		"lL"[waslocked],
 		"dD"[!!rdp->nocb_defer_wakeup],
 		"tT"[wastimer],
-- 
2.9.5

