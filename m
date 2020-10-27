Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C2929AA61
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899056AbgJ0LPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:15:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51639 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897016AbgJ0LPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:15:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id v5so984351wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 04:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xbK4gaQOq/bUIpGKsNMyOlQPjutx0rk45ygjxEisbnA=;
        b=G2kdLdWgqqNpX0bHSEyClwKPVbiN9Z601TcVF7VcvFRhmiVDqZOmtqpHktu3xjNwAP
         XHVevvLEQN6Jt2NnsNo84o4wnVn2Pn4NxO/fDLFoeXvT5xkf2RGqmKUGh5q4K6h4hB1M
         96lC7xaRcuDWtmw2bKiyG/cpk9fPQ1Iu6QoQvE1MIET5pZb6qDXa5IKAomYqTs4Vi9WE
         QaeziN7lJuAhErao83OxwprCQkLRi/jH4F7d8ToTKJwggdzaqrIQpT+5TV+tU6V/Jhvy
         JGad2ozTs2IxBhz64xb+neNRrvFp0TTjK7/LWA1ukC1bT6ooiMEzLOzfloh8M11HzvPS
         4utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xbK4gaQOq/bUIpGKsNMyOlQPjutx0rk45ygjxEisbnA=;
        b=jTvsm1txGDxim12wdZ0491PII1pkKY/M5l3mK89aSbpEjVJicj8CCW0jqsvTNzisRZ
         edvDiop2yEBE2FCgeuQ1Ifc4yv5EMMpQTHkR97Wl2GanG7cCDEwz3ZWe8goNMocY9MWu
         QBJqPc/am4fSIp6lzI42SEgfbcBdWitiBjGXnu4h97Pp14x1efx8xzGxMifuz+mpHaZJ
         XNDy+Z4gLI4gysiIy2wI+NXQDdjQvZ/UC9qQG4TS90tik1Zez5IQMFiBxYP5e0gpOCAP
         bDMRLUG1htmmc64WrBnLlL5MCuB3Mal4gStXhx+6bNGMXD/1vS2Po0SANs6jDfWISFf8
         yLZA==
X-Gm-Message-State: AOAM533eXbbX2JPkwD9BD7IYqXJITeLvg8P9uRztCUGmNreX+ZqRE00G
        p5pDLdj+ojhBkjx259iaQE2y2A==
X-Google-Smtp-Source: ABdhPJwl1KRQS9vpklnvJ9uNX3G3YrMEoK/TYMxOg2TsH6GhK+eMJXROXcnfkF+Z4VlwIoXFqroUNQ==
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr2267889wmi.140.1603797335725;
        Tue, 27 Oct 2020 04:15:35 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t62sm1495432wmf.22.2020.10.27.04.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 04:15:34 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] ASoC: qcom: qdsp6: make use of devm_of_platform_populate
Date:   Tue, 27 Oct 2020 11:15:26 +0000
Message-Id: <20201027111526.12326-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make use of devm_of_platform_populate to remove some redundant code!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1: rebased on top of sound-next

 sound/soc/qcom/qdsp6/q6adm.c | 10 +---------
 sound/soc/qcom/qdsp6/q6afe.c | 10 +---------
 sound/soc/qcom/qdsp6/q6asm.c | 10 +---------
 3 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index 72f29720398c..1855b805eba2 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -601,14 +601,7 @@ static int q6adm_probe(struct apr_device *adev)
 	INIT_LIST_HEAD(&adm->copps_list);
 	spin_lock_init(&adm->copps_list_lock);
 
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
-}
-
-static int q6adm_remove(struct apr_device *adev)
-{
-	of_platform_depopulate(&adev->dev);
-
-	return 0;
+	return devm_of_platform_populate(dev);
 }
 
 #ifdef CONFIG_OF
@@ -621,7 +614,6 @@ MODULE_DEVICE_TABLE(of, q6adm_device_id);
 
 static struct apr_driver qcom_q6adm_driver = {
 	.probe = q6adm_probe,
-	.remove = q6adm_remove,
 	.callback = q6adm_callback,
 	.driver = {
 		.name = "qcom-q6adm",
diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 0ca1e4aae518..daa58b5f941e 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -1740,14 +1740,7 @@ static int q6afe_probe(struct apr_device *adev)
 
 	dev_set_drvdata(dev, afe);
 
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
-}
-
-static int q6afe_remove(struct apr_device *adev)
-{
-	of_platform_depopulate(&adev->dev);
-
-	return 0;
+	return devm_of_platform_populate(dev);
 }
 
 #ifdef CONFIG_OF
@@ -1760,7 +1753,6 @@ MODULE_DEVICE_TABLE(of, q6afe_device_id);
 
 static struct apr_driver qcom_q6afe_driver = {
 	.probe = q6afe_probe,
-	.remove = q6afe_remove,
 	.callback = q6afe_callback,
 	.driver = {
 		.name = "qcom-q6afe",
diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index c547c560cb24..a6618efe22f2 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -1727,14 +1727,7 @@ static int q6asm_probe(struct apr_device *adev)
 	spin_lock_init(&q6asm->slock);
 	dev_set_drvdata(dev, q6asm);
 
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
-}
-
-static int q6asm_remove(struct apr_device *adev)
-{
-	of_platform_depopulate(&adev->dev);
-
-	return 0;
+	return devm_of_platform_populate(dev);
 }
 
 #ifdef CONFIG_OF
@@ -1747,7 +1740,6 @@ MODULE_DEVICE_TABLE(of, q6asm_device_id);
 
 static struct apr_driver qcom_q6asm_driver = {
 	.probe = q6asm_probe,
-	.remove = q6asm_remove,
 	.callback = q6asm_srvc_callback,
 	.driver = {
 		.name = "qcom-q6asm",
-- 
2.21.0

