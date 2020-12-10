Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35B72D61FC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392332AbgLJQcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbgLJQEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:04:41 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C55C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:04:01 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so5854658wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hh8PxAhln6PiY96SsIvH4Jb4HnhnMqeMZCUSPG8j+s0=;
        b=DLZ928rqaeb/lsTz6CetglcHdGdiZkSKcNbL+S0gXsaCg1O7UdHDnhC/o64G2rrVYd
         K3heFF0KQl/eEspEWJJvlkIdqSFxbIeRzDTpk9PVoMOR24vo0uTw58xd71nL3srbmzv1
         8TJOoxrvfbWu0J8wZGvX2E/JiRZTdgLa+jhq71FCJoDLykcycr246iElt6AiPtk6yLZ2
         5KPwJ90ogvnpan9yngc2YYi6VIr1+OESuqABEZeVIXtiUU3fLkqGq1dbTmGC/B2cUD7x
         s+YfUc5Kt1KAut4BzM/AVJJdR8UXi7j2vuXku9o2jBm5c+GCdiKuMfzfKqk+s5XeNRUh
         C27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hh8PxAhln6PiY96SsIvH4Jb4HnhnMqeMZCUSPG8j+s0=;
        b=HBW+v2a/Nt9LwoY1cay9aCx9TLHEMtfYbCcwUpKvH9tFT0MIHxbW89XgoNvhEgDWIt
         wzAYAGhSZLW+5LAjbWD0228O7RR7hKb4V6q+16rDfTnvK06UEJ8UuxVdBcJOPiNUSnQT
         iyPuZrO6qG9kjqtDor9G4ZXiFolrouc2OYwGDCIYS0YA2QMGy4MjzpIIGwzWArnxz8c4
         L1pyozwsOcOJGmnxDxJ5q5fGzoflhh4ZF00AwL4Ca3j/zbT1tFCPukFJAvgfUjyBzApa
         8h3evdCF0BJEanq9lVhEPKjOMCQH8Q1QQuD9+IVy7bWTtJk5Cn3LCVS6dmRwWoiRndwF
         E8Cw==
X-Gm-Message-State: AOAM531z5u87/2sbEX+D4I4EmWGZK0JGIJAaS/jrcNoNsUNUjG4R3oQK
        IDEDcQVey0Vz6noW7qzaL+f1GSexLgKt/g==
X-Google-Smtp-Source: ABdhPJwlL+iccy5h+6abVXgzPBfF873S9rja/ooxjbuBYTgwfozKKRBiUTpSGG43GvEvWnRDaZvTIw==
X-Received: by 2002:a1c:e10b:: with SMTP id y11mr9199667wmg.65.1607616239854;
        Thu, 10 Dec 2020 08:03:59 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id d17sm9274768wro.62.2020.12.10.08.03.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 08:03:59 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, vbabka@suse.cz, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lmark@codeaurora.org, georgi.djakov@linaro.org
Subject: [PATCH v3] mm/page_owner: Record timestamp and pid
Date:   Thu, 10 Dec 2020 18:03:57 +0200
Message-Id: <20201210160357.27779-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Mark <lmark@codeaurora.org>

Collect the time for each allocation recorded in page owner so that
allocation "surges" can be measured.

Record the pid for each allocation recorded in page owner so that the
source of allocation "surges" can be better identified.

The above is very useful when doing memory analysis.  On a crash for
example, we can get this information from kdump (or ramdump) and parse it
to figure out memory allocation problems.

Please note that on x86_64 this increases the size of struct page_owner
from 16 bytes to 32.

Vlastimil: it's not a functionality intended for production, so unless
somebody says they need to enable page_owner for debugging and this
increase prevents them from fitting into available memory, let's not
complicate things with making this optional.

Signed-off-by: Liam Mark <lmark@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>
---

v3:
- Fix the warnings in the documentation (reported in linux-next) and make
  Sphinx happy:
  Documentation/vm/page_owner.rst:44: WARNING: Literal block ends without a blank line; unexpected unindent.
  Documentation/vm/page_owner.rst:49: WARNING: Literal block ends without a blank line; unexpected unindent.

v2: https://lore.kernel.org/r/20201209125153.10533-1-georgi.djakov@linaro.org
- Improve the commit message (Andrew and Vlastimil)
- Update page_owner.rst with more recent object size information (Andrew)
- Use pid_t for the pid (Andrew)
- Print the info also in __dump_page_owner() (Vlastimil)

v1: https://lore.kernel.org/r/20201112184106.733-1-georgi.djakov@linaro.org

 Documentation/vm/page_owner.rst | 12 ++++++------
 mm/page_owner.c                 | 17 +++++++++++++----
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index 02deac76673f..4e67c2e9bbed 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -41,17 +41,17 @@ size change due to this facility.
 - Without page owner::
 
    text    data     bss     dec     hex filename
-   40662   1493     644   42799    a72f mm/page_alloc.o
+   48392   2333     644   51369    c8a9 mm/page_alloc.o
 
 - With page owner::
 
    text    data     bss     dec     hex filename
-   40892   1493     644   43029    a815 mm/page_alloc.o
-   1427      24       8    1459     5b3 mm/page_ext.o
-   2722      50       0    2772     ad4 mm/page_owner.o
+   48800   2445     644   51889    cab1 mm/page_alloc.o
+   6574     108      29    6711    1a37 mm/page_owner.o
+   1025       8       8    1041     411 mm/page_ext.o
 
-Although, roughly, 4 KB code is added in total, page_alloc.o increase by
-230 bytes and only half of it is in hotpath. Building the kernel with
+Although, roughly, 8 KB code is added in total, page_alloc.o increase by
+520 bytes and less than half of it is in hotpath. Building the kernel with
 page owner and turning it on if needed would be great option to debug
 kernel memory problem.
 
diff --git a/mm/page_owner.c b/mm/page_owner.c
index b735a8eafcdb..af464bb7fbe7 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -10,6 +10,7 @@
 #include <linux/migrate.h>
 #include <linux/stackdepot.h>
 #include <linux/seq_file.h>
+#include <linux/sched/clock.h>
 
 #include "internal.h"
 
@@ -25,6 +26,8 @@ struct page_owner {
 	gfp_t gfp_mask;
 	depot_stack_handle_t handle;
 	depot_stack_handle_t free_handle;
+	u64 ts_nsec;
+	pid_t pid;
 };
 
 static bool page_owner_enabled = false;
@@ -172,6 +175,8 @@ static inline void __set_page_owner_handle(struct page *page,
 		page_owner->order = order;
 		page_owner->gfp_mask = gfp_mask;
 		page_owner->last_migrate_reason = -1;
+		page_owner->pid = current->pid;
+		page_owner->ts_nsec = local_clock();
 		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
 		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
 
@@ -236,6 +241,8 @@ void __copy_page_owner(struct page *oldpage, struct page *newpage)
 	new_page_owner->last_migrate_reason =
 		old_page_owner->last_migrate_reason;
 	new_page_owner->handle = old_page_owner->handle;
+	new_page_owner->pid = old_page_owner->pid;
+	new_page_owner->ts_nsec = old_page_owner->ts_nsec;
 
 	/*
 	 * We don't clear the bit on the oldpage as it's going to be freed
@@ -349,9 +356,10 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		return -ENOMEM;
 
 	ret = snprintf(kbuf, count,
-			"Page allocated via order %u, mask %#x(%pGg)\n",
+			"Page allocated via order %u, mask %#x(%pGg), pid %d, ts %llu ns\n",
 			page_owner->order, page_owner->gfp_mask,
-			&page_owner->gfp_mask);
+			&page_owner->gfp_mask, page_owner->pid,
+			page_owner->ts_nsec);
 
 	if (ret >= count)
 		goto err;
@@ -427,8 +435,9 @@ void __dump_page_owner(struct page *page)
 	else
 		pr_alert("page_owner tracks the page as freed\n");
 
-	pr_alert("page last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg)\n",
-		 page_owner->order, migratetype_names[mt], gfp_mask, &gfp_mask);
+	pr_alert("page last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg), pid %d, ts %llu\n",
+		 page_owner->order, migratetype_names[mt], gfp_mask, &gfp_mask,
+		 page_owner->pid, page_owner->ts_nsec);
 
 	handle = READ_ONCE(page_owner->handle);
 	if (!handle) {
