Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A491FC0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 23:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgFPVWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 17:22:10 -0400
Received: from v6.sk ([167.172.42.174]:48346 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFPVWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:22:09 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 5C4C76163A;
        Tue, 16 Jun 2020 21:21:38 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King <linux+etnaviv@arlinux.org.uk>,
        Christian Geiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [RESEND PATCH v2 3/4] drm/etnaviv: Make the "core" clock mandatory
Date:   Tue, 16 Jun 2020 23:21:26 +0200
Message-Id: <20200616212127.986410-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616212127.986410-1-lkundrak@v3.sk>
References: <20200616212127.986410-1-lkundrak@v3.sk>
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

 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index f303172c091db..798fdbc8ecdb5 100644
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

