Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9376B2FDDC8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390172AbhAUATo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403811AbhATXTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 18:19:13 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6192C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 14:50:30 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 34so14183904otd.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 14:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4idyrgOjbPCo0xIvVDxnoQX1+7++2YYqASwzmUbTSIg=;
        b=FwpFBEdguoiC+d4juDT3vyfKfWHn9cZAGK9cR+YsoPIdAANOkVKQvzUBgY460yF0YW
         Y1W7EeLTIwQWdYygIyO03+K/O3PKuFQTfhmBhhxhL2TPN9rltmJru4ry5loGDnXVO8+s
         ohSkXH6uOH/MLP/ksrmbF+ncN5DQM+fWvWEscvZ3efjMIIt9QhE3imCLLwtvsKL/w88Y
         vfegYkpMwCQ7mFNiKBAs6ME7NLKJ4hxJiFvcPtHYx++uQuODT6MEHD/fHvM7zeQqErkg
         ZKUS4iMInVT5/QgI+yogRUDCaSZk31f5VZY7KLJIBBnV2WhXqvnUWH6ZVJx9NniH7b88
         ZVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4idyrgOjbPCo0xIvVDxnoQX1+7++2YYqASwzmUbTSIg=;
        b=DQTmbNB/C7D2qdFqiWFvMrHBVV2ZnWBdf+YOvkjiYhStsvKcygiChixNDE7fDcRHDz
         e8PBJGzPoGGUbGMhf30KYHtqeoqqbwrFW5qBFAuilATL7ZmTMRMJclOc6xbHLBw77XtF
         oSbqyT4QfiaYrQu/U247x6xR8OKXHBcgM4zRALRBlkqCnA9XPCJyg8e3oOYrlDqKn2ln
         wrxprTixV23x40dC2zOH2LDGMaXw6Ei99PBHtLTxEMOAhs+N18rsRUjey03YNa3ihQlm
         /OpeMCIdqAm4InhUEdAFPAwQc0jgkokeMUsmW6FURBbBzCkWujbyebyEfNn4YzBNnjTe
         vHmA==
X-Gm-Message-State: AOAM530rJZeLWM2NZOkNo4qTfxq9AqXLB1wpXzwCHGVzD7fQSH073mRm
        orCjlVTH+G5zdNlWPTqVNae0zGXcDP8DIw==
X-Google-Smtp-Source: ABdhPJyI5wePjhle5rg1W7f9Ny2WB6bW1HhAX6OhimdlyLMDYG/NNtvs8dUtFT6bjs4SeTFn/jGw6Q==
X-Received: by 2002:a9d:4b03:: with SMTP id q3mr8362686otf.88.1611183030357;
        Wed, 20 Jan 2021 14:50:30 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r133sm677632oia.17.2021.01.20.14.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 14:50:29 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] soc: qcom: rpmhpd: Add SC8180X
Date:   Wed, 20 Jan 2021 14:50:37 -0800
Message-Id: <20210120225037.1611353-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120225037.1611353-1-bjorn.andersson@linaro.org>
References: <20210120225037.1611353-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the power domains exposed by RPMH in the Qualcomm SC8180X platform.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/soc/qcom/rpmhpd.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 7ce06356d24c..18d5180c0ca0 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -217,8 +217,29 @@ static const struct rpmhpd_desc sc7180_desc = {
 	.num_pds = ARRAY_SIZE(sc7180_rpmhpds),
 };
 
+/* SC8180x RPMH powerdomains */
+static struct rpmhpd *sc8180x_rpmhpds[] = {
+	[SC8180X_CX] = &sdm845_cx,
+	[SC8180X_CX_AO] = &sdm845_cx_ao,
+	[SC8180X_EBI] = &sdm845_ebi,
+	[SC8180X_GFX] = &sdm845_gfx,
+	[SC8180X_LCX] = &sdm845_lcx,
+	[SC8180X_LMX] = &sdm845_lmx,
+	[SC8180X_MMCX] = &sm8150_mmcx,
+	[SC8180X_MMCX_AO] = &sm8150_mmcx_ao,
+	[SC8180X_MSS] = &sdm845_mss,
+	[SC8180X_MX] = &sdm845_mx,
+	[SC8180X_MX_AO] = &sdm845_mx_ao,
+};
+
+static const struct rpmhpd_desc sc8180x_desc = {
+	.rpmhpds = sc8180x_rpmhpds,
+	.num_pds = ARRAY_SIZE(sc8180x_rpmhpds),
+};
+
 static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sc7180-rpmhpd", .data = &sc7180_desc },
+	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &sc8180x_desc },
 	{ .compatible = "qcom,sdm845-rpmhpd", .data = &sdm845_desc },
 	{ .compatible = "qcom,sdx55-rpmhpd", .data = &sdx55_desc},
 	{ .compatible = "qcom,sm8150-rpmhpd", .data = &sm8150_desc },
-- 
2.29.2

