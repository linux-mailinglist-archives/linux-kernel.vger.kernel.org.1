Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1B52E8C69
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 14:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbhACN5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 08:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbhACN5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 08:57:13 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03496C061573
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 05:56:33 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id n10so17046156pgl.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 05:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OkmIEGZrUYxTikbU8Yd5Ez0Y/58b3wmDmzrHUQ/JMJM=;
        b=nGjvjcmdsFlkfDjdvxxYRqohrXCuqaKdYCNjBP1AJYFGuN8bT0krRV+4Nnzp+QG9RN
         iABSwavXnFmlBX2apMYrgTZORFtYaKMlKI6y/uz5KdMGKDxdf9Z29rHQYAiLDOOjEm+K
         G9zIyW0Fq9CkTvOltoikIB8nRZCo4DJVh9j3OL8VeDnm9GgS4b2P4GOXQ9wqA54oXuv4
         HA5lHIMg72vc7Wswx8uy9HG8RRAQrVywRjP02mc6fG7JgWj+QJh8y7erpzdN3HJCGvaf
         5MzI1FW8qzWfkNNCcjH4dTluJzs9wIipgT4mb6YbFQuHBjXD/o1wFLAGUGKqSUj5BsF6
         Ni5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OkmIEGZrUYxTikbU8Yd5Ez0Y/58b3wmDmzrHUQ/JMJM=;
        b=aEcCg1epKeLgrxtXHnFyC7xzP0eJkCvriO+7ikivclDQVtDcfADpLhGto3dHl5gryY
         8E8geDrZtqyrkI91gjtzjn75hYnacFjz/6EF+o/jH+wLZ/NhwytBrKAmTft50rl3+lNw
         PA/tsbgfA1u/j4uHRyFbzJlhPcM7ozmwbeRWmYw6isYJQ1NgEWFk7v4vyLCfv7T+0mB+
         zumsRQOWEixYLBat1bpv91acBEk/cO3ziBYsFBvCiBU+SNJH7gjlpTPQBxsnEA7QvVNw
         Ex85DQOLtv7vDk0zvMcXOiyZpYQRsJ8yIBtvjJg6d7o/44+yb8/ykpAlWEnyFaBTkm5m
         4jHA==
X-Gm-Message-State: AOAM5319tfZyGfLH+6nEF8IHQKHY4hJ1LKTZDv6T9jE+HAkH5lMXNoDq
        0Hd9mVhIlV+bJFEZix6Nj937ErAxuBs=
X-Google-Smtp-Source: ABdhPJxW8b/T9Mjgg0bCBSsDDs05greg1V5BdrxjsF8j/i2UplKH6ZyUEqMxWXlFrLFHRQKRV7Q91Q==
X-Received: by 2002:a62:ea17:0:b029:1ad:4788:7815 with SMTP id t23-20020a62ea170000b02901ad47887815mr55124711pfh.1.1609682191812;
        Sun, 03 Jan 2021 05:56:31 -0800 (PST)
Received: from localhost.localdomain (61-230-37-4.dynamic-ip.hinet.net. [61.230.37.4])
        by smtp.gmail.com with ESMTPSA id u12sm25928427pgi.91.2021.01.03.05.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 05:56:31 -0800 (PST)
From:   Lecopzer Chen <lecopzer@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Cc:     dan.j.williams@intel.com, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        Lecopzer Chen <lecopzer@gmail.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH] kasan: fix unaligned address is unhandled in kasan_remove_zero_shadow
Date:   Sun,  3 Jan 2021 21:56:21 +0800
Message-Id: <20210103135621.83129-1-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During testing kasan_populate_early_shadow and kasan_remove_zero_shadow,
if the shadow start and end address in kasan_remove_zero_shadow() is
not aligned to PMD_SIZE, the remain unaligned PTE won't be removed.

In the test case for kasan_remove_zero_shadow():
    shadow_start: 0xffffffb802000000, shadow end: 0xffffffbfbe000000
    3-level page table:
      PUD_SIZE: 0x40000000 PMD_SIZE: 0x200000 PAGE_SIZE: 4K
0xffffffbf80000000 ~ 0xffffffbfbdf80000 will not be removed because
in kasan_remove_pud_table(), kasan_pmd_table(*pud) is true but the
next address is 0xffffffbfbdf80000 which is not aligned to PUD_SIZE.

In the correct condition, this should fallback to the next level
kasan_remove_pmd_table() but the condition flow always continue to skip
the unaligned part.

Fix by correcting the condition when next and addr are neither aligned.

Fixes: 0207df4fa1a86 ("kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN")
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 mm/kasan/init.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index 67051cfae41c..ae9158f7501f 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -372,9 +372,10 @@ static void kasan_remove_pmd_table(pmd_t *pmd, unsigned long addr,
 
 		if (kasan_pte_table(*pmd)) {
 			if (IS_ALIGNED(addr, PMD_SIZE) &&
-			    IS_ALIGNED(next, PMD_SIZE))
+			    IS_ALIGNED(next, PMD_SIZE)) {
 				pmd_clear(pmd);
-			continue;
+				continue;
+			}
 		}
 		pte = pte_offset_kernel(pmd, addr);
 		kasan_remove_pte_table(pte, addr, next);
@@ -397,9 +398,10 @@ static void kasan_remove_pud_table(pud_t *pud, unsigned long addr,
 
 		if (kasan_pmd_table(*pud)) {
 			if (IS_ALIGNED(addr, PUD_SIZE) &&
-			    IS_ALIGNED(next, PUD_SIZE))
+			    IS_ALIGNED(next, PUD_SIZE)) {
 				pud_clear(pud);
-			continue;
+				continue;
+			}
 		}
 		pmd = pmd_offset(pud, addr);
 		pmd_base = pmd_offset(pud, 0);
@@ -423,9 +425,10 @@ static void kasan_remove_p4d_table(p4d_t *p4d, unsigned long addr,
 
 		if (kasan_pud_table(*p4d)) {
 			if (IS_ALIGNED(addr, P4D_SIZE) &&
-			    IS_ALIGNED(next, P4D_SIZE))
+			    IS_ALIGNED(next, P4D_SIZE)) {
 				p4d_clear(p4d);
-			continue;
+				continue;
+			}
 		}
 		pud = pud_offset(p4d, addr);
 		kasan_remove_pud_table(pud, addr, next);
@@ -456,9 +459,10 @@ void kasan_remove_zero_shadow(void *start, unsigned long size)
 
 		if (kasan_p4d_table(*pgd)) {
 			if (IS_ALIGNED(addr, PGDIR_SIZE) &&
-			    IS_ALIGNED(next, PGDIR_SIZE))
+			    IS_ALIGNED(next, PGDIR_SIZE)) {
 				pgd_clear(pgd);
-			continue;
+				continue;
+			}
 		}
 
 		p4d = p4d_offset(pgd, addr);
-- 
2.25.1

