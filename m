Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FEF1C801A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 04:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgEGCn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 22:43:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55102 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726625AbgEGCn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 22:43:28 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0D9524A2EEAD7A4C5AE1;
        Thu,  7 May 2020 10:43:26 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 10:43:19 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <linux@armlinux.org.uk>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Samuel Zou" <zou_wei@huawei.com>
Subject: [PATCH -next] drm/i2c/tda998x: Make tda998x_audio_digital_mute static
Date:   Thu, 7 May 2020 10:49:28 +0800
Message-ID: <1588819768-11818-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

drivers/gpu/drm/i2c/tda998x_drv.c:1136:5: warning:
symbol 'tda998x_audio_digital_mute' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 3c90d7a..9517f52 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1133,7 +1133,8 @@ static void tda998x_audio_shutdown(struct device *dev, void *data)
 	mutex_unlock(&priv->audio_mutex);
 }
 
-int tda998x_audio_digital_mute(struct device *dev, void *data, bool enable)
+static int tda998x_audio_digital_mute(struct device *dev, void *data,
+				      bool enable)
 {
 	struct tda998x_priv *priv = dev_get_drvdata(dev);
 
-- 
2.6.2

