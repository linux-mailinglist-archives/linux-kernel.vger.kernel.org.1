Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EDB2A8183
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbgKEOwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731478AbgKEOwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:52:39 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8063FC061A4A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:52:39 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b8so2104847wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ohyBbiMl4QAk0hhVQhX7OOzIoCPrYd9chXW0LdTWwg=;
        b=XBW8xFz25wrZDDaO9F9vfOL8x0OhOhpJq3zGD2BEffVr94ia5p8vCiGc1dDvydPk8G
         NDrGwM8qHJIWF+YyN3+pqM04QpTovwtHRwYaY+CB0lm71Gm7e96ItZi/WAkO9B1ijRbJ
         D3zSToxMNbprGNAI1QfIFaElECUMP9+zGdyTDLypSReTAwazDqv05F15HG1XUa+Dn15J
         cMuSKGY3lupgIXoi2hTrHUZpaqPt6dZAhP+Pq/Rx2olZZEtgk11RkFZCZLK2f05T1Vk0
         8wHSBFUOFm63LhPsJnl9L2OhDl4kuTp5kTmGF7uaGIC/XEBoHlD+C41OVq0tg4j7E+K+
         CcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ohyBbiMl4QAk0hhVQhX7OOzIoCPrYd9chXW0LdTWwg=;
        b=jHJp/tBoaJ+tPWWQsFnA2Tgto8zLHfKh7bcyRralFtgpZ6t6ax7hadl7GuPMAoBv+k
         3h0iYW7jaAIt/wdYoHxrWqvkCiB+Va3NVAkU/FgXSZtnPPX5d9Cobhf2Dq0+Khc8IoSS
         lQrBp4YLa44OAtj8Av4bCPOhL2Jrs/jWPAn9KGEPWHP7ozGdKmjJ08Ip3/BhDJWGZPiv
         UtVL2Qh+3MZJfMN/BQmBKEQDw8PDzfhPeKbQe1MPlzUyjcTiwxn78SSB79T/ktHLwtOi
         mZ70VIHgglDo857hSNGJv/5VJzs+C0pCkHDG/n7QxLJXMoJiIvGkPFAoHB/WYDh6ZS3M
         1QYA==
X-Gm-Message-State: AOAM53156UDa0YPaZL2uF4AnT89AeYS6t+oV0ajWHjscZ12v8et8qe3l
        cW/3k4jc9Q6pkSH4/mjdTbKnVA==
X-Google-Smtp-Source: ABdhPJy1zJUpgVBLvXfGwyfP/DxiTdsE/xHFzIPHRB2Y83e58sQ2ACFhophmTpm4Om/fUXHn2r43dQ==
X-Received: by 2002:adf:fe46:: with SMTP id m6mr3113804wrs.254.1604587958250;
        Thu, 05 Nov 2020 06:52:38 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f5sm2631243wmh.16.2020.11.05.06.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:52:37 -0800 (PST)
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
        Jingoo Han <jg1.han@samsung.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 19/19] gpu: drm: bridge: analogix: analogix_dp_reg: Remove unused function 'analogix_dp_start_aux_transaction'
Date:   Thu,  5 Nov 2020 14:45:17 +0000
Message-Id: <20201105144517.1826692-20-lee.jones@linaro.org>
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

 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c:527:12: warning: ‘analogix_dp_start_aux_transaction’ defined but not used [-Wunused-function]

Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jason Yan <yanaijie@huawei.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 44 -------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 9ce45c757f8c8..cab6c8b92efd4 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -524,50 +524,6 @@ void analogix_dp_enable_sw_function(struct analogix_dp_device *dp)
 	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_1);
 }
 
-static int analogix_dp_start_aux_transaction(struct analogix_dp_device *dp)
-{
-	int reg;
-	int retval = 0;
-	int timeout_loop = 0;
-
-	/* Enable AUX CH operation */
-	reg = readl(dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_2);
-	reg |= AUX_EN;
-	writel(reg, dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_2);
-
-	/* Is AUX CH command reply received? */
-	reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA);
-	while (!(reg & RPLY_RECEIV)) {
-		timeout_loop++;
-		if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
-			dev_err(dp->dev, "AUX CH command reply failed!\n");
-			return -ETIMEDOUT;
-		}
-		reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA);
-		usleep_range(10, 11);
-	}
-
-	/* Clear interrupt source for AUX CH command reply */
-	writel(RPLY_RECEIV, dp->reg_base + ANALOGIX_DP_INT_STA);
-
-	/* Clear interrupt source for AUX CH access error */
-	reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA);
-	if (reg & AUX_ERR) {
-		writel(AUX_ERR, dp->reg_base + ANALOGIX_DP_INT_STA);
-		return -EREMOTEIO;
-	}
-
-	/* Check AUX CH error access status */
-	reg = readl(dp->reg_base + ANALOGIX_DP_AUX_CH_STA);
-	if ((reg & AUX_STATUS_MASK) != 0) {
-		dev_err(dp->dev, "AUX CH error happens: %d\n\n",
-			reg & AUX_STATUS_MASK);
-		return -EREMOTEIO;
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

