Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8AA26B004
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgIOV4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgIOV3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:29:24 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAC9C0611C1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:37 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id l15so241621wmh.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SMbpusk9UPFJ5bty/4o1CBzmR923bOTqJu4p/yHyDoA=;
        b=et5na2SrMTeEtk7EWiOzMg0RIlxhLHym2BHU/vxQbTuVAB46m56Vgt+uJkfq6C1HPC
         LdLXNgovu/Qc5xh0rc0eA0wF96LwrPAujajBypmTg2C9f00xeyv2mMhZBtqDmrJPwnmx
         wItchGs3NqcMVlvP2XrDs63cj25TUc29zJtXuj8oAElnc584tZimCx/2j9MN+aveLpbe
         6CExqkZyjmo1zU4cX09+bUDu5QeTKo0OoBQfzNRGLVcv7Pxfas6s/765v6fOyapNv95w
         Ef+ox4JfLp90yekqgK4IN7gatUONDMd8P8B2lydG89kADRCDIGIqUbs8vlf0OeozcRfe
         bYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SMbpusk9UPFJ5bty/4o1CBzmR923bOTqJu4p/yHyDoA=;
        b=nKLc8UKys4V5ZKFLgOQnMIWPcJliEtVh+17WztBswuwplQx/ukZvOxYRisUXmJQtW1
         rS7Vy4WIAhBiLVjT8PWVrZLuM7r+8ak0cOE2dUFazNteQvYn4VENcbBDqgzKvfx/gSml
         TvAuMFpkAGncjCFRRi76j6MZhQdrY5M0cEcwehbGYzHNpmoYfjOtscuOU2kFThYMMxsi
         Aod1Q/AXOQdFIcd5FdqExxByiAqwOB1e8IsmaXdC+3pip3IFCBXG6bpx/yQ90XIvmFhA
         Z6eKcavNI0dHktyuGaaY2dg5i8FMDSPfwRqOK719e+fXc5AMMEztcGIlRcu3HJpmLzd9
         AiKg==
X-Gm-Message-State: AOAM533wyTcuOdAt1ZRkW6bQFHsxWXysVClEhAPCmgL2fUUd3LhHMrVj
        NvCjRRmgWYYc+dMFS2RosC4IzMkydGsrWSyx
X-Google-Smtp-Source: ABdhPJwujyv1jICnb8Z84hBJXMAHZtwatucCSBcuhq+9tnfe5N4bmea9C5aR+KvNqkTUUlaGyRY0Mdi7Bwl5AIg1
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:5281:: with SMTP id
 c1mr23095217wrv.184.1600204655669; Tue, 15 Sep 2020 14:17:35 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:16:12 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <3a3002e1d70f8faf2dfc07176c3ece22450b68a3.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 30/37] kasan: define KASAN_GRANULE_SIZE for HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware tag-based KASAN has granules of MTE_GRANULE_SIZE. Define
KASAN_GRANULE_SIZE to MTE_GRANULE_SIZE for CONFIG_KASAN_HW_TAGS.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: I5d1117e6a991cbca00d2cfb4ba66e8ae2d8f513a
---
 mm/kasan/kasan.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 8b43fc163ed1..ba63d8a62968 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -5,7 +5,13 @@
 #include <linux/kasan.h>
 #include <linux/stackdepot.h>
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 #define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
+#else
+#include <asm/mte-helpers.h>
+#define KASAN_GRANULE_SIZE	(MTE_GRANULE_SIZE)
+#endif
+
 #define KASAN_GRANULE_MASK	(KASAN_GRANULE_SIZE - 1)
 
 #define KASAN_TAG_KERNEL	0xFF /* native kernel pointers tag */
-- 
2.28.0.618.gf4bc123cb7-goog

