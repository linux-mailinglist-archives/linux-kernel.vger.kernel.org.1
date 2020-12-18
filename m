Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C052DE0E9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 11:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389074AbgLRKXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 05:23:10 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44262 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733163AbgLRKXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 05:23:10 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BIAJulT050545;
        Fri, 18 Dec 2020 10:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=yZVSy6EAEkuFTl3w094FI33pOcFr9o89On5Z47ID5tI=;
 b=FB8bov3xvzptM61+kZ4s5lYukNeGaugdn2PMrCNCuwUAi56DzeABMbp4kkPICHulFjCD
 /Xt+cm4WYgTxet6F/Pqa8l6hB8u9vedqCu2UgD6rSnh4r1JqR4S7ayb2yshEdajktRKB
 9dwdP6qZddyzJx/V7u5Js7UY9DXSg8ZVT6lPR/X7+8W8Ri5KH9/gBrT17hQlcpQzzctM
 e6EHSqv3n+GiLdDub+o8PZTUU+bkSC6mt1zJokPDIIIDUgraoghHROwCn8K6rGjfie0I
 HL7zoy0mYCq93Ue/MSCd9Y+2OJ+Tu8VffC7jNJ/WEeZ4b0OYrWtAQt4oPbPRGoNHqdpz Gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 35ckcbsv92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Dec 2020 10:22:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BIAFMns186416;
        Fri, 18 Dec 2020 10:22:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 35e6eujq18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Dec 2020 10:22:26 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BIAMP4P021858;
        Fri, 18 Dec 2020 10:22:25 GMT
Received: from jian-L460.jp.oracle.com (/10.191.3.55)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Dec 2020 02:22:24 -0800
From:   Jacob Wen <jian.w.wen@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, jian.w.wen@oracle.com
Subject: [PATCH] mm/vmscan: DRY cleanup for do_try_to_free_pages()
Date:   Fri, 18 Dec 2020 18:22:17 +0800
Message-Id: <20201218102217.186836-1-jian.w.wen@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=35 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=6 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012180075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reduces repetition of set_task_reclaim_state() around
do_try_to_free_pages().

Signed-off-by: Jacob Wen <jian.w.wen@oracle.com>
---
 mm/vmscan.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 257cba79a96d..4bc244b23686 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3023,6 +3023,10 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 	pg_data_t *last_pgdat;
 	struct zoneref *z;
 	struct zone *zone;
+	unsigned long ret;
+
+	set_task_reclaim_state(current, &sc->reclaim_state);
+
 retry:
 	delayacct_freepages_start();
 
@@ -3069,12 +3073,16 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 
 	delayacct_freepages_end();
 
-	if (sc->nr_reclaimed)
-		return sc->nr_reclaimed;
+	if (sc->nr_reclaimed) {
+		ret = sc->nr_reclaimed;
+		goto out;
+	}
 
 	/* Aborted reclaim to try compaction? don't OOM, then */
-	if (sc->compaction_ready)
-		return 1;
+	if (sc->compaction_ready) {
+		ret = 1;
+		goto out;
+	}
 
 	/*
 	 * We make inactive:active ratio decisions based on the node's
@@ -3101,7 +3109,10 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 		goto retry;
 	}
 
-	return 0;
+	ret = 0;
+out:
+	set_task_reclaim_state(current, NULL);
+	return ret;
 }
 
 static bool allow_direct_reclaim(pg_data_t *pgdat)
@@ -3269,13 +3280,11 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 	if (throttle_direct_reclaim(sc.gfp_mask, zonelist, nodemask))
 		return 1;
 
-	set_task_reclaim_state(current, &sc.reclaim_state);
 	trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
 
 	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
 
 	trace_mm_vmscan_direct_reclaim_end(nr_reclaimed);
-	set_task_reclaim_state(current, NULL);
 
 	return nr_reclaimed;
 }
@@ -3347,7 +3356,6 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 	 */
 	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
 
-	set_task_reclaim_state(current, &sc.reclaim_state);
 	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
 	noreclaim_flag = memalloc_noreclaim_save();
 
@@ -3355,7 +3363,6 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
-	set_task_reclaim_state(current, NULL);
 
 	return nr_reclaimed;
 }
@@ -4023,11 +4030,9 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 
 	fs_reclaim_acquire(sc.gfp_mask);
 	noreclaim_flag = memalloc_noreclaim_save();
-	set_task_reclaim_state(current, &sc.reclaim_state);
 
 	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
 
-	set_task_reclaim_state(current, NULL);
 	memalloc_noreclaim_restore(noreclaim_flag);
 	fs_reclaim_release(sc.gfp_mask);
 
-- 
2.25.1

