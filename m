Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F762052BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 14:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732586AbgFWMmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 08:42:14 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:41205 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729504AbgFWMmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:42:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U0W2m8i_1592916130;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0W2m8i_1592916130)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jun 2020 20:42:11 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mgorman@suse.de, akpm@linux-foundation.org,
        richard.weiyang@linux.alibaba.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mm/page_alloc.c: replace the definition of NR_MIGRATETYPE_BITS with PB_migratetype_bits
Date:   Tue, 23 Jun 2020 20:41:58 +0800
Message-Id: <20200623124201.8199-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have the definition of PB_migratetype_bits and current
NR_MIGRATETYPE_BITS looks like a cyclic definition.

Just use PB_migratetype_bits is enough.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 include/linux/mmzone.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index df1f08486d81..eeb0da54ff5f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -88,8 +88,7 @@ static inline bool is_migrate_movable(int mt)
 
 extern int page_group_by_mobility_disabled;
 
-#define NR_MIGRATETYPE_BITS (PB_migrate_end - PB_migrate + 1)
-#define MIGRATETYPE_MASK ((1UL << NR_MIGRATETYPE_BITS) - 1)
+#define MIGRATETYPE_MASK ((1UL << PB_migratetype_bits) - 1)
 
 #define get_pageblock_migratetype(page)					\
 	get_pfnblock_flags_mask(page, page_to_pfn(page),		\
-- 
2.20.1 (Apple Git-117)

