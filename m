Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A267D1D6038
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 12:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgEPKKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 06:10:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4853 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbgEPKKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 06:10:45 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 65FC387165E396FE2340;
        Sat, 16 May 2020 18:10:44 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Sat, 16 May 2020
 18:10:38 +0800
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] uprobe: switch to bitmap_zalloc() in __create_xol_area()
Message-ID: <41b31e6d-9af3-0c5e-0334-12508b869f13@huawei.com>
Date:   Sat, 16 May 2020 18:10:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to bitmap_zalloc() to show clearly in __create_xol_area().

No functional change.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 kernel/events/uprobes.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ece7e13f6e4a..1d3dde9101b0 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1490,8 +1490,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	if (unlikely(!area))
 		goto out;

-	area->bitmap = kcalloc(BITS_TO_LONGS(UINSNS_PER_PAGE), sizeof(long),
-			       GFP_KERNEL);
+	area->bitmap = bitmap_zalloc(UINSNS_PER_PAGE, GFP_KERNEL);
 	if (!area->bitmap)
 		goto free_area;

@@ -1515,7 +1514,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)

 	__free_page(area->pages[0]);
  free_bitmap:
-	kfree(area->bitmap);
+	bitmap_free(area->bitmap);
  free_area:
 	kfree(area);
  out:
@@ -1556,7 +1555,7 @@ void uprobe_clear_state(struct mm_struct *mm)
 		return;

 	put_page(area->pages[0]);
-	kfree(area->bitmap);
+	bitmap_free(area->bitmap);
 	kfree(area);
 }

-- 
1.8.3.1

