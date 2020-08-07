Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763B023E9A4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 10:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgHGI7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 04:59:02 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:46971 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbgHGI7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:59:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U5.BvXs_1596790736;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U5.BvXs_1596790736)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Aug 2020 16:58:56 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [RESEND Patch 2/2] bitops: use the same mechanism for get_count_order[_long]
Date:   Fri,  7 Aug 2020 16:58:37 +0800
Message-Id: <20200807085837.11697-3-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200807085837.11697-1-richard.weiyang@linux.alibaba.com>
References: <20200807085837.11697-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two functions share the same logic.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 include/linux/bitops.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 030a98f0c452..5b74bdf159d6 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -188,12 +188,10 @@ static inline unsigned fls_long(unsigned long l)
 
 static inline int get_count_order(unsigned int count)
 {
-	int order;
+	if (count == 0)
+		return -1;
 
-	order = fls(count) - 1;
-	if (count & (count - 1))
-		order++;
-	return order;
+	return fls(--count);
 }
 
 /**
-- 
2.20.1 (Apple Git-117)

