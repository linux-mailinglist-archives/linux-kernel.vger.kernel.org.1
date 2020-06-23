Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79082204571
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731983AbgFWAcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731643AbgFWAaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F7132082F;
        Tue, 23 Jun 2020 00:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872216;
        bh=gFvVkuGayO5dIBUvKhLS305uE+ytbiCZERTAqgnColQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eO9eU8uDPhnYFubzvYvibEh2Y/qMrZby3wzNwkbYi438vSKkEgC1C8P/kc7UnJ2wW
         1oXiQFjh/01qorFW0atN3cZhCTmsqEMY49ny9xZmC8vGwM5VTDN3usBapBawdxvXx3
         64cSrWDjQpiZA1US1y/rv8uELZVdC0hVFC+x5LzM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/30] refperf: Allow decimal nanoseconds
Date:   Mon, 22 Jun 2020 17:29:50 -0700
Message-Id: <20200623003013.26252-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The CONFIG_PREEMPT=n rcu_read_lock()/rcu_read_unlock() pair's overhead,
even including loop overhead, is far less than one nanosecond.
Since logscale plots are not all that happy with zero values, provide
picoseconds as decimals.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 57c7b7a..e991d48 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -375,7 +375,7 @@ static int main_func(void *arg)
 		if (torture_must_stop())
 			goto end;
 
-		reader_tasks[exp].result_avg = process_durations(exp) / ((exp + 1) * loops);
+		reader_tasks[exp].result_avg = 1000 * process_durations(exp) / ((exp + 1) * loops);
 	}
 
 	// Print the average of all experiments
@@ -386,7 +386,7 @@ static int main_func(void *arg)
 	strcat(buf, "Threads\tTime(ns)\n");
 
 	for (exp = 0; exp < nreaders; exp++) {
-		sprintf(buf1, "%d\t%llu\n", exp + 1, reader_tasks[exp].result_avg);
+		sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, reader_tasks[exp].result_avg / 1000, (int)(reader_tasks[exp].result_avg % 1000));
 		strcat(buf, buf1);
 	}
 
-- 
2.9.5

