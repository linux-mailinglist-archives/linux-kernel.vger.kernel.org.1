Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEBF233D32
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 04:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbgGaC2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 22:28:31 -0400
Received: from mail1.windriver.com ([147.11.146.13]:57481 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730768AbgGaC2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:28:31 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 06V2SBVI005111
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 30 Jul 2020 19:28:12 -0700 (PDT)
Received: from pek-lpg-core1-vm1.wrs.com (128.224.156.106) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Jul 2020 19:27:52 -0700
From:   <qiang.zhang@windriver.com>
To:     <willy@infradead.org>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/dmapool.c: add WARN_ON() in dma_pool_destroy
Date:   Fri, 31 Jul 2020 10:39:39 +0800
Message-ID: <20200731023939.19206-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qiang <qiang.zhang@windriver.com>

The pool is being destroyed, all page which in the pool,
should be free. if some page is still be use by somebody,
we should not just output error logs, also should also add
a warning message.

Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
---
 mm/dmapool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index f9fb9bbd733e..8f4dc53dde5b 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -285,7 +285,7 @@ void dma_pool_destroy(struct dma_pool *pool)
 		struct dma_page *page;
 		page = list_entry(pool->page_list.next,
 				  struct dma_page, page_list);
-		if (is_page_busy(page)) {
+		if (WARN_ON(is_page_busy(page))) {
 			if (pool->dev)
 				dev_err(pool->dev,
 					"dma_pool_destroy %s, %p busy\n",
-- 
2.26.2

