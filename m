Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A962C5D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 22:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391763AbgKZVHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 16:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391622AbgKZVG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 16:06:58 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7242AC061A53
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:56 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id s21so2587628pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/KGOX9KkEX+n+yFMKTjakVzZosqRnFOWNvseTfllA6Q=;
        b=Dg+HdzxDV2YNawQ0UhBP6HdLS5ZVfu3mLkvXwyT6jnxsG2wu2G+m7UD0mOxya3fTN2
         a9YMPlCBY/rXtrETa0IEBOpG/TCZKmhJsG1jozvA4SM9iuIVszkHSgf+Q9SPAx5DIGCW
         Pwh61Oz8jyJQb0BuXQy8+l1YJhUgNlq9j4tWrr/dqDZJiI8IVfWCzO5G50b2Usgzcv1W
         IvWXUq5805Wcj7MwD2WFiInSQL8+Ltpv5QL8ebWvwGCOPUNejoEmFYsIesO0NeSQbimY
         1MlVtiFWwIm/l1LjWovvF+mF6BIdiCKp5xTS77fFQLxqNJ0g7M9vSZvDmKQ/9jsQnNsY
         3XNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/KGOX9KkEX+n+yFMKTjakVzZosqRnFOWNvseTfllA6Q=;
        b=mGBXNxTxwl85eORBRlWZdOMSEdjLpe5PnGp399mEdfBcogUnSRerNodr9+wYOOTVMV
         TmjdnUn806/ovJca7QPd1XvtLuu4aIzCn67MZcSvDbT1wSf7ZlSNcfmGugscwcBOIeoG
         6EJAMltU7m//EHJi68OUB9Of796YM4CZYpZAwOJDCPWGcy8GlzK4wGH0pA6gcf4Jv2c5
         PpXxllJCt3vc0ICfDU0xhnQHFokHWamkFXfAoX9qgV4vSuie6CDSXNzN5lwWtU3avT4y
         zMoRc8Zk3F/KvQCeN2AY8PVcHs0M17v3rnU9Rdm2mm677QTOJLz9wwuHu7WHlizsoWgN
         BBHg==
X-Gm-Message-State: AOAM530jm93aCxwVb2+RGEJIKeQ9haz10WsWOfqvDmss5ggDRcIfJAzs
        qQ2yZqcS7GoXphZKsiKHVtZseg==
X-Google-Smtp-Source: ABdhPJzr8aZpx9HBvkaCPyAWEaw6iohIuja0Ntqlnm2c2SLjUUSlnTqjuSH7wdlhYHHiPjrfDzHPnw==
X-Received: by 2002:a62:1d6:0:b029:197:f8a8:e6de with SMTP id 205-20020a6201d60000b0290197f8a8e6demr4133919pfb.38.1606424816035;
        Thu, 26 Nov 2020 13:06:56 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c203sm5612676pfc.10.2020.11.26.13.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 13:06:55 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com
Subject: [PATCH v3 12/15] remoteproc: Properly deal with a stop request when attached
Date:   Thu, 26 Nov 2020 14:06:39 -0700
Message-Id: <20201126210642.897302-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126210642.897302-1-mathieu.poirier@linaro.org>
References: <20201126210642.897302-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the capability to stop a remote processor
that has been attached to by the remoteproc core.  For that to
happen a rproc::ops::stop() operation need to be available.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_cdev.c  | 5 +++--
 drivers/remoteproc/remoteproc_core.c  | 6 +++++-
 drivers/remoteproc/remoteproc_sysfs.c | 5 +++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index b19ea3057bde..d06f8d4919c7 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -37,10 +37,11 @@ static ssize_t rproc_cdev_write(struct file *filp, const char __user *buf, size_
 
 		ret = rproc_boot(rproc);
 	} else if (!strncmp(cmd, "stop", len)) {
-		if (rproc->state != RPROC_RUNNING)
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
 			return -EINVAL;
 
-		rproc_shutdown(rproc);
+		ret = rproc_shutdown(rproc);
 	} else {
 		dev_err(&rproc->dev, "Unrecognized option\n");
 		ret = -EINVAL;
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 51275107eb1f..3d7d245edc4e 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1642,6 +1642,10 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
 	struct device *dev = &rproc->dev;
 	int ret;
 
+	/* No need to continue if a stop() operation has not been provided */
+	if (!rproc->ops->stop)
+		return -EINVAL;
+
 	/* Stop any subdevices for the remote processor */
 	rproc_stop_subdevices(rproc, crashed);
 
@@ -1880,7 +1884,7 @@ int rproc_shutdown(struct rproc *rproc)
 		return ret;
 	}
 
-	if (rproc->state != RPROC_RUNNING) {
+	if (rproc->state != RPROC_RUNNING && rproc->state != RPROC_ATTACHED) {
 		ret = -EPERM;
 		goto out;
 	}
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index f9694def9b54..3696f2ccc785 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -201,10 +201,11 @@ static ssize_t state_store(struct device *dev,
 		if (ret)
 			dev_err(&rproc->dev, "Boot failed: %d\n", ret);
 	} else if (sysfs_streq(buf, "stop")) {
-		if (rproc->state != RPROC_RUNNING)
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
 			return -EINVAL;
 
-		rproc_shutdown(rproc);
+		ret = rproc_shutdown(rproc);
 	} else {
 		dev_err(&rproc->dev, "Unrecognised option: %s\n", buf);
 		ret = -EINVAL;
-- 
2.25.1

