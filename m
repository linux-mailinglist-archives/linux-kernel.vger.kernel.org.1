Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D012CE503
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389425AbgLDBYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:24:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8633 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbgLDBX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:23:58 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnFLq46ktz15WbQ;
        Fri,  4 Dec 2020 09:22:43 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 09:23:06 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/tilcdc: Remove unnecessary THIS_MODULE
Date:   Fri, 4 Dec 2020 09:23:13 +0800
Message-ID: <1607044999-47666-8-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607044999-47666-1-git-send-email-tiantao6@hisilicon.com>
References: <1607044999-47666-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As THIS_MODULE has been set in platform_driver_register(),
so remove it.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_panel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
index 00efc30..4235780 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -399,7 +399,6 @@ static struct platform_driver panel_driver = {
 	.probe = panel_probe,
 	.remove = panel_remove,
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "tilcdc-panel",
 		.of_match_table = panel_of_match,
 	},
-- 
2.7.4

