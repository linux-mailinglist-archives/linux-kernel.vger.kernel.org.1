Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F702EB916
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 05:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbhAFEuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 23:50:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:33366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbhAFEuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 23:50:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5082230FC;
        Wed,  6 Jan 2021 04:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908539;
        bh=DIO0eY77jlMD4O2dMKMXcweDuDIG/CCwsKDWfgWKbkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mRftl8KVPmN72nvp8w4f2Wqc9fNnVybCxuLCBxApslUGrgFEkRLiLCS9ONBlLn+3a
         Rn/bPg/UUcijbKjNo3yUEGlqFoHP9Da6Iyoq6Q+fehsno8bgWPIZ+eScTuO0bk32Vy
         l8HkmxwNJ4c+o6kJl1dOkwp5z/bPvC465t7771oFPVuB1D5RO++udge+Xy5pww9NMN
         7DM6K+LZ8+AtVtBrMenQRD2TAuUPaqYN8tOWQDekYqpToHc5VCM0ZrCVpWRSnfEUxU
         jLEAwJ81aigPHEhvo/xEYz5GqUPgEXVu6467FvIv7QooJBGd+wi2RRXrnLpAaEAD/W
         yUU5WbKT8SLSA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 19/21] rcu/nocb: Add nocb CB kthread list to show_rcu_nocb_state() output
Date:   Tue,  5 Jan 2021 20:48:51 -0800
Message-Id: <20210106044853.20812-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit improves debuggability by indicating laying out the order
in which rcuoc kthreads appear in the ->nocb_next_cb_rdp list.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 5ee1113..bc63a6b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2730,6 +2730,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 	sprintf(bufr, "%ld", rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
 	pr_info("   CB %d^%d->%d %c%c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
 		rdp->cpu, rdp->nocb_gp_rdp->cpu,
+		rdp->nocb_next_cb_rdp ? rdp->nocb_next_cb_rdp->cpu : -1,
 		"kK"[!!rdp->nocb_cb_kthread],
 		"bB"[raw_spin_is_locked(&rdp->nocb_bypass_lock)],
 		"cC"[!!atomic_read(&rdp->nocb_lock_contended)],
-- 
2.9.5

