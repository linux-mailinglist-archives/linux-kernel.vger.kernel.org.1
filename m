Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A8427D6E8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgI2T3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbgI2T3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:29:45 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFD6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:29:45 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o21so4577077qtp.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQjBA9NgyL26LnUuoSDLOqhNdN/FWjyvKU8svYcqWsk=;
        b=Ce8LTnc8e/zH9MehkioLTQWGUhuleeWSeiMQwntLEhQs92eE59HfRttFq9qE61S2Xw
         0F5HbktYGoepjGQHGS7dw5Re7zLmU4a0zcP3keEqP51Q0tl44DJdrfoSR7VjDnu3kpk9
         ZjEmjob35yN1LhZLsOSWox4kpZZGaUYjZZ95Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQjBA9NgyL26LnUuoSDLOqhNdN/FWjyvKU8svYcqWsk=;
        b=n97LAJsAz/rSIO+R4tdbuc5KVd3QNmJ89ytueC8o7OQaAEF5mryPMuGdu3s1lXZo/d
         7//OoipdXjRAZ7/unqZ649t6cf+ynnlgii14JScm9DYAo9uBq6BKuAjTpXIB8CsQ0NQC
         wXULw03Wyj92qy9MC0sGQ++ANRsRaICuWqS2P2imjEa4A/ub5PXPgw08p7JI7aupZY+r
         oKDs2Ey82vMLgkUJbgdbECOwilAHyCkvN/itib/gwx5kvLyISMrV+RceupRRUMj0GqcD
         LINA9ghZh6tv5GlLh5wy/bntO2c7IQBkLsUN3TcAne1SWsY5J/6ppzeVv6Ogap+8bso6
         4PGg==
X-Gm-Message-State: AOAM531W3JGW2RHi7Sw8lCc1zsnu4iTSgq+uVygE0tqztOXPwClnxSms
        q1GyfVOPgURUVo6h3Nfv+Xp5phwtbuEADw==
X-Google-Smtp-Source: ABdhPJy25X9n2PF95bcmGXJqCqVjaGo9NuWiG7UnaK6M9X2h10n1bvAtigH8Vr5rL4Np5meBMDld5A==
X-Received: by 2002:aed:2f61:: with SMTP id l88mr5024636qtd.262.1601407784422;
        Tue, 29 Sep 2020 12:29:44 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id n7sm6892887qtf.27.2020.09.29.12.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:29:43 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 1/2] rcu/tree: Add a warning if CPU being onlined did not report QS already
Date:   Tue, 29 Sep 2020 15:29:27 -0400
Message-Id: <20200929192928.3749502-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, rcu_cpu_starting() checks to see if the RCU core expects a
quiescent state from the incoming CPU.  However, the current interaction
between RCU quiescent-state reporting and CPU-hotplug operations should
mean that the incoming CPU never needs to report a quiescent state.
First, the outgoing CPU reports a quiescent state if needed.  Second,
the race where the CPU is leaving just as RCU is initializing a new
grace period is handled by an explicit check for this condition.  Third,
the CPU's leaf rcu_node structure's ->lock serializes these checks.

This means that if rcu_cpu_starting() ever feels the need to report
a quiescent state, then there is a bug somewhere in the CPU hotplug
code or the RCU grace-period handling code.  This commit therefore
adds a WARN_ON_ONCE() to bring that bug to everyone's attention.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 55d3700dd1e7..5efe0a98ea45 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4119,7 +4119,9 @@ void rcu_cpu_starting(unsigned int cpu)
 	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
-	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
+
+	/* An incoming CPU should never be blocking a grace period. */
+	if (WARN_ON_ONCE(rnp->qsmask & mask)) { /* RCU waiting on incoming CPU? */
 		rcu_disable_urgency_upon_qs(rdp);
 		/* Report QS -after- changing ->qsmaskinitnext! */
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
-- 
2.28.0.709.gb0816b6eb0-goog

