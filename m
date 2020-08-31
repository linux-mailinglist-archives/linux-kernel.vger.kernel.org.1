Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA15258054
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgHaSI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729281AbgHaSH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:07:56 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA775216C4;
        Mon, 31 Aug 2020 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897275;
        bh=dSRO3iw+g/8K2GNSW3vbCSxB0vUdY4LvGCmhf6THC6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKytA2kQy/jH7It4K+qqGn3XzAgiTaIS0wfeiGsj4VkaRi1t13wqmdCBh3P3fkh2y
         Rc4crmzNl5QTT1ZaibqpGfLgN1MedGr6IFwg2jrkQkX6YkbPPMkfItKW5MLw5kTaxj
         E5NUK0o9Zqh52GrUHYMr25LWftorNM3wooLMwKrk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/19] scftorture: Check unexpected "switch" statement value
Date:   Mon, 31 Aug 2020 11:07:45 -0700
Message-Id: <20200831180749.843-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180731.GA582@paulmck-ThinkPad-P72>
References: <20200831180731.GA582@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a "default" case to the switch statement in
scftorture_invoke_one() which contains a WARN_ON_ONCE() and an assignment
to ->scfc_out to suppress knock-on warnings.  These knock-on warnings
could otherwise cause the user to think that there was a memory-ordering
problem in smp_call_function() instead of a bug in scftorture.c itself.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 9180de7..d9c01c7 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -357,6 +357,10 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		}
 		smp_call_function(scf_handler, scfcp, scfsp->scfs_wait);
 		break;
+	default:
+		WARN_ON_ONCE(1);
+		if (scfcp)
+			scfcp->scfc_out = true;
 	}
 	if (scfcp && scfsp->scfs_wait) {
 		if (WARN_ON_ONCE(!scfcp->scfc_out))
-- 
2.9.5

