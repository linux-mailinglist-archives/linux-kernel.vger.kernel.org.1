Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E332A3297
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 19:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgKBSL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 13:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgKBSLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:11:52 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FFDC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 10:11:52 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id t14so11493233pgg.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 10:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=65bWdgXbJUHSY9klg8B4g7EQCn2RPfl2U/2hJDHKOAE=;
        b=U5rpbbu/Wrv4XZAFMnegfITISy/o8wRmSAZfJOKn2097owuIhcuSadcJxcjRhHssNw
         uWobnKuds82uuRwIxhpeoRAIUz/L2h8mFs0pBKxMQMw3/H0kbLH/uzvxxw0BdJvQxvgt
         ubiXu+AQ4Ylqn8AHKEJgXa96iJHyoSqCZU0rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=65bWdgXbJUHSY9klg8B4g7EQCn2RPfl2U/2hJDHKOAE=;
        b=EuBq0JH/YPvjw1RU2V3Y2gg76bYu6gD51sp7gZUOphdCw6xmz6Awej3sbLgveB5u49
         L8pRyDg8liu+nMRbkMaioYFYy/gYC+43IIqVtCV3cn3F/WI8ALC8EzJC+YM/k+pz74zm
         sKeL35+vtHWG+lNUEhdoF9ZicpwBbdiAiXAJVpoXg/H1A77SY3JB5TnSelkWKBdijlPM
         elUGQlzWbNNyMFX4iITeK19KrgGBWRJwa0sfG5lgE+dfa72QnHaw+0hpT50fQq+hh4dm
         RDlI3b67ZOuOPwrb1KiP/TbBipJnLRBCnR3Y0OT1Zx4M6iGncUcVJN+NdBDBHhjHM0OL
         9iuQ==
X-Gm-Message-State: AOAM533xQEM6NdTrNvDcBcGbPtQZnjyH9bbCW7tTQwGGBdWKfEzHY1Rp
        1YBhsJxBZY4szNdavIpyVqhalQ==
X-Google-Smtp-Source: ABdhPJyiqLw//JRe3xdwfiASEB6IO86bTA3ip32CFqcGAv0wzGc0q3Li+IksqOKphIfp6NeiyysU1w==
X-Received: by 2002:a62:d44b:0:b029:162:67f0:3c56 with SMTP id u11-20020a62d44b0000b029016267f03c56mr22037823pfl.55.1604340711929;
        Mon, 02 Nov 2020 10:11:51 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id b17sm13175640pgb.94.2020.11.02.10.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:11:51 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH v3 4/4] drm/bridge: ti-sn65dsi86: Update reply on aux failures
Date:   Mon,  2 Nov 2020 10:11:44 -0800
Message-Id: <20201102181144.3469197-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201102181144.3469197-1-swboyd@chromium.org>
References: <20201102181144.3469197-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should be setting the drm_dp_aux_msg::reply field if a NACK or a
SHORT reply happens. Update the error bit handling logic in
ti_sn_aux_transfer() to handle these cases and notify upper layers that
such errors have happened. This helps the retry logic understand that a
timeout has happened, or to shorten the read length if the panel isn't
able to handle the longest read possible.

Note: I don't have any hardware that exhibits these code paths so this
is written based on reading the datasheet for this bridge and inspecting
the code and how this is called.

Changes in v2:
 - Move WRITE_STATUS_UPDATE check from case to assignment

Changes in v2:
 - Handle WRITE_STATUS_UPDATE properly

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Sean Paul <seanpaul@chromium.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 35 +++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 6b6e98ca2881..3a758c706b70 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -861,7 +861,7 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 				  struct drm_dp_aux_msg *msg)
 {
 	struct ti_sn_bridge *pdata = aux_to_ti_sn_bridge(aux);
-	u32 request = msg->request & ~DP_AUX_I2C_MOT;
+	u32 request = msg->request & ~(DP_AUX_I2C_MOT | DP_AUX_I2C_WRITE_STATUS_UPDATE);
 	u32 request_val = AUX_CMD_REQ(msg->request);
 	u8 *buf = msg->buffer;
 	unsigned int len = msg->size;
@@ -878,6 +878,8 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 	case DP_AUX_NATIVE_READ:
 	case DP_AUX_I2C_READ:
 		regmap_write(pdata->regmap, SN_AUX_CMD_REG, request_val);
+		/* Assume it's good */
+		msg->reply = 0;
 		break;
 	default:
 		return -EINVAL;
@@ -909,10 +911,33 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 	ret = regmap_read(pdata->regmap, SN_AUX_CMD_STATUS_REG, &val);
 	if (ret)
 		return ret;
-	else if ((val & AUX_IRQ_STATUS_NAT_I2C_FAIL)
-		 || (val & AUX_IRQ_STATUS_AUX_RPLY_TOUT)
-		 || (val & AUX_IRQ_STATUS_AUX_SHORT))
-		return -ENXIO;
+
+	if (val & AUX_IRQ_STATUS_AUX_RPLY_TOUT) {
+		/*
+		 * The hardware tried the message seven times per the DP spec
+		 * but it hit a timeout. We ignore defers here because they're
+		 * handled in hardware.
+		 */
+		return -ETIMEDOUT;
+	}
+
+	if (val & AUX_IRQ_STATUS_AUX_SHORT) {
+		ret = regmap_read(pdata->regmap, SN_AUX_LENGTH_REG, &len);
+		if (ret)
+			return ret;
+	} else if (val & AUX_IRQ_STATUS_NAT_I2C_FAIL) {
+		switch (request) {
+		case DP_AUX_I2C_WRITE:
+		case DP_AUX_I2C_READ:
+			msg->reply |= DP_AUX_I2C_REPLY_NACK;
+			break;
+		case DP_AUX_NATIVE_READ:
+		case DP_AUX_NATIVE_WRITE:
+			msg->reply |= DP_AUX_NATIVE_REPLY_NACK;
+			break;
+		}
+		return 0;
+	}
 
 	if (request == DP_AUX_NATIVE_WRITE || request == DP_AUX_I2C_WRITE ||
 	    len == 0)
-- 
Sent by a computer, using git, on the internet

