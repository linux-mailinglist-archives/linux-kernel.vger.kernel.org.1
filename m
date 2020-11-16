Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE862B40DA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgKPKTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:19:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbgKPKSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:18:31 -0500
Received: from mail.kernel.org (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 706532244C;
        Mon, 16 Nov 2020 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605521908;
        bh=Rh4dZjuk2KSuZTvDIh3X2akKo3hW2gIOC5NS/nf5ntE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xi2d8qqNWjnBVbcfSh5jQ+2T78WbxoLzvASxF6Ozg234G1SAJevJB5f7Ae+P1qZ99
         PrUBmXmIE3ywC3iQhpnZkEWNLd4FpoGaB3oK4rRArs1SVZBL56okoGhzajWoXDFPTa
         9a0yemT7Vzflw8S1F0BEQQdD5VyK5uYdhu21dAAQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kebac-00FwEW-Fu; Mon, 16 Nov 2020 11:18:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 18/27] hrtimer: fix kernel-doc markups
Date:   Mon, 16 Nov 2020 11:18:14 +0100
Message-Id: <9dc87808c2fd07b7e050bafcd033c5ef05808fea.1605521731.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605521731.git.mchehab+huawei@kernel.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hrtimer_get_remaining() markup is documenting, instead,
__hrtimer_get_remaining(), as it is placed at the C file.

In order to properly document it, a kernel-doc markup is
needed together with the function prototype. So, add a
new one, while preserving the existing one, just fixing
the function name.

The hrtimer_is_queued prototype has a typo: it is using
'=' character instead of '-' to split:
	        identifier - description

as required by kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/hrtimer.h | 6 +++++-
 kernel/time/hrtimer.c   | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 107cedd7019a..bb5e7b0a4274 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -430,52 +430,56 @@ static inline void hrtimer_start_expires(struct hrtimer *timer,
 {
 	u64 delta;
 	ktime_t soft, hard;
 	soft = hrtimer_get_softexpires(timer);
 	hard = hrtimer_get_expires(timer);
 	delta = ktime_to_ns(ktime_sub(hard, soft));
 	hrtimer_start_range_ns(timer, soft, delta, mode);
 }
 
 void hrtimer_sleeper_start_expires(struct hrtimer_sleeper *sl,
 				   enum hrtimer_mode mode);
 
 static inline void hrtimer_restart(struct hrtimer *timer)
 {
 	hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
 }
 
 /* Query timers: */
 extern ktime_t __hrtimer_get_remaining(const struct hrtimer *timer, bool adjust);
 
+/**
+ * hrtimer_get_remaining - get remaining time for the timer
+ * @timer:	the timer to read
+ */
 static inline ktime_t hrtimer_get_remaining(const struct hrtimer *timer)
 {
 	return __hrtimer_get_remaining(timer, false);
 }
 
 extern u64 hrtimer_get_next_event(void);
 extern u64 hrtimer_next_event_without(const struct hrtimer *exclude);
 
 extern bool hrtimer_active(const struct hrtimer *timer);
 
 /**
- * hrtimer_is_queued = check, whether the timer is on one of the queues
+ * hrtimer_is_queued - check, whether the timer is on one of the queues
  * @timer:	Timer to check
  *
  * Returns: True if the timer is queued, false otherwise
  *
  * The function can be used lockless, but it gives only a current snapshot.
  */
 static inline bool hrtimer_is_queued(struct hrtimer *timer)
 {
 	/* The READ_ONCE pairs with the update functions of timer->state */
 	return !!(READ_ONCE(timer->state) & HRTIMER_STATE_ENQUEUED);
 }
 
 /*
  * Helper function to check, whether the timer is running the callback
  * function
  */
 static inline int hrtimer_callback_running(struct hrtimer *timer)
 {
 	return timer->base->running == timer;
 }
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 387b4bef7dd1..743c852e10f2 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1267,41 +1267,41 @@ static inline void hrtimer_sync_wait_running(struct hrtimer_cpu_base *base,
  *
  * Returns:
  *  0 when the timer was not active
  *  1 when the timer was active
  */
 int hrtimer_cancel(struct hrtimer *timer)
 {
 	int ret;
 
 	do {
 		ret = hrtimer_try_to_cancel(timer);
 
 		if (ret < 0)
 			hrtimer_cancel_wait_running(timer);
 	} while (ret < 0);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hrtimer_cancel);
 
 /**
- * hrtimer_get_remaining - get remaining time for the timer
+ * __hrtimer_get_remaining - get remaining time for the timer
  * @timer:	the timer to read
  * @adjust:	adjust relative timers when CONFIG_TIME_LOW_RES=y
  */
 ktime_t __hrtimer_get_remaining(const struct hrtimer *timer, bool adjust)
 {
 	unsigned long flags;
 	ktime_t rem;
 
 	lock_hrtimer_base(timer, &flags);
 	if (IS_ENABLED(CONFIG_TIME_LOW_RES) && adjust)
 		rem = hrtimer_expires_remaining_adjusted(timer);
 	else
 		rem = hrtimer_expires_remaining(timer);
 	unlock_hrtimer_base(timer, &flags);
 
 	return rem;
 }
 EXPORT_SYMBOL_GPL(__hrtimer_get_remaining);
 
 #ifdef CONFIG_NO_HZ_COMMON
-- 
2.28.0

