Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015BD204E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 11:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbgFWJnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 05:43:06 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:39016 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731947AbgFWJnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:43:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U0Uz0A9_1592905379;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0Uz0A9_1592905379)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jun 2020 17:42:59 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH] mm/spase: never partially remove memmap for early section
Date:   Tue, 23 Jun 2020 17:42:58 +0800
Message-Id: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For early sections, we assumes its memmap will never be partially
removed. But current behavior breaks this.

Let's correct it.

Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/sparse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index b2b9a3e34696..1a0069f492f5 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -825,10 +825,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
 	}
 
-	if (section_is_early && memmap)
-		free_map_bootmem(memmap);
-	else
+	if (!section_is_early)
 		depopulate_section_memmap(pfn, nr_pages, altmap);
+	else if (memmap)
+		free_map_bootmem(memmap);
 
 	if (empty)
 		ms->section_mem_map = (unsigned long)NULL;
-- 
2.20.1 (Apple Git-117)

