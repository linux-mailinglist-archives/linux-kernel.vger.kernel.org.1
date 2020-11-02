Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5151B2A2F3C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgKBQF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgKBQFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:05:47 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF06C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:05:47 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id i39so8345179qtb.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=E7M1YMbMIR4yMAYd8ymzpiiG9f9KaGeAaRDscMDAbI8=;
        b=B+b74HQOp3f/kfOxXBITIRBEll8gls2oSrKFlkytGbLYfoRHHu1uMoDCIY1/QpTreR
         1OWKmsbQ3kb79xzISbXlnmxB2nFKPH9xGsspSZnhWewaaEzeQQzpYHdE+Tvylc9ZEy1C
         Ynm9YJUeyl+VKHbYnn3nmDML3XSJTKgfLfCPTEHNx4Yj+yOt3oFEMIQaUDLmJGta7A6s
         +CZAF+bpODT0CKwxt9FAzMVIgqHaDyQzk6/HgFfJyDbRWtMk9xod5t/V99ooccHzwWKh
         mR2nvhRCb+Ky6uhyTKye5Xm1E2L9ta9OLifCVWA+NfdRlyOE/FFvrXthJ3hePSrMPK9z
         3dQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E7M1YMbMIR4yMAYd8ymzpiiG9f9KaGeAaRDscMDAbI8=;
        b=ZSSVi6TLxIGKgRSBrl0mKDav+R0ICRcH9m3ZU/IQa38OcAfFMTiOUE0y8y9G9oX3vs
         Ikh7m1RfvQu9N/hkgzIS3az3boY7Ey//HPMe6wZz8QUvHSkuuL+WY8iJOsNVIs1GLF+e
         EqlgYvmyozAr2/F1kt5vAY+MSztdz50n0tNo8SxkrPQNYd031zkuOGqqqDrMr6Lpk8wP
         oITz17AFrGVWPMIYq/oTzxnfbefikm0dfeYuBOohP4ZdM5fx/Hpf5H6opf0h+dGjtQNZ
         o+5LgTOe+6O/NE41oP5h3OqKao78NI9Us/YKCrgh5T2SmS5O6ABFppSq+ezi1e7NoyUY
         1X4g==
X-Gm-Message-State: AOAM533AWLR6KEBlXWBPJWDlbLCtmFFEs64xW2AUM2P78QFdYLIV9o7O
        YPKeXq1jYPnkaTyWA+M5wqdwP79/AWQWnLmp
X-Google-Smtp-Source: ABdhPJxCpvODUOhYUZL5nc/yMsQuPusWm8gNXkjp/HkCNDgiJkwTvpJ1d1RHTffAkbxP5qgxtSriqvYjoje6hyoR
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:f70e:: with SMTP id
 w14mr23027576qvn.10.1604333146336; Mon, 02 Nov 2020 08:05:46 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:04:13 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <adfb51f61d93c78ca37d6238d4a435e755b30e43.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 33/41] kasan: define KASAN_GRANULE_SIZE for HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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

