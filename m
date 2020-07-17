Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D916E223DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 16:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgGQOGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 10:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgGQOGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:06:07 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 991CB22CAD;
        Fri, 17 Jul 2020 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594994766;
        bh=df75s59VuqNLWmyo7tnNgvL4VZ8Ta+kcRoAI89Me1GA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sur81/pxe8ikD5KcU1OejVnr4dLsYD3fu7zJRkrqDsuVkxteXy8u7LmF8L3LJUx7h
         Vh9uI0yaVm4JkcAafDxCo1cEo9XkpbW6XEZyOZ+FE32QN4mBKU7XMDF16f/t2JgnJk
         s+lKDyMxV6BdBtGoIHZUpPDX9UgvJNmOhZLj4vM0=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 06/12] timer: Optimize _next_timer_interrupt() level iteration
Date:   Fri, 17 Jul 2020 16:05:45 +0200
Message-Id: <20200717140551.29076-7-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717140551.29076-1-frederic@kernel.org>
References: <20200717140551.29076-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a level has a timer that expires before we reach the next level,
there is no need to iterate further.

The next level is reached when the 3 lower bits of the current level are
cleared. If the next event happens before/during that, the next levels
won't give us an earlier expiration.

Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index af1c08b0b168..9abc41715fd2 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1526,6 +1526,7 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 	clk = base->clk;
 	for (lvl = 0; lvl < LVL_DEPTH; lvl++, offset += LVL_SIZE) {
 		int pos = next_pending_bucket(base, offset, clk & LVL_MASK);
+		unsigned long lvl_clk = clk & LVL_CLK_MASK;
 
 		if (pos >= 0) {
 			unsigned long tmp = clk + (unsigned long) pos;
@@ -1533,6 +1534,13 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 			tmp <<= LVL_SHIFT(lvl);
 			if (time_before(tmp, next))
 				next = tmp;
+
+			/*
+			 * If the next expiration happens before we reach
+			 * the next level, no need to check further.
+			 */
+			if (pos <= ((LVL_CLK_DIV - lvl_clk) & LVL_CLK_MASK))
+				break;
 		}
 		/*
 		 * Clock for the next level. If the current level clock lower
@@ -1570,7 +1578,7 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 		 * So the simple check whether the lower bits of the current
 		 * level are 0 or not is sufficient for all cases.
 		 */
-		adj = clk & LVL_CLK_MASK ? 1 : 0;
+		adj = lvl_clk ? 1 : 0;
 		clk >>= LVL_CLK_SHIFT;
 		clk += adj;
 	}
-- 
2.26.2

