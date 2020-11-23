Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2042C1994
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgKWXrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 18:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgKWXrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:47:31 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638E1C061A51
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:47:31 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e19so25212513ybc.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ascgbhXbYRQvyEEAQc3awfc5IanY2cScWjvfywd41uw=;
        b=NVO7kq0BdA8NchuGjtepWi1CMDdfRhVBA+8xSr23/BBIEz7LwztR0xKXOeeicljJRt
         wIORwPyuB4UkZ1VvIGtiMK7bhnG14yLGAMoHvVFE/lfbj7YnsXznDl3q+Pl3fDEwC7E5
         sJVbBKxol2DgA51MfkPSnmWM/rRqQvI+TCF+/wOgyzXc8CvqQbJdgVrgkmD7B+MzUMCG
         iyhkKaNrHMKnIOK4PMU3axx2c/ZmNTGD5NyPyZzy6yD/+VFuYJgheSX51weNQpRVOeKF
         0Z4adFr4YUwsK3z/OXEusej89maa10IuewyDAx9yIjD+aWdZOYSTXrMgUkyIbyC3DNYw
         icCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ascgbhXbYRQvyEEAQc3awfc5IanY2cScWjvfywd41uw=;
        b=VFOjXjn4nkdsViB9F1sPYK2MwhZtv4TCjv7ZjGmMBK8eUvYhkL8yAaezZex/ilME2B
         hfKzzF9M/t9oVqCCisI1QurqJdxNvBXcPSEDMA6vf2Pmc5HDXaZAdfORlPbTu8UKMgHt
         z0CE+soPN/8nl5f/iorS3H1FSInv/xp2nzT7TP+DWdhq4T45xfC7N4Pwb+yZVCLPVEg4
         9vQnYoysqqgklS2I4SyviMq7v7+Qw0A0U+e3yEY4A7olhWtJyCkyIwWpU9/2ATgxMeT6
         9Me5QsWpeTd11S0dc67lRJmnXV42BKGs7riCHxpKqTY7ZASffNv4YQW9J1APDgBdBKBR
         Iyog==
X-Gm-Message-State: AOAM5331unIFtEhNBHDUzkuKmhRhyWICwZnIwEH2qnI3Kk3N3ucN6F3A
        geA3ETbXd559Ewk+bFXoBnDkevcm5hVDzkYZ
X-Google-Smtp-Source: ABdhPJwwO3D8fyfqoddTi/oBTzNxexCqo25s0PJRu3y6Eg/5BgVoADplquRyUIHn3iqMzr1tg9czGO6FC07kxm2H
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a25:4095:: with SMTP id
 n143mr3145444yba.106.1606175250569; Mon, 23 Nov 2020 15:47:30 -0800 (PST)
Date:   Tue, 24 Nov 2020 00:47:25 +0100
Message-Id: <d7035335fdfe7493067fbf7d677db57807a42d5d.1606175031.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v5] kcov, usb: only collect coverage from __usb_hcd_giveback_urb
 in softirq
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Nazime Hande Harputluoglu <handeharput@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there's a kcov remote coverage collection section in
__usb_hcd_giveback_urb(). Initially that section was added based on the
assumption that usb_hcd_giveback_urb() can only be called in interrupt
context as indicated by a comment before it. This is what happens when
syzkaller is fuzzing the USB stack via the dummy_hcd driver.

As it turns out, it's actually valid to call usb_hcd_giveback_urb() in task
context, provided that the caller turned off the interrupts; USB/IP does
exactly that. This can lead to a nested KCOV remote coverage collection
sections both trying to collect coverage in task context. This isn't
supported by kcov, and leads to a WARNING.

Change __usb_hcd_giveback_urb() to only call kcov_remote_*() callbacks
when it's being executed in a softirq. To avoid calling
in_serving_softirq() directly in the driver code, add a couple of new kcov
wrappers.

As the result of this change, the coverage from USB/IP related
usb_hcd_giveback_urb() calls won't be collected, but the WARNING is fixed.

A potential future improvement would be to support nested remote coverage
collection sections, but this patch doesn't address that.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Acked-by: Marco Elver <elver@google.com>
---

Changes in v5:
- Don't call in_serving_softirq() in USB driver code directly, do that
  via kcov wrappers.

---
 drivers/usb/core/hcd.c |  9 +++++++--
 include/linux/kcov.h   | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 2c6b9578a7d3..7bafd01e05fb 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1646,9 +1646,14 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 
 	/* pass ownership to the completion handler */
 	urb->status = status;
-	kcov_remote_start_usb((u64)urb->dev->bus->busnum);
+	/*
+	 * This function can be called in task context inside another remote
+	 * coverage collection section, but kcov doesn't support that kind of
+	 * recursion yet. Only collect coverage in softirq context for now.
+	 */
+	kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
 	urb->complete(urb);
-	kcov_remote_stop();
+	kcov_remote_stop_softirq();
 
 	usb_anchor_resume_wakeups(anchor);
 	atomic_dec(&urb->use_count);
diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index a10e84707d82..4e3037dc1204 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -52,6 +52,25 @@ static inline void kcov_remote_start_usb(u64 id)
 	kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_USB, id));
 }
 
+/*
+ * The softirq flavor of kcov_remote_*() functions is introduced as a temporary
+ * work around for kcov's lack of nested remote coverage sections support in
+ * task context. Adding suport for nested sections is tracked in:
+ * https://bugzilla.kernel.org/show_bug.cgi?id=210337
+ */
+
+static inline void kcov_remote_start_usb_softirq(u64 id)
+{
+	if (in_serving_softirq())
+		kcov_remote_start_usb(id);
+}
+
+static inline void kcov_remote_stop_softirq(void)
+{
+	if (in_serving_softirq())
+		kcov_remote_stop();
+}
+
 #else
 
 static inline void kcov_task_init(struct task_struct *t) {}
@@ -66,6 +85,8 @@ static inline u64 kcov_common_handle(void)
 }
 static inline void kcov_remote_start_common(u64 id) {}
 static inline void kcov_remote_start_usb(u64 id) {}
+static inline void kcov_remote_start_usb_softirq(u64 id) {}
+static inline void kcov_remote_stop_softirq(void) {}
 
 #endif /* CONFIG_KCOV */
 #endif /* _LINUX_KCOV_H */
-- 
2.29.2.454.gaff20da3a2-goog

