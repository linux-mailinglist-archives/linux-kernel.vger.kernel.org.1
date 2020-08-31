Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9FA257FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 19:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgHaRy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 13:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbgHaRy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:54:57 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4839C21527;
        Mon, 31 Aug 2020 17:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896496;
        bh=i75OvD9EoRcIr5Io3wLC+xC5GgIiF+qGDlv+KiQ85L4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NStNTMD+JndnMAKJObOlgpnZPaQwSl+RNJBfFjUeQeUYzqmaBbmnzvO2T6ByOpTMN
         Sjx26MNurvC2sJgREFv4Kaslwn1r4PIBxrcNYYdpwnF8ngpd0OHKvU3XeFDHeCHOhK
         Kc6EMG81JshlviI42Sn/FfUVZKkuf2vPfJfADIvI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/3] doc: Drop doubled words from RCU requirements documentation
Date:   Mon, 31 Aug 2020 10:54:52 -0700
Message-Id: <20200831175452.32381-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831175419.GA31013@paulmck-ThinkPad-P72>
References: <20200831175419.GA31013@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled words "to" and "for".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: rcu@vger.kernel.org
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 8f41ad0..1ae79a1 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2162,7 +2162,7 @@ scheduling-clock interrupt be enabled when RCU needs it to be:
    this sort of thing.
 #. If a CPU is in a portion of the kernel that is absolutely positively
    no-joking guaranteed to never execute any RCU read-side critical
-   sections, and RCU believes this CPU to to be idle, no problem. This
+   sections, and RCU believes this CPU to be idle, no problem. This
    sort of thing is used by some architectures for light-weight
    exception handlers, which can then avoid the overhead of
    ``rcu_irq_enter()`` and ``rcu_irq_exit()`` at exception entry and
@@ -2431,7 +2431,7 @@ However, there are legitimate preemptible-RCU implementations that do
 not have this property, given that any point in the code outside of an
 RCU read-side critical section can be a quiescent state. Therefore,
 *RCU-sched* was created, which follows “classic” RCU in that an
-RCU-sched grace period waits for for pre-existing interrupt and NMI
+RCU-sched grace period waits for pre-existing interrupt and NMI
 handlers. In kernels built with ``CONFIG_PREEMPT=n``, the RCU and
 RCU-sched APIs have identical implementations, while kernels built with
 ``CONFIG_PREEMPT=y`` provide a separate implementation for each.
-- 
2.9.5

