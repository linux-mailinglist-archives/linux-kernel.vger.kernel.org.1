Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9D627CF74
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgI2NjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbgI2NjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:39:04 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EB8C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:39:02 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id q131so2658616qke.22
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=vVOlNt/WCejDp1JOCEsvSSdVHILjJnc43Mcb0PKSl94=;
        b=UOSBvRZBZKrpnksJMXA3OOhNYA+IsYKy4qy9MiaMAWv4Qmco6I0lGG/1E1y4vY58vz
         CZBn6KJFIpSQPzI+0qHZF+n9AKpdnR1c/FcXU2vi9d6AcLaxN+0h2+6lKxpJ+VwD/Fb0
         l3hIQBgDmYX4Qqem9eqXPEynllsNkpk/ipyQ/c4kOJwGgN0Mahu/+1w7p7blTpkFPPDH
         eBthRpEWp+J41zyd12Z9gm0BLrS+hsDfGa9rRHXKGig2x9ktsb/VO1/Z+5uzlxgK3Imv
         TxFCLtBlLbW0IQrbRuWQz26NF7uEVM4FpTthHS8NRQsg6B3mcVsX1dkd9vbBMEbwjd3+
         Bw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vVOlNt/WCejDp1JOCEsvSSdVHILjJnc43Mcb0PKSl94=;
        b=FY4ReoxcGnKBcC/nmzxVhOCOnZBjLPRTPbmX49T9F4EMqPmK6a4maFPiT/S8dktnHS
         vitJT7Dvs8PLyTHYY4qvFVfl3g7hbsLYOl+ESWFphzHlmk3jRNFePNzp/pJsFba19sP5
         MI2/D5Dx4+0BB+UAPksCyH12gn6k0C6+P8Tuay7vlwB6ZXWfabKuHkqJv5opma+bRMZQ
         PxVpfxwaCsqA2sqLqBT7Bwisi5nL4TSqFs7w8qXhO++Ix4pHPX325NyLAr/tThuI0ac2
         IldP6wguCorflDKJF+1GArtY5Db6D6lzVZfxOGX2202cb2+Ob6iZPKzAbJ538wa5iwu2
         jaBA==
X-Gm-Message-State: AOAM532XwzwGRvD9UOVI1okurYmCZN86tc0cdCDDr8JIi36/gWro7+Rh
        WoaE6qJukOOcT7oyB6WgOE7mYfzEhQ==
X-Google-Smtp-Source: ABdhPJxPHumSkQ+1sRW54lJFlDtPVwTgrVQLDVfUTBhLd4jdPTbPDJavbzzqCAAj2yGSJ8AXrL9sZ4EW2w==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a0c:f6c4:: with SMTP id d4mr4373033qvo.41.1601386741788;
 Tue, 29 Sep 2020 06:39:01 -0700 (PDT)
Date:   Tue, 29 Sep 2020 15:38:11 +0200
In-Reply-To: <20200929133814.2834621-1-elver@google.com>
Message-Id: <20200929133814.2834621-9-elver@google.com>
Mime-Version: 1.0
References: <20200929133814.2834621-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 08/11] kfence, lockdep: make KFENCE compatible with lockdep
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

Lockdep checks that dynamic key registration is only performed on keys
that are not static objects. With KFENCE, it is possible that such a
dynamically allocated key is a KFENCE object which may, however, be
allocated from a static memory pool (if HAVE_ARCH_KFENCE_STATIC_POOL).

Therefore, ignore KFENCE-allocated objects in static_obj().

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
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
2.28.0.709.gb0816b6eb0-goog

