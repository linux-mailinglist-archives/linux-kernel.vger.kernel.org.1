Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52E9269CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIOD7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIOD6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:58:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BD6C061352
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:58:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q2so2088077ybo.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=jND5K7nrTIUr/jnKohKbWFO0ev/Az4T5zj9+dc82ED0=;
        b=Qg6CHZ5gHjhda+KwUOhclR4Q3kDy3biP0i2FZHBxpfArWudV4ORqkavGZ804ogOMUy
         8AUNGmNkzsDG73STZid0h0HXNjcgdhU4z3oj6pqyPjdc1v1BMSCNOBh546+lDwWinBM4
         cSlB1yrVcuwV2HUQQYnA6r4/PxntWOm1hhTkIerea3b0w8zu6c5UEDEtj+WcoE3hx7R1
         YA1AxmrHGF7aGsI8eMd0/1MjlansTNSSQzyABO6LIF06D7toFkjbaSfU/b9S5nvjHrim
         VBUPtn9VDxBpNA7C2qX9ZnMsLj+kasG45T7Fsvm4BO4z47Kg6OcXsgjtIINYa94fy2AP
         jaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jND5K7nrTIUr/jnKohKbWFO0ev/Az4T5zj9+dc82ED0=;
        b=tMeJQcwl12ZCZVWHUhEa4HbSxUFnnfzd3avCDaxpQjkDVlbN4rJnDimzsknb1aEy8W
         BNLZ0L98n+EL0caiPU8H723O/mDg3kmPHzs12+ELJWysgAiSv6NClxMt3JuplRbqDlvL
         JAdlyFRALS1WtZnE6WR3M4n4FtSkiAZJfY/2cKZGZ6WNEZqufQeQ68aI2THXMTXb+p+/
         y708tWqZ7vt8y1Tfg+Fusmaf8Ksh45rzKKbuKhOffR+1pkpGrSRzBtWO4mOM/QgfBHEb
         Zfj4PDNV2NsAjEOADZqzXUMT1mrn602/gId/yHmZ3afgm1HLEr/ISBiT4VP71+NW2IhN
         wr/Q==
X-Gm-Message-State: AOAM531UaQTxG/sfWZkeWZqFKsXE/7lJNCqRMg8yxjpIRiHP/ZyQNlSw
        7/DEW0c5xXW2BJ0kjwhLaOWP6beqYOMgJw==
X-Google-Smtp-Source: ABdhPJwNy5/SF/gC/zNSc6jUHjF6RdEpH1yc/KAlxvozMks7rfzxf+Z68GE5eK2NaQQX5jQCMnFNIydwDzj4gw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a25:10c1:: with SMTP id
 184mr23945299ybq.407.1600142327208; Mon, 14 Sep 2020 20:58:47 -0700 (PDT)
Date:   Mon, 14 Sep 2020 20:58:28 -0700
In-Reply-To: <20200915035828.570483-1-davidgow@google.com>
Message-Id: <20200915035828.570483-6-davidgow@google.com>
Mime-Version: 1.0
References: <20200915035828.570483-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v14 5/5] mm: kasan: Do not panic if both panic_on_warn and
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
2.28.0.618.gf4bc123cb7-goog

