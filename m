Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24081275ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgIWOx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:53:57 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:63607 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgIWOx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:53:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600872837; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=E8EY+ZCQ/E+6/fGqtQk7cFqKhQr66yDJmc66sl86p9U=; b=Us9uZya3lUHMlLBn6WfO6HQw+brUwbx8OQUlkMCeIVQQ/tfy/xHmxHytAiirWyetZIyGmWc3
 bqlsxK43YCeO90Cqg/ad38u+QOalvAKBsyJHgILo1/FhIgo0YEibsOcvVaEsv2cjklj5xaim
 jHMH9RpFK58fbiAlzGQAjM5Y3w0=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f6b618431df7883e5d26012 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Sep 2020 14:53:56
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6488FC433CA; Wed, 23 Sep 2020 14:53:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from charante-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 50FEDC433CA;
        Wed, 23 Sep 2020 14:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50FEDC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     joro@8bytes.org, iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH] iommu: of: skip iommu_device_list traversal in of_iommu_xlate()
Date:   Wed, 23 Sep 2020 20:23:46 +0530
Message-Id: <1600872826-2254-1-git-send-email-charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In of_iommu_xlate(), check if iommu device is enabled before traversing
the iommu_device_list through iommu_ops_from_fwnode(). It is of no use
in traversing the iommu_device_list only to return NO_IOMMU because of
iommu device node is disabled.

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---
 drivers/iommu/of_iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e505b91..225598c 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -94,9 +94,10 @@ static int of_iommu_xlate(struct device *dev,
 	struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
 	int ret;
 
+	if (!of_device_is_available(iommu_spec->np))
+		return NO_IOMMU;
 	ops = iommu_ops_from_fwnode(fwnode);
-	if ((ops && !ops->of_xlate) ||
-	    !of_device_is_available(iommu_spec->np))
+	if (ops && !ops->of_xlate)
 		return NO_IOMMU;
 
 	ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

