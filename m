Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F8826B830
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgIPAiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgIONXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:23:43 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF6FC0611C0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:21:19 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id k13so1234705wrl.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=a8meNz/QEeXxbn8b6t9gmGleu286u2hc+BNFU326RBY=;
        b=iMvsBbNhgXGxnHuHOkBUVAAM2qOoY48Cj/hlej2s6y2vnL8IvcLin4Y20xBeyU/km1
         5wsT+5syuztJ23L+OnZf6qPvh9KPK+uSriT1U9BNQyQVzqYYdX2+ph3t1DP2YDYfN4sf
         Dmro65jUXU2/e4ZFwym3N1STOvAQhGuQCVkjmJQ2g8aebKIZT9ffsKffbOtCn1attREE
         RsxBD7Uir7r4B7jU3FXDIJ+jVSByU3ErwYkkcn/iqxIhKM5YFs/dkTnflfODfPePIiq9
         TDbx9M/7RJ6YOPJgIKKAisxFttdU10HweoylvSuu5uNY5vU97BDTQYyFyoITjaDvUh3H
         5+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a8meNz/QEeXxbn8b6t9gmGleu286u2hc+BNFU326RBY=;
        b=PN39VfDcQ8Edai62J2NNpEur20jNbZvSZjDED2x+KqzvVlrTjIz9KspefiOOpycTPB
         ubZNtgxE5VEzfCGRaniWDJX1TmvNN3cmfJ4VqfSsN3OxKFDHeBeoVwALNscOpmiygQhK
         fvKE9JpxSK4GwG6WxkecQyydPJQY23Uw4MGlpawgghaLBKF4uwBskpbwQSreOdoJ2jKv
         xw8VyFHHz3RgPHHfUSaeYxEmaClXpxmgdJXDdD2XwCEzTscD3JUH7Xme58p4GsvpDrUq
         6s9WMQufBQ4kuTJ1L4EukZmdUx91FybzL66Nhih7QucE1+3jvO5SJ/vcJ5B8KigZ+anO
         csDA==
X-Gm-Message-State: AOAM532LRKII4213RMfgg2uPNlKXNsuQnTCIChhmXgRC40PRv0gtDJW7
        tmJ9OzGUEM2Kgt3NoZY8hfBlBYi//Q==
X-Google-Smtp-Source: ABdhPJxc+SFUorzyuHDnGAmMdmAFnOXbAdljVi+RbRH5QtpV+KA/ekb7T2afDQiufl+mm1oPBfvLzn0Tjw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a7b:c749:: with SMTP id w9mr4491690wmk.29.1600176077770;
 Tue, 15 Sep 2020 06:21:17 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:20:44 +0200
In-Reply-To: <20200915132046.3332537-1-elver@google.com>
Message-Id: <20200915132046.3332537-9-elver@google.com>
Mime-Version: 1.0
References: <20200915132046.3332537-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 08/10] kfence, lockdep: make KFENCE compatible with lockdep
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org, glider@google.com
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com,
        rientjes@google.com, dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, mingo@redhat.com, jannh@google.com,
        Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        mark.rutland@arm.com, penberg@kernel.org, peterz@infradead.org,
        cai@lca.pw, tglx@linutronix.de, vbabka@suse.cz, will@kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep checks that dynamic key registration is only performed on keys
that are not static objects. With KFENCE, it is possible that such a
dynamically allocated key is a KFENCE object which may, however, be
allocated from a static memory pool (if HAVE_ARCH_KFENCE_STATIC_POOL).

Therefore, ignore KFENCE-allocated objects in static_obj().

Co-developed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/locking/lockdep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 54b74fabf40c..0cf5d5ecbd31 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -38,6 +38,7 @@
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/kallsyms.h>
+#include <linux/kfence.h>
 #include <linux/interrupt.h>
 #include <linux/stacktrace.h>
 #include <linux/debug_locks.h>
@@ -755,6 +756,13 @@ static int static_obj(const void *obj)
 	if (arch_is_kernel_initmem_freed(addr))
 		return 0;
 
+	/*
+	 * KFENCE objects may be allocated from a static memory pool, but are
+	 * not actually static objects.
+	 */
+	if (is_kfence_address(obj))
+		return 0;
+
 	/*
 	 * static variable?
 	 */
-- 
2.28.0.618.gf4bc123cb7-goog

