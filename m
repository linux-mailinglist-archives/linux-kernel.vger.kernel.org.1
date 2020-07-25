Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324DA22D967
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 20:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgGYSvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 14:51:42 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:50035 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726035AbgGYSvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 14:51:41 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from build.alporthouse.com (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP id 21931418-1500050 
        for multiple; Sat, 25 Jul 2020 19:51:11 +0100
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH] locking/lockdep: Fix overflow in presentation of average lock-time
Date:   Sat, 25 Jul 2020 19:51:10 +0100
Message-Id: <20200725185110.11588-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though the number of lock-acquisitions is tracked as unsigned long, this
is passed as the divisor to div_s64() which interprets it as a s32,
giving nonsense values with more than 2 billion acquisitons. E.g.

  acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
  -------------------------------------------------------------------------
    2350439395           0.07         353.38   649647067.36          0.-32

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
---
 kernel/locking/lockdep_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 5525cd3ba0c8..02ef87f50df2 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -423,7 +423,7 @@ static void seq_lock_time(struct seq_file *m, struct lock_time *lt)
 	seq_time(m, lt->min);
 	seq_time(m, lt->max);
 	seq_time(m, lt->total);
-	seq_time(m, lt->nr ? div_s64(lt->total, lt->nr) : 0);
+	seq_time(m, lt->nr ? div64_u64(lt->total, lt->nr) : 0);
 }
 
 static void seq_stats(struct seq_file *m, struct lock_stat_data *data)
-- 
2.20.1

