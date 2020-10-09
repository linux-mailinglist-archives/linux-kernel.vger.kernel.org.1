Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2581288970
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387951AbgJIM6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732494AbgJIM6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:58:44 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D477C0613D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 05:58:44 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id r16so5186751wrm.18
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 05:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=1SLpeoVP+KmJ3MNjUMrmmSJBrm2VlkC1VfYu1S5MKOc=;
        b=AcdN/R8jskNNTOM90JrNrRpkSI8CeziorVJ+MAqF9JiYxByIkTxHESGQUi0ElNaFkE
         HjxPX01gGLdzSYrZhlrkFwImvWHyoZ5SAuWC3Okc3QfgQh3sKwItSaqOJzCdAWZ2OKyx
         fGs1zlcjKx31e5QJrau6qHMlSjMTqQ0Z2JjoiL5CHOz2j3xBgL8XrELvHsx/tHJfVwxR
         PP+9p7Sfq2Y18IWS+ZjwpKRp6ctqtXI19G4nExjAQD1U+YEG2w7+D3Us48AYrwrcgdyA
         nax4BEeJnRj/qEeuJsXtCPOHmY5qW0T9ryNkhZuJM6W7wqbZPIhqA+JXFtHuw2JXFxuG
         u22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=1SLpeoVP+KmJ3MNjUMrmmSJBrm2VlkC1VfYu1S5MKOc=;
        b=U8rjAFbpsrhGL6FwPkHZBoKBLzKXq4ghT8AVy3luPlCtznhdWC+BOYDlLoV3zVzGN2
         0G2+kPY8aS/vumoKCGVY15akxxp+G9YBs2SdwmClVnqfx9sPFU3uPuL6RdtqJVa6jGxR
         I2iOggxwdEUZ7tf/csW8pBY8FTidJmU7KQ26oKQmya6g8kkY+hteDR9vHMTrHZ8lw1pB
         aoKD3e29ObLhCWgkM2d0way7I5cLoFPRmM30o/rLQpinT/dqEbomnUyVML/nkXKkkl78
         VD7zgp7lY6830VwXY5GTdpChrEH4mQRWR887bDdHm9z6WPOT7YBEFVdsRYasEkQ53tw/
         u7FA==
X-Gm-Message-State: AOAM5310A2zLoa7efQXEqBvfGQ+AvQnmUwjCUREgTRrJspboSIXj0BNY
        J0NPu0+yj869/EpBtKVOD6o4YfhjBSZv2uPq
X-Google-Smtp-Source: ABdhPJxwPJ9TgDYr/md/gHUwGfwT0fxi/fRK9KN0oN6wSg18o9sJ4tk6dGvjYtjfYWgLB8clRmd1RVVlHe95vWo7
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c345:: with SMTP id
 l5mr13883075wmj.123.1602248322770; Fri, 09 Oct 2020 05:58:42 -0700 (PDT)
Date:   Fri,  9 Oct 2020 14:58:34 +0200
Message-Id: <223901affc7bd759b2d6995c2dbfbdd0a29bc88a.1602248029.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v2] kcov, usb, vhost: specify contexts for remote coverage sections
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there's a KCOV remote coverage collection section in
__usb_hcd_giveback_urb(). Initially that section was added based on the
assumption that usb_hcd_giveback_urb() can only be called in interrupt
context as indicated by a comment before it. This is what happens when
syzkaller is fuzzing the USB stack via the dummy_hcd driver.

As it turns out, it's actually valid to call usb_hcd_giveback_urb() in task
context, provided that the caller turned off the interrupts; USB/IP does
exactly that. This can lead to a nested KCOV remote coverage collection
sections both trying to collect coverage in task context. This isn't
supported by KCOV, and leads to a WARNING.

The approach this patch takes is to annotate every call of kcov_remote_*()
callbacks with the context those callbacks are supposed to be executed in.
If the current context doesn't match the mask provided to a callback,
that callback is ignored. KCOV currently only supports collecting remote
coverage in two contexts: task and softirq. This patch constraints KCOV to
only collect coverage from __usb_hcd_giveback_urb() when it's executed in
softirq context.

As the result, the coverage from USB/IP related usb_hcd_giveback_urb() calls
won't be collected, but the WARNING is fixed.

A potential future improvement would be to support nested remote coverage
collection sections, but this patch doesn't address that.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---

Changes v1->v2:
- Fix context checks in kcov_remote_start/stop().
- Clarify commit description.

---
 Documentation/dev-tools/kcov.rst |  5 +++++
 drivers/usb/core/hcd.c           |  4 ++--
 drivers/usb/core/hub.c           |  4 ++--
 drivers/vhost/vhost.c            |  5 +++--
 include/linux/kcov.h             | 24 ++++++++++++++----------
 kernel/kcov.c                    | 16 ++++++++++++----
 6 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
index 8548b0b04e43..99fda94a34c5 100644
--- a/Documentation/dev-tools/kcov.rst
+++ b/Documentation/dev-tools/kcov.rst
@@ -235,6 +235,11 @@ saved to the kcov_handle field in the current task_struct and needs to be
 passed to the newly spawned threads via custom annotations. Those threads
 should in turn be annotated with kcov_remote_start()/kcov_remote_stop().
 
+Besides a handle, kcov_remote_start()/kcov_remote_stop() annotations accept
+a context mask. This mask describes the contexts in which these annotations
+should be applied. E.g. specifying KCOV_CONTEXT_SOFTIRQ will result in the
+corresponding annotations being ignored in any context other than softirq.
+
 Internally kcov stores handles as u64 integers. The top byte of a handle
 is used to denote the id of a subsystem that this handle belongs to, and
 the lower 4 bytes are used to denote the id of a thread instance within
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index a33b849e8beb..1b090e3218a8 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1646,9 +1646,9 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 
 	/* pass ownership to the completion handler */
 	urb->status = status;
-	kcov_remote_start_usb((u64)urb->dev->bus->busnum);
+	kcov_remote_start_usb((u64)urb->dev->bus->busnum, KCOV_CONTEXT_SOFTIRQ);
 	urb->complete(urb);
-	kcov_remote_stop();
+	kcov_remote_stop(KCOV_CONTEXT_SOFTIRQ);
 
 	usb_anchor_resume_wakeups(anchor);
 	atomic_dec(&urb->use_count);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 5b768b80d1ee..d17db72dd020 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5509,7 +5509,7 @@ static void hub_event(struct work_struct *work)
 	hub_dev = hub->intfdev;
 	intf = to_usb_interface(hub_dev);
 
-	kcov_remote_start_usb((u64)hdev->bus->busnum);
+	kcov_remote_start_usb((u64)hdev->bus->busnum, KCOV_CONTEXT_TASK);
 
 	dev_dbg(hub_dev, "state %d ports %d chg %04x evt %04x\n",
 			hdev->state, hdev->maxchild,
@@ -5618,7 +5618,7 @@ static void hub_event(struct work_struct *work)
 	usb_autopm_put_interface(intf);
 	kref_put(&hub->kref, hub_release);
 
-	kcov_remote_stop();
+	kcov_remote_stop(KCOV_CONTEXT_TASK);
 }
 
 static const struct usb_device_id hub_id_table[] = {
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index b45519ca66a7..8913de414e89 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -363,9 +363,10 @@ static int vhost_worker(void *data)
 		llist_for_each_entry_safe(work, work_next, node, node) {
 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
 			__set_current_state(TASK_RUNNING);
-			kcov_remote_start_common(dev->kcov_handle);
+			kcov_remote_start_common(dev->kcov_handle,
+							KCOV_CONTEXT_TASK);
 			work->fn(work);
-			kcov_remote_stop();
+			kcov_remote_stop(KCOV_CONTEXT_TASK);
 			if (need_resched())
 				schedule();
 		}
diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index a10e84707d82..507003038918 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -22,6 +22,10 @@ enum kcov_mode {
 	KCOV_MODE_TRACE_CMP = 3,
 };
 
+#define KCOV_CONTEXT_TASK	(1u << 0)
+#define KCOV_CONTEXT_SOFTIRQ	(1u << 1)
+#define KCOV_CONTEXT_MASK	(KCOV_CONTEXT_TASK | KCOV_CONTEXT_SOFTIRQ)
+
 #define KCOV_IN_CTXSW	(1 << 30)
 
 void kcov_task_init(struct task_struct *t);
@@ -38,18 +42,18 @@ do {						\
 } while (0)
 
 /* See Documentation/dev-tools/kcov.rst for usage details. */
-void kcov_remote_start(u64 handle);
-void kcov_remote_stop(void);
+void kcov_remote_start(u64 handle, unsigned int context);
+void kcov_remote_stop(unsigned int context);
 u64 kcov_common_handle(void);
 
-static inline void kcov_remote_start_common(u64 id)
+static inline void kcov_remote_start_common(u64 id, unsigned int context)
 {
-	kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_COMMON, id));
+	kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_COMMON, id), context);
 }
 
-static inline void kcov_remote_start_usb(u64 id)
+static inline void kcov_remote_start_usb(u64 id, unsigned int context)
 {
-	kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_USB, id));
+	kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_USB, id), context);
 }
 
 #else
@@ -58,14 +62,14 @@ static inline void kcov_task_init(struct task_struct *t) {}
 static inline void kcov_task_exit(struct task_struct *t) {}
 static inline void kcov_prepare_switch(struct task_struct *t) {}
 static inline void kcov_finish_switch(struct task_struct *t) {}
-static inline void kcov_remote_start(u64 handle) {}
-static inline void kcov_remote_stop(void) {}
+static inline void kcov_remote_start(u64 handle, unsigned int context) {}
+static inline void kcov_remote_stop(unsigned int context) {}
 static inline u64 kcov_common_handle(void)
 {
 	return 0;
 }
-static inline void kcov_remote_start_common(u64 id) {}
-static inline void kcov_remote_start_usb(u64 id) {}
+static inline void kcov_remote_start_common(u64 id, unsigned int context) {}
+static inline void kcov_remote_start_usb(u64 id, unsigned int context) {}
 
 #endif /* CONFIG_KCOV */
 #endif /* _LINUX_KCOV_H */
diff --git a/kernel/kcov.c b/kernel/kcov.c
index 6b8368be89c8..e4475b63d6be 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -808,7 +808,7 @@ static void kcov_remote_softirq_stop(struct task_struct *t)
 	}
 }
 
-void kcov_remote_start(u64 handle)
+void kcov_remote_start(u64 handle, unsigned int context)
 {
 	struct task_struct *t = current;
 	struct kcov_remote *remote;
@@ -821,7 +821,11 @@ void kcov_remote_start(u64 handle)
 
 	if (WARN_ON(!kcov_check_handle(handle, true, true, true)))
 		return;
-	if (!in_task() && !in_serving_softirq())
+	if (WARN_ON((context & ~KCOV_CONTEXT_MASK) || !context))
+		return;
+	if (in_task() && !(context & KCOV_CONTEXT_TASK))
+		return;
+	if (in_serving_softirq() && !(context & KCOV_CONTEXT_SOFTIRQ))
 		return;
 
 	local_irq_save(flags);
@@ -952,7 +956,7 @@ static void kcov_move_area(enum kcov_mode mode, void *dst_area,
 }
 
 /* See the comment before kcov_remote_start() for usage details. */
-void kcov_remote_stop(void)
+void kcov_remote_stop(unsigned int context)
 {
 	struct task_struct *t = current;
 	struct kcov *kcov;
@@ -962,7 +966,11 @@ void kcov_remote_stop(void)
 	int sequence;
 	unsigned long flags;
 
-	if (!in_task() && !in_serving_softirq())
+	if (WARN_ON((context & ~KCOV_CONTEXT_MASK) || !context))
+		return;
+	if (in_task() && !(context & KCOV_CONTEXT_TASK))
+		return;
+	if (in_serving_softirq() && !(context & KCOV_CONTEXT_SOFTIRQ))
 		return;
 
 	local_irq_save(flags);
-- 
2.28.0.1011.ga647a8990f-goog

