Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41C62A8182
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbgKEOwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731504AbgKEOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:52:31 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE94C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:52:30 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id n18so2096520wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rDbLk2JBRogslz/zoVgvVt10s2+/czAleqnbZF2PqCo=;
        b=GMWyFQ8DSD9byB9lddD/NyUUDqnEAbCbwAp0QAL61+0zBB45uUHwL8q4EDB8BuAAPn
         LQ577k4iflbvlAV0dzpguwoJ66yfIQ/YL0JdHZsm228lZVGpFv9vCCtjKk0Uu4QgBGIY
         n31UkVlb0RTvBCsfV1BL3t72WjAUYYUAasCYzceDyKYsl51RKexB49kUHCpteFFyKmnx
         /1z7S6EQgCudi7WRWd8ZXIl7NCwoqHJ1LbAT/tABZGCvU2bOmnckTynv0+WMyKHoFMph
         4fgVEyqsunNnBgJnRD9zNsJTwPCyrbL614n1ajhMjj52Q4uu5i6z3pq1NWixK4gt9xet
         KzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rDbLk2JBRogslz/zoVgvVt10s2+/czAleqnbZF2PqCo=;
        b=KfzzIOkAMTcXM8nnlpGj+h8PZtb2FaJOyFmOzfNcBPAAB/thsx9zsvgpl+7tZwuG7U
         BFMjJeuYPR0+bDhThCt36C8+q0Dbdu3rqxqxwt18UzMhuA+HSzNW0qJZPnXr9kphAl8K
         trsJZqwnQ1NmsX1JWc6lcusohVWV+uAXCjVi6lgxy46E7Cc5fxGr6McvJ/EG7X66jghL
         AFfE+Z++KtCRNt3xzYl0kW9jeDlTctA4FPNesp0pKUPplvj7jXtNMoLxTMRE2Avfv2qU
         tkGyRridRAk2N7tG9eh+AmlOFq0R5CbJG5Qz7Hd5zewvoZJWjIbcGrlHtJHPdkQLbsh2
         iwWA==
X-Gm-Message-State: AOAM532ssxDCLWY+3asAkZ8zZCy1U9piaWJ53a7BJ08WciXswgDBvvIv
        wkI8oVmKAjSpjiOw4PmVjMyZCw==
X-Google-Smtp-Source: ABdhPJyGT71xib6DJdiI22PqqtneEPs2v/oITwMrzyxOxfCyY+tQfjZPt0a48UrqUZedobkzXWBqrA==
X-Received: by 2002:adf:e94b:: with SMTP id m11mr3380925wrn.35.1604587949674;
        Thu, 05 Nov 2020 06:52:29 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f5sm2631243wmh.16.2020.11.05.06.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:52:28 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jason Yan <yanaijie@huawei.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jingoo Han <jg1.han@samsung.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 12/19] gpu: drm: bridge: analogix: analogix_dp_reg: Remove unused function 'analogix_dp_write_byte_to_dpcd'
Date:   Thu,  5 Nov 2020 14:45:10 +0000
Message-Id: <20201105144517.1826692-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105144517.1826692-1-lee.jones@linaro.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c:571:5: warning: no previous prototype for ‘analogix_dp_write_byte_to_dpcd’ [-Wmissing-prototypes]

Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jason Yan <yanaijie@huawei.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 44 -------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index fafb4b492ea04..9ce45c757f8c8 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -568,50 +568,6 @@ static int analogix_dp_start_aux_transaction(struct analogix_dp_device *dp)
 	return retval;
 }
 
-int analogix_dp_write_byte_to_dpcd(struct analogix_dp_device *dp,
-				   unsigned int reg_addr,
-				   unsigned char data)
-{
-	u32 reg;
-	int i;
-	int retval;
-
-	for (i = 0; i < 3; i++) {
-		/* Clear AUX CH data buffer */
-		reg = BUF_CLR;
-		writel(reg, dp->reg_base + ANALOGIX_DP_BUFFER_DATA_CTL);
-
-		/* Select DPCD device address */
-		reg = AUX_ADDR_7_0(reg_addr);
-		writel(reg, dp->reg_base + ANALOGIX_DP_AUX_ADDR_7_0);
-		reg = AUX_ADDR_15_8(reg_addr);
-		writel(reg, dp->reg_base + ANALOGIX_DP_AUX_ADDR_15_8);
-		reg = AUX_ADDR_19_16(reg_addr);
-		writel(reg, dp->reg_base + ANALOGIX_DP_AUX_ADDR_19_16);
-
-		/* Write data buffer */
-		reg = (unsigned int)data;
-		writel(reg, dp->reg_base + ANALOGIX_DP_BUF_DATA_0);
-
-		/*
-		 * Set DisplayPort transaction and write 1 byte
-		 * If bit 3 is 1, DisplayPort transaction.
-		 * If Bit 3 is 0, I2C transaction.
-		 */
-		reg = AUX_TX_COMM_DP_TRANSACTION | AUX_TX_COMM_WRITE;
-		writel(reg, dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_1);
-
-		/* Start AUX transaction */
-		retval = analogix_dp_start_aux_transaction(dp);
-		if (retval == 0)
-			break;
-
-		dev_dbg(dp->dev, "%s: Aux Transaction fail!\n", __func__);
-	}
-
-	return retval;
-}
-
 void analogix_dp_set_link_bandwidth(struct analogix_dp_device *dp, u32 bwtype)
 {
 	u32 reg;
-- 
2.25.1

