Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B45829261C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgJSKzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:55:38 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:11200 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgJSKzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:55:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603104937; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=5C7mAG/C8vIFQ9gazzzfkLKmMxkQW868fcv5Ij6tOxs=; b=DTD/2XN4I/I22EcSXtXttsrRmGItKsJej5fYoGO+XhKGk+sKPSnE5HbSeoHsNUMaO6aDY0s9
 P2SHpOJYTc2hMxtkbLzsNRTqMSpqdcq5zS4KCo25ccQ7mdjTaZIGYeH/Uhz5bXOA9aKKqME1
 2hXqYsgI0EsBoLhoHypaDbjyUs0=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f8d70a8aad2c3cd1cd036ca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 19 Oct 2020 10:55:36
 GMT
Sender: zhenhuah=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2485AC433C9; Mon, 19 Oct 2020 10:55:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from zhenhuah-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zhenhuah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7718BC433F1;
        Mon, 19 Oct 2020 10:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7718BC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=zhenhuah@codeaurora.org
From:   Zhenhua Huang <zhenhuah@codeaurora.org>
To:     akpm@linux-foundation.org
Cc:     Zhenhua Huang <zhenhuah@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz
Subject: [PATCH v2] mm: fix page_owner initializing issue for arm32
Date:   Mon, 19 Oct 2020 18:55:25 +0800
Message-Id: <1603104925-5888-1-git-send-email-zhenhuah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page owner of pages used by page owner itself used is missing on arm32 targets.
The reason is dummy_handle and failure_handle is not initialized correctly.
Buddy allocator is used to initialize these two handles. However, buddy
allocator is not ready when page owner calls it. This change fixed that by
initializing page owner after buddy initialization.

The working flow before and after this change are:
original logic:
1. allocated memory for page_ext(using memblock).
2. invoke the init callback of page_ext_ops like
page_owner(using buddy allocator).
3. initialize buddy.

after this change:
1. allocated memory for page_ext(using memblock).
2. initialize buddy.
3. invoke the init callback of page_ext_ops like
page_owner(using buddy allocator).

with the change, failure/dummy_handle can get its correct value and
page owner output for example has the one for page owner itself:
Page allocated via order 2, mask 0x6202c0(GFP_USER|__GFP_NOWARN), pid 1006, ts
67278156558 ns
PFN 543776 type Unmovable Block 531 type Unmovable Flags 0x0()
 init_page_owner+0x28/0x2f8
 invoke_init_callbacks_flatmem+0x24/0x34
 start_kernel+0x33c/0x5d8
   (null)

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Zhenhua Huang <zhenhuah@codeaurora.org>
---
 include/linux/page_ext.h |  8 ++++++++
 init/main.c              |  2 ++
 mm/page_ext.c            | 10 ++++++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index cfce186..aff81ba 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -44,8 +44,12 @@ static inline void page_ext_init_flatmem(void)
 {
 }
 extern void page_ext_init(void);
+static inline void page_ext_init_flatmem_late(void)
+{
+}
 #else
 extern void page_ext_init_flatmem(void);
+extern void page_ext_init_flatmem_late(void);
 static inline void page_ext_init(void)
 {
 }
@@ -76,6 +80,10 @@ static inline void page_ext_init(void)
 {
 }
 
+static inline void page_ext_init_flatmem_late(void)
+{
+}
+
 static inline void page_ext_init_flatmem(void)
 {
 }
diff --git a/init/main.c b/init/main.c
index 130376e..b34c475 100644
--- a/init/main.c
+++ b/init/main.c
@@ -818,6 +818,8 @@ static void __init mm_init(void)
 	init_debug_pagealloc();
 	report_meminit();
 	mem_init();
+	/* page_owner must be initialized after buddy is ready */
+	page_ext_init_flatmem_late();
 	kmem_cache_init();
 	kmemleak_init();
 	pgtable_init();
diff --git a/mm/page_ext.c b/mm/page_ext.c
index a3616f7..16b161f2 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -99,12 +99,19 @@ static void __init invoke_init_callbacks(void)
 	}
 }
 
+#ifndef CONFIG_SPARSEMEM
+void __init page_ext_init_flatmem_late(void)
+{
+	invoke_init_callbacks();
+}
+#endif
+
 static inline struct page_ext *get_entry(void *base, unsigned long index)
 {
 	return base + page_ext_size * index;
 }
 
-#if !defined(CONFIG_SPARSEMEM)
+#ifndef CONFIG_SPARSEMEM
 
 
 void __meminit pgdat_page_ext_init(struct pglist_data *pgdat)
@@ -177,7 +184,6 @@ void __init page_ext_init_flatmem(void)
 			goto fail;
 	}
 	pr_info("allocated %ld bytes of page_ext\n", total_usage);
-	invoke_init_callbacks();
 	return;
 
 fail:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

