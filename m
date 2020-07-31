Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152BD233E64
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 06:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgGaEnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 00:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgGaEnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 00:43:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A4FC061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 21:43:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w11so11165362ybi.23
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 21:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=beEVykI/w3KZVAvPQjbc06TAF1ssDBP5sJ8EW7g7IJE=;
        b=wK2O50ySlF5ASt2GKsAqVARb1LUmHwMkknk0UmPXxVufvAvC9lPGBOkaNfqYgrUDnJ
         4VBXnS9MseaGLdap+ZvQlGrYrI3snt1mfaZn7LxpF2cXgy4V6aPkzKy8R6u7XFWktHGT
         t2+H/wWC4qg7iKNZYvNWzcklCOmnyiKLU0AZ0DvC9ceOf+LTgyhPZH3x6Y4TeED/2h/x
         f3/STNqkn2miCTcRso4ITLjV0JevDlJHzw26WTn/mm5BBmQ5oRKPl8lcFJRamwkHGMTg
         qU3vreHwygr5pbQ+xaLEqDePQXvDflCaVQZQeZJUyhv5081JqiQIAaqtyrxFlZM1B66V
         3Bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=beEVykI/w3KZVAvPQjbc06TAF1ssDBP5sJ8EW7g7IJE=;
        b=SKfS4mPeTCOkxbzOaCW1BRY7CH3YqzrVRl1cs1NzPauaL+OruhXgMneP3Tzl8sQedO
         QCuAbWPG+pIsFRsGenEAcQTvWQyEbTELF4cLDqSRAM39IM5YakWmZ91jxmlGLVcszC5x
         tcjCNYo3UCrnAxibCdkagxDjIwPyyLnZsIj5KxbootEfTt1rOrxaTT32Br+Wl4lfhZk7
         BP80oQHKes8p+7omv+hUJutlBQx0ASXdVkgBpHqGBUIvYOXQKH3GYSbnqvt2O5yZt4mi
         N90X5PpThVnAcWILrW0DZxwRjcNU55AieRv3BpmsaVET82Z1zIdYvbaweN48q7SEfPFh
         F6eQ==
X-Gm-Message-State: AOAM533u+vikQthWFL5VdYZLOUKwEOjbrMta+Qh7Y/BwviETj87/F2pK
        5m7Qzo+8EBTGi0x+00hpYfhsQ84IdHqB2w==
X-Google-Smtp-Source: ABdhPJwu24MFR6IZ+344IkbGVBQg1N3XcrFl0sy/7OerPAGdbj160vL5rZ6Qdok7k/Q4sjw98Arnn+OnNTN0Jw==
X-Received: by 2002:a5b:30d:: with SMTP id j13mr3228618ybp.51.1596170581813;
 Thu, 30 Jul 2020 21:43:01 -0700 (PDT)
Date:   Thu, 30 Jul 2020 21:42:38 -0700
In-Reply-To: <20200731044242.1323143-1-davidgow@google.com>
Message-Id: <20200731044242.1323143-2-davidgow@google.com>
Mime-Version: 1.0
References: <20200731044242.1323143-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v9 1/5] Add KUnit Struct to Current Task
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
index 683372943093..3a27399c98b1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1197,6 +1197,10 @@ struct task_struct {
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

