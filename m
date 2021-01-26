Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74C7303BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405426AbhAZLpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:45:23 -0500
Received: from inva020.nxp.com ([92.121.34.13]:35842 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392211AbhAZLWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:22:39 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 73AD11A0CDE;
        Tue, 26 Jan 2021 12:21:52 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 675601A0CD2;
        Tue, 26 Jan 2021 12:21:52 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1BC612034A;
        Tue, 26 Jan 2021 12:21:52 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC] clk: Mark HW enabled clocks as enabled in core
Date:   Tue, 26 Jan 2021 13:21:36 +0200
Message-Id: <1611660096-12381-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clocks are already enabled in HW even before the kernel
starts to boot. So, in order to make sure that these clocks do not
get disabled when clk_disable_unused call is done or when
reparenting clocks, we enable them in core on clock registration.
Such a clock will have to be registered with CLK_IGNORE_UNUSED flag
and also needs to have the is_enabled ops implemented.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/clk.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 3d751ae5bc70..26d55851cfa5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3416,6 +3416,7 @@ static int __clk_core_init(struct clk_core *core)
 	int ret;
 	struct clk_core *parent;
 	unsigned long rate;
+	bool is_hw_enabled = false;
 	int phase;
 
 	if (!core)
@@ -3558,12 +3559,20 @@ static int __clk_core_init(struct clk_core *core)
 		rate = 0;
 	core->rate = core->req_rate = rate;
 
+	/*
+	 * If the clock has the CLK_IGNORE_UNUSED flag set and it is already
+	 * enabled in HW, enable it in core too so it won't get accidentally
+	 * disabled when walking the orphan tree and reparenting clocks
+	 */
+	if (core->flags & CLK_IGNORE_UNUSED && core->ops->is_enabled)
+		is_hw_enabled = clk_core_is_enabled(core);
+
 	/*
 	 * Enable CLK_IS_CRITICAL clocks so newly added critical clocks
 	 * don't get accidentally disabled when walking the orphan tree and
 	 * reparenting clocks
 	 */
-	if (core->flags & CLK_IS_CRITICAL) {
+	if (core->flags & CLK_IS_CRITICAL || is_hw_enabled) {
 		unsigned long flags;
 
 		ret = clk_core_prepare(core);
-- 
2.29.2

