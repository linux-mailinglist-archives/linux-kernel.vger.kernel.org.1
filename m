Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2492E1BB5A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 07:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgD1FDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 01:03:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59314 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726329AbgD1FCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 01:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588050172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FFf78A3RR1oBJhSQrlT3XMUn2VXqYCmgEn7/7/hlliA=;
        b=EJyWCx+F56sYDWbPTVYFC7CW3h6lfahg5DVey6KOaFg1rJxwTT8ZVBA7ZDf+A2eeWS+iq8
        u/aXwR2X1FU8HUrFPUs2UiHL5DXHc0nEL4t9qIPdGNqZ7+Fq1HBpYBFN6JwQMknNWH/EoJ
        j8cO0HLnNO36erde131qYMjLVA+zgG8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-aF9l6dmiOQeQfrNOsfYd8A-1; Tue, 28 Apr 2020 01:02:48 -0400
X-MC-Unique: aF9l6dmiOQeQfrNOsfYd8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F7F2835B43;
        Tue, 28 Apr 2020 05:02:47 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 612041A924;
        Tue, 28 Apr 2020 05:02:46 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Scott Wood <swood@redhat.com>
Subject: [RFC PATCH 2/3] sched/fair: Enable interrupts when dropping lock in newidle_balance()
Date:   Tue, 28 Apr 2020 00:02:41 -0500
Message-Id: <20200428050242.17717-3-swood@redhat.com>
In-Reply-To: <20200428050242.17717-1-swood@redhat.com>
References: <20200428050242.17717-1-swood@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When combined with the next patch, which breaks out of rebalancing
when an RT task is runnable, significant latency reductions are seen
on systems with many CPUs.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 74c3c5280d6b..dfde7f0ce3db 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10376,7 +10376,7 @@ static void nohz_newidle_balance(struct rq *this_=
rq)
 	    time_before(jiffies, READ_ONCE(nohz.next_blocked)))
 		return;
=20
-	raw_spin_unlock(&this_rq->lock);
+	raw_spin_unlock_irq(&this_rq->lock);
 	/*
 	 * This CPU is going to be idle and blocked load of idle CPUs
 	 * need to be updated. Run the ilb locally as it is a good
@@ -10385,7 +10385,7 @@ static void nohz_newidle_balance(struct rq *this_=
rq)
 	 */
 	if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
 		kick_ilb(NOHZ_STATS_KICK);
-	raw_spin_lock(&this_rq->lock);
+	raw_spin_lock_irq(&this_rq->lock);
 }
=20
 #else /* !CONFIG_NO_HZ_COMMON */
@@ -10452,7 +10452,7 @@ int newidle_balance(void)
 		goto out;
 	}
=20
-	raw_spin_unlock(&this_rq->lock);
+	raw_spin_unlock_irq(&this_rq->lock);
=20
 	update_blocked_averages(this_cpu);
 	rcu_read_lock();
@@ -10493,7 +10493,7 @@ int newidle_balance(void)
 	}
 	rcu_read_unlock();
=20
-	raw_spin_lock(&this_rq->lock);
+	raw_spin_lock_irq(&this_rq->lock);
=20
 	if (curr_cost > this_rq->max_idle_balance_cost)
 		this_rq->max_idle_balance_cost =3D curr_cost;
--=20
2.18.2

