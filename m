Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4FC2E7851
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 12:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgL3L7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 06:59:19 -0500
Received: from m12-18.163.com ([220.181.12.18]:52326 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbgL3L7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 06:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=BVkYW
        nerAgEAUJ+R498wrhw6J78zN7/yUiGX3c4XnIU=; b=UErKyZ3PHxYhIjY9642y0
        eLXIoInRFI64kRzlWBnEHNKE+ZGvvQ1S0DtvOW+Dgibswv4q+7ijTwjrxHY+r4lr
        rSpnEz9CSB219xQ3K8y8anUkfIdpi81Zsl+vFedOv8gmVMUv+PuSCueArt7Bdmfe
        6ORaRVR6Lg3dc50YR9hmvc=
Received: from localhost (unknown [101.86.213.121])
        by smtp14 (Coremail) with SMTP id EsCowADnzRIeZ+xfAGxCMg--.51347S2;
        Wed, 30 Dec 2020 19:40:15 +0800 (CST)
Date:   Wed, 30 Dec 2020 19:40:14 +0800
From:   Hui Su <sh_def@163.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm/page_alloc: remove the static for local variable
 node_order
Message-ID: <20201230114014.GA1934427@ubuntu-A520I-AC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EsCowADnzRIeZ+xfAGxCMg--.51347S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrJw4DXFWUAr4kZw1fAr43Wrg_yoWxXwcEvF
        1xJrsrCrWYy3409w4UA3WxX34fKw18CF4kKw1ak3Waya4UJr4Ivr4kG3ZxJFWDZ3y3Ary3
        GasrXrWDKw129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0Hlk7UUUUU==
X-Originating-IP: [101.86.213.121]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbBDh8LX1rbLxzTawAAsP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

local variable node_order do not need the static here.

Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bdbec4c98173..45e049ccf117 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5864,7 +5864,7 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
 
 static void build_zonelists(pg_data_t *pgdat)
 {
-	static int node_order[MAX_NUMNODES];
+	int node_order[MAX_NUMNODES];
 	int node, load, nr_nodes = 0;
 	nodemask_t used_mask = NODE_MASK_NONE;
 	int local_node, prev_node;
-- 
2.25.1


