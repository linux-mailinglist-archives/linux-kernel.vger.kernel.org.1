Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DC4277BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgIXWwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgIXWvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:51:44 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39867C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:44 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id x81so316238wmg.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=jdvdUBTX2W2BS/6LXn98shgk2aR72XHwNTl4Sjd6ky0=;
        b=ZQQPPgDSsb+RqoQ/V3HmUYIqMU+UrlOk8tc2bUZ7rhSzWXTeSE9UL3xTph/O5JV0Xn
         Gd4J220+dOAYM3xd/7stx4MLA5aq4ffisUoGAU3/SNWfgKsjkON3MAa7pyZmpDE9onQj
         XecIfFP2Qu8yEIpTdao36Gbvd4q+30zMx/df5kjZu6Jj/ibjqcfqLLOwQ8juDuKm+ig7
         YWDHJdcDPacXrGkRn6WAJhy2kISS76X8iPKtz1xPwukNUi9xOI/izZRrqFNCofqrcuGD
         aXA+Og8HAoq76Z4J/GLDsXuIxsBcCGO4JgWO3UvARfsE94gJB40NqaI+sKoLKkP/lVGJ
         75qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jdvdUBTX2W2BS/6LXn98shgk2aR72XHwNTl4Sjd6ky0=;
        b=caAvWG7wFT0uHEcJFktBJ0nAGCjOVHJE2tA/RC5KdEfrAWlnNbNg2dvWyuHerd+AcJ
         G7hvHmmd3jsLhsY1t2OaGJucRJtLs4tPi/CZsmoIye/5b5Dp00lM9awDPRKbs2xXgw4p
         EEO04gWk00DksUbJrPzL0ez0vrSrL9u6znbOJUnU1DWDD/X0wQiO1eJDo6erBjxWFHBk
         Nwh5sYEKXCt2MuBYV2kzrXLVTiCDck2l9KOijy8bHVtbw2aF14FpKawr1RsLTj+X+vWE
         3YWlZ8WgGFDgLEHpRBqQVEzHSQBWkZjBVbfXBFzDKOATOGqCQ3fb0LbJBkoGjR5VBxB6
         iEyw==
X-Gm-Message-State: AOAM530iHcC52JkcebIajrHvQW2x5rO175p5POC72ZKUQ5wALWcEUk5C
        mKI82x1rWHHuwaMCsrO5UwHAFjLVQ2HKLHCj
X-Google-Smtp-Source: ABdhPJy2CZOdFXzSDMUAYWi5qsJLuL4ZWGYGgwoO+4VNTAknABxkthypQXCnRTm13gA6Hia3YIbJdc+b+9sAWjV9
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:4d0c:: with SMTP id
 o12mr169wmh.0.1600987902272; Thu, 24 Sep 2020 15:51:42 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:28 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <d00f21f69ba7cb4809e850cf322247d48dae75ce.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 21/39] kasan: don't allow SW_TAGS with ARM64_MTE
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

Software tag-based KASAN provides its own tag checking machinery that
can conflict with MTE. Don't allow enabling software tag-based KASAN
when MTE is enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: Icd29bd0c6b1d3d7a0ee3d50c20490f404d34fc97
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e7450fbd0aa7..e875db8e1c86 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -131,7 +131,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
-	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
+	select HAVE_ARCH_KASAN_SW_TAGS if (HAVE_ARCH_KASAN && !ARM64_MTE)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
-- 
2.28.0.681.g6f77f65b4e-goog

