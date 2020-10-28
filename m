Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CE229D900
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388989AbgJ1Wlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:41:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6704 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731064AbgJ1Wi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:38:58 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CLg3K54KCzkbVc;
        Wed, 28 Oct 2020 15:21:01 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 15:20:50 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] mm, page_alloc: Fix old-style function definition
Date:   Wed, 28 Oct 2020 15:32:48 +0800
Message-ID: <1603870368-104763-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning:

mm/page_alloc.c:763:6: warning: old-style function definition [-Wold-style-definition]
 void init_mem_debugging()
      ^~~~~~~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f80dc59..470b18d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -760,7 +760,7 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
  * order of appearance. So we need to first gather the full picture of what was
  * enabled, and then make decisions.
  */
-void init_mem_debugging()
+void init_mem_debugging(void)
 {
 	if (_init_on_alloc_enabled_early) {
 		if (page_poisoning_enabled()) {
-- 
2.6.2

