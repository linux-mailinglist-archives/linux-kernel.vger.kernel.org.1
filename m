Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504222D08B1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 02:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgLGBEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 20:04:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8701 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgLGBEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 20:04:47 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cq4n808PHzkmFw;
        Mon,  7 Dec 2020 09:03:24 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 09:04:00 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/drv: switch to using devm_add_action_or_reset()
Date:   Mon, 7 Dec 2020 09:04:15 +0800
Message-ID: <1607303055-5199-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

switch to using devm_add_action_or_reset() instead of devm_add_action.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/drm_drv.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 7343038..b92f7fd 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -675,11 +675,8 @@ static int devm_drm_dev_init(struct device *parent,
 	if (ret)
 		return ret;
 
-	ret = devm_add_action(parent, devm_drm_dev_init_release, dev);
-	if (ret)
-		devm_drm_dev_init_release(dev);
-
-	return ret;
+	return devm_add_action_or_reset(parent,
+					devm_drm_dev_init_release, dev);
 }
 
 void *__devm_drm_dev_alloc(struct device *parent,
-- 
2.7.4

