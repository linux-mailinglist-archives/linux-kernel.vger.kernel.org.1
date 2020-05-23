Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29ED31DF6AE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 12:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbgEWKlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 06:41:49 -0400
Received: from v6.sk ([167.172.42.174]:40046 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgEWKls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 06:41:48 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 6DFB2612FF;
        Sat, 23 May 2020 10:41:47 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 3/4] drm/etnaviv: Make the "core" clock mandatory
Date:   Sat, 23 May 2020 12:41:36 +0200
Message-Id: <20200523104137.12562-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523104137.12562-1-lkundrak@v3.sk>
References: <20200523104137.12562-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is always present. It was documented as mandatory prior to
commit 90aeca875f8a ("dt-bindings: display: Convert etnaviv to
json-schema").

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Add this patch
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index f303172c091d..798fdbc8ecdb 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1796,7 +1796,7 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	if (IS_ERR(gpu->clk_bus))
 		return PTR_ERR(gpu->clk_bus);
 
-	gpu->clk_core = devm_clk_get_optional(&pdev->dev, "core");
+	gpu->clk_core = devm_clk_get(&pdev->dev, "core");
 	DBG("clk_core: %p", gpu->clk_core);
 	if (IS_ERR(gpu->clk_core))
 		return PTR_ERR(gpu->clk_core);
-- 
2.26.2

