Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49414263E03
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 09:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbgIJHG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 03:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbgIJHDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:03:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D38C0617A0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 00:03:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j20so4575662ybt.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yVT9yLW7JYWhoMqFcNSvIQqOD/OC9Y5kGyMXj6mDfzA=;
        b=SWzaAF3z61UdDBRXy/OCKHiF8fjMlKLNvdTmk6/Dbh+Kq1lqavqta7ibeGJDMVVjK9
         9axKITn1wFqjz5tlBRpOkLHHQYFcxzoWXqmY1Wr+HNvMkBdSC5mKf3xMXU+ryg27V0jn
         Th4btmcNJXuVRUgMFzA+P1ccT7ZakwLeIba9vmrMXLytgcsHgtPq/ujpT4Fvy8CJSLCl
         Qe3OIPeflNh4YVVch2brsFc0DsYZFIzzMQKNykwBbU9Kf3BE4FGLV7RgkC7+kUlkcYlm
         vQCACO2h7BOQiACwrP48GTHlEEljHMJN9F8kLZF8t731qo/RgTIaPzL/vO9bN/p+0HRJ
         8pZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yVT9yLW7JYWhoMqFcNSvIQqOD/OC9Y5kGyMXj6mDfzA=;
        b=DGkuPdLlTcH9dBBUeOHDw+TSg4UiRLZ/puo6bkw4TzL0ocq+dCzwZd9zJNWPGczjHk
         QvZyYrxfJSBOcMnfhWt65Zb2Cq+CkB3/EuYmrfB0k/M/4UFRKzEqSVFqDeJeQ+kd2ckl
         nmizUnlPUC0IVbt/7RaMgtA6fK/+lQESKnBHt6OKK/oBkydC/IcQrCTIU5+7COmWblUl
         z8wvbJ20xhJiGzvkNmax4yHMQuPBFpScV3hWez/F8iZ//YQbzm0sIvSHTXnp1ydgEEtD
         QOuJ+lXUua5jTq3gaqfiNjX6e5IpwcuggvMGXMo0s6xQ5LLfcg3vmyGFR4pvjizUrwUs
         QLVA==
X-Gm-Message-State: AOAM533gVujmBz7orTW00ft5DaPs+3HL/CwcLbicA+gc1RmUOwtncCM0
        m6lHZuH6Q8xMkoSVPX0oBws5dVyWA0IgxA==
X-Google-Smtp-Source: ABdhPJx6wYqq0LRezDVx5FLW+SCF9/8HZEb3hTyx5Wg3k/fevn1boLeFIzGzqQKYhcL1qVh2j1dn8STpGk5QXw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a25:ef03:: with SMTP id
 g3mr9920500ybd.364.1599721430919; Thu, 10 Sep 2020 00:03:50 -0700 (PDT)
Date:   Thu, 10 Sep 2020 00:03:30 -0700
In-Reply-To: <20200910070331.3358048-1-davidgow@google.com>
Message-Id: <20200910070331.3358048-6-davidgow@google.com>
Mime-Version: 1.0
References: <20200910070331.3358048-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v13 5/5] mm: kasan: Do not panic if both panic_on_warn and
 kasan_multishot set
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com,
        shuah@kernel.org, akpm@linux-foundation.org
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN errors will currently trigger a panic when panic_on_warn is set.
This renders kasan_multishot useless, as further KASAN errors won't be
reported if the kernel has already paniced. By making kasan_multishot
disable this behaviour for KASAN errors, we can still have the benefits
of panic_on_warn for non-KASAN warnings, yet be able to use
kasan_multishot.

This is particularly important when running KASAN tests, which need to
trigger multiple KASAN errors: previously these would panic the system
if panic_on_warn was set, now they can run (and will panic the system
should non-KASAN warnings show up).

Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index e2c14b10bc81..00a53f1355ae 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -95,7 +95,7 @@ static void end_report(unsigned long *flags)
 	pr_err("==================================================================\n");
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 	spin_unlock_irqrestore(&report_lock, *flags);
-	if (panic_on_warn) {
+	if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags)) {
 		/*
 		 * This thread may hit another WARN() in the panic path.
 		 * Resetting this prevents additional WARN() from panicking the
-- 
2.28.0.526.ge36021eeef-goog

