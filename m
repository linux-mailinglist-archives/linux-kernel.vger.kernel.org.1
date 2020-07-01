Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53100210156
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 03:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgGABLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 21:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgGABKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:10:46 -0400
Received: from lenoir.home (lfbn-ncy-1-996-218.w90-101.abo.wanadoo.fr [90.101.73.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A47D20781;
        Wed,  1 Jul 2020 01:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593565845;
        bh=LV7P23B00+S8ImLTPp+ijLF3+cQPf7ovG23sO3ILZA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jScekagbnRJlFZeSkgNby0+kJKvLj7lTuyCNCNQexmktTGPBvKSVygsaeUfC+Km18
         A6aOh3qo9M+7unA2dOm4u93xMqA0SG2GXFs9KNk5Tx2upNPjyAq8tGHFF/LJajwrA+
         2YhAK2J/5dI3jHybc3YVIhwmw0hVlZvAVLzU2SuE=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH 06/10] timer: Reuse next expiry cache after nohz exit
Date:   Wed,  1 Jul 2020 03:10:26 +0200
Message-Id: <20200701011030.14324-7-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701011030.14324-1-frederic@kernel.org>
References: <20200701011030.14324-1-frederic@kernel.org>
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
index 30f491ec875a..4612d26fd09a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1697,13 +1697,11 @@ static int collect_expired_timers(struct timer_base *base,
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
@@ -1711,7 +1709,7 @@ static int collect_expired_timers(struct timer_base *base,
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

