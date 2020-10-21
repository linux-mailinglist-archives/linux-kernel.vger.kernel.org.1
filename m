Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0496E2952F6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504620AbgJUT2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:28:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:52816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411191AbgJUT2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:28:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48D6CAE55;
        Wed, 21 Oct 2020 19:28:24 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     peterz@infradead.org
Cc:     tglx@linutronix.de, mingo@kernel.org, a.darwish@linutronix.de,
        dave@stgolabs.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] timekeeping: Convert jiffies_seq to seqcount_raw_spinlock_t
Date:   Wed, 21 Oct 2020 12:07:49 -0700
Message-Id: <20201021190749.19363-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new api and associate the seqcounter to the jiffies_lock enabling
lockdep support - although for this particular case the write-side locking
and non-preemptibility are quite obvious.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/time/jiffies.c     | 3 ++-
 kernel/time/timekeeping.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index eddcf4970444..a5cffe2a1770 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -59,7 +59,8 @@ static struct clocksource clocksource_jiffies = {
 };
 
 __cacheline_aligned_in_smp DEFINE_RAW_SPINLOCK(jiffies_lock);
-__cacheline_aligned_in_smp seqcount_t jiffies_seq;
+__cacheline_aligned_in_smp seqcount_raw_spinlock_t jiffies_seq =
+	SEQCNT_RAW_SPINLOCK_ZERO(jiffies_seq, &jiffies_lock);
 
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void)
diff --git a/kernel/time/timekeeping.h b/kernel/time/timekeeping.h
index 099737f6f10c..6c2cbd9ef999 100644
--- a/kernel/time/timekeeping.h
+++ b/kernel/time/timekeeping.h
@@ -26,7 +26,7 @@ extern void do_timer(unsigned long ticks);
 extern void update_wall_time(void);
 
 extern raw_spinlock_t jiffies_lock;
-extern seqcount_t jiffies_seq;
+extern seqcount_raw_spinlock_t jiffies_seq;
 
 #define CS_NAME_LEN	32
 
-- 
2.26.2

