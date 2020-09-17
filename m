Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F4E26E710
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 23:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIQVEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 17:04:30 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54823 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726344AbgIQVE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 17:04:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id DCDF95C0237;
        Thu, 17 Sep 2020 17:04:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 17 Sep 2020 17:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:reply-to:mime-version
        :content-transfer-encoding; s=fm1; bh=J6L2UYFGptZ2yYfZRWaSnPrub0
        tg5wrrKaCkeegrAac=; b=dMHDqaFagAGff2Q9pBg1lePQktQCbfUROCz+v88YB+
        ul/1BOxUV9GWjC1OoOKINXOc1mnANy5NU5QIP2Z7OoqpdhZrVvGhgScxNvvqCxrQ
        zKxxMdjrW8pVdtuzggnFAPlL72kyQgAiOU1Mr8eFtpIPcin0o7btYG1z/HXYNRO1
        Fnf/EzNVlezMkstYv2Gy42OzWssI/irxHEtrGYDlW0tZYM/snuFaoGT7j03ivxwS
        1acC9aiuEwVWjjJjoDQC8uem7WFgG7XcGJK1po6rvdBO420frjyNeiVbJf37fhQ1
        Tg86KHjHLgtk3ON0GZk6RqErH3wyo1kGwXCB3F5daxqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:reply-to:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=J6L2UY
        FGptZ2yYfZRWaSnPrub0tg5wrrKaCkeegrAac=; b=bBuLRM51BrDNvT9mbjV6ml
        rDKjEbkskrmCNJguxQbyJGSdoAu6iro8zCTHXnTpYypTDQF81wUo0TpqaatC7DOp
        zCbQyC7xWjSAiKSHDSCFv/dDZXfCcUxhju22pMo3RHqvIE3fcxABL/+Xsjbs+u+r
        3F8bjokQswMtIZdzN5UqBFqgYVchQrUXcpy85swpfDIygusR+i0HJhnpr0b8mEsh
        Z2MAhv0JtaMjBK32ay8hARwIvhNMRzaVnzihOkrfTq+iHUhlcX69KyeQjbOoZHY4
        Y38CnI4+qMEgAOISuak68lJMWfH15BLGz7kGM3v2UXy/oqKKJKocC5kqz5tR054g
        ==
X-ME-Sender: <xms:XM9jXzl3jkpF7didvNy6tGY4cS74k12wLM7SJmBI6UM2tnCT1lIhbA>
    <xme:XM9jX20VSFxtUJ_OANymoMRB3o1jlOVllhK3Iqv3GDGTtqBJzgl-c1RppeWRB13a9
    dnyJiC-T6ZBIwkGQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeggdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfforhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepgfellefhvd
    eitdehffejheelgfehtdevheejhffgledtieehtdejffefveeijeehnecukfhppeduvddr
    geeirddutdeirdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:XM9jX5plzUuF7W06D88KENfb4glSAxuRQGlp_wv6G5zptCwq7cTixQ>
    <xmx:XM9jX7kKmEoJz90Hq---EruI37pHLC11Ts-QE1Au0bVeXbqqZ1tdEA>
    <xmx:XM9jXx2LLulCicr6HYQ4kNea4uaYOuRGpVU6nBgXPDWxroCkuSdP2Q>
    <xmx:XM9jX6w1cbk8vo1oFFZfvi8t_vTfP_NUZxA88CNjHSQhtcYvCkdVnA>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 666AB3280065;
        Thu, 17 Sep 2020 17:04:28 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v2] mm/migrate: correct thp migration stats.
Date:   Thu, 17 Sep 2020 17:04:13 -0400
Message-Id: <20200917210413.1462975-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

PageTransHuge returns true for both thp and hugetlb, so thp stats was
counting both thp and hugetlb migrations. Exclude hugetlb migration by
setting is_thp variable right.

Clean up thp handling code too when we are there.

Fixes: 1a5bae25e3cf ("mm/vmstat: add events for THP migration without split")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/migrate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 941b89383cf3..6bc9559afc70 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1445,7 +1445,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			 * Capture required information that might get lost
 			 * during migration.
 			 */
-			is_thp = PageTransHuge(page);
+			is_thp = PageTransHuge(page) && !PageHuge(page);
 			nr_subpages = thp_nr_pages(page);
 			cond_resched();
 
@@ -1471,7 +1471,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 * we encounter them after the rest of the list
 				 * is processed.
 				 */
-				if (PageTransHuge(page) && !PageHuge(page)) {
+				if (is_thp) {
 					lock_page(page);
 					rc = split_huge_page_to_list(page, from);
 					unlock_page(page);
@@ -1480,8 +1480,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 						nr_thp_split++;
 						goto retry;
 					}
-				}
-				if (is_thp) {
+
 					nr_thp_failed++;
 					nr_failed += nr_subpages;
 					goto out;
-- 
2.28.0

