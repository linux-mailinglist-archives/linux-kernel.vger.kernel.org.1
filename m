Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0267278F08
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbgIYQtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbgIYQtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:49:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B36C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:49:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c18so4310209wrm.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+lQmvGIW34Fed8sffLC/RmBoE8wLwQ9s9GB7PfHXuY=;
        b=M/XtpBobcAIos+IdHsIK68CgjPPg2rsTajJNuovI45M/2jPmSRHobGneHaX9YLNRP3
         pTCMj+z1dh3MXU4NBXKht0kqjDD29ym7UXPVGQop6w+sq427UZstFfc+2nmCE1NtwCPy
         Y6vmo6TRTuFHeG+0gQX2OFxHS8IetqimALxKatB+YUMcPKNiN/D1RJY0kK4lRjEKK325
         lZm5ryF8uY6UFRGrmI510cJm2MLnhVyN9v0A1rrePF9aC+OQpzZN6HJOt2/AEPiYx/5x
         qeyqEKi3qiOt7qhb0EJQAWdtBN043nHeA928CHBkxLNnoeWx68GtBUUMnoPa/Cqr8dEV
         3k1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+lQmvGIW34Fed8sffLC/RmBoE8wLwQ9s9GB7PfHXuY=;
        b=hTuUFoCcD37ssEXuKKmOuiRk76IKJRCE60NFO9mWo0Bh5TgY6C2ADOO++fn0O4H4sK
         C53Cl6EFcdBAXAQTRzd3Zgs31zAIodnvVNHzxAPVjRekB9Z+cZrMzK7XzQeDnKnSIaYR
         Z1DXvFvzce6FrHmDWnJJU67VrlPpLLdOxzpTkQ7UvRvD8Sj6qKKsIOwEISD8JZhBlhRe
         S5f++J0jPbPHLr/02dzxyfoMPDsFSxRjcVUh7WWMVhGdUhqt5H4GqB0pP7ltGb4flX1J
         6dEcTCGucaQBkdE/bh3tCDeVPhOW4Aw4jZBpdtsgXPW1oZ7ly06PlCis6L8lsnigFP95
         QpMg==
X-Gm-Message-State: AOAM531fhbnyRrOhSUm/uAuF5qmzmjlpMIXmruDnN2HKrS2xqWxLB4F5
        H4A8rfnkMmxkHxPUY/NQNK+VXA==
X-Google-Smtp-Source: ABdhPJx/JB5PBClWY2jrtfogYCCMqfSI3zpnGS+eBAJ/wTTG6XHNczADwF1DBHMnRE49dlurlJ67xg==
X-Received: by 2002:a5d:4a0e:: with SMTP id m14mr5799478wrq.313.1601052548481;
        Fri, 25 Sep 2020 09:49:08 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id a5sm3604247wrp.37.2020.09.25.09.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 09:49:07 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, srivasam@codeaurora.org,
        rohitkr@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/2] ASoC: lpass-platform: use devm_regmap_field_bulk_alloc
Date:   Fri, 25 Sep 2020 17:48:56 +0100
Message-Id: <20200925164856.10315-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200925164856.10315-1-srinivas.kandagatla@linaro.org>
References: <20200925164856.10315-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use new devm_regmap_field_bulk_alloc to allocate fields as
it make the code more readable!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
 sound/soc/qcom/lpass-platform.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index df692ed95503..7ac26290082f 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -56,6 +56,7 @@ static int lpass_platform_alloc_dmactl_fields(struct device *dev,
 	struct lpass_data *drvdata = dev_get_drvdata(dev);
 	struct lpass_variant *v = drvdata->variant;
 	struct lpaif_dmactl *rd_dmactl, *wr_dmactl;
+	int rval;
 
 	drvdata->rd_dmactl = devm_kzalloc(dev, sizeof(struct lpaif_dmactl),
 					  GFP_KERNEL);
@@ -70,31 +71,13 @@ static int lpass_platform_alloc_dmactl_fields(struct device *dev,
 	rd_dmactl = drvdata->rd_dmactl;
 	wr_dmactl = drvdata->wr_dmactl;
 
-	rd_dmactl->bursten = devm_regmap_field_alloc(dev, map, v->rdma_bursten);
-	rd_dmactl->wpscnt = devm_regmap_field_alloc(dev, map, v->rdma_wpscnt);
-	rd_dmactl->fifowm = devm_regmap_field_alloc(dev, map, v->rdma_fifowm);
-	rd_dmactl->intf = devm_regmap_field_alloc(dev, map, v->rdma_intf);
-	rd_dmactl->enable = devm_regmap_field_alloc(dev, map, v->rdma_enable);
-	rd_dmactl->dyncclk = devm_regmap_field_alloc(dev, map, v->rdma_dyncclk);
+	rval = devm_regmap_field_bulk_alloc(dev, map, &rd_dmactl->bursten,
+					    &v->rdma_bursten, 6);
+	if (rval)
+		return rval;
 
-	if (IS_ERR(rd_dmactl->bursten) || IS_ERR(rd_dmactl->wpscnt) ||
-	    IS_ERR(rd_dmactl->fifowm) || IS_ERR(rd_dmactl->intf) ||
-	    IS_ERR(rd_dmactl->enable) || IS_ERR(rd_dmactl->dyncclk))
-		return -EINVAL;
-
-	wr_dmactl->bursten = devm_regmap_field_alloc(dev, map, v->wrdma_bursten);
-	wr_dmactl->wpscnt = devm_regmap_field_alloc(dev, map, v->wrdma_wpscnt);
-	wr_dmactl->fifowm = devm_regmap_field_alloc(dev, map, v->wrdma_fifowm);
-	wr_dmactl->intf = devm_regmap_field_alloc(dev, map, v->wrdma_intf);
-	wr_dmactl->enable = devm_regmap_field_alloc(dev, map, v->wrdma_enable);
-	wr_dmactl->dyncclk = devm_regmap_field_alloc(dev, map, v->wrdma_dyncclk);
-
-	if (IS_ERR(wr_dmactl->bursten) || IS_ERR(wr_dmactl->wpscnt) ||
-	    IS_ERR(wr_dmactl->fifowm) || IS_ERR(wr_dmactl->intf) ||
-	    IS_ERR(wr_dmactl->enable) || IS_ERR(wr_dmactl->dyncclk))
-		return -EINVAL;
-
-	return 0;
+	return devm_regmap_field_bulk_alloc(dev, map, &wr_dmactl->bursten,
+					    &v->wrdma_bursten, 6);
 }
 
 static int lpass_platform_pcmops_open(struct snd_soc_component *component,
-- 
2.21.0

