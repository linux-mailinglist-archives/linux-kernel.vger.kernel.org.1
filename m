Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51671277C04
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgIXWwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgIXWwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:52:07 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF71C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:52:06 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id b14so276951wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ISpXqi6MEt5kdGDveTeyFeZjiJg33x31XXLtNJOX90w=;
        b=aE6bW7ZDlkLgWzGa4o3PRAmLiBp3IRcgh5N7h4FNoVyd6AmscujV9JlWq8dKljxlC4
         523n/Y8i6ZrEXWAGM10ylIXaT9VSUlUo/q1y7jMxJTxGoRKHXZsVU+VxTg09dnzxtEbD
         19Mk0NQSrnAEHsTaq414dsxpbVsGA13Z4r2092REN2jpW9aTyE6HZcGf0RIyN00skHGv
         hrPrZptQh/k8srB8zWpu/LLo9neRTFmmGfSjvaZX6UJOskQAD54nSGk30kdAI8M2++s3
         KtYqNM+uEMLjiBC4sNDBQOXBaQfS5KGXKWJ1AaUCiUACAr5+tBsq94cciSXeRPI4hnF/
         bn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ISpXqi6MEt5kdGDveTeyFeZjiJg33x31XXLtNJOX90w=;
        b=pB4wAtLP8kxT3e+5I/s/wUQmWxnG9ErkYXJn0ApKQsUMlkW7R7DgLT3HzYc8V2IjuH
         IRKWwE+cEllvoOJYjrnW6oWTBG6WxUv7NpgmQ/Ii1q7jHcrKaXGDh7Vnttc5/j7fZcTo
         VhFbh6DckUbifzgqeWdpewhWVXSmblBAawYqWuz2cacOMLda1YSGtyXJ0OOdeQ6xZpgm
         2E5tw58N3WrvP4C4nH9Ynmp1CZSPtEybxEjnjniZo7pbiV2RLJz/btnATrFE7Uvhg9fB
         euw99h/4VCvyRjb+U5pOagkh5lbWmydE3t/FBI5U4ASM8oyiD589wn1IDrt1gosFz7WI
         2k3g==
X-Gm-Message-State: AOAM533UUhgh+kA3/3kTuYSxF031NsuqKwhGQHDPKEwZ7kIRN0VHZrRB
        lgKcozriKZbb+4KT1BcAFIGSocweTV8FaCTX
X-Google-Smtp-Source: ABdhPJzhV6ORp8E+PJLlYV1e4UYVrlVysMgIWJSr++y4qyiS9CmeuzTQVo6Ea/EmYKbrlqlyS8hMPkCXlel3wibI
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:4d0c:: with SMTP id
 o12mr202wmh.0.1600987925110; Thu, 24 Sep 2020 15:52:05 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:37 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <733e94d7368b54473b242bb6a38e421cf459c9ad.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 30/39] arm64: kasan: Enable TBI EL1
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

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Hardware tag-based KASAN relies on Memory Tagging Extension (MTE) that is
built on top of the Top Byte Ignore (TBI) feature.

Enable in-kernel TBI when CONFIG_KASAN_HW_TAGS is turned on by enabling
the TCR_TBI1 bit in proc.S.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
Change-Id: I91944903bc9c9c9044f0d50e74bcd6b9971d21ff
---
 arch/arm64/mm/proc.S | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 12ba98bc3b3f..dce06e553c7c 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -40,9 +40,13 @@
 #define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
 
 #ifdef CONFIG_KASAN_SW_TAGS
-#define TCR_KASAN_FLAGS TCR_TBI1
+#define TCR_KASAN_SW_FLAGS TCR_TBI1
 #else
-#define TCR_KASAN_FLAGS 0
+#define TCR_KASAN_SW_FLAGS 0
+#endif
+
+#ifdef CONFIG_KASAN_HW_TAGS
+#define TCR_KASAN_HW_FLAGS TCR_TBI1
 #endif
 
 /*
@@ -454,6 +458,9 @@ SYM_FUNC_START(__cpu_setup)
 
 	/* set the TCR_EL1 bits */
 	orr	mte_tcr, mte_tcr, #SYS_TCR_EL1_TCMA1
+#ifdef CONFIG_KASAN_HW_TAGS
+	orr	mte_tcr, mte_tcr, #TCR_KASAN_HW_FLAGS
+#endif
 1:
 #endif
 	msr	mair_el1, x5
@@ -463,7 +470,7 @@ SYM_FUNC_START(__cpu_setup)
 	 */
 	mov_q	x10, TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
-			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
+			TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS
 #ifdef CONFIG_ARM64_MTE
 	orr	x10, x10, mte_tcr
 	.unreq	mte_tcr
-- 
2.28.0.681.g6f77f65b4e-goog

