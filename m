Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4672F5B12
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbhANHJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbhANHJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:09:06 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA012C061575;
        Wed, 13 Jan 2021 23:08:25 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 30so3155081pgr.6;
        Wed, 13 Jan 2021 23:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=S9qA10US8vCCyMBqu6NxHUPr7KRXGMvBnqk5YeBK5uU=;
        b=S2i9xG0O5qTsxksVhtuBm9dz9WBe1wbZF91O8ZA5i4u3PK+iSjkg8QdiaR4xUo5vCU
         y7R+uZlw/cF9RkMVAQNHZ+JTP4wzsklKrpaCLGD9tXYRYfPn4DpZahcOmOK8Dir1Lh63
         Adum+a4NlBCexoCl0EJ46aVRPGOOcyQnd7R5WrLivr+oCIP7mPhbFhAulMwG/MK3d0T1
         YzCK5b9/PRCA+/8sZjNLEgmW7gAW2v3G2nIHcsFU0VDIJBD4JNMyCGl4EYA8Dp/UlYoI
         6BmI8sUR6V0mBZAdwCY5co32fcLgAcxwA1Wfe5csfzM5WQrdUhvF5Bk1SCDlcExGhYeE
         wYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=S9qA10US8vCCyMBqu6NxHUPr7KRXGMvBnqk5YeBK5uU=;
        b=BElCHnG8byuZApCaWnM0pDMokGy5y3JCFxK0Z35N6okHdMFJyAxZjoaLkpX3VSg8g9
         fbnjecOF4IXimg1DqY0imk0fegpDF3OUbJ1hASrYEotselDzwxTCbOy/gT6woCxX3wCi
         KSgZN6EGc24dSJnSAH+8QjNJphrzT93Dnc31voOUlnIG4eGMOB4WZ2153GRlDEeucGGJ
         Jk92ef97Jou5JUaLumLP3kNPnTlf1psnsjZCvegCWj8F/xH6zXmtRLGYGWH9t3hZBUD2
         1DVrkoiJevj02qhLrRtC5IYAfs1Q930yl/DveiglPrDmWtESTQSuk84bvUCTlVz3paaD
         SF+w==
X-Gm-Message-State: AOAM530lIIo6VJGfLRCJllnTIYpoNRtdYvQgsRipzmzNcsvPbQivcPM1
        rb6vL8xpCaJQ96R4jb2Q5wJzT4VaVeg=
X-Google-Smtp-Source: ABdhPJwxDHyY9npG8eI2PkJ4ofN3B0BPll4vjsU5rS46O4tX4xQS9OMKqpS+PcAOnEe5ffQ471PwCA==
X-Received: by 2002:a65:68cb:: with SMTP id k11mr6098855pgt.271.1610608105465;
        Wed, 13 Jan 2021 23:08:25 -0800 (PST)
Received: from AD01715016 ([211.249.70.61])
        by smtp.gmail.com with ESMTPSA id t8sm224291pjm.45.2021.01.13.23.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 23:08:24 -0800 (PST)
Date:   Thu, 14 Jan 2021 16:08:17 +0900
From:   Daeseok Youn <daeseok.youn@gmail.com>
To:     rppt@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mm: memblock: remove return value of memblock_free_all()
Message-ID: <20210114070817.GA2868715@AD01715016>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one checks the return value of memblock_free_all().
Make the return value void.

memblock_free_all() is used on mem_init() for each
architecture, and the total count of freed pages will be added
to _totalram_pages variable by calling totalram_pages_add().

so do not need to return total count of freed pages.

Signed-off-by: Daeseok Youn <daeseok.youn@gmail.com>
---
 include/linux/memblock.h | 2 +-
 mm/memblock.c            | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 9c5cc95c7cee..076fda398dff 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -117,7 +117,7 @@ int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
 
-unsigned long memblock_free_all(void);
+void memblock_free_all(void);
 void reset_node_managed_pages(pg_data_t *pgdat);
 void reset_all_zones_managed_pages(void);
 void memblock_enforce_memory_reserved_overlap(void);
diff --git a/mm/memblock.c b/mm/memblock.c
index 40ca30bfa387..2a2b1fe4b659 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2074,10 +2074,8 @@ void __init reset_all_zones_managed_pages(void)
 
 /**
  * memblock_free_all - release free pages to the buddy allocator
- *
- * Return: the number of pages actually released.
  */
-unsigned long __init memblock_free_all(void)
+void __init memblock_free_all(void)
 {
 	unsigned long pages;
 
@@ -2086,8 +2084,6 @@ unsigned long __init memblock_free_all(void)
 
 	pages = free_low_memory_core_early();
 	totalram_pages_add(pages);
-
-	return pages;
 }
 
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
-- 
2.25.1

