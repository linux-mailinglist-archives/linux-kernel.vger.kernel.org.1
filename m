Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F97A2F76C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbhAOKem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:34:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11544 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbhAOKem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:34:42 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DHHZ1296gzMKnV;
        Fri, 15 Jan 2021 18:32:41 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Fri, 15 Jan 2021
 18:33:55 +0800
From:   Chengyang Fan <cy.fan@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/migrate: Remove unneeded semicolons
Date:   Fri, 15 Jan 2021 19:01:31 +0800
Message-ID: <20210115110131.2359683-1-cy.fan@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove superfluous semicolons after function definitions.

Signed-off-by: Chengyang Fan <cy.fan@huawei.com>
---
 include/linux/migrate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 4594838a0f7c..3a389633b68f 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -89,7 +89,7 @@ extern int PageMovable(struct page *page);
 extern void __SetPageMovable(struct page *page, struct address_space *mapping);
 extern void __ClearPageMovable(struct page *page);
 #else
-static inline int PageMovable(struct page *page) { return 0; };
+static inline int PageMovable(struct page *page) { return 0; }
 static inline void __SetPageMovable(struct page *page,
 				struct address_space *mapping)
 {
-- 
2.25.1

