Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9537D2A7139
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbgKDXUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732729AbgKDXUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:20:00 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F59C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:20:00 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id f9so14546532qkg.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=85BahkB/ARH3bXDyEMCLh1SMwp72o82khunrv9SMNJc=;
        b=ZSx/SUZkoPccCRj9OftK35AirVXNnRtp71K5sDqNMlvALJiDEVVRbRbzni4v+KpEn6
         DR5qqfRr/HSb/5m93J1kjvN9bTrwdSivj2gbYskR57KH3/2fnHjS49zgRnf0XLBh7rTs
         TLIRmN9t69+li/zc8WOODCJDawuxRFoF7JJjpm5OVD4kXwtUqZ64BCR+rdIOLKZHXzaQ
         aY/VSzpkX3qDkZyveOcv4Yk62lSY8x0QOg95iZjPHujmoFBUFcpb42QtebEUpYUUDvYs
         fGiNAL0NQynN6Gx32F2eyMAHd93Z8x7NZ1jLXOSvuSzfc4TN6tOuhfaz1zohnDWnSxBI
         9TVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=85BahkB/ARH3bXDyEMCLh1SMwp72o82khunrv9SMNJc=;
        b=bhzFzvPq4eHsrlEsEHZHSGd3RPZB6c3cdIGeaRHkOEOSckk0kVMf/Va9cLEj8YNyv/
         Rp/MVDeZzHgSZUhq7CEw3GPnK+7q/MpPMLkiTTVP344sOVuPy6VcR9iov62umvG9n+rK
         egbSGX5x2Ku+fvvFsyli10f0d9SQ8lC8+PzBUBT49rhp41al74ug/HhxpcknhgM+gTMc
         +jR+nj3tWQh11z0IdmxGkA2yoenDXRaD/AR5NAxOlQORqfNpmO+tK9XNQwYqRXkV+g8s
         3d8iBCQ2Euo1nNziX84Csd5rSCyazdCaaEpSC2ykqZCWhKIHBun1j+7ReYB4+C6StiJ4
         R+7g==
X-Gm-Message-State: AOAM531KOecJOs+uf2OkB6ELp5xHlpEeaHBqiDqKls6fTdm9HyNUfvh2
        73vWUe+9NFKP+0+fN0Kw+JphF11FQHAHJ2EI
X-Google-Smtp-Source: ABdhPJxfI6kOiOxV7S8W+SnVGnmgLZBRR87caA7tfhL0oTiavOqISUFp7aEvbTK9SlXVrVm0rxc3OyFfrW6Sbyp4
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:a8e4:: with SMTP id
 h36mr421233qvc.24.1604531999270; Wed, 04 Nov 2020 15:19:59 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:37 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <5ec82ee9aaa25e2f15ddfbe292632de1d78b87b5.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 22/43] kasan: rename SHADOW layout macros to META
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

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

Hardware tag-based KASAN won't be using shadow memory, but will reuse
these macros. Rename "SHADOW" to implementation-neutral "META".

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: Id2d836bf43b401bce1221cc06e745185f17b1cc
---
 mm/kasan/report.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 594bad2a3a5e..8c588588c88f 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -33,11 +33,11 @@
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
 
@@ -240,7 +240,7 @@ static void print_address_description(void *addr, u8 tag)
 
 static bool row_is_guilty(const void *row, const void *guilty)
 {
-	return (row <= guilty) && (guilty < row + SHADOW_BYTES_PER_ROW);
+	return (row <= guilty) && (guilty < row + META_BYTES_PER_ROW);
 }
 
 static int shadow_pointer_offset(const void *row, const void *shadow)
@@ -249,7 +249,7 @@ static int shadow_pointer_offset(const void *row, const void *shadow)
 	 *    3 + (BITS_PER_LONG/8)*2 chars.
 	 */
 	return 3 + (BITS_PER_LONG/8)*2 + (shadow - row)*2 +
-		(shadow - row) / SHADOW_BYTES_PER_BLOCK + 1;
+		(shadow - row) / META_BYTES_PER_BLOCK + 1;
 }
 
 static void print_memory_metadata(const void *addr)
@@ -259,15 +259,15 @@ static void print_memory_metadata(const void *addr)
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
@@ -276,17 +276,17 @@ static void print_memory_metadata(const void *addr)
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
2.29.1.341.ge80a0c044ae-goog

