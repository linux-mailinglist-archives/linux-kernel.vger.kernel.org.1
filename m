Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DA82A7376
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbgKEACw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgKEACu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:02:50 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D42C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:02:50 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a12so460712ybc.20
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JW8D6ibToVOb7LpAkCihsputAW6li7gT66iFpWFJlB0=;
        b=EIGseFkUbu4j97m+Rhe8ifiJEJ0/vSgBaoaF2oPB6YJuPwOq2yFl8o3MdZTisWpG8v
         7KPp5oAaiwsPmjeCUi37l89Z7cZJJj/hhe5YwAUSX9ohPHFQHG9rviik167v9qNGYxg+
         P0LNwwi8goSo5pXkQCm2SaSogyReaDgIOTbI5K97sZj9flQ0v+LrD0Pth2BoTDM0Nawq
         hRM42A6VpyD9FTb4ipeHNtA1FxJV0NecpqgkotIXjwA3kZts685NAweHbMSnkr4kQD/y
         wrASYwOEExzSGG5j537dCqcaS992EojrvnZ4VEjnIXPSewtClP3KbuoKPCc76tmqA1U1
         kE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JW8D6ibToVOb7LpAkCihsputAW6li7gT66iFpWFJlB0=;
        b=s3m3M4Vbge/kA224eqRq1zevvHmEeC0kh+i3QcGkyYAQjT/0wc30t2r3aLDmmzBz7n
         WIwocAK5poqGTllWHealdhEHUL0b3xiFyqL9dBYqg7Bh6wJn3vHYQZTb9vId49zyfDE6
         4758PsCC+mwTU9wknElijwgAyJ5gOXuF9VoIpjHo1xSL//0wvEFj9QTUP3ULunBsev0t
         wfGwDeLru0PDvdZIOdTxNJN5ZSCZD5QzASA7VXjv12kaKA236/IS7CXX9fe3aLlMlk7u
         uBlQ6P98U9oSCnmbYGAGI3RVpsSnHRnkHvnlmlToUqQiE4H33UVR38bD+zOUw+/oZU+o
         I1XQ==
X-Gm-Message-State: AOAM5329k3XFc8mM+EM9+6rtg3tRcOX9xDVQE27I8uRT5rrIGAI0dj3r
        /+Uod15BKV817HMsRhnv8Tc2C3QCUWKRHqqp
X-Google-Smtp-Source: ABdhPJyMEsriifNDEGfN+BopmjlIR9t9CjJFRB97WqiYs1BD5RFz7wmlp/gc3XkSEP7qscjhGorWWs7vzkyRjDGQ
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a25:48c:: with SMTP id
 134mr48783ybe.158.1604534569629; Wed, 04 Nov 2020 16:02:49 -0800 (PST)
Date:   Thu,  5 Nov 2020 01:02:16 +0100
In-Reply-To: <cover.1604534322.git.andreyknvl@google.com>
Message-Id: <f5a46b4c122fb08bbe2fe25d91165e8d7aa232a7.1604534322.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 06/20] kasan: remove __kasan_unpoison_stack
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Link: https://linux-review.googlesource.com/id/Ie5ba549d445292fe629b4a96735e4034957bcc50
---
 mm/kasan/common.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index a3e67d49b893..9008fc6b0810 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -59,18 +59,12 @@ void kasan_disable_current(void)
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
 #if CONFIG_KASAN_STACK
-static void __kasan_unpoison_stack(struct task_struct *task, const void *sp)
-{
-	void *base = task_stack_page(task);
-	size_t size = sp - base;
-
-	kasan_unpoison_memory(base, size);
-}
-
 /* Unpoison the entire stack for a task. */
 void kasan_unpoison_task_stack(struct task_struct *task)
 {
-	__kasan_unpoison_stack(task, task_stack_page(task) + THREAD_SIZE);
+	void *base = task_stack_page(task);
+
+	kasan_unpoison_memory(base, THREAD_SIZE);
 }
 
 /* Unpoison the stack for the current task beyond a watermark sp value. */
-- 
2.29.1.341.ge80a0c044ae-goog

