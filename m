Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FBD2B5BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgKQJZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:25:00 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:32950 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbgKQJY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:24:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UFh2-H3_1605605092;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFh2-H3_1605605092)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Nov 2020 17:24:53 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/vmalloc: add 'align' parameter explanation for pvm_determine_end_from_reverse
Date:   Tue, 17 Nov 2020 17:24:48 +0800
Message-Id: <1605605088-30668-3-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605605088-30668-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1605605088-30668-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel-doc markup has a issue on pvm_determine_end_from_reverse:
mm/vmalloc.c:3145: warning: Function parameter or member 'align' not
described in 'pvm_determine_end_from_reverse'
Add a explanation for it to remove the warning.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/vmalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7e903524e002..4cd7652ce626 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3137,6 +3137,7 @@ pvm_find_va_enclose_addr(unsigned long addr)
  * @va:
  *   in - the VA we start the search(reverse order);
  *   out - the VA with the highest aligned end address.
+ * @align: alignment for required highest address
  *
  * Returns: determined end address within vmap_area
  */
-- 
2.29.GIT

