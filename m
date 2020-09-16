Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5C526C524
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 18:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIPQ1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 12:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgIPQT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:19:57 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B30122955;
        Wed, 16 Sep 2020 16:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600273093;
        bh=d96KYZZMydcJHEl9ntD8CVmSDdqIiH31PsoEq+mfyUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uad7FDK4a+Ne5IYmZfeU+1YD99kDHHrIlZutKKrYvUTLFZmBTRwlLmBx02L+gdKmT
         MTXHEXjysUHsNp9b6pr/mXmJg4XB4MRZhGPeFw02cwXudkz35qpubMtJJ9zQtzjhi9
         45bZmPAi3H4zojr6wkUQO4eJoHTiNA7QT5KWRctY=
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
Subject: [PATCH 6/6] clk: rockchip: rk3308: drop unused mux_timer_src_p
Date:   Wed, 16 Sep 2020 18:17:40 +0200
Message-Id: <20200916161740.14173-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916161740.14173-1-krzk@kernel.org>
References: <20200916161740.14173-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parent names 'mux_timer_src_p' is not used:

  In file included from drivers/clk/rockchip/clk-rk3308.c:13:0:
  drivers/clk/rockchip/clk-rk3308.c:136:7: warning: ‘mux_timer_src_p’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/rockchip/clk-rk3308.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3308.c b/drivers/clk/rockchip/clk-rk3308.c
index b0baf87a283e..5bf15f2a44b7 100644
--- a/drivers/clk/rockchip/clk-rk3308.c
+++ b/drivers/clk/rockchip/clk-rk3308.c
@@ -133,7 +133,6 @@ PNAME(mux_uart1_p)		= { "clk_uart1_src", "dummy", "clk_uart1_frac" };
 PNAME(mux_uart2_p)		= { "clk_uart2_src", "dummy", "clk_uart2_frac" };
 PNAME(mux_uart3_p)		= { "clk_uart3_src", "dummy", "clk_uart3_frac" };
 PNAME(mux_uart4_p)		= { "clk_uart4_src", "dummy", "clk_uart4_frac" };
-PNAME(mux_timer_src_p)		= { "xin24m", "clk_rtc32k" };
 PNAME(mux_dclk_vop_p)		= { "dclk_vop_src", "dclk_vop_frac", "xin24m" };
 PNAME(mux_nandc_p)		= { "clk_nandc_div", "clk_nandc_div50" };
 PNAME(mux_sdmmc_p)		= { "clk_sdmmc_div", "clk_sdmmc_div50" };
-- 
2.17.1

