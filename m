Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3124C25C46F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgICPKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 11:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbgICN5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 09:57:54 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DB5C0619EC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 06:31:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so3242382wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p6XrrMy9U9a6D72/M7vouTgDf12ccI5j+g02H66Xr7c=;
        b=L2JFU0UnIqcJXPhPG2tVj2XRHoqRM6PPI5htL1hCEyDVp4E0ETfFHDLkACalSGr/NL
         1mCI0n24LD+c5P+pvefpfp+1P64ZVlcoM1fLYHA0aj8SIe8lK6Gf0kMOng5ACRm29Pev
         Brm3/jFTBNR8jRWdOEKq/gutqsBKLsGgfg5JSOx3H3DCAEteJPvlgPUGtcXxnZMlI6wx
         mX8ZQ2TkLPLDLMNb3AuNWuPrZ6eNN1TWphSfPTazFkMEsLYtGL9Uz39FMmtDbgpBDBX/
         X+GDQkpSDK+NqJpBfPREEhLu7NiM/5zYIdNZCYDlFKNQ8yosDa3G2RX8z3T90pGBzAXj
         daGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p6XrrMy9U9a6D72/M7vouTgDf12ccI5j+g02H66Xr7c=;
        b=XmWexek5Ev4ChSnUYQVr4YEgD7vsLanPz/XtctZ8sXK/btK8zlYf2Hx5qVijhF7aJ4
         P5O7FWRfp5UBLsB5EaH/TCFUdRNrHgYnAX2XjG6Tt2T1yn+yuGjd2uqYIe0oPJDlYnNZ
         R1kgPXWNJ4m+bjQxZR15KUBt139mk82Ibu3jTTXgw0L9hb3OE14nKJ6MyTHQJuBd1GY+
         VcHdEyyUdNApFTBJSDj8PtvVaNTZz98q4lFOjlRJ3XPAevWZ3+3Z423CfcGY6ZpDT4q5
         fBq3MEkRBhqJHlrU2krrU18QBKv8iLAxvYaXbLix0ZtIPuCnFD/QNgftOfxDNVwPXzHI
         munw==
X-Gm-Message-State: AOAM530kUfzeQbfJRNnJvL1MXuIhwAi29rnyv7z5HqJa7YE9gABgbD71
        8thkOHfcFnI17mPKDW9AMB4hhA==
X-Google-Smtp-Source: ABdhPJyfSdIyuKbBOmnhuXtH81KE55IYjPFKRa6w/R89qr724BOshRxg5zZ27zOXQWH4OsXv3j/CDA==
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr2500760wrm.120.1599139900643;
        Thu, 03 Sep 2020 06:31:40 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b2sm4310768wmh.47.2020.09.03.06.31.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 06:31:40 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, bjorn.andersson@linaro.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] interconnect: qcom: Implement xlate_extended() to parse tags
Date:   Thu,  3 Sep 2020 16:31:30 +0300
Message-Id: <20200903133134.17201-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200903133134.17201-1-georgi.djakov@linaro.org>
References: <20200903133134.17201-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a function to parse the arguments of the "interconnects" DT
property and populate the interconnect path tags if this information
is available.

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/icc-rpmh.c | 27 +++++++++++++++++++++++++++
 drivers/interconnect/qcom/icc-rpmh.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 3ac5182c9ab2..7e538155e486 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -6,6 +6,8 @@
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
@@ -92,6 +94,31 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_set);
 
+struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+{
+	struct icc_node_data *ndata;
+	struct icc_node *node;
+
+	node = of_icc_xlate_onecell(spec, data);
+	if (IS_ERR(node))
+		return ERR_CAST(node);
+
+	ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
+	if (!ndata)
+		return ERR_PTR(-ENOMEM);
+
+	ndata->node = node;
+
+	if (spec->args_count == 2)
+		ndata->tag = spec->args[1];
+
+	if (spec->args_count > 2)
+		pr_warn("%pOF: Too many arguments, path tag is not parsed\n", spec->np);
+
+	return ndata;
+}
+EXPORT_SYMBOL_GPL(qcom_icc_xlate_extended);
+
 /**
  * qcom_icc_bcm_init - populates bcm aux data and connect qnodes
  * @bcm: bcm to be initialized
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 903d25e61984..1dac39bc255d 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -143,6 +143,7 @@ struct qcom_icc_desc {
 int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 		       u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 int qcom_icc_set(struct icc_node *src, struct icc_node *dst);
+struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data);
 int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev);
 void qcom_icc_pre_aggregate(struct icc_node *node);
 
