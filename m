Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C79277C05
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgIXWwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgIXWwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:52:24 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88A2C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:52:24 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id m13so510891qtu.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gEuj2b9WdC9oBanHgBD8GdnBbbRvvuF2rkOpQJigrMM=;
        b=JIbAlw2WviAZ3NcpcEWMBxrRnN/ODOpCEnkFSV/tpeIF3G28JZrmI5tqLOAvPnSFfK
         dbZl21niTZ+VjAFzkEgQiu9PJSCY/brdhcVz/c4jHMYy+vlwO2r2454npuRCehH4O8a5
         bT7nLd/MsiaWkNv4VyC7KGxqDoBapmdH9NDHsd3nyxNcazyx+F1Jrslc2YpFML94wbJp
         lA+sWhzbQdIfShhGi7ypkFNUzYRfSkP2pmpwLqbJ9HoCc5n++Rwc+PdunApYdZb1vmRF
         AyDh/7o4WztLPfJMW0OV0+aVFZqdnJKmtTiOB7X3EQBkoAiGIYi/nwSlt7mDJpqtMf0g
         4O0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gEuj2b9WdC9oBanHgBD8GdnBbbRvvuF2rkOpQJigrMM=;
        b=TRbl+znYFrKs+X/0TOdJhBpYDBp/dopQF2K+kZ9zKCO1HxQ+ahZoAnNJRFelc5x+8C
         mBTM3+TEdTKUTmlUtmrI0Isv70/rQazWG309oW6/QyvRp2GjLFDhpLX8UECCwnxmX2X6
         D+mBg4Q/p+T6vih5eoORUo9i7LJfKEsBQm4BoVNyS9LLwZop6HhnTnjXKX99psoKnmZm
         2tK/sBn0xbH5hJ02NGFaCfae56J2BbuM6KfYpziymB+SXpPg6aELYsEFJ5Dxf+ZvYUxj
         g+/LBtVvHt1oI9bqT1XRFPnWMQLDuSiGLJDTTv6BRkqiiPtu6EoicXMxNEskR4h1+nBx
         1iwQ==
X-Gm-Message-State: AOAM5329I+2YGBTYpV8XmVb53Vu1S5+pv79RpmvH9/I42aDRS3m/hgfe
        DSjoagNAh9Avc1WrOUy16JCtBjVtvlxAnTLa
X-Google-Smtp-Source: ABdhPJzhSo9kHU85hHjvut8uMbw9MAeIY2MG58bH3ahvzG9KwlNiUATEsTYQSYjo5klsOOjalTUpEJyWtYTKvhCw
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:5387:: with SMTP id
 i7mr1572849qvv.43.1600987943938; Thu, 24 Sep 2020 15:52:23 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:45 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <04d60f57ea65706bf38450d29a64e34a69df2123.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 38/39] kasan, arm64: enable CONFIG_KASAN_HW_TAGS
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

Hardware tag-based KASAN is now ready, enable the configuration option.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: I6eb1eea770e6b61ad71c701231b8d815a7ccc853
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e28d49cc1400..8d139c68343e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -132,6 +132,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
 	select HAVE_ARCH_KASAN_SW_TAGS if (HAVE_ARCH_KASAN && !ARM64_MTE)
+	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
-- 
2.28.0.681.g6f77f65b4e-goog

