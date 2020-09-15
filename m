Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB6926A04F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgIOIAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 04:00:10 -0400
Received: from mail1.windriver.com ([147.11.146.13]:41793 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgIOH5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:57:15 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 08F7uiJU022562
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 15 Sep 2020 00:56:44 -0700 (PDT)
Received: from pek-lpggp1.wrs.com (128.224.153.74) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 00:56:36 -0700
From:   <yanfei.xu@windriver.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/page_alloc.c: avoid inheritting current's flags when invoked in interrupt
Date:   Tue, 15 Sep 2020 15:56:35 +0800
Message-ID: <20200915075635.1112-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

alloc_mask shouldn't inherit the current task's flags when
__alloc_pages_nodemask is invoked in interrupt.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fab5e97dc9ca..388b587b35a8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4889,7 +4889,8 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	 * from a particular context which has been marked by
 	 * memalloc_no{fs,io}_{save,restore}.
 	 */
-	alloc_mask = current_gfp_context(gfp_mask);
+	if (!in_interrupt())
+		alloc_mask = current_gfp_context(gfp_mask);
 	ac.spread_dirty_pages = false;
 
 	/*
-- 
2.18.2

