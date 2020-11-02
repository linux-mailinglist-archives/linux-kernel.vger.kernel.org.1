Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E9B2A2F1F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgKBQFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgKBQFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:05:17 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A825CC061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:05:17 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id y8so8934532qki.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=n8TE6VLWWv4zp+ZnErvJoE/L5oOe+Pde/aeeJYIsZf4=;
        b=tKz5YdB6UDUayZDh3Ann06GYOy0cU648f7bijqaKH/0c6sbX//YgHqrIyXb80G73EX
         BSD4o2VhAnO4XfMv8Q6MKJKqmzt6gvWCmI05xWOa0EE85RfO3NzNImWBxMycARw92GtO
         K8fP5BRNiHHOdXO7LrkxOaE6ID/WxaNyXdRhYOuBMclFNqL5ycYJmf0Q4WKR/DslMOHk
         qf0t+Ovi0zj2r7oDOmj9M1ZNnJ4yaULjzwMYSX0K8Km6Hhy9FNCZOs/PQvRF8TsAqZsD
         5zJUa02vnchJ8dHt7u6FYdtSi1La5iA14tjnHGUXDjNCBVQDsvVPIy6LabT+Uf/sPCb1
         yQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n8TE6VLWWv4zp+ZnErvJoE/L5oOe+Pde/aeeJYIsZf4=;
        b=McKvzPqM3iKJzcrR9NEbE6Lwf7x3OywXUaoCkHfn77MeIqGQhwQ1vKV5lLF9BP90Bu
         uXLG7LC3bdDXFjOS6u2LtQvjhFj0PNgUMulVQSnMXSi8oSw4KukxWFCIXux1xJE2wBuc
         aseW1FLCw5byVLkLa7+jhn9Dw1TFBj/EIUSBKqe+D96aG5Rjw/x6FAm6vgi9zcthzk2d
         ZtpGVxg+RjA7e20sPlXJIQ3q5LPyu0tcLfJTGryTc51ibwHHdTMZhNDFQHYb1XEXwB82
         I++8GjUlXDAVsRFI3Qzj3MuFVW1WmCVLt5u+emi9I1Y0tkvh9bXjcWAwSyVz9hlhKsWE
         ytjA==
X-Gm-Message-State: AOAM5301jZ2qx14V8dIJLMkvsYsAaBCQqPnyN2gqNqdKXPidqFnkAECJ
        +Q5EYLVwz2+Lt4Qr0XQacZLHxNjnRZKMO3rF
X-Google-Smtp-Source: ABdhPJxh+JDDPmS+b2lNs3Nso1hi/a5ml40n8p4Ea5AE7qbvFc8pXHQIMCNNNxampag9DgrRyKks8VCyyDOAMaIR
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:127:: with SMTP id
 w7mr7034621qvs.3.1604333116812; Mon, 02 Nov 2020 08:05:16 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:04:01 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <2673f10ce2a1186d88d6bda0023cc81e2564888a.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 21/41] kasan: don't duplicate config dependencies
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
index 8f0742a0f23e..ec59a0e26d09 100644
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
2.29.1.341.ge80a0c044ae-goog

