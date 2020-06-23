Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AC620452F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbgFWAW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:22:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731583AbgFWAVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:54 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E934020E65;
        Tue, 23 Jun 2020 00:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871714;
        bh=Q9EmaI2zNZ8aQmraXrV8lyboLZtGt3Rsxhfvg/MyXkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HJuX1VDlQRq22V63VAtTCn71+2YkJxi3nZOUH4Rvp5h7YQncretA8jeKK26SE3KAV
         R/A4QHvvDz7Hhj7geSM2wZD3URYr9jUcCpWIkBr2ezzlxBO/qLMRf6CD4SF4iok/aV
         zfzr2XEpZsx0Oe9WlAXA9E2G7e3TaaQTaDz+Pblw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 23/26] kernel/rcu/tree.c: Fix kernel-doc warnings
Date:   Mon, 22 Jun 2020 17:21:44 -0700
Message-Id: <20200623002147.25750-23-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning:

../kernel/rcu/tree.c:959: warning: Excess function parameter 'irq' description in 'rcu_nmi_enter'

Fixes: cf7614e13c8f ("rcu: Refactor rcu_{nmi,irq}_{enter,exit}()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Byungchul Park <byungchul.park@lge.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0806762..e7161e0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -944,7 +944,6 @@ void __rcu_irq_enter_check_tick(void)
 
 /**
  * rcu_nmi_enter - inform RCU of entry to NMI context
- * @irq: Is this call from rcu_irq_enter?
  *
  * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
  * rdp->dynticks_nmi_nesting to let the RCU grace-period handling know
-- 
2.9.5

