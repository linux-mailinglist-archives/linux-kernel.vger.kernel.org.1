Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5DB258038
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgHaSEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729368AbgHaSEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:04:11 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 665B521734;
        Mon, 31 Aug 2020 18:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897051;
        bh=kKicyu7ptqG+ii+QgMaz1nq0PeJHubdSZmknmoN0U+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IF7C5HhCzAMAVRaj1hDsut81buQNGzp7E13VsqlWuRpoF67OKQ5Ni7T29ETOkPVYY
         rxEVYZemmgxfUUMUnC5s/YOshtoS4VhXiT3jXa8LMPq15IrdX+/tatP1WFANVnFf1p
         6CAlB5ixP8ZaoxVzh35GhdB+QEnPQlPndDq58ipM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Colin Ian King <colin.king@canonical.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/14] refperf: Avoid null pointer dereference when buf fails to allocate
Date:   Mon, 31 Aug 2020 11:04:03 -0700
Message-Id: <20200831180406.494-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180348.GA416@paulmck-ThinkPad-P72>
References: <20200831180348.GA416@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently in the unlikely event that buf fails to be allocated it
is dereferenced a few times.  Use the errexit flag to determine if
buf should be written to to avoid the null pointer dereferences.

Addresses-Coverity: ("Dereference after null check")
Fixes: f518f154ecef ("refperf: Dynamically allocate experiment-summary output buffer")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index d9291f8..952595c 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -546,9 +546,11 @@ static int main_func(void *arg)
 	// Print the average of all experiments
 	SCALEOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
 
-	buf[0] = 0;
-	strcat(buf, "\n");
-	strcat(buf, "Runs\tTime(ns)\n");
+	if (!errexit) {
+		buf[0] = 0;
+		strcat(buf, "\n");
+		strcat(buf, "Runs\tTime(ns)\n");
+	}
 
 	for (exp = 0; exp < nruns; exp++) {
 		u64 avg;
-- 
2.9.5

