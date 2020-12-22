Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352262E0EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 20:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgLVTQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 14:16:37 -0500
Received: from m12-12.163.com ([220.181.12.12]:48995 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbgLVTQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 14:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=580Ow
        Nj9VQTuck9gYalATYntiA58Tf9ffgntFB1gstw=; b=HOE4TajeV3EHosIXZ8/UX
        gTvu3dQ6R3ZWF8I3IjuFWlf8CTrtAqiCZhP7HsFltCK7I3GnFA7TO+k3wraWF0V1
        a8ZaSKgJJ6jFqCUv14XqZG3hJ/bwHr3vhaPm4kef4eDxmeAg+Qel0cNIw0ryB7tD
        nwj2nVLKyDB9xjkywJJxJo=
Received: from localhost (unknown [101.86.213.121])
        by smtp8 (Coremail) with SMTP id DMCowADHMNyXOuJfSqqNIQ--.57720S2;
        Wed, 23 Dec 2020 02:27:35 +0800 (CST)
Date:   Wed, 23 Dec 2020 02:27:35 +0800
From:   sh <sh_def@163.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     sh_def@163.com
Subject: [PATCH] mm/page_reporting: use list_entry_is_head() in
 page_reporting_cycle()
Message-ID: <20201222182735.GA1257912@ubuntu-A520I-AC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DMCowADHMNyXOuJfSqqNIQ--.57720S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWfJw1fXF1kWr1xuw45Jrb_yoW3Arc_u3
        yI93WkWrnxtrs29r1UA3WfKFnxJw4UCr4fJr4xtF1rtryUGrs8WFZ5AwnI9rW3WrW3u343
        uw1DXFy7ur17XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbFAp7UUUUU==
X-Originating-IP: [101.86.213.121]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbBDhgDX1rbLou8CQAAsb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace '&next->lru != list' with list_entry_is_head().
No functional change.

Signed-off-by: sh <sh_def@163.com>
---
 mm/page_reporting.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index cd8e13d41df4..c50d93ffa252 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -211,7 +211,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 	}
 
 	/* Rotate any leftover pages to the head of the freelist */
-	if (&next->lru != list && !list_is_first(&next->lru, list))
+	if (!list_entry_is_head(next, list, lru) && !list_is_first(&next->lru, list))
 		list_rotate_to_front(&next->lru, list);
 
 	spin_unlock_irq(&zone->lock);
-- 
2.25.1


