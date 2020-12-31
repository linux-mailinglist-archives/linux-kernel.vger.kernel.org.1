Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76802E8050
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 15:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgLaOXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 09:23:07 -0500
Received: from comms.puri.sm ([159.203.221.185]:59562 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgLaOXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 09:23:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 31710E117D;
        Thu, 31 Dec 2020 06:22:26 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Uz3fBmt1EJap; Thu, 31 Dec 2020 06:22:25 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] Revert "clk: imx: fix composite peripheral flags"
Date:   Thu, 31 Dec 2020 15:21:49 +0100
Message-Id: <20201231142149.26062-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 936c383673b9e3007432f17140ac62de53d87db9.

It breaks clock reparenting via devfreq on the imx8mq used in the
Librem 5 phone. When switching dram frequency (which worked before)
the system now hangs after this where the dram_apb clock cannot be
set:

[  129.391755] imx8m-ddrc-devfreq 3d400000.memory-controller: failed to
set dram_apb parent: -16
[  129.391959] imx8m-ddrc-devfreq 3d400000.memory-controller: ddrc
failed freq switch to 25000000 from 800000000: error -16. now at 25000000
[  129.406133] imx8m-ddrc-devfreq 3d400000.memory-controller: failed to
update frequency from PM QoS (-16)

Note that on the Librem 5 devkit that uses a different revision of the
imx8mq SoC, the added flag does *not* break said clock reparenting so
there might be subtle differences here.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/clk/imx/clk-composite-8m.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 2c309e3dc8e3..78fb7e52a42a 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -216,7 +216,6 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 		div->width = PCG_PREDIV_WIDTH;
 		divider_ops = &imx8m_clk_composite_divider_ops;
 		mux_ops = &clk_mux_ops;
-		flags |= CLK_SET_PARENT_GATE;
 	}
 
 	div->lock = &imx_ccm_lock;
-- 
2.20.1

