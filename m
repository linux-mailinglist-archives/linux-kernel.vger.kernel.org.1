Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5108E2350E8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 09:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgHAHJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 03:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgHAHJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 03:09:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE97C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 00:09:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o8so17907577ybg.16
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 00:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1s/fGj49wZAcV85LY6dM4ghB8ELbpKuQm5SC6WcoZ6s=;
        b=cdRSBdXuMHgMFOn2Y6bY+Ajl5sSdFblzIbNL6eSYQI041QCBDSfqxdwsZqjMYI8OCD
         uKvKxPM55CFHYbMHjTBNGHIswmektWKhz1uL3twzczeSucVXxERnixOkCA3zbCvvNp2x
         TgBbxHTwoB9NE8QYl2ZXtqRKTmBN4vwVmFYSZ8I7qmnabh9W6aaaMh5tkM2Ke4Aj8TiI
         JpZtcpC7o3LioN8F9sduWmu9kTgFQ+e9MXEy4tm0KkJ5Pe0LXqPAD11oPhW8BtcabylX
         0fkkRcT0XFrKqeXARZ7Xf5mv6+s6BL5EBWo0YPYYPPviYHzFSTIS2jClq0hL1/qnfehT
         VvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1s/fGj49wZAcV85LY6dM4ghB8ELbpKuQm5SC6WcoZ6s=;
        b=Bwkh+z21CXkJVKuBZsX9Cwcr1sT0CvJvijg0MoW1dI4pPsaUmswLdO9kLg6ggJZivt
         Oa8obBLM8oSxpvs8HSRKcUiG5ywn87Stat48Gabm/9BYMOFnXpRHc1bOH9E/NlxHJj8S
         I2g97ul1J6fqBvJHt3W93bY8dr+CGBmcTAQQFO2LQTzluDBPbf0msCH36nOkqGCivqgD
         0X+6U2SHF+4+reIXkdgSLwRSuYznVdHsOOrK83c++bIev19+uKPnpmDZZNtcQ260oqo6
         0ngmG/TS8JaBROD4wYE4b8I61LkGEcRGskTwbOE3a46yle3C/QjQPRgxKx4/eicMSZlk
         H94g==
X-Gm-Message-State: AOAM531r7JAA7wLbil6phIvQqrjN0gal2VehddARF+Xi5JsaYafIvqbQ
        XcN3HjdFp1srWzUexNeqSQrU/OYCHQ+NKA==
X-Google-Smtp-Source: ABdhPJxN0opToKugwUlpKZQEDzPNtHVxFCZKujhuXoLfdd+mFJo4CCnbZMOLl5RcIsm8WKqcXZbSnf/XOopmBA==
X-Received: by 2002:a25:9249:: with SMTP id e9mr12571927ybo.105.1596265796918;
 Sat, 01 Aug 2020 00:09:56 -0700 (PDT)
Date:   Sat,  1 Aug 2020 00:09:20 -0700
In-Reply-To: <20200801070924.1786166-1-davidgow@google.com>
Message-Id: <20200801070924.1786166-2-davidgow@google.com>
Mime-Version: 1.0
References: <20200801070924.1786166-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v10 1/5] Add KUnit Struct to Current Task
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patricia Alfonso <trishalfonso@google.com>

In order to integrate debugging tools like KASAN into the KUnit
framework, add KUnit struct to the current task to keep track of the
current KUnit test.

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 include/linux/sched.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 27882a08163f..f3f990b82bde 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1196,6 +1196,10 @@ struct task_struct {
 	struct kcsan_ctx		kcsan_ctx;
 #endif
 
+#if IS_ENABLED(CONFIG_KUNIT)
+	struct kunit			*kunit_test;
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* Index of current stored address in ret_stack: */
 	int				curr_ret_stack;
-- 
2.28.0.163.g6104cc2f0b6-goog

