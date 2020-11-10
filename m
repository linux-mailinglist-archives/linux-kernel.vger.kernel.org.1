Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5413E2AE32E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbgKJWUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbgKJWUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:20:45 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F8AC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:44 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id o19so1873244wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gyGUZGx6qFH2jkAU5L1Nk+VZLXl2e4B3h6WrDO5AJuc=;
        b=ljjlpu8510giM6ompwxwC9fW/XdFC8qbLxu53fZ6U03b6EYiKpJWB0pnDuMqHGR+jN
         r5TObzaeFfHiWBeyCqwixdqdi5C/59498RU2S9dfH8AcpG/uescXFFAI4vk1MFIFdUxs
         aKXAW+Igl/dpH9QlRqyELk9F5/tXGDupazh551//E9tyUg+sj67imZtPjKwh90Ayg1OS
         vnltrTuRHfB3/tkF78B29cR78uIqwsQ9sGY6GIW8WBL94NHckeVhPN4/F3EutOAkS+Ln
         5/kQaGmI93yINQy4OgjBA4Oz+orNqVJURp3LVEBZBzBxMrSgh386MQ6eowcq/tXep6fs
         h8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gyGUZGx6qFH2jkAU5L1Nk+VZLXl2e4B3h6WrDO5AJuc=;
        b=G7r0YToLp6Q9S4sTt4ElfWdiiYnhx6ZWGJpnVhc0oxe6MHKcagM6SXNGFG/afSE+h/
         pMWKN+uL2h+ekXFKl3kBN91lzlXAiwmX7MxHJj7rOV3mGLYM2Z3eV1WOYT5P5J3rEru9
         Myqi5ElatAS09SQZlPLguVrijCJfBEBKlDsa9NAgLQfineILHFmTXHc7RF7l69pId/TS
         SZLNYRqlLeTBua0adcsOh7sv+wTDcXeKpoFoz3q/a7kyxLx3UODFb2ATBuZYLk8VQogL
         i5DZ2KHAkctwSRT9nohdNfbv13tSb8vWUVJMgSS0HmN+quNfn+gemAfETaz+RaH/sbZ2
         iUPA==
X-Gm-Message-State: AOAM530lDvIqW5/ISFzYYl18tB5L/gKHhIrxCcdSpup9Ou6CE+eVrthG
        JmyoNQR3KdIjhtsouWH/NvLNxQCCGWvMm63r
X-Google-Smtp-Source: ABdhPJwekepriFSyzIoCXRNKCGpvFiq2NnAR4bAyn052jaQHzEPlcFfRQSyz8Y0DdueqyddIpnCAMwTZ+WqCAiQP
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:630b:: with SMTP id
 i11mr5840517wru.404.1605046843285; Tue, 10 Nov 2020 14:20:43 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:20:10 +0100
In-Reply-To: <cover.1605046662.git.andreyknvl@google.com>
Message-Id: <462c375f39ba8c4c105b3a9bf3b5db17f3720159.1605046662.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2 06/20] kasan: remove __kasan_unpoison_stack
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
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
2.29.2.222.g5d2a92d10f8-goog

