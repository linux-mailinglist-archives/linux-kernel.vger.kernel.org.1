Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5AF29FA70
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 02:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgJ3BRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 21:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgJ3BRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 21:17:43 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C3FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:17:43 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r10so3793094pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bd9wyHuVLCFuoo+uR0VpYuko8KnuaddorUz56unAlSM=;
        b=Oe5wxWNnvQ9eFlBIuzDEJsO0w0uOadc2EQV2r7nsTQfk5AnTdC50fNEmA1X/7+fO+2
         j9UGXevXdEb9/Y1yqJCFvmM+a02Z/0tEgHEw0YKgLH7WKzWTy4pnvudB8vLUNs4NXaDe
         edxsHmzkVU5UOPtC+oWAtoJ5nLkpdGfvzzs8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bd9wyHuVLCFuoo+uR0VpYuko8KnuaddorUz56unAlSM=;
        b=fBTig52Ftsm/QaqCnULRRpg6gjK+1fGRDliGiKtlJwmfqQSErrrTVgGX+gXCqRUSQ6
         yU2VygpPtvROU/7XdawGYglLBsBvdlbR1a1Msi4faOHtKnTESKy8G7DhR2Obd4Is4/Ev
         BDhGJb5HdOyoAu+4vbmd8hBdvoA4y7L8YOuxcS8rn397t6SQjX1J/uYCddsr/9BrvI0b
         HKzayDMlfwKkN8MxkfOKQSTn/S8j7kq61q5tyTfY8juP4Yjuus61txDPa3aLRPGvNKEp
         ju6eR9L3gYWUlL7Ma63MrYCVeZhvyVct9pJw6K/ZnEO3IPfxLFnQXKo6nTg1bEAvl4Oc
         yb1Q==
X-Gm-Message-State: AOAM533Hp+XTfzw3MnZMGkz1iBRUGiaAgpk2mTxBWs7NiABalPKFNm7i
        yr5aaMJ97fcZclXxgkFlWofb0g==
X-Google-Smtp-Source: ABdhPJwZNGBc2+B0BGbpbZzFyHysHQxtULqVw9MiqUX8PQT5YzKL7R8AjHlHL79uwXnq5+xv0EWaXQ==
X-Received: by 2002:a63:595a:: with SMTP id j26mr18073pgm.37.1604020663485;
        Thu, 29 Oct 2020 18:17:43 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z26sm4477854pfq.131.2020.10.29.18.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 18:17:42 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH v2 2/4] drm/bridge: ti-sn65dsi86: Make polling a busy loop
Date:   Thu, 29 Oct 2020 18:17:36 -0700
Message-Id: <20201030011738.2028313-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201030011738.2028313-1-swboyd@chromium.org>
References: <20201030011738.2028313-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason we need to wait here to poll a register over i2c. The
i2c bus is inherently slow and delays are practically part of the
protocol because we have to wait for the device to respond to any
request for a register. Let's rely on the sleeping of the i2c controller
instead of adding any sort of delay here in the bridge driver.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index a1ebfa95088c..c77f46a21aae 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -881,9 +881,9 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 
 	regmap_write(pdata->regmap, SN_AUX_CMD_REG, request_val | AUX_CMD_SEND);
 
+	/* Zero delay loop because i2c transactions are slow already */
 	ret = regmap_read_poll_timeout(pdata->regmap, SN_AUX_CMD_REG, val,
-				       !(val & AUX_CMD_SEND), 200,
-				       50 * 1000);
+				       !(val & AUX_CMD_SEND), 0, 50 * 1000);
 	if (ret)
 		return ret;
 
-- 
Sent by a computer, using git, on the internet

