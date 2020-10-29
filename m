Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B79229E03A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404281AbgJ2BMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729861AbgJ2BL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 21:11:59 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2873CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 18:11:59 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c20so938401pfr.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 18:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=43Z65rMPFX7c5zSWXhXV75KBPOJpzYr19A/FVKbG0kQ=;
        b=gaOJwxZk2SVJy0xnoCB5dJaUR2mO3wYx5WgvqbszDB+92yPQcR+9mAXUCZ37z0UeLK
         qn+adoLcNXZKQXVDF6Q2qBOgMMVrEIcfvQO2IFKoAr3uHfs5WbIakf8WIKWYfs5yXDFe
         a2FALBeE2ogDfGw4nVwVwqvUEVweX9YoNCC2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=43Z65rMPFX7c5zSWXhXV75KBPOJpzYr19A/FVKbG0kQ=;
        b=Rl8v4t2F1AWPRVLwsdi/T6VcXeS0vEO0I2+pHPdaXaCFZxAsWGwV6it+/SE/bkvMQK
         jrtrLHbuuV7L8oLhCuj6LVFzJJ+v5IP0B+vc2kfqkyHqqw1JYlZpc214VkKahqm6g05C
         6n/R6aKdHZmwoTHUz1Kzsq7UEpL5MyPQJ50s26UPiD5arVccjl0p0+PcV9JpptFWqAL6
         vGLtRgXN3dRxFUk02s39xbRoYtC1DJOXMy9nMvhAi/tR6QjlhO0gzTifCQW3E+DoMdOP
         Yj6KCbEogTlGSZUJpihP9kiYm9CogfUEvPxokGnDoRUIN66muR+YQgtIhMQvN3/2+7Tw
         cf/w==
X-Gm-Message-State: AOAM531st4O3fy2OeRO0YL5QMgsW9XYuQ3nGYQ+jFXI4hD9fnBf5BEky
        H/Vr2EVwC6YsDBc28L+1D35fxg==
X-Google-Smtp-Source: ABdhPJwytjkLPYk5jIPzS5cqIs63+UiSyMI+LTRDpm9VkQgZeuEE+mrdjewTHVF7UHozLGy7FvTPrw==
X-Received: by 2002:a62:1e43:0:b029:164:9ac2:f54e with SMTP id e64-20020a621e430000b02901649ac2f54emr1562015pfe.61.1603933918770;
        Wed, 28 Oct 2020 18:11:58 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id e6sm781769pfn.190.2020.10.28.18.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 18:11:58 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 2/4] drm/bridge: ti-sn65dsi86: Make polling a busy loop
Date:   Wed, 28 Oct 2020 18:11:52 -0700
Message-Id: <20201029011154.1515687-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201029011154.1515687-1-swboyd@chromium.org>
References: <20201029011154.1515687-1-swboyd@chromium.org>
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

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 87726b9e446f..8276fa50138f 100644
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

