Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E021DF6AF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 12:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgEWKlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 06:41:53 -0400
Received: from v6.sk ([167.172.42.174]:40060 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731237AbgEWKlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 06:41:50 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 3B60461300;
        Sat, 23 May 2020 10:41:49 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 4/4] drm/etnaviv: Simplify clock enable/disable
Date:   Sat, 23 May 2020 12:41:37 +0200
Message-Id: <20200523104137.12562-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523104137.12562-1-lkundrak@v3.sk>
References: <20200523104137.12562-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the NULL checks are pointless, clk_*() routines already deal with NULL
just fine.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 53 ++++++++++-----------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 798fdbc8ecdb..fb37787449bb 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1487,55 +1487,40 @@ static int etnaviv_gpu_clk_enable(struct etnaviv_gpu *gpu)
 {
 	int ret;
 
-	if (gpu->clk_reg) {
-		ret = clk_prepare_enable(gpu->clk_reg);
-		if (ret)
-			return ret;
-	}
+	ret = clk_prepare_enable(gpu->clk_reg);
+	if (ret)
+		return ret;
 
-	if (gpu->clk_bus) {
-		ret = clk_prepare_enable(gpu->clk_bus);
-		if (ret)
-			goto disable_clk_reg;
-	}
+	ret = clk_prepare_enable(gpu->clk_bus);
+	if (ret)
+		goto disable_clk_reg;
 
-	if (gpu->clk_core) {
-		ret = clk_prepare_enable(gpu->clk_core);
-		if (ret)
-			goto disable_clk_bus;
-	}
+	ret = clk_prepare_enable(gpu->clk_core);
+	if (ret)
+		goto disable_clk_bus;
 
-	if (gpu->clk_shader) {
-		ret = clk_prepare_enable(gpu->clk_shader);
-		if (ret)
-			goto disable_clk_core;
-	}
+	ret = clk_prepare_enable(gpu->clk_shader);
+	if (ret)
+		goto disable_clk_core;
 
 	return 0;
 
 disable_clk_core:
-	if (gpu->clk_core)
-		clk_disable_unprepare(gpu->clk_core);
+	clk_disable_unprepare(gpu->clk_core);
 disable_clk_bus:
-	if (gpu->clk_bus)
-		clk_disable_unprepare(gpu->clk_bus);
+	clk_disable_unprepare(gpu->clk_bus);
 disable_clk_reg:
-	if (gpu->clk_reg)
-		clk_disable_unprepare(gpu->clk_reg);
+	clk_disable_unprepare(gpu->clk_reg);
 
 	return ret;
 }
 
 static int etnaviv_gpu_clk_disable(struct etnaviv_gpu *gpu)
 {
-	if (gpu->clk_shader)
-		clk_disable_unprepare(gpu->clk_shader);
-	if (gpu->clk_core)
-		clk_disable_unprepare(gpu->clk_core);
-	if (gpu->clk_bus)
-		clk_disable_unprepare(gpu->clk_bus);
-	if (gpu->clk_reg)
-		clk_disable_unprepare(gpu->clk_reg);
+	clk_disable_unprepare(gpu->clk_shader);
+	clk_disable_unprepare(gpu->clk_core);
+	clk_disable_unprepare(gpu->clk_bus);
+	clk_disable_unprepare(gpu->clk_reg);
 
 	return 0;
 }
-- 
2.26.2

