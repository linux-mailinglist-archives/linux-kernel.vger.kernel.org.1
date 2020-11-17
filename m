Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C537D2B674C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgKQOYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbgKQOYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:24:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F4EC0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 06:24:15 -0800 (PST)
Message-Id: <20201117132006.197713794@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605623054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=miYG/zCZQGaQ06LzKq3I6PBnnpUMnS6AYhRh98IRgrk=;
        b=lhC88pVT/RrLxHKU2wmGAXJNDqc2/jLyC2KR/4K/ZJcGQo/T18TGADnYq1w7HpakZlYHi6
        pB1NYGnHACqrlnr1zAxZScdtb66eD7boEQkTBecQIMrDprXD4UeNqSjzcm2o9LsA2EVwS7
        rImIh49xsvtyRAFvJl79hLZLJcdATywpDr8jOmFimM68DordxVNagqFFb875z1wF2ykwuC
        59O4dTr5IdVT+9hQ//A+9v0mxamYXNNWjI9L5BQmDWieZI5qHUZCV3sRdnzmCoKuU6d54p
        +Fx9qekS/JhPeDlSSXYcCXUGAiLPzTfcXjie1YwzHPkPphCWxMCZRYK4KOo7Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605623054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=miYG/zCZQGaQ06LzKq3I6PBnnpUMnS6AYhRh98IRgrk=;
        b=tGvsPoJp8TEqSIjGznvmxy3GWDWb4aK55bAqLrdUXtmCZhQ38mbu8nQHil/dym+DVIIMqh
        nqgEVgHhskSq9cBw==
Date:   Tue, 17 Nov 2020 14:19:44 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [patch 2/7] tick: Document protections for tick related data
References: <20201117131942.515430545@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The protection rules for tick_next_period and last_jiffies_update are blury
at best. Clarify this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/tick-common.c |    4 +++-
 kernel/time/tick-sched.c  |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -27,7 +27,9 @@
  */
 DEFINE_PER_CPU(struct tick_device, tick_cpu_device);
 /*
- * Tick next event: keeps track of the tick time
+ * Tick next event: keeps track of the tick time. It's updated by the
+ * CPU which handles the tick and protected by jiffies_lock. There is
+ * no requirement to write hold the jiffies seqcount for it.
  */
 ktime_t tick_next_period;
 ktime_t tick_period;
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -44,7 +44,9 @@ struct tick_sched *tick_get_tick_sched(i
 
 #if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
 /*
- * The time, when the last jiffy update happened. Protected by jiffies_lock.
+ * The time, when the last jiffy update happened. Write access must hold
+ * jiffies_lock and jiffies_seq. tick_nohz_next_event() needs to get a
+ * consistent view of jiffies and last_jiffies_update.
  */
 static ktime_t last_jiffies_update;
 

