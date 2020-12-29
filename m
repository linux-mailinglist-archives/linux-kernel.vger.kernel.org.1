Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B6D2E6D81
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 04:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgL2DMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 22:12:42 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:49531 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727745AbgL2DMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 22:12:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UK6RXMx_1609211518;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UK6RXMx_1609211518)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 29 Dec 2020 11:11:58 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rongwei.wang@linux.alibaba.com
Subject: [PATCH] mm: rectify a page bad reason
Date:   Tue, 29 Dec 2020 11:11:56 +0800
Message-Id: <20201229031156.3861-1-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

When I was doing some memory-related projects, it always reported error
"nonzero mapcount", but its judgment condition was that _mapcount was not equal
to -1, so I felt the original string was a bit inappropriate, so I tried to
update it.

Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7a2c89b..57d7f26 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1114,7 +1114,7 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 	const char *bad_reason = NULL;
 
 	if (unlikely(atomic_read(&page->_mapcount) != -1))
-		bad_reason = "nonzero mapcount";
+		bad_reason = "non-(-1) _mapcount";
 	if (unlikely(page->mapping != NULL))
 		bad_reason = "non-NULL mapping";
 	if (unlikely(page_ref_count(page) != 0))
-- 
1.8.3.1

