Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E897272570
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgIUN1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbgIUN0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:26:55 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0755EC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 06:26:55 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id g1so12770139qtc.22
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 06:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Xu8t61b4dNKr+fiQ7+DCPl49hEzGiBe/cMhyep8752Q=;
        b=t/PhPbvgVmVZNO9No4Qsi0HZRKHniwTfNY8al1/FxEWkHh40tZwZm8AG2oTdT6OtOE
         0U1EmeVMJvqIU3FT608D0nMfNpWZdrS74pAWAyQtXEcglvXWT3hoZM3gk9OIvEZlM92Y
         njI4DKdBxtMEsniD1uoqdp7LR2Kx0bmYr03XdW/yAxE9foJVT6JQDImhnmsDt0m+l50I
         qBJ7XAVxF44YbVX+PQeCKvfjZ+JK9mDAS6pkbvbegvxujp51QBihra7o3Hi9nduA2yG3
         PeiSIZbpwxu8jilOBEUmyAhKDo3ggadkcLt4SwKR3jtuywvAeXsITeIKnUnfOR+kZORB
         MdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xu8t61b4dNKr+fiQ7+DCPl49hEzGiBe/cMhyep8752Q=;
        b=M6hZh2ARe/zdVj85sywAQ3G+SL9U0LGWQXP3F+sfDKXyY2gNXaroi0htslia0NmSCs
         W8BUH537w+tjvhHoqkb1bubPhnQS3H0+1xMCjB5d1ifka3qLI0eN6tBBL0cBX6pFXaj5
         SqWj0mCS/A02jAbc2nTAWpSc9GQS/VKje3VMV9wB2AyBcfuYff0XeV8vya3wM00TLDMC
         xl1oG54MtDFG9JyKjT5mDfUy2WQy4tiPqWN5JMhPkFmRjarfJN6CPzdaa0/W4ThSpT8f
         dfIuXCozlHzMpAaBnmKj0pSWxxu36aG1QwGw6FZlsh2dz52IblCQvw3OYpC8jZ90unkM
         U9lw==
X-Gm-Message-State: AOAM533g1nj4KSFlzG1XVtoVgaK7XvnV+JXqDUizghnIJ1IdSBkW7p6D
        yuCjn+wKvBbtCrrS2HSxmEpchQs6KA==
X-Google-Smtp-Source: ABdhPJwlomHZW5LFrUvnOYp1W3ILbDMFcZXnyVZmSCcK70XUPvRiAPt5y/KlgaYdqO/4DLRWjmwMvNsM3A==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a0c:e311:: with SMTP id s17mr28925297qvl.45.1600694813892;
 Mon, 21 Sep 2020 06:26:53 -0700 (PDT)
Date:   Mon, 21 Sep 2020 15:26:08 +0200
In-Reply-To: <20200921132611.1700350-1-elver@google.com>
Message-Id: <20200921132611.1700350-8-elver@google.com>
Mime-Version: 1.0
References: <20200921132611.1700350-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 07/10] kfence, kmemleak: make KFENCE compatible with KMEMLEAK
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org, glider@google.com
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com,
        rientjes@google.com, dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, mingo@redhat.com,
        jannh@google.com, Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        mark.rutland@arm.com, penberg@kernel.org, peterz@infradead.org,
        sjpark@amazon.com, tglx@linutronix.de, vbabka@suse.cz,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>

Add compatibility with KMEMLEAK, by making KMEMLEAK aware of the KFENCE
memory pool. This allows building debug kernels with both enabled, which
also helped in debugging KFENCE.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Co-developed-by: Marco Elver <elver@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
* Rework using delete_object_part() [suggested by Catalin Marinas].
---
 mm/kmemleak.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 5e252d91eb14..feff16068e8e 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -97,6 +97,7 @@
 #include <linux/atomic.h>
 
 #include <linux/kasan.h>
+#include <linux/kfence.h>
 #include <linux/kmemleak.h>
 #include <linux/memory_hotplug.h>
 
@@ -1948,6 +1949,11 @@ void __init kmemleak_init(void)
 		      KMEMLEAK_GREY, GFP_ATOMIC);
 	create_object((unsigned long)__bss_start, __bss_stop - __bss_start,
 		      KMEMLEAK_GREY, GFP_ATOMIC);
+#if defined(CONFIG_KFENCE) && defined(CONFIG_HAVE_ARCH_KFENCE_STATIC_POOL)
+	/* KFENCE objects are located in .bss, which may confuse kmemleak. Skip them. */
+	delete_object_part((unsigned long)__kfence_pool, KFENCE_POOL_SIZE);
+#endif
+
 	/* only register .data..ro_after_init if not within .data */
 	if (&__start_ro_after_init < &_sdata || &__end_ro_after_init > &_edata)
 		create_object((unsigned long)__start_ro_after_init,
-- 
2.28.0.681.g6f77f65b4e-goog

