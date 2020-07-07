Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B516216361
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 03:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgGGBdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 21:33:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbgGGBdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 21:33:20 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 010FC20708;
        Tue,  7 Jul 2020 01:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594085600;
        bh=Yglo1nLyXn5lD9ndDoMXcf1QbBt/8Mm+tqMH0fT+dJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZ4WHvwfaaBUpw4B2hj1E7lekiv3wFCMeAxrH6P3tIQ/LAbA0vFS7CuE4Mrq5lcv7
         G6CUzSLDIMt5vtsmhmjAWqjoF1++HhCTE+ZY9ucrT1MgQSM+5aNw88sddFRafHiRRd
         3Rp+gmu7tYCKIzh8k9CnYDqIiIXeAcDt2aoKqEJA=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 9/9] timer: Lower base clock forwarding threshold
Date:   Tue,  7 Jul 2020 03:32:53 +0200
Message-Id: <20200707013253.26770-10-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707013253.26770-1-frederic@kernel.org>
References: <20200707013253.26770-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing that prevents us from forwarding the base clock if
it's one jiffy off. This reason for this arbitrary limit is historical
and doesn't seem to stand anymore.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 60126d5c79e1..814eaf42a8b5 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -891,7 +891,7 @@ static inline void forward_timer_base(struct timer_base *base)
 	 * Also while executing timers, base->clk is 1 offset ahead
 	 * of jiffies to avoid endless requeuing to current jffies.
 	 */
-	if ((long)(jnow - base->clk) < 2)
+	if ((long)(jnow - base->clk) < 1)
 		return;
 
 	/*
-- 
2.26.2

