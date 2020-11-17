Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F042B674E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgKQOYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbgKQOYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:24:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A644C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 06:24:18 -0800 (PST)
Message-Id: <20201117132006.462195901@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605623056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=itP+JTa4DEq4Q+ARMIvM4RWaT4jjh5aOphYQvSpEEug=;
        b=ANsTL+J+Lx2rgOSilEMgZhLGPoD3F5Gdid9SNDBE6GBmNbohixMgVGMVIzmIPxChAcA22q
        aXOyQO7S2vR284uL2uTLLuAkHsUxXAujYN1AQf00YlMsDBgeDmd50EoulUhaJaF6CpcM4L
        Cm/yYFt44puPYRVjey3nRaysSiDeognxyhar7f6aS9Gd1Si4xSxrt8doHGS1njt0wjUNWe
        fML5npRtgS226+KXSrS1pvxlCJ2ZbSa5kqKo+eeSCyFkOLutDKlkCUU8jmYRvw4BqHxnLi
        0u8yioM+jAHtj1LJhzZmK5TbmJnu7XeNSNw2HmBYUGCpZ9/kg8hPHakhx/03+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605623056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=itP+JTa4DEq4Q+ARMIvM4RWaT4jjh5aOphYQvSpEEug=;
        b=DSXUWde2Fr7EeJ1vs/WujE8BZWB6hfvB9d5IM6Cd9VLuJHo5AJAu8qCXsHy47IsAs53xK7
        hoD7xmGyxbcIjUCA==
Date:   Tue, 17 Nov 2020 14:19:46 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [patch 4/7] tick/sched: Reduce seqcount held scope in
 tick_do_update_jiffies64()
References: <20201117131942.515430545@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If jiffies are up to date already (caller lost the race against another
CPU) there is no point to change the sequence count. Doing that just forces
other CPUs into the seqcount retry loop in tick_nohz_next_event() for
nothing.

Just bail out early.

Reported-by: Yunfeng Ye <yeyunfeng@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/tick-sched.c |   53 ++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -86,38 +86,35 @@ static void tick_do_update_jiffies64(kti
 
 	/* Reevaluate with jiffies_lock held */
 	raw_spin_lock(&jiffies_lock);
+	if (ktime_before(now, tick_next_period)) {
+		raw_spin_unlock(&jiffies_lock);
+		return;
+	}
+
 	write_seqcount_begin(&jiffies_seq);
 
-	delta = ktime_sub(now, last_jiffies_update);
-	if (delta >= tick_period) {
+	last_jiffies_update = ktime_add(last_jiffies_update, tick_period);
 
-		delta = ktime_sub(delta, tick_period);
-		last_jiffies_update = ktime_add(last_jiffies_update,
-						tick_period);
-
-		/* Slow path for long timeouts */
-		if (unlikely(delta >= tick_period)) {
-			s64 incr = ktime_to_ns(tick_period);
-
-			ticks = ktime_divns(delta, incr);
-
-			last_jiffies_update = ktime_add_ns(last_jiffies_update,
-							   incr * ticks);
-		}
-		do_timer(++ticks);
-
-		/*
-		 * Keep the tick_next_period variable up to date.
-		 * WRITE_ONCE() pairs with the READ_ONCE() in the lockless
-		 * quick check above.
-		 */
-		WRITE_ONCE(tick_next_period,
-			   ktime_add(last_jiffies_update, tick_period));
-	} else {
-		write_seqcount_end(&jiffies_seq);
-		raw_spin_unlock(&jiffies_lock);
-		return;
+	delta = ktime_sub(now, tick_next_period);
+	if (unlikely(delta >= tick_period)) {
+		/* Slow path for long idle sleep times */
+		s64 incr = ktime_to_ns(tick_period);
+
+		ticks = ktime_divns(delta, incr);
+
+		last_jiffies_update = ktime_add_ns(last_jiffies_update,
+						   incr * ticks);
 	}
+
+	do_timer(++ticks);
+
+	/*
+	 * Keep the tick_next_period variable up to date.  WRITE_ONCE()
+	 * pairs with the READ_ONCE() in the lockless quick check above.
+	 */
+	WRITE_ONCE(tick_next_period,
+		   ktime_add(last_jiffies_update, tick_period));
+
 	write_seqcount_end(&jiffies_seq);
 	raw_spin_unlock(&jiffies_lock);
 	update_wall_time();

