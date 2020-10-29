Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1159D29E050
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391049AbgJ2BVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730983AbgJ2BL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 21:11:58 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CC6C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 18:11:57 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id i26so976235pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 18:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ET2A4jH+uwVe3UkhuRlAn9izlrJ702A3D9TrDdaU1JA=;
        b=Nwd7P2JqMxrReBmpZimFwJHiY+/+4Y+8xLTf9/uUlhKZQCkG6eE+3O32ooXaly2nle
         96o92s/8s8avx+xtSOg9zNGtr6xkc9HxACzX15Y9vYXbskSMLoIhXsliVwOW5RN3TbQX
         8BbpShPOFvPiyuJ1XzMX7uxLV+lB47nDVyX8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ET2A4jH+uwVe3UkhuRlAn9izlrJ702A3D9TrDdaU1JA=;
        b=qbzn3HCfj1KqaHaLhkSjHN2RASCEo1rYKau1AJJKc1+x1yFazujJepdVkl7RB4nS+w
         DsTy2+MAFMbkkNYVy2BNvoYKIpUbKatTKBVHmP+0ExWaTmjnjSvYnN/HTgNa11g7ijFq
         fJMaVR7QFuO+Eic1J0Rv6KPGmAV7kiSRmF8E26l2Wxu5fWBg6d1PeEoAtB2fr2cVDxHo
         x7LUJb8H48U0f0geGaaHRbIdHbR7gmSyIOq5ln4G9+qiDLYY5HaaXu1ipFv/aNsEkcLY
         nTu7L90Zp2cky8gdlf0KDpPfJyq4QV6q9XmeyaDESRA6qTp1t0qGR1oyyf0PTbsm1o5L
         9rKw==
X-Gm-Message-State: AOAM5331IcdXe7K3pF6QBTkge/5JC6pbblb51HYDVR+uD7LnrDXBwKnQ
        YMhCD5SwzHAcGDwwvtVVscy+jw==
X-Google-Smtp-Source: ABdhPJy0r49pxAwM7OzjF2oEcWXoV8VsegRH81o1uqlPlfifg5iNAr6wd7XsBA2Ehe39hG2M8XK2tQ==
X-Received: by 2002:a17:90b:3413:: with SMTP id kg19mr1554067pjb.37.1603933917602;
        Wed, 28 Oct 2020 18:11:57 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id e6sm781769pfn.190.2020.10.28.18.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 18:11:57 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 1/4] drm/bridge: ti-sn65dsi86: Combine register accesses in ti_sn_aux_transfer()
Date:   Wed, 28 Oct 2020 18:11:51 -0700
Message-Id: <20201029011154.1515687-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201029011154.1515687-1-swboyd@chromium.org>
References: <20201029011154.1515687-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These register reads and writes are sometimes directly next to each
other in the register address space. Let's use regmap bulk read/write
APIs to get the data with one transfer instead of multiple i2c
transfers. This helps cut down on the number of transfers in the case of
something like reading an EDID where we read in blocks of 16 bytes at a
time and the last for loop here is sending an i2c transfer for each of
those 16 bytes, one at a time. Ouch!

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 50 ++++++++++++---------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index ecdf9b01340f..87726b9e446f 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -17,6 +17,8 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
+#include <asm/unaligned.h>
+
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
@@ -72,6 +74,7 @@
 #define SN_AUX_ADDR_19_16_REG			0x74
 #define SN_AUX_ADDR_15_8_REG			0x75
 #define SN_AUX_ADDR_7_0_REG			0x76
+#define SN_AUX_ADDR_MASK			GENMASK(19, 0)
 #define SN_AUX_LENGTH_REG			0x77
 #define SN_AUX_CMD_REG				0x78
 #define  AUX_CMD_SEND				BIT(0)
@@ -841,11 +844,13 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 	struct ti_sn_bridge *pdata = aux_to_ti_sn_bridge(aux);
 	u32 request = msg->request & ~DP_AUX_I2C_MOT;
 	u32 request_val = AUX_CMD_REQ(msg->request);
-	u8 *buf = (u8 *)msg->buffer;
+	u8 *buf = msg->buffer;
+	unsigned int len = msg->size;
 	unsigned int val;
-	int ret, i;
+	int ret;
+	u8 addr_len[SN_AUX_LENGTH_REG + 1 - SN_AUX_ADDR_19_16_REG];
 
-	if (msg->size > SN_AUX_MAX_PAYLOAD_BYTES)
+	if (len > SN_AUX_MAX_PAYLOAD_BYTES)
 		return -EINVAL;
 
 	switch (request) {
@@ -859,19 +864,14 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 		return -EINVAL;
 	}
 
-	regmap_write(pdata->regmap, SN_AUX_ADDR_19_16_REG,
-		     (msg->address >> 16) & 0xF);
-	regmap_write(pdata->regmap, SN_AUX_ADDR_15_8_REG,
-		     (msg->address >> 8) & 0xFF);
-	regmap_write(pdata->regmap, SN_AUX_ADDR_7_0_REG, msg->address & 0xFF);
-
-	regmap_write(pdata->regmap, SN_AUX_LENGTH_REG, msg->size);
+	BUILD_BUG_ON(sizeof(addr_len) != sizeof(__be32));
+	put_unaligned_be32((msg->address & SN_AUX_ADDR_MASK) << 8 | len,
+			   addr_len);
+	regmap_bulk_write(pdata->regmap, SN_AUX_ADDR_19_16_REG, addr_len,
+			  ARRAY_SIZE(addr_len));
 
-	if (request == DP_AUX_NATIVE_WRITE || request == DP_AUX_I2C_WRITE) {
-		for (i = 0; i < msg->size; i++)
-			regmap_write(pdata->regmap, SN_AUX_WDATA_REG(i),
-				     buf[i]);
-	}
+	if (request == DP_AUX_NATIVE_WRITE || request == DP_AUX_I2C_WRITE)
+		regmap_bulk_write(pdata->regmap, SN_AUX_WDATA_REG(0), buf, len);
 
 	/* Clear old status bits before start so we don't get confused */
 	regmap_write(pdata->regmap, SN_AUX_CMD_STATUS_REG,
@@ -895,21 +895,15 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 		 || (val & AUX_IRQ_STATUS_AUX_SHORT))
 		return -ENXIO;
 
-	if (request == DP_AUX_NATIVE_WRITE || request == DP_AUX_I2C_WRITE)
-		return msg->size;
+	if (request == DP_AUX_NATIVE_WRITE || request == DP_AUX_I2C_WRITE ||
+	    len == 0)
+		return len;
 
-	for (i = 0; i < msg->size; i++) {
-		unsigned int val;
-		ret = regmap_read(pdata->regmap, SN_AUX_RDATA_REG(i),
-				  &val);
-		if (ret)
-			return ret;
-
-		WARN_ON(val & ~0xFF);
-		buf[i] = (u8)(val & 0xFF);
-	}
+	ret = regmap_bulk_read(pdata->regmap, SN_AUX_RDATA_REG(0), buf, len);
+	if (ret)
+		return ret;
 
-	return msg->size;
+	return len;
 }
 
 static int ti_sn_bridge_parse_dsi_host(struct ti_sn_bridge *pdata)
-- 
Sent by a computer, using git, on the internet

