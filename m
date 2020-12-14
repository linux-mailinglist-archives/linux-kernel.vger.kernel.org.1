Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10D82D98F5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439604AbgLNNf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:35:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9199 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439483AbgLNNfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:35:22 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cvj5q3NPqzkrpC;
        Mon, 14 Dec 2020 21:33:51 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:34:28 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <lee.jones@linaro.org>, <daniel.thompson@linaro.org>,
        <jingoohan1@gmail.com>, <b.zolnierkie@samsung.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] backlight: sky81452-backlight: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:34:58 +0800
Message-ID: <20201214133458.3729-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/video/backlight/sky81452-backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
index 8268ac43d54f..c95e0de7f4e7 100644
--- a/drivers/video/backlight/sky81452-backlight.c
+++ b/drivers/video/backlight/sky81452-backlight.c
@@ -291,7 +291,7 @@ static int sky81452_bl_probe(struct platform_device *pdev)
 	}
 
 	memset(&props, 0, sizeof(props));
-	props.max_brightness = SKY81452_MAX_BRIGHTNESS,
+	props.max_brightness = SKY81452_MAX_BRIGHTNESS;
 	name = pdata->name ? pdata->name : SKY81452_DEFAULT_NAME;
 	bd = devm_backlight_device_register(dev, name, dev, regmap,
 						&sky81452_bl_ops, &props);
-- 
2.22.0

