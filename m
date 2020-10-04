Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6AF282D7D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 22:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgJDUHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 16:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgJDUHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 16:07:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D70C0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 13:06:59 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r24so5513981ljm.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 13:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/4EV+wL5qpugIXXyGUN4h13qKX7qr6NSXuZ62a9ozE=;
        b=HcYgzMDixECWWf1gc5PlDnKU1KJoFMxq/eo6bK+klFdcL+U263X7gvj4WJo183ok4U
         Kew4BHE59a705/4A3H17PNfNMYg7H3mL0cHdVcHhVGjqEzlv90kZzHAw2/GfplGHPeJm
         Fs062jm68SPF3RbfHgQWX8MzKZYishNHC18e5oafQnbzDjP4tBFgARxj4yqbCGLTgKQs
         fi2DfOjHaudv/4bgjh5uiu5d3uMRshZRIl2jODyuV0Y35Ldh19wSW/DCSVI70dJkdK4Z
         GpP7nQVM2Ijvbh7K48e1XX2/5VwNnLJy1Ixd3A/6aveQyZAPZqgIbqh4d0mQnBSULgao
         6UOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/4EV+wL5qpugIXXyGUN4h13qKX7qr6NSXuZ62a9ozE=;
        b=pS9xLSI7Za+Pi4SgbReomulQfc5rS4BpCnkgLgnpVlBQ3q+t8wDJho73q3uE3eAnqs
         UdjFeVrrmt0Ayz89diOIdXfR7KDck2PZEHeKbgMTk9EH5KmQO1ZS1WIDtgR2RK13THHz
         WWwHfn6gWivl5Vb8qhB0WpwGXJjGJ/sLzuOsTgkRfBFJdt9MgbtB77pwq0TM8Z0aHb8P
         6AZIDbDgOgrf2NNma+9gtwuaw533dWl3S7cLcoV/P2L+GNQeO8kDrQxXlAcmplYgyZF2
         uFzwCmgPIt/xTc02/rNl8W5TysbNAp1Xd6sIQIWrXegTdD0huohpdRojS3q7QlWZzB1g
         Xnqg==
X-Gm-Message-State: AOAM532FZKpkO6D4lTWSrp3yYacetktcPk77AX9sHgnX5CsNzPkvczFB
        WiexJgVGktBHHdbPLwVmV6E=
X-Google-Smtp-Source: ABdhPJxlGGgPUBFrwh32PMLAPfMm1HSKe33/idBcUmIoq6/OvdbFL4kc05rFI8QDh8WUpG+jBUYJQQ==
X-Received: by 2002:a05:651c:549:: with SMTP id q9mr3102270ljp.399.1601842018350;
        Sun, 04 Oct 2020 13:06:58 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-221-232.NA.cust.bahnhof.se. [155.4.221.232])
        by smtp.gmail.com with ESMTPSA id x5sm2932781lff.280.2020.10.04.13.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 13:06:57 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] drm: bridge: dw-hdmi: Constify dw_hdmi_i2s_ops
Date:   Sun,  4 Oct 2020 22:06:53 +0200
Message-Id: <20201004200653.14702-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of dw_hdmi_i2s_ops is to assign its address to the ops
field in the hdmi_codec_pdata struct, which is a const pointer. Make it
const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index 9fef6413741d..feb04f127b55 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -170,7 +170,7 @@ static int dw_hdmi_i2s_hook_plugged_cb(struct device *dev, void *data,
 	return dw_hdmi_set_plugged_cb(hdmi, fn, codec_dev);
 }
 
-static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
+static const struct hdmi_codec_ops dw_hdmi_i2s_ops = {
 	.hw_params	= dw_hdmi_i2s_hw_params,
 	.audio_startup  = dw_hdmi_i2s_audio_startup,
 	.audio_shutdown	= dw_hdmi_i2s_audio_shutdown,
-- 
2.28.0

