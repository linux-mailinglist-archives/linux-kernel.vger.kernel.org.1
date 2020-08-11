Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4792414EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 04:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgHKCZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 22:25:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9363 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbgHKCZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:25:09 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3CB13EA7F5F601B280FC;
        Tue, 11 Aug 2020 10:24:57 +0800 (CST)
Received: from DESKTOP-A9S207P.china.huawei.com (10.174.179.61) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 11 Aug 2020 10:24:51 +0800
From:   <wuyun.wu@huawei.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
CC:     <hewenliang4@huawei.com>, <hushiyuan@huawei.com>,
        Abel Wu <wuyun.wu@huawei.com>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/slub: fix missing ALLOC_SLOWPATH stat when bulk alloc
Date:   Tue, 11 Aug 2020 10:24:24 +0800
Message-ID: <20200811022427.1363-1-wuyun.wu@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Wu <wuyun.wu@huawei.com>

The ALLOC_SLOWPATH statistics is missing in bulk allocation now.
Fix it by doing statistics in alloc slow path.

Signed-off-by: Abel Wu <wuyun.wu@huawei.com>
---
 mm/slub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index df93a5a0e9a4..5d89e4064f83 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2600,6 +2600,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	void *freelist;
 	struct page *page;
 
+	stat(s, ALLOC_SLOWPATH);
+
 	page = c->page;
 	if (!page) {
 		/*
@@ -2788,7 +2790,6 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	page = c->page;
 	if (unlikely(!object || !node_match(page, node))) {
 		object = __slab_alloc(s, gfpflags, node, addr, c);
-		stat(s, ALLOC_SLOWPATH);
 	} else {
 		void *next_object = get_freepointer_safe(s, object);
 
-- 
2.28.0.windows.1

