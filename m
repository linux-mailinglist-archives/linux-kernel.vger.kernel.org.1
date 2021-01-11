Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B772F195A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbhAKPQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729275AbhAKPQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:16:47 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C529EC061786;
        Mon, 11 Jan 2021 07:16:06 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r5so34364eda.12;
        Mon, 11 Jan 2021 07:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tWKprXggvOuTBCM4ux6Fy6I4JWY3k6KRYP7cItmISrw=;
        b=nPNH3n7FKLUaawD3t1ZaV7MF/1GDeKXfru7Y4wFAG2BExLhOk0eX46Mb2ipJkY1j2U
         gXLSuHy3rjxPUwREAmBX8qPzuBSjFpu7HGPyabIpKJrXGkzuU1eDR55ewu/N/yRtaUvS
         axJupyiFuS5dFZu9LRLDnumnclaPrmWGGuGMpRtW5cChFgV4tvd792EZMS0LaeS2xDiW
         Rj99qP7nkj/P2E8IRjToFwdNbjDw6i7oAHTc1EbR+HV9YSGRqpbTugKP6zpuoqvNxWYo
         UEbxm5IJhd4BjrLZRinbdWwxmxBfsDzOeGnL0hIMhM0ox5mGC5hzI5TLrkFVip48MhRf
         kHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tWKprXggvOuTBCM4ux6Fy6I4JWY3k6KRYP7cItmISrw=;
        b=oAdpUSrsxgxFqMUReXB3yNuGhwJ73FEhAU9Ol7i9/CfhMWd3dgRg7yEzu/OxsH1pPt
         fTBMd8cfTICCAM8DQO76tLQ2516D+42JY4SHfCUJCw8XKARfY8NLU3P3fY4+TLKpH9BD
         dNKEVOjasiWQI91MeiHai9boudhxVXwrPUORDxDOwyTk7oW1zjdaxVDHvnqCa9NnFq27
         O2XAdSesySwCVXv8gquAjzKdVS9RoetuBqC4ZamzCqMvIW/LPeJ8vklJ0bWoSNqNEXgt
         VrrxMKE1fNauYquixAggw3ufNbOx2Vq8ggES7p036Ee6xBQxOMte2X/jFy9NNEbdRZO8
         DzHA==
X-Gm-Message-State: AOAM532fKFVo5rYlaWJtUAPV7FrOYS3zNDRDJphOsdQEmTCjGiDAzZPC
        +O/AL5Qu/XKvetp32ICehIsKL/i2m/mwgrnW
X-Google-Smtp-Source: ABdhPJzRbDlLMCtaSfmcNX//58RW+X6+3SRKczh2vcxrOvdxiWtNnLsedmlXGpgju7ULpQA8Ww78vw==
X-Received: by 2002:aa7:c891:: with SMTP id p17mr14532386eds.309.1610378165283;
        Mon, 11 Jan 2021 07:16:05 -0800 (PST)
Received: from xps13.lan (3e6b100e.rev.stofanet.dk. [62.107.16.14])
        by smtp.gmail.com with ESMTPSA id j7sm7223269ejj.27.2021.01.11.07.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 07:16:04 -0800 (PST)
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bruno Thomsen <bruno.thomsen@gmail.com>,
        Bruno Thomsen <bth@kamstrup.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] ARM: dts: imx7d-flex-concentrator: fix pcf2127 reset
Date:   Mon, 11 Jan 2021 16:15:37 +0100
Message-Id: <20210111151537.12530-1-bruno.thomsen@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTC pcf2127 device driver has changed default behaviour of the watchdog
feature in v5.11-rc1. Now you need to explicitly enable it with a
device tree property, "reset-source", when used in the board design.

Fixes: 71ac13457d9d ("rtc: pcf2127: only use watchdog when explicitly available")

Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
Cc: Bruno Thomsen <bth@kamstrup.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/imx7d-flex-concentrator.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx7d-flex-concentrator.dts b/arch/arm/boot/dts/imx7d-flex-concentrator.dts
index 84b095279e65..bd6b5285aa8d 100644
--- a/arch/arm/boot/dts/imx7d-flex-concentrator.dts
+++ b/arch/arm/boot/dts/imx7d-flex-concentrator.dts
@@ -115,6 +115,7 @@ pcf2127: rtc@0 {
 		compatible = "nxp,pcf2127";
 		reg = <0>;
 		spi-max-frequency = <2000000>;
+		reset-source;
 	};
 };
 

base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
-- 
2.29.2

