Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BA22EC1F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbhAFRTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:19:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:32780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbhAFRTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:19:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EE422332A;
        Wed,  6 Jan 2021 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953435;
        bh=yipqOx/rP7K7SHQyXFDzCi9dBq2GxO3qShtqmZmEp04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VUl0RcIznUxfw9sbMJepqCRihyvUJq8Wjps6HUPTExBWTXjdm61szCzmTkeBCjgbN
         kDuRvnJ7l6Yjlmi9z4heYtMOgpS8XtuEJk+F+o6q0XQ1Kv/z+124Fvg5LtbmX1rQBo
         BUkyWpcWXE4PCbCLZTHkB6UE1MrH51BbL47Og3eY84NofPZYDZ1Gan2AWqPOxTPKDd
         hM3nWJM7eE5sixIDYxohyuyx7MMGmjsPf/ml0sXE0hceB+CdhONC8ADO4NgVgqRo5/
         o+R+4mrQR7P71x1YA6Yg4z4XTze1sUMSPhVpxspCwn/Mo4NrXWlj+Ohq32FRqv0F5T
         p52XMr2BrsDuQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 17/17] rcutorture: Add rcutree.use_softirq=0 to RUDE01 and TASKS01
Date:   Wed,  6 Jan 2021 09:17:10 -0800
Message-Id: <20210106171710.22239-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106171532.GA20769@paulmck-ThinkPad-P72>
References: <20210106171532.GA20769@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

RCU's rcutree.use_softirq=0 kernel boot parameter substitutes the per-CPU
rcuc kthreads for softirq, which is used in real-time installations.
However, none of the rcutorture scenarios test this parameter.
This commit therefore adds rcutree.use_softirq=0 to the RUDE01 and
TASKS01 rcutorture scenarios, both of which indirectly exercise RCU.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot  | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TASKS01.boot | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot
index 9363708..932a079 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot
@@ -1 +1,2 @@
 rcutorture.torture_type=tasks-rude
+rcutree.use_softirq=0
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKS01.boot b/tools/testing/selftests/rcutorture/configs/rcu/TASKS01.boot
index cd2a188..22cdece 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TASKS01.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKS01.boot
@@ -1 +1,2 @@
 rcutorture.torture_type=tasks
+rcutree.use_softirq=0
-- 
2.9.5

