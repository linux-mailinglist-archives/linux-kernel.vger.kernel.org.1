Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B8020487F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 06:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbgFWEJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 00:09:00 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25746 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732082AbgFWEI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 00:08:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592885336; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=IARNoExwd9tKeod/PEcdNAzRsZO98vGy2+NXI+vE9dA=; b=JnyOkN+nUIXcf5kOXbrR7cBiYGmTHEZB6q6nRw5i78BzIhu60tS2QtqYCz8126ZyGcRDGDwU
 JS5RzuNhrLquumICzz4DaeKnxROuN3oCFe0+pwK0NsFvDcJSXiJUnLZjQ5PmipSm3Wj9mGpT
 2x2hbo5gOoN1HlCTeOLd9B3rVCs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5ef18040c76a4e7a2abdab2b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 04:08:32
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AEBFDC43391; Tue, 23 Jun 2020 04:08:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0BB2EC433AD;
        Tue, 23 Jun 2020 04:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0BB2EC433AD
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH 4/4] interconnect: qcom: Fix small BW votes being truncated to zero
Date:   Mon, 22 Jun 2020 21:08:14 -0700
Message-Id: <20200623040814.23791-5-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200623040814.23791-1-mdtipton@codeaurora.org>
References: <20200623040814.23791-1-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small BW votes that translate to less than a single BCM unit are
currently truncated to zero. Ensure that non-zero BW requests always
result in at least a vote of 1 to BCM.

Fixes: 976daac4a1c5 ("interconnect: qcom: Consolidate interconnect RPMh support")
Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index a68c858ca6b7..9e2612fe7fad 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -54,8 +54,20 @@ static int cmp_vcd(void *priv, struct list_head *a, struct list_head *b)
 		return 1;
 }
 
+static u64 bcm_div(u64 num, u64 base)
+{
+	/* Ensure that small votes aren't lost. */
+	if (num && num < base)
+		return 1;
+
+	do_div(num, base);
+
+	return num;
+}
+
 static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 {
+	struct qcom_icc_node *node;
 	size_t i, bucket;
 	u64 agg_avg[QCOM_ICC_NUM_BUCKETS] = {0};
 	u64 agg_peak[QCOM_ICC_NUM_BUCKETS] = {0};
@@ -63,22 +75,21 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 
 	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
 		for (i = 0; i < bcm->num_nodes; i++) {
-			temp = bcm->nodes[i]->sum_avg[bucket] * bcm->aux_data.width;
-			do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
+			node = bcm->nodes[i];
+			temp = bcm_div(node->sum_avg[bucket] * bcm->aux_data.width,
+				       node->buswidth * node->channels);
 			agg_avg[bucket] = max(agg_avg[bucket], temp);
 
-			temp = bcm->nodes[i]->max_peak[bucket] * bcm->aux_data.width;
-			do_div(temp, bcm->nodes[i]->buswidth);
+			temp = bcm_div(node->max_peak[bucket] * bcm->aux_data.width,
+				       node->buswidth);
 			agg_peak[bucket] = max(agg_peak[bucket], temp);
 		}
 
 		temp = agg_avg[bucket] * bcm->vote_scale;
-		do_div(temp, bcm->aux_data.unit);
-		bcm->vote_x[bucket] = temp;
+		bcm->vote_x[bucket] = bcm_div(temp, bcm->aux_data.unit);
 
 		temp = agg_peak[bucket] * bcm->vote_scale;
-		do_div(temp, bcm->aux_data.unit);
-		bcm->vote_y[bucket] = temp;
+		bcm->vote_y[bucket] = bcm_div(temp, bcm->aux_data.unit);
 	}
 
 	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

