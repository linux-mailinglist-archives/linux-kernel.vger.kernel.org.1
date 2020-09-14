Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D6D2688F9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgINKIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgINKHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:07:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668C6C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:07:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id s13so10034548wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uVsG0Kkb3udXixOXzcX/0nWy6iMIi/f0mWhUtwVsfPg=;
        b=LQEpOLVMWVXWQajzwR4iS7CsWBaOQXjEAZrW/0AbAvZo/cIGqyeTJ6om5D+vZbISyK
         0QTG3tbRdRvfu5g6id4Ze2iJ37oCVKkaGaX+DLTCKkb4j5uRVSZEFDwh0K5gBXCzPywg
         6AG0xezXTQ1Z30tZVWI0/AsYdyEStjM191omA81i99oQbB1XWpaDQfY4R1pWfzHI3K66
         X2vlQl20cKyloNby1I5kcdH7EFzDh9TjpcNa30/c7/nHE78C+Op94vjmfDDqQsUIro2c
         90d16uQPY8bJVW/ZY8Xf3Rx2B+cHo48nuoxm9lo4ZbeYFMKgb8UsJkbJzUDUJy+uyRlI
         P0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uVsG0Kkb3udXixOXzcX/0nWy6iMIi/f0mWhUtwVsfPg=;
        b=kwy4mJQAvcqEEYJhnED7ZXk5LkcNq4X9FQZAc6M/JNRdBHNPEY95HoQZKkdceAFal/
         R023MRbMUAyz3dgqRYPQ+h6oz/bztKTJM3FaF7VWPGc2f3u7MVtApKvVB8HWB0wi53gC
         baa+CKbduqMl5+Lo3uiGymFzcqpYW9DqUEnTIl8HcPT/qOR5lw6a4vJRV9pG9e1s+r5z
         mdx6+nVmyI3ly3SCuAlucQ5laCUc0utD14N7cWa6ggYWMJbDM96pg8dfDBPIy+b3+q3h
         DmymW0ujzTkaD4D3pXusHU5EaXOddWVj7uMkqODDdTToYU14jUSwN7QJlS59q2szZW6h
         g4aQ==
X-Gm-Message-State: AOAM530kGrjCSBya6NXBmxpJH1PSAi0rFkDKzMX8X1y+CExI2aHsafN5
        +qasiz2aMkr5ZOQa6MfDls8+wihNSYEmHA==
X-Google-Smtp-Source: ABdhPJy7yaAiQnoYnvIRyEyNMlmXPfg0k2YcwNad5xpdcHp3LRUdvhMwnY1tCif6jgR1LLtk+5L9Ug==
X-Received: by 2002:a1c:770c:: with SMTP id t12mr15252565wmi.121.1600078067958;
        Mon, 14 Sep 2020 03:07:47 -0700 (PDT)
Received: from localhost.localdomain (188.147.112.12.nat.umts.dynamic.t-mobile.pl. [188.147.112.12])
        by smtp.gmail.com with ESMTPSA id t4sm20485749wrr.26.2020.09.14.03.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 03:07:47 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, akpm@linux-foundation.org
Subject: [RFC PATCH] mm/page_alloc.c: micro-optimization reduce oom critical section size
Date:   Mon, 14 Sep 2020 12:06:54 +0200
Message-Id: <20200914100654.21746-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Most operations from '__alloc_pages_may_oom' do not require oom_mutex hold.
Exception is 'out_of_memory'. The patch refactors '__alloc_pages_may_oom'
to reduce critical section size and improve overall system performance.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/page_alloc.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b9bd75cacf02..b07f950a5825 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3935,18 +3935,7 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 		.order = order,
 	};
 	struct page *page;
-
-	*did_some_progress = 0;
-
-	/*
-	 * Acquire the oom lock.  If that fails, somebody else is
-	 * making progress for us.
-	 */
-	if (!mutex_trylock(&oom_lock)) {
-		*did_some_progress = 1;
-		schedule_timeout_uninterruptible(1);
-		return NULL;
-	}
+	bool success;
 
 	/*
 	 * Go through the zonelist yet one more time, keep very high watermark
@@ -3959,14 +3948,17 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 				      ~__GFP_DIRECT_RECLAIM, order,
 				      ALLOC_WMARK_HIGH|ALLOC_CPUSET, ac);
 	if (page)
-		goto out;
+		return page;
+
+	/* Check if somebody else is making progress for us. */
+	*did_some_progress = mutex_is_locked(&oom_lock);
 
 	/* Coredumps can quickly deplete all memory reserves */
 	if (current->flags & PF_DUMPCORE)
-		goto out;
+		return NULL;
 	/* The OOM killer will not help higher order allocs */
 	if (order > PAGE_ALLOC_COSTLY_ORDER)
-		goto out;
+		return NULL;
 	/*
 	 * We have already exhausted all our reclaim opportunities without any
 	 * success so it is time to admit defeat. We will skip the OOM killer
@@ -3976,12 +3968,12 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	 * The OOM killer may not free memory on a specific node.
 	 */
 	if (gfp_mask & (__GFP_RETRY_MAYFAIL | __GFP_THISNODE))
-		goto out;
+		return NULL;
 	/* The OOM killer does not needlessly kill tasks for lowmem */
 	if (ac->highest_zoneidx < ZONE_NORMAL)
-		goto out;
+		return NULL;
 	if (pm_suspended_storage())
-		goto out;
+		return NULL;
 	/*
 	 * XXX: GFP_NOFS allocations should rather fail than rely on
 	 * other request to make a forward progress.
@@ -3992,8 +3984,20 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	 * failures more gracefully we should just bail out here.
 	 */
 
+	/*
+	 * Acquire the oom lock.  If that fails, somebody else is
+	 * making progress for us.
+	 */
+	if (!mutex_trylock(&oom_lock)) {
+		*did_some_progress = 1;
+		schedule_timeout_uninterruptible(1);
+		return NULL;
+	}
+	success = out_of_memory(&oc);
+	mutex_unlock(&oom_lock);
+
 	/* Exhausted what can be done so it's blame time */
-	if (out_of_memory(&oc) || WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL)) {
+	if (success || WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL)) {
 		*did_some_progress = 1;
 
 		/*
@@ -4004,8 +4008,7 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 			page = __alloc_pages_cpuset_fallback(gfp_mask, order,
 					ALLOC_NO_WATERMARKS, ac);
 	}
-out:
-	mutex_unlock(&oom_lock);
+
 	return page;
 }
 
-- 
2.20.1

