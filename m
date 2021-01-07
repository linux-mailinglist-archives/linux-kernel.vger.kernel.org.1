Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24712ED3DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbhAGQCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbhAGQCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:02:33 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36307C0612F8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 08:01:53 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id g17so2818227wrr.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 08:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=cIq2VE7GHy/A2isTfDsjFX2FggL4BJiiCnO6T+jBwiM=;
        b=V2dITOA4ZjQIh2CP/4hdMBOhHdPmn6LvL5o1BQmeXUJWYStzYxOyeukrKxJFrwD7I5
         PWWjqrFvsPibnGIuA9XfKs2wn2Bu5zrka5JWFF1njoWkmqfZvWZCTubMCUYP9JHYTLF/
         t31kkKtUmhSwZ9ARkQpjC+ec2pnVBix1wPsb2jB3nQlL6iZV907N98AY7YG0CKM/brIh
         q8TqXjUY1FiHrtCGpOZ4wKJrYZASTlk+Z4KsvxXqk1BWaMf4pXW2y/hzx0nmGWS618uW
         i+qeKOQdDicunc596/MeRoR2lOh5f09ia0+QO6tcP4xmLfAK6m4FnshJxxJA1cGOEKoC
         bEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=cIq2VE7GHy/A2isTfDsjFX2FggL4BJiiCnO6T+jBwiM=;
        b=kpBPARnTV/pB3Biut92fzYn5L2hk3LsI0M2XgoQzr8IwYB9kwJn6PK1ZLJn8CIZpyb
         ++scLdzr1gKBSiUZJiA9AbbYgQPxNvlTAyfMD5f7mdYqy1PmjjbNeaBellHFrJ7hAGNg
         YjTPjJuUOAxKtG/QoaVp3Uh/hZSfENlSOMVyNbYZOTbmmQYgyjY3yIF2HzWxzDJxVH1f
         jCBKNWKdurO/df2GGpjMy4gqt72lbeO23m4jPmFLHBW6KNu3fNGrNi2Ze60Qx3cdBt9M
         woZjoYMsnfBmrUa0HZoSpsneHF2/hmx+MA5BGGpGsabPGQDg0MZCyvtWzf424tYiITXZ
         kZ4w==
X-Gm-Message-State: AOAM530QohNRPn04LEkWn4rXLtsBTPzqUKpTD1Uh6s5RFmBcyWnUTA/T
        sPVbRcoXfyEjY09MoPwEW121auFMNyaym4L3
X-Google-Smtp-Source: ABdhPJwA5EIT8h4WB2E34cwYPYToSiJcQ93GEB2pMHddQLY8+1saxvnZdXIrKJ6e9sf9dluJGXMEXRjObypGj0Hz
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:2c89:: with SMTP id
 s131mr1458471wms.0.1610035310903; Thu, 07 Jan 2021 08:01:50 -0800 (PST)
Date:   Thu,  7 Jan 2021 17:01:44 +0100
Message-Id: <04978189d40307e979be61c458f4944b61134198.1610035117.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v2] kcov, usb: hide in_serving_softirq checks in __usb_hcd_giveback_urb
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Done opencode in_serving_softirq() checks in __usb_hcd_giveback_urb() to
avoid cluttering the code, hide them in kcov helpers instead.

Fixes: aee9ddb1d371 ("kcov, usb: only collect coverage from __usb_hcd_giveback_urb in softirq")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---

Changes v1->v2:
- Fix a typo in the commit description and in a comment in the patch.

---
 drivers/usb/core/hcd.c |  8 +++-----
 include/linux/kcov.h   | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 60886a7464c3..ad5a0f405a75 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1649,14 +1649,12 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 	urb->status = status;
 	/*
 	 * This function can be called in task context inside another remote
-	 * coverage collection section, but KCOV doesn't support that kind of
+	 * coverage collection section, but kcov doesn't support that kind of
 	 * recursion yet. Only collect coverage in softirq context for now.
 	 */
-	if (in_serving_softirq())
-		kcov_remote_start_usb((u64)urb->dev->bus->busnum);
+	kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
 	urb->complete(urb);
-	if (in_serving_softirq())
-		kcov_remote_stop();
+	kcov_remote_stop_softirq();
 
 	usb_anchor_resume_wakeups(anchor);
 	atomic_dec(&urb->use_count);
diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index a10e84707d82..18306ef8ad5a 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -52,6 +52,25 @@ static inline void kcov_remote_start_usb(u64 id)
 	kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_USB, id));
 }
 
+/*
+ * The softirq flavor of kcov_remote_*() functions is introduced as a temporary
+ * workaround for kcov's lack of nested remote coverage sections support in
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
2.29.2.729.g45daf8777d-goog

