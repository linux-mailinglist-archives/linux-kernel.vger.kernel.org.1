Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D879827AE03
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgI1Mjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:39:55 -0400
Received: from z5.mailgun.us ([104.130.96.5]:11451 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgI1Mjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:39:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601296794; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=QQmh3BA5OpkzZwsl8PVvSFFLJyaODlKUR1Mfgw9Rt5E=; b=LW2ouZqMZAss+6kJ1+pjEZhwuadg9ehosfQ5tRgju+nCSKm961O73TiHTNs+vHsiHdPyEe3R
 3avpcedlwp2OKD3sl3xVz0tLZiQaVq4QsfZ1MpLuSvzBA+w9qUPUUQOUxvxbIbCmwAJ91YNV
 B9ZdNntdGMuUxCmUrLqRPnZcCMI=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f71d99a1fdd3a1390c786ca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Sep 2020 12:39:54
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A71F1C43385; Mon, 28 Sep 2020 12:39:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vjitta-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9EF13C433CA;
        Mon, 28 Sep 2020 12:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9EF13C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
From:   vjitta@codeaurora.org
To:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     vinmenon@codeaurora.org, kernel-team@android.com,
        vjitta@codeaurora.org, robin.murphy@arm.com
Subject: [PATCH v3 1/2] iommu/iova: Retry from last rb tree node if iova search fails
Date:   Mon, 28 Sep 2020 18:09:33 +0530
Message-Id: <1601296774-24890-1-git-send-email-vjitta@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijayanand Jitta <vjitta@codeaurora.org>

When ever a new iova alloc request comes iova is always searched
from the cached node and the nodes which are previous to cached
node. So, even if there is free iova space available in the nodes
which are next to the cached node iova allocation can still fail
because of this approach.

Consider the following sequence of iova alloc and frees on
1GB of iova space

1) alloc - 500MB
2) alloc - 12MB
3) alloc - 499MB
4) free -  12MB which was allocated in step 2
5) alloc - 13MB

After the above sequence we will have 12MB of free iova space and
cached node will be pointing to the iova pfn of last alloc of 13MB
which will be the lowest iova pfn of that iova space. Now if we get an
alloc request of 2MB we just search from cached node and then look
for lower iova pfn's for free iova and as they aren't any, iova alloc
fails though there is 12MB of free iova space.

To avoid such iova search failures do a retry from the last rb tree node
when iova search fails, this will search the entire tree and get an iova
if its available.

Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
---
 drivers/iommu/iova.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 30d969a..acc8bee 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -184,8 +184,9 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	struct rb_node *curr, *prev;
 	struct iova *curr_iova;
 	unsigned long flags;
-	unsigned long new_pfn;
+	unsigned long new_pfn, low_pfn_new;
 	unsigned long align_mask = ~0UL;
+	unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
 
 	if (size_aligned)
 		align_mask <<= fls_long(size - 1);
@@ -198,15 +199,25 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 
 	curr = __get_cached_rbnode(iovad, limit_pfn);
 	curr_iova = rb_entry(curr, struct iova, node);
+	low_pfn_new = curr_iova->pfn_hi + 1;
+
+retry:
 	do {
-		limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
-		new_pfn = (limit_pfn - size) & align_mask;
+		high_pfn = min(high_pfn, curr_iova->pfn_lo);
+		new_pfn = (high_pfn - size) & align_mask;
 		prev = curr;
 		curr = rb_prev(curr);
 		curr_iova = rb_entry(curr, struct iova, node);
-	} while (curr && new_pfn <= curr_iova->pfn_hi);
-
-	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
+	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
+
+	if (high_pfn < size || new_pfn < low_pfn) {
+		if (low_pfn == iovad->start_pfn && low_pfn_new < limit_pfn) {
+			high_pfn = limit_pfn;
+			low_pfn = low_pfn_new;
+			curr = &iovad->anchor.node;
+			curr_iova = rb_entry(curr, struct iova, node);
+			goto retry;
+		}
 		iovad->max32_alloc_size = size;
 		goto iova32_full;
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
2.7.4

