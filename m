Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD02428D309
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 19:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388353AbgJMRTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 13:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJMRTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 13:19:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AED0C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 10:19:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e18so180098wrw.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hi/aqJYx9lDP1HowNRsqMAfgvbnLyBU/Tyswx0oWrYA=;
        b=md7BnzJBSb99UK843T7yDU4rkdMtlCNAi8Xj418lZAwmGnFkQKgSVNzWZrCQ22kZIj
         6lxtI/o3x6XOyh/kRvWMEFseyGVA8mw5T7Rkd/9QBR1AqpHldIUT4BHO493wGlCmoOpH
         I7yexQzoZs7X6GgN5EEmC+4Y+VlCEmJ/bMErNf1O/qyfnEXVBFit0Jdu03HrS5829HTQ
         NKa1Y6Fq6ehVdQrfdUUtpvgWDnX1SxuuntofQhAcpMdy2NcAr8RK8rLfzNetY0GgPJyN
         RpWSQVgkNBiD7+72nsJwSlq0nhz0PUZdEhJSbKreJTonlCPb8qq2UMuY6wNiG8DxQ3DI
         8PTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hi/aqJYx9lDP1HowNRsqMAfgvbnLyBU/Tyswx0oWrYA=;
        b=kc+ll2+1EK5NWHhF9Gbh7fy5XwnWcW6BycsGVQ1WFNy/XpAh/G1gyEZyndyYWL93CZ
         8lunWuhGh14rhMstIcVolx1sjbHRbY54uyD3wOVgxw/Wcd7bKyAEOSLhea+tdjza80Lg
         AhYpwGw6J4ZYvUMmRxUfj+DLNf6UTPkNcLiAdCVKG2VeWDBGl14azRFQ+Lq5gzdedj3R
         URIQCsskGok7jvRmLUUA0gJtKNPmqfDGJ4H/GqtMa7i47tgBLTLtW4C3eSild6DBpJ3q
         T/ptaSZUGes4ycgEhUspsp7pwnzrAz1MhbWI9XZgBKYtjb6jxXVBS8rS3tv7iPsPFTEW
         VH5w==
X-Gm-Message-State: AOAM532JRrhHw9PHYjPwQt4bv+HaxT5PP1EW9eTikDsK9PWljSQdYDaJ
        81vhuGYQwG/j5HyYDJwLjIsV+g==
X-Google-Smtp-Source: ABdhPJwietwj2yNqUWc59yGVuGyBA5MFBEhx8TCB8X03OJoQyr/Fo3Ktwr4wAz+DcvwRpR6q48trFA==
X-Received: by 2002:adf:e80f:: with SMTP id o15mr808126wrm.308.1602609561969;
        Tue, 13 Oct 2020 10:19:21 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id c18sm317609wrq.5.2020.10.13.10.19.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2020 10:19:21 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     mdtipton@codeaurora.org, okukatla@codeaurora.org,
        sibis@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] interconnect: qcom: Simplify the vcd compare function
Date:   Tue, 13 Oct 2020 20:19:23 +0300
Message-Id: <20201013171923.7351-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's simplify the cmp_vcd() function and replace the conditionals
with just a single statement, which also improves readability.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index 887d13721e52..1cc565bce2f4 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -41,17 +41,10 @@ struct bcm_voter {
 
 static int cmp_vcd(void *priv, struct list_head *a, struct list_head *b)
 {
-	const struct qcom_icc_bcm *bcm_a =
-			list_entry(a, struct qcom_icc_bcm, list);
-	const struct qcom_icc_bcm *bcm_b =
-			list_entry(b, struct qcom_icc_bcm, list);
-
-	if (bcm_a->aux_data.vcd < bcm_b->aux_data.vcd)
-		return -1;
-	else if (bcm_a->aux_data.vcd == bcm_b->aux_data.vcd)
-		return 0;
-	else
-		return 1;
+	const struct qcom_icc_bcm *bcm_a = list_entry(a, struct qcom_icc_bcm, list);
+	const struct qcom_icc_bcm *bcm_b = list_entry(b, struct qcom_icc_bcm, list);
+
+	return bcm_a->aux_data.vcd - bcm_b->aux_data.vcd;
 }
 
 static u64 bcm_div(u64 num, u32 base)
