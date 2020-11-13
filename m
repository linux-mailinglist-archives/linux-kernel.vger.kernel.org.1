Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC90A2B22E8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgKMRqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgKMRqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:46:45 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DAFC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:46:44 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id k1so9206716ilc.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DkXFGk6I0ftq147+tviBntyoQUaQXSxzVtForeH2b2I=;
        b=V1eb2WQHPY0ZXpfWOadopbiNfS6oEGnzwvFXzKdyqtIjkiTUCWeai90oC3/G40IqjT
         rWt3UoZyuBXzrADF2A6e/WZ201YMzY2Cm0EdXiveJCBHn2/BJJLses8QGTNhguWGemE1
         ZR9W3T3n2qyOWtPivW3OrhLeRZCK1e1JdDaSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DkXFGk6I0ftq147+tviBntyoQUaQXSxzVtForeH2b2I=;
        b=o78wNhzSKHAMZZduXkdRKyuw5wAaE/NxaXKlzLSq6Eph3Xh26II1hPgWoSE2SwI6UG
         6vhNzOk6QkeC7+yfrHyp5DB97hqeW20lRUekGLI3a8mtMc2+YgnPQGw71Ear4v5L6eXX
         Su/Y4CVIftrSZsWqA+JeO+cpNazkKxGczB1mmJ+H+W8r+TyssSTxnhOjC9onzaOXp746
         wnCO5wEPVVBN0HMpAi+K3+c2DFZeaj2YQl9tlpu/bRe9XndYGZZQfjukYZo5vddnkYjd
         kvxzpoaZoS4A1zz7MgMrsZfkiD1enFgRx5V9w71bhhSzSGHghAMMTBkHiqDHu4V9svKN
         8kvQ==
X-Gm-Message-State: AOAM530bgD9/NdVit0E0QHXRDQr9EunYoPmCElZyq5nz2vQ0MOV2MbMR
        Uz/+QX5i6grLpLGPu5NrU1MQVA==
X-Google-Smtp-Source: ABdhPJyvkWLA330BLwQL4aUJ5TeGKR0MUiiIa2fekfvHAE/e+cmZWZrmniX+7CK8UkVVHgTJQinoTw==
X-Received: by 2002:a92:1f19:: with SMTP id i25mr769862ile.198.1605289602222;
        Fri, 13 Nov 2020 09:46:42 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y14sm4772585ilb.66.2020.11.13.09.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 09:46:41 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     rric@kernel.org, gregkh@linuxfoundation.org, keescook@chromium.org,
        peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, oprofile-list@lists.sf.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/13] drivers/oprofile: convert stats to use seqnum_ops
Date:   Fri, 13 Nov 2020 10:46:10 -0700
Message-Id: <648c2fabd395ae22e29cde4b2f8a7716952d28b4.1605287778.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605287778.git.skhan@linuxfoundation.org>
References: <cover.1605287778.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sequence Number api provides interfaces for unsigned atomic up counters
leveraging atomic_t and atomic64_t ops underneath.

atomic_t variables used for stats are atomic counters. Convert them
to use seqnum_ops.

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
index cc917865f13a..5c10b7d5d076 100644
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
+			seqnum32_inc_return(&oprofile_stats.sample_lost_no_mapping);
 			offset = pc;
 		}
 		if (cookie != last_cookie) {
@@ -391,14 +392,14 @@ add_sample(struct mm_struct *mm, struct op_sample *s, int in_kernel)
 	/* add userspace sample */
 
 	if (!mm) {
-		atomic_inc(&oprofile_stats.sample_lost_no_mm);
+		seqnum32_inc_return(&oprofile_stats.sample_lost_no_mm);
 		return 0;
 	}
 
 	cookie = lookup_dcookie(mm, s->eip, &offset);
 
 	if (cookie == INVALID_COOKIE) {
-		atomic_inc(&oprofile_stats.sample_lost_no_mapping);
+		seqnum32_inc_return(&oprofile_stats.sample_lost_no_mapping);
 		return 0;
 	}
 
@@ -556,7 +557,7 @@ void sync_buffer(int cpu)
 		/* ignore backtraces if failed to add a sample */
 		if (state == sb_bt_start) {
 			state = sb_bt_ignore;
-			atomic_inc(&oprofile_stats.bt_lost_no_mapping);
+			seqnum32_inc_return(&oprofile_stats.bt_lost_no_mapping);
 		}
 	}
 	release_mm(mm);
diff --git a/drivers/oprofile/event_buffer.c b/drivers/oprofile/event_buffer.c
index 6c9edc8bbc95..2e2ff87b2a5d 100644
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
+		seqnum32_inc_return(&oprofile_stats.event_lost_overflow);
 		return;
 	}
 
diff --git a/drivers/oprofile/oprof.c b/drivers/oprofile/oprof.c
index ed2c3ec07024..0f65235fb760 100644
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
+	seqnum32_inc_return(&oprofile_stats.multiplex_counter);
 	start_switch_worker();
 }
 
diff --git a/drivers/oprofile/oprofile_stats.c b/drivers/oprofile/oprofile_stats.c
index 59659cea4582..5ad52a4ba5a2 100644
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
+	seqnum32_init(&oprofile_stats.sample_lost_no_mm);
+	seqnum32_init(&oprofile_stats.sample_lost_no_mapping);
+	seqnum32_init(&oprofile_stats.event_lost_overflow);
+	seqnum32_init(&oprofile_stats.bt_lost_no_mapping);
+	seqnum32_init(&oprofile_stats.multiplex_counter);
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

