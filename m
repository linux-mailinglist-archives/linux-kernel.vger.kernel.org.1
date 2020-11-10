Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8282AE2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732966AbgKJWMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732914AbgKJWMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:12:30 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09EAC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:28 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t71so185524ybi.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AWBOrywbLQB+4u6q3KIizLA7Ns2sbu1oUV46sd6l1CY=;
        b=e3OOW+tqsg4Vhyv8X3Xod4zrgwWq1gbp/YZv7AZ3J3/ktq4wWa35UKYKxt84rtB1QK
         3B4r9P6nzYoSeXfhwLb70Ue8eIbEmI1Sdfi6UL/JvGFcHJXZUxVfDFR87BpN5zfNU1n6
         H1gu9RVYdPMQkmsBZjBIuIyCCHnK+nQUigSMGQUSZi1q/U3FKM0XU7I4N7ATJNcrusmP
         UYnBxdBH4Fv6Y/h7AwedKCXd2bdugFA7YtEk2wZaDv/9ONlZPbwFuLUk4CsvwXEeBDUC
         UBoKjhziv6+bciU3KcUH6jficpCPmTxrJLgNXG5wOVktrV9zHmBG50XrtsFWkm5WkcjE
         PcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AWBOrywbLQB+4u6q3KIizLA7Ns2sbu1oUV46sd6l1CY=;
        b=hhkDnV7e+0Y1s3H1XMQdnZGQQGUbhIfm32uHT9Bp6FsU7XEbpM7r5lBGnwKTX3eX4A
         Ykd/djYpYY2RuvMndt2mQIL9TzD+mIGFQJc7I5hCoQsPcfPPlNJQSDyTZezwtRKWwt4q
         VBScGzYgR4pInSnHphhMWDFhYUrRMz6FV41V7twH7RfmTuszs/mofemxX2rq03dGFRS3
         El39aRnAPN1CUT1dCPj6Yjt7EywYN7TemVWoaYdan56QhN5f3ozSp35xSe/yGKTcHApt
         EbhZvl39JldO4et/Z9672HBLHZjojJh7/wC1cb03aWappNZmBhZHGsj1tBYPJpWN7Lny
         UwuQ==
X-Gm-Message-State: AOAM532QetZYot6bTvH3kEVxOJrqaj+NeeQ71xgY2ZfHxFHyN0bjCKOb
        d4lBJRdga29YnCifZDT6jpQovflhFPyRGDBh
X-Google-Smtp-Source: ABdhPJwhlX6AQ97UEoMvYcNV25l2xhFbbk2YuOXWTd5VQwdGRTM2uJicQqv84zFQDeLs4QF0cawsX9B2H2Q7+7Sl
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a25:100a:: with SMTP id
 10mr29800073ybq.410.1605046347868; Tue, 10 Nov 2020 14:12:27 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:31 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <76b91f88120fc8c3e5923d6432a1d537ee584fc8.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 34/44] arm64: kasan: Align allocations for HW_TAGS
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

Hardware tag-based KASAN uses the memory tagging approach, which requires
all allocations to be aligned to the memory granule size. Align the
allocations to MTE_GRANULE_SIZE via ARCH_SLAB_MINALIGN when
CONFIG_KASAN_HW_TAGS is enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: I51ebd3f9645e6330e5a92973bf7c86b62d632c2b
---
 arch/arm64/include/asm/cache.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 63d43b5f82f6..77cbbe3625f2 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -6,6 +6,7 @@
 #define __ASM_CACHE_H
 
 #include <asm/cputype.h>
+#include <asm/mte-kasan.h>
 
 #define CTR_L1IP_SHIFT		14
 #define CTR_L1IP_MASK		3
@@ -51,6 +52,8 @@
 
 #ifdef CONFIG_KASAN_SW_TAGS
 #define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
+#elif defined(CONFIG_KASAN_HW_TAGS)
+#define ARCH_SLAB_MINALIGN	MTE_GRANULE_SIZE
 #endif
 
 #ifndef __ASSEMBLY__
-- 
2.29.2.222.g5d2a92d10f8-goog

