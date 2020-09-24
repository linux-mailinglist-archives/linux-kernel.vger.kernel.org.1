Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F24A2773C5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgIXOSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:18:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14276 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727974AbgIXOSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:18:36 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 409F99240FE602BAB053;
        Thu, 24 Sep 2020 22:18:31 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 24 Sep 2020
 22:18:27 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <tomi.valkeinen@ti.com>, <b.zolnierkie@samsung.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] video: Remove set but not used variable
Date:   Thu, 24 Sep 2020 22:18:26 +0800
Message-ID: <1600957106-13741-1-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/video/fbdev/sis/300vtbl.h:1064:28: warning:
‘SiS300_CHTVVCLKSONTSC’ defined but not used [-Wunused-const-variable=]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Li Heng <liheng40@huawei.com>
---
 drivers/video/fbdev/sis/300vtbl.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/sis/300vtbl.h b/drivers/video/fbdev/sis/300vtbl.h
index e4b4a26..26b19f7 100644
--- a/drivers/video/fbdev/sis/300vtbl.h
+++ b/drivers/video/fbdev/sis/300vtbl.h
@@ -1061,8 +1061,6 @@ static const unsigned char SiS300_CHTVVCLKUNTSC[]  = { 0x29,0x29,0x29,0x29,0x2a,

 static const unsigned char SiS300_CHTVVCLKONTSC[]  = { 0x2c,0x2c,0x2c,0x2c,0x2d,0x2b };

-static const unsigned char SiS300_CHTVVCLKSONTSC[] = { 0x2c,0x2c,0x2c,0x2c,0x2d,0x2b };
-
 static const unsigned char SiS300_CHTVVCLKUPAL[]   = { 0x2f,0x2f,0x2f,0x2f,0x2f,0x31 };

 static const unsigned char SiS300_CHTVVCLKOPAL[]   = { 0x2f,0x2f,0x2f,0x2f,0x30,0x32 };
--
2.7.4

