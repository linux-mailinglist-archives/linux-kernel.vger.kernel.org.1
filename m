Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E81626C71A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgIPSSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:18:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgIPSPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:15:30 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2356722838;
        Wed, 16 Sep 2020 16:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600273075;
        bh=EHjGZUuZJT8P4Fu0wZHtU4bWPefvl/SobBpWptZnDPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LD3VU4pDXDvILOHtDKFxURYvXgyTB8ACfXbibwSPYo+xFQOia2LymDneAbApJiQI+
         cxMskXpjhQluQQ38YUTirUoMLw+iYwfvr6P2NtTXqT+FcFsXJrGB1IXP4lwyxHTKqy
         spD0X0DFb9IkH1cUnIo4Nk8zrl19XU+gqpBDxf0A=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Heiko Stuebner <heiko@sntech.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/6] clk: davinci: add missing kerneldoc
Date:   Wed, 16 Sep 2020 18:17:37 +0200
Message-Id: <20200916161740.14173-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916161740.14173-1-krzk@kernel.org>
References: <20200916161740.14173-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing kerneldoc to fix compile warning:

  drivers/clk/davinci/da8xx-cfgchip.c:578: warning: Function parameter or member 'dev' not described in 'da8xx_cfgchip_register_usb1_clk48'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: David Lechner <david@lechnology.com>
---
 drivers/clk/davinci/da8xx-cfgchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
index bdc52364b421..77d18276bfe8 100644
--- a/drivers/clk/davinci/da8xx-cfgchip.c
+++ b/drivers/clk/davinci/da8xx-cfgchip.c
@@ -571,6 +571,7 @@ static const struct clk_ops da8xx_usb1_clk48_ops = {
 
 /**
  * da8xx_cfgchip_register_usb1_clk48 - Register a new USB 1.1 PHY clock
+ * @dev: The device
  * @regmap: The CFGCHIP regmap
  */
 static struct da8xx_usb1_clk48 *
-- 
2.17.1

