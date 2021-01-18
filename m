Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD7D2F9F71
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391332AbhARMXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:23:23 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:37312 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391418AbhARMVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:21:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610972475; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=GyOs5boWHE5ZDS7w/1hvsdodxkJzzGORG4OD1eAwl/8=; b=JR99LdUuYhf73R15v3F/eQrnMIgap7pmDHf3c5vj1J7Oy6Z0wIBJIdFb1FcBrGeVcIIhETfG
 DIARhdQ5Nry1VOGpZc1hdNxP2MRUUBZzwxIVs0wAN6kXkSEwFwZA1U9Av8+MBEjLGe6JESyg
 RLiNUb6CLxG5T4LbRhTa/srxX2E=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 60057d1ffd7e724dd3aabd20 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Jan 2021 12:20:47
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A84A9C43465; Mon, 18 Jan 2021 12:20:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from charante-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98B17C433C6;
        Mon, 18 Jan 2021 12:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98B17C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        khalid.aziz@oracle.com, ngupta@nitingupta.dev,
        vinmenon@codeaurora.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH V2] mm/compaction: correct deferral logic for proactive compaction
Date:   Mon, 18 Jan 2021 17:50:08 +0530
Message-Id: <1610972408-20986-1-git-send-email-charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

should_proactive_compact_node() returns true when sum of the
weighted fragmentation score of all the zones in the node is greater
than the wmark_high of compaction, which then triggers the proactive
compaction that operates on the individual zones of the node. But
proactive compaction runs on the zone only when its weighted
fragmentation score is greater than wmark_low(=wmark_high - 10).

This means that the sum of the weighted fragmentation scores of all the
zones can exceed the wmark_high but individual weighted fragmentation
zone scores can still be less than wmark_low which makes the unnecessary
trigger of the proactive compaction only to return doing nothing.

Issue with the return of proactive compaction with out even trying is
its deferral. It is simply deferred for 1 << COMPACT_MAX_DEFER_SHIFT if
the scores across the proactive compaction is same, thinking that
compaction didn't make any progress but in reality it didn't even try.
With the delay between successive retries for proactive compaction is
500msec, it can result into the deferral for ~30sec with out even trying
the proactive compaction.

Test scenario is that: compaction_proactiveness=50 thus the wmark_low =
50 and wmark_high = 60. System have 2 zones(Normal and Movable) with
sizes 5GB and 6GB respectively. After opening some apps on the android,
the weighted fragmentation scores of these zones are 47 and 49
respectively. Since the sum of these fragmentation scores are above the
wmark_high which triggers the proactive compaction and there since the
individual zones weighted fragmentation scores are below wmark_low, it
returns without trying the proactive compaction. As a result the
weighted fragmentation scores of the zones are still 47 and 49 which
makes the existing logic to defer the compaction thinking that
noprogress is made across the compaction.

Fix this by checking just zone fragmentation score, not the weighted, in
__compact_finished() and use the zones weighted fragmentation score in
fragmentation_score_node(). In the test case above, If the weighted
average of is above wmark_high, then individual score (not adjusted) of
atleast one zone has to be above wmark_high. Thus it avoids the
unnecessary trigger and deferrals of the proactive compaction.

Fix-suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---

Changes in V2: Addressed comments from vlastimil

Changes in V1: https://lore.kernel.org/patchwork/patch/1364646/

 mm/compaction.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index e5acb97..1b98427 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1924,16 +1924,16 @@ static bool kswapd_is_running(pg_data_t *pgdat)
 }
 
 /*
- * A zone's fragmentation score is the external fragmentation wrt to the
- * COMPACTION_HPAGE_ORDER scaled by the zone's size. It returns a value
- * in the range [0, 100].
+ * A weighted zone's fragmentation score is the external fragmentation
+ * wrt to the COMPACTION_HPAGE_ORDER scaled by the zone's size. It
+ * returns a value in the range [0, 100].
  *
  * The scaling factor ensures that proactive compaction focuses on larger
  * zones like ZONE_NORMAL, rather than smaller, specialized zones like
  * ZONE_DMA32. For smaller zones, the score value remains close to zero,
  * and thus never exceeds the high threshold for proactive compaction.
  */
-static unsigned int fragmentation_score_zone(struct zone *zone)
+static unsigned int fragmentation_score_zone_weighted(struct zone *zone)
 {
 	unsigned long score;
 
@@ -1943,6 +1943,15 @@ static unsigned int fragmentation_score_zone(struct zone *zone)
 }
 
 /*
+ * A zone's fragmentation score is the external fragmentation wrt to the
+ * COMPACTION_HPAGE_ORDER. It returns a value in the range [0, 100].
+ */
+static unsigned int fragmentation_score_zone(struct zone *zone)
+{
+	return extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
+}
+
+/*
  * The per-node proactive (background) compaction process is started by its
  * corresponding kcompactd thread when the node's fragmentation score
  * exceeds the high threshold. The compaction process remains active till
@@ -1958,7 +1967,7 @@ static unsigned int fragmentation_score_node(pg_data_t *pgdat)
 		struct zone *zone;
 
 		zone = &pgdat->node_zones[zoneid];
-		score += fragmentation_score_zone(zone);
+		score += fragmentation_score_zone_weighted(zone);
 	}
 
 	return score;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

