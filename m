Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC77226A391
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgIOKsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:48:15 -0400
Received: from mail5.windriver.com ([192.103.53.11]:58096 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgIOKrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:47:36 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 08FAkQvb029270
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 15 Sep 2020 03:46:47 -0700
Received: from pek-lpggp1.wrs.com (128.224.153.74) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 03:46:21 -0700
From:   <yanfei.xu@windriver.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/page_alloc.c: variable type of 'progress' should be 'unsigned long'
Date:   Tue, 15 Sep 2020 18:46:20 +0800
Message-ID: <20200915104620.20582-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

try_to_free_pages returns the number of pages reclaimed, and the type of
returns is 'unsigned long'. So we should use a matched type for storing
it.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fab5e97dc9ca..5f1016c70b94 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4245,9 +4245,8 @@ static int
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

