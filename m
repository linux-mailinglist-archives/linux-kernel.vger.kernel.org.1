Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C869C2F831B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbhAORzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731791AbhAORzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:55:01 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8049EC0617A2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:37 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id w8so4465521wrv.18
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2dy0JKUm8Du/4wd3SX5MxOAJub1HPeeRj+5dAQlPBLw=;
        b=SmjPm6FsW6rI2GtXZD+Me7Hcyqy6ZeO5c7Ch1XxpfvE4CoGPdDUekkC1XvFdUq/VU/
         55q1xclB04xecgUZEyOpy8ALlLH5r4q6JI24KDxQyQOzwEhjZNxIQ8FdfuX+vuQed4HZ
         dqDhv7md5aQ4nebIWi1pur8eKObjTL9eZpwI4TGTtMReh0dN1inqr9MM+OfR1wpKDjXB
         FEBGQJPwIfgFUyo7qLD3JY/j799yCZX3OYdi7wTVNrNX5UufE9tVRjgNej49yKTcbcEx
         TzXJAtwdUSoaMxZTurgFNvTmwq0xSiZBoSzg4IBmgq6CyfNJS9mmPew8oRBYdKLXJMLn
         d14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2dy0JKUm8Du/4wd3SX5MxOAJub1HPeeRj+5dAQlPBLw=;
        b=gSxeSG/0DUpDggA4p5hMTwyUWUPl90t+owfR2v+5pWoyUsZnkoaIqxGxueCzZvEAfZ
         B/P+7Ip9EFOdXWuVQ6s7Z9v1ikGoqppFfZ2fWQshtoxl1iskQiSCb/R2GWEiBJaWuDAx
         ZNel98+VhCoOU+sUtk/XWn1aSRyvhV6K7bPc/BiCwopVd93fgBQ6MHQFc22OmaaPZOQ6
         VbeN2+jn93qGt6uJH7PyOcXxJaPjTdDTf1755kqaWIB14FRlkfYpddroDvteqKCo8TLl
         FjJI4qfTFdHTqp3OyaFr/mjl8RbO2LxuZ9QL6bGaIySraN2YGYbrAAga14yS8+ojA4P0
         wPxQ==
X-Gm-Message-State: AOAM532AB8isDy+89jndDnqfb49Tw4SLRF+/czHaKKYzwZk2DPuRDnfn
        X2oos8SO0wfF2dxx06U083QLs090+ur3XQsc
X-Google-Smtp-Source: ABdhPJzCwtvOzxt74tFT0Nofq6kJnl4VHr6DR4YDhi+J5CSjZSYFoWpWz8biVKm8VdLbGd8ieXVnEegP7FeBV4Rj
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:51cc:: with SMTP id
 n12mr13912569wrv.375.1610733216075; Fri, 15 Jan 2021 09:53:36 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:52:52 +0100
In-Reply-To: <cover.1610733117.git.andreyknvl@google.com>
Message-Id: <25bd4fb5cae7b421d806a1f33fb633edd313f0c7.1610733117.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610733117.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v4 15/15] kasan: don't run tests when KASAN is not enabled
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
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

Don't run KASAN tests when it's disabled with kasan.mode=off to avoid
corrupting kernel memory.

Link: https://linux-review.googlesource.com/id/I6447af436a69a94bfc35477f6bf4e2122948355e
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 4ba7461210fd..d16ec9e66806 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -47,6 +47,11 @@ static bool multishot;
  */
 static int kasan_test_init(struct kunit *test)
 {
+	if (!kasan_enabled()) {
+		kunit_err(test, "can't run KASAN tests with KASAN disabled");
+		return -1;
+	}
+
 	multishot = kasan_save_enable_multi_shot();
 	hw_set_tagging_report_once(false);
 	return 0;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

