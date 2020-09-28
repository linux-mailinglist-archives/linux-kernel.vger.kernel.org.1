Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9B727AE09
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgI1Mkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:40:31 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:55103 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgI1Mka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:40:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601296830; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=kin/Mn1DnCVJ38Zxy6TVgJAh053AKuD1AM1bvjdF47o=; b=bdnhAUkSuGkTRBXpy0u4fkHuHgwZLpcBwte9mlZlGu6C57M+Q1pKW2PPqczBrC+2pmTaB5U4
 e5j6+bj6KrQZJaKVRSFw7uOTBc/3PXxaClIwKcBOWIp4UNKLs8ytcyC31UlCM/athBOOw5Ae
 tMArCrks/ewV5hxxIlkBDaV+5gM=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f71d9a083f5ac99db009a3e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Sep 2020 12:40:00
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3BB40C433F1; Mon, 28 Sep 2020 12:40:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vjitta-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 26DBBC433CA;
        Mon, 28 Sep 2020 12:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26DBBC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
From:   vjitta@codeaurora.org
To:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     vinmenon@codeaurora.org, kernel-team@android.com,
        vjitta@codeaurora.org, robin.murphy@arm.com
Subject: [PATCH v3 2/2] iommu/iova: Free global iova rcache on iova alloc failure
Date:   Mon, 28 Sep 2020 18:09:34 +0530
Message-Id: <1601296774-24890-2-git-send-email-vjitta@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601296774-24890-1-git-send-email-vjitta@codeaurora.org>
References: <1601296774-24890-1-git-send-email-vjitta@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijayanand Jitta <vjitta@codeaurora.org>

When ever an iova alloc request fails we free the iova
ranges present in the percpu iova rcaches and then retry
but the global iova rcache is not freed as a result we could
still see iova alloc failure even after retry as global
rcache is holding the iova's which can cause fragmentation.
So, free the global iova rcache as well and then go for the
retry.

Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
---
 drivers/iommu/iova.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index acc8bee..b4f04fd 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -442,6 +442,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 		flush_rcache = false;
 		for_each_online_cpu(cpu)
 			free_cpu_cached_iovas(cpu, iovad);
+		free_global_cached_iovas(iovad);
 		goto retry;
 	}
 
@@ -1057,5 +1058,26 @@ void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
 	}
 }
 
+/*
+ * free all the IOVA ranges of global cache
+ */
+static void free_global_cached_iovas(struct iova_domain *iovad)
+{
+	struct iova_rcache *rcache;
+	unsigned long flags;
+	int i, j;
+
+	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+		rcache = &iovad->rcaches[i];
+		spin_lock_irqsave(&rcache->lock, flags);
+		for (j = 0; j < rcache->depot_size; ++j) {
+			iova_magazine_free_pfns(rcache->depot[j], iovad);
+			iova_magazine_free(rcache->depot[j]);
+			rcache->depot[j] = NULL;
+		}
+		rcache->depot_size = 0;
+		spin_unlock_irqrestore(&rcache->lock, flags);
+	}
+}
 MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
 MODULE_LICENSE("GPL");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
2.7.4

