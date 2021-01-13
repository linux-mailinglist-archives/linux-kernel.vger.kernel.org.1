Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188962F4CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbhAMOFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:05:14 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:46525 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbhAMOFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:05:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610546694; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=kk8JFI24A13gOE/9zp1nevr+Dpd0ltUMl4RWOmeOO1g=; b=Oz5PiLaKmD0rEQnpwTECmmqH2ILEnYpDG9v54RlId2tWLzB2YJRKNCpo6VZyqxK2pUHhrFJf
 v244SBxdRrNRtbi0wYYTXMyI+/gF5wMxLgNXcsBx4BASiU96r+nKhvktkCKGMwgBtCsxV4LB
 e6epHvzhre+QHmBd8At2dnwXVJA=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ffefdb5c88af0610783af6b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 13 Jan 2021 14:03:33
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B9735C43462; Wed, 13 Jan 2021 14:03:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from charante-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F0EB3C433C6;
        Wed, 13 Jan 2021 14:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F0EB3C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        khalid.aziz@oracle.com, ngupta@nitingupta.dev,
        vinmenon@codeaurora.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH] mm/compaction: return proper state in should_proactive_compact_node
Date:   Wed, 13 Jan 2021 19:33:06 +0530
Message-Id: <1610546586-18998-1-git-send-email-charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

should_proactive_compact_node() returns true when sum of the
fragmentation score of all the zones in the node is greater than the
wmark_high of compaction which then triggers the proactive compaction
that operates on the individual zones of the node. But proactive
compaction runs on the zone only when the fragmentation score of the
zone is greater than wmark_low(=wmark_high - 10).

This means that the sum of the fragmentation scores of all the zones can
exceed the wmark_high but individual zone scores can still be less than
the wmark_low which makes the unnecessary trigger of the proactive
compaction only to return doing nothing.

Another issue with the return of proactive compaction with out even
trying is its deferral. It is simply deferred for 1 <<
COMPACT_MAX_DEFER_SHIFT if the scores across the proactive compaction is
same, thinking that compaction didn't make any progress but in reality
it didn't even try. With the delay between successive retries for
proactive compaction is 500msec, it can result into the deferral for
~30sec with out even trying the proactive compaction.

Test scenario is that: compaction_proactiveness=50 thus the wmark_low =
50 and wmark_high = 60. System have 2 zones(Normal and Movable) with
sizes 5GB and 6GB respectively. After opening some apps on the android,
the fragmentation scores of these zones are 47 and 49 respectively.
Since the sum of these fragmentation scores are above the wmark_high
which triggers the proactive compaction and there since the individual
zone scores are below wmark_low, it returns without trying the
compaction. As a result the fragmentation scores of the zones are still
47 and 49 which makes the existing logic to defer the compaction
thinking that noprogress is made across the compaction.

So, run the proactive compaction on the node zones only when atleast one
of the zones fragmentation score is greater than wmark_low. This avoids
the unnecessary deferral and retries of the compaction.

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---
 mm/compaction.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index e5acb97..f7a772a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1964,6 +1964,26 @@ static unsigned int fragmentation_score_node(pg_data_t *pgdat)
 	return score;
 }
 
+/*
+ * Returns the maximum of fragmentation scores of zones in a node. This is
+ * used in taking the decission of whether to trigger the proactive compaction
+ * on the zones of this node.
+ */
+static unsigned int fragmentation_score_node_zones_max(pg_data_t *pgdat)
+{
+	int zoneid;
+	unsigned int max = 0;
+
+	for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
+		struct zone *zone;
+
+		zone = &pgdat->node_zones[zoneid];
+		max = max_t(unsigned int, fragmentation_score_zone(zone), max);
+	}
+
+	return max;
+}
+
 static unsigned int fragmentation_score_wmark(pg_data_t *pgdat, bool low)
 {
 	unsigned int wmark_low;
@@ -1979,13 +1999,16 @@ static unsigned int fragmentation_score_wmark(pg_data_t *pgdat, bool low)
 
 static bool should_proactive_compact_node(pg_data_t *pgdat)
 {
-	int wmark_high;
+	int wmark_low, wmark_high;
 
 	if (!sysctl_compaction_proactiveness || kswapd_is_running(pgdat))
 		return false;
 
 	wmark_high = fragmentation_score_wmark(pgdat, false);
-	return fragmentation_score_node(pgdat) > wmark_high;
+	wmark_low = fragmentation_score_wmark(pgdat, true);
+
+	return fragmentation_score_node(pgdat) > wmark_high &&
+		fragmentation_score_node_zones_max(pgdat) > wmark_low;
 }
 
 static enum compact_result __compact_finished(struct compact_control *cc)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

