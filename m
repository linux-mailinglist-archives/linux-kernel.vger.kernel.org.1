Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725A02B1CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgKMOLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:11:11 -0500
Received: from m12-11.163.com ([220.181.12.11]:56351 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgKMOLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=BPvet
        3Bokc0CBtDtXhqknCUn3oJg8vZczH3XlVV+zN8=; b=TrwUQ6hzN1xsUAbWBf6Kj
        dwmNw/ro1i7kxnvtlTDzpid+RETNrODJZhjsFXREfYah5fzjZ8eMw5rB1EnF4s9K
        FzeUQIOUQEIy/llma5zJjQ6eHbaWgCncRi/6GIY8f6bQCtDqtNSnULp735w81zF3
        RftE1X2X/sn899oikWGa1o=
Received: from localhost (unknown [101.86.208.122])
        by smtp7 (Coremail) with SMTP id C8CowAAXm3Dok65fL9JXBg--.38573S2;
        Fri, 13 Nov 2020 22:10:48 +0800 (CST)
Date:   Fri, 13 Nov 2020 22:10:48 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     sh_def@163.com
Subject: [PATCH] mm/page_counter: use page_counter_read in
 page_counter_set_max
Message-ID: <20201113141048.GA178922@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: C8CowAAXm3Dok65fL9JXBg--.38573S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw1xAr1xCrWfZFWfZFWxCrg_yoW3twc_Aw
        1kXF1DJrsIga47Ar1Ut3W3Xrn5t3s29rWkXryxtFyYy3WYqrySqF18AF13Jr4DJr4rXrs8
        Gw1Fva4xur9xtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU1xRDUUUUU==
X-Originating-IP: [101.86.208.122]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiIAnbX10TCJdzZwAAso
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use page_counter_read() in page_counter_set_max().

Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/page_counter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_counter.c b/mm/page_counter.c
index b24a60b28bb0..c6860f51b6c6 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -183,14 +183,14 @@ int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages)
 		 * the limit, so if it sees the old limit, we see the
 		 * modified counter and retry.
 		 */
-		usage = atomic_long_read(&counter->usage);
+		usage = page_counter_read(counter);
 
 		if (usage > nr_pages)
 			return -EBUSY;
 
 		old = xchg(&counter->max, nr_pages);
 
-		if (atomic_long_read(&counter->usage) <= usage)
+		if (page_counter_read(counter) <= usage)
 			return 0;
 
 		counter->max = old;
-- 
2.29.0


