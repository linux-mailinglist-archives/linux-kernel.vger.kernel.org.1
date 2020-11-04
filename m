Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE732A714F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbgKDXUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732873AbgKDXUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:20:32 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3D1C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:20:32 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id 2so72951qtb.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=E7M1YMbMIR4yMAYd8ymzpiiG9f9KaGeAaRDscMDAbI8=;
        b=vNs/tV40nkRYLh+bd2pRN8tnAzZTvTLYqRkQOCW6i0NqSU2MOjkywCmEziyzjFDNbr
         1rXXXbldJOqtLhDCWvgATfC+KSCn3Aw1SgcbKhGaY2x/0ad9/WzaRZcunh9SZ9VhdWE+
         93GL/HUwq1B+KUAPEFz5rUbLRIrVBCkQXeDb31FsmrSWnLJ4R1ycm2wOLG0aAjeFzPNd
         jLN+AusTKOptQ9gIduhkrhSG92OcBcAhl87OkgzMmsZeCPCIffeaaQOvpyCBT3IoQjWh
         u6V6jH9lhOM7AGfqm48kv9PP2ZoAcIs2IFa3F6C/Ts6nXU4mcYfW9PncMAclN7WOtnNw
         P00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E7M1YMbMIR4yMAYd8ymzpiiG9f9KaGeAaRDscMDAbI8=;
        b=X2WR46wvtV4C4baoI3ZyYlkSDgC5A85k5GPgu9aqso5HFDcZlq9xJRq/fGe/OIQQUt
         OPOIa57FDezFJTQbmzi9Tk1JHCOU6egNRfMORSai/9NffW6QBn7D2nLzzf/1PGsX1ZOE
         vPgUC0H3EBaeh8fk2fBmOrJA2azHCmbLQ8JIf9/n8V34exxODX6LUSEijcgpPjfxE2p+
         5FgtiFg7+99icjMZ7fR/80H0jsgiOqiqJWFKpKinzcbg41udAV6HxQV/VBZI6zwmqG7B
         yi8Cv8d1FXsXaUl7osEIQ6+MAdaCp5XiUwIMX86mFDvGauepKH6ZexcZShai9IxnBxCC
         z+WA==
X-Gm-Message-State: AOAM533ZRv8FRPSGspV1Lnj1BXd0JzpYiPKEDWUa4MRRDLpQlnR79izz
        KdyhSjVVHX/jnjCR/bbpm+3E6SiGzOEJYUtu
X-Google-Smtp-Source: ABdhPJzqgs/A05RlcSOyed/F/WMpRLrfZfCyn2cPNSS5rL4ubrhak1Ah1gehiCULAgkww5qluz2BjCh1uVyX/JcV
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4b32:: with SMTP id
 s18mr435733qvw.16.1604532031338; Wed, 04 Nov 2020 15:20:31 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:50 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <dff2b79698978d86f4813fb7901492a1a61190b7.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 35/43] kasan: define KASAN_GRANULE_SIZE for HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware tag-based KASAN has granules of MTE_GRANULE_SIZE. Define
KASAN_GRANULE_SIZE to MTE_GRANULE_SIZE for CONFIG_KASAN_HW_TAGS.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I5d1117e6a991cbca00d2cfb4ba66e8ae2d8f513a
---
 mm/kasan/kasan.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index e3cd6a3d2b23..618e69d12f61 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -5,7 +5,13 @@
 #include <linux/kasan.h>
 #include <linux/stackdepot.h>
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 #define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
+#else
+#include <asm/mte-kasan.h>
+#define KASAN_GRANULE_SIZE	MTE_GRANULE_SIZE
+#endif
+
 #define KASAN_GRANULE_MASK	(KASAN_GRANULE_SIZE - 1)
 #define KASAN_GRANULE_PAGE	(KASAN_GRANULE_SIZE << PAGE_SHIFT)
 
-- 
2.29.1.341.ge80a0c044ae-goog

