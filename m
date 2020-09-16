Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF4726BA08
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgIPCXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:23:01 -0400
Received: from mail5.windriver.com ([192.103.53.11]:43174 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgIPCW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:22:58 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 08G2M38i027889
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 15 Sep 2020 19:22:13 -0700
Received: from pek-lpggp1.wrs.com (128.224.153.74) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 19:21:40 -0700
From:   <yanfei.xu@windriver.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mm/page_alloc.c: __perform_reclaim should return 'unsigned long'
Date:   Wed, 16 Sep 2020 10:21:38 +0800
Message-ID: <20200916022138.16740-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

__perform_reclaim()'s single caller expects it to return 'unsigned long',
hence change its return value and a local variable to 'unsigned long'.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/page_alloc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fab5e97dc9ca..9c985b0c316c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4241,13 +4241,12 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
 #endif
 
 /* Perform direct synchronous page reclaim */
-static int
+static unsigned long
 __perform_reclaim(gfp_t gfp_mask, unsigned int order,
 					const struct alloc_context *ac)
 {
-	int progress;
 	unsigned int noreclaim_flag;
-	unsigned long pflags;
+	unsigned long pflags, progress;
 
 	cond_resched();
 
-- 
2.18.2

