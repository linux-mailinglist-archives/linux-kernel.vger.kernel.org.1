Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608EA277C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgIXWw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgIXWvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:51:39 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DD6C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:39 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id w3so324319wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6hEKAMD+f8HNSFJwh5TzY+nY9DWh+cKlQh2Jz/ohGSg=;
        b=pi/15Azt45EHWLyUtjCxlXB5enq1782kvIDG+8HU2qG3e2rtDhEkXonPnUZsi06Eto
         c470mfbeiXK1NxgcOSWoL1FRIOH44mHG2yJWE2hMsbi+6XfZYtLci63nTh7d84PsAyFX
         dCHugDmII/ET/tP7V/7iM7bhqtIUIxH60N8YAamPYhpXIint60KGfsU9905K+TupFc+T
         TcjCakSKr6Y5tFD6HtzMRmulXqXdEw4zPQMyaagB+ooFRbjjiVu3+BCr3DKJehbnar7t
         vzEv+kSY/nVc/4CY+RkziGeXHqBN1urvE15zA2G5G5h+QTf/ungLkJFTENh7nMT35UG1
         CbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6hEKAMD+f8HNSFJwh5TzY+nY9DWh+cKlQh2Jz/ohGSg=;
        b=FdR3t32wf7cfhtGxE3nd7/8OfbOQVSgKRTGp6/uF0k9Ia2Ibks3SzOBs15fe+EYw/s
         X+rGw56K77ilPEToMtjO1xuInu9QJpwqSGELsj5ALrbNnLX5WnFglD9oUhAI3Pt0hgQk
         CNEwTb/KR/DsJeOx4mIRKpXGLzCtCOIsjJvYuNLhybwEcLMDvvyGCeVk+lrsFOMsbed6
         EM5ua3zWbPr87z75aVZ/MXwJR7teMa0Np+vAHJTJ2LQl29+am+5eWNst+Z6nu3sR27hK
         EjoIXGKZkvEL0wqabHNG/ggwsLW7IBFNUzgpt3Mxd1m6NkxvpdFot0zaqgon3RQipxXm
         t9Ig==
X-Gm-Message-State: AOAM530pxY1YaOh18QIkS/vBNGXjrlFRHWJERSgfiwLk7VumlVmyTOu6
        hppMeTRrAR6UZT7+2Im49ZxV6gl6lU9AiA/E
X-Google-Smtp-Source: ABdhPJy0Fc1EN8k6vuF5Zj2ENRUtTKs2pMRCxeNs9SFwi0xHDZj+TUg7dvgNLRkvlDFHpH1o2pdr0pz+NHKwkSyE
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c4d9:: with SMTP id
 g25mr846564wmk.15.1600987897744; Thu, 24 Sep 2020 15:51:37 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:26 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <cac8b9713e5d3ac1ab767a9cc42c61b04c46bdfc.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 19/39] kasan: rename SHADOW layout macros to META
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

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

Hardware tag-based KASAN won't be using shadow memory, but will reuse
these macros. Rename "SHADOW" to implementation-neutral "META".

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: Id2d836bf43b401bce1221cc06e745185f17b1cc
---
 mm/kasan/report.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 67aa30b45805..13b27675a696 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -31,11 +31,11 @@
 #include "kasan.h"
 #include "../slab.h"
 
-/* Shadow layout customization. */
-#define SHADOW_BYTES_PER_BLOCK 1
-#define SHADOW_BLOCKS_PER_ROW 16
-#define SHADOW_BYTES_PER_ROW (SHADOW_BLOCKS_PER_ROW * SHADOW_BYTES_PER_BLOCK)
-#define SHADOW_ROWS_AROUND_ADDR 2
+/* Metadata layout customization. */
+#define META_BYTES_PER_BLOCK 1
+#define META_BLOCKS_PER_ROW 16
+#define META_BYTES_PER_ROW (META_BLOCKS_PER_ROW * META_BYTES_PER_BLOCK)
+#define META_ROWS_AROUND_ADDR 2
 
 static unsigned long kasan_flags;
 
@@ -238,7 +238,7 @@ static void print_address_description(void *addr, u8 tag)
 
 static bool row_is_guilty(const void *row, const void *guilty)
 {
-	return (row <= guilty) && (guilty < row + SHADOW_BYTES_PER_ROW);
+	return (row <= guilty) && (guilty < row + META_BYTES_PER_ROW);
 }
 
 static int shadow_pointer_offset(const void *row, const void *shadow)
@@ -247,7 +247,7 @@ static int shadow_pointer_offset(const void *row, const void *shadow)
 	 *    3 + (BITS_PER_LONG/8)*2 chars.
 	 */
 	return 3 + (BITS_PER_LONG/8)*2 + (shadow - row)*2 +
-		(shadow - row) / SHADOW_BYTES_PER_BLOCK + 1;
+		(shadow - row) / META_BYTES_PER_BLOCK + 1;
 }
 
 static void print_memory_metadata(const void *addr)
@@ -257,15 +257,15 @@ static void print_memory_metadata(const void *addr)
 	const void *shadow_row;
 
 	shadow_row = (void *)round_down((unsigned long)shadow,
-					SHADOW_BYTES_PER_ROW)
-		- SHADOW_ROWS_AROUND_ADDR * SHADOW_BYTES_PER_ROW;
+					META_BYTES_PER_ROW)
+		- META_ROWS_AROUND_ADDR * META_BYTES_PER_ROW;
 
 	pr_err("Memory state around the buggy address:\n");
 
-	for (i = -SHADOW_ROWS_AROUND_ADDR; i <= SHADOW_ROWS_AROUND_ADDR; i++) {
+	for (i = -META_ROWS_AROUND_ADDR; i <= META_ROWS_AROUND_ADDR; i++) {
 		const void *kaddr = kasan_shadow_to_mem(shadow_row);
 		char buffer[4 + (BITS_PER_LONG/8)*2];
-		char shadow_buf[SHADOW_BYTES_PER_ROW];
+		char shadow_buf[META_BYTES_PER_ROW];
 
 		snprintf(buffer, sizeof(buffer),
 			(i == 0) ? ">%px: " : " %px: ", kaddr);
@@ -274,17 +274,17 @@ static void print_memory_metadata(const void *addr)
 		 * function, because generic functions may try to
 		 * access kasan mapping for the passed address.
 		 */
-		memcpy(shadow_buf, shadow_row, SHADOW_BYTES_PER_ROW);
+		memcpy(shadow_buf, shadow_row, META_BYTES_PER_ROW);
 		print_hex_dump(KERN_ERR, buffer,
-			DUMP_PREFIX_NONE, SHADOW_BYTES_PER_ROW, 1,
-			shadow_buf, SHADOW_BYTES_PER_ROW, 0);
+			DUMP_PREFIX_NONE, META_BYTES_PER_ROW, 1,
+			shadow_buf, META_BYTES_PER_ROW, 0);
 
 		if (row_is_guilty(shadow_row, shadow))
 			pr_err("%*c\n",
 				shadow_pointer_offset(shadow_row, shadow),
 				'^');
 
-		shadow_row += SHADOW_BYTES_PER_ROW;
+		shadow_row += META_BYTES_PER_ROW;
 	}
 }
 
-- 
2.28.0.681.g6f77f65b4e-goog

