Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649CE2912BE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 17:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438592AbgJQPjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 11:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438581AbgJQPjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 11:39:04 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895D0C0613D3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 08:39:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b8so6791732wrn.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O8b3a8tEsPdmZGsHhmbkp77mMXjgy1OCPeTQ0OgsXhc=;
        b=eetgpeWy2duISOUDuLyFZjrkyYQTTQ4O/2P+CjAqB5m11MBRtpoRaAYVv15D9JlmyM
         a1Icr54M4EieBbiqaq0OIvB4Xk0nZC0ipg9IUPpxTKe+6mEY2xYS0zPWVSUYAEsjt6pf
         1ArkVnfn0TV4zhdy1QuKC2MHufrU83Gk/bqq+qQUs/eI5ZLQ5uTvP9GGBXuYy9nOahfu
         2ILaJWM6Z5l+lFIPMj4xpu46GomC3haPVwC72czZxJ4JvqcKXKYh47f/YHlcCLskXtCr
         AWbmMf5xk4jQweA7ccmj9VhgdxDJxcK1p/v0wdzZFwNLuCr321dvztWFBxc+5etmC4ti
         BYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8b3a8tEsPdmZGsHhmbkp77mMXjgy1OCPeTQ0OgsXhc=;
        b=IFpRpsboW84ZP7kYVcD+nFGuksjUhKuImxSbj1ob0E13zh2BK3jTNjd4UNYalPY+IU
         OVe5JkURxuFiTrZIT3feTt5lRIVHHL0mJJdsT4G6ca0fnDHCnFUDtup9j+vPNoNPzdxi
         uSFesxm5wNNlX0dsyOBhBR7IprunF9RiXjp00tBYP9YL3i2uEjwL6EI28vBPIRReaMrR
         27QYdP3U7/AAoeXowJQkKPeVnKcJ1ehqaqw3kIeN/0oM1vreOMq8xPYeS3DA9LAy15ch
         mLtoAqOjvK3IKlsrCtXKPzcUwKWtDPnmbJF8XlVHP2OBALmzIDVHFdZK/ApBsc7UiyVQ
         yMzw==
X-Gm-Message-State: AOAM532Udk96aGPuUI7Di+Vj8k3Uc0szUrwIU99iDY8EkfgpEGe/Xhd9
        5ex6B5DyqvLAb04KDLLHsInVeg==
X-Google-Smtp-Source: ABdhPJzFnhShrjHXlRQr6YUYUiE55WTFRHSvzdlJc5N5ji8mSvo00iysRozA20esxUivjnKunTuapw==
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr10942738wrx.246.1602949143310;
        Sat, 17 Oct 2020 08:39:03 -0700 (PDT)
Received: from localhost.localdomain (159.171.185.81.rev.sfr.net. [81.185.171.159])
        by smtp.gmail.com with ESMTPSA id n66sm7654953wmb.35.2020.10.17.08.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 08:39:02 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, tglx@linutronix.de,
        daniel.lezcano@linaro.org, Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/2] clocksource: mediatek: add clk13m and bus clock support
Date:   Sat, 17 Oct 2020 17:38:57 +0200
Message-Id: <20201017153857.2494845-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017153857.2494845-1-fparent@baylibre.com>
References: <20201017153857.2494845-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some MediaTek SoC like MT8516 need to enable additional clocks
for the GPT timer. Enable them if present.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/clocksource/timer-mediatek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index 9318edcd8963..42e2d2090484 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
 #include <linux/interrupt.h>
@@ -278,8 +279,19 @@ static int __init mtk_syst_init(struct device_node *node)
 
 static int __init mtk_gpt_init(struct device_node *node)
 {
+	struct clk *clk_13m, *clk_bus;
 	int ret;
 
+	/* Optional clock*/
+	clk_13m = of_clk_get_by_name(node, "clk13m");
+	if (!IS_ERR(clk_13m))
+		clk_prepare_enable(clk_13m);
+
+	/* Optional clock*/
+	clk_bus = of_clk_get_by_name(node, "bus");
+	if (!IS_ERR(clk_bus))
+		clk_prepare_enable(clk_bus);
+
 	to.clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	to.clkevt.set_state_shutdown = mtk_gpt_clkevt_shutdown;
 	to.clkevt.set_state_periodic = mtk_gpt_clkevt_set_periodic;
-- 
2.28.0

