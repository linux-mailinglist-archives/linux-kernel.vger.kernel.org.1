Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0922E959C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 14:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbhADNJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 08:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbhADNJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:09:24 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B532C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 05:08:43 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id 14so4943973wmo.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 05:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=4L00xbr85BzSZDrQcVSi8abHo1VhpZjBCyy/C5zqGwE=;
        b=nH8T7gQCERdM9wRKWX4DEAqrp0kptl5k5BnEQzdeMjx7oO0rXj/NE+cZSF/mCPc0pm
         zP6bmbTpvSQv2KbJuWGSmH9z+iwcDcJ6FEDYFFAx+JO/982XbnoOzT8SXid50w1xtj4m
         TNaAol/5IOv2oyce8VJ4Dj6Z01z+YifW0eT4r+aPP6N2v8WbghgIJO8qxIxGTD1wjcWh
         sOZufFgCoxqZT9jC8vXPJQh7gBq2Cg2c1styvvRkGBZzJT4+c3WQdnxjN+qdFvBKuzqU
         XGFGYYXQaTLR6oOSYr6h38nrRfpxdE/0nD87NpMYlvADYGHz7R2HlugfFomf8ehhqDYr
         8hYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=4L00xbr85BzSZDrQcVSi8abHo1VhpZjBCyy/C5zqGwE=;
        b=lNnpRT7QcBstckM0wz8gI0sscTNt+wiCizIT81ttu+XUrhscY/8D+I2cHSXOrXq8A1
         Yg0ku3G499nzYBm7KqvHKkY6USz0EeuIDG2oyoB2J62lI5eJtbm7X+qxp10aPJvAKlCa
         Xhu+nxw2StMp11sCi/DEw/h1FoipBAGJD15eKefpf0w6wPIboCKyTY5jzPR21BtJXsOW
         FQibLGRm5oVMhxk2yfJX2LxfXUSR4LRRfm9I9wgbLWqI3oJhHPFL+NTsNa/OXfk5Qho1
         571RJID0wsD0Z1gT4Tfy5EE0RzjK9RA8IwMY0dg9/xAMnLYYw18msZJupdHkfA+Z/mSn
         fLyQ==
X-Gm-Message-State: AOAM531MW4MiK5h2aVzsNPKjH1eVJLjagz9xtg5dscx7MJNtJN5jw4ty
        Pq5NmLv2lsIganVVjv7T71l3YhHd7A==
X-Google-Smtp-Source: ABdhPJwxp4QH8WQfBjJFX4ZDH9oYpUgEvBSxgpJLt62QKw9i4luO/TOxsk2Q7b93KQIs+K8QDf5eAsvS0Q==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a5d:69c2:: with SMTP id s2mr78387688wrw.36.1609765722195;
 Mon, 04 Jan 2021 05:08:42 -0800 (PST)
Date:   Mon,  4 Jan 2021 14:07:49 +0100
Message-Id: <20210104130749.1768991-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH mm] kfence: fix potential deadlock due to wake_up()
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, jannh@google.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep reports that we may deadlock when calling wake_up() in
__kfence_alloc(), because we may already hold base->lock. This can
happen if debug objects are enabled:

    ...
    __kfence_alloc+0xa0/0xbc0 mm/kfence/core.c:710
    kfence_alloc include/linux/kfence.h:108 [inline]
    ...
    kmem_cache_zalloc include/linux/slab.h:672 [inline]
    fill_pool+0x264/0x5c0 lib/debugobjects.c:171
    __debug_object_init+0x7a/0xd10 lib/debugobjects.c:560
    debug_object_init lib/debugobjects.c:615 [inline]
    debug_object_activate+0x32c/0x3e0 lib/debugobjects.c:701
    debug_timer_activate kernel/time/timer.c:727 [inline]
    __mod_timer+0x77d/0xe30 kernel/time/timer.c:1048
    ...

Therefore, switch to an open-coded wait loop. The difference to before
is that the waiter wakes up and rechecks the condition after 1 jiffy;
however, given the infrequency of kfence allocations, the difference is
insignificant.

Link: https://lkml.kernel.org/r/000000000000c0645805b7f982e4@google.com
Reported-by: syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com
Suggested-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kfence/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 933b197b8634..f0816d5f5913 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -94,9 +94,6 @@ DEFINE_STATIC_KEY_FALSE(kfence_allocation_key);
 /* Gates the allocation, ensuring only one succeeds in a given period. */
 static atomic_t allocation_gate = ATOMIC_INIT(1);
 
-/* Wait queue to wake up allocation-gate timer task. */
-static DECLARE_WAIT_QUEUE_HEAD(allocation_wait);
-
 /* Statistics counters for debugfs. */
 enum kfence_counter_id {
 	KFENCE_COUNTER_ALLOCATED,
@@ -586,6 +583,8 @@ late_initcall(kfence_debugfs_init);
 static struct delayed_work kfence_timer;
 static void toggle_allocation_gate(struct work_struct *work)
 {
+	unsigned long end_wait;
+
 	if (!READ_ONCE(kfence_enabled))
 		return;
 
@@ -596,7 +595,14 @@ static void toggle_allocation_gate(struct work_struct *work)
 	 * Await an allocation. Timeout after 1 second, in case the kernel stops
 	 * doing allocations, to avoid stalling this worker task for too long.
 	 */
-	wait_event_timeout(allocation_wait, atomic_read(&allocation_gate) != 0, HZ);
+	end_wait = jiffies + HZ;
+	do {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (atomic_read(&allocation_gate) != 0)
+			break;
+		schedule_timeout(1);
+	} while (time_before(jiffies, end_wait));
+	__set_current_state(TASK_RUNNING);
 
 	/* Disable static key and reset timer. */
 	static_branch_disable(&kfence_allocation_key);
@@ -707,7 +713,6 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 	 */
 	if (atomic_read(&allocation_gate) || atomic_inc_return(&allocation_gate) > 1)
 		return NULL;
-	wake_up(&allocation_wait);
 
 	if (!READ_ONCE(kfence_enabled))
 		return NULL;
-- 
2.29.2.729.g45daf8777d-goog

