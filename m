Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8179720452A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbgFWAWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731593AbgFWAVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84CCD20890;
        Tue, 23 Jun 2020 00:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871714;
        bh=0zcTLldr7M4Ceq2rVbYKJjCl+2rGwuuMCUQOFSYZW/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWcx9VLCY187INCxnUt3px5lN2WfsdCnG4qznyZwg59KcqSfEjeSbe0MuVYUT072x
         SioYfgdSlk7aet6lLBneP4X5RRTKPZle+404U1yGPcBy/r93Ja30jJqa1AsKsTfzG6
         qiwyJaCLLshmqZ7seKHXHVTGZy+cBXcPyh8L2MdE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 26/26] rcu: Remove KCSAN stubs from update.c
Date:   Mon, 22 Jun 2020 17:21:47 -0700
Message-Id: <20200623002147.25750-26-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

KCSAN is now in mainline, so this commit removes the stubs for the
data_race(), ASSERT_EXCLUSIVE_WRITER(), and ASSERT_EXCLUSIVE_ACCESS()
macros.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index a0ba885..f37cebf 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -52,19 +52,6 @@
 #endif
 #define MODULE_PARAM_PREFIX "rcupdate."
 
-#ifndef data_race
-#define data_race(expr)							\
-	({								\
-		expr;							\
-	})
-#endif
-#ifndef ASSERT_EXCLUSIVE_WRITER
-#define ASSERT_EXCLUSIVE_WRITER(var) do { } while (0)
-#endif
-#ifndef ASSERT_EXCLUSIVE_ACCESS
-#define ASSERT_EXCLUSIVE_ACCESS(var) do { } while (0)
-#endif
-
 #ifndef CONFIG_TINY_RCU
 module_param(rcu_expedited, int, 0);
 module_param(rcu_normal, int, 0);
-- 
2.9.5

