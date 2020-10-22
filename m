Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD261295FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899782AbgJVNVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899548AbgJVNTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:19:46 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1441EC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:45 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id f126so987894qke.17
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=9DI5u3KafPzj5V3i+niAdO1uhXW2it0RjumucIpkaOw=;
        b=KYdK90La20UFPuJ0fER+IgQyEcsxZKP6b9b4wzo9FrNthDqnAFuD/5RyVeAhzGtgFD
         1rxDr3Tc3DpMi3VJMulxGYNmOXPyCZ44TXQZaLrnagTdrvXkZGmK0uz5CxJO/kcl5io3
         867JSelEDG2IXELgOzI1dAaZAG7MmtKcjNEZw8rVk16HYclXkCIp562h7Clu9cWh/Wg5
         5sMDUaz9GmxLB9D5wgH9F8tliUrf553LG/ujqa+Aw8uNtunaPRVtcHU0XXldn0KPABn4
         67TodbIEgPzRL7xJwdjXnRZry1RJYdBDnHwRP6RxpKrDAAvx5/BmRHoHIKiIx5Jn7T5Q
         Z85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9DI5u3KafPzj5V3i+niAdO1uhXW2it0RjumucIpkaOw=;
        b=jBqeji616w8/cRYGD/0uyyHHpYlVZWId159RtjW2YEXkz8WMIss3oaRg0BYlki4XYC
         PyHbBmXBK0ycABaPdn+eIBAlWIENvA+FxDwIU49lqiYQhpdaDsdi5N+jO6mb+JAhkyGE
         qQRSt4RxmhxShRs1Xd4K/jX15kJS4AG4+qi5r1jq3gAMP7gIDZLbfRVOKFPKcWBZrNyK
         Wg/hWP7lAnnlrFUuQabiXgQs2rKWEZcL6i2Tz1iigc5gkIAlrDhUvs913IjM1qxyEh13
         2rQkab00eiKDrSGw6uaX+uUaDhHyfMYerWUZzPwXkasnYKIDpLVblzeM5TsPOvnULLUd
         9H8Q==
X-Gm-Message-State: AOAM533yLzjK6OpnPNswuYAQ4C786weyw+fEmNSFfXkodrW2UFNghKF0
        Iq6E62uES6VmZmPhCTJv4iDTPZDPm4NW2xsW
X-Google-Smtp-Source: ABdhPJzpu4qsDmsSwhmtsakN67Db1oW3vqlMK/6JoYcULaWh7/ua/BL0cxNVhiDmj+hapXuFvoOwNe42CSDioYtU
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:b5e1:: with SMTP id
 o33mr516199qvf.17.1603372784151; Thu, 22 Oct 2020 06:19:44 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:19:00 +0200
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
Message-Id: <84dc684519c5de460c58b85f0351c4f9ab57e897.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 08/21] kasan: remove __kasan_unpoison_stack
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
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
currently used in a single place. Removing it also removes undeed
arithmetic.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
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
2.29.0.rc1.297.gfa9743e501-goog

