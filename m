Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9C42FBCC6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389388AbhASQpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732983AbhASQnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:43:43 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4956C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:43:02 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id r4so398764eds.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Mv8HVHZiqq2Y22lxEuv91PTBTzfF3aDqkg+FO9Cjpcc=;
        b=sMDi4o9tE+P0gYCKpCsgSYKKMzx29ksE7m2wjA+KO85uTUpDuhkfMFInQgjkr8yfsF
         8Q+wFUdrqk1EjqshuBKCk2MukU8b+SsvgvMNkzJnFpZ+5+xUVt6Qs5dIMg0XCcXb6Xj9
         cr8Iw+xLquN+FrQyE32gFCNctBztV8F5MODxfHff/reLdviDiImV9OzLV9zzug4jYnvd
         hF17mG0QYbtONfqRYQjQKFPKxcGV2jzBvZps2e8ZHAGz6D4Do0vmkmRj/HjOD6nE3x+L
         aA0t0N5rsw39WKKfziJ5TFLsw3wE91T0MTd0gcS7HUVFWjqxD/TcQfNwQsBXHLl6ZHjq
         qpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Mv8HVHZiqq2Y22lxEuv91PTBTzfF3aDqkg+FO9Cjpcc=;
        b=J61dTOzeVeIBIKeCk4Z4RsqGfye2YaIQJTPvpJktg73Z05Wt6w3GeuXaSIDCDz14fB
         aqL7rU+lrP1LBoucUpsBd/6c4VIR+50JguAYTqXhH/CSki6gLH/nMeeCry2buCME64HM
         x4wmB81SMpF6Cj2Xi4VzrBZB7BEz0INiO9VfnPumaOzAM46V+eJkbbQoNv4ByRLSrnPi
         UQp9fLMHwjwLOtveoad8Od5oaNwDxq9fUgp1oFnlNTvzVqDRqHeJVswKIFvMM2QTPR0j
         5dceT/LYWxUVGsAm44BbSbFHH99o7VASyZ7/7uFPamS0VcMUt2WP+cCxJzVgmeVF78Gn
         pT0A==
X-Gm-Message-State: AOAM530tSAP7EGhiDTipO9ymSgQt8gYvSf9+RUwNKbU8+EHiv8nAMR3q
        fzqXCALA33t7iRJc65p9muIPUhJzLhHDkp3/
X-Google-Smtp-Source: ABdhPJyYT38o1pemfEC7bTB5RG+igiwtCnzLyzGxVJxVdrDLqyO+4RuE/lsIuIfAvcyeoJO0lx0Pv/cE4W8trvGg
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:351a:: with SMTP id
 r26mr3406466eja.204.1611074581393; Tue, 19 Jan 2021 08:43:01 -0800 (PST)
Date:   Tue, 19 Jan 2021 17:42:55 +0100
Message-Id: <02b5bcd692e912c27d484030f666b350ad7e4ae4.1611074450.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH] kasan, mm: fix resetting page_alloc tags for HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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

A previous commit added resetting KASAN page tags to
kernel_init_free_pages() to avoid false-positives due to accesses to
metadata with the hardware tag-based mode.

That commit did reset page tags before the metadata access, but didn't
restore them after. As the result, KASAN fails to detect bad accesses
to page_alloc allocations on some configurations.

Fix this by recovering the tag after the metadata access.

Fixes: aa1ef4d7b3f6 ("kasan, mm: reset tags when accessing metadata")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bdbec4c98173..8ef6fc53962a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1207,8 +1207,10 @@ static void kernel_init_free_pages(struct page *page, int numpages)
 	/* s390's use of memset() could override KASAN redzones. */
 	kasan_disable_current();
 	for (i = 0; i < numpages; i++) {
+		u8 tag = page_kasan_tag(page + i);
 		page_kasan_tag_reset(page + i);
 		clear_highpage(page + i);
+		page_kasan_tag_set(page + i, tag);
 	}
 	kasan_enable_current();
 }
-- 
2.30.0.284.gd98b1dd5eaa7-goog

