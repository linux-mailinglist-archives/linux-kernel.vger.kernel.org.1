Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916EF2D77FD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 15:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406297AbgLKOdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 09:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406269AbgLKOco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:32:44 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3701AC0611E4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:30:50 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id w13so13583149lfd.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TC3nvcCsKElennu363xgzX81b8s+QPHA8xr9Tbhrl4w=;
        b=fInATpmn5aXIMdqqCMq1nnYMD46JaKgeio7qqkIWPAy5iyQuaCf5xpZAzST7LnZiTm
         pT70ncVHd2lqP67P4nbKHZ9a+8Iw2NPSoqecYwa0jtOBDVCG+mIRCn0Q6jO27a7E9Jem
         ahwGZg63orgPCV+6S6kwJOvwUqast68vh5XMgDJ2lWzJngEVaQ00QMHEZAiTifJToCsP
         xK98/H2A+EoE7gRboeajuRtpbjG80nnEqCp0WgPh88s/1f3JHi7gPkc9WG1gTYUtugLy
         IlUJihn1oN5NSWXah1ZJG90tgoB8u82HSIRq82qIFd/JIvwvjQvTjDA9uoxSlHc0qgOo
         iOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TC3nvcCsKElennu363xgzX81b8s+QPHA8xr9Tbhrl4w=;
        b=pHTOYuqVtUm+K6L6889jaWodmE46TGBUvY1dKqMuEQCYUJB6HMFHSUqmx6pd6qBFaA
         xjg2Zfl+VxxDpKclof+7AVowT7/ZZlfkWQ1RunPIdLcW0MjQV0UWbiLp4uLCktFSsG6L
         NhaIQG/jDFygcahIN+1DGJMusI4W6vsWUrv5OtCnMWYvmX6k8xSnWQ/zM/H9Pm+jXS6y
         hmyoGN6Tnr6YiihG/JpDU5KtieXZ5C/RxhKUrxWxbKtjI4Qv+hOx2JB565kC1a9gFE9f
         +u9cRitroEB5ezbXKXItddkAI3xvavR+4KrjSO9c0gtF5f3P/w/Tu5Dd41WarKsucIIG
         7yVQ==
X-Gm-Message-State: AOAM530Ai4UOHY7Zwrznva3fU31bZSjMn4aWNlDERBpy0pE3jWbfTi4b
        anN66h4atrn0GbFqAS0XJKtzPA==
X-Google-Smtp-Source: ABdhPJxMxrQ4KNASC27zblm4T7/0+PW+bq/u7+d/RQzYScHtQ48AArv3ONiHIP4xpRXDnTufQITTrA==
X-Received: by 2002:a19:5f5d:: with SMTP id a29mr4517141lfj.212.1607697048664;
        Fri, 11 Dec 2020 06:30:48 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id x26sm906491lfq.112.2020.12.11.06.30.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 06:30:48 -0800 (PST)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org, s-anna@ti.com,
        ssantosh@kernel.org
Cc:     grzegorz.jaszczyk@linaro.org, linux-remoteproc@vger.kernel.org,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, praneeth@ti.com,
        rogerq@ti.com
Subject: [PATCH 5/5] remoteproc: pru: Configure firmware based on client setup
Date:   Fri, 11 Dec 2020 15:29:33 +0100
Message-Id: <20201211142933.25784-6-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201211142933.25784-1-grzegorz.jaszczyk@linaro.org>
References: <20201211142933.25784-1-grzegorz.jaszczyk@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

Client device node property firmware-name is now used to configure
firmware for the PRU instances. The default firmware is also
restored once releasing the PRU resource.

Co-developed-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
---
 drivers/remoteproc/pru_rproc.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index ac13e4452a57..fed7a2051ebf 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -170,6 +170,23 @@ void pru_control_set_reg(struct pru_rproc *pru, unsigned int reg,
 	spin_unlock_irqrestore(&pru->rmw_lock, flags);
 }
 
+/**
+ * pru_rproc_set_firmware() - set firmware for a pru core
+ * @rproc: the rproc instance of the PRU
+ * @fw_name: the new firmware name, or NULL if default is desired
+ *
+ * Return: 0 on success, or errno in error case.
+ */
+static int pru_rproc_set_firmware(struct rproc *rproc, const char *fw_name)
+{
+	struct pru_rproc *pru = rproc->priv;
+
+	if (!fw_name)
+		fw_name = pru->fw_name;
+
+	return rproc_set_firmware(rproc, fw_name);
+}
+
 static struct rproc *__pru_rproc_get(struct device_node *np, int index)
 {
 	struct device_node *rproc_np = NULL;
@@ -230,6 +247,8 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
 	struct rproc *rproc;
 	struct pru_rproc *pru;
 	struct device *dev;
+	const char *fw_name;
+	int ret;
 
 	rproc = __pru_rproc_get(np, index);
 	if (IS_ERR(rproc))
@@ -254,7 +273,21 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
 	if (pru_id)
 		*pru_id = pru->id;
 
+	ret = of_property_read_string_index(np, "firmware-name", index,
+					    &fw_name);
+	if (!ret) {
+		ret = pru_rproc_set_firmware(rproc, fw_name);
+		if (ret) {
+			dev_err(dev, "failed to set firmware: %d\n", ret);
+			goto err;
+		}
+	}
+
 	return rproc;
+
+err:
+	pru_rproc_put(rproc);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(pru_rproc_get);
 
@@ -276,6 +309,8 @@ void pru_rproc_put(struct rproc *rproc)
 	if (!pru->client_np)
 		return;
 
+	pru_rproc_set_firmware(rproc, NULL);
+
 	mutex_lock(&pru->lock);
 	pru->client_np = NULL;
 	rproc->deny_sysfs_ops = false;
-- 
2.29.0

