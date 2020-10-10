Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30F928A283
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgJJW5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732228AbgJJTo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:44:29 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE414C05BD1E
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 07:11:04 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n9so9750393pgf.9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 07:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aFdk5pHcczHboDQ4Z0dkuXj5cJClEARqjSldQajbuVE=;
        b=NQMgUYL3XpOeE8p6KkyvlM2h8/YjxRGpI5X7NjnkwhpHMX3CAJNNxHRetViP6u58z+
         z5Pgr0wrAtK7JBODFZvSIe0gbMTatabpy2GRP9L7rM3MaVkBERJGt+vYVKPHldqROqce
         MNwKS8cao7wLaRkrStMgtV3QQurJeB2f/BSR96tVJHxK0PZA2rdes4WYHaGngc1yFaAb
         RpIB4XA4EOSlgJpYA5RhS+mjqG46AQ5+aEYMxUoBGdyUhlqgyEXLuZFh9upnhd5QMuB7
         sMYI0hI8QUsizR6Ib9zZEba1pDdCxr3sKrcFgsRMqCkmFWftQUBhxIkzAo0wRBf313E9
         k17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aFdk5pHcczHboDQ4Z0dkuXj5cJClEARqjSldQajbuVE=;
        b=TAI6x4fVMJv7z6+6Lq3qFFHMZT0JlXOyOsnCuEcDrKeJ50KjtSO7CAOOUxGMYOt71e
         YTSb7MThwBLTaPH77E5hNlBJLFj9lIckAaGynY3x7k6SARbI/48a6eX10ygTkkAj7Wdy
         /aXSN0JfH8DJY4WDKK0gXW+j/8lMCtiK4erH/x/RZHGljggr5vC/dTq9KGcDHEzD7TGv
         KceATXb+52aWbJgMbxrpGxuvXCvr+QXz51FTLbb7cD3fs6wUoW3K/KiIzD/j8tsrKuUk
         bKz+e3tUmz6+DtaXrqX3VUJIfXaOMxlOFiVPWmh9xbxAmjmNEFVLg7KLHOQ6cFl8FORU
         +LlA==
X-Gm-Message-State: AOAM531OvX03TdQSSu4VoVGkUjEfekntjn6S14SksBucQss+W3evf9v5
        2ry4chFJwKWRGftuo6NLGfQ=
X-Google-Smtp-Source: ABdhPJzUp2TaF2aGU9Vqb8JmbmH4wR+sCSiRw1AkINCd1dXGXkktRPGPBmTuxWQcARCbNGVn0ZsuLg==
X-Received: by 2002:a17:90b:902:: with SMTP id bo2mr10042504pjb.169.1602339064394;
        Sat, 10 Oct 2020 07:11:04 -0700 (PDT)
Received: from localhost ([13.94.42.177])
        by smtp.gmail.com with ESMTPSA id s16sm14138547pgl.78.2020.10.10.07.11.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Oct 2020 07:11:03 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] trace: Fix some typos in comment
Date:   Sat, 10 Oct 2020 22:09:24 +0800
Message-Id: <20201010140924.3809-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/wihin/within/
s/retrieven/retrieved/
s/suppport/support/
s/wil/will/
s/accidently/accidentally/
s/if the if the/if the/

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/trace.c | 4 ++--
 kernel/trace/trace.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d3e5de717df2..2fae027a9fe5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9432,7 +9432,7 @@ __init static int tracer_alloc_buffers(void)
 	}
 
 	/*
-	 * Make sure we don't accidently add more trace options
+	 * Make sure we don't accidentally add more trace options
 	 * than we have bits for.
 	 */
 	BUILD_BUG_ON(TRACE_ITER_LAST_BIT > TRACE_FLAGS_MAX_SIZE);
@@ -9461,7 +9461,7 @@ __init static int tracer_alloc_buffers(void)
 
 	/*
 	 * The prepare callbacks allocates some memory for the ring buffer. We
-	 * don't free the buffer if the if the CPU goes down. If we were to free
+	 * don't free the buffer if the CPU goes down. If we were to free
 	 * the buffer, then the user would lose any trace that was in the
 	 * buffer. The memory will be removed once the "instance" is removed.
 	 */
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 610d21355526..d7d0764af062 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -246,7 +246,7 @@ typedef bool (*cond_update_fn_t)(struct trace_array *tr, void *cond_data);
  * tracing_snapshot_cond(tr, cond_data), the cond_data passed in is
  * passed in turn to the cond_snapshot.update() function.  That data
  * can be compared by the update() implementation with the cond_data
- * contained wihin the struct cond_snapshot instance associated with
+ * contained within the struct cond_snapshot instance associated with
  * the trace_array.  Because the tr->max_lock is held throughout the
  * update() call, the update() function can directly retrieve the
  * cond_snapshot and cond_data associated with the per-instance
@@ -271,7 +271,7 @@ typedef bool (*cond_update_fn_t)(struct trace_array *tr, void *cond_data);
  *	take the snapshot, by returning 'true' if so, 'false' if no
  *	snapshot should be taken.  Because the max_lock is held for
  *	the duration of update(), the implementation is safe to
- *	directly retrieven and save any implementation data it needs
+ *	directly retrieved and save any implementation data it needs
  *	to in association with the snapshot.
  */
 struct cond_snapshot {
@@ -573,7 +573,7 @@ struct tracer {
  *   The function callback, which can use the FTRACE bits to
  *    check for recursion.
  *
- * Now if the arch does not suppport a feature, and it calls
+ * Now if the arch does not support a feature, and it calls
  * the global list function which calls the ftrace callback
  * all three of these steps will do a recursion protection.
  * There's no reason to do one if the previous caller already
@@ -1472,7 +1472,7 @@ __trace_event_discard_commit(struct trace_buffer *buffer,
 /*
  * Helper function for event_trigger_unlock_commit{_regs}().
  * If there are event triggers attached to this event that requires
- * filtering against its fields, then they wil be called as the
+ * filtering against its fields, then they will be called as the
  * entry already holds the field information of the current event.
  *
  * It also checks if the event should be discarded or not.
-- 
2.17.1

