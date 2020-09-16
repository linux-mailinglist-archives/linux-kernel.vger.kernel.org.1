Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0343E26CBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgIPUgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgIPRKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:10:30 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9595F227C3;
        Wed, 16 Sep 2020 16:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600273071;
        bh=LN9CdnpYig01xRkC8IS2l0nFAprnIaPmxff2deSsbdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=arZO1DSzyRhOIJzlgIdKnCqEdPq/+2oXH63V3zCRjt2uefr7rK8wu2FICE1m/evd4
         PlqSMpOP/sMmTTnpdckGd2RTU2CZs6H8hQ2e0xrGUnH+VxSn5fabupSMTnPVjpODK1
         n6acg/19rRfvPoRNDQbAwgcoHWP6hRI2xjgG86tg=
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
Subject: [PATCH 2/6] clk: fixed: add missing kerneldoc
Date:   Wed, 16 Sep 2020 18:17:36 +0200
Message-Id: <20200916161740.14173-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916161740.14173-1-krzk@kernel.org>
References: <20200916161740.14173-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing kerneldoc to fix compile warnings like:

  drivers/clk/clk-fixed-factor.c:211: warning: Function parameter or member 'node' not described in 'of_fixed_factor_clk_setup'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/clk-fixed-factor.c | 1 +
 drivers/clk/clk-fixed-rate.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 8b343e59dc61..910e6e74ae90 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -206,6 +206,7 @@ static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
 
 /**
  * of_fixed_factor_clk_setup() - Setup function for simple fixed factor clock
+ * @node:	device node for the clock
  */
 void __init of_fixed_factor_clk_setup(struct device_node *node)
 {
diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 77499a27c8fb..45501637705c 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -168,6 +168,7 @@ static struct clk_hw *_of_fixed_clk_setup(struct device_node *node)
 
 /**
  * of_fixed_clk_setup() - Setup function for simple fixed rate clock
+ * @node:	device node for the clock
  */
 void __init of_fixed_clk_setup(struct device_node *node)
 {
-- 
2.17.1

