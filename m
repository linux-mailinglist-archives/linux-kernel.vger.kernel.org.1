Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683F72F6B36
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbhANTiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbhANTiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:38:05 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85BEC06179B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:37:10 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id n8so840179edo.19
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zyyZOaAWvcuFygSPGgq4+eSGOnhBneBdiwht0viZDwY=;
        b=SxaVUGgJljdEYW2KnDIY5Z36fvF1kQ+Jd9n/RLgZ6Va4SRdJaBUgCybkyqNvuMHz0n
         a0eTmwREx91flHtnmJPxNH7YOcYtiPyvYyp7wcbqHyBJ8cmnTVt86JUzISdWmrtY/czM
         lXf9klmNGXOF/XpQd/y7icwO08Whw399GWpnc4xm0ya9eM+OorqEMiDM0SSXknJmf+F/
         KuG/yXiY3PNIVQ/R80qCoAfZRIbq5xXqCRbvW46XdFxhhgj2y0aBHKfWSV07fz5DjwQG
         qtaY33hkeoDI2s4HZ+2rB4I4CYy3AArPXBB7uUfvsDyMjiob2X7TE6BRib6DZvFhQeRH
         cgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zyyZOaAWvcuFygSPGgq4+eSGOnhBneBdiwht0viZDwY=;
        b=sAEU2Mq10t0+zdw3gjr9kWqMP003PWqgtGiKma5Kh5yBgKu7aK+Ab+wlilRZSPD9tk
         eqzZ/Fm3wKReFSYEouEg5DbnuK9MouwiYZKyiF8ANgPzuyeluA55SsEZULYbiF5mNmFx
         VWENZLWQjbOm8x2Iw1hITAZFIgDYV6ELJjdVc8lZgo93g4qFbPnk6jV6SKKkBkkiVQHd
         t0f7+H5ia9G395IiNlb6Xu0P6Rtzl9OeVqLL5Q9JZ4lvlUz6k0nsit0mcVHupHBuiAKP
         /7jz2UbTSQaCrBDfq0fM8cWPcnGeuqnWM79s1MH0XOES1XXX7qL+6NGWRLe1DSKgRq27
         dgBA==
X-Gm-Message-State: AOAM530GMDbfkE2T0m0vGxlKxP/AIFYkj1PmAyW5urZN9+oY9SAdcUnD
        k0givBhpNe06+msmURKGe2Yv1RI702cKg6zh
X-Google-Smtp-Source: ABdhPJxy0qo3tzsnOX2RQoUCqx3Ms5p03cdSH3Wd2WdiGlkWhtJGIwz4DTMckIiPWn2La2MX6XpdaVtQSHzjEUTS
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6402:379:: with SMTP id
 s25mr7276006edw.367.1610653029351; Thu, 14 Jan 2021 11:37:09 -0800 (PST)
Date:   Thu, 14 Jan 2021 20:36:31 +0100
In-Reply-To: <cover.1610652890.git.andreyknvl@google.com>
Message-Id: <da60f1848b42dd04a4977e156715c8d0382a1ecd.1610652890.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610652890.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v3 15/15] kasan: don't run tests when KASAN is not enabled
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
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index a96376aa7293..6238b56127f8 100644
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

