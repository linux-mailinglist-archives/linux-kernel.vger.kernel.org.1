Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322BE2E1CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 15:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgLWOLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 09:11:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9637 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbgLWOLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 09:11:00 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D1FSj52hsz15hr7;
        Wed, 23 Dec 2020 22:09:25 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Wed, 23 Dec 2020 22:09:58 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <lee.jones@linaro.org>, <daniel.thompson@linaro.org>,
        <jingoohan1@gmail.com>, <b.zolnierkie@samsung.com>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] video: backlight: use DEFINE_MUTEX (and mutex_init() had been too late)
Date:   Wed, 23 Dec 2020 22:10:35 +0800
Message-ID: <20201223141035.32178-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/video/backlight/backlight.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 537fe1b376ad..d7a09c422547 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -64,7 +64,7 @@
  */
 
 static struct list_head backlight_dev_list;
-static struct mutex backlight_dev_list_mutex;
+static DEFINE_MUTEX(backlight_dev_list_mutex);
 static struct blocking_notifier_head backlight_notifier;
 
 static const char *const backlight_types[] = {
@@ -757,7 +757,6 @@ static int __init backlight_class_init(void)
 	backlight_class->dev_groups = bl_device_groups;
 	backlight_class->pm = &backlight_class_dev_pm_ops;
 	INIT_LIST_HEAD(&backlight_dev_list);
-	mutex_init(&backlight_dev_list_mutex);
 	BLOCKING_INIT_NOTIFIER_HEAD(&backlight_notifier);
 
 	return 0;
-- 
2.22.0

