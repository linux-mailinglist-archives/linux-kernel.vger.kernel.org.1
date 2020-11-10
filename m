Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D7D2AE043
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbgKJTyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731844AbgKJTyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:54:45 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74075C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:54:45 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id n5so13336447ile.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LHM+swMuuT3POe4DU8IsoYr+nsKWsmE8YLJVMKZTyNE=;
        b=FE1t0qzdZKFZscedBvi1KP1LfJXT7HMNpb0kjnU6tG767Rt/1lCx5Y5WWkme9t55Ph
         VhpfLlsc7LVTVBix8vmVuuPIb2Tn2pBMydcYeNBW/ptl49c0pacQre0QlUf8IhRWiAY0
         YTB8WOwRNFxKZXgYszI28/CmodyLBAVBVkN4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LHM+swMuuT3POe4DU8IsoYr+nsKWsmE8YLJVMKZTyNE=;
        b=ZYQHbEqmN47+zV4IsxX+YGxul/ZkWPpfuxrt458jC+jVE3QK4gsiALtLg36orvz5an
         4pzieUIsGLNCL9MXLI4kKFB2rqd9k1nQgutK645Sfw031/dkPaYhIywlOBQi1TwWtfH9
         Eiqv+xR5Vtkclyx/cyTTzR13/erQCHzasg8OcRHAovCd97+pog7UtcWm47A3zKK+p9pB
         5M5A3pLh7d/Bf2ea8Y9kq+Oinj/ADN05ruJliwB9+CbaORuqo9CzXcQs0894VzY4ZMuv
         lCT8cUkIEaQwzDHrBbtDQ/6RIB7z2KpzbwNU5hxiE5ZW4YS9CLxWrqKrBQORfpkT678S
         CIXA==
X-Gm-Message-State: AOAM5307yKq3zif3uK9AGwyM6g/hF+PTni/JGs/PA52FeS4xmp/mduD2
        VWq/ZYmlJhRMWuH+XzzeIwwidg==
X-Google-Smtp-Source: ABdhPJz7Yy8mu6bb8BQaG7xL88wT03W6rj1/5JQdszUNDt6VAC/aGg3OTpfKeW2RByYiAeo35//8eQ==
X-Received: by 2002:a92:c5ce:: with SMTP id s14mr15974587ilt.40.1605038084864;
        Tue, 10 Nov 2020 11:54:44 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o14sm123971ilg.71.2020.11.10.11.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:54:44 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     rric@kernel.org, gregkh@linuxfoundation.org, keescook@chromium.org,
        peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, oprofile-list@lists.sf.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] drivers/oprofile: convert stats to use seqnum_ops
Date:   Tue, 10 Nov 2020 12:53:34 -0700
Message-Id: <908cbac7285d11fd494e64b71c5e54e6b1b1c564.1605027593.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605027593.git.skhan@linuxfoundation.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seqnum_ops api is introduced to be used when a variable is used as
a sequence/stat counter and doesn't guard object lifetimes. This
clearly differentiates atomic_t usages that guard object lifetimes.

seqnum32 variables wrap around to INT_MIN when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

atomic_t variables used for stats are atomic counters. Overflow will
wrap around and reset the stats and no change with the conversion.

Convert them to use seqnum_ops.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/oprofile/buffer_sync.c    |  9 +++++----
 drivers/oprofile/event_buffer.c   |  3 ++-
 drivers/oprofile/oprof.c          |  3 ++-
 drivers/oprofile/oprofile_stats.c | 11 ++++++-----
 drivers/oprofile/oprofile_stats.h | 11 ++++++-----
 drivers/oprofile/oprofilefs.c     |  3 ++-
 include/linux/oprofile.h          |  3 ++-
 7 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/oprofile/buffer_sync.c b/drivers/oprofile/buffer_sync.c
index cc917865f13a..0503d467429b 100644
--- a/drivers/oprofile/buffer_sync.c
+++ b/drivers/oprofile/buffer_sync.c
@@ -34,6 +34,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
 #include <linux/gfp.h>
+#include <linux/seqnum_ops.h>
 
 #include "oprofile_stats.h"
 #include "event_buffer.h"
@@ -347,7 +348,7 @@ static void add_data(struct op_entry *entry, struct mm_struct *mm)
 		if (cookie == NO_COOKIE)
 			offset = pc;
 		if (cookie == INVALID_COOKIE) {
-			atomic_inc(&oprofile_stats.sample_lost_no_mapping);
+			seqnum32_inc(&oprofile_stats.sample_lost_no_mapping);
 			offset = pc;
 		}
 		if (cookie != last_cookie) {
@@ -391,14 +392,14 @@ add_sample(struct mm_struct *mm, struct op_sample *s, int in_kernel)
 	/* add userspace sample */
 
 	if (!mm) {
-		atomic_inc(&oprofile_stats.sample_lost_no_mm);
+		seqnum32_inc(&oprofile_stats.sample_lost_no_mm);
 		return 0;
 	}
 
 	cookie = lookup_dcookie(mm, s->eip, &offset);
 
 	if (cookie == INVALID_COOKIE) {
-		atomic_inc(&oprofile_stats.sample_lost_no_mapping);
+		seqnum32_inc(&oprofile_stats.sample_lost_no_mapping);
 		return 0;
 	}
 
@@ -556,7 +557,7 @@ void sync_buffer(int cpu)
 		/* ignore backtraces if failed to add a sample */
 		if (state == sb_bt_start) {
 			state = sb_bt_ignore;
-			atomic_inc(&oprofile_stats.bt_lost_no_mapping);
+			seqnum32_inc(&oprofile_stats.bt_lost_no_mapping);
 		}
 	}
 	release_mm(mm);
diff --git a/drivers/oprofile/event_buffer.c b/drivers/oprofile/event_buffer.c
index 6c9edc8bbc95..6ec2f1ed8d94 100644
--- a/drivers/oprofile/event_buffer.c
+++ b/drivers/oprofile/event_buffer.c
@@ -19,6 +19,7 @@
 #include <linux/dcookies.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
+#include <linux/seqnum_ops.h>
 
 #include "oprof.h"
 #include "event_buffer.h"
@@ -53,7 +54,7 @@ void add_event_entry(unsigned long value)
 	}
 
 	if (buffer_pos == buffer_size) {
-		atomic_inc(&oprofile_stats.event_lost_overflow);
+		seqnum32_inc(&oprofile_stats.event_lost_overflow);
 		return;
 	}
 
diff --git a/drivers/oprofile/oprof.c b/drivers/oprofile/oprof.c
index ed2c3ec07024..f3183ef0f607 100644
--- a/drivers/oprofile/oprof.c
+++ b/drivers/oprofile/oprof.c
@@ -15,6 +15,7 @@
 #include <linux/workqueue.h>
 #include <linux/time.h>
 #include <linux/mutex.h>
+#include <linux/seqnum_ops.h>
 
 #include "oprof.h"
 #include "event_buffer.h"
@@ -110,7 +111,7 @@ static void switch_worker(struct work_struct *work)
 	if (oprofile_ops.switch_events())
 		return;
 
-	atomic_inc(&oprofile_stats.multiplex_counter);
+	seqnum32_inc(&oprofile_stats.multiplex_counter);
 	start_switch_worker();
 }
 
diff --git a/drivers/oprofile/oprofile_stats.c b/drivers/oprofile/oprofile_stats.c
index 59659cea4582..04e9b2a0d35a 100644
--- a/drivers/oprofile/oprofile_stats.c
+++ b/drivers/oprofile/oprofile_stats.c
@@ -11,6 +11,7 @@
 #include <linux/smp.h>
 #include <linux/cpumask.h>
 #include <linux/threads.h>
+#include <linux/seqnum_ops.h>
 
 #include "oprofile_stats.h"
 #include "cpu_buffer.h"
@@ -30,11 +31,11 @@ void oprofile_reset_stats(void)
 		cpu_buf->sample_invalid_eip = 0;
 	}
 
-	atomic_set(&oprofile_stats.sample_lost_no_mm, 0);
-	atomic_set(&oprofile_stats.sample_lost_no_mapping, 0);
-	atomic_set(&oprofile_stats.event_lost_overflow, 0);
-	atomic_set(&oprofile_stats.bt_lost_no_mapping, 0);
-	atomic_set(&oprofile_stats.multiplex_counter, 0);
+	seqnum32_set(&oprofile_stats.sample_lost_no_mm, 0);
+	seqnum32_set(&oprofile_stats.sample_lost_no_mapping, 0);
+	seqnum32_set(&oprofile_stats.event_lost_overflow, 0);
+	seqnum32_set(&oprofile_stats.bt_lost_no_mapping, 0);
+	seqnum32_set(&oprofile_stats.multiplex_counter, 0);
 }
 
 
diff --git a/drivers/oprofile/oprofile_stats.h b/drivers/oprofile/oprofile_stats.h
index 1fc622bd1834..229bcbb16527 100644
--- a/drivers/oprofile/oprofile_stats.h
+++ b/drivers/oprofile/oprofile_stats.h
@@ -11,13 +11,14 @@
 #define OPROFILE_STATS_H
 
 #include <linux/atomic.h>
+#include <linux/seqnum_ops.h>
 
 struct oprofile_stat_struct {
-	atomic_t sample_lost_no_mm;
-	atomic_t sample_lost_no_mapping;
-	atomic_t bt_lost_no_mapping;
-	atomic_t event_lost_overflow;
-	atomic_t multiplex_counter;
+	struct seqnum32 sample_lost_no_mm;
+	struct seqnum32 sample_lost_no_mapping;
+	struct seqnum32 bt_lost_no_mapping;
+	struct seqnum32 event_lost_overflow;
+	struct seqnum32 multiplex_counter;
 };
 
 extern struct oprofile_stat_struct oprofile_stats;
diff --git a/drivers/oprofile/oprofilefs.c b/drivers/oprofile/oprofilefs.c
index 0875f2f122b3..c5749b9aca11 100644
--- a/drivers/oprofile/oprofilefs.c
+++ b/drivers/oprofile/oprofilefs.c
@@ -17,6 +17,7 @@
 #include <linux/fs_context.h>
 #include <linux/pagemap.h>
 #include <linux/uaccess.h>
+#include <linux/seqnum_ops.h>
 
 #include "oprof.h"
 
@@ -193,7 +194,7 @@ static const struct file_operations atomic_ro_fops = {
 
 
 int oprofilefs_create_ro_atomic(struct dentry *root,
-	char const *name, atomic_t *val)
+	char const *name, struct seqnum32 *val)
 {
 	return __oprofilefs_create_file(root, name,
 					&atomic_ro_fops, 0444, val);
diff --git a/include/linux/oprofile.h b/include/linux/oprofile.h
index b2a0f15f11fe..f770254a0c8a 100644
--- a/include/linux/oprofile.h
+++ b/include/linux/oprofile.h
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/printk.h>
 #include <linux/atomic.h>
+#include <linux/seqnum_ops.h>
  
 /* Each escaped entry is prefixed by ESCAPE_CODE
  * then one of the following codes, then the
@@ -140,7 +141,7 @@ int oprofilefs_create_ro_ulong(struct dentry * root,
  
 /** Create a file for read-only access to an atomic_t. */
 int oprofilefs_create_ro_atomic(struct dentry * root,
-	char const * name, atomic_t * val);
+	char const *name, struct seqnum32 *val);
  
 /** create a directory */
 struct dentry *oprofilefs_mkdir(struct dentry *parent, char const *name);
-- 
2.27.0

