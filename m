Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB82328BEE6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404048AbgJLRRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403845AbgJLRRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:17:21 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F916C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:17:21 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id r128so13219148qkc.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=iftzmkGj+wEWSbxIj0LtgdSqgUlxBbSobE6NvMeXE1k=;
        b=taIzv5OlhST2Zc1P/rubs2NGB6QZNl6ot+eta151F7y0DPGOvka4ArYxmFrdWao4Ld
         em+3qctGjpNnaVcebsSHvgnKrBhq0T1NJkPA88Nzyq6wB6Qg7lISi5a+miTYwoC+g4Ee
         3BTdcni9U92gmCuoaDm1At6zXVxM1/+fdzjsiFGeuTqmdQOkEF2IxrRN/3oe1tNjQkFI
         v6Q00UbiVGVLBJOUZlrwNUjNXcOl+LcER6zZFZOK1g5xBwFj4Z59aPuxQDmyJ9roO7IO
         glIMRMYNXcZJGxf6joaXvwepuAbdXqOdYfQJeuUxGHVIh1qGMmB0RWM24Wd04ozBku+H
         vCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=iftzmkGj+wEWSbxIj0LtgdSqgUlxBbSobE6NvMeXE1k=;
        b=MScOI99K2ZXEU7qHWWtv9IPJ2Fn8HB270YEDOKJLwgHSNTL5y/sbihKIWC6UPz7XMo
         hYORsqcXKmz/r9WdDQySm0kZaswb69btW4p1VieOi4ECvbpxp/KHpV4qtErf+MUk2/Qf
         nZZDsrKVVmBrLfBs0qeTgC4bjMEBqRZG++SWBCin4qyVZLKWNOH/4oODcdG06e4F3KPK
         tqJG3atBYo3rjD1D3bkt/WUqLpcP5zsUSbsh/VSHwPjCvT0jZATdM7EAba5956iiI8at
         X6lravNAFZCHN1IkMF1qDeyjUrus5v7sI6u7FsnVXiRH6txIE+Y6SMVut2zc5LXmoago
         L+9g==
X-Gm-Message-State: AOAM530EfczdR1QsQ+2AebOOQmXQXd7UAKoAdH2fnfCi2evKrBSxOwlm
        6D57PBQHyYuc2tJ+ZRqk2mbrzW4OzPwzYvoJ
X-Google-Smtp-Source: ABdhPJy8OcaT6FoXJMdq3WHdkDyXe1RWsv5vnH6sy3ogRmfuI/Hha2hcMBPjUXPL4XhMWdUZy2rcExIj3S8OTUXk
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:bd85:: with SMTP id
 n5mr25605380qvg.22.1602523039990; Mon, 12 Oct 2020 10:17:19 -0700 (PDT)
Date:   Mon, 12 Oct 2020 19:17:12 +0200
Message-Id: <c229372e5526b84ed0542028437111c2eb83d55f.1602522784.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v4] kcov, usb: specify contexts for remote coverage sections
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
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

The approach this patch takes is to add another set of kcov_remote_*()
callbacks that specify the context they are supposed to be executed in.
If the current context doesn't match the mask provided to a callback,
that callback is ignored. KCOV currently only supports collecting remote
coverage in two contexts: task and softirq. This patch constraints KCOV to
only collect coverage from __usb_hcd_giveback_urb() when it's executed in
softirq context.

As the result, the coverage from USB/IP related usb_hcd_giveback_urb()
calls won't be collected, but the WARNING is fixed.

A potential future improvement would be to support nested remote coverage
collection sections, but this patch doesn't address that.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Acked-by: Marco Elver <elver@google.com>
---

Changes v3->v4:
- Drop unnecessary returns from kcov callbacks.

---
 Documentation/dev-tools/kcov.rst |  6 ++++++
 drivers/usb/core/hcd.c           |  4 ++--
 include/linux/kcov.h             | 31 +++++++++++++++++++++++++++++--
 kernel/kcov.c                    | 26 +++++++++++++++++++-------
 4 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
index 8548b0b04e43..2c0f58988512 100644
--- a/Documentation/dev-tools/kcov.rst
+++ b/Documentation/dev-tools/kcov.rst
@@ -235,6 +235,12 @@ saved to the kcov_handle field in the current task_struct and needs to be
 passed to the newly spawned threads via custom annotations. Those threads
 should in turn be annotated with kcov_remote_start()/kcov_remote_stop().
 
+Besides the annotations that only accept a handle, there are also
+kcov_remote_start_context()/kcov_remote_stop_context() that accept a
+context mask. This mask describes the contexts in which these annotations
+should be applied. E.g. specifying KCOV_CONTEXT_SOFTIRQ will result in the
+corresponding annotations being ignored in any context other than softirq.
+
 Internally kcov stores handles as u64 integers. The top byte of a handle
 is used to denote the id of a subsystem that this handle belongs to, and
 the lower 4 bytes are used to denote the id of a thread instance within
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index a33b849e8beb..ea93d9ebcb2e 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1646,9 +1646,9 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 
 	/* pass ownership to the completion handler */
 	urb->status = status;
-	kcov_remote_start_usb((u64)urb->dev->bus->busnum);
+	kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
 	urb->complete(urb);
-	kcov_remote_stop();
+	kcov_remote_stop_softirq();
 
 	usb_anchor_resume_wakeups(anchor);
 	atomic_dec(&urb->use_count);
diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index a10e84707d82..a9c025c3e1df 100644
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
@@ -38,10 +42,21 @@ do {						\
 } while (0)
 
 /* See Documentation/dev-tools/kcov.rst for usage details. */
-void kcov_remote_start(u64 handle);
-void kcov_remote_stop(void);
+
+void kcov_remote_start_context(u64 handle, unsigned int context);
+void kcov_remote_stop_context(unsigned int context);
 u64 kcov_common_handle(void);
 
+static inline void kcov_remote_start(u64 handle)
+{
+	kcov_remote_start_context(handle, KCOV_CONTEXT_MASK);
+}
+
+static inline void kcov_remote_stop(void)
+{
+	kcov_remote_stop_context(KCOV_CONTEXT_MASK);
+}
+
 static inline void kcov_remote_start_common(u64 id)
 {
 	kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_COMMON, id));
@@ -52,6 +67,16 @@ static inline void kcov_remote_start_usb(u64 id)
 	kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_USB, id));
 }
 
+static inline void kcov_remote_start_usb_softirq(u64 id)
+{
+	kcov_remote_start_context(kcov_remote_handle(KCOV_SUBSYSTEM_USB, id), KCOV_CONTEXT_SOFTIRQ);
+}
+
+static inline void kcov_remote_stop_softirq(void)
+{
+	kcov_remote_stop_context(KCOV_CONTEXT_SOFTIRQ);
+}
+
 #else
 
 static inline void kcov_task_init(struct task_struct *t) {}
@@ -66,6 +91,8 @@ static inline u64 kcov_common_handle(void)
 }
 static inline void kcov_remote_start_common(u64 id) {}
 static inline void kcov_remote_start_usb(u64 id) {}
+static inline void kcov_remote_start_usb_softirq(u64 id) {}
+static inline void kcov_remote_stop_softirq(void) {}
 
 #endif /* CONFIG_KCOV */
 #endif /* _LINUX_KCOV_H */
diff --git a/kernel/kcov.c b/kernel/kcov.c
index 6b8368be89c8..3ccdbe060f47 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -808,7 +808,8 @@ static void kcov_remote_softirq_stop(struct task_struct *t)
 	}
 }
 
-void kcov_remote_start(u64 handle)
+/* Also see kcov_remote_start() defined in include/linux/kcov.h. */
+void kcov_remote_start_context(u64 handle, unsigned int context)
 {
 	struct task_struct *t = current;
 	struct kcov_remote *remote;
@@ -821,7 +822,11 @@ void kcov_remote_start(u64 handle)
 
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
@@ -894,7 +899,7 @@ void kcov_remote_start(u64 handle)
 	local_irq_restore(flags);
 
 }
-EXPORT_SYMBOL(kcov_remote_start);
+EXPORT_SYMBOL(kcov_remote_start_context);
 
 static void kcov_move_area(enum kcov_mode mode, void *dst_area,
 				unsigned int dst_area_size, void *src_area)
@@ -951,8 +956,11 @@ static void kcov_move_area(enum kcov_mode mode, void *dst_area,
 	}
 }
 
-/* See the comment before kcov_remote_start() for usage details. */
-void kcov_remote_stop(void)
+/*
+ * Also see kcov_remote_stop() defined in include/linux/kcov.h.
+ * See the comment before kcov_remote_start_context() for usage details.
+ */
+void kcov_remote_stop_context(unsigned int context)
 {
 	struct task_struct *t = current;
 	struct kcov *kcov;
@@ -962,7 +970,11 @@ void kcov_remote_stop(void)
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
@@ -1018,7 +1030,7 @@ void kcov_remote_stop(void)
 	/* Get in kcov_remote_start(). */
 	kcov_put(kcov);
 }
-EXPORT_SYMBOL(kcov_remote_stop);
+EXPORT_SYMBOL(kcov_remote_stop_context);
 
 /* See the comment before kcov_remote_start() for usage details. */
 u64 kcov_common_handle(void)
-- 
2.28.0.1011.ga647a8990f-goog

