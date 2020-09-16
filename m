Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0A926C9C1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgIPTWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbgIPTTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:19:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABF7C06121E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:58 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k15so4523668pfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oe49LMKwv41Q/rKpDAMKCy8PmysOJZGeIA2wNQPMFDo=;
        b=k1qCnGcV5ydKrYSZmb7z6t2rf8NDhB199Q+CTrqhlDFZH1YPgkXkqdcpHFUUMmFZB2
         nhHFszfE//oADI2Sw4apMJE43ezjbPXDFOSqMKV1tVsDWi21ugWht5ff3u12bcaMI+6/
         gKwT/4ikJcrErNs8nJDnc/0BGa1jVMx5GqFC5UCkfiMj/OTRXgkyY0erUNFP2t6Ful5I
         G46dXB435jwkzFyT7iIb/wnTkDJHrtgI3kNHCmCl8lgAplNoM+u4lgjCX7WrMk8LgJYp
         CSkJ3xoPSXG5ph1DGvftMQa6B/pQ4TFw5+sxZz/tDOGsJ89AT1CbFS3M1cGBoWJez54+
         iqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oe49LMKwv41Q/rKpDAMKCy8PmysOJZGeIA2wNQPMFDo=;
        b=fLt5hdMr8OwtWLKqiRdM/dZIcikAdv4xT7q4HjDvhL8jPjOZhkbw1534CspY7Nyhc3
         tPHpS2V/0lPXYtNKHVsRREMtCuUcRBTzqbPrVPA/Dga4W0wsU+iYAGRU25R6MNNTKP1p
         YzWKB1rVADPjpIpBO0izYy+ZTZ7y7Xm5ouYJHViYzEjsKIARqy6bVhleO/FGy+tIPsai
         AC6LQcT+FqARfEZBa4FDtxX8WP6An4X2kwzGGk6hB1xgee6EuX52RNwwr9/0Owx+BoFl
         i06ysye807z3oDaRt6ELp9WCGAQ0oZ9mNk5MwpagnsHT23evkcQtVWF3c58yiR+aAWmO
         4oGw==
X-Gm-Message-State: AOAM531pvJ5HljuJsmBHulOybRBEa0B9tx5j5qRgH2dxw1xm69Gpi3A+
        yNe7E7xf5sjF9+l6RV3fvW9Mpqrj100i8Q==
X-Google-Smtp-Source: ABdhPJz4/2EA/zzbsQeVkyxz0UVvQIol29EhFlEroXCYa/7jZJoZG06NJLqej/NQ51x9sw2Vhfh2Ig==
X-Received: by 2002:a63:3643:: with SMTP id d64mr2586988pga.207.1600283875709;
        Wed, 16 Sep 2020 12:17:55 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b2sm11373688pfp.3.2020.09.16.12.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:17:55 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/16] coresight: etm4x: Fix mis-usage of nr_resource in sysfs interface
Date:   Wed, 16 Sep 2020 13:17:36 -0600
Message-Id: <20200916191737.4001561-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
References: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Zhou <jonathan.zhouwen@huawei.com>

The member @nr_resource represents how many resource selector pairs,
and the pair 0 is always implemented and reserved.
So let's multiply by 2 when resetting the selector configuration.
And also update the validation of the input @idx.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: lizixian@hisilicon.com
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
[Fixed typographical error in changelog, added stable]
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index a588cd6de01c..989ce7b8ade7 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -236,7 +236,7 @@ static ssize_t reset_store(struct device *dev,
 	}
 
 	config->res_idx = 0x0;
-	for (i = 0; i < drvdata->nr_resource; i++)
+	for (i = 2; i < 2 * drvdata->nr_resource; i++)
 		config->res_ctrl[i] = 0x0;
 
 	config->ss_idx = 0x0;
@@ -1663,8 +1663,11 @@ static ssize_t res_idx_store(struct device *dev,
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
-	/* Resource selector pair 0 is always implemented and reserved */
-	if ((val == 0) || (val >= drvdata->nr_resource))
+	/*
+	 * Resource selector pair 0 is always implemented and reserved,
+	 * namely an idx with 0 and 1 is illegal.
+	 */
+	if ((val < 2) || (val >= 2 * drvdata->nr_resource))
 		return -EINVAL;
 
 	/*
-- 
2.25.1

