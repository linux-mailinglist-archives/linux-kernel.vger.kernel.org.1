Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A352C1649
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbgKWUPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731687AbgKWUPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:15:09 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB403C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:08 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id h13so6189857wrr.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=p36dbwqSBkDo+5S2cwk7w2vFpTiM3nymWvjDRmhBFUI=;
        b=mg4G1DidJDofLGHNEBS3YNNpngVUCVymP5RWXDDdw2uRs9rVTEIaudcIuGM5F2q3L6
         9Z/syptAsR65gevgGC7vb22jdpSpm8g2/OW2ZOv1TZ8ZvhRbz+eCh8+IZlSsYvvoSEaY
         KmtODUBNRhwsiEkBrfxHvAbyW7zWsjL/jwTAXPHFYAnzD1KOcF2q0gADTK7rF9nFZ+jO
         eOckU8kstaGbsmTJEnIYdXYtBuw6W4CSugEN2FyQtnaWvOQo7rNh2FHuR2TdgNawAkcz
         Xd/a751+eSOv37jt6hmeRkX2yJmLePmHNofrgvw4sRG3ClS9Zjoqb5Og50/dgojj1XOP
         Mbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p36dbwqSBkDo+5S2cwk7w2vFpTiM3nymWvjDRmhBFUI=;
        b=V5rpZfZfso7EDrxMEZMoeEbVxBvDQW73IrWRWYHglwETOLz99ai7UKNMw6jahB4INS
         xNbn0kDj55ex9UD1z88jHyGk0qhnGNc+xQP7cWrYtpB2m3TKbA3BU2DDrtMgwq+Jx9Uy
         6ownMz/1NbI3wLCIPVTIh3cFr6z7fLO9dblHGZjWVxOVIuCtyizbZf9il691AyOu4DWF
         VVr54leeprbWkKW2z5wPY3a2ee0dfrkM11Ae4JDqqiiAF322MeVhBe3liXwq74mH5oxC
         AR/oNt7cUEc1sgb12XNzGpZlUeE+MyU29LjahDleP6zIEnIBdpN/QoYMNECQhRtPmyLN
         GUjQ==
X-Gm-Message-State: AOAM533USvczi5QknecEwQODfBOpL07UZFZgYCRQC3BN0HdY7WQVlI5a
        vmjFwN5cAjkbu0MfeCvZA2jR+G/9zOJDDUQf
X-Google-Smtp-Source: ABdhPJx/wpDE4yzZ0h+S0RGgypb3BniYNtoFo8y6Vex4DrXhWizpWxJCeQcvoYWSbeyWzTWTt6szgogxteJ0R7Gh
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:9d4c:: with SMTP id
 g73mr17209wme.127.1606162507547; Mon, 23 Nov 2020 12:15:07 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:14:36 +0100
In-Reply-To: <cover.1606162397.git.andreyknvl@google.com>
Message-Id: <93e78948704a42ea92f6248ff8a725613d721161.1606162397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606162397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v4 06/19] kasan: remove __kasan_unpoison_stack
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need for __kasan_unpoison_stack() helper, as it's only
currently used in a single place. Removing it also removes unneeded
arithmetic.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Link: https://linux-review.googlesource.com/id/Ie5ba549d445292fe629b4a96735e4034957bcc50
---
 mm/kasan/common.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 7648a2452a01..fabd843eff3d 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -65,18 +65,12 @@ void kasan_unpoison_range(const void *address, size_t size)
 }
 
 #if CONFIG_KASAN_STACK
-static void __kasan_unpoison_stack(struct task_struct *task, const void *sp)
-{
-	void *base = task_stack_page(task);
-	size_t size = sp - base;
-
-	unpoison_range(base, size);
-}
-
 /* Unpoison the entire stack for a task. */
 void kasan_unpoison_task_stack(struct task_struct *task)
 {
-	__kasan_unpoison_stack(task, task_stack_page(task) + THREAD_SIZE);
+	void *base = task_stack_page(task);
+
+	unpoison_range(base, THREAD_SIZE);
 }
 
 /* Unpoison the stack for the current task beyond a watermark sp value. */
-- 
2.29.2.454.gaff20da3a2-goog

