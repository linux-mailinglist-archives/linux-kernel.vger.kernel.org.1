Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478B728CFA9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbgJMN7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 09:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388174AbgJMN7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:59:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8BDC0613D5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 06:59:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b8so10970141wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 06:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+bxQjF8JFA6Asp2x5Qy6bOVvEknWT2jmgAadI+Foe/4=;
        b=UHFX6ogsO9YEIpG7gnor6Jqroymz8ZdFMfwBgY/YnjRGDWk0Pegm37VyPl2TgQF5kH
         vj92LXD9MWFC9LoKlOn7V4+8rkWsBTmKCmznAkmSPV3OUi6bCeSKhnRT9a6QuXnPZeAW
         78F/hDYd4oNUQ7IZYHKvywWP0tx0xrtnRkJp3bChNvTbz2ijfnaNWSmK8Y231P90Ya7h
         Mnh7Y3mkorQ3UZ/KstidY7o0MLC2jaLpT38dGooda1B6XEz00X+NDIJOIH5CpIlJjnku
         3mWCTkdgtru9x58w/kJNfIfozrbntdYPaL/PpP14Rj8ACE676wMRiKQMKdJOHX1sPgwb
         uQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+bxQjF8JFA6Asp2x5Qy6bOVvEknWT2jmgAadI+Foe/4=;
        b=odX2gY/pUrSZlxzCRClR6MoA/pkj5cRs4jUE50j9n/WpdgBabd4Vd7cQfemw5ITH/k
         6rhvQF5QU0NfA3UuCnhPB/x53T5hCUhLYhAiwEcYT7KqF94n//CTEc7HK0y1d+FuaJS2
         D4TCll3KgeUheK42gDAprkN0n10OtANlT7WzrFEHZhAg2/9RDTDSevDAyFbWPj9xEFNk
         3CSs2zkhUFQEv3VA/HUvyCc7cDFFrR1lfrY9L3dk8tQlJqHJgFPFBsEiCySqjSFis19/
         dHj3DmAQTo+k16bzUDTUbxJrS6GNtEkm8FOqhCg6lUyqZwuauSptw1FQJJhwXYOx9yLk
         uBWw==
X-Gm-Message-State: AOAM531mroBrh5kwmDGWEbj3Iz12S5CFDR+Sgz6AxHRmJjRqhbSvNurD
        ipbV7pYp2r+VcwjLhiN1aDox+g==
X-Google-Smtp-Source: ABdhPJySAnjh+044UzGZPOEf9/B71RqNokP2SUMBpwVEdgmbgwgSwLsXYJa+QYU6CxndkNvBNPltTQ==
X-Received: by 2002:adf:a31a:: with SMTP id c26mr34581095wrb.378.1602597554919;
        Tue, 13 Oct 2020 06:59:14 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a199sm17785wmd.8.2020.10.13.06.59.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2020 06:59:14 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     mdtipton@codeaurora.org, okukatla@codeaurora.org,
        sibis@codeaurora.org, saravanak@google.com,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 3/3] interconnect: qcom: sc7180: Init BCMs before creating the nodes
Date:   Tue, 13 Oct 2020 16:59:13 +0300
Message-Id: <20201013135913.29059-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013135913.29059-1-georgi.djakov@linaro.org>
References: <20201013135913.29059-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if we use sync_state, by default the bandwidth is maxed out,
but in order to set this in hardware, the BCMs (Bus Clock Managers) need
to be initialized first. Move the BCM initialization before creating the
nodes to fix this.

Fixes: 7d3b0b0d8184 ("interconnect: qcom: Use icc_sync_state")
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sc7180.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index bf11b82ed55c..8d9044ed18ab 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -553,6 +553,9 @@ static int qnoc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	for (i = 0; i < qp->num_bcms; i++)
+		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
+
 	for (i = 0; i < num_nodes; i++) {
 		size_t j;
 
@@ -576,9 +579,6 @@ static int qnoc_probe(struct platform_device *pdev)
 	}
 	data->num_nodes = num_nodes;
 
-	for (i = 0; i < qp->num_bcms; i++)
-		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
-
 	platform_set_drvdata(pdev, qp);
 
 	return 0;
