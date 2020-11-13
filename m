Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F3C2B2874
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgKMWWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgKMWUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:20:31 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C804C061A47
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:30 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id m17so5483738qtu.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Jsr+yOOqZi2Nj6qjC5GqIPggpAtw8z6+rbSLs9IYMt8=;
        b=Mr40u2Na+744Lu2xB5XH5N7NJUu5zkCz5bvYutyv8bprHVKibdWrcZ08RTuHeheEFy
         9jmFVE9u4pMUBRSsH8duKKAxLckAMS81HXO4Xd+IF5ViTs3z+IiCHYitEFwvlrygLVdl
         Fp1Iu8qVyEn4/oBWnVHCDlVMIVq/wT8DxVhflITdtyJe4/pBd2b+AM+ccSDdOjDiwdhT
         xJhX33OueoxZPgKqC96ik1I2rYb4dt4KvgmOopH5k0UnP/KslDnr1Hsw0cCUNHD6tkYZ
         pie5A+DraMOwWtJRPgmHqz7/llq9yX68G1qf4bknJXWyJ3BKIpXkFHmhJnfNhv7ht2kH
         CfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Jsr+yOOqZi2Nj6qjC5GqIPggpAtw8z6+rbSLs9IYMt8=;
        b=TvNFIBw0ubX7pLtMRGYJunJef4K06mn0+LVvoXpL+tv9QgjHsc0dPyNjbg2S9gj2X7
         pZ9vjK0h2iL3TXDmFRdqJSky83VVeR4th6ebyo9fZ6L1DskNx/auBGMCyzBJ932u0Kci
         682qgPu5t60nrzq7FAFLxT0UrTsfU4797+f08zi149Jyn6Jfw9QBTM9DMaYEI6tUKQTz
         0sNLj05gJKlBaRLTF/MvL95oGXxz1pHT5TNV8pa4quBN2GA0W91jJuekz63ETD3D5yOO
         oPy9h/q5Bz7ku87t4KVMYjddDKus/66PPjVu+jV2LkFxCOKZAiM6L8BTt4pcDoONNLx2
         nnuw==
X-Gm-Message-State: AOAM530TzkLcXmoiNp5gA+rwhgS35MyaOQcv8j8TNN0RaZ4vz1W0Yldr
        V+vg7hQoqSpj72nIY29yyGG8BQ8ZKkfcnjbV
X-Google-Smtp-Source: ABdhPJwVIBicKScDqVn4tuFRRg0l3bRUAKZbS6vROY4eFdr5r/DaOJjnoyZljU2l4klUlopSKmUGVNXS2wDcCsNI
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4633:: with SMTP id
 x19mr4837837qvv.11.1605306029294; Fri, 13 Nov 2020 14:20:29 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:19:56 +0100
In-Reply-To: <cover.1605305978.git.andreyknvl@google.com>
Message-Id: <157e9dfe43c5612ab028638c39ed5774b613449d.1605305978.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v3 06/19] kasan: remove __kasan_unpoison_stack
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
2.29.2.299.gdc1121823c-goog

