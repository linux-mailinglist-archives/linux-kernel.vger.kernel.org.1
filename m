Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A9A248346
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 12:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHRKoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 06:44:08 -0400
Received: from mail.windriver.com ([147.11.1.11]:47119 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgHRKoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:44:08 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 07IAhrxr008368
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 18 Aug 2020 03:43:54 -0700 (PDT)
Received: from pek-lpggp1.wrs.com (128.224.153.74) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.487.0; Tue, 18 Aug 2020
 03:43:40 -0700
From:   <yanfei.xu@windriver.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v2] mm/memory: Fix typo in __do_fault() comment
Date:   Tue, 18 Aug 2020 18:43:39 +0800
Message-ID: <20200818104339.5310-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

It's "pte_alloc_one", not "pte_alloc_pne". Let's fix that.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 v2: modify the commit message 

 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index c3a83f4ca851..9cc3d0dc816c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3446,7 +3446,7 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 	 *				unlock_page(A)
 	 * lock_page(B)
 	 *				lock_page(B)
-	 * pte_alloc_pne
+	 * pte_alloc_one
 	 *   shrink_page_list
 	 *     wait_on_page_writeback(A)
 	 *				SetPageWriteback(B)
-- 
2.18.2

