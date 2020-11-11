Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2372AEE0F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgKKJsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:48:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7514 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKKJsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:48:00 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CWKfF034Rzhjgg;
        Wed, 11 Nov 2020 17:47:49 +0800 (CST)
Received: from huawei.com (10.175.113.25) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 11 Nov 2020
 17:47:47 +0800
From:   Zheng Zengkai <zhengzengkai@huawei.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <khilman@baylibre.com>, <narmstrong@baylibre.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <zhengzengkai@huawei.com>
Subject: [PATCH] usb: dwc3: meson-g12a: disable clk on error handling path in probe
Date:   Wed, 11 Nov 2020 17:52:56 +0800
Message-ID: <20201111095256.10477-1-zhengzengkai@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dwc3_meson_g12a_probe() does not invoke clk_bulk_disable_unprepare()
on one error handling path. This patch fixes that.

Fixes: 347052e3bf1b ("usb: dwc3: meson-g12a: fix USB2 PHY initialization on G12A and A1 SoCs")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 417e05381b5d..bdf1f98dfad8 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -754,7 +754,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 
 	ret = priv->drvdata->setup_regmaps(priv, base);
 	if (ret)
-		return ret;
+		goto err_disable_clks;
 
 	if (priv->vbus) {
 		ret = regulator_enable(priv->vbus);
-- 
2.20.1

