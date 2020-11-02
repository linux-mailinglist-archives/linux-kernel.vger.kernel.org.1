Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB682A2D1E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKBOko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:40:44 -0500
Received: from z5.mailgun.us ([104.130.96.5]:16070 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgKBOkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:40:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604328042; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=snwxvlRE7nLYTeaBPML9K64AgFTva8Hm58yvYVS5uW4=; b=E3GPoW3BKG3l2C9xNzXU14SrpLAee0/nzMc6S8Egj6hSoILpV7t21afhkNoZwCrmqEjRvDCK
 CdmB2U3PrewRmSYaAPrlDqWm71Mrr0bLZ485jCC2D6ffW+4YuvCV+rYH/HC4z+30deVWcEq7
 7k8LQxSTlei8lsa5jW40WoFehlQ=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fa01a560ce128468b530106 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 02 Nov 2020 14:40:22
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 49CE9C43382; Mon,  2 Nov 2020 14:40:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from cgoldswo-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2714EC433C6;
        Mon,  2 Nov 2020 14:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2714EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cgoldswo@codeaurora.org
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: [PATCH 2/2] zram: allow zram to allocate CMA pages
Date:   Mon,  2 Nov 2020 06:39:22 -0800
Message-Id: <4c77bb100706b714213ff840d827a48e40ac9177.1604282969.git.cgoldswo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1604282969.git.cgoldswo@codeaurora.org>
References: <cover.1604282969.git.cgoldswo@codeaurora.org>
In-Reply-To: <cover.1604282969.git.cgoldswo@codeaurora.org>
References: <cover.1604282969.git.cgoldswo@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinayak Menon <vinmenon@codeaurora.org>

Though zram pages are movable, they aren't allowed to enter
MIGRATE_CMA pageblocks. zram is not seen to pin pages for
long which can cause an issue. Moreover allowing zram to
pick CMA pages can be helpful in cases seen where zram order
0 alloc fails when there are lots of free cma pages, resulting
in kswapd or direct reclaim not making enough progress.

Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
---
 drivers/block/zram/zram_drv.c | 5 +++--
 mm/zsmalloc.c                 | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9a1e6ee..4b6b16d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1380,13 +1380,14 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 				__GFP_KSWAPD_RECLAIM |
 				__GFP_NOWARN |
 				__GFP_HIGHMEM |
-				__GFP_MOVABLE);
+				__GFP_MOVABLE |
+				__GFP_CMA);
 	if (!handle) {
 		zcomp_stream_put(zram->comp);
 		atomic64_inc(&zram->stats.writestall);
 		handle = zs_malloc(zram->mem_pool, comp_len,
 				GFP_NOIO | __GFP_HIGHMEM |
-				__GFP_MOVABLE);
+				__GFP_MOVABLE | __GFP_CMA);
 		if (handle)
 			goto compress_again;
 		return -ENOMEM;
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index b03bee2..16ba318 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -351,7 +351,7 @@ static void destroy_cache(struct zs_pool *pool)
 static unsigned long cache_alloc_handle(struct zs_pool *pool, gfp_t gfp)
 {
 	return (unsigned long)kmem_cache_alloc(pool->handle_cachep,
-			gfp & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
+			gfp & ~(__GFP_HIGHMEM|__GFP_MOVABLE|__GFP_CMA));
 }
 
 static void cache_free_handle(struct zs_pool *pool, unsigned long handle)
@@ -362,7 +362,7 @@ static void cache_free_handle(struct zs_pool *pool, unsigned long handle)
 static struct zspage *cache_alloc_zspage(struct zs_pool *pool, gfp_t flags)
 {
 	return kmem_cache_alloc(pool->zspage_cachep,
-			flags & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
+			flags & ~(__GFP_HIGHMEM|__GFP_MOVABLE|__GFP_CMA));
 }
 
 static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

