Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100511D1B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 18:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389723AbgEMQr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 12:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729328AbgEMQrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:47:25 -0400
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5545220671;
        Wed, 13 May 2020 16:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589388445;
        bh=4+3mLFAc10shBxODrs806LYPRqoEl77BGtNpCVGGsoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yLQlp+wVA6ciyaZ2aWBo++unfZRY4a/InfilVeC9PihXnw3Rrqo7jZWSBO84IWCe0
         IZypTUAgNEDcW3jaarTMLf6oK+uh27rbxs5HR/UA/wfCM+AbywQrn8k5THxXcA1AMk
         hPCRHS5WhT+5XiNRR5YjKgZgJqak7utfjR39Zyv0=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 03/10] rcu: Make locking explicit in do_nocb_deferred_wakeup_common()
Date:   Wed, 13 May 2020 18:47:07 +0200
Message-Id: <20200513164714.22557-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200513164714.22557-1-frederic@kernel.org>
References: <20200513164714.22557-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can either be called inline (locally or CPU hotplug locked) when
rdp->nocb_defer_wakeup is pending or from the nocb timer. In both cases
the rdp is offlined and we want to take the nocb lock.

Clarify the locking rules and expectations.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree_plugin.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1d22b16c03e0..1dd3fdd675a1 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2142,9 +2142,9 @@ static void do_nocb_deferred_wakeup_common(struct rcu_data *rdp)
 	unsigned long flags;
 	int ndw;
 
-	rcu_nocb_lock_irqsave(rdp, flags);
+	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
 	if (!rcu_nocb_need_deferred_wakeup(rdp)) {
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 		return;
 	}
 	ndw = READ_ONCE(rdp->nocb_defer_wakeup);
-- 
2.25.0

