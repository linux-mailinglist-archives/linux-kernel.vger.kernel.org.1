Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E7E2783FA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgIYJ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbgIYJ2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:28:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E8DC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:28:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so2792021wrx.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+lQmvGIW34Fed8sffLC/RmBoE8wLwQ9s9GB7PfHXuY=;
        b=LNznKUHScZpcbVBxTTF2/ypBWXKkc8wBM9UV9nb/DgTkEiwfxUYkczzbFEG8RkMWUX
         lP7MurZarRW7M0/dXDSmFrlZhe1Ow6Caz+Jl/Sj7Inx/i4+1hi22xwa+2ynB+3SA73T5
         H/k7KNVtHyZNypCILFyhsCfPg9YgGLgyhZR21ACLyCTSiRDpF8+t2UDq7rtoMN4lHBba
         7MqHRMod7qyO8iI7qB3pm8cmNMsnLiYwCp33yHv20vFnw9XjNZ3TMN8BDuNU8E7f3S1K
         mrUDYXOL9gQDlj0b+vQC7r9OgRLAMvs6dlRH/ngDAzh5stAiNr9I5z6MqTpJSmhSBC6F
         05Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+lQmvGIW34Fed8sffLC/RmBoE8wLwQ9s9GB7PfHXuY=;
        b=CWsvwvTX4vgMxZfZuQcV0fI3e2pmCyBetQgs+rQv+cAhOEBjwokcVgfIxKqcDvf+Oi
         Zb3gsoW1udCw0n55Lzr6h2pGpBGviD+GZb1U+xQcoNTlqCkLdr/b1kINpQaHuvrWTCcU
         +YkPRIsK9PiCQp0Beb9AOiMnALy2wC51Q3GV4FzDs+iVbDIC1YzNkpSNztSu3IbefTWy
         dEKRsp8JwGBlpBh8l+zxVm6Q2ZJPYWdoiWSrXJhTe2FCL9aYyx9eXVhr+0epA8VuZ9zi
         iqpiFpzPUrTZpwmH2ksfxThP+aiRaLsYks3XYoN/ASZgnl1Ha9mUpqhrzUMWJr/puEhG
         D8gA==
X-Gm-Message-State: AOAM530MOoZUfrunpCMVuAsylBQfaOX29+UdCUH9p/ruyChHj0nitYHo
        vp4glU2ou5+tVTfM2LMdqMLVWA==
X-Google-Smtp-Source: ABdhPJwe0tGhwlRBHQfo0XPNmflmh1mkrdlaabZjOOBmINRUpSzPw9GJzqrYNZkjHavFfPXH6KD/cQ==
X-Received: by 2002:adf:9e06:: with SMTP id u6mr3515710wre.208.1601026115714;
        Fri, 25 Sep 2020 02:28:35 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n2sm2366859wma.29.2020.09.25.02.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 02:28:35 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, srivasam@codeaurora.org,
        rohitkr@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] ASoC: lpass-platform: use devm_regmap_field_bulk_alloc
Date:   Fri, 25 Sep 2020 10:28:04 +0100
Message-Id: <20200925092804.23536-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200925092804.23536-1-srinivas.kandagatla@linaro.org>
References: <20200925092804.23536-1-srinivas.kandagatla@linaro.org>
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

