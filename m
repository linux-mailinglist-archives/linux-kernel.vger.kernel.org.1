Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B942CB559
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 07:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbgLBGxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 01:53:38 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:60592 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728709AbgLBGxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 01:53:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UHI83jK_1606891975;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UHI83jK_1606891975)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Dec 2020 14:52:56 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/vmalloc: Remove unnecessary return statement
Date:   Wed,  2 Dec 2020 14:52:42 +0800
Message-Id: <ca23f89259c80c3562700ae6e227b2815a195853.1606891153.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary return statement for void function.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/vmalloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6ae491a..c290fc9 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2275,7 +2275,6 @@ static void __vunmap(const void *addr, int deallocate_pages)
 	}
 
 	kfree(area);
-	return;
 }
 
 static inline void __vfree_deferred(const void *addr)
-- 
1.8.3.1

