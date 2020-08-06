Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B70B23DFAB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 19:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgHFRve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 13:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgHFQcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:32:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27953C02B8C0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 09:31:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z18so41042333wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p6XrrMy9U9a6D72/M7vouTgDf12ccI5j+g02H66Xr7c=;
        b=gI3p6b8ECCrNo9n/aOwg75F407VUCIBJzIHiUJ3ZTR5OJFXCVSok01gaibSuM1Crx6
         G+v1zWeVB7wj2EJV488CKSi2e1wbKEGP1HvupPK77bODf80LKhyrtn5EeqNbDtZNWg/P
         JBNA+tpVMCZZ1Dv7ZNqlPbr9WxTrbRBQMWgRR8Wb4fTs67gYfeUr20pC0J7BNRpmoZBr
         8hRhJng73ZiWa05IyZViEuOyDnXuvdD1O/yVXrIPezQZgbyK1Udc4J+3zuJUQk5acbb8
         yoRERyaZJ9Leh42ctG9D+JzoQs+z70GYaBRWhq/+myYwIJuDZmGP2p1r3Q57fRGjLQP3
         lH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p6XrrMy9U9a6D72/M7vouTgDf12ccI5j+g02H66Xr7c=;
        b=ir5q9wbb/xRC3Pfl1rIBMYEQkurRwnZgTNzND26AI++W8a+3S6Rq2mhk+uSVr4wRoX
         QsK+7DqStYd6DCX82orKVp73ptiTYK6sb10HlvmCwleDtx6LQrKOJeEc/2q0A79UnL9b
         8x/6Annf33VAGTneTDI5jL582ZwshQtWUYNILwJYTk1P2vVnAMlbiPAXt5LZGl8Dn8LG
         gBhXiHOEiATY/vVq1V9PHVVsYW1uTdk0lObRwvIwVlh7ZsaCpqWRYIpo0LA2GEmc+zN6
         0LxqRRyjrHQ+wdKiHjAa0W/P5n8Ds0Y6wbguKMlr6FKkRrgTm/go/21q8ooclKn1Umj2
         hDmw==
X-Gm-Message-State: AOAM533yXtnj+im3zzCuEDgkGEumX8zY9moZK/JMDrEmyGLCbme2QrlN
        6BLxG0HNKHMeqmKu4cu4Kkf/rA==
X-Google-Smtp-Source: ABdhPJzNNUfPimsDxn89xZX6EUAh0/BfX6oyvTuoGwFBIfa1ooTzH26s1ikWWa07mwCAl6TlUUNU1g==
X-Received: by 2002:adf:ba83:: with SMTP id p3mr8390078wrg.246.1596731493713;
        Thu, 06 Aug 2020 09:31:33 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id i66sm7468537wma.35.2020.08.06.09.31.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2020 09:31:33 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, bjorn.andersson@linaro.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] interconnect: qcom: Implement xlate_extended() to parse tags
Date:   Thu,  6 Aug 2020 19:31:22 +0300
Message-Id: <20200806163126.22667-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200806163126.22667-1-georgi.djakov@linaro.org>
References: <20200806163126.22667-1-georgi.djakov@linaro.org>
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
 
