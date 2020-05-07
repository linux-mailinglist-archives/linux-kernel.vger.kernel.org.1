Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6A71C816D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 07:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgEGFRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 01:17:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3879 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgEGFRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 01:17:14 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 458A2AA6B645CBEB0247;
        Thu,  7 May 2020 13:17:11 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 13:17:02 +0800
From:   ChenTao <chentao107@huawei.com>
To:     <dmitry.torokhov@gmail.com>
CC:     <kstewart@linuxfoundation.org>, <tglx@linutronix.de>,
        <gregkh@linuxfoundation.org>, <allison@lohutok.net>,
        <linux-kernel@vger.kernel.org>, <chentao107@huawei.com>
Subject: [PATCH] input/misc/drv260x: Remove a useless comparison
Date:   Thu, 7 May 2020 13:16:17 +0800
Message-ID: <20200507051617.212434-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:

'mode' and 'library' are u32, they are never be negative,
DRV260X_LRA_MODE and DRV260X_LIB_EMPTY are 0x00, the comparison
is always false.

drivers/input/misc/drv260x.c:478:20: warning:
comparison of unsigned expression < 0 is always false [-Wtype-limits]
  if (haptics->mode < DRV260X_LRA_MODE ||
drivers/input/misc/drv260x.c:490:23: warning:
comparison of unsigned expression < 0 is always false [-Wtype-limits]
  if (haptics->library < DRV260X_LIB_EMPTY ||

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenTao <chentao107@huawei.com>
---
 drivers/input/misc/drv260x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 79d7fa710a71..0078f742df5c 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -475,8 +475,7 @@ static int drv260x_probe(struct i2c_client *client,
 		return error;
 	}
 
-	if (haptics->mode < DRV260X_LRA_MODE ||
-	    haptics->mode > DRV260X_ERM_MODE) {
+	if (haptics->mode > DRV260X_ERM_MODE) {
 		dev_err(dev, "Vibrator mode is invalid: %i\n", haptics->mode);
 		return -EINVAL;
 	}
@@ -487,8 +486,7 @@ static int drv260x_probe(struct i2c_client *client,
 		return error;
 	}
 
-	if (haptics->library < DRV260X_LIB_EMPTY ||
-	    haptics->library > DRV260X_ERM_LIB_F) {
+	if (haptics->library > DRV260X_ERM_LIB_F) {
 		dev_err(dev,
 			"Library value is invalid: %i\n", haptics->library);
 		return -EINVAL;
-- 
2.22.0

