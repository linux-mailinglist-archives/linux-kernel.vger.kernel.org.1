Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD49329FA6F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 02:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgJ3BRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 21:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgJ3BRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 21:17:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A56C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:17:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u7so97837pls.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GixG0AIp4K7aEPxnTMoVGo349E06hix+8APGiCAeVDg=;
        b=iwMP8439b+n/zanp2YSKeVm2e2FnXGqeUWQWVL6rDTBnQ6ZDMxsP46JOVZy3kVytvW
         PlBUV0FNHeHnwbMaSf6TrNY4GTuZ0jMBpg+PNxkFhORmf9Ms14sCxRlkzGfyipzDDUUc
         6eMaNyhn664iSTNGNXje17gI7xJ+vfdImlqCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GixG0AIp4K7aEPxnTMoVGo349E06hix+8APGiCAeVDg=;
        b=i/SMVUMuld2oLLjem+GwS28Lq5Q4K3/VKuxAvp0v/ti2/G4VBD04ZSn9NqL5/NTvZO
         Ds6RVm0sinfqxo/zv+U7pv0FIr2+NfAT8X68rZBL53mD1IH4lEt0rEvBL9gRSaasNCRL
         i92EEKJZZ02GaG4GEeb73ilSg10wQkSCyr6B6kOIkzuTYfhQfviJaRb+/9Ym8dJz6krA
         idkJ4yVOn3rqkSSpHq2YwXWVV3JQ3h/RhXu0FodkP+EuvjF0lDHZn+P4gxZ0OLxcwbLV
         7mnIQRFjiaZQcMM8PLTrerkof/oaNlu+QtOaYymsri7RJqBIrbUPBhk8qBnypunRCdrL
         2YcA==
X-Gm-Message-State: AOAM530xhf2DfXm3nlFQej13+PJS7OSvCWPCzBZN19LJHlojAe/+jkMl
        ETlByvr4qUe8XbsUcIxCNecegQ==
X-Google-Smtp-Source: ABdhPJxYudIQ2YVqBE67sdMqELFeQMtHqfxicmXnHIedGvx0yL8cZqg6wE6FyG3S/ifYAoRVHpQBgA==
X-Received: by 2002:a17:902:b7c2:b029:d6:f71:38d5 with SMTP id v2-20020a170902b7c2b02900d60f7138d5mr6341002plz.1.1604020665929;
        Thu, 29 Oct 2020 18:17:45 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z26sm4477854pfq.131.2020.10.29.18.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 18:17:45 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH v2 4/4] drm/bridge: ti-sn65dsi86: Update reply on aux failures
Date:   Thu, 29 Oct 2020 18:17:38 -0700
Message-Id: <20201030011738.2028313-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201030011738.2028313-1-swboyd@chromium.org>
References: <20201030011738.2028313-1-swboyd@chromium.org>
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
 - Handle WRITE_STATUS_UPDATE properly

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 36 ++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index f86934fd6cc8..984ea41deca8 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -873,10 +873,16 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 		return -EINVAL;
 
 	switch (request) {
+	case DP_AUX_I2C_WRITE_STATUS_UPDATE:
+		/* WRITE_STATUS_UPDATE only matters for request_val */
+		request &= ~DP_AUX_I2C_WRITE_STATUS_UPDATE;
+		fallthrough;
 	case DP_AUX_NATIVE_WRITE:
 	case DP_AUX_I2C_WRITE:
 	case DP_AUX_NATIVE_READ:
 	case DP_AUX_I2C_READ:
+		/* Assume it's good */
+		msg->reply = 0;
 		break;
 	default:
 		return -EINVAL;
@@ -909,10 +915,32 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
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

