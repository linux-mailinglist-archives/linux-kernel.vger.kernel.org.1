Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180CF216363
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 03:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgGGBd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 21:33:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgGGBdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 21:33:17 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D341A206F6;
        Tue,  7 Jul 2020 01:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594085594;
        bh=Fuc0I6pCPkKVyR/yCCQ2R2KYLOEOy3g4y2Qdg5rWwek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jgb3e4vdBBuiFYbimOazTn8c1Eo5QhWDugGXuYelnHyMUiqt9dg7e9DPK05NOXszh
         WQ6ZjVzKpp1LyBhot6iT91BgHUmCvj7yLtNmbRtI2ekBzwzYPNz5svVBdA7DZ0InZG
         CQ+eJ3f1ckGVKirbW86Jv1wjdrOMi7ZzGjGNdUXA=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 5/9] timer: Reuse next expiry cache after nohz exit
Date:   Tue,  7 Jul 2020 03:32:49 +0200
Message-Id: <20200707013253.26770-6-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707013253.26770-1-frederic@kernel.org>
References: <20200707013253.26770-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we track the next expiry unconditionally when a timer is added,
we can reuse that information on a tick firing after exiting nohz.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 8a4138e47aa4..501d36ef0b75 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1705,13 +1705,11 @@ static int collect_expired_timers(struct timer_base *base,
 	 * the next expiring timer.
 	 */
 	if ((long)(now - base->clk) > 2) {
-		unsigned long next = __next_timer_interrupt(base);
-
 		/*
 		 * If the next timer is ahead of time forward to current
 		 * jiffies, otherwise forward to the next expiry time:
 		 */
-		if (time_after(next, now)) {
+		if (time_after(base->next_expiry, now)) {
 			/*
 			 * The call site will increment base->clk and then
 			 * terminate the expiry loop immediately.
@@ -1719,7 +1717,7 @@ static int collect_expired_timers(struct timer_base *base,
 			base->clk = now;
 			return 0;
 		}
-		base->clk = next;
+		base->clk = base->next_expiry;
 	}
 	return __collect_expired_timers(base, heads);
 }
-- 
2.26.2

