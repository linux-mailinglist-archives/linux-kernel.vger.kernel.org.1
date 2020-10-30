Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE1A29FA6D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 02:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgJ3BRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 21:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ3BRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 21:17:42 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9824BC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:17:42 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id i26so3799529pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tqAoIXc3ytgAavQ+efnVkrK/RwAJKjiKat1Aft50o8c=;
        b=YQ+xc3TKk3JGEMrmowXNrRo1roNkVLWIVtCd6iDOPQPoE7gzJ94zEt3DFYcNn6ga8f
         5GUzz5MID1Ktpd8iZmDgW703z3nogfZnzgHJ6NzgLzN2lSSXzjMUuLETJL3SE+Ul4vFX
         8/8kbXdoqFGN7rZUSLY2Py9YbpXKM7yyFoO/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tqAoIXc3ytgAavQ+efnVkrK/RwAJKjiKat1Aft50o8c=;
        b=OihH3gGe8ukA9X3i8DhGZRhefkpPwbKel6/cVQ09gFHkiKWuzZ7z1j/wUy4Q8EC86y
         3cpd4mDepg2VQiC8E7yIfVNXUA9P3sUN/S3GIEBU7AzDU5PGyJEgnYjW1/5hlhmWv78v
         6Z6F7PYl9RpFQuYzK5d2TyqDL+P51ueX0lQF2dGevNC2ahnPyUCwDWkAJtLMrByYteya
         t0uVm1RqYoDhlBkaNYOPlyOL5oUFUgIAQk61+YtrCaAn0pdNqpu9tc5VVYStvBx6U9j5
         YeM1vnFxOjBnvjjvVRBEPCryw9VnLaVZwgSxWaPYtNTjyRCdaYqtac1Z3sOVio6+KKCf
         axvQ==
X-Gm-Message-State: AOAM5332Ew+obH/+iSbpu7yyPKoEbwuj448M2qeRDIljXt9+AiVM1akO
        3c5bWmR0/lP2/DLqk3Zabcq3Ig==
X-Google-Smtp-Source: ABdhPJwKkS2GJoKe+7gf2VDGU36Z2svRca3TfzmDiKNvwcs+sGEdv6Xue4Du4RbxIMDfju0gQe7LqQ==
X-Received: by 2002:a65:4cc9:: with SMTP id n9mr34656pgt.236.1604020662216;
        Thu, 29 Oct 2020 18:17:42 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z26sm4477854pfq.131.2020.10.29.18.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 18:17:41 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH v2 1/4] drm/bridge: ti-sn65dsi86: Combine register accesses in ti_sn_aux_transfer()
Date:   Thu, 29 Oct 2020 18:17:35 -0700
Message-Id: <20201030011738.2028313-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201030011738.2028313-1-swboyd@chromium.org>
References: <20201030011738.2028313-1-swboyd@chromium.org>
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

Changes in v2:
 - Combined AUX_CMD register write

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 52 ++++++++++++---------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index ecdf9b01340f..a1ebfa95088c 100644
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
+	u8 reg_buf[SN_AUX_CMD_REG + 1 - SN_AUX_ADDR_19_16_REG];
 
-	if (msg->size > SN_AUX_MAX_PAYLOAD_BYTES)
+	if (len > SN_AUX_MAX_PAYLOAD_BYTES)
 		return -EINVAL;
 
 	switch (request) {
@@ -853,25 +858,20 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 	case DP_AUX_I2C_WRITE:
 	case DP_AUX_NATIVE_READ:
 	case DP_AUX_I2C_READ:
-		regmap_write(pdata->regmap, SN_AUX_CMD_REG, request_val);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	regmap_write(pdata->regmap, SN_AUX_ADDR_19_16_REG,
-		     (msg->address >> 16) & 0xF);
-	regmap_write(pdata->regmap, SN_AUX_ADDR_15_8_REG,
-		     (msg->address >> 8) & 0xFF);
-	regmap_write(pdata->regmap, SN_AUX_ADDR_7_0_REG, msg->address & 0xFF);
-
-	regmap_write(pdata->regmap, SN_AUX_LENGTH_REG, msg->size);
+	BUILD_BUG_ON(sizeof(reg_buf) < sizeof(__be32));
+	put_unaligned_be32((msg->address & SN_AUX_ADDR_MASK) << 8 | len,
+			   reg_buf);
+	reg_buf[SN_AUX_CMD_REG - SN_AUX_ADDR_19_16_REG] = request_val;
+	regmap_bulk_write(pdata->regmap, SN_AUX_ADDR_19_16_REG, reg_buf,
+			  ARRAY_SIZE(reg_buf));
 
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

