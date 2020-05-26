Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5305E1D1B86
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 18:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389758AbgEMQrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 12:47:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389736AbgEMQr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:47:29 -0400
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25F03207CB;
        Wed, 13 May 2020 16:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589388449;
        bh=hYHHYYaIjhq2WC73z/SlpaRnlEZFHSMmjus8CtbgDLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SvUC75M1tEFamYkQwWEQohI5UKKZSTXDJlkDnf3E7G/ogS/4XJlaEKpwYW2/YKqrP
         Te2wG31CkMGtL3WK88NvZkMeak3lBo2Qx3OuQAlpxbDoVOEhHMKwkMFJrdOrDi9Hux
         +Rl8YHzXhnYKlkG2IEUa83/jvrb9ZwbCikUbK14E=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 05/10] rcu: Remove useless conditional nocb unlock
Date:   Wed, 13 May 2020 18:47:09 +0200
Message-Id: <20200513164714.22557-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200513164714.22557-1-frederic@kernel.org>
References: <20200513164714.22557-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not only is it in the bad order (rdp->nocb_lock should be unlocked after
rnp) but it's also dead code as we are in the !offloaded path.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 804cf7dfff03..cc95419f6491 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3680,7 +3680,6 @@ void rcutree_migrate_callbacks(int cpu)
 		raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled. */
 		__call_rcu_nocb_wake(my_rdp, true, flags);
 	} else {
-		rcu_nocb_unlock(my_rdp); /* irqs remain disabled. */
 		raw_spin_unlock_irqrestore_rcu_node(my_rnp, flags);
 	}
 	if (needwake)
-- 
2.25.0

