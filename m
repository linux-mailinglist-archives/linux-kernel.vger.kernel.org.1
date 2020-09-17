Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455F726D1B4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 05:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgIQD3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 23:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIQD2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 23:28:07 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0609C061A27
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 20:22:35 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id r8so757108qtp.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 20:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uYlLNN0UyKBRIab8OLOITLg387YzzBqmIZv+ipj1Bk=;
        b=WgQWIsUlbXN3VVXSecXh6NSwzMBUdXegJ1UbE5dZ5hL0zTZqMnJXK3IU1YodWCoeuB
         Y4OEpjgNajgPg+yhYvIAF872GecFsE1BgxlzwnqnA2jGT679cwonprKHeJe8p+UZy5J4
         r72IIPcyanDumuLDsqhSxQlUc1HrTMomgmZd3gWrEDjF51lbPdFbSTdtKnYDJe3bi49z
         HEdjA9fmvjxIv9m2vCLCmsz7H6ZD+ixW5RTucdXqj8nak9ZZl5Ra/dU9HxJrqjt1fx3v
         5Uc6+JFwsR2u575L2MXyGO88rbRgDz78wJEGc2KS0sgSp02IBTsoU+HrrDclIL7UUzD5
         yPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uYlLNN0UyKBRIab8OLOITLg387YzzBqmIZv+ipj1Bk=;
        b=pGW5E4bgiWSYARgIlfZZ6VFUxQE9x72APL/vhzIzCN8/fQz0q03mhSUvqggLap7aST
         8TKbgJGAEgV1K0NVNE0aJid5clKniFTl7QLjHeofncwDmo3MvCair/ZSspZxlmn8Wf1L
         jZC4oezYZGb8wM2DrFmolJb+G1CNbH7R8EBf7ZIyrfRkBQT4Nlb6XTAaTsnz2Q0m7kTD
         5KQ2GX8NW6rGIe+uED5s2PdtwfwRJCgA6HdIcAcEco7G+dH+OKGicgS6oPrU5WMT1hqr
         ZOib0so+/fYvwsBKXmas0PblvxjLfKi80rc1Ti2WJjz43WfqTDeXfF+fwf0BiQ123ZyQ
         Eshg==
X-Gm-Message-State: AOAM532D4VR+4Hx9z3PsIrhsiB8Dte6d3JQRG+l2W0Y+7KQa0cMKQtPJ
        BteJNQwnHxc6sb+Rnn2p6Z5o2Q==
X-Google-Smtp-Source: ABdhPJzGL4YEJnZLHDs2gCK48wqeWdvZlE8nmVrQmjPTUaQ1EXFV5sqoz+sP/iUjbWjWIJ3lhJr+wg==
X-Received: by 2002:aed:2b86:: with SMTP id e6mr25582795qtd.86.1600312955087;
        Wed, 16 Sep 2020 20:22:35 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id g45sm21370801qtb.60.2020.09.16.20.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 20:22:34 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lukasz.luba@arm.com, amitk@kernel.org
Subject: [PATCH RFC 8/8] soc:qcom:qcom_aoss: Change cooling_device_register to warming_device_register
Date:   Wed, 16 Sep 2020 23:22:26 -0400
Message-Id: <20200917032226.820371-9-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917032226.820371-1-thara.gopinath@linaro.org>
References: <20200917032226.820371-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always on subsystem host resources cx and ebi that are used as warming
devices. Use the newly introduce _warming_device_register to register
these devices with the thermal framework.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/soc/qcom/qcom_aoss.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index ed2c687c16b3..4f65c03a5def 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -461,7 +461,7 @@ static int qmp_cooling_device_add(struct qmp *qmp,
 	qmp_cdev->qmp = qmp;
 	qmp_cdev->state = !qmp_cdev_max_state;
 	qmp_cdev->name = cdev_name;
-	qmp_cdev->cdev = devm_thermal_of_cooling_device_register
+	qmp_cdev->cdev = devm_thermal_of_warming_device_register
 				(qmp->dev, node,
 				cdev_name,
 				qmp_cdev, &qmp_cooling_device_ops);
@@ -501,7 +501,7 @@ static int qmp_cooling_devices_register(struct qmp *qmp)
 
 unroll:
 	while (--count >= 0)
-		thermal_cooling_device_unregister
+		thermal_warming_device_unregister
 			(qmp->cooling_devs[count].cdev);
 
 	return ret;
@@ -512,7 +512,7 @@ static void qmp_cooling_devices_remove(struct qmp *qmp)
 	int i;
 
 	for (i = 0; i < QMP_NUM_COOLING_RESOURCES; i++)
-		thermal_cooling_device_unregister(qmp->cooling_devs[i].cdev);
+		thermal_warming_device_unregister(qmp->cooling_devs[i].cdev);
 }
 
 static int qmp_probe(struct platform_device *pdev)
-- 
2.25.1

