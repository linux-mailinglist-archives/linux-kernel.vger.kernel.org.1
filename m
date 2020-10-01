Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070AA280B11
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387563AbgJAXLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733304AbgJAXLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:11:13 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D74C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:11:12 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id w7so131839wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BiBwOA300QhxWc80ZJY9u1KximGsgeGOJ7BXhwr4DYI=;
        b=KR9aH6cOj3xj0Tv7uVW4YbkD4gucBvMwbquiUSEetcOOULzOMPPj+0LBbeLDsEn6xN
         1IVpHX0M955Dcl5bbqOwSk8ZsH4m87349TFQuHNiGz6/uqPgW+8byz6CR9aCAnpeFaq6
         ol6M1LyyslHIGMszPWtvhbBB9QJP2ZOG+zOLC2JfsEZK8dIZ0HD/YqsOUTQGx+y6SKmd
         qMSjZZA0Fgur17drDbLzTIHf44z1SKSLASvKJbOy7fZVlPQF/BXxciP3QB8tXZZvDqP/
         fsvuD8DpMocaqLjwZURWPHAsntya9U3ZUK08lu5sFSXjFsoDD+cdF840Y4rxGpC2l+At
         6aWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BiBwOA300QhxWc80ZJY9u1KximGsgeGOJ7BXhwr4DYI=;
        b=nceKwodB7QCMH3UQkEAZGYaXpeN6OBuRBtegE/hCBk0gdVkmiPJ0hN5YNtltCS3bLA
         q/IWsnFSICWRXrP2zuf4fd73lDNaxVeBsbW5ev1TWr/kCj7+eYNQcopJ8iSVP2qpQbju
         PyAMvmL/Ec6MCMEbbQ+4ZAgfYcTpSGfYkJxohlpUAcwSReB/dTET6wOWe3mzAZMOSaGS
         6irGvyUMzeiVwqVEH1O5yMhkzhrfW4PXV1fxswX0rquDvMuWL9xt20Ro8q1+xX2vYS3K
         njEziuk4hQO0tHFpz6rdpJHYd38yCfYONrNmWuiD8ss3ygB5/thedmavrh1E7JbTiRHT
         NePw==
X-Gm-Message-State: AOAM532vO5LbMJ2xgBUBtyKkIcFyfj+G3456Mc/5Y72EzqPpLitVGIx6
        w56tC1c6gsJI0z85Tl/vljwbtJcrMTSyW0w1
X-Google-Smtp-Source: ABdhPJyx5TxeKaVViHN1/tArVa8dGVdnr3CQ2RpreFIjzyF6P4ggefYuncYDX4SkYOmoY2mXzWlV0CAAa8/+Aj+Z
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:f009:: with SMTP id
 a9mr2285015wmb.158.1601593870620; Thu, 01 Oct 2020 16:11:10 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:12 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <9bc9adc49d90831aad292b1927cac60570380d2a.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 11/39] kasan: don't duplicate config dependencies
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

Both KASAN_GENERIC and KASAN_SW_TAGS have common dependencies, move
those to KASAN.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I77e475802e8f1750b9154fe4a6e6da4456054fcd
---
 lib/Kconfig.kasan | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index e1d55331b618..f73d5979575a 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -24,6 +24,8 @@ menuconfig KASAN
 		   (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
 	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
+	select CONSTRUCTORS
+	select STACKDEPOT
 	help
 	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
 	  designed to find out-of-bounds accesses and use-after-free bugs.
@@ -46,10 +48,7 @@ choice
 config KASAN_GENERIC
 	bool "Generic mode"
 	depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
-	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	select SLUB_DEBUG if SLUB
-	select CONSTRUCTORS
-	select STACKDEPOT
 	help
 	  Enables generic KASAN mode.
 
@@ -70,10 +69,7 @@ config KASAN_GENERIC
 config KASAN_SW_TAGS
 	bool "Software tag-based mode"
 	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
-	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	select SLUB_DEBUG if SLUB
-	select CONSTRUCTORS
-	select STACKDEPOT
 	help
 	  Enables software tag-based KASAN mode.
 
-- 
2.28.0.709.gb0816b6eb0-goog

