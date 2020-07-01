Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3904210969
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 12:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbgGAKcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 06:32:10 -0400
Received: from vps.xff.cz ([195.181.215.36]:42456 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730004AbgGAKbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593599494; bh=3QXBBwf2NX/RkQpQ64nV5k6ulAezZ6ucTw8Gf1SveRQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=LKl1+NVC7OIRwW9kuhH1lYlhx/QATsVz6EqGOZ63DG8aeRkXN0rTIhc9f6UOPJitL
         LVlzEHNsG0HM6IQzDPjrY4TaTuXolUuCrVOQiXCcfz0LpUTXwPe6W5T0YSyIcX7tJm
         peIrF4ciQlz7dO1gjRFVXkIcP1QX6IkkPKaseu+M=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     Ondrej Jirman <megous@megous.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: [PATCH v6 11/13] drm/panel: st7703: Assert reset prior to powering down the regulators
Date:   Wed,  1 Jul 2020 12:31:24 +0200
Message-Id: <20200701103126.1512615-12-megous@megous.com>
In-Reply-To: <20200701103126.1512615-1-megous@megous.com>
References: <20200701103126.1512615-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset pin is inverted, so if we don't assert reset, the actual gpio
will be high and may keep driving the IO port of the panel.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 0c4167994d01..e303b7b1a215 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -417,6 +417,7 @@ static int st7703_unprepare(struct drm_panel *panel)
 	if (!ctx->prepared)
 		return 0;
 
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 	regulator_disable(ctx->iovcc);
 	regulator_disable(ctx->vcc);
 	ctx->prepared = false;
-- 
2.27.0

