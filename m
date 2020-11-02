Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1B42A3295
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 19:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgKBSLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 13:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgKBSLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:11:50 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56F5C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 10:11:49 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id f21so7216519plr.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 10:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mucw0+S0CdtYt2MrRKtHgnlnbG3RdZ1CSuq3C9GPsWI=;
        b=JBUs/ATc6uaPEMghQ/X3xL58YiXfHxnNb2KJQlhhG6ZMIoCG6puCx17Mix5ZaIIktH
         O8MBOpsa+Hpbr+NJ90V/vYmzGqZcR3Q0grcapVGHvrG3pnQkz1VzWmLwRQbvoTUPMwS3
         IKqh/NbK43OMImI8cujYwv8KvNtR3igfTvoLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mucw0+S0CdtYt2MrRKtHgnlnbG3RdZ1CSuq3C9GPsWI=;
        b=knBtU5BoyCPhkFeY60/FyN3tT5jT0OGcreyetK0VWDaNHA9kI72IayU1qkI0tHbQ+F
         OBRdIAaMOYU/s7tTr4Mt9qpemDJZjKrGxH83v58MT8bl+zWBVAjdartgvy6ERiWOl2YT
         qrTsTuB/JvM89oFAnwY8nrXaZU/CItFmETRaa2oy30JbufTsk7GI4T9Gut6/cAfRKVBj
         S+EIErJanTyzT+UfB9f7YBRHnUxBzoPOKXp7Qzzw3O3kPjyCJLTpaiLbEqzA0qEXsn/t
         EvMrI+XDLxpfHCAGAJo4hvdb+ds0XML4omepO4JDHn+ddGNRTuUMwdTJE0s9vCPse1wn
         2//w==
X-Gm-Message-State: AOAM532oXi0/bC+b+olPtV0qMA29Tz2R9OX/wCwtU62J56CfzHMxI/LD
        ee+dkwLiIWCxNSh00TcnLKNj+VzWzpnscw==
X-Google-Smtp-Source: ABdhPJyHYVx0D/MimpLNF9meNsmXNCFBi0+HKgmBxtQQHUNbkMk9oc+WHbulYskfoB1/sI0kTUilQg==
X-Received: by 2002:a17:902:b689:b029:d5:e78f:65d1 with SMTP id c9-20020a170902b689b02900d5e78f65d1mr21923958pls.6.1604340709451;
        Mon, 02 Nov 2020 10:11:49 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id b17sm13175640pgb.94.2020.11.02.10.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:11:48 -0800 (PST)
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
Subject: [PATCH v3 2/4] drm/bridge: ti-sn65dsi86: Make polling a busy loop
Date:   Mon,  2 Nov 2020 10:11:42 -0800
Message-Id: <20201102181144.3469197-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201102181144.3469197-1-swboyd@chromium.org>
References: <20201102181144.3469197-1-swboyd@chromium.org>
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
Acked-by: Sam Ravnborg <sam@ravnborg.org>
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

