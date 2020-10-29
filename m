Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DBF29E03B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404290AbgJ2BME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404283AbgJ2BMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 21:12:01 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB1DC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 18:12:01 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id c20so938497pfr.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 18:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HMnyM9hnGSWiflifnZ+155XlhVa/FPrVDuXugyYPm7I=;
        b=eaokMHoEbOulnBlsExgxoDER8Sx0r9k5So0QpAhfgL05Yq8mtvqSgL5dZm/FcxPiL9
         s+BVRN4TjdtfCGAJvZDotxU047Z+xD+eDZNsKFaGHmlvdSx+uyUKRIQ1x3nTZfCGoddK
         ADWgrvvKT1A4sadDfuogByLfDXV4liA2WAXuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HMnyM9hnGSWiflifnZ+155XlhVa/FPrVDuXugyYPm7I=;
        b=oGC1m7QzkZb2hR+qqgUzUxrlKzevgNUFuTLotmVenzrQKBS/iHbx9Xkcqm86l2J7qL
         I2/M0G1c0UvIZNoguRqc0HbGWLxiRcBKVxysgldgPvSAlbQgAdLWfxjrG0p+oG35nMdp
         wCURZD0ltrGAvAbVbneI8tXBivj9IDQbsiib79+GrPUN55ZZZLK61t3+laLJ8ahrZFGs
         BYrW2GtISt45E78KNeROS0GxIWeGTdrs6AqUV0otw0eMIdzwzYJne3DR2175a3icFd9C
         z5aTnKEfh+udaEowCfHkVLet1f/LP9BZJl9W+9RC/NjP8WgA2Bh7PCQmJs2NtQwC/oEn
         iVxQ==
X-Gm-Message-State: AOAM533Hfwmy8n27rQCr1Dq0bPqnCxTrJLxCqwA8+TrwmLAyA/dVItzZ
        h5RmtsfBE577dyTFgAe+IIG83g==
X-Google-Smtp-Source: ABdhPJz4OI5ZTi5XCi0Xrzs2vkKBHMG13FV4RyD3SOjJjLNExKzToETzT21lAu3EC12RVUiN04d3xQ==
X-Received: by 2002:a62:ddd4:0:b029:155:af54:3000 with SMTP id w203-20020a62ddd40000b0290155af543000mr1673370pff.64.1603933921240;
        Wed, 28 Oct 2020 18:12:01 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id e6sm781769pfn.190.2020.10.28.18.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 18:12:00 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 4/4] drm/bridge: ti-sn65dsi86: Update reply on aux failures
Date:   Wed, 28 Oct 2020 18:11:54 -0700
Message-Id: <20201029011154.1515687-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201029011154.1515687-1-swboyd@chromium.org>
References: <20201029011154.1515687-1-swboyd@chromium.org>
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

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 31 +++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 6b6e98ca2881..19737bc01b8f 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -878,6 +878,7 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 	case DP_AUX_NATIVE_READ:
 	case DP_AUX_I2C_READ:
 		regmap_write(pdata->regmap, SN_AUX_CMD_REG, request_val);
+		msg->reply = 0; /* Assume it's good */
 		break;
 	default:
 		return -EINVAL;
@@ -909,10 +910,32 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
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

