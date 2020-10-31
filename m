Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203772A134E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 04:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgJaDRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 23:17:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6712 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaDRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 23:17:06 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CNPVR0069zkcf9;
        Sat, 31 Oct 2020 11:17:02 +0800 (CST)
Received: from localhost (10.174.176.180) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Sat, 31 Oct 2020
 11:16:55 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tomi.valkeinen@ti.com>, <yuehaibing@huawei.com>,
        <sebastian.reichel@collabora.com>, <sam@ravnborg.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/bridge: tpd12s015: Fix irq registering in tpd12s015_probe
Date:   Sat, 31 Oct 2020 11:16:48 +0800
Message-ID: <20201031031648.42368-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.176.180]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpiod_to_irq() return negative value in case of error,
the existing code handle negative error codes wrongly.

Fixes: cff5e6f7e83f ("drm/bridge: Add driver for the TI TPD12S015 HDMI level shifter")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/bridge/ti-tpd12s015.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-tpd12s015.c b/drivers/gpu/drm/bridge/ti-tpd12s015.c
index 514cbf0eac75..a18d5197c16c 100644
--- a/drivers/gpu/drm/bridge/ti-tpd12s015.c
+++ b/drivers/gpu/drm/bridge/ti-tpd12s015.c
@@ -160,7 +160,7 @@ static int tpd12s015_probe(struct platform_device *pdev)
 
 	/* Register the IRQ if the HPD GPIO is IRQ-capable. */
 	tpd->hpd_irq = gpiod_to_irq(tpd->hpd_gpio);
-	if (tpd->hpd_irq) {
+	if (tpd->hpd_irq > 0) {
 		ret = devm_request_threaded_irq(&pdev->dev, tpd->hpd_irq, NULL,
 						tpd12s015_hpd_isr,
 						IRQF_TRIGGER_RISING |
-- 
2.17.1

