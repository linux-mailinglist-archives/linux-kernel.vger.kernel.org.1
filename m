Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45D4280B39
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733171AbgJAXM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387624AbgJAXMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:12:07 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9421FC0613E7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:12:02 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id b14so42658wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hpJpWYgCbJqCacKELcaZY87V3j8i77+2ePhmmcYZBwE=;
        b=Z/TzKhjpg91DfKCc/CiqW/F4XrM8/U6zmv+9HIDxEvnoi1ckNUpyOG4cj68JJ6spg+
         aA9EFmQM81hY10kgafDc8KyTDl+2q41H6ENogJ2RtbBGAiUfJEx+eP7tAbUo/mAbsiSi
         jd6cZ+jdd1pfv5n7yYC7rhk8KsHKLG1/XUiVvxLVhWrSSQYdJE1OaJqpM4XLRZAorfiy
         bjH/N2+Ql9DPeM7RD2tlnzJ6mNi8yFpYOsFfTg/pg04yvlTT6VMnfE0DvjF5F+YM0Mod
         nla9jlN6fHFSKjkU8Pf7uqZNUyixW/3+UYlU2wIk5flUxhn42CjfCWGpcoxtc1RRM9u3
         9VyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hpJpWYgCbJqCacKELcaZY87V3j8i77+2ePhmmcYZBwE=;
        b=O7pqm3EiMXXy8R3rKwpBFi3Ph87gCX05FXZKw5F4CQls9G5i6YHgMjSj9TtnSMSKnR
         J9ojCckWzZJ28efElBeCr+RNhIGlbrTctcwk+GXRpemiLazLlcAcJbTpTf0FMNXMNUVv
         aFdb9Ob+Le5a3FjxqI3GwXEvOCDvBaRtUpaVbYiCDcle2331Eg4SLnvUwu6Q7AfbnHP9
         yft767+tF5IVVWW8XjhfvB0Iwhc3eFK7D6UvKm+ILNUz+csshCPZ9vfnXOhW8wlD2qNK
         0c6jNF3hwzc7zAYsHw4K2fX422GWE3+TYtvRdjA1W2XTC0rJUGapLtcHY/fTQMENqYK0
         VCHw==
X-Gm-Message-State: AOAM532NC3OYLrwI4lKvcLt9N0cekdbGIIEgA6OYTK1T8ktQDO7AQQ/0
        WUTfc5wnKiE03NLQD0eZunnWvjsWYlCUJnp7
X-Google-Smtp-Source: ABdhPJx0Pq6gAwprm7ylOWsjE098TiN8AOf8BUCNUupdLVMrlls34MPn6CFBY8IIC1tomeVuQwSv3CMV98Hex5dB
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:22c5:: with SMTP id
 5mr2354008wmg.34.1601593921173; Thu, 01 Oct 2020 16:12:01 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:33 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <2f2c30b9793bd5da7601043c9027d1b87ccb2e8e.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 32/39] kasan: define KASAN_GRANULE_SIZE for HW_TAGS
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
index 9c73f324e3ce..cf03640c8874 100644
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
2.28.0.709.gb0816b6eb0-goog

