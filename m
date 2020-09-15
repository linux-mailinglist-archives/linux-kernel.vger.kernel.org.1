Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D79426AFFF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgIOVyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgIOVaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:30:16 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC583C06121C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:07 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id m20so247457wmg.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=cNUkjw3h6h2vvdGQHstiUCBBTL6uA9taUHJKEUHsZNs=;
        b=Uqy/64yl/TSrssjZLH9qRL0b1Q9ojBJrOiiVPJ6ffDQyrLQwhEesqFOJzIy2SSQmB6
         5Wrl7d+D7GwJr3iWjqN/g1Ny2ldoUFt/lxuop9KNLjFnQAb2HjaHQKWj7TRjUdJC2lWd
         hQ4u7RssH2+XZd6nSzU8L9eWNVu4lSjWsQPxXgZQGxMY/ynXM8tFY+vKO9z+j0VGLgaN
         u979tZVDr+n6SAG0gkOE5MPgiZXcWW7rtVKsnD6/NdRFxC5Ve11juxVWE4kEhLdnaz1x
         SZ7nt3Wfnj/6q1QYIc3/bAtTVIKiLtanjm1hhdDEPfwaS62q9mGK2QonxuEACBYt+zCJ
         zwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cNUkjw3h6h2vvdGQHstiUCBBTL6uA9taUHJKEUHsZNs=;
        b=mdc5CIFpbCxks2ugj92HziwaH9disTtNOTRJUrHauQXCqoEuBOgShqg5RguUsDOwdE
         r2iPvKntTOWzZ9GiVLG5YqCzt8TXzwhbIb87eMbppTf62hAuqXNfI/12ouk7MX/uoPO0
         +fYfSGN7lYhL59tKj6IYGM+Zc6egZ0QpcumL2YE2tHDVE66UmWDalKmOPQs8SLiHZIKJ
         M+8N2nAvOWL5RC6npmcaOS/OVSCeMP67u6UOZLUWtjmNyd4DJ3OV+pFfcU/xD4QjQum4
         xRy2VrPr/4jTGddNg/U4lI7sWhB5nnws84qhCGENYL05EEYd25mXPdUVh0654H11sQvP
         BtMw==
X-Gm-Message-State: AOAM531QtiSWnP9CCUGSuBPDaIrKTb7ZYYxe3CYw0UJx1aYAH+dNtJ8Q
        jSRdM6JJ79u0qX9mCXLxr/VXNkgWBX6Q6Kn1
X-Google-Smtp-Source: ABdhPJzL8BhYNRzK4slQohtZ+7TSTK/+JbYrZ5VcU+mY7HWwBH8wrvRTXucYiWwyPZaxtMd5XV7Uyp2JR6WDFw6Q
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:245:: with SMTP id
 5mr1264364wmj.33.1600204626209; Tue, 15 Sep 2020 14:17:06 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:16:00 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <ab44c5a0f7edf21d17c4212167a2ec2ca3f69582.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 18/37] kasan: separate metadata_fetch_row for each mode
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

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

Rework print_memory_metadata() to make it agnostic with regard to the
way metadata is stored. Allow providing a separate metadata_fetch_row()
implementation for each KASAN mode. Hardware tag-based KASAN will provide
its own implementation that doesn't use shadow memory.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: I5b0ed1d079ea776e620beca6a529a861e7dced95
---
 mm/kasan/kasan.h          |  8 ++++++
 mm/kasan/report.c         | 56 +++++++++++++++++++--------------------
 mm/kasan/report_generic.c |  5 ++++
 mm/kasan/report_tags.c    |  5 ++++
 4 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 38fa4c202e9a..1d3c7c6ce771 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -56,6 +56,13 @@
 #define KASAN_ABI_VERSION 1
 #endif
 
+/* Metadata layout customization. */
+#define META_BYTES_PER_BLOCK 1
+#define META_BLOCKS_PER_ROW 16
+#define META_BYTES_PER_ROW (META_BLOCKS_PER_ROW * META_BYTES_PER_BLOCK)
+#define META_MEM_BYTES_PER_ROW (META_BYTES_PER_ROW * KASAN_GRANULE_SIZE)
+#define META_ROWS_AROUND_ADDR 2
+
 struct kasan_access_info {
 	const void *access_addr;
 	const void *first_bad_addr;
@@ -167,6 +174,7 @@ bool check_invalid_free(void *addr);
 
 void *find_first_bad_addr(void *addr, size_t size);
 const char *get_bug_type(struct kasan_access_info *info);
+void metadata_fetch_row(char *buffer, void *row);
 
 #ifdef CONFIG_KASAN_STACK_ENABLE
 void print_address_stack_frame(const void *addr);
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 6306673e7062..c904edab33b8 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -36,12 +36,6 @@
 #include "kasan.h"
 #include "../slab.h"
 
-/* Metadata layout customization. */
-#define META_BYTES_PER_BLOCK 1
-#define META_BLOCKS_PER_ROW 16
-#define META_BYTES_PER_ROW (META_BLOCKS_PER_ROW * META_BYTES_PER_BLOCK)
-#define META_ROWS_AROUND_ADDR 2
-
 static unsigned long kasan_flags;
 
 #define KASAN_BIT_REPORTED	0
@@ -241,55 +235,59 @@ static void print_address_description(void *addr, u8 tag)
 	print_address_stack_frame(addr);
 }
 
-static bool row_is_guilty(const void *row, const void *guilty)
+static bool meta_row_is_guilty(const void *row, const void *addr)
 {
-	return (row <= guilty) && (guilty < row + META_BYTES_PER_ROW);
+	return (row <= addr) && (addr < row + META_MEM_BYTES_PER_ROW);
 }
 
-static int shadow_pointer_offset(const void *row, const void *shadow)
+static int meta_pointer_offset(const void *row, const void *addr)
 {
-	/* The length of ">ff00ff00ff00ff00: " is
-	 *    3 + (BITS_PER_LONG/8)*2 chars.
+	/*
+	 * Memory state around the buggy address:
+	 *  ff00ff00ff00ff00: 00 00 00 05 fe fe fe fe fe fe fe fe fe fe fe fe
+	 *  ...
+	 *
+	 * The length of ">ff00ff00ff00ff00: " is
+	 *    3 + (BITS_PER_LONG / 8) * 2 chars.
+	 * The length of each granule metadata is 2 bytes
+	 *    plus 1 byte for space.
 	 */
-	return 3 + (BITS_PER_LONG/8)*2 + (shadow - row)*2 +
-		(shadow - row) / META_BYTES_PER_BLOCK + 1;
+	return 3 + (BITS_PER_LONG / 8) * 2 +
+		(addr - row) / KASAN_GRANULE_SIZE * 3 + 1;
 }
 
 static void print_memory_metadata(const void *addr)
 {
 	int i;
-	const void *shadow = kasan_mem_to_shadow(addr);
-	const void *shadow_row;
+	void *row;
 
-	shadow_row = (void *)round_down((unsigned long)shadow,
-					META_BYTES_PER_ROW)
-		- META_ROWS_AROUND_ADDR * META_BYTES_PER_ROW;
+	row = (void *)round_down((unsigned long)addr, META_MEM_BYTES_PER_ROW)
+			- META_ROWS_AROUND_ADDR * META_MEM_BYTES_PER_ROW;
 
 	pr_err("Memory state around the buggy address:\n");
 
 	for (i = -META_ROWS_AROUND_ADDR; i <= META_ROWS_AROUND_ADDR; i++) {
-		const void *kaddr = kasan_shadow_to_mem(shadow_row);
-		char buffer[4 + (BITS_PER_LONG/8)*2];
-		char shadow_buf[META_BYTES_PER_ROW];
+		char buffer[4 + (BITS_PER_LONG / 8) * 2];
+		char metadata[META_BYTES_PER_ROW];
 
 		snprintf(buffer, sizeof(buffer),
-			(i == 0) ? ">%px: " : " %px: ", kaddr);
+				(i == 0) ? ">%px: " : " %px: ", row);
+
 		/*
 		 * We should not pass a shadow pointer to generic
 		 * function, because generic functions may try to
 		 * access kasan mapping for the passed address.
 		 */
-		memcpy(shadow_buf, shadow_row, META_BYTES_PER_ROW);
+		metadata_fetch_row(&metadata[0], row);
+
 		print_hex_dump(KERN_ERR, buffer,
 			DUMP_PREFIX_NONE, META_BYTES_PER_ROW, 1,
-			shadow_buf, META_BYTES_PER_ROW, 0);
+			metadata, META_BYTES_PER_ROW, 0);
 
-		if (row_is_guilty(shadow_row, shadow))
-			pr_err("%*c\n",
-				shadow_pointer_offset(shadow_row, shadow),
-				'^');
+		if (meta_row_is_guilty(row, addr))
+			pr_err("%*c\n", meta_pointer_offset(row, addr), '^');
 
-		shadow_row += META_BYTES_PER_ROW;
+		row += META_MEM_BYTES_PER_ROW;
 	}
 }
 
diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index 29d30fae9421..6524651b5d2e 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -127,6 +127,11 @@ const char *get_bug_type(struct kasan_access_info *info)
 	return get_wild_bug_type(info);
 }
 
+void metadata_fetch_row(char *buffer, void *row)
+{
+	memcpy(buffer, kasan_mem_to_shadow(row), META_BYTES_PER_ROW);
+}
+
 #ifdef CONFIG_KASAN_STACK_ENABLE
 static bool __must_check tokenize_frame_descr(const char **frame_descr,
 					      char *token, size_t max_tok_len,
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 6ddb55676a7c..4060d0503462 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -85,6 +85,11 @@ void *find_first_bad_addr(void *addr, size_t size)
 	return p;
 }
 
+void metadata_fetch_row(char *buffer, void *row)
+{
+	memcpy(buffer, kasan_mem_to_shadow(row), META_BYTES_PER_ROW);
+}
+
 void print_tags(u8 addr_tag, const void *addr)
 {
 	u8 *shadow = (u8 *)kasan_mem_to_shadow(addr);
-- 
2.28.0.618.gf4bc123cb7-goog

